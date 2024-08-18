Return-Path: <linux-iio+bounces-8579-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F9B955FEE
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 00:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6681C20E8C
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2024 22:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B63158A18;
	Sun, 18 Aug 2024 22:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="DICxbbHB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3D515665C;
	Sun, 18 Aug 2024 22:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724020193; cv=none; b=qxCQx8kBJ3OWI2AdDVu2Ndl+o6D+tkws0Zs/MKGO+ppmheBbgf4Jm7hMzsxlMsaw7OgJdy7KLIF+CT9GpS+1B/+wxGJwq0HNTNXZuyqUzXPbsoqOWU36jb7Egjxk4yuCGaLLLaVNNMsfFwk+kId44ajXBEWB/lUR+tLksWErnP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724020193; c=relaxed/simple;
	bh=erR3YXfyR6YYacA2NXu2UfVsRMEtFUNDbmujbsNttnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TGGghUoazxKPdCXadvb9qJD3t4c4Wl1lhuavvmTi5o+FA/Qo3bRVdC6oy8InxENyxW3zbUrjavQeUgjTAQ6xfoeC1wDfmDV3Sb/x4EOFG6+6bI1vkBAJxIpnF3VRU/ZG3b8ixXDKMxU+7sVjRlq6uwLPhr//aIJ6kwER9Ba3ZZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=DICxbbHB; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.130] (BC24970D.unconfigured.pool.telekom.hu [188.36.151.13])
	by mail.mainlining.org (Postfix) with ESMTPSA id F33E6E44FA;
	Sun, 18 Aug 2024 22:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1724020183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AuAB+Yyk0IY0gR/o8Nr+b5iFRu32YIFGK3pitiqJ894=;
	b=DICxbbHBbKioUGdouPLAMZ6dtuX1xbGvRxmdrR+ZLk3nQavVUoETebbI78JlJMci+l3ZsS
	ujNpznX7yMbWbYhwCOg4BwM6iVxaWJbJojWDP940LBT25fuJ/woMbKxqlxAZxOof5B4ESO
	kxCurm3Qqi5XeUhTmSFkKWv8x8Vd1CVmXt4E39CZu7mRqeF9UAlupM1FzZs7dGh5OaMigG
	qzGyI4iyn8gTZRQmUvoOELc+a7iiATrD3owiLGewcmcsJK1qZTJsf9Zur/pDmsglVKXcVR
	qpCz/UrWOOycT3rpqcFw1wA3Ps4S9dHDpDXPaDi7C+iteApoUm9fcobfXOpA1Q==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Mon, 19 Aug 2024 00:29:42 +0200
Subject: [PATCH v4 4/4] iio: magnetometer: ak8975: Add AK09118 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240819-ak09918-v4-4-f0734d14cfb9@mainlining.org>
References: <20240819-ak09918-v4-0-f0734d14cfb9@mainlining.org>
In-Reply-To: <20240819-ak09918-v4-0-f0734d14cfb9@mainlining.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Albrieux <jonathan.albrieux@gmail.com>, 
 Gwendal Grignou <gwendal@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux@mainlining.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724020180; l=3929;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=jH94zmHYohaHlsfuauJez36FEmmQ91Sz43Wv2cI6eTA=;
 b=+aAgFedlGGJ0qjoP2fysKXe821fhndg/kj6phLDhZC0tHH3mRc9BEVx3l2IyjR0sSTlD3QEKi
 3HKM7ROp0XhDQqz9kNu5gnO0tc9ZWKUBqO2QAiSlRTJyYRTiG4CU7sq
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

From: Danila Tikhonov <danila@jiaxyga.com>

Add additional AK09118 to the magnetometer driver which has the same
register mapping and scaling as the AK09112 device.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 drivers/iio/magnetometer/Kconfig  |  2 +-
 drivers/iio/magnetometer/ak8975.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index cd2917d71904..8eb718f5e50f 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -39,7 +39,7 @@ config AK8975
 	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Asahi Kasei AK8975, AK8963,
