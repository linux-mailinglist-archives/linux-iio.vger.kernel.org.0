Return-Path: <linux-iio+bounces-10830-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C686D9A5724
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 00:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72131C20D0D
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 22:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F4A1991B6;
	Sun, 20 Oct 2024 22:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="ESiEWVKg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hf3f9vEB"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978FA198A22;
	Sun, 20 Oct 2024 22:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729461684; cv=none; b=tiN1N8CcaYY0xECuNb9SPXJ8JJLeT6DhunN9UPCkifBSbpR5Mi0UfmDaAI4Lpg51f1aA+5QVSuZ8StW2bATYHWPvUv9kG3vOePZLJxfYY70zhK4N1NUf80kEtf7VXZVWwlGvDj058nDwO5qXdmOHepPbnk5ZUvAg6AqrR7+V7OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729461684; c=relaxed/simple;
	bh=ZlwpZiCAJw5Iw6r9ePBt0CKhMBO9B6wzTj3Q1YlBAY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KU45ZNR4q2uHxQea4AhMms2r4hqDKqH4e4t7gI6HLV7IAXklfYBrF8h+vzCNftju1QosQirC6KLbIXj1ulenze3Nms/uLnt/VWdPDIhe3CGNO/PRP3ftfMsLaMcibHJB18sJ/97ZMLzVjJDCUn5VN5Isxzrl3ZHcECCZKmahXq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=ESiEWVKg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hf3f9vEB; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5FD5C1140094;
	Sun, 20 Oct 2024 18:01:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 20 Oct 2024 18:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1729461681; x=
	1729548081; bh=ZdNJ9xpyp21teAdPDPuiOkx1UKnmhOQ6+MEcMCqD6n4=; b=E
	SiEWVKg63KQZMLsUYRbP1TLVALj2jSTOOTXjqWvt4kwiHHxi0DShJdzOoNzjZRqj
	hL21uxvnAO07p060/7DhrQMaZF14xrMnFVjqNARmBA/3UtvLWRrzMRVXCQbhZsRE
	P3LW9JiKC7D9n86QcCBwcLro6yHrlXjq80Ueob3OzQmMStrHlOQOMj52r31pbwA8
	Q6+UdT+/Z7XNSPTAOTscvsqxdcG6+4Hr2Nuyrvkb0qxMn+zlX3Yo23ccdVavrZ29
	8H90FptSeftRC9GEbcX7tSMQhckmsjQCbcROFvJdHFdwlja6RVVsRuoH5sia4fRR
	Iq4Ki8w3bqn5NqmwnC06A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729461681; x=
	1729548081; bh=ZdNJ9xpyp21teAdPDPuiOkx1UKnmhOQ6+MEcMCqD6n4=; b=H
	f3f9vEBPomiOcQbC45d86U7jnNEGJIUn1SI+MRRFV9Xpd1iBVhPu0jiFEFMYQ46w
	HEi02uUQQU74HnDwFI8wcW4MPLndaUW30OthWAXrr5WZSo9gUOG5t9Oe6HQRJZRE
	bEd1374lIq0RWPKH0m2lWfxBOf7Y7KllD/Ljy6jQv8vTBJpFsVJquqbRa3pjSPzS
	Oxb8XD7JF7z1gR0iSHZtQugpsZPd9KiAW/X1gzGn4U9MBZbeGSgPDcTgX0LIT9gp
	90QugDhtGZD8u4vtBv5kklTXM8Kley7SOL/jhqIK9QGj0Ws7K1Cy+JKUPB0TBuai
	JET7SGZgyT22S/12UHmRA==
X-ME-Sender: <xms:sX0VZ_NsQ-PHzDs2W94EcNLwOX8-TfkYAjd4pvO-PQ9TazttFC4IFQ>
    <xme:sX0VZ5_RkcnhYmrnO-yH1Ke_vNd8wBFTUvdE4cei5uwMy_4dF12VGyyPF7shWZIjH
    iHxeCnkBJZH7uO9Hg>
X-ME-Received: <xmr:sX0VZ-RyX-0CE84FbYBAJPBFdtmBzF3CEY3ZZtB5JumdFKZJgYZU-9HL9vaKo8ruQfkYI_8j3MZ-_5NoeT1Fi_85TUF8JiEVmHpzBdHBvA>
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
X-ME-Proxy: <xmx:sX0VZzsv8LlXXT7QUsu1B3HFEFS8xbKb2rqSy6PeSivzKkr9y7Nopg>
    <xmx:sX0VZ3fiWuZ8-6Pub_y1AlhQ4oh0pZbBniRMFDd7lkJWk-lDWVUsNQ>
    <xmx:sX0VZ_3ywzR-ApNLHXy5K8fOpx6MQmp5Qu9bngABCC-Q8ktXFzcypA>
    <xmx:sX0VZz9Vl134Nj3IeFC3PxKxufUnpvHIZwIMtcrvgl9EKiwjwwBgkA>
    <xmx:sX0VZ10jT9muUGNEgaZMP4X2ub-kG-z7XRvfCNiA5EqUPIUkwawU_WlH>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Oct 2024 18:01:19 -0400 (EDT)
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
Subject: [PATCH v3 2/6] iio: imu: bmi270: Provide chip info as configuration structure
Date: Sun, 20 Oct 2024 15:00:06 -0700
Message-ID: <20241020220011.212395-3-justin@justinweiss.com>
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

Prepare the bmi270 driver to support similar devices like the bmi260.

