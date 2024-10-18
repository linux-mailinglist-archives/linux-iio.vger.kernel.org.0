Return-Path: <linux-iio+bounces-10755-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5469A4A2F
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 01:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC0222846BC
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 23:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18761192B88;
	Fri, 18 Oct 2024 23:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="O/bwy1Hh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="py5i+2C1"
X-Original-To: linux-iio@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92008192593;
	Fri, 18 Oct 2024 23:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729294721; cv=none; b=RiQOOqwv4LbwKzK8yfaDCSAlZDXGgYbCx5mYJBVIY1aGVC7MIwPSjSL5lMyfCc5kfMKsvtwUgfp/HRfpKOITFe4IJUqiyMDEECAZZcvz9DUzKNW5MjQEiNdChzeONLkogdSglhXK7JHs0nXFE2MSgWj/001g9qJk4mbnLqfI4Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729294721; c=relaxed/simple;
	bh=Rb0+K9ekan0pIdjctjIWQU5HI8jwStHR65Uuq2wijnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQiYbTNelGrunjTkjqW/G13EREWsF72NQOelpc0phAj52giL8Y0tNo2aghxKG1RmmD+U7W6keMpjSvKusRrnc5EJmk5IgGBfMPGQD7l4gQIZAQpIieEcRCF5nYKgJHfVruTDOZ7dvdGWuXS2+H7rm3kjIiTPPESuX8nPCx7i8kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=O/bwy1Hh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=py5i+2C1; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B60AC11400B5;
	Fri, 18 Oct 2024 19:38:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 18 Oct 2024 19:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729294718; x=
	1729381118; bh=jIzjZw+jZqRy27lPMRRLcFPQ1p9XahgRDxdC2JepzMY=; b=O
	/bwy1HhRLHD1IC+EXmZaUtn9rAhtn8qVt2Up5uBgF8rsCbXkG8z5bDKZ8xVoIr/q
	otRJaCTku/KJcL9IiblprZLd0hfsjOG3qgZt24HNXLNTg/aG98AR+Zq5Usu4LpVC
	tBZf/ZPz6EcjmYqeBruBi2q69mhehf3HQTJXq4pgQruWWV4obh0iHISAgPm2zTpF
	UNoHmD+oEJrQjSJfwnFEx3SxvcMY1Ewxo1K+5Xnaz+sgSip1YFvjH9a/4ZX5Kf6f
	CiIM5oehRDaPuoJTU5++E9qKwVnhWxBAE4FT3jXSL9dRZjN564wBBwstCrlhdTJH
	ZLyv3wwkPAXb0tW7Hltnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729294718; x=
	1729381118; bh=jIzjZw+jZqRy27lPMRRLcFPQ1p9XahgRDxdC2JepzMY=; b=p
	y5i+2C1ZV5BpdNbG7LjWgx+hPql7QEPJCesPcA+xXdJ8JpIvSn6NJX0TYqD+njG2
	p8IM96Gqo9NSCCUVusaqgcVTvaIL0hhhsnYPwWZVN9+shi/u7tOJM3vzVSj/RRnY
	YXQza9qiI+jnB+pnPMosWHrHwdBV12iv8OKxpXvHTPk0rt32Pp5olsOwZgXfZTI6
	ayUJnkUM16/2TAiTVAitcItG8wEhViJLVh3jA9SwbGjSaSFJlcf445glLo9gHlFD
	mHaZadtefBjc3rwS7vG+5FL6e6N/Vgr39mtnieHVD6bHqHHSdd811PL5fO0bqzg1
	MvtBy1uRQzcBQPwxv2QTw==
X-ME-Sender: <xms:fvESZ9SAd_ssQDMExacswpkWsy9YJrNU4zEtUZQwzQ8mUiVXnjGVCw>
    <xme:fvESZ2xuBlPacTC5gMFwm6qZQeIQH270X3BLktQHe5fJ_iZzabWMVuhEGlCcm1uvb
    IGje7Lh2jr4kgx-xw>
