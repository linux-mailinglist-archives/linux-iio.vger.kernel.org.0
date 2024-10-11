Return-Path: <linux-iio+bounces-10462-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEDC99A7F9
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 17:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 505CAB23B70
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 15:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C015198E6D;
	Fri, 11 Oct 2024 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="Xq+f91GK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jRCj2Pqm"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C87194A70;
	Fri, 11 Oct 2024 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661102; cv=none; b=chZRbyrRE+D7aHB2kG8Wzs8x4sWURBUeLJUPgZnaeMAvma2NE9bC9akswdbcCX2a4b19JO8f3RNhIPeUtgqucUHE99gQU6CSouZidHeYgdf+nwUjKCVMYYlv85U6L2b/f4KrGUsWvnJBU7IRvyasBS6dC803we0zqdQd8O2JTgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661102; c=relaxed/simple;
	bh=Z6uBrdvSJ43EqogOegiG6Xcd5YZbpV5K4LXOn5qNKB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVd5c3UzVo19qsKT4G8RrxDaDJGi8sFGlbuJudgi+3xAfMdUuNgBKppxXfTVNi6x+c6Nzh5e46LrhykP2PtgYHIY0mKmLR4aLZd+x/RhAvWl1nuFCgVI95XTA2WqD4K/5mirQZUt4ltRk8+Lvgf9ft3TmnY3s6X1SaNV799lhfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=Xq+f91GK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jRCj2Pqm; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 4BBC91380213;
	Fri, 11 Oct 2024 11:38:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 11 Oct 2024 11:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1728661099; x=
	1728747499; bh=Ac+EBU0kzwQVqMurDpXKcoQ0wJQlhmrAdN2yUg+g31o=; b=X
	q+f91GKCkd24U2A3vDZKzXUUGQfzP+m3tHafBbilAx8e6nMlePW4zXxBqpOYkB97
	bFDdVEIkMcbCYbp3tFn/NiLJQLDpj575ZLqhoMzWTq1iNhBseJMUNOr9CPE/7kzJ
	0CfMl0kq65J0NtjHbaY/DjmRX4FWQwj/4RT6NYgjkhwAtxARG/n7mnaw2xUIKGFf
	pcnz1IGMNvi7WFEF74CrDg0k7Trs9/yX2Sj4lAgl1MYE/g2XsCzhxeAwfWi3FJOk
	PuYs2TrwbIbv5v2IAQaeWelKZKFKP/6oZzSqLyenifU+4ptJElWYqGsrVWbXP9U/
	670XL5kZq7ODt7eiGP2Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728661099; x=
	1728747499; bh=Ac+EBU0kzwQVqMurDpXKcoQ0wJQlhmrAdN2yUg+g31o=; b=j
	RCj2Pqmr4TaTIlIOVu9ZYFXDdAZ3KQBxSMNjnSgJGRcA2e5KgExy++b/MBqZyTDy
	vhXJeD12MF6J/TMeHfw+bF3IFNAaFcKWFiwuUEKfXjqNfm9ZAXd1PlkxeRoSNCwE
	xNvuXbf5HmA2skAebFb7fxtMw4W+HnIMPVWSgiZzHAcadzHr+1/orQrvWbxKvGGV
	oyCZzyopdb3u9mS1FMomStBRFvysQQW/X+dvojoiUhSdKufw6A/e+6Phs9Hy2/b8
	k1za8XUZGVcc7XqeiIFeQaueBY6PJWhtesX8xD0/QDkfx+HZr3iYlskwoR4hINjY
	LpLpED3q18Ou7dAo2+GnQ==
X-ME-Sender: <xms:a0YJZyRSU3-xIXIjwyb1S66Vpichs8KpFI1Oua-2SZVyE908PT969Q>
    <xme:a0YJZ3xtbEtFGgIvVcEm-leD4JRJYIuFxLf5AvQvRYK4QkDKutHy0sPL9c2EOHCLN
    448576YcSvxz12foQ>