Signed-off-by: Justin Weiss <justin@justinweiss.com>
---
 drivers/iio/imu/bmi270/bmi270.h      | 11 ++++++++++-
 drivers/iio/imu/bmi270/bmi270_core.c | 18 ++++++++++++++----
 drivers/iio/imu/bmi270/bmi270_i2c.c  | 11 ++++++++---
 drivers/iio/imu/bmi270/bmi270_spi.c  | 11 ++++++++---
 4 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
index 8ac20ad7ee94..93e5f387607b 100644
--- a/drivers/iio/imu/bmi270/bmi270.h
+++ b/drivers/iio/imu/bmi270/bmi270.h
@@ -10,10 +10,19 @@ struct device;
 struct bmi270_data {
 	struct device *dev;
 	struct regmap *regmap;
+	const struct bmi270_chip_info *chip_info;
+};
+
+struct bmi270_chip_info {
+	const char *name;
+	int chip_id;
+	const char *fw_name;
 };
 
 extern const struct regmap_config bmi270_regmap_config;
+extern const struct bmi270_chip_info bmi270_chip_info;
 
-int bmi270_core_probe(struct device *dev, struct regmap *regmap);
+int bmi270_core_probe(struct device *dev, struct regmap *regmap,
+		      const struct bmi270_chip_info *chip_info);
 
 #endif  /* BMI270_H_ */
diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index e598c642178f..5f08d786fa21 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -66,6 +66,13 @@ enum bmi270_scan {
 	BMI270_SCAN_GYRO_Z,
 };
 
+const struct bmi270_chip_info bmi270_chip_info = {
+	.name = "bmi270",
+	.chip_id = BMI270_CHIP_ID_VAL,
+	.fw_name = BMI270_INIT_DATA_FILE,
+};
+EXPORT_SYMBOL_NS_GPL(bmi270_chip_info, IIO_BMI270);
+
 static int bmi270_get_data(struct bmi270_data *bmi270_device,
 			   int chan_type, int axis, int *val)
 {
@@ -150,7 +157,7 @@ static int bmi270_validate_chip_id(struct bmi270_data *bmi270_device)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to read chip id");
 
-	if (chip_id != BMI270_CHIP_ID_VAL)
+	if (chip_id != bmi270_device->chip_info->chip_id)
 		dev_info(dev, "Unknown chip id 0x%x", chip_id);
 
 	return 0;
@@ -183,7 +190,8 @@ static int bmi270_write_calibration_data(struct bmi270_data *bmi270_device)
 		return dev_err_probe(dev, ret,
 				     "Failed to prepare device to load init data");
 
-	ret = request_firmware(&init_data, BMI270_INIT_DATA_FILE, dev);
+	ret = request_firmware(&init_data,
+			       bmi270_device->chip_info->fw_name, dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to load init data file");
 
@@ -270,7 +278,8 @@ static int bmi270_chip_init(struct bmi270_data *bmi270_device)
 	return bmi270_configure_imu(bmi270_device);
 }
 
-int bmi270_core_probe(struct device *dev, struct regmap *regmap)
+int bmi270_core_probe(struct device *dev, struct regmap *regmap,
+		      const struct bmi270_chip_info *chip_info)
 {
 	int ret;
 	struct bmi270_data *bmi270_device;
@@ -283,6 +292,7 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap)
 	bmi270_device = iio_priv(indio_dev);
 	bmi270_device->dev = dev;
 	bmi270_device->regmap = regmap;
+	bmi270_device->chip_info = chip_info;
 
 	ret = bmi270_chip_init(bmi270_device);
 	if (ret)
@@ -290,7 +300,7 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap)
 
 	indio_dev->channels = bmi270_channels;
 	indio_dev->num_channels = ARRAY_SIZE(bmi270_channels);
-	indio_dev->name = "bmi270";
+	indio_dev->name = chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmi270_info;
 
diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
index d59161f23f9a..394f27996059 100644
--- a/drivers/iio/imu/bmi270/bmi270_i2c.c
+++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
@@ -17,22 +17,27 @@ static int bmi270_i2c_probe(struct i2c_client *client)
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
+	{ "bmi270", (kernel_ulong_t)&bmi270_chip_info },
 	{ }
 };
 
 static const struct of_device_id bmi270_of_match[] = {
-	{ .compatible = "bosch,bmi270" },
+	{ .compatible = "bosch,bmi270", .data = &bmi270_chip_info },
 	{ }
 };
 
diff --git a/drivers/iio/imu/bmi270/bmi270_spi.c b/drivers/iio/imu/bmi270/bmi270_spi.c
index b53784d4a1f4..7c2062c660d9 100644
--- a/drivers/iio/imu/bmi270/bmi270_spi.c
+++ b/drivers/iio/imu/bmi270/bmi270_spi.c
@@ -49,6 +49,11 @@ static int bmi270_spi_probe(struct spi_device *spi)
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
@@ -56,16 +61,16 @@ static int bmi270_spi_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(regmap),
 				     "Failed to init i2c regmap");
 
-	return bmi270_core_probe(dev, regmap);
+	return bmi270_core_probe(dev, regmap, chip_info);
 }
 
 static const struct spi_device_id bmi270_spi_id[] = {
-	{ "bmi270" },
+	{ "bmi270", (kernel_ulong_t)&bmi270_chip_info },
 	{ }
 };
 
 static const struct of_device_id bmi270_of_match[] = {
-	{ .compatible = "bosch,bmi270" },
+	{ .compatible = "bosch,bmi270", .data = &bmi270_chip_info },
 	{ }
 };
 
-- 
2.47.0


