Return-Path: <linux-iio+bounces-11004-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9E19ACE9B
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 17:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD181C244BB
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 15:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76271CCEF7;
	Wed, 23 Oct 2024 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HeCY1gOY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29A01C9EB0;
	Wed, 23 Oct 2024 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696956; cv=none; b=bEkbxWjMd48rtAZKLnhJ40aoL9iBFiBk6MENSTRgDilxn+h+/1vX/mkOEpRgabF96iVKY43FOSkpP4qb6IQmBMZN2yOShf8osNm5hkaLGpib1U7Epnn5a430fT7QFB1KoHPh4iYFMjfN0s5B6RyzoIH4Jp+0+YXEWmo0WJBmmHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696956; c=relaxed/simple;
	bh=9qK8YTmgDasaLPPVFFnxrZN3ShXslQGBdf4tUGHlt4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZQ4Ti84SFFi1sQmVCXNyjAWs6YmdvNNnPwvgsCm3Nr75rEgOx/Fa5+UtFI/2Zl9hSAt1bnxKZlo/6SvIIyplE5o2u6OW6uZVChS1FYQrYABmOVmqX8BL0O6qbcrvcg4uMXzR2VKltJ7UHCUYD3unFidcXAUTADlsqpiuYip+5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HeCY1gOY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729696955; x=1761232955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9qK8YTmgDasaLPPVFFnxrZN3ShXslQGBdf4tUGHlt4c=;
  b=HeCY1gOYtdig4wTsAgqATPtLSxDP72805NnRne/g+2uwDhTa9Mp6X7vz
   nIFU3pC5KBjG6cLE4xQN5ZmTxH3Ry6k+ZGKzW1XMEkyY8mF4gijAHpauC
   xHWobOMX+GU1REnM0KWnH+pAkFxRkEpSi3jupFi3vonG3AeLONVdtUCGk
   xQwiMDEvsId4IL9ErUBePJnvzemo8LjnTuqEmFy4PMqivjeIQF4BY3vc+
   PB+dmBzn1DZM9DjyFXujowG4iIKZIEGpcXRVT+XM2VW8QCsoAvQvK4oCR
   GmnJUG7XZjRurtFDCBhpCimHjQcWaO9tKtjvaToRtNZ+G+AmNp2QXqwPE
   w==;
X-CSE-ConnectionGUID: Ns+HoS9NQ528buwcVrG6+Q==
X-CSE-MsgGUID: ppfCN3nYQd6e2K8x08bfvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39841508"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39841508"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 08:21:56 -0700
X-CSE-ConnectionGUID: Bjtkx44jSJevyaLixdk9aw==
X-CSE-MsgGUID: w7IYGt4ITiqk85YE2Wg4CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="80430817"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 23 Oct 2024 08:21:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 141D35B8; Wed, 23 Oct 2024 18:21:49 +0300 (EEST)
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
Subject: [PATCH v1 09/13] iio: light: isl29018: Replace a variant of iio_get_acpi_device_name_and_data()
Date: Wed, 23 Oct 2024 18:17:32 +0300
Message-ID: <20241023152145.3564943-10-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/light/isl29018.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index 8dfc750e68c0..526ee5619d26 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -687,20 +687,6 @@ static const struct isl29018_chip_info isl29018_chip_info_tbl[] = {
 	},
 };
 
-static const char *isl29018_match_acpi_device(struct device *dev, int *data)
-{
-	const struct acpi_device_id *id;
-
-	id = acpi_match_device(dev->driver->acpi_match_table, dev);
-
-	if (!id)
-		return NULL;
-
-	*data = (int)id->driver_data;
-
-	return dev_name(dev);
-}
-
 static void isl29018_disable_regulator_action(void *_data)
 {
 	struct isl29018_chip *chip = _data;
@@ -716,9 +702,10 @@ static int isl29018_probe(struct i2c_client *client)
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct isl29018_chip *chip;
 	struct iio_dev *indio_dev;
+	const void *ddata;
+	const char *name;
+	int dev_id;
 	int err;
-	const char *name = NULL;
-	int dev_id = 0;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
 	if (!indio_dev)
@@ -731,11 +718,11 @@ static int isl29018_probe(struct i2c_client *client)
 	if (id) {
 		name = id->name;
 		dev_id = id->driver_data;
+	} else {
+		name = iio_get_acpi_device_name_and_data(&client->dev, &ddata);
+		dev_id = (intptr_t)ddata;
 	}
 
-	if (ACPI_HANDLE(&client->dev))
-		name = isl29018_match_acpi_device(&client->dev, &dev_id);
-
 	mutex_init(&chip->lock);
 
 	chip->type = dev_id;
-- 
2.43.0.rc1.1336.g36b5255a03ac


