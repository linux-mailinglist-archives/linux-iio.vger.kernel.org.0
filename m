Return-Path: <linux-iio+bounces-11231-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A169AF273
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 21:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A3B1C260C6
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1309B228B51;
	Thu, 24 Oct 2024 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXCIBLJ0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6C822626D;
	Thu, 24 Oct 2024 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797139; cv=none; b=iNNnvRqj5YsIcF+Sf5BikgV+5XCr8S1doa9Y52O7kpudCkTVdmstgvB2/l2oUMamOh9HT6URj20KEh4l/2bE/tAkQd+kXiOSW/ObLBuLhpDRxpEe2cX8ZOk7NmXkdBJIZTmmARKpPgf8yEBbaYFPGicoz5jjGYU67yGVmHKPVkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797139; c=relaxed/simple;
	bh=b8hIeNRtf3Ory07zi10pIZrzrMdfb+TK7D/5/ekkk3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYhGyysiepGsZj5V3pM8w8Nfb2Wy5A8uyS8olAjEaEAiRUz0Rg8JNb39yTYM++l4ax7n+x7k9knrx/Mjt1iRRWwG6nj+Xa4YMZKiVrC0I4HQVTPg5cG4yH5h2eADoQ9B4kZXnntwqzMEOmahTYdIUNwXPKznLY4e/K1Rp1hfBPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jXCIBLJ0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729797138; x=1761333138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b8hIeNRtf3Ory07zi10pIZrzrMdfb+TK7D/5/ekkk3E=;
  b=jXCIBLJ0CprDrxPryRX4zvJGj1eHLAuShSX3A7bjXHq8YeJN+aixHcex
   AnEy0m9Qgj0ezl+BAPhAWkAms7OXyUq0eeRn64dV6N2PMyc1PMxL5k/ji
   I8ZHKrDyek169+qkdzBOxwCdDIuQDsjy1+Dl6wbVdnhARwrwgClw1U1mk
   Kil+uXJtO/8MZdmlqjruAZ7fg5dd1VZ2jYNKdtlUQIC15wWsALqCanwkh
   E+WkqkvvsYrsYDH9qPALLgx91Px3ND9ac883j3PuGKBNzl69lJ0SKaAq3
   JS+gvbQ/Cbnyq7hDhTqrd4cF5nN4MyDQ+rdsW6g3hcA6c/Y0Agnzq369f
   Q==;
X-CSE-ConnectionGUID: ptLVxmOnToqBcq5NrDzOpQ==
X-CSE-MsgGUID: eD6FJokTTW+vKfnOUNtwmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="46934529"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="46934529"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:12:11 -0700
X-CSE-ConnectionGUID: WSsAyPekQsOO8ffbemVkxQ==
X-CSE-MsgGUID: 05Cn2qFhTC2p8CSp+gDplQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="80266713"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 24 Oct 2024 12:12:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C61727F7; Thu, 24 Oct 2024 22:12:01 +0300 (EEST)
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
Subject: [PATCH v3 15/24] iio: accel: kxcjk-1013: Replace a variant of iio_get_acpi_device_name_and_data()
Date: Thu, 24 Oct 2024 22:05:04 +0300
Message-ID: <20241024191200.229894-16-andriy.shevchenko@linux.intel.com>
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

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 38 ++++++++++------------------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index a8c73e401f95..e8074e0c59a4 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1466,26 +1466,6 @@ static irqreturn_t kxcjk1013_data_rdy_trig_poll(int irq, void *private)
 		return IRQ_HANDLED;
 }
 
-static const char *kxcjk1013_match_acpi_device(struct device *dev,
-					       const struct kx_chipset_info **info,
-					       const char **label)
-{
-	const struct acpi_device_id *id;
-
-	id = acpi_match_device(dev->driver->acpi_match_table, dev);
-	if (!id)
-		return NULL;
-
-	if (strcmp(id->id, "KIOX010A") == 0)
-		*label = "accel-display";
-	else if (strcmp(id->id, "KIOX020A") == 0)
-		*label = "accel-base";
-
-	*info = (const struct kx_chipset_info *)id->driver_data;
-
-	return dev_name(dev);
-}
-
 static int kxcjk1013_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
@@ -1493,6 +1473,7 @@ static int kxcjk1013_probe(struct i2c_client *client)
 	struct kxcjk1013_data *data;
 	struct iio_dev *indio_dev;
 	struct kxcjk_1013_platform_data *pdata;
+	const void *ddata;
 	const char *name;
 	int ret;
 
@@ -1535,15 +1516,18 @@ static int kxcjk1013_probe(struct i2c_client *client)
 	if (id) {
 		name = id->name;
 		data->info = (const struct kx_chipset_info *)(id->driver_data);
-	} else if (ACPI_HANDLE(&client->dev)) {
-		name = kxcjk1013_match_acpi_device(&client->dev, &data->info,
-						   &indio_dev->label);
-	} else
+	} else {
+		name = iio_get_acpi_device_name_and_data(&client->dev, &ddata);
+		if (name)
+			data->info = ddata;
+		if (data->info == &kxcj91008_kiox010a_info)
+			indio_dev->label = "accel-display";
+		else if (data->info == &kxcj91008_kiox020a_info)
+			indio_dev->label = "accel-base";
+	}
+	if (!name)
 		return -ENODEV;
 
-	if (!data->info)
-		return -EINVAL;
-
 	ret = kxcjk1013_chip_init(data);
 	if (ret < 0)
 		return ret;
-- 
2.43.0.rc1.1336.g36b5255a03ac


