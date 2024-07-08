Return-Path: <linux-iio+bounces-7433-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CD892A163
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 13:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08691B21679
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 11:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4197F7C7;
	Mon,  8 Jul 2024 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="oiAZ2L3B"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719367D08F;
	Mon,  8 Jul 2024 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720438969; cv=none; b=oipD5sik4CqZafagyz7i/A5rLZcMiltyP2OqM8avGLy6OtlSf8v92UZlqB+7UGFZh96gyc8UJFwG8fVGE8U941CgGhdjsNKtd0sEqYZWxNetXrk1FM20NqJrM0O0hw5FipFkdrR78MtBI/6G8g4EmEnJXmR8FGsFmjQO8ypYVX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720438969; c=relaxed/simple;
	bh=ZYh09gO8kyDIQPOgdCiUCd9hkBcYEAeEvQJvZq5PwIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGUOo4E1nPS2Pn5mxdkg37Y4YxczAjuIcP3JfP6QTwkXGrK6Dj4UnVSR5vJx+Nt2slj4vjZb9eabvP6DhWqdoV7DKO6p+eH4rXW0hAOPtJgoFVD3dN9ZEi1UdQ+Ai5sVHeYGTmEzn/IZimLDVmZ+tS7+MHFv6JRZmeQCO+Efh0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=oiAZ2L3B; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 31F19886EE;
	Mon,  8 Jul 2024 13:42:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720438965;
	bh=pH4+AyZwAkY/+g12+n1CI9KXGbcJwVm+VNEsrS4QAZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oiAZ2L3B1eU0HiK8TCCv+QeaqvKAdC/HTHPWDKyeUcEdju40yqPLeXlr/NPKcV/fx
	 AEP4h0VFpBofCL3ycnSekBWBykO5RhVi9ZYXu1cTXZPSUHy7wuHqB9EKnzuS6n4/FE
	 GnuL3qYxCgazqaTODvd45cD6vLNC0/nKhhZya8crWImsY03LWIepnr1gEA+dvNd4Pu
	 2xjxbJygkWLMUpFevD5xj0f04CjjjW+v7uZ4thlmoRQecFrLn8C2y9BboXDIL6u/xP
	 Mhc9/37uOS9higd6+G3oC0WMI5XoRdIeqOkqQ/9zR2ZzBowlPQS7iLcNOTUYi+YTJc
	 3thAdYD/axJEg==
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] iio: light: ltrf216a: Add LTR-308 support
Date: Mon,  8 Jul 2024 13:41:18 +0200
Message-ID: <20240708114227.18283-2-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708114227.18283-1-marex@denx.de>
References: <20240708114227.18283-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Add LiteOn LTR-308 support into LTR-F216A kernel driver.

The two devices seem to have almost identical register map, except that
the LTR-308 does not have three CLEAR_DATA registers, which are unused
by this driver. Furthermore, LTR-308 and LTR-F216A use different lux
calculation constants, 0.6 and 0.45 respectively. Both differences are
handled using chip info data.

https://optoelectronics.liteon.com/upload/download/DS86-2016-0027/LTR-308ALS_Final_%20DS_V1%201.pdf
https://optoelectronics.liteon.com/upload/download/DS86-2019-0016/LTR-F216A_Final_DS_V1.4.PDF

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Shreeya Patel <shreeya.patel@collabora.com>
Cc: devicetree@vger.kernel.org
Cc: linux-iio@vger.kernel.org
---
V2: - Make chip info static const
    - Document the missing registers as non-volatile
    - Retain "ltr,ltrf216a" until the discussion whether to drop it or
      not gets sorted out
---
 drivers/iio/light/ltrf216a.c | 53 +++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
index 68dc48420a886..bc8444516689e 100644
--- a/drivers/iio/light/ltrf216a.c
+++ b/drivers/iio/light/ltrf216a.c
@@ -68,6 +68,13 @@ static const int ltrf216a_int_time_reg[][2] = {
 	{  25, 0x40 },
 };
 
