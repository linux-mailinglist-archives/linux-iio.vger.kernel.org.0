Return-Path: <linux-iio+bounces-11104-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390479AE588
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 15:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1AE1C219E8
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 13:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADAB1D9A46;
	Thu, 24 Oct 2024 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8dpvO54"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8001D89E4;
	Thu, 24 Oct 2024 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775074; cv=none; b=mqNfUGaQqb6ooffyVPbVlxsXoQEpCaRmYmkztWWafb1Fpxn2tCUsvn5BvZ4WiYCFVp2o8C8u8EorpO4jGOXWtbeMjHTQp9ySULBdsKey26CoOYE18Nw0s5bW9B5LxsczOA6YuHQKt56DGMZNVXQg12m38W9FFINK7naUxIOI75E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775074; c=relaxed/simple;
	bh=uf9btLtoClCOjF/hTMc4aLgnXwHw0svLKzR/oE7cpbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqCSbcX+s2SPjxXIH9d6kLD1X9hmbooRzy0m1Hl4KuI2SHwtbsFpUmS37K2rHMiF9FGkj1HlMZm7Uljup0bZKc+BU4GAzIgCbw4vFB5okYIPpWzfVagudDauy/SMdnKhfI97H4aiPjpHphaM/EUXITxUhu/WavfnNUfMWZTwSnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8dpvO54; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729775072; x=1761311072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uf9btLtoClCOjF/hTMc4aLgnXwHw0svLKzR/oE7cpbo=;
  b=l8dpvO540pDF2rMtTxOOk2MrNacMDua1zRFvSU/R870ASVpLRTAI+MUE
   s+7CG+/n5qmKJGkIuXElo0egR6OJm0k3aUVpmunnW5EYP3igxX1cL1T4j
   GQ4L2Q0iBnzG56Ay0mrAZu3lxeNcwBZM1Pf92PetS1wgrpiPOiEgSs9hR
   flLpPK43QJ5jvJG8x2JO3aS5fbwqvdOPqQqj215Sj6LvpUL8UN3nTks6w
   lfD8p04CrDyUbVX7kZ/EYZpEna1oUxlTx4B+d2yjuHI+7dePBieBBhgux
   zfqxCr7eceOa9MUnBWi8eqB3Zdyn+xOx1ppW55tOoYLOqFKLOW2H/fd8Z
   Q==;
X-CSE-ConnectionGUID: 9GZS6s1DTaiuSrQOL3lbmw==
X-CSE-MsgGUID: rT6+6DlOQ8KFEja8DLeMiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40795228"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="40795228"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 06:04:32 -0700
X-CSE-ConnectionGUID: Aslfd0SbSkWbImDdq2vs9w==
X-CSE-MsgGUID: Hf3D80zFREmQFKzMtYsCag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="103898631"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 24 Oct 2024 06:04:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4572C7A7; Thu, 24 Oct 2024 16:04:25 +0300 (EEST)
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
Subject: [PATCH v2 13/13] iio: light: ltr501: Replace a variant of iio_get_acpi_device_name_and_data()
Date: Thu, 24 Oct 2024 15:36:18 +0300
Message-ID: <20241024130424.3818291-14-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241024130424.3818291-1-andriy.shevchenko@linux.intel.com>
References: <20241024130424.3818291-1-andriy.shevchenko@linux.intel.com>
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


