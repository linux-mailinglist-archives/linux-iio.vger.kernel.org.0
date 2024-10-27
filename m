Return-Path: <linux-iio+bounces-11403-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B0E9B1F59
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 18:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F631C20EE3
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 17:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC988178CCA;
	Sun, 27 Oct 2024 17:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="k8aqnkw8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gUafitMw"
X-Original-To: linux-iio@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE14838F82;
	Sun, 27 Oct 2024 17:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730049709; cv=none; b=gnjr3DnY5nxK7ed60izbNArB5SdpPBz4X4I9jmkJ0QYoFbgEg1/Nwt36XbTjapcdnAFphzClTX+oSvfWKGel03p6BThgI5SsoXPkfwm4aTFapDM0O7vRe3cP+URNHdsslHaBMsiXfNhFBK+bsVitCiGAi8mHluuFT1DNfbvTYmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730049709; c=relaxed/simple;
	bh=Nsxs3CXHgYFu8qUUqadgrTXp6c1kCCUvahwZ69uwwKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3N1QkLthbtBEWdt8tXFlFoBc0iMZo0IHyWkC4d982+zmYlQV6+e+fSlGXm3Y0Hd8844AE/cADGhsam8giI9lFba5jIIOSIQ96GNq3cTYMAe9QtQl11+pRkKHHwqkjKiYO7Sq53ztV4Sqd2wfgxfzswikC9NaHcy87WHTEmfcjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=k8aqnkw8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gUafitMw; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3FB98254009C;
	Sun, 27 Oct 2024 13:21:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 27 Oct 2024 13:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1730049705; x=
	1730136105; bh=CwZceMBqTT2pEGup3sQN8Jo7JhDAcLQmyspij77zCCM=; b=k
	8aqnkw8/Bfg8uBo+L7WgmnQ67P0axF6zZzmHcPbU3auBgIXBcASVYWHpk7rA71S5
	TKn2s/h9+L2oeiphD6T1JcTlNRmR7SJmJcONBhSVtGtUeghMY7CIagLAPEpCHGhu
	tgr1G5R3hPjNt0Nk/49FizV2F6HCzo4meUNF2/HxrWSV3jFMNGwTJgsC+2AipdPw
	F21WY40AWp7Wtbs+8tzzcwneUckUlGoQsm8aiJi9ObcqzG/eR1FiDHsDkyhS4Nfk
	2HGyIGCUewbhSXua+C64ubvC1tj+7H17oyi7wmIXp4iRjd1YGoYvWxG/LHfI9kHj
	VD7qu3xguP7wyV4u6vxRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730049705; x=
	1730136105; bh=CwZceMBqTT2pEGup3sQN8Jo7JhDAcLQmyspij77zCCM=; b=g
	UafitMw+DI0xQFzHP5y2lAVwsp0oLOHCY6BNWNgHsIBwjd3yByN+Y4XeC98kaSYS
	BjIreVog7eIsLJBlMqToNwUq/7YSa3xD7JjQGB5FC7IBPzFRky4BvMzw7hZzw5XX
	p+ogaWsnKiSea0HHV/Ylbil81mWe7BkaehrhBiQtELC/+WW+1FQJYTSthOkYFhel
	/bq/F91oaMg36ILOGgdWNVpu8d1kOFVNFl00L2Hzw2ANdEIhzUlBMOvaUKEdWX3E
	ayQnaB9ZC26xail4agUzaHK16VfLocp8U+gzHj53zb9QMASt+xIxbDNEsXZxbJg8
	4RdwWAWbOIQLlCgUJwxbQ==
X-ME-Sender: <xms:qHYeZ92F_2ww0VvtQSsaZ4lDVk-tzmesV23g64BWW-TE5DygtTXGUQ>
    <xme:qHYeZ0GpwlBrDTMV3q2uXV7xJ2zhxKxno9DIzZ4JweD0Yys1isch2LcGxNHfBnOP2
    -MZJDq4kP9cgyaZaw>
