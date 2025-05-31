import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../widgets/common/custom_app_bar.dart';
import '../../../widgets/common/modern_text_field.dart';

class AssetManagementScreen extends StatefulWidget {
  const AssetManagementScreen({super.key});

  @override
  State<AssetManagementScreen> createState() => _AssetManagementScreenState();
}

class _AssetManagementScreenState extends State<AssetManagementScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Asset Management',
        showBackButton: true,
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search bar
                ModernTextField(
                  label: '',
                  hint: 'Search assets...',
                  prefixIcon: Icons.search,
                  controller: _searchController,
                ),
                
                AppSpacing.heightMd,
                
                // Tab bar
                TabBar(
                  controller: _tabController,
                  labelColor: AppColors.primaryNavy,
                  unselectedLabelColor: AppColors.darkGray,
                  indicatorColor: AppColors.primaryMint,
                  indicatorWeight: 3,
                  tabs: const [
                    Tab(text: 'All Assets'),
                    Tab(text: 'Electronics'),
                    Tab(text: 'Furniture'),
                    Tab(text: 'Vehicles'),
                  ],
                ),
              ],
            ),
          ),
          
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAssetList('all'),
                _buildAssetList('electronics'),
                _buildAssetList('furniture'),
                _buildAssetList('vehicles'),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddAssetDialog(context);
        },
        backgroundColor: AppColors.primaryMint,
        child: const Icon(
          Icons.add,
          color: AppColors.primaryNavy,
        ),
      ),
    );
  }

  Widget _buildAssetList(String category) {
    // Sample asset data
    final assets = _getAssetsByCategory(category);
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: assets.length,
      itemBuilder: (context, index) {
        final asset = assets[index];
        return _buildAssetCard(asset);
      },
    );
  }

  Widget _buildAssetCard(Map<String, dynamic> asset) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: AppDecorations.softCard,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: _getCategoryColor(asset['category']).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getCategoryIcon(asset['category']),
                    color: _getCategoryColor(asset['category']),
                    size: 30,
                  ),
                ),
                AppSpacing.widthMd,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        asset['name'],
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'ID: ${asset['id']} • ${asset['category']}',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.darkGray,
                        ),
                      ),
                      AppSpacing.heightXs,
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(asset['status']).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              asset['status'],
                              style: AppTextStyles.caption.copyWith(
                                color: _getStatusColor(asset['status']),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          AppSpacing.widthMd,
                          Text(
                            'Location: ${asset['location']}',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.more_vert,
                    color: AppColors.darkGray,
                  ),
                  onPressed: () {
                    _showAssetOptions(context, asset);
                  },
                ),
              ],
            ),
          ),
          Divider(
            color: AppColors.mediumGray,
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildAssetActionButton(
                  'Details',
                  Icons.info_outline_rounded,
                  AppColors.info,
                  () {
                    _showAssetDetails(context, asset);
                  },
                ),
                _buildAssetActionButton(
                  'Edit',
                  Icons.edit_rounded,
                  AppColors.warning,
                  () {
                    _showEditAssetDialog(context, asset);
                  },
                ),
                _buildAssetActionButton(
                  'Transfer',
                  Icons.swap_horiz_rounded,
                  AppColors.success,
                  () {
                    _showTransferDialog(context, asset);
                  },
                ),
                _buildAssetActionButton(
                  'Maintenance',
                  Icons.build_rounded,
                  AppColors.primaryNavy,
                  () {
                    _showMaintenanceDialog(context, asset);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssetActionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            AppSpacing.heightXs,
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods
  List<Map<String, dynamic>> _getAssetsByCategory(String category) {
    final allAssets = [
      {
        'id': 'AST001',
        'name': 'Dell Laptop XPS 15',
        'category': 'Electronics',
        'status': 'Active',
        'location': 'IT Lab',
        'purchase_date': '2023-01-15',
        'purchase_price': '\$1,200',
        'assigned_to': 'John Smith',
        'condition': 'Good',
        'warranty_expiry': '2026-01-15',
      },
      {
        'id': 'AST002',
        'name': 'HP Printer LaserJet Pro',
        'category': 'Electronics',
        'status': 'Under Maintenance',
        'location': 'Admin Office',
        'purchase_date': '2022-05-20',
        'purchase_price': '\$350',
        'assigned_to': 'Admin Department',
        'condition': 'Fair',
        'warranty_expiry': '2025-05-20',
      },
      {
        'id': 'AST003',
        'name': 'Conference Table',
        'category': 'Furniture',
        'status': 'Active',
        'location': 'Meeting Room 1',
        'purchase_date': '2021-11-10',
        'purchase_price': '\$800',
        'assigned_to': 'Meeting Room 1',
        'condition': 'Excellent',
        'warranty_expiry': '2024-11-10',
      },
      {
        'id': 'AST004',
        'name': 'Executive Chair',
        'category': 'Furniture',
        'status': 'Active',
        'location': 'Principal Office',
        'purchase_date': '2022-02-28',
        'purchase_price': '\$250',
        'assigned_to': 'Principal',
        'condition': 'Good',
        'warranty_expiry': '2025-02-28',
      },
      {
        'id': 'AST005',
        'name': 'School Bus',
        'category': 'Vehicles',
        'status': 'Active',
        'location': 'Parking Lot',
        'purchase_date': '2020-08-15',
        'purchase_price': '\$45,000',
        'assigned_to': 'Transportation Dept',
        'condition': 'Good',
        'warranty_expiry': '2023-08-15',
      },
      {
        'id': 'AST006',
        'name': 'Smart Board',
        'category': 'Electronics',
        'status': 'Inactive',
        'location': 'Storage',
        'purchase_date': '2019-06-10',
        'purchase_price': '\$1,800',
        'assigned_to': 'Unassigned',
        'condition': 'Poor',
        'warranty_expiry': '2022-06-10',
      },
      {
        'id': 'AST007',
        'name': 'Staff Van',
        'category': 'Vehicles',
        'status': 'Under Maintenance',
        'location': 'Service Center',
        'purchase_date': '2021-03-22',
        'purchase_price': '\$28,000',
        'assigned_to': 'Staff Transportation',
        'condition': 'Fair',
        'warranty_expiry': '2024-03-22',
      },
    ];
    
    if (category == 'all') {
      return allAssets;
    } else {
      return allAssets.where((asset) => 
        asset['category'].toString().toLowerCase() == category.toLowerCase()
      ).toList();
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'electronics':
        return Icons.computer_rounded;
      case 'furniture':
        return Icons.chair_rounded;
      case 'vehicles':
        return Icons.directions_bus_rounded;
      default:
        return Icons.inventory_2_rounded;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'electronics':
        return AppColors.info;
      case 'furniture':
        return AppColors.warning;
      case 'vehicles':
        return AppColors.success;
      default:
        return AppColors.primaryNavy;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return AppColors.success;
      case 'inactive':
        return AppColors.error;
      case 'under maintenance':
        return AppColors.warning;
      default:
        return AppColors.darkGray;
    }
  }

  // Dialog methods
  void _showAssetOptions(BuildContext context, Map<String, dynamic> asset) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.info_outline, color: AppColors.info),
                title: const Text('View Details'),
                onTap: () {
                  Navigator.pop(context);
                  _showAssetDetails(context, asset);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit, color: AppColors.warning),
                title: const Text('Edit Asset'),
                onTap: () {
                  Navigator.pop(context);
                  _showEditAssetDialog(context, asset);
                },
              ),
              ListTile(
                leading: const Icon(Icons.swap_horiz, color: AppColors.success),
                title: const Text('Transfer Asset'),
                onTap: () {
                  Navigator.pop(context);
                  _showTransferDialog(context, asset);
                },
              ),
              ListTile(
                leading: const Icon(Icons.build, color: AppColors.primaryNavy),
                title: const Text('Schedule Maintenance'),
                onTap: () {
                  Navigator.pop(context);
                  _showMaintenanceDialog(context, asset);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: AppColors.error),
                title: const Text('Delete Asset'),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmation(context, asset);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAssetDetails(BuildContext context, Map<String, dynamic> asset) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Asset Details: ${asset['name']}'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDetailRow('Asset ID', asset['id']),
                _buildDetailRow('Category', asset['category']),
                _buildDetailRow('Status', asset['status']),
                _buildDetailRow('Location', asset['location']),
                _buildDetailRow('Purchase Date', asset['purchase_date']),
                _buildDetailRow('Purchase Price', asset['purchase_price']),
                _buildDetailRow('Assigned To', asset['assigned_to']),
                _buildDetailRow('Condition', asset['condition']),
                _buildDetailRow('Warranty Expiry', asset['warranty_expiry']),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.darkGray,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddAssetDialog(BuildContext context) {
    // This would be a form to add a new asset
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Asset'),
          content: const SingleChildScrollView(
            child: Text('Asset form would go here'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Add asset logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryMint,
                foregroundColor: AppColors.primaryNavy,
              ),
              child: const Text('Add Asset'),
            ),
          ],
        );
      },
    );
  }

  void _showEditAssetDialog(BuildContext context, Map<String, dynamic> asset) {
    // This would be a form to edit an existing asset
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Asset: ${asset['name']}'),
          content: const SingleChildScrollView(
            child: Text('Asset edit form would go here'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Update asset logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryMint,
                foregroundColor: AppColors.primaryNavy,
              ),
              child: const Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  void _showTransferDialog(BuildContext context, Map<String, dynamic> asset) {
    // This would be a form to transfer an asset to a new location/person
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Transfer Asset: ${asset['name']}'),
          content: const SingleChildScrollView(
            child: Text('Asset transfer form would go here'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Transfer asset logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryMint,
                foregroundColor: AppColors.primaryNavy,
              ),
              child: const Text('Transfer'),
            ),
          ],
        );
      },
    );
  }

  void _showMaintenanceDialog(BuildContext context, Map<String, dynamic> asset) {
    // This would be a form to schedule maintenance for an asset
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Schedule Maintenance: ${asset['name']}'),
          content: const SingleChildScrollView(
            child: Text('Maintenance scheduling form would go here'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Schedule maintenance logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryMint,
                foregroundColor: AppColors.primaryNavy,
              ),
              child: const Text('Schedule'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, Map<String, dynamic> asset) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Asset'),
          content: Text('Are you sure you want to delete ${asset['name']}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Delete asset logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: AppColors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}