Return-Path: <linux-iio+bounces-10993-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C0D9ACE82
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 17:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3A81F2336B
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 15:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DD61BE23F;
	Wed, 23 Oct 2024 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FnP8jfpV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8221C1ADFF5;
	Wed, 23 Oct 2024 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696918; cv=none; b=iXw5HYRqk4M6pHKwhFDtcUsfIhKwxobc8i/Qy/4ztOqVkf93xLjiYLd1aZhhDNmda3T9X1EyvTI/CLcdny25Yh4ygERhX1M75FMO4sW69+utS8jV3gNBGjWPrGoCO7IPU0V0LeGU2BemhuIgBB8T6+p38kVQgMDSozzwSrPNdGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696918; c=relaxed/simple;
	bh=v2aFdgK6XcZSWP1hJOrhbPXIQXhFFZvYV0bSqCyYMYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFzw4GticFHiGs5R6ENi82gPWKiX+T7e9fM5xrqJY/LJL3xB391KftFlB1xGJ3ft3YrgAO/bLx6laszTLj4BrxBBQ70gmsk/urTY3BqewouGKfQgekbpZgAoekixepHCkqJd1ZFHxJJQ5VjZ2XCEmF2ngBd9E2+lZSuhJwPzRH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FnP8jfpV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729696917; x=1761232917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v2aFdgK6XcZSWP1hJOrhbPXIQXhFFZvYV0bSqCyYMYA=;
  b=FnP8jfpVPDJ/oKAZtNh1eHjDiJ2OKZ6Y551/jZZrIFVBLaOGSAxhNNPn
   98r6lqF+j2LiTSz4GnwMS+KZPgvb0Ct8eQR6j1bTsabCTXOjxMtgEGQE7
   hwyNH6esBcITFQK6bdE41riDdAZnhODp4ENOC5r3kc463un7qNjuEg+iC
   64aWC20Tm+ps6dw1UuVNCzXdDl5SC3m6PsEheRfdu65lJt1JnqR2jzRDG
   aVHs5hdlnNZDLLBDIsiIFepVMmG+TE6qWgWM8CWuXoUiSK34HLFI54mbk
   DTqrc6GVLxbof8tco6vEFIkrr3/ylGKAi7j9CY764vcty6A8cH/MgUqOO
   Q==;
X-CSE-ConnectionGUID: tJI85ZE+Soy+VxJbPBAK+Q==
X-CSE-MsgGUID: Pl9surWaRzSWhWvbvROycw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46757904"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46757904"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 08:21:56 -0700
X-CSE-ConnectionGUID: NLdGGJjOSzirU153mWDuPw==
X-CSE-MsgGUID: zlY6Q2PJTxuguX46NN0J3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="79823541"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 23 Oct 2024 08:21:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 04FB6588; Wed, 23 Oct 2024 18:21:48 +0300 (EEST)
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
Subject: [PATCH v1 08/13] iio: gyro: bmg160: Replace custom implementation of iio_get_acpi_device_name()
Date: Wed, 23 Oct 2024 18:17:31 +0300
Message-ID: <20241023152145.3564943-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241023152145.3564943-1-andriy.shevchenko@linux.intel.com>
References: <20241023152145.3564943-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IIO core (ACPI part) provides a generic helper that may be used in
the driver. Replace custom implementation of iio_get_acpi_device_name().

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


