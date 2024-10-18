Return-Path: <linux-iio+bounces-10754-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CFD9A4A2C
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 01:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 232DA1C21B14
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 23:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C631925AA;
	Fri, 18 Oct 2024 23:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="QwCnc2sD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ek89c0VS"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C655C1922D8;
	Fri, 18 Oct 2024 23:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729294720; cv=none; b=DY1xoPzUEqaHXUidxvODqDcKmyJ/qyJqfZun/e/8fyXnx55356sbMGkYLQD/Eu4o/MlCUn0/ZArvcDxUTs3e0ZZAzZb0l9BErgA+snOt4Pn7FV7heY02MnWo3DyVBybyWbsfKBcvdh6oGpTEhZMSLbo436Z9FgkXkBPEkd+n+FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729294720; c=relaxed/simple;
	bh=efEEDDEcwsl9RrrRrmM9w38qZUfKeTJkwV2M+yOy4MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vv8GEXC7eYq9SPssL4wG9UXjuMcf3hDx9RsEd6g9IfymFDH0w0+/QP06/9nPRJ4aSwI53TA1Aa7qGIAvbbNEvjwlvvWwQVunzUFxSBFbPH10hwYDperf0SnqPhefoyFlkV6vZ33E6dvzyuD2tm+sIQb9YB/7TwWnJN2MNcnng9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=QwCnc2sD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ek89c0VS; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id F3A95138027C;
	Fri, 18 Oct 2024 19:38:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 18 Oct 2024 19:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729294716; x=
	1729381116; bh=Lwz5amVvIkTFXl6lGJDlLiSiyJHjLWdvDvVr3n66PJo=; b=Q
	wCnc2sDUOPdsDB7YBQFGfSR04Wl8af1bqNVFLf0IruzsX+AlYetm63GPXUZmxR9d
	gcMZqvuk18VK7G4Jm/dv3awiW7Hs7HzzzC9ZIhHu8V2fzzt3F3F5lgOdULNdwylE
	EGbj2aTbglOc71keEq+b8MB2LSmk4ZcyHQg2HTSjOq1vqSRJXCqH29Eq5gqz+kUr
	hhY/7thSbxvR8dAq6+AwKLtx71J+ui6aF87CRRY64pINuCCBcUMNsKjbkz9tPsTO
	74zLR77emCIdBtNTIN+2qDHBWG9tgoCjasXN55CWgspLj5D+WHIvEeFqLkLfaeJ6
	5MbK4jPrPJb+Yb626n17Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729294716; x=
	1729381116; bh=Lwz5amVvIkTFXl6lGJDlLiSiyJHjLWdvDvVr3n66PJo=; b=e
	k89c0VSXQsG5Ycx6dwPvEGZUTYIzBlhRzDwPknCOahYFjYL3QpZhgms9eZ3envYb
	vY9zBUxcjj/Lw4V4n6ckWrjVa9mWAJWqs+2oIHwBA+TrU+hCbBMKAAimpV2iJRht
	xixpBDY5u/cEs5JJNHQoZAIqRAT52tF5Nf3jX7eiGeBKv4Yg1BX5yn+MoXfkekOL
	klqMtFyecZMRVR7Tt2UEEI8tbOLm1K0iIFNlh527hMhev1QE94PffCP+tVPpUw+V
	NVIbnbcVPl8Sgt2NcRx8wCQCwkPpNkFW5gi05bJOQ799W2G2GsDRu2lk9ihhCVld
	2qcvNTi8FRnIGGcSt7DyQ==
X-ME-Sender: <xms:fPESZ2yM-zkLvVKOlAJ_RpwkjsxWJ62ah01yKVlSG7MwK1cMhgCxEQ>
    <xme:fPESZyTuyRNax6lBBkKpxsB1x9GI25N7DBAcefXy4P3GRRuec-CwOzD-9zgyghknN
    xV5zYV3y0Ev2DDyDQ>
