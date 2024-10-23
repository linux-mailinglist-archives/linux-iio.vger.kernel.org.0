Return-Path: <linux-iio+bounces-11006-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0439ACEA1
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 17:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F60285DCA
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 15:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6004B1CACC8;
	Wed, 23 Oct 2024 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1sETyk8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D52C1C9EDC;
	Wed, 23 Oct 2024 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696958; cv=none; b=hS6f37pVB++l0U/ESx3P24j9n6LoF5V97ATFiXND+A0gjInUFYZzSUYTVk/H1VmvcsyCG0J1lc4KH2LUiQvBWriABmRT7dgjNF2pXhQr1IHzbNgCiChW84wUOla7MJbVoW96R3GIMMb5g6s2VQ4yJTcsFaUOyvGTNxi1h32oTT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696958; c=relaxed/simple;
	bh=Q2rrzZAtm3fm6EOsPSqpPKX95A5SEPcckPpxCpzG8Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJFM8DHMEYfh1q2XJsWm7gQ5/GFFKg259CEirxCoFCRL5/4OyIgttSDAC0Xg2+45KPSY8jrxcHTx+hzm4gTGvuLD4aQBZCZVpfZa6qwmaV5f67SM70iivCMcYqVZA1WXyjnPFmqQ9AaAOfKNB8ff8SEtwK2wT6VRWzf16zIxY4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1sETyk8; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729696957; x=1761232957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q2rrzZAtm3fm6EOsPSqpPKX95A5SEPcckPpxCpzG8Xg=;
  b=I1sETyk8huOvJQrj5PNn7Zajp7yerKbhXzIqyXhncCl44t5DBMm1m9KO
   fj+Pniia5anmOOP3alKzs9xXMSi5EokrRlNItjnFDyJ9k5c2qYYrUlEm+
   OmkjSq40EfLf2bmjQlHi1d6gdJntWjmLghJI84mI21/pLx3eEijtcVG9P
   RKldE1tl76V6khsP0fv6xC7Fqy6x8dSQ/l0DJXys6mQMr/4wXykaPH6NH
   1ZeoC+c6z5k1jiVXYv/H13F+K5yV7eeUvW1rWoPDpkqxsgfD00/SnQASI
   yAKlU3c+MZrXoWOkR49MZ31htS0NdWV9HcC9eb2XRQWg4sEoy0xSZoYCH
   A==;
X-CSE-ConnectionGUID: RpyjDyL8RyCARjayTJnNPA==
X-CSE-MsgGUID: WNMZ+wWdRGyk4cRjrUwRiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39841526"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39841526"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 08:21:57 -0700
X-CSE-ConnectionGUID: fh0buKkcTXahrPe8s/F0Lg==
X-CSE-MsgGUID: NZIDNE+YT8W0bY4lxjIZEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="80430828"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 23 Oct 2024 08:21:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3A56A6A7; Wed, 23 Oct 2024 18:21:49 +0300 (EEST)
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
Subject: [PATCH v1 13/13] iio: light: ltr501: Replace a variant of iio_get_acpi_device_name_and_data()
Date: Wed, 23 Oct 2024 18:17:36 +0300
Message-ID: <20241023152145.3564943-14-andriy.shevchenko@linux.intel.com>
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
the driver. Replace a variant of iio_get_acpi_device_name_and_data().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/ltr501.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 4051d0d9e799..c389be6a106d 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -15,7 +15,6 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/regmap.h>
-#include <linux/acpi.h>
 #include <linux/regulator/consumer.h>
 
 #include <linux/iio/iio.h>
@@ -1422,17 +1421,6 @@ static int ltr501_powerdown(struct ltr501_data *data)
 				  data->ps_contr & ~LTR501_CONTR_ACTIVE);
 }
 
-static const char *ltr501_match_acpi_device(struct device *dev, int *chip_idx)
-{
-	const struct acpi_device_id *id;
-
-	id = acpi_match_device(dev->driver->acpi_match_table, dev);
-	if (!id)
-		return NULL;
-	*chip_idx = id->driver_data;
-	return dev_name(dev);
-}
-
 static int ltr501_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
@@ -1440,8 +1428,10 @@ static int ltr501_probe(struct i2c_client *client)
 	struct ltr501_data *data;
 	struct iio_dev *indio_dev;
 	struct regmap *regmap;
-	int ret, partid, chip_idx = 0;
-	const char *name = NULL;
+	int partid, chip_idx;
+	const void *ddata;
+	const char *name;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
@@ -1523,11 +1513,12 @@ static int ltr501_probe(struct i2c_client *client)
 	if (id) {
 		name = id->name;
 		chip_idx = id->driver_data;
-	} else  if (ACPI_HANDLE(&client->dev)) {
-		name = ltr501_match_acpi_device(&client->dev, &chip_idx);
 	} else {
-		return -ENODEV;
+		name = iio_get_acpi_device_name_and_data(&client->dev, &ddata);
+		chip_idx = (intptr_t)ddata;
 	}
+	if (!name)
+		return -ENODEV;
 
 	data->chip_info = &ltr501_chip_info_tbl[chip_idx];
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


