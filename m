Return-Path: <linux-iio+bounces-10752-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C1F9A4A25
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 01:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B50CB22D77
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 23:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA854191F97;
	Fri, 18 Oct 2024 23:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="jif7WHSY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eJAVyMxE"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127D21917E8;
	Fri, 18 Oct 2024 23:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729294716; cv=none; b=nIv5AQvRflRkNHjUunjrtvx4zZYrPJ6Fy4rwUifTYfKs2Rk2kNOeC+FhFykjfxKF+eISub4LdF+EgaCXRPqwkwH79L/fpS68b68CGfLs31/el0SbBkJIOk+OuYhA8F23UbBSzq0LIBxQWz8vEs/viHrXGYti8wJhmMAhBXnYhio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729294716; c=relaxed/simple;
	bh=GDYZwPp3yvJIK3hOsOoF8vQ04kAvhZffTQjy6lXZLRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWK192/vXbjh6XzivhbB+tHk2c3OobfEazzNWb+rfCaO8TOeLCioLg3GJfwRA3ZGGv5Z1r0rphXh2f0rsOi4VLazAu56DlHPLUGSohpYKSJHId0yTmz1QDyh4yQ8aZB2JwOfNd8NInF4LTYJkebUI9ZRGuQK1HxSJ5yuuHWd414=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=jif7WHSY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eJAVyMxE; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 4001B138025E;
	Fri, 18 Oct 2024 19:38:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 18 Oct 2024 19:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729294713; x=
	1729381113; bh=6QboU7Q+vBowkys+BJ+Pi/7vS9E06Wbw+TGb24bDDNI=; b=j
	if7WHSYIU1uQqG8nWGMPFH7wU+TkpsQflejZRNr3VGdMhh5Ta1qwhqTGw0cF4Wau
	RecDDbaPGmx1NREW7rxdSgDZICWIr7D6hm7hvKYElGMCSMu7cD0KyzG9UCArxglk
	z2Ip4WdhozPQ9fPpDEZx69xSM820Br9kcMp5VgTa1GmIXxlztocx4hDU9UYSjJg1
	W1eb74HSTi+Y/HoaWviRl0N0KTfwhmJb55jfwEo1D0SOD6zhwLVg/BPdGVJ0M0dE
	X2fqvOPPSx5v0OdDcFdPchgyiYEvxLJZUdL/ABBMlm7gST8YgIEQyzCXjU8Pfvn4
	HUrhFGFkF+4a7NYGEiWiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729294713; x=
	1729381113; bh=6QboU7Q+vBowkys+BJ+Pi/7vS9E06Wbw+TGb24bDDNI=; b=e
	JAVyMxE/Ke8m4tB+dYYVPZqxSioeUNWE5NpHZhYKPsZh1gO12foEQV/ic6Xq3ku/
	SsOp6CuOCuYy1APp2iiLNzglcZMv2hv6iSQqkYBN/FR2CJ3ZeHxhtd3yqnOzLyZ+
	nLPDDJXvEjoqI/vsjsKMYWtcMYA6EYvlfPqddFjnD631o69r+Is0vIakWJFXtiyd
	+dkbKCU+ptKFMR9rYqA7GvHaV7xyGlt9Qlj9bw53bB0Uplz/MEPyR+dYNh9FQUAS
	gYoVojGoLSsAsSjUeDQeHtndU1+VjnryY+WNSNNa0tmxNiUq0A5ay4WyykPPjnHJ
	zm37ErMfn56sHGRKoDfEw==
X-ME-Sender: <xms:ePESZ_fJPLoAbbaWXf-SilpzO0O-umhZswHM5fkWEppV55EZgaphbQ>
    <xme:ePESZ1MEAJMdaqQqSZ1K0wK8Nvip8hnOJDqhYqRSJ9kVPQGdgtUNwPvksfel-ZpFh
    6GPQ4ASk3BA-kntUA>
