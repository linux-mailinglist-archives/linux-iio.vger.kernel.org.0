Return-Path: <linux-iio+bounces-11226-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1CE9AF266
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 21:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89293B22832
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9A621B42C;
	Thu, 24 Oct 2024 19:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="foHCzaEU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BB621B442;
	Thu, 24 Oct 2024 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797135; cv=none; b=b/QhiUBjLVQ9UB3JpejObkZgV0kidWS5I2+qGoOJ8a5eUrgi2bBZrsNPZgXZpPSj1Ki2mfYSeSsKkimPSBXbAqlN9F8vNVXlyvqXOY71mpcvjcJJNft3+fbdK4AkBEFZVDusC3QCY84qd8zbItY0m+4uG5JbJG7KotSjS+3xsIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797135; c=relaxed/simple;
	bh=uf9btLtoClCOjF/hTMc4aLgnXwHw0svLKzR/oE7cpbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uy1SOiYzuRXwX3RhJeoYU6qYGdYaMDervu4Lbi7BsqAUa8czSp7OK3QtIQqhkRKlJE5GH0kytaGWphbLGsq8m5vgZyYtNCHxcuml2GZ5idTmLI18DBW2Jh7nU9Q2T2SN2iEBBbIElKZBN3RYPu7RG9efqBZow4Lca1OlvYHkP5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=foHCzaEU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729797133; x=1761333133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uf9btLtoClCOjF/hTMc4aLgnXwHw0svLKzR/oE7cpbo=;
  b=foHCzaEUo7xVmbOXRp4JKQzVhDc39GPQvEmiHaiIvblHyjcm5+G5M9JB
   lrth8VnaXz2QaILKgZn3kRiZWQ+BOQqh1WE25G9E7c4EWYli4ZNe17hsF
   AEOrhDYC5vxOAU/C4Awr68ExETQ92s+MGDzC5jeIPGdAtFsjYCHArJAyV
   D1SxVk0XfgkNbMXrFxleeytJAjJ1QiDd8/CBstNycePG9eRofU629YQmR
   yFWYrTutLsCuDoxkqTNzlVLmRfbAnG+K0ADhfr+UMrDAdpTk2bT9IjHrJ
   +FiCmo1eQRKkBmSxcz1vJAFR+F6SJHSzyKXz1ONLIjZBNmzoUQhYoBb4u
   Q==;
X-CSE-ConnectionGUID: x/T/LtNgTFWFyFFHSUKFTg==
X-CSE-MsgGUID: 2ILj3+zxRfaxKyZUkKhQDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29563217"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="29563217"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:12:12 -0700
X-CSE-ConnectionGUID: UV+BvQjWS8CEjhxzO9060Q==
X-CSE-MsgGUID: lwvM5+r0RsmMQR/AnOV6IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="85791754"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 24 Oct 2024 12:12:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3185BBD1; Thu, 24 Oct 2024 22:12:02 +0300 (EEST)
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
Subject: [PATCH v3 24/24] iio: light: ltr501: Replace a variant of iio_get_acpi_device_name_and_data()
Date: Thu, 24 Oct 2024 22:05:13 +0300
Message-ID: <20241024191200.229894-25-andriy.shevchenko@linux.intel.com>
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
the driver. Replace a variant of iio_get_acpi_device_name_and_data().

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
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