X-ME-Received: <xmr:fPESZ4UVf5Hm2HYl9iLJV_ZHURmOz83MMfUBRboqBVx5kz2Tyk8J4p4B6K05c8KMW2bkRpLpFxmz0c6bYCNeg-cbFlFgm34NyUpGmqf0tQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehgedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheplfhushhtihhnucghvghishhsuceojhhushhtihhnsehjuhhsthhinhifvg
    hishhsrdgtohhmqeenucggtffrrghtthgvrhhnpeeiffdtvdfgtddvieetffduhfejtdef
    teelkefgteekgeegffduiefhudeiveejkeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehjuhhsthhinhesjhhushhtihhnfigvihhsshdrtgho
    mhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hlrghniigrnhhordgrlhgvgiesghhmrghilhdrtghomhdprhgtphhtthhopehjihgtvdef
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrghrshesmhgvthgrfhhoohdruggvpd
    hrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdo
    ughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepjhhushhtihhnsehjuhhsthhinhifvghishhsrdgtohhm
    pdhrtghpthhtoheplhhinhhugidqihhiohesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fPESZ8gT8ZHeQojYHz32Pm8g6VxgGS57Yih-eddaOtf3ew8WY31-lw>
    <xmx:fPESZ4DgDqT8YFFhvL6HrtSE450_YODjIy9wrtq0qdYfmJ3e6Bz9Eg>
    <xmx:fPESZ9Iy765rMxuH-wFyZan84-wyB02-ALmw8O39c2VgsnyrjDiRdw>
    <xmx:fPESZ_DgtssjctQrtj1R6nu2foVoPHhE8WibFyiPKADKNas-QLkmzA>
    <xmx:fPESZ079nLqN-vQYKl0kMEexUXt6K-XNiynrlnbfvGa9_xvCFiUb2Gyc>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 19:38:35 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Justin Weiss <justin@justinweiss.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Philip=20M=C3=BCller?= <philm@manjaro.org>
Subject: [PATCH v2 4/6] iio: imu: bmi270: Add support for BMI260
Date: Fri, 18 Oct 2024 16:36:10 -0700
Message-ID: <20241018233723.28757-5-justin@justinweiss.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241018233723.28757-1-justin@justinweiss.com>
References: <20241018233723.28757-1-justin@justinweiss.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds support for the Bosch BMI260 6-axis IMU to the Bosch BMI270
driver. Setup and operation is nearly identical to the Bosch BMI270,
but has a different chip ID and requires different firmware.

Firmware is requested and loaded from userspace.

Signed-off-by: Justin Weiss <justin@justinweiss.com>
---
 drivers/iio/imu/bmi270/bmi270.h      |  1 +
 drivers/iio/imu/bmi270/bmi270_core.c | 25 +++++++++++++++++++++++--
 drivers/iio/imu/bmi270/bmi270_i2c.c  | 13 +++++++++++++
 drivers/iio/imu/bmi270/bmi270_spi.c  |  8 ++++++++
 4 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
index 2e8d85a4e419..51e374fd4290 100644
--- a/drivers/iio/imu/bmi270/bmi270.h
+++ b/drivers/iio/imu/bmi270/bmi270.h
@@ -14,6 +14,7 @@ struct bmi270_data {
 };
 
 enum bmi270_device_type {
+	BMI260,
 	BMI270,
 };
 
diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index 799df78ec862..b30201dc4e22 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -11,6 +11,8 @@
 #include "bmi270.h"
 
 #define BMI270_CHIP_ID_REG				0x00
+#define BMI160_CHIP_ID_VAL				0xD1
+#define BMI260_CHIP_ID_VAL				0x27
 #define BMI270_CHIP_ID_VAL				0x24
 #define BMI270_CHIP_ID_MSK				GENMASK(7, 0)
 
@@ -55,6 +57,7 @@
 #define BMI270_PWR_CTRL_ACCEL_EN_MSK			BIT(2)
 #define BMI270_PWR_CTRL_TEMP_EN_MSK			BIT(3)
 