X-ME-Received: <xmr:ePESZ4jByIj801_HJodGcmlqaQluls2lo1qOvuS1KCIreSodjSPwwkMBjXg0XpenmH_80JSKJValwkBDylX31PiCkaAWCOD3zBmBWPICEg>
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
X-ME-Proxy: <xmx:ePESZw8Dnjn9CvuJAFbREX9V8v3z7m-4BSCAydSj_FSh70XGYCiL2A>
    <xmx:ePESZ7uLHo-RUshBObXxSU2LDk9hmdcpRfsw1d0fmb0Mv-S-zm8jmQ>
    <xmx:ePESZ_Ec1tyF3wq-LEeb6LOFl9YphqY0cQW9voTwgzSvS03rDLSpaQ>
    <xmx:ePESZyNq9IMrXPEbmcfQ9tGKul8V3VAq7sOfUv6raMmvydlZNUmi2w>
    <xmx:efESZ0E5a0gSSO0vez-vNHNdfKwHF9440LfzVn5wo-_-T5myTSA9Onqs>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 19:38:31 -0400 (EDT)
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
Subject: [PATCH v2 2/6] iio: imu: bmi270: Provide chip info as configuration structure
Date: Fri, 18 Oct 2024 16:36:08 -0700
Message-ID: <20241018233723.28757-3-justin@justinweiss.com>
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

Prepare the bmi270 driver to support similar devices like the bmi260.

Signed-off-by: Justin Weiss <justin@justinweiss.com>
---
 drivers/iio/imu/bmi270/bmi270.h      | 15 ++++++++++++++-
 drivers/iio/imu/bmi270/bmi270_core.c | 18 +++++++++++++++---
 drivers/iio/imu/bmi270/bmi270_i2c.c  | 11 ++++++++---
 drivers/iio/imu/bmi270/bmi270_spi.c  | 11 ++++++++---
 4 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
index 8ac20ad7ee94..2e8d85a4e419 100644
--- a/drivers/iio/imu/bmi270/bmi270.h
+++ b/drivers/iio/imu/bmi270/bmi270.h
@@ -10,10 +10,23 @@ struct device;
 struct bmi270_data {
 	struct device *dev;
 	struct regmap *regmap;
+	const struct bmi270_chip_info *chip_info;
+};
+
+enum bmi270_device_type {
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
index 87036f352698..799df78ec862 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -66,6 +66,15 @@ enum bmi270_scan {
 	BMI270_SCAN_GYRO_Z,
 };
 
+const struct bmi270_chip_info bmi270_chip_info[] = {
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
@@ -187,7 +196,8 @@ static int bmi270_write_calibration_data(struct bmi270_data *bmi270_device)
 		return dev_err_probe(dev, ret,
 				     "Failed to prepare device to load init data");
 
-	ret = request_firmware(&init_data, BMI270_INIT_DATA_FILE, dev);
+	ret = request_firmware(&init_data,
+			       bmi270_device->chip_info->fw_name, dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to load init data file");
 
@@ -274,7 +284,8 @@ static int bmi270_chip_init(struct bmi270_data *bmi270_device)
 	return bmi270_configure_imu(bmi270_device);
 }
 
-int bmi270_core_probe(struct device *dev, struct regmap *regmap)
+int bmi270_core_probe(struct device *dev, struct regmap *regmap,
+		      const struct bmi270_chip_info *chip_info)
 {
 	int ret;
 	struct bmi270_data *bmi270_device;
@@ -287,6 +298,7 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap)
 	bmi270_device = iio_priv(indio_dev);
 	bmi270_device->dev = dev;
 	bmi270_device->regmap = regmap;
+	bmi270_device->chip_info = chip_info;
 
 	ret = bmi270_chip_init(bmi270_device);
 	if (ret)
@@ -294,7 +306,7 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap)
 
 	indio_dev->channels = bmi270_channels;
 	indio_dev->num_channels = ARRAY_SIZE(bmi270_channels);
-	indio_dev->name = "bmi270";
+	indio_dev->name = chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmi270_info;
 
diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
index e9025d22d5cc..742149701849 100644
--- a/drivers/iio/imu/bmi270/bmi270_i2c.c
+++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
@@ -18,22 +18,27 @@ static int bmi270_i2c_probe(struct i2c_client *client)
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
+	{ "bmi270", (kernel_ulong_t)&bmi270_chip_info[BMI270] },
 	{ }
 };
 
 static const struct of_device_id bmi270_of_match[] = {
-	{ .compatible = "bosch,bmi270" },
+	{ .compatible = "bosch,bmi270", .data = &bmi270_chip_info[BMI270] },
 	{ }
 };
 
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


