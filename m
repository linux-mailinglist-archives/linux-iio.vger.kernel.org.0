Return-Path: <linux-iio+bounces-10463-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE1E99A7FB
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 17:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934601F21AF6
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 15:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28431990C4;
	Fri, 11 Oct 2024 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="YVF7q28/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I1vvCQJD"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B0D195FCE;
	Fri, 11 Oct 2024 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661103; cv=none; b=X7sertNs9dyXuIEWlvC4N7drLUa3Im+zSQEErZIQmOZHerOfBnG3AJgoIZhCcMPMqfbcCTQIJn8voB03IIk/XP4CDgQT4lejsN5/55+QTS5zue9BbXz786bwnNhXV65ywQ+a5JfN4GnuHQL3svlTa030AOY40gWht6WSuI0w2PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661103; c=relaxed/simple;
	bh=Xsa7E4sI2a3AFjkvFeja04vjdO52xi11YqzXkhiDSA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7dqBUHJtxHXAaL993Dqm+2AkxDYtWnpDvLY2I2tdUwDgAEZH0s4g3gqklZsslCjux5Qr85Qgk6aqQ6pihacko29WcTk/o/5wroGcaqclWZiNZC/HVYS6PguGwoQB7O664Qs5eHn7CMoQmPCL0WO6/bzg40lvhIBAt73Z4Umpaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=YVF7q28/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I1vvCQJD; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id BF39A1380225;
	Fri, 11 Oct 2024 11:38:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 11 Oct 2024 11:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1728661100; x=
	1728747500; bh=nl/3aTrRjSgjCiMNNGf2bPVcKSWbVjCvRjUJQchF8eE=; b=Y
	VF7q28/N7+5e7a925HBkYf3qzeIMNNZelX2WGraJotiJG9qz3aSl7j6OdYabBeCZ
	NwbudDZV0sdK9e3ey1+rSHg8EE7ypUt8kytsyWNyZhr9hYO8BuwaooVcpWvCsCBq
	PCTT6EA5l4mkn0LTvpPewqzEfYiIT4GSl8jnmPyMiU1Fsb3sZUlW4P08Wf6TV4+f
	nn8ExJOfwwJlhc37415JSZ4RD879eBByS5st3ekGQAz4cUhry5jpctQiJtbEivKj
	NteaTzfqvsM0USJb2XJ2wBbqXC7lDq6Irzc7N0JsSDL6Qbi/S8MvwVyUFMX1UUvg
	9CmwdTOhbKlJmNL39c7aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728661100; x=
	1728747500; bh=nl/3aTrRjSgjCiMNNGf2bPVcKSWbVjCvRjUJQchF8eE=; b=I
	1vvCQJDbb4QwkuO00Pv3I/58/9BE/qCioye+YCgU0XjN2S5L7WwfDX7GeGVFXulU
	cMQ9XNUf9QLEQWar0jGh40cxNW7syvGY9SaHjXKwKrVBBj2NRwZVvlhhuwvdt08O
	E16wCknBgv/tHSn+MHyznW/PrNrsBaVDPwhZNww8eXPVKw3Mti2ctAw+BuGX9tDF
	svFLq4ijcqjJorW+m4eWSmslftPfAo8No0auTZBvSFm7mUQ+u6sMfXNL6zowjoe2
	w1IseZ+as/NMGU+aYJguR1S+ox4yQcv7FNEjcuApXbCtYxTJEND5jY3buOrbgAHu
	suvrmC9v4wBITd/i2rcsA==
X-ME-Sender: <xms:bEYJZzF_F82R-sMeSTnnc0i1AQEwYA990OWEtYnCvc4-xulLSCpt0w>
    <xme:bEYJZwVKaXaCphVeXM_ykngz2P_W6XiO7zWyVioRRF3_V2cqh-ra0-4_VCDw1HYTj
    q93LD679SzBKT2LLg>
X-ME-Received: <xmr:bEYJZ1JaUY2QD6zAZDxaSefKQCkyxsHdRwbyUHYiBJzJA3XqLW84sixvVpaysi9eP8870WsHwvI_1PewtOxK0QEwe80O0qqsmNAjVTjoUg>
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
X-ME-Proxy: <xmx:bEYJZxGNROeux6ZbfsJT6GwmbTuU8PJ6bkZWC8eBMnPAupTgNzwPLg>
    <xmx:bEYJZ5Ua3RRJByT_wsZ--7XNysXI8JcIWMHjwVxZ6QNmwZArcnbzyA>
    <xmx:bEYJZ8PLSMC389nCI8_n-xAAK-Htv8PhAiWEsO2LKsg6_vLDMRh2kA>
    <xmx:bEYJZ42FcaoXyTvEx60SjKlko8OgOyIXKYqNiocqo1E9X__F0AqGsg>
    <xmx:bEYJZ1p7M2lUDT7YpUWQkmS5QHxwpn-ts0w92ejDHGqPc6QlSkvy-BuA>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 11:38:19 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: Justin Weiss <justin@justinweiss.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Philip=20M=C3=BCller?= <philm@manjaro.org>
