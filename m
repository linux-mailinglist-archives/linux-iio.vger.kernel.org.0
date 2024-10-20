Return-Path: <linux-iio+bounces-10832-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6BE9A572A
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 00:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2C31F220FD
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 22:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B790119924E;
	Sun, 20 Oct 2024 22:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="dv+yqjL4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oIg+pGtk"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D09E19923A;
	Sun, 20 Oct 2024 22:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729461689; cv=none; b=DTO9G5IEtL4/ReEnaPBXmO6hptrUAujFCWSTlyHDxduzufoKJ/Z4hsRNsUqGoN4A3DrsPTqRgr3OD91arXXmKeefoXcwcyzkVD7+w+J3ilYU22jjDb/vdGyamnijgUf2tARVu2izEvkyYPCqdJce1WcKVUXh/8r8Y7QbULKcCKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729461689; c=relaxed/simple;
	bh=DZ2bx7zJ032LMc6mL9mqFRpePhr64LSdUHo6or2i7tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuvMs1g6g9+h25mbMdX7OcqYXllqBnZ5tWzzKcwaHoYNMVB5Q5F3mThYZj3exQLgwUtK9zhX6hAmGF03+TI9e6zGMm2S73M4D06x0VEcCv9sZbQiKWnHF/Trfkgs+0CQFHzxvJTY5Cxe6LXWiMaFf6bbbFD2uJAIlm3XqBT1QD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=dv+yqjL4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oIg+pGtk; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 2D84111400A6;
	Sun, 20 Oct 2024 18:01:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 20 Oct 2024 18:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1729461686; x=
	1729548086; bh=iVqj9XZD2JsvGg/ibY285jQCG1X6rPsjya8e6dV1l68=; b=d
	v+yqjL4Gq4Y/o1fYSKAWz5PWmkA+paZaoFJgCB2P4HHuHIx3szZIR84dZ4HNbdYO
	O4pMoL03mOTni+MUUqGWPGb9kfJ897ZBuAhCwu3zEoLRho7vjUwuCyrlt/pYluOX
	+ABVj8JMs/y+R+LA8rPjj9aiHHSNhwQ7rENFkyJoVt3tNl3gzCTNI9/CEMRZAea8
	gOtDsx6AtgYdQZd/s97YVmmLJyxovxQ/VHbgdhuCY2FmmQzIpnsx2QyNYe/dXq/4
	mlZ6ue/iYclw6wqawCGTaK5cJw1y25zxZkjjhkrm7Zqc0G5IBXxEg3skfZK8VdAl
	qqHXQY4J1EWtFaEkA6BXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729461686; x=
	1729548086; bh=iVqj9XZD2JsvGg/ibY285jQCG1X6rPsjya8e6dV1l68=; b=o
	Ig+pGtkiSRKFutg+2JSLNyD4gacmI8A3XY31Ph7iw4cA8bPWJs+6YaxvR7ADr2GB
	2lzV0pU8ZnsOtKFWBxBvaJqCaLJKDD88YRn7WcLcYY2ab2vpFtIE4GojMkC7bnpj
	g2s4xIY+UuUmFs4eqqM1Uqg/I/g8XQLB395McpkP+0J0sv3417MeevmpYohB8/f5
	MY86vRQ9d+Gl+XizSt94d8fa+QO8hOyPKmR3lrDIjKx11JFRv3WHzdhdAPoJtN70
	xRKDPQv3ydihyLNd38urNoDjcQCabxMm42+uBSk6+sJmVJtNOuCnxYhGfhPFllIN
	QQifNSRUp1MtETN7w+qBA==
X-ME-Sender: <xms:tX0VZySTR6e_e-urcnRy1kSRafWETotRAOkrTalLc3nY-RYW5oXjlg>
    <xme:tX0VZ3wa0qw4ZK4sN3aJsMRbweUJF-dvOwlJuvNGFVoZCHYPadwnZ3RLHAibrN3VO
    ukSx2IYnNMU3094tg>
