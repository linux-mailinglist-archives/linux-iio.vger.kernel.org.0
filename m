Return-Path: <linux-iio+bounces-10732-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9537C9A41D2
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 16:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DB34B2479D
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 14:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC1F1FF5F8;
	Fri, 18 Oct 2024 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VWjERFmc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE391F429B;
	Fri, 18 Oct 2024 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729263491; cv=none; b=LqYidhPaJpoxnVL3DnR5emZU51M3R2ip1NOAH6wbAbwI82lUpt/q0DT5Eph5hZ6Dj0xUAujuLKM+vlBFy8tIUhRgKVf2crimmJoP4AAkLZgnqZfm8g6XJ6/46u3bTeuyMuxs58hvjcZDaatpKCaNDmqeN9K3pYfV08BOsrqcLiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729263491; c=relaxed/simple;
	bh=74fLzFNcwcounsFYAZsEPLGIMN5eGdKW2jj2yAaU8k8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fe0KqXL1QAkUjQx11lTEzCUoTR9/ZSLKPKcvkyRzL3+s3QLE09Y4qAi2v0eDPCHIFcDhhiN7iTOV9cmX/NCUUoA+S3eevYv7BED6eDTpEy/s4LFJWmfvbXDgueaQ28Qk7c6Gw8r8p9t18TNysQZk+7a2B3Rcg0fYkhRy3vyjNcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VWjERFmc; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729263490; x=1760799490;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=74fLzFNcwcounsFYAZsEPLGIMN5eGdKW2jj2yAaU8k8=;
  b=VWjERFmcI6/R1egm/9OmBBixv9dnlMjreS8Zpi+YY9sjpxMKJoHB39rW
   T7Hqu8ZPFeCbiMkS21DtlHwEo8VffMsbRdiGtpi1xwuf+RbkBVBykuZ2a
   VjSPi4PvYSfVRSwSayvtEs1tWjoKKnkhXTYkjVoLOTy3tlGrgR8lvcETo
   uRgUi02xJo3BEnlRKSCfS3VhtFudpNZVrbB6p0EWytLj1yg1cBjX0JUy3
   W+avsYygr08ByYAtEaejL0fNT0OY9FpjXMWtIbgDT3nsONAkmxTLFraIY
   Hg8GwmTBM6UDJ+W+eA5KVc9v2+1BioG5Rryy2+pt62TcZ9qgQoAzPdKnr
   g==;
X-CSE-ConnectionGUID: gZ3Q0zEWSQKkua7VrNU1xw==
X-CSE-MsgGUID: VWjIkcPbTfW5QA6I+Zg6xA==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="29005975"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="29005975"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:58:09 -0700
X-CSE-ConnectionGUID: f//i9UHiT3e3x0AuLeFSug==
X-CSE-MsgGUID: DjJe8tEjTiuUjV+IeEIcKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="78903326"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 18 Oct 2024 07:58:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 47EBE343; Fri, 18 Oct 2024 17:58:06 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v1 1/1] iio: magnetometer; bmc150_magn: Drop most likely fake ACPI IDs
Date: Fri, 18 Oct 2024 17:58:05 +0300
Message-ID: <20241018145805.2181682-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commits in question do not proove that ACPI IDs exist.
Quite likely it was a cargo cult addition while doing that
for DT-based enumeration. Drop most likely fake ACPI IDs.

The to be removed IDs has been checked against the following resources:
1) DuckDuckGo
2) Google
3) MS catalog: https://www.catalog.update.microsoft.com/Search.aspx
This gives no useful results in regard to DSDT, moreover, the official
vendor IDs in the registry for Bosh are BSG and BOSC.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/bmc150_magn_i2c.c | 9 ---------
 drivers/iio/magnetometer/bmc150_magn_spi.c | 9 ---------
 2 files changed, 18 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn_i2c.c b/drivers/iio/magnetometer/bmc150_magn_i2c.c
index a28d46d59875..17e10a462ac8 100644
--- a/drivers/iio/magnetometer/bmc150_magn_i2c.c
+++ b/drivers/iio/magnetometer/bmc150_magn_i2c.c
@@ -38,14 +38,6 @@ static void bmc150_magn_i2c_remove(struct i2c_client *client)
 	bmc150_magn_remove(&client->dev);
 }
 
-static const struct acpi_device_id bmc150_magn_acpi_match[] = {
-	{"BMC150B", 0},
-	{"BMC156B", 0},
-	{"BMM150B", 0},
-	{},
-};
-MODULE_DEVICE_TABLE(acpi, bmc150_magn_acpi_match);
-
 static const struct i2c_device_id bmc150_magn_i2c_id[] = {
 	{ "bmc150_magn" },
 	{ "bmc156_magn" },
@@ -67,7 +59,6 @@ static struct i2c_driver bmc150_magn_driver = {
 	.driver = {
 		.name	= "bmc150_magn_i2c",
 		.of_match_table = bmc150_magn_of_match,
-		.acpi_match_table = bmc150_magn_acpi_match,
 		.pm	= &bmc150_magn_pm_ops,
 	},
 	.probe		= bmc150_magn_i2c_probe,
diff --git a/drivers/iio/magnetometer/bmc150_magn_spi.c b/drivers/iio/magnetometer/bmc150_magn_spi.c
index abc75a05c46a..c850de1bc79b 100644
--- a/drivers/iio/magnetometer/bmc150_magn_spi.c
+++ b/drivers/iio/magnetometer/bmc150_magn_spi.c
@@ -41,20 +41,11 @@ static const struct spi_device_id bmc150_magn_spi_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, bmc150_magn_spi_id);
 
-static const struct acpi_device_id bmc150_magn_acpi_match[] = {
-	{"BMC150B", 0},
-	{"BMC156B", 0},
-	{"BMM150B", 0},
-	{},
-};
-MODULE_DEVICE_TABLE(acpi, bmc150_magn_acpi_match);
-
 static struct spi_driver bmc150_magn_spi_driver = {
 	.probe		= bmc150_magn_spi_probe,
 	.remove		= bmc150_magn_spi_remove,
 	.id_table	= bmc150_magn_spi_id,
 	.driver = {
-		.acpi_match_table = bmc150_magn_acpi_match,
 		.name	= "bmc150_magn_spi",
 	},
 };
-- 
2.43.0.rc1.1336.g36b5255a03ac