+struct ltr_chip_info {
+	/* Chip contains CLEAR_DATA_0/1/2 registers at offset 0xa..0xc */
+	bool		has_clear_data;
+	/* Lux calculation multiplier for ALS data */
+	int		lux_multiplier;
+};
+
 /*
  * Window Factor is needed when the device is under Window glass
  * with coated tinted ink. This is to compensate for the light loss
@@ -79,6 +86,7 @@ static const int ltrf216a_int_time_reg[][2] = {
 struct ltrf216a_data {
 	struct regmap *regmap;
 	struct i2c_client *client;
+	const struct ltr_chip_info *info;
 	u32 int_time;
 	u16 int_time_fac;
 	u8 als_gain_fac;
@@ -246,7 +254,7 @@ static int ltrf216a_get_lux(struct ltrf216a_data *data)
 
 	ltrf216a_set_power_state(data, false);
 
-	lux = greendata * 45 * LTRF216A_WIN_FAC;
+	lux = greendata * data->info->lux_multiplier * LTRF216A_WIN_FAC;
 
 	return lux;
 }
@@ -334,15 +342,15 @@ static const struct iio_info ltrf216a_info = {
 
 static bool ltrf216a_readable_reg(struct device *dev, unsigned int reg)
 {
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct ltrf216a_data *data = iio_priv(indio_dev);
+
 	switch (reg) {
 	case LTRF216A_MAIN_CTRL:
 	case LTRF216A_ALS_MEAS_RES:
 	case LTRF216A_ALS_GAIN:
 	case LTRF216A_PART_ID:
 	case LTRF216A_MAIN_STATUS:
-	case LTRF216A_ALS_CLEAR_DATA_0:
-	case LTRF216A_ALS_CLEAR_DATA_1:
-	case LTRF216A_ALS_CLEAR_DATA_2:
 	case LTRF216A_ALS_DATA_0:
 	case LTRF216A_ALS_DATA_1:
 	case LTRF216A_ALS_DATA_2:
@@ -355,6 +363,10 @@ static bool ltrf216a_readable_reg(struct device *dev, unsigned int reg)
 	case LTRF216A_ALS_THRES_LOW_1:
 	case LTRF216A_ALS_THRES_LOW_2:
 		return true;
+	case LTRF216A_ALS_CLEAR_DATA_0:
+	case LTRF216A_ALS_CLEAR_DATA_1:
+	case LTRF216A_ALS_CLEAR_DATA_2:
+		return data->info->has_clear_data;
 	default:
 		return false;
 	}
@@ -382,15 +394,23 @@ static bool ltrf216a_writable_reg(struct device *dev, unsigned int reg)
 
 static bool ltrf216a_volatile_reg(struct device *dev, unsigned int reg)
 {
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct ltrf216a_data *data = iio_priv(indio_dev);
+
 	switch (reg) {
 	case LTRF216A_MAIN_STATUS:
-	case LTRF216A_ALS_CLEAR_DATA_0:
-	case LTRF216A_ALS_CLEAR_DATA_1:
-	case LTRF216A_ALS_CLEAR_DATA_2:
 	case LTRF216A_ALS_DATA_0:
 	case LTRF216A_ALS_DATA_1:
 	case LTRF216A_ALS_DATA_2:
 		return true;
+	/*
+	 * If these registers are not present on a chip (like LTR-308),
+	 * the missing registers are not considered volatile.
+	 */
+	case LTRF216A_ALS_CLEAR_DATA_0:
+	case LTRF216A_ALS_CLEAR_DATA_1:
+	case LTRF216A_ALS_CLEAR_DATA_2:
+		return data->info->has_clear_data;
 	default:
 		return false;
 	}
@@ -433,6 +453,7 @@ static int ltrf216a_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
+	data->info = i2c_get_match_data(client);
 
 	mutex_init(&data->lock);
 
@@ -520,15 +541,27 @@ static int ltrf216a_runtime_resume(struct device *dev)
 static DEFINE_RUNTIME_DEV_PM_OPS(ltrf216a_pm_ops, ltrf216a_runtime_suspend,
 				 ltrf216a_runtime_resume, NULL);
 
+static const struct ltr_chip_info ltr308_chip_info = {
+	.has_clear_data		= false,
+	.lux_multiplier		= 60,
+};
+
+static const struct ltr_chip_info ltrf216a_chip_info = {
+	.has_clear_data		= true,
+	.lux_multiplier		= 45,
+};
+
 static const struct i2c_device_id ltrf216a_id[] = {
-	{ "ltrf216a" },
+	{ "ltr308", .driver_data = (kernel_ulong_t)&ltr308_chip_info },
+	{ "ltrf216a", .driver_data = (kernel_ulong_t)&ltrf216a_chip_info },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ltrf216a_id);
 
 static const struct of_device_id ltrf216a_of_match[] = {
-	{ .compatible = "liteon,ltrf216a" },
-	{ .compatible = "ltr,ltrf216a" },
+	{ .compatible = "liteon,ltr308", .data = &ltr308_chip_info },
+	{ .compatible = "liteon,ltrf216a", .data = &ltrf216a_chip_info },
+	{ .compatible = "ltr,ltrf216a", .data = &ltrf216a_chip_info },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ltrf216a_of_match);
-- 
2.43.0