X-ME-Received: <xmr:tX0VZ_0G8UK01Ibb8tY_6uFgLnviwnau6up_XLbZEeXEFsDGKbLSQBNOROcqXkl5uIaUuv2Zqcfru-NUJ-mrmj3ofgyzH7pj2voMZAURQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehkedgtdeiucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:tX0VZ-CzBilUFP0xVvxHbZp2E4Uu6K4qhTYUr5kdLbUJFLBgIBO4Hg>
    <xmx:tX0VZ7iaOcy36xT9x5rK-DmTguOkg-JEyZilEYJDJJHxNYYvb5266Q>
    <xmx:tX0VZ6rMDmhHblQ8ebTts_jprgeo0u8EaeYj-2o4zp30u8Jg7WVGww>
    <xmx:tX0VZ-hxgyXXOn4pQdcrSh3_bqvvV1GoCsALFD5TaSDpv8mlkc8nQA>
    <xmx:tn0VZ0a8D9Ew6Q75P6XkhmPVROk5dstaOGh7xJ67XQEMDm0il0k0v9f3>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Oct 2024 18:01:24 -0400 (EDT)
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
Subject: [PATCH v3 4/6] iio: imu: bmi270: Add support for BMI260
Date: Sun, 20 Oct 2024 15:00:08 -0700
Message-ID: <20241020220011.212395-5-justin@justinweiss.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241020220011.212395-1-justin@justinweiss.com>
References: <20241020220011.212395-1-justin@justinweiss.com>
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
 drivers/iio/imu/bmi270/bmi270_core.c | 28 +++++++++++++++++++++++++++-
 drivers/iio/imu/bmi270/bmi270_i2c.c  | 13 +++++++++++++
 drivers/iio/imu/bmi270/bmi270_spi.c  |  8 ++++++++
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
index 93e5f387607b..d8f6d7cf47fc 100644
--- a/drivers/iio/imu/bmi270/bmi270.h
+++ b/drivers/iio/imu/bmi270/bmi270.h
@@ -20,6 +20,7 @@ struct bmi270_chip_info {
 };
 
 extern const struct regmap_config bmi270_regmap_config;