X-ME-Received: <xmr:qHYeZ97OPqQ3u9HLHpXGyk3d-lrm12ubhPzjI3DG8GnqrsNUfAZo4yQp5b4uxRgQS4MK9NFwVXigWjw2GfwyU_2yCD45zcZ4muKYVROIdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejiedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpefluhhsthhinhcuhggvihhsshcuoehjuhhsthhinhesjhhushhtihhnfi
    gvihhsshdrtghomheqnecuggftrfgrthhtvghrnhepiefftddvgfdtvdeiteffudfhjedt
    feetleekgfetkeeggeffudeihfduieevjeeknecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepjhhushhtihhnsehjuhhsthhinhifvghishhsrdgt
    ohhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eplhgrnhiirghnohdrrghlvgigsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhitgdv
    feeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgrrhhssehmvghtrghfohhordguvg
    dprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihk
    odgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhn
    uhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepjhhushhtihhnsehjuhhsthhinhifvg
    hishhsrdgtohhmpdhrtghpthhtoheplhhinhhugidqihhiohesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:qHYeZ630JNqbVE7Q2g2Ky49h-ZOw0mGFlpYV6fxYcQDdxm59fFx12g>
    <xmx:qHYeZwFgT-fdDXbeEART-bYzy6tRZ0LaffyvNMcXvBiDBycDXk7J7g>
    <xmx:qHYeZ79i36ykwokklDk6yV5yvxB3B-URWsPb30w0Om-IEotCHiHvyg>
    <xmx:qHYeZ9k2hmqYmUkqFLoUXYmrSIwNEHjgArvQImaTMleTneJ2sP6j1Q>
    <xmx:qXYeZ0FLi08HarCizRwd9RYuV2-TQ-RxX_0IoiNV9hU1nXTZbJgf044F>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Oct 2024 13:21:43 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Justin Weiss <justin@justinweiss.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Philip=20M=C3=BCller?= <philm@manjaro.org>
Subject: [PATCH v4 1/4] iio: imu: bmi270: Add triggered buffer for Bosch BMI270 IMU
Date: Sun, 27 Oct 2024 10:20:22 -0700
Message-ID: <20241027172029.160134-2-justin@justinweiss.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241027172029.160134-1-justin@justinweiss.com>
References: <20241027172029.160134-1-justin@justinweiss.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set up a triggered buffer for the accel and angl_vel values.

Signed-off-by: Justin Weiss <justin@justinweiss.com>
---
 drivers/iio/imu/bmi270/Kconfig       |  1 +
 drivers/iio/imu/bmi270/bmi270.h      |  9 +++++
 drivers/iio/imu/bmi270/bmi270_core.c | 56 ++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/drivers/iio/imu/bmi270/Kconfig b/drivers/iio/imu/bmi270/Kconfig
index 0ffd29794fda..6362acc706da 100644
--- a/drivers/iio/imu/bmi270/Kconfig
+++ b/drivers/iio/imu/bmi270/Kconfig
@@ -6,6 +6,7 @@
 config BMI270
 	tristate
 	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 
 config BMI270_I2C
 	tristate "Bosch BMI270 I2C driver"
diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
index 93e5f387607b..6173be929bac 100644
--- a/drivers/iio/imu/bmi270/bmi270.h
+++ b/drivers/iio/imu/bmi270/bmi270.h
@@ -11,6 +11,15 @@ struct bmi270_data {
 	struct device *dev;
 	struct regmap *regmap;
 	const struct bmi270_chip_info *chip_info;
+
+	/*
+	 * Where IIO_DMA_MINALIGN may be larger than 8 bytes, align to
+	 * that to ensure a DMA safe buffer.
+	 */
+	struct {
+		__le16 channels[6];
+		aligned_s64 timestamp;
+	} data __aligned(IIO_DMA_MINALIGN);
 };
 
 struct bmi270_chip_info {
diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index 5f08d786fa21..1608cb2c8fb5 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -7,6 +7,8 @@
 #include <linux/regmap.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 #include "bmi270.h"
 
@@ -64,6 +66,17 @@ enum bmi270_scan {
 	BMI270_SCAN_GYRO_X,
 	BMI270_SCAN_GYRO_Y,
 	BMI270_SCAN_GYRO_Z,
+	BMI270_SCAN_TIMESTAMP,
+};
+
+static const unsigned long bmi270_avail_scan_masks[] = {
+	(BIT(BMI270_SCAN_ACCEL_X) |
+	 BIT(BMI270_SCAN_ACCEL_Y) |
+	 BIT(BMI270_SCAN_ACCEL_Z) |
+	 BIT(BMI270_SCAN_GYRO_X) |
+	 BIT(BMI270_SCAN_GYRO_Y) |
+	 BIT(BMI270_SCAN_GYRO_Z)),
+	0
 };
 
 const struct bmi270_chip_info bmi270_chip_info = {
@@ -73,6 +86,27 @@ const struct bmi270_chip_info bmi270_chip_info = {
 };
 EXPORT_SYMBOL_NS_GPL(bmi270_chip_info, IIO_BMI270);
 
+static irqreturn_t bmi270_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct bmi270_data *bmi270_device = iio_priv(indio_dev);
+	int ret;
+
+	ret = regmap_bulk_read(bmi270_device->regmap, BMI270_ACCEL_X_REG,
+			       &bmi270_device->data.channels,
+			       sizeof(bmi270_device->data.channels));
+
+	if (ret)
+		goto done;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &bmi270_device->data,
+					   pf->timestamp);
+done:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
 static int bmi270_get_data(struct bmi270_data *bmi270_device,
 			   int chan_type, int axis, int *val)
 {
@@ -128,6 +162,13 @@ static const struct iio_info bmi270_info = {
 	.modified = 1,						\
 	.channel2 = IIO_MOD_##_axis,				\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.scan_index = BMI270_SCAN_ACCEL_##_axis,		\
+	.scan_type = {						\
+		.sign = 's',					\
+		.realbits = 16,					\
+		.storagebits = 16,				\
+		.endianness = IIO_LE				\
+	},	                                                \
 }
 
 #define BMI270_ANG_VEL_CHANNEL(_axis) {				\
@@ -135,6 +176,13 @@ static const struct iio_info bmi270_info = {
 	.modified = 1,						\
 	.channel2 = IIO_MOD_##_axis,				\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.scan_index = BMI270_SCAN_GYRO_##_axis,			\
+	.scan_type = {						\
+		.sign = 's',					\
+		.realbits = 16,					\
+		.storagebits = 16,				\
+		.endianness = IIO_LE				\
+	},	                                                \
 }
 
 static const struct iio_chan_spec bmi270_channels[] = {
@@ -144,6 +192,7 @@ static const struct iio_chan_spec bmi270_channels[] = {
 	BMI270_ANG_VEL_CHANNEL(X),
 	BMI270_ANG_VEL_CHANNEL(Y),
 	BMI270_ANG_VEL_CHANNEL(Z),
+	IIO_CHAN_SOFT_TIMESTAMP(BMI270_SCAN_TIMESTAMP),
 };
 
 static int bmi270_validate_chip_id(struct bmi270_data *bmi270_device)
@@ -301,9 +350,16 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->channels = bmi270_channels;
 	indio_dev->num_channels = ARRAY_SIZE(bmi270_channels);
 	indio_dev->name = chip_info->name;
+	indio_dev->available_scan_masks = bmi270_avail_scan_masks;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmi270_info;
 
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      bmi270_trigger_handler, NULL);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(bmi270_core_probe, IIO_BMI270);
-- 
2.47.0


