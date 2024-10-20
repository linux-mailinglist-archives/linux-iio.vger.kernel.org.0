Return-Path: <linux-iio+bounces-10833-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7870F9A572D
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 00:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8C01B22445
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 22:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E987F199EA8;
	Sun, 20 Oct 2024 22:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="p1LYkbyp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZIkPC6Kx"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886D81993BA;
	Sun, 20 Oct 2024 22:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729461691; cv=none; b=NXBvGhjiHrfkcu51SmQWZAohMRGMOJF6/Jt6z6yQWMslEPSpJEW3fSPcpQvuDXMpiEih1JKSCgACku84L0tLO7fSZ8l1QnUMC2cZQgu0vZgAgOxeKQ8L86sm8PmHuIGDLqw/Z75vlYGMELeqlJpfPIKIhIhm0yVPtfLeD77X+zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729461691; c=relaxed/simple;
	bh=CxNCSF8NoJCOEhg4BM8L5ZjwqS4AkGsSGeH5dxRmZvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDy2hdqYLjTflhSLKjoxZjks5A1IWie7ERNGbSE1aJ15/ow2DzsHijco8kPZzV/KSBgwyqiW4tuof2XQT1tQ+YHaAFw3bzqp8kYEzoJAmcab+HYgxCbVATMonc/XkO7CLY3hBq7YZ8xYDA24h2NBbRxmARZYKT4iK8hpmpg3mDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=p1LYkbyp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZIkPC6Kx; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5DD6D114008E;
	Sun, 20 Oct 2024 18:01:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 20 Oct 2024 18:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1729461688; x=
	1729548088; bh=v7JdK+EfV4NU1+GpmRFSjPS2tNauAbxiLGo8QCU/BU0=; b=p
	1LYkbyprI8+dTsKrO6SlUlPdRY/HJvY4lZtCIiqWP9TCeir5HcQzwyE+ABrYDk4f
	j+Gjxi6Z7IoAZpMVHbL5Xyxe1ybG1REa3swQ68rNYWdjXBL84eGNIhDI0OWKAUXJ
	pePIFUW1k0pQvI/Ytq/ONvYtie9Rb0pH+eN16ewUDrnFuQjIREgS4YBt8X48VLxe
	zTLzvdenBWjYngUBpF93HkM8edhCx/XphQ5L9Vfy2FSoHbefPl+MKXqKYKTDsg8/
	OYHqfBQ35vhsPIA6c/2K89+q6b9Q5RRJDmPlOe4tIUodJyKu5r1ck54+0E98tyDa
	dl1sBOXpV+t4Lv294yauA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729461688; x=
	1729548088; bh=v7JdK+EfV4NU1+GpmRFSjPS2tNauAbxiLGo8QCU/BU0=; b=Z
	IkPC6Kxf7o3hFYGTE/SKMKvh/fgpbiFf0eJxaAn3T6L2Pa0rVuEl0u+UrXbYZTst
	QEnKnv6VL2gXc05BRc5h4Ic7D50sVE1sn21YlhEqUHULfCTJdU3WKKqg6AXsHjzG
	YR2oaRZercwUmAizbzW7U5Zdd+f590xs6qLWaGRzb/yNrobz/ouphpjMKE/ZZJec
	CW0VEef6EpmYdsr8nFhDCPsD5cCgJp7ao9DXE6zCRizY4uBtnKEir4c/kYalCZPL
	Ew9zirUlSLrWLrXd0YzP9JlhaEzqEKl1RdJNZ1msjyKgV1k0wcOE3paa8UTbSIHQ
	l4Ix1UdRjw2fRZv5v6CiA==
X-ME-Sender: <xms:uH0VZ3-Pf2UBuN03VDV4a1oVVNz9hAnOv6-bwMr7dUw2a_gyYIBjBg>
    <xme:uH0VZztPRoXutm9WshIAtSV4zotG9d5lxGpCNVDH1FekxhDmdr865kbbO4SnDJvJ9
    5ESgs0Tqj8qSk5mZQ>
X-ME-Received: <xmr:uH0VZ1AW4xVnzFMlcelsowEQ8UgG3AZ8o08Hhad7Dt4puOEliykHvmibeOcvQbAKRqYSWFR9d6RlYiWKF4__hutZar8mie4BG0QNP90O9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehkedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheplfhushhtihhnucghvghishhsuceojhhushhtihhnsehjuhhsthhinhifvg
    hishhsrdgtohhmqeenucggtffrrghtthgvrhhnpeeiffdtvdfgtddvieetffduhfejtdef
    teelkefgteekgeegffduiefhudeiveejkeenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehjuhhsthhinhesjhhushhtihhnfigvihhsshdrtgho
    mhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hlrghniigrnhhordgrlhgvgiesghhmrghilhdrtghomhdprhgtphhtthhopehjihgtvdef
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrghrshesmhgvthgrfhhoohdruggvpd
    hrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdo
    ughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepjhhushhtihhnsehjuhhsthhinhifvghishhsrdgtohhm
    pdhrtghpthhtoheplhhinhhugidqihhiohesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:uH0VZzfMX459R0au3XUvrmQnLV6sI4IGeZqY5SnAKeSryjr1gVbolA>
    <xmx:uH0VZ8MhO-HRSUdljsjS1zDSixkEjOfNgTIc0DyUH3KkgrM9Zhbf8w>
    <xmx:uH0VZ1kuLcEcXXgoPgyQpJhanP1w7dMFvkJjPurp63WtMo0ZKzOtqg>
    <xmx:uH0VZ2tDijI20xba0PRmNfxNBRATRO6Wdfr42rgoFZ71nTL2qwxAOw>
    <xmx:uH0VZ4n0yTy4KjR85LZN68U2sffhaC0CmNbPH23VRNKbvIyoRlckV2VZ>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Oct 2024 18:01:26 -0400 (EDT)
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
Subject: [PATCH v3 5/6] iio: imu: bmi270: Add triggered buffer for Bosch BMI270 IMU
Date: Sun, 20 Oct 2024 15:00:09 -0700
Message-ID: <20241020220011.212395-6-justin@justinweiss.com>
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
index d8f6d7cf47fc..fdfad5784cc5 100644
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
index 24e45d6f0706..5b643afae9f7 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -7,6 +7,8 @@
 #include <linux/regmap.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 #include "bmi270.h"
 
@@ -70,6 +72,17 @@ enum bmi270_scan {
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
 
 const struct bmi270_chip_info bmi260_chip_info = {
@@ -86,6 +99,27 @@ const struct bmi270_chip_info bmi270_chip_info = {
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
@@ -141,6 +175,13 @@ static const struct iio_info bmi270_info = {
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
@@ -148,6 +189,13 @@ static const struct iio_info bmi270_info = {
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
@@ -157,6 +205,7 @@ static const struct iio_chan_spec bmi270_channels[] = {
 	BMI270_ANG_VEL_CHANNEL(X),
 	BMI270_ANG_VEL_CHANNEL(Y),
 	BMI270_ANG_VEL_CHANNEL(Z),
+	IIO_CHAN_SOFT_TIMESTAMP(BMI270_SCAN_TIMESTAMP),
 };
 
 static int bmi270_validate_chip_id(struct bmi270_data *bmi270_device)
@@ -327,9 +376,16 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap,
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


