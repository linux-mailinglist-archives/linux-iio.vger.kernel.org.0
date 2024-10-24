Return-Path: <linux-iio+bounces-11112-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA0A9AE59C
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 15:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18517B2479D
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 13:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D871E2619;
	Thu, 24 Oct 2024 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f6IJIrbG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9096F1DE2AC;
	Thu, 24 Oct 2024 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775087; cv=none; b=eVeDhO0/PgxzR1frD0clB4jlbSmxeaBVBXhlTl08ZNassZgyII+Ja7lFeIT8pPaNTSwWFEcE2ipJFKniZn5KbMLziNu7deUNazt4UyYs6bt/U8dTlJsMHlus5PKOM/qwqvYwv5+NApL9atJKMRNK6LFXvxJ44bwDJOQutS6O2rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775087; c=relaxed/simple;
	bh=7VD/YZ3dxyXfp5F1cccl2DO7mfRb7DzapOk2MWXOIuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dn0BbIFv0zZ82G89TMhy6iR3sTb7Ahb0CtEH1/7sSq29DYDjJdDRQqLjVliSbtpQAcVGImgTBmTmaKQP+QtLFx0iS42ANVrMqyfnC/y1p9jxZIgGW7/YNL91fD7LLqX8i9D9Y77LjqPg64GaVyUOX87bKxouP+u97TohgSRKo1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f6IJIrbG; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729775086; x=1761311086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7VD/YZ3dxyXfp5F1cccl2DO7mfRb7DzapOk2MWXOIuI=;
  b=f6IJIrbG54uZNXsHs7a2aNlGs137jzo8Jydn0jitVx49NoNLoZOPuxAb
   v/mQU3BhQm3llEcmNNGYIOpqhedX7Wv2rnGFpFORsxZ5iyTAxi+st4WJx
   f4yvFSmI90lrWZZ9bWMi+mje9ngGj06ygzIlpWnT0iO0Ze+PFnjLHJWCC
   uIY30Rrsmz1BGVJyzooT9ySiTjUZgvDiQ6xcQNxXOyFFySrdGrprvEpFK
   iAPMnQuqxfkoSwdLOSAH4PWlTEy4e6c0KFlhY1sIEPsODR5oUV8ZHNeM9
   0EonFCVIOxog7NErXJDAQ1OQv8Gj3iaR65SQj7bRYOriAlWFi+vSUB8Hz
   g==;
X-CSE-ConnectionGUID: n2j918/1Tr2vPMwSJaqJCQ==
X-CSE-MsgGUID: 8C7lo0T1RTyt3HevTjveVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="54802816"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="54802816"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 06:04:32 -0700
X-CSE-ConnectionGUID: Z9saZD1/QsKLdNGplz/99Q==
X-CSE-MsgGUID: TybJP+20ScefkZkLOo56Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80238787"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 24 Oct 2024 06:04:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1656C644; Thu, 24 Oct 2024 16:04:25 +0300 (EEST)
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
Subject: [PATCH v2 08/13] iio: gyro: bmg160: Replace custom implementation of iio_get_acpi_device_name()
Date: Thu, 24 Oct 2024 15:36:13 +0300
Message-ID: <20241024130424.3818291-9-andriy.shevchenko@linux.intel.com>
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