X-ME-Received: <xmr:a0YJZ_1dOPWj_S1yRJcGeHSQ0NZvOGOWiEmILINjL5HQOFUPCdVeI4aLzoEZKLbdttLvblCZqUMClNNpWR3UMYBf9bkc5-o_nsSBhpFgZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheplfhushhtihhnucghvghishhsuceojhhushhtihhnsehjuhhsthhinhifvg
    hishhsrdgtohhmqeenucggtffrrghtthgvrhhnpeeiffdtvdfgtddvieetffduhfejtdef
    teelkefgteekgeegffduiefhudeiveejkeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehjuhhsthhinhesjhhushhtihhnfigvihhsshdrtgho
    mhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplh
    grnhiirghnohdrrghlvgigsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhitgdvfees
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgrrhhssehmvghtrghfohhordguvgdprh
    gtphhtthhopehjuhhsthhinhesjhhushhtihhnfigvihhsshdrtghomhdprhgtphhtthho
    pehlihhnuhigqdhiihhosehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    uggvrhgvkhhjohhhnhdrtghlrghrkhesghhmrghilhdrtghomhdprhgtphhtthhopehphh
    hilhhmsehmrghnjhgrrhhordhorhhg
X-ME-Proxy: <xmx:a0YJZ-C-kF3GTsOS1Uy9o7Tvo6njpV-M4raR1EXI4QI24NcsyHHMkA>
    <xmx:a0YJZ7hJ4lQuElMlVa0HU4d3xnYHUgjluz1ZRZDdhNmmMJGAIkejJA>
    <xmx:a0YJZ6pPG3nJjRQV_W4b0FMDDfpUC_t3f79_p73iNhOJQLDLJLraow>
    <xmx:a0YJZ-g4iWlk0PkU_4uVI9xmXUSq7YlFLK36hl2u3sPaVa1zbJ-MsQ>
    <xmx:a0YJZ8W_XmLG5y7t3MS2zqO0mlyadO9z1c-JwB8M_YqhA4Jwc2nNy_N5>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 11:38:18 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: Justin Weiss <justin@justinweiss.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Philip=20M=C3=BCller?= <philm@manjaro.org>
Subject: [PATCH 1/3] iio: imu: Add i2c driver for bmi260 imu
Date: Fri, 11 Oct 2024 08:37:47 -0700
Message-ID: <20241011153751.65152-2-justin@justinweiss.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241011153751.65152-1-justin@justinweiss.com>
References: <20241011153751.65152-1-justin@justinweiss.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds i2c support for the Bosch BMI260 6-axis IMU to the Bosch BMI270
driver. Setup and operation is nearly identical to the Bosch BMI270,
but has a different chip ID and requires different firmware.

Firmware is requested and loaded from userspace.

Signed-off-by: Justin Weiss <justin@justinweiss.com>
---
 drivers/iio/imu/bmi270/bmi270.h      | 16 ++++++++++++++-
 drivers/iio/imu/bmi270/bmi270_core.c | 29 +++++++++++++++++++++++-----
 drivers/iio/imu/bmi270/bmi270_i2c.c  | 22 ++++++++++++++++++---
 drivers/iio/imu/bmi270/bmi270_spi.c  | 11 ++++++++---
 4 files changed, 66 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
index 8ac20ad7ee94..51e374fd4290 100644
--- a/drivers/iio/imu/bmi270/bmi270.h
+++ b/drivers/iio/imu/bmi270/bmi270.h
@@ -10,10 +10,24 @@ struct device;
 struct bmi270_data {
 	struct device *dev;
 	struct regmap *regmap;
+	const struct bmi270_chip_info *chip_info;
+};
+
+enum bmi270_device_type {
+	BMI260,
+	BMI270,
+};
+
+struct bmi270_chip_info {
+	const char *name;
+	int chip_id;
+	const char *fw_name;
 };
 
 extern const struct regmap_config bmi270_regmap_config;
