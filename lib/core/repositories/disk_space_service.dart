import 'package:disk_space_2/disk_space_2.dart';

import 'contracts.dart';

class DeviceDiskSpaceService implements DiskSpaceService {
  const DeviceDiskSpaceService();

  @override
  Future<int?> getFreeBytes(String path) async {
    final mebibytes = await DiskSpace.getFreeDiskSpaceForPath(path);
    return mebibytes == null ? null : (mebibytes * 1024 * 1024).floor();
  }
}
