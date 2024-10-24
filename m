Return-Path: <linux-iio+bounces-11232-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBF99AF275
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 21:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD601C260EA
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B5A228B69;
	Thu, 24 Oct 2024 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g//6B/qC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FAC224B50;
	Thu, 24 Oct 2024 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797140; cv=none; b=UKhJk8FUBT3Kusqrb2JaDkOkEk7XDmB1l7x2OO+29uT4RLchU7n+h704o5MW+KsWbwPkMFPXoUrLkDKGSTknESzUy0pYDknpHbasHP7ouq+7EILOfiqNHkYTPGIRN5Urt6HSYSBoQV9pQ44wlBgLCPcrPLvZyY/Z+z5rknrMb0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797140; c=relaxed/simple;
	bh=7VD/YZ3dxyXfp5F1cccl2DO7mfRb7DzapOk2MWXOIuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AP73UnYn20oJL52iABsfEtC5oy7GG/hpU5r0clEPuOL3upzWNp2JmNQdxyQsngLgG/yw23jTXfZuM5ZW7SpzSO9krOz+aDYG1tabYAduyE/RPJFZ9toKNhHyLGzPM3ovF6u4X5u7gvwAv8j7s1CUnbuCR6Bb9g5T4iEgsRDahbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g//6B/qC; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729797138; x=1761333138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7VD/YZ3dxyXfp5F1cccl2DO7mfRb7DzapOk2MWXOIuI=;
  b=g//6B/qC0FEdNpzuI6vMs4gfoWm+Rz2bLVHHVl+AgdTsl1b0aSmug/Dz
   O4usGf7RM36+8KseG3lVBkOXB+71NL+0RV2bVDEPeSu1NRSusLdjCPJ0H
   NEo7Pr5ZqBBcK5p4TGKQ7rj5YKoYgRlALBikQYzHAaadJ5GteBZ7vifpN
   qpTjM6DymS/Q8/ZW7E9eq6yHh7Pd1PROVk33RXMKxqgZhGxtAnh52Tg6G
   em0pspz0gV/CaDk1Y6On2rlLYA79sAu5N1aQKBiySnV8MrpdB/4WbdTrm
   CMEKPvnYRBc/Y7RluNAJEqnhIFnTTX7+sBjcbgvjhPSD/+VKBTfbcDOk4
   g==;
X-CSE-ConnectionGUID: NuxNraqOT/CvjZEiuqm/4w==
X-CSE-MsgGUID: w8X8LHztQmK8HwdkOzV4bA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="46934537"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="46934537"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:12:11 -0700
X-CSE-ConnectionGUID: 4wmZuixmRzy1i2nqX7mz1g==
X-CSE-MsgGUID: FGzQ+BlfSQCF8+sBwp8w7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="80266718"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 24 Oct 2024 12:12:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EE9DC8EC; Thu, 24 Oct 2024 22:12:01 +0300 (EEST)
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
Subject: [PATCH v3 19/24] iio: gyro: bmg160: Replace custom implementation of iio_get_acpi_device_name()
Date: Thu, 24 Oct 2024 22:05:08 +0300
Message-ID: <20241024191200.229894-20-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IIO core (ACPI part) provides a generic helper that may be used in
the driver. Replace custom implementation of iio_get_acpi_device_name().

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/gyro/bmg160_core.c | 15 ---------------
 drivers/iio/gyro/bmg160_i2c.c  |  4 +++-
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 10728d5ccae3..499078537fa4 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -8,7 +8,6 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-#include <linux/acpi.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/iio/iio.h>
@@ -1055,17 +1054,6 @@ static const struct iio_buffer_setup_ops bmg160_buffer_setup_ops = {
 	.postdisable = bmg160_buffer_postdisable,
 };
 
-static const char *bmg160_match_acpi_device(struct device *dev)
-{
-	const struct acpi_device_id *id;
-
-	id = acpi_match_device(dev->driver->acpi_match_table, dev);
-	if (!id)
-		return NULL;
-
-	return dev_name(dev);
-}
-
 int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 		      const char *name)
 {
@@ -1098,9 +1086,6 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 
 	mutex_init(&data->mutex);
 
-	if (ACPI_HANDLE(dev))
-		name = bmg160_match_acpi_device(dev);
-
 	indio_dev->channels = bmg160_channels;
 	indio_dev->num_channels = ARRAY_SIZE(bmg160_channels);
 	indio_dev->name = name;
diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
index a81814df5205..9c5d7e8ee99c 100644
--- a/drivers/iio/gyro/bmg160_i2c.c
+++ b/drivers/iio/gyro/bmg160_i2c.c
@@ -17,7 +17,7 @@ static int bmg160_i2c_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct regmap *regmap;
-	const char *name = NULL;
+	const char *name;
 
 	regmap = devm_regmap_init_i2c(client, &bmg160_regmap_i2c_conf);
 	if (IS_ERR(regmap)) {
@@ -28,6 +28,8 @@ static int bmg160_i2c_probe(struct i2c_client *client)
 
 	if (id)
 		name = id->name;
+	else
+		name = iio_get_acpi_device_name(&client->dev);
 
 	return bmg160_core_probe(&client->dev, regmap, client->irq, name);
 }
-- 
2.43.0.rc1.1336.g36b5255a03ac