+extern const struct bmi270_chip_info bmi270_chip_info[];
 
-int bmi270_core_probe(struct device *dev, struct regmap *regmap);
+int bmi270_core_probe(struct device *dev, struct regmap *regmap,
+		      const struct bmi270_chip_info *chip_info);
 
 #endif  /* BMI270_H_ */
diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index aeda7c4228df..e5ee80c12166 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -11,6 +11,7 @@
 #include "bmi270.h"
 
 #define BMI270_CHIP_ID_REG				0x00
+#define BMI260_CHIP_ID_VAL				0x27
 #define BMI270_CHIP_ID_VAL				0x24
 #define BMI270_CHIP_ID_MSK				GENMASK(7, 0)
 
@@ -55,6 +56,7 @@
 #define BMI270_PWR_CTRL_ACCEL_EN_MSK			BIT(2)
 #define BMI270_PWR_CTRL_TEMP_EN_MSK			BIT(3)
 
+#define BMI260_INIT_DATA_FILE "bmi260-init-data.fw"
 #define BMI270_INIT_DATA_FILE "bmi270-init-data.fw"
 
 enum bmi270_scan {
@@ -66,6 +68,20 @@ enum bmi270_scan {
 	BMI270_SCAN_GYRO_Z,
 };
 
+const struct bmi270_chip_info bmi270_chip_info[] = {
+	[BMI260] = {
+		.name = "bmi260",
+		.chip_id = BMI260_CHIP_ID_VAL,
+		.fw_name = BMI260_INIT_DATA_FILE,
+	},
+	[BMI270] = {
+		.name = "bmi270",
+		.chip_id = BMI270_CHIP_ID_VAL,
+		.fw_name = BMI270_INIT_DATA_FILE,
+	}
+};
+EXPORT_SYMBOL_NS_GPL(bmi270_chip_info, IIO_BMI270);
+
 static int bmi270_get_data(struct bmi270_data *bmi270_device,
 			   int chan_type, int axis, int *val)
 {
@@ -154,8 +170,8 @@ static int bmi270_validate_chip_id(struct bmi270_data *bmi270_device)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to read chip id");
 
-	if (chip_id != BMI270_CHIP_ID_VAL)
-		dev_info(dev, "Unknown chip id 0x%x", chip_id);
+	if (chip_id != bmi270_device->chip_info->chip_id)
+		return dev_err_probe(dev, -ENODEV, "Unknown chip id 0x%x", chip_id);
 
 	return 0;
 }
@@ -187,7 +203,8 @@ static int bmi270_write_calibration_data(struct bmi270_data *bmi270_device)
 		return dev_err_probe(dev, ret,
 				     "Failed to prepare device to load init data");
 
-	ret = request_firmware(&init_data, BMI270_INIT_DATA_FILE, dev);
+	ret = request_firmware(&init_data,
+			       bmi270_device->chip_info->fw_name, dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to load init data file");
 
@@ -274,7 +291,8 @@ static int bmi270_chip_init(struct bmi270_data *bmi270_device)
 	return bmi270_configure_imu(bmi270_device);
 }
 
-int bmi270_core_probe(struct device *dev, struct regmap *regmap)
+int bmi270_core_probe(struct device *dev, struct regmap *regmap,
+		      const struct bmi270_chip_info *chip_info)
 {
 	int ret;
 	struct bmi270_data *bmi270_device;
@@ -287,6 +305,7 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap)
 	bmi270_device = iio_priv(indio_dev);
 	bmi270_device->dev = dev;
 	bmi270_device->regmap = regmap;
+	bmi270_device->chip_info = chip_info;
 
 	ret = bmi270_chip_init(bmi270_device);
 	if (ret)
@@ -294,7 +313,7 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap)
 
 	indio_dev->channels = bmi270_channels;
 	indio_dev->num_channels = ARRAY_SIZE(bmi270_channels);
-	indio_dev->name = "bmi270";
+	indio_dev->name = chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmi270_info;
 
diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
index e9025d22d5cc..c8c90666c76b 100644
--- a/drivers/iio/imu/bmi270/bmi270_i2c.c
+++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
@@ -18,28 +18,44 @@ static int bmi270_i2c_probe(struct i2c_client *client)
 {
 	struct regmap *regmap;
 	struct device *dev = &client->dev;
+	const struct bmi270_chip_info *chip_info;
+
+	chip_info = i2c_get_match_data(client);
+	if (!chip_info)
+		return -ENODEV;
 
 	regmap = devm_regmap_init_i2c(client, &bmi270_i2c_regmap_config);
 	if (IS_ERR(regmap))
 		return dev_err_probe(dev, PTR_ERR(regmap),
 				     "Failed to init i2c regmap");
 
-	return bmi270_core_probe(dev, regmap);
+	return bmi270_core_probe(dev, regmap, chip_info);
 }
 
 static const struct i2c_device_id bmi270_i2c_id[] = {
-	{ "bmi270", 0 },
+	{ "bmi260", (kernel_ulong_t)&bmi270_chip_info[BMI260] },
+	{ "bmi270", (kernel_ulong_t)&bmi270_chip_info[BMI270] },
 	{ }
 };
 
+static const struct acpi_device_id bmi270_acpi_match[] = {
+	{ "BOSC0260", (kernel_ulong_t)&bmi270_chip_info[BMI260] },
+	{ "BMI0260",  (kernel_ulong_t)&bmi270_chip_info[BMI260] },
+	{ "BOSC0160", (kernel_ulong_t)&bmi270_chip_info[BMI260] },
+	{ "BMI0160",  (kernel_ulong_t)&bmi270_chip_info[BMI260] },
+	{ "10EC5280", (kernel_ulong_t)&bmi270_chip_info[BMI260] },
+	{ },
+};
+
 static const struct of_device_id bmi270_of_match[] = {
-	{ .compatible = "bosch,bmi270" },
+	{ .compatible = "bosch,bmi270", .data = &bmi270_chip_info[BMI270] },
 	{ }
 };
 
 static struct i2c_driver bmi270_i2c_driver = {
 	.driver = {
 		.name = "bmi270_i2c",
+		.acpi_match_table = bmi270_acpi_match,
 		.of_match_table = bmi270_of_match,
 	},
 	.probe = bmi270_i2c_probe,
diff --git a/drivers/iio/imu/bmi270/bmi270_spi.c b/drivers/iio/imu/bmi270/bmi270_spi.c
index 34d5ba6273bb..3d240f9651bc 100644
--- a/drivers/iio/imu/bmi270/bmi270_spi.c
+++ b/drivers/iio/imu/bmi270/bmi270_spi.c
@@ -50,6 +50,11 @@ static int bmi270_spi_probe(struct spi_device *spi)
 {
 	struct regmap *regmap;
 	struct device *dev = &spi->dev;
+	const struct bmi270_chip_info *chip_info;
+
+	chip_info = spi_get_device_match_data(spi);
+	if (!chip_info)
+		return -ENODEV;
 
 	regmap = devm_regmap_init(dev, &bmi270_regmap_bus, dev,
 				  &bmi270_spi_regmap_config);
@@ -57,16 +62,16 @@ static int bmi270_spi_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(regmap),
 				     "Failed to init i2c regmap");
 
-	return bmi270_core_probe(dev, regmap);
+	return bmi270_core_probe(dev, regmap, chip_info);
 }
 
 static const struct spi_device_id bmi270_spi_id[] = {
-	{ "bmi270" },
+	{ "bmi270", (kernel_ulong_t)&bmi270_chip_info[BMI270] },
 	{ }
 };
 
 static const struct of_device_id bmi270_of_match[] = {
-	{ .compatible = "bosch,bmi270" },
+	{ .compatible = "bosch,bmi270", .data = &bmi270_chip_info[BMI270] },
 	{ }
 };
 
-- 
2.47.0