-	  AK09911, AK09912 or AK09916 3-Axis Magnetometer.
+	  AK09911, AK09912, AK09916 or AK09918 3-Axis Magnetometer.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called ak8975.
diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 2fa6721aa66f..0eb0da9d6787 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -78,6 +78,7 @@
  */
 #define AK09912_REG_WIA1		0x00
 #define AK09912_REG_WIA2		0x01
+#define AK09918_DEVICE_ID		0x0C
 #define AK09916_DEVICE_ID		0x09
 #define AK09912_DEVICE_ID		0x04
 #define AK09911_DEVICE_ID		0x05
@@ -209,6 +210,7 @@ enum asahi_compass_chipset {
 	AK09911,
 	AK09912,
 	AK09916,
+	AK09918,
 };
 
 enum ak_ctrl_reg_addr {
@@ -371,6 +373,34 @@ static const struct ak_def ak_def_array[] = {
 			AK09912_REG_HXL,
 			AK09912_REG_HYL,
 			AK09912_REG_HZL},
+	},
+	[AK09918] = {
+		/* ak09918 is register compatible with ak09912 this is for avoid
+		 * unknown id messages.
+		 */
+		.type = AK09918,
+		.raw_to_gauss = ak09912_raw_to_gauss,
+		.range = 32752,
+		.ctrl_regs = {
+			AK09912_REG_ST1,
+			AK09912_REG_ST2,
+			AK09912_REG_CNTL2,
+			AK09912_REG_ASAX,
+			AK09912_MAX_REGS},
+		.ctrl_masks = {
+			AK09912_REG_ST1_DRDY_MASK,
+			AK09912_REG_ST2_HOFL_MASK,
+			0,
+			AK09912_REG_CNTL2_MODE_MASK},
+		.ctrl_modes = {
+			AK09912_REG_CNTL_MODE_POWER_DOWN,
+			AK09912_REG_CNTL_MODE_ONCE,
+			AK09912_REG_CNTL_MODE_SELF_TEST,
+			AK09912_REG_CNTL_MODE_FUSE_ROM},
+		.data_regs = {
+			AK09912_REG_HXL,
+			AK09912_REG_HYL,
+			AK09912_REG_HZL},
 	}
 };
 
@@ -452,6 +482,7 @@ static int ak8975_who_i_am(struct i2c_client *client,
 	/*
 	 * Signature for each device:
 	 * Device   |  WIA1      |  WIA2
+	 * AK09918  |  DEVICE_ID_|  AK09918_DEVICE_ID
 	 * AK09916  |  DEVICE_ID_|  AK09916_DEVICE_ID
 	 * AK09912  |  DEVICE_ID |  AK09912_DEVICE_ID
 	 * AK09911  |  DEVICE_ID |  AK09911_DEVICE_ID
@@ -484,6 +515,10 @@ static int ak8975_who_i_am(struct i2c_client *client,
 		if (wia_val[1] == AK09916_DEVICE_ID)
 			return 0;
 		break;
+	case AK09918:
+		if (wia_val[1] == AK09918_DEVICE_ID)
+			return 0;
+		break;
 	}
 
 	dev_info(&client->dev, "Device ID %x is unknown.\n", wia_val[1]);
@@ -1070,6 +1105,7 @@ static const struct i2c_device_id ak8975_id[] = {
 	{"ak09911", (kernel_ulong_t)&ak_def_array[AK09911] },
 	{"ak09912", (kernel_ulong_t)&ak_def_array[AK09912] },
 	{"ak09916", (kernel_ulong_t)&ak_def_array[AK09916] },
+	{"ak09918", (kernel_ulong_t)&ak_def_array[AK09918] },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ak8975_id);
@@ -1084,6 +1120,7 @@ static const struct of_device_id ak8975_of_match[] = {
 	{ .compatible = "asahi-kasei,ak09912", .data = &ak_def_array[AK09912] },
 	{ .compatible = "ak09912", .data = &ak_def_array[AK09912] },
 	{ .compatible = "asahi-kasei,ak09916", .data = &ak_def_array[AK09916] },
+	{ .compatible = "asahi-kasei,ak09918", .data = &ak_def_array[AK09918] },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ak8975_of_match);

-- 
2.46.0


