import 'package:bloc_learner/utils/shimmer_utils.dart';
import 'package:bloc_learner/widgets/shimmer_items/card_list_item.dart';
import 'package:bloc_learner/widgets/shimmer_items/circle_item.dart';
import 'package:bloc_learner/widgets/shimmer_items/shimmer/shimmer.dart';
import 'package:bloc_learner/widgets/shimmer_items/shimmer/shimmer_loading.dart';
import 'package:flutter/material.dart';

class ShimmerScreen extends StatefulWidget {
  const ShimmerScreen({super.key});

  @override
  State<ShimmerScreen> createState() => _ShimmerScreenState();
}

class _ShimmerScreenState extends State<ShimmerScreen> {
  bool _isLoading = true;

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shimmer Screen'),
      ),
      body: ListView(
        physics: _isLoading ? const NeverScrollableScrollPhysics() : null,
        children: [
          const SizedBox(height: 16),
          Shimmer(
            linearGradient: ShimmerUtils.shimmerGradient,
            child: _buildTopRowList(),
          ),
          const SizedBox(height: 16),
          Shimmer(
            linearGradient: ShimmerUtils.shimmerGradient,
            child: _buildListItem(),
          ),
          Shimmer(
            linearGradient: ShimmerUtils.shimmerGradient,
            child: _buildListItem(),
          ),
          Shimmer(
            linearGradient: ShimmerUtils.shimmerGradient,
            child: _buildListItem(),
          ),
          // _buildListItem(),
          // _buildListItem(),
          // _buildListItem(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleLoading,
        child: Icon(
          _isLoading ? Icons.hourglass_full : Icons.hourglass_bottom,
        ),
      ),
    );
  }

  Widget _buildTopRowList() {
    return SizedBox(
      height: 72,
      child: ListView(
        physics: _isLoading ? const NeverScrollableScrollPhysics() : null,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          const SizedBox(width: 16),
          _buildTopRowItem(),
          _buildTopRowItem(),
          _buildTopRowItem(),
          _buildTopRowItem(),
          _buildTopRowItem(),
          _buildTopRowItem(),
        ],
      ),
    );
  }

  Widget _buildTopRowItem() {
    return ShimmerLoading(
      isLoading: _isLoading,
      child: const CircleListItem(),
    );
  }

  Widget _buildListItem() {
    return ShimmerLoading(
      isLoading: _isLoading,
      child: CardListItem(
        isLoading: _isLoading,
      ),
    );
  }
}