+#define BMI260_INIT_DATA_FILE "bmi260-init-data.fw"
 #define BMI270_INIT_DATA_FILE "bmi270-init-data.fw"
 
 enum bmi270_scan {
@@ -67,6 +70,11 @@ enum bmi270_scan {
 };
 
 const struct bmi270_chip_info bmi270_chip_info[] = {
+	[BMI260] = {
+		.name = "bmi260",
+		.chip_id = BMI260_CHIP_ID_VAL,
+		.fw_name = BMI260_INIT_DATA_FILE,
+	},
 	[BMI270] = {
 		.name = "bmi270",
 		.chip_id = BMI270_CHIP_ID_VAL,
@@ -163,8 +171,21 @@ static int bmi270_validate_chip_id(struct bmi270_data *bmi270_device)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to read chip id");
 
-	if (chip_id != BMI270_CHIP_ID_VAL)
-		dev_info(dev, "Unknown chip id 0x%x", chip_id);
+	/*
+	 * Some manufacturers use "BMI0160" for both the BMI160 and
+	 * BMI260. If the device is actually a BMI160, the bmi160
+	 * driver should handle it and this driver should not.
+	 */
+	if (chip_id == BMI160_CHIP_ID_VAL)
+		return -ENODEV;
+
+	if (chip_id != bmi270_device->chip_info->chip_id)
+		dev_info(dev, "Unexpected chip id 0x%x", chip_id);
+
+	if (chip_id == BMI260_CHIP_ID_VAL)
+		bmi270_device->chip_info = &bmi270_chip_info[BMI260];
+	else if (chip_id == BMI270_CHIP_ID_VAL)
+		bmi270_device->chip_info = &bmi270_chip_info[BMI270];
 
 	return 0;
 }
diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
index 742149701849..d6417b7c799c 100644
--- a/drivers/iio/imu/bmi270/bmi270_i2c.c
+++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
@@ -33,11 +33,23 @@ static int bmi270_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id bmi270_i2c_id[] = {
+	{ "bmi260", (kernel_ulong_t)&bmi270_chip_info[BMI260] },
 	{ "bmi270", (kernel_ulong_t)&bmi270_chip_info[BMI270] },
 	{ }
 };
 
+static const struct acpi_device_id bmi270_acpi_match[] = {
+	/* OrangePi NEO */
+	{ "BMI0260",  (kernel_ulong_t)&bmi270_chip_info[BMI260] },
+	/* GPD Win Mini, Aya Neo AIR Pro, OXP Mini Pro, etc. */
+	{ "BMI0160",  (kernel_ulong_t)&bmi270_chip_info[BMI260] },
+	/* GPD Win Max 2 */
+	{ "10EC5280", (kernel_ulong_t)&bmi270_chip_info[BMI260] },
+	{ }
+};
+
 static const struct of_device_id bmi270_of_match[] = {
+	{ .compatible = "bosch,bmi260", .data = &bmi270_chip_info[BMI260] },
 	{ .compatible = "bosch,bmi270", .data = &bmi270_chip_info[BMI270] },
 	{ }
 };
@@ -45,6 +57,7 @@ static const struct of_device_id bmi270_of_match[] = {
 static struct i2c_driver bmi270_i2c_driver = {
 	.driver = {
 		.name = "bmi270_i2c",
+		.acpi_match_table = bmi270_acpi_match,
 		.of_match_table = bmi270_of_match,
 	},
 	.probe = bmi270_i2c_probe,
diff --git a/drivers/iio/imu/bmi270/bmi270_spi.c b/drivers/iio/imu/bmi270/bmi270_spi.c
index 3d240f9651bc..88173e9a3529 100644
--- a/drivers/iio/imu/bmi270/bmi270_spi.c
+++ b/drivers/iio/imu/bmi270/bmi270_spi.c
@@ -66,11 +66,18 @@ static int bmi270_spi_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id bmi270_spi_id[] = {
+	{ "bmi260", (kernel_ulong_t)&bmi270_chip_info[BMI260] },
 	{ "bmi270", (kernel_ulong_t)&bmi270_chip_info[BMI270] },
 	{ }
 };
 
+static const struct acpi_device_id bmi270_acpi_match[] = {
+	{ "BOSC0260",  (kernel_ulong_t)&bmi270_chip_info[BMI260] },
+	{ }
+};
+
 static const struct of_device_id bmi270_of_match[] = {
+	{ .compatible = "bosch,bmi260", .data = &bmi270_chip_info[BMI260] },
 	{ .compatible = "bosch,bmi270", .data = &bmi270_chip_info[BMI270] },
 	{ }
 };
@@ -78,6 +85,7 @@ static const struct of_device_id bmi270_of_match[] = {
 static struct spi_driver bmi270_spi_driver = {
 	.driver = {
 		.name = "bmi270",
+		.acpi_match_table = bmi270_acpi_match,
 		.of_match_table = bmi270_of_match,
 	},
 	.probe = bmi270_spi_probe,
-- 
2.47.0


