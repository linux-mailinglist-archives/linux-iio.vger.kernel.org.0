Return-Path: <linux-iio+bounces-11107-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 626FE9AE591
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 15:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A46E284F1A
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 13:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5892E1D89E3;
	Thu, 24 Oct 2024 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fU8S6YAy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BEE1D63FB;
	Thu, 24 Oct 2024 13:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775083; cv=none; b=N7UUq0KAe/XVHm64oRyxPR1sndrIdLXMdrbVBt7VnIZLiOPCyrOYCK27HBwrUmfhy99usJEe0j23jVWYAdgQxp1gWSdcw1xz48grw0A64afBSA3j0RdonLbf37iGMtcFUs2JZXDo2uvbclzw+qXXHCxAiH5L4vu7H88ikp0Uetk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775083; c=relaxed/simple;
	bh=fnr+wlY4mm9fxB3WttBrUUaubpN0xpag/hGemkkYPyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uCcO3Ke15Bw9qwZzhPVTW41gJYb+uNh4B95kPRruQ3+vI8A2IVhOdbv5CBTq0JhUC1FnvfHb9jAgzvzh8XHqmADsPkgCABYHjOVOHdUdwdjVz8BE8ryG7o17EqOXD6N5AG9eFeMMcV32xSomykKqf0RsBPuWKUDZy9jdx8/uEqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fU8S6YAy; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729775081; x=1761311081;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fnr+wlY4mm9fxB3WttBrUUaubpN0xpag/hGemkkYPyc=;
  b=fU8S6YAyf/at+QiQPPQmz2JjY2fNRZNN+eot6GMfqOfr4Z1J1+VD2N0A
   /Ogm4/Q4txDrXY6Qb+/Nt3RyPJVpeYsvPymTIand57G+BO3KbQ2+DZoZC
   t/GhAQTcwh3+dD7mKkwS2T03Hdy938CRwxb5NvXqOZ/GKwoFhBbiZqXE4
   V/Zy5Q2REq9gKJsPWbVAwUhC4aI+Owp0qRrefjy5CxNY/tkmfkbc2aOay
   VG7hzR16gUBgYyh6zgCCFWiMk5lQIONsk0bHzVvln0yX1vPn4Q6eQpJpS
   4wA5n5dlSEfmdgvR2yxoWj8jeLc1XtE8C+y4oYXMKe76Y/XPmklpnCsTB
   g==;
X-CSE-ConnectionGUID: DyTPi9yBS8KOYOueOQCI+Q==
X-CSE-MsgGUID: JZkZoWNHQAu9HTkzloRy8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="54802768"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="54802768"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 06:04:28 -0700
X-CSE-ConnectionGUID: dsqS1srlQkud69Tl7sw3SA==
X-CSE-MsgGUID: zDOc5cSNRf6k/6pZ6a+Fxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80238761"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 24 Oct 2024 06:04:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B2B2D331; Thu, 24 Oct 2024 16:04:24 +0300 (EEST)
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
Subject: [PATCH v2 00/13] iio: Clean up acpi_match_device() use cases
Date: Thu, 24 Oct 2024 15:36:05 +0300
Message-ID: <20241024130424.3818291-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are current uses of acpi_match_device():
- as strange way of checking if the device was enumerated via ACPI
- as a way to get IIO device name as ACPI device instance name
- as above with accompanying driver data

Deduplicate its use by providing two new helper functions in IIO ACPI
library and update the rest accordingly.

This also includes a rework of previously sent ltr501 patch.

In v2:
- collected tags (Hans, Jean-Baptiste)
- updated SoB chain in patch 4

Andy Shevchenko (13):
  iio: magnetometer: bmc150: Drop dead code from the driver
  iio: adc: pac1934: Replace strange way of checking type of enumeration
  iio: imu: inv_mpu6050: Replace strange way of checking type of
    enumeration
  iio: acpi: Improve iio_read_acpi_mount_matrix()
  iio: acpi: Add iio_get_acpi_device_name_and_data() helper function
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

 drivers/iio/accel/mma9551.c                | 19 ++-------
 drivers/iio/accel/mma9553.c                | 19 ++-------
 drivers/iio/adc/pac1934.c                  |  2 +-
 drivers/iio/gyro/bmg160_core.c             | 15 --------
 drivers/iio/gyro/bmg160_i2c.c              |  4 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c |  5 +--
 drivers/iio/industrialio-acpi.c            | 45 ++++++++++++++++++++--
 drivers/iio/light/isl29018.c               | 38 ++++++------------
 drivers/iio/light/ltr501.c                 | 29 +++++---------
 drivers/iio/magnetometer/bmc150_magn.c     | 15 --------
 include/linux/iio/iio.h                    | 10 +++++
 11 files changed, 86 insertions(+), 115 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


