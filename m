Return-Path: <linux-iio+bounces-11212-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40719AF24A
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 21:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B358A289487
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89BD21790F;
	Thu, 24 Oct 2024 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZEPD7HiR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBA22170BA;
	Thu, 24 Oct 2024 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797127; cv=none; b=uYnZE6YF4hppCXYUPefGHnpzx6wqFj5u6IKGHF9j4hwXcwD5rDD36lirhc1C2ODKGQ5cfdAObHn3JNmwfw0mOtUPHE3eJDWmf9hXEqey+DptrIByjlIxWhTI1pw2XxzngmHfWOd0HFTxzCJOuR46C6Xko45CwlAbzXLIxvIwr3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797127; c=relaxed/simple;
	bh=hvpYKl2aqhiqojiuSjEDscF3HMw+BXuyFgI4u7EJIFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k1V4IVPX+fJxO+vmL0wiuekD81MiyBHf8Ot3Uyh3NDg9TO/pbRe90VHXAk7rNspNY402J2JQwPi8EAwgW4MWLt818kHa660t8jbgObTCS9uVKq5hLAEiFYSVR6LsjtiCqmTv2pBDaY/faNlTw6jAuZpV5w4Aw8iJoGEwt5hv3v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZEPD7HiR; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729797125; x=1761333125;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hvpYKl2aqhiqojiuSjEDscF3HMw+BXuyFgI4u7EJIFs=;
  b=ZEPD7HiRfORIZplHJ96Jy2YzO3vv1XyCWWc/7nTBREFoLCctrn4GCI7x
   TMfFkyMYx3NAwxc39SEatiyS0vyUwjUiJtGfHAGDx4HrCkqUpedXOSzP7
   MQtdbjwTYoVm8JEzBcNz7glBjC68gxKCFNBOx51hexgdqRXlnlprYsnMM
   1AbOcVDwXYKAhe41ecCh7kx0zbTzPB/R7kZdYTCbzhlJ5rq74x2Atpb0u
   ThO/UUzPn70bUW48Io/hxu3E3ANLjWvRlIYYAaeeXhh5E0mlQR9XwZCAV
   yFxxKqgIWPkHQFnTdgBPZ11fO7e3B5viur3k4fJrUMOtSx9eos17+TojA
   g==;
X-CSE-ConnectionGUID: XS83D3Z1QiqfKFFZE7g3OA==
X-CSE-MsgGUID: nyFpZ9IQQby1GUulfAR7/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="46934404"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="46934404"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:12:04 -0700
X-CSE-ConnectionGUID: A7qBuIkMQ3qYtlAPdmZoEA==
X-CSE-MsgGUID: qKDA0PULT/Wp1z3jJIk3nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="80266645"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 24 Oct 2024 12:12:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 041F6252; Thu, 24 Oct 2024 22:12:00 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 00/24] iio: Clean up acpi_match_device() use cases
Date: Thu, 24 Oct 2024 22:04:49 +0300
Message-ID: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There are current uses of acpi_match_device():
- as strange way of checking if the device was enumerated via ACPI
- as a way to get IIO device name as ACPI device instance name
- as above with accompanying driver data

Deduplicate its use by providing two new helper functions in IIO ACPI
library and update the rest accordingly.

This also includes a rework of previously sent ltr501 patch.

Besides that there ie a big clean up for the kxcjk-1013 driver, started
with the revert of the one patch discussed earlier today. Feel free to
route that one via fixes branch of your tree.

In v3:
- collected tags (Marius)
- added note to the documentation about usage of new API (Jonathan)
- added a handful patches for kxcjk-1013 driver

In v2:
- collected tags (Hans, Jean-Baptiste)
- updated SoB chain in patch 4

Andy Shevchenko (24):
  iio: magnetometer: bmc150: Drop dead code from the driver
  iio: adc: pac1934: Replace strange way of checking type of enumeration
  iio: imu: inv_mpu6050: Replace strange way of checking type of
    enumeration
  iio: acpi: Improve iio_read_acpi_mount_matrix()
  iio: acpi: Add iio_get_acpi_device_name_and_data() helper function
  iio: accel: kxcjk-1013: Remove redundant I²C ID
  iio: accel: kxcjk-1013: Revert "Add support for KX022-1020"
  iio: accel: kxcjk-1013: Switch from CONFIG_PM guards to pm_ptr() etc
  iio: accel: kxcjk-1013: Use local variable for regs
  iio: accel: kxcjk-1013: Rename kxcjk1013_info
  iio: accel: kxcjk-1013: Start using chip_info variables instead of
    enum
  iio: accel: kxcjk-1013: Move odr_start_up_times up in the code
  iio: accel: kxcjk-1013: Convert ODR times array to variable in
    chip_info
  iio: accel: kxcjk-1013: Get rid of enum kx_chipset
  iio: accel: kxcjk-1013: Replace a variant of
    iio_get_acpi_device_name_and_data()
  iio: accel: kxcjk-1013: drop ACPI_PTR() and move ID out of CONFIG_ACPI
    guards
  iio: accel: mma9551: Replace custom implementation of
    iio_get_acpi_device_name()
  iio: accel: mma9553: Replace custom implementation of
    iio_get_acpi_device_name()
  iio: gyro: bmg160: Replace custom implementation of
    iio_get_acpi_device_name()
  iio: light: isl29018: Replace a variant of
    iio_get_acpi_device_name_and_data()
  iio: light: isl29018: drop ACPI_PTR() and CONFIG_ACPI guards
  iio: light: ltr501: Drop most likely fake ACPI IDs
  iio: light: ltr501: Add LTER0303 to the supported devices
  iio: light: ltr501: Replace a variant of
    iio_get_acpi_device_name_and_data()

 drivers/iio/accel/kxcjk-1013.c             | 449 +++++++++++----------
 drivers/iio/accel/mma9551.c                |  19 +-
 drivers/iio/accel/mma9553.c                |  19 +-
 drivers/iio/adc/pac1934.c                  |   2 +-
 drivers/iio/gyro/bmg160_core.c             |  15 -
 drivers/iio/gyro/bmg160_i2c.c              |   4 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c |   5 +-
 drivers/iio/industrialio-acpi.c            |  48 ++-
 drivers/iio/light/isl29018.c               |  38 +-
 drivers/iio/light/ltr501.c                 |  29 +-
 drivers/iio/magnetometer/bmc150_magn.c     |  15 -
 include/linux/iio/iio.h                    |  10 +
 12 files changed, 315 insertions(+), 338 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