+extern const struct bmi270_chip_info bmi260_chip_info;
 extern const struct bmi270_chip_info bmi270_chip_info;
 
 int bmi270_core_probe(struct device *dev, struct regmap *regmap,
diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index 5f08d786fa21..24e45d6f0706 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -11,6 +11,11 @@
 #include "bmi270.h"
 
 #define BMI270_CHIP_ID_REG				0x00
+
+/* Used to prevent sending incompatible firmware to BMI160 devices */
+#define BMI160_CHIP_ID_VAL				0xD1
+
+#define BMI260_CHIP_ID_VAL				0x27
 #define BMI270_CHIP_ID_VAL				0x24
 #define BMI270_CHIP_ID_MSK				GENMASK(7, 0)
 
@@ -55,6 +60,7 @@
 #define BMI270_PWR_CTRL_ACCEL_EN_MSK			BIT(2)
 #define BMI270_PWR_CTRL_TEMP_EN_MSK			BIT(3)
 
+#define BMI260_INIT_DATA_FILE "bmi260-init-data.fw"
 #define BMI270_INIT_DATA_FILE "bmi270-init-data.fw"
 
 enum bmi270_scan {
@@ -66,6 +72,13 @@ enum bmi270_scan {
 	BMI270_SCAN_GYRO_Z,
 };
 
+const struct bmi270_chip_info bmi260_chip_info = {
+	.name = "bmi260",
+	.chip_id = BMI260_CHIP_ID_VAL,
+	.fw_name = BMI260_INIT_DATA_FILE,
+};
+EXPORT_SYMBOL_NS_GPL(bmi260_chip_info, IIO_BMI270);
+
 const struct bmi270_chip_info bmi270_chip_info = {
 	.name = "bmi270",
 	.chip_id = BMI270_CHIP_ID_VAL,
@@ -157,8 +170,21 @@ static int bmi270_validate_chip_id(struct bmi270_data *bmi270_device)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to read chip id");
 
+	/*
+	 * Some manufacturers use "BMI0160" for both the BMI160 and
+	 * BMI260. If the device is actually a BMI160, the bmi160
+	 * driver should handle it and this driver should not.
+	 */
+	if (chip_id == BMI160_CHIP_ID_VAL)
+		return -ENODEV;
+
 	if (chip_id != bmi270_device->chip_info->chip_id)
-		dev_info(dev, "Unknown chip id 0x%x", chip_id);
+		dev_info(dev, "Unexpected chip id 0x%x", chip_id);
+
+	if (chip_id == bmi260_chip_info.chip_id)
+		bmi270_device->chip_info = &bmi260_chip_info;
+	else if (chip_id == bmi270_chip_info.chip_id)
+		bmi270_device->chip_info = &bmi270_chip_info;
 
 	return 0;
 }
diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
index 394f27996059..3d0d8f3e8b63 100644
--- a/drivers/iio/imu/bmi270/bmi270_i2c.c
+++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
@@ -32,11 +32,23 @@ static int bmi270_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id bmi270_i2c_id[] = {
+	{ "bmi260", (kernel_ulong_t)&bmi260_chip_info },
 	{ "bmi270", (kernel_ulong_t)&bmi270_chip_info },
 	{ }
 };
 
+static const struct acpi_device_id bmi270_acpi_match[] = {
+	/* OrangePi NEO */
+	{ "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },
+	/* GPD Win Mini, Aya Neo AIR Pro, OXP Mini Pro, etc. */
+	{ "BMI0160",  (kernel_ulong_t)&bmi260_chip_info },
+	/* GPD Win Max 2 */
+	{ "10EC5280", (kernel_ulong_t)&bmi260_chip_info },
+	{ }
+};
+
 static const struct of_device_id bmi270_of_match[] = {
+	{ .compatible = "bosch,bmi260", .data = &bmi260_chip_info },
 	{ .compatible = "bosch,bmi270", .data = &bmi270_chip_info },
 	{ }
 };
@@ -44,6 +56,7 @@ static const struct of_device_id bmi270_of_match[] = {
 static struct i2c_driver bmi270_i2c_driver = {
 	.driver = {
 		.name = "bmi270_i2c",
+		.acpi_match_table = bmi270_acpi_match,
 		.of_match_table = bmi270_of_match,
 	},
 	.probe = bmi270_i2c_probe,
diff --git a/drivers/iio/imu/bmi270/bmi270_spi.c b/drivers/iio/imu/bmi270/bmi270_spi.c
index 7c2062c660d9..7f42ed74023b 100644
--- a/drivers/iio/imu/bmi270/bmi270_spi.c
+++ b/drivers/iio/imu/bmi270/bmi270_spi.c
@@ -65,11 +65,18 @@ static int bmi270_spi_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id bmi270_spi_id[] = {
+	{ "bmi260", (kernel_ulong_t)&bmi260_chip_info},
 	{ "bmi270", (kernel_ulong_t)&bmi270_chip_info },
 	{ }
 };
 
+static const struct acpi_device_id bmi270_acpi_match[] = {
+	{ "BOSC0260",  (kernel_ulong_t)&bmi260_chip_info },
+	{ }
+};
+
 static const struct of_device_id bmi270_of_match[] = {
+	{ .compatible = "bosch,bmi260", .data = &bmi260_chip_info },
 	{ .compatible = "bosch,bmi270", .data = &bmi270_chip_info },
 	{ }
 };
@@ -77,6 +84,7 @@ static const struct of_device_id bmi270_of_match[] = {
 static struct spi_driver bmi270_spi_driver = {
 	.driver = {
 		.name = "bmi270",
+		.acpi_match_table = bmi270_acpi_match,
 		.of_match_table = bmi270_of_match,
 	},
 	.probe = bmi270_spi_probe,
-- 
2.47.0


