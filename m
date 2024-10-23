Return-Path: <linux-iio+bounces-10999-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1909ACE91
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 17:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2563B1F23EE3
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 15:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA9A1C9EBF;
	Wed, 23 Oct 2024 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AQBqlOIL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805451A76BC;
	Wed, 23 Oct 2024 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696924; cv=none; b=EgwqOqhka7/TYhca5LtZb1C/sAnJFIkU9EW9HmoaZkWpwPM2WZTwQsA+0eu1MDnTl2e0Q6H1HCu8GRdq/pql1YtsEo02FWDZTJ0aBOMQNRAad0aSKP9bwudDq907bhZNCoR5Jg8eYNeqMNoN61c9wC9M9BaEjpdFIW0KwI4oM3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696924; c=relaxed/simple;
	bh=vMDAskFdruufkzegFHqLFG9HztgrEKOtKQZ2YdbSa+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=chN1e88+Al5zbAw8gpMM3nXyZwa3j3q9zFAVnyZGP9by5CJNFbuonnwI1XGmZoTqemI6973WWS91M2WuCfIAPvQC2OFAbF6virruiaenJvyY1FH+M9zG8/3AJ9Q3vfQHu5DmwqWASWIJVAkSRThC4HXxDURMEDC20GYnGEl7C7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AQBqlOIL; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729696922; x=1761232922;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vMDAskFdruufkzegFHqLFG9HztgrEKOtKQZ2YdbSa+8=;
  b=AQBqlOILLqnKE9MIK4jOpphYkP5d83OOYaMscFs4N70maVpql6DCJzXz
   RMlXfTpHYTBGYA69fz7EDlPMBqvbolLZyHQ/8mG+qMqXRsy4d9BFLakC1
   R/mGZS9kpbZjMjeoIIQGXgVao4HRFrOhwEyOLuTcHsxDvJubZJGZxM26U
   RIrBmpGDoM77/MnXdiU6NooqWQns9QV4tYABzuZJO8cTaEsjEMgrWMMWZ
   IABdZzSutaAee4beCkSfmnkEKF6qAn6MKS48CD2HleQaaS1bWWkU5RCBv
   WZAbUvg4Ultjy5uN2iRKz7pOqUnKNm6j/eZXrOzT8k+UnxLMIkBWZSJOa
   g==;
X-CSE-ConnectionGUID: +tJH+kdYTmaoVCs2YP+qKw==
X-CSE-MsgGUID: W6FZZSreRGOHC5Py/lizAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29449193"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29449193"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 08:21:59 -0700
X-CSE-ConnectionGUID: zTNCEsOMSzWptf0++Xc56Q==
X-CSE-MsgGUID: FQ3nsIJgQY2YhHIcoOAlsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="80179591"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 23 Oct 2024 08:21:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8E957252; Wed, 23 Oct 2024 18:21:48 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v1 00/13] iio: Clean up acpi_match_device() use cases
Date: Wed, 23 Oct 2024 18:17:23 +0300
Message-ID: <20241023152145.3564943-1-andriy.shevchenko@linux.intel.com>
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