Subject: [PATCH 2/3] iio: imu: Add triggered buffer for Bosch BMI270 IMU
Date: Fri, 11 Oct 2024 08:37:48 -0700
Message-ID: <20241011153751.65152-3-justin@justinweiss.com>
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

Set up a triggered buffer for the accel and angl_vel values.

Signed-off-by: Justin Weiss <justin@justinweiss.com>
---
 drivers/iio/imu/bmi270/Kconfig       |  1 +
 drivers/iio/imu/bmi270/bmi270.h      |  8 +++++
 drivers/iio/imu/bmi270/bmi270_core.c | 47 ++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

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
index 51e374fd4290..335400c34b0d 100644
--- a/drivers/iio/imu/bmi270/bmi270.h
+++ b/drivers/iio/imu/bmi270/bmi270.h
@@ -11,6 +11,14 @@ struct bmi270_data {
 	struct device *dev;
 	struct regmap *regmap;
 	const struct bmi270_chip_info *chip_info;
+
+	/*
+	 * Ensure natural alignment for timestamp if present.
+	 * Max length needed: 2 * 3 channels + 4 bytes padding + 8 byte ts.
+	 * If fewer channels are enabled, less space may be needed, as
+	 * long as the timestamp is still aligned to 8 bytes.
+	 */
+	__le16 buf[12] __aligned(8);
 };
 
 enum bmi270_device_type {
diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index e5ee80c12166..f49db5d1bffd 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -7,6 +7,8 @@
 #include <linux/regmap.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 #include "bmi270.h"
 
@@ -66,6 +68,7 @@ enum bmi270_scan {
 	BMI270_SCAN_GYRO_X,
 	BMI270_SCAN_GYRO_Y,
 	BMI270_SCAN_GYRO_Z,
+	BMI270_SCAN_TIMESTAMP,
 };
 
 const struct bmi270_chip_info bmi270_chip_info[] = {
@@ -82,6 +85,29 @@ const struct bmi270_chip_info bmi270_chip_info[] = {
 };
 EXPORT_SYMBOL_NS_GPL(bmi270_chip_info, IIO_BMI270);
 
+static irqreturn_t bmi270_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct bmi270_data *bmi270_device = iio_priv(indio_dev);
+	int i, ret, j = 0, base = BMI270_ACCEL_X_REG;
+	__le16 sample;
+
+	for_each_set_bit(i, indio_dev->active_scan_mask, indio_dev->masklength) {
+		ret = regmap_bulk_read(bmi270_device->regmap,
+				       base + i * sizeof(sample),
+				       &sample, sizeof(sample));
+		if (ret)
+			goto done;
+		bmi270_device->buf[j++] = sample;
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, bmi270_device->buf, pf->timestamp);
+done:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
 static int bmi270_get_data(struct bmi270_data *bmi270_device,
 			   int chan_type, int axis, int *val)
 {
@@ -139,6 +165,13 @@ static const struct iio_info bmi270_info = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
 		BIT(IIO_CHAN_INFO_FREQUENCY),			\
+	.scan_index = BMI270_SCAN_ACCEL_##_axis,		\
+	.scan_type = {						\
+		.sign = 's',					\
+		.realbits = 16,				\
+		.storagebits = 16,				\
+		.endianness = IIO_LE				\
+	},	                                                \
 }
 
 #define BMI270_ANG_VEL_CHANNEL(_axis) {				\
@@ -148,6 +181,13 @@ static const struct iio_info bmi270_info = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
 		BIT(IIO_CHAN_INFO_FREQUENCY),			\
+	.scan_index = BMI270_SCAN_GYRO_##_axis,		\
+	.scan_type = {						\
+		.sign = 's',					\
+		.realbits = 16,				\
+		.storagebits = 16,				\
+		.endianness = IIO_LE				\
+	},	                                                \
 }
 
 static const struct iio_chan_spec bmi270_channels[] = {
@@ -157,6 +197,7 @@ static const struct iio_chan_spec bmi270_channels[] = {
 	BMI270_ANG_VEL_CHANNEL(X),
 	BMI270_ANG_VEL_CHANNEL(Y),
 	BMI270_ANG_VEL_CHANNEL(Z),
+	IIO_CHAN_SOFT_TIMESTAMP(BMI270_SCAN_TIMESTAMP),
 };
 
 static int bmi270_validate_chip_id(struct bmi270_data *bmi270_device)
@@ -317,6 +358,12 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap,
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