X-ME-Received: <xmr:fvESZy1k4os9f5LZ1WOfVG9Ka9MN6dC3Evl7Po217jtmcOle8tZKF9WesgcJRb8qPIoJFY1vsGAojb-mlOpPfgF4uY8uD12-Ru8SXIplkQ>
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
X-ME-Proxy: <xmx:fvESZ1CBxJln_8ysRDMSBAjKys6kjqPU6TfAQHRqtrkPF-Qg1nZCjA>
    <xmx:fvESZ2iz3NZbDI1RHl5riIkTPe_kjNKzInWE-lvqoY6NlL44Q1nQfA>
    <xmx:fvESZ5pv7tmOgP7qGAnsQ5DXfBkWSXvn7qiQpr5awBli1pCivr_vKQ>
    <xmx:fvESZxhyX-OrxAdSht6Hy2x5PpbT3HGuE0glTAWVjfWfji5iWrY9ag>
    <xmx:fvESZ3YorNP_ScFwtN4uUZ6V_SEeldJ1bDdUnesQyxm1EMrIdCf8JiOS>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 19:38:37 -0400 (EDT)
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
Subject: [PATCH v2 5/6] iio: imu: bmi270: Add triggered buffer for Bosch BMI270 IMU
Date: Fri, 18 Oct 2024 16:36:11 -0700
Message-ID: <20241018233723.28757-6-justin@justinweiss.com>
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
index 51e374fd4290..844d70a7d32e 100644
--- a/drivers/iio/imu/bmi270/bmi270.h
+++ b/drivers/iio/imu/bmi270/bmi270.h
@@ -11,6 +11,15 @@ struct bmi270_data {
 	struct device *dev;
 	struct regmap *regmap;
 	const struct bmi270_chip_info *chip_info;
+
+	/*
+	 * Where IIO_DMA_MINALIGN is larger than 8 bytes, align to that
+	 * to ensure a DMA safe buffer.
+	 */
+	struct {
+		__le16 channels[6];
+		aligned_s64 timestamp;
+	} data __aligned(IIO_DMA_MINALIGN);
 };
 
 enum bmi270_device_type {
diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index b30201dc4e22..69b011f97324 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -7,6 +7,8 @@
 #include <linux/regmap.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 #include "bmi270.h"
 
@@ -67,6 +69,17 @@ enum bmi270_scan {
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
 
 const struct bmi270_chip_info bmi270_chip_info[] = {
@@ -83,6 +96,27 @@ const struct bmi270_chip_info bmi270_chip_info[] = {
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
@@ -140,6 +174,13 @@ static const struct iio_info bmi270_info = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+	.scan_index = BMI270_SCAN_ACCEL_##_axis,		\
+	.scan_type = {						\
+		.sign = 's',					\
+		.realbits = 16,					\
+		.storagebits = 16,				\
+		.endianness = IIO_LE				\
+	},	                                                \
 }
 
 #define BMI270_ANG_VEL_CHANNEL(_axis) {				\
@@ -149,6 +190,13 @@ static const struct iio_info bmi270_info = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+	.scan_index = BMI270_SCAN_GYRO_##_axis,			\
+	.scan_type = {						\
+		.sign = 's',					\
+		.realbits = 16,					\
+		.storagebits = 16,				\
+		.endianness = IIO_LE				\
+	},	                                                \
 }
 
 static const struct iio_chan_spec bmi270_channels[] = {
@@ -158,6 +206,7 @@ static const struct iio_chan_spec bmi270_channels[] = {
 	BMI270_ANG_VEL_CHANNEL(X),
 	BMI270_ANG_VEL_CHANNEL(Y),
 	BMI270_ANG_VEL_CHANNEL(Z),
+	IIO_CHAN_SOFT_TIMESTAMP(BMI270_SCAN_TIMESTAMP),
 };
 
 static int bmi270_validate_chip_id(struct bmi270_data *bmi270_device)
@@ -328,9 +377,16 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap,
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


