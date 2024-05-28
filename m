Return-Path: <linux-iio+bounces-5400-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA408D1EA4
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 16:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8B47B23210
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 14:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6C217106D;
	Tue, 28 May 2024 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuWvkbjK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDA1170824;
	Tue, 28 May 2024 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906286; cv=none; b=dqWynOkSPc+WdL6FKoDsUwqdqZo9U84+xgFQb/ycn7KdIDrXT9uX0f5f6C83UhN9wFkcrdMFVUWHF3dRBIAusXyH65LoSJI6CjlPekObYYzlnOXp6dWUNEb+9JKJZMzYu/n0QiMwwWiIWxavqauP3H/bUWpgYIPNxGzCELrf2Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906286; c=relaxed/simple;
	bh=LaC7Cp/Vch94bp0LzvJ4XVaviyhJp6VCRvtsSLC7X6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lSBp5aLdCbxLASFMDVHLq8STNAQyS3gMQXKmLVfiLbaIeAoVQs56lfuBlLpWAx9d27U+F1yxXdKPbXclbAa1SSlq/GwNe6G3k75Vu4ENvEZrmh9dqAvJ8z8v2ylpUjgj9qEHsYS5Yg2NSpU2JpyEYg2u4XNU8pDCEyUK/Faj2og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuWvkbjK; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-578517c8b49so1085793a12.3;
        Tue, 28 May 2024 07:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716906283; x=1717511083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnqXUCFZ5EtFmdWWExd39eHRKmWQKrueiv9NV1j2AHA=;
        b=KuWvkbjKoKt80tmBm54YxxDuz9HePzM0CrfblRztb87lcfEJWpHJORdFabOIuYhTja
         lYvGkvbDIz/SzjJx6czTbmEHdGFhwFmS8gnlHV17HygzASwn5SfUc4cOrPcLEjOlQ7oA
         baltKPjhCCPe3xiL4gsyjgCIfdB5rQoahvhgUg0x6zlJhb2V9E5/t7C/TQDCXS3J5r3s
         S/fJcniEOtkowcxIy6Iva1tDzKs2T+oOwh+NvjpCnbdEQ/A/hk1bpoFkP0egk7roILbX
         OSzKg6RTtP1zx5E9y8Z258mu6caJSmxwE1cMiFVXcPZ3kF+Ed4jIRdPpDx9P+t6fOeBW
         vL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716906283; x=1717511083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnqXUCFZ5EtFmdWWExd39eHRKmWQKrueiv9NV1j2AHA=;
        b=nCTPZk9gFOl7eO0mD/RL8BRRfbSmMzUPZH/W7UDW7FpeogV8wS7FyuJZi7qpsMXsNd
         7yXhPNtOV2arEAf8VaGJjgv8cF0wTmnqEvrYpUwGI85dVpd1qCqKZ3j4IvySxERSXwbj
         6s5iwuzmfqImlTdt8OVNN6vuMYoyZ5ow24Gka/AZhEJ+p/x566igO6+uY7zaUyAhrhP1
         AKMb1AvDG1qCEovXIXTs6KfRat4kXr6N1TBdbKPimI0BnY+rblltvVnLhVlt0mHvVewi
         xIi9Qb04zC0LJfMCg4n/ZcskCgJoZL9snfZZQKWJBuVkZsGBwISCOhEqAyX7rnipNp+n
         Lriw==
X-Forwarded-Encrypted: i=1; AJvYcCU1J63LCOqKjhrlI+XFwXMDmBTHZNbm2pIDwOtSqNCpJxKFxeMSFlTIt/eKs/kFhSelJnbbHh69pnrGSjVXF5Moni6cPJEFBlDGJzY8Xv0XgLy7Ha/z92pg35eqJLPSYRawjjlHQBRYHDCLIcHthzrFQ7VcCr4yAUuV3Uy2Rgxsyw==
X-Gm-Message-State: AOJu0Yy62kUMwfOGrZh2oYcvkg6RHJpfD1RBAyJe0If2mV8AcUDY1j30
	IkU4y8QFvZ+PcBT2vENVD79bpBsOavotqG3rr77oyICdaMKW8Sb7TuSMCyhkl58=
X-Google-Smtp-Source: AGHT+IHxYM2+mIFboPKU6ucMCZxA6ZOpY5B4zJBiUHaC99fhZd1z4WD3riBJXtJ6qrL2ZE96wxKoog==
X-Received: by 2002:a50:cc4a:0:b0:579:c8cb:ec4c with SMTP id 4fb4d7f45d1cf-579c8cbef27mr4839107a12.1.1716906282770;
        Tue, 28 May 2024 07:24:42 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:3736:ef2a:a857:c911])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579d7dc9efesm2495580a12.48.2024.05.28.07.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:24:42 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
X-Google-Original-From: Ramona Gradinariu <ramona.gradinariu@analog.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	corbet@lwn.net,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v2 4/6] iio: adis16480: add support for adis16545/7 families
Date: Tue, 28 May 2024 17:24:07 +0300
Message-Id: <20240528142409.239187-5-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528142409.239187-1-ramona.gradinariu@analog.com>
References: <20240528142409.239187-1-ramona.gradinariu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ADIS16545 and ADIS16547 are a complete inertial system that
includes a triaxis gyroscope and a triaxis accelerometer.
The serial peripheral interface (SPI) and register structure provide a
simple interface for data collection and configuration control.

These devices are similar to the ones already supported in the driver,
with changes in the scales, timings and the max spi speed in burst
mode.
Also, they support delta angle and delta velocity readings in burst
mode, for which support was added in the trigger handler.

Co-developed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
---
changes in v2:
 - dropped condition to add extra padding byte for temp channel
 - used available_scan_masks instead of checking the mask in
 adis16480_update_scan_mode
 - added macros instead of magic values for burst ids
 - added explaantory comment for selecting the default burst id
 - added missing case for delta channel in the trigger handler
 drivers/iio/imu/adis16480.c | 237 ++++++++++++++++++++++++++++++++++--
 1 file changed, 229 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 0cd55040db93..56ca5a09fbbf 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -104,7 +104,8 @@
  */
 #define ADIS16495_REG_SYNC_SCALE		ADIS16480_REG(0x03, 0x10)
 #define ADIS16495_REG_BURST_CMD			ADIS16480_REG(0x00, 0x7C)
-#define ADIS16495_BURST_ID			0xA5A5
+#define ADIS16495_GYRO_ACCEL_BURST_ID		0xA5A5
+#define ADIS16545_DELTA_ANG_VEL_BURST_ID	0xC3C3
 /* total number of segments in burst */
 #define ADIS16495_BURST_MAX_DATA		20

@@ -132,6 +133,10 @@
 #define ADIS16480_SYNC_MODE_MSK		BIT(8)
 #define ADIS16480_SYNC_MODE(x)		FIELD_PREP(ADIS16480_SYNC_MODE_MSK, x)

+#define ADIS16545_BURST_DATA_SEL_0_CHN_MASK	GENMASK(5, 0)
+#define ADIS16545_BURST_DATA_SEL_1_CHN_MASK	GENMASK(16, 11)
+#define ADIS16545_BURST_DATA_SEL_MASK		BIT(8)
+
 struct adis16480_chip_info {
 	unsigned int num_channels;
 	const struct iio_chan_spec *channels;
@@ -147,6 +152,7 @@ struct adis16480_chip_info {
 	const unsigned int *filter_freqs;
 	bool has_pps_clk_mode;
 	bool has_sleep_cnt;
+	bool has_burst_delta_data;
 	const struct adis_data adis_data;
 };

@@ -170,6 +176,7 @@ struct adis16480 {
 	struct clk *ext_clk;
 	enum adis16480_clock_mode clk_mode;
 	unsigned int clk_freq;
+	u16 burst_id;
 	/* Alignment needed for the timestamp */
 	__be16 data[ADIS16495_BURST_MAX_DATA] __aligned(8);
 };
@@ -876,6 +883,23 @@ static const struct iio_chan_spec adis16485_channels[] = {
 	ADIS16480_DELTVEL_CHANNEL_NO_SCAN(Z),
 };

+static const struct iio_chan_spec adis16545_channels[] = {
+	ADIS16480_GYRO_CHANNEL(X),
+	ADIS16480_GYRO_CHANNEL(Y),
+	ADIS16480_GYRO_CHANNEL(Z),
+	ADIS16480_ACCEL_CHANNEL(X),
+	ADIS16480_ACCEL_CHANNEL(Y),
+	ADIS16480_ACCEL_CHANNEL(Z),
+	ADIS16480_TEMP_CHANNEL(),
+	ADIS16480_DELTANG_CHANNEL(X),
+	ADIS16480_DELTANG_CHANNEL(Y),
+	ADIS16480_DELTANG_CHANNEL(Z),
+	ADIS16480_DELTVEL_CHANNEL(X),
+	ADIS16480_DELTVEL_CHANNEL(Y),
+	ADIS16480_DELTVEL_CHANNEL(Z),
+	IIO_CHAN_SOFT_TIMESTAMP(17),
+};
+
 enum adis16480_variant {
 	ADIS16375,
 	ADIS16480,
@@ -888,6 +912,12 @@ enum adis16480_variant {
 	ADIS16497_1,
 	ADIS16497_2,
 	ADIS16497_3,
+	ADIS16545_1,
+	ADIS16545_2,
+	ADIS16545_3,
+	ADIS16547_1,
+	ADIS16547_2,
+	ADIS16547_3
 };

 #define ADIS16480_DIAG_STAT_XGYRO_FAIL 0
@@ -969,6 +999,12 @@ static const struct adis_timeout adis16495_1_timeouts = {
 	.self_test_ms = 20,
 };

+static const struct adis_timeout adis16545_timeouts = {
+	.reset_ms = 315,
+	.sw_reset_ms = 270,
+	.self_test_ms = 35,
+};
+
 static const struct adis16480_chip_info adis16480_chip_info[] = {
 	[ADIS16375] = {
 		.channels = adis16485_channels,
@@ -1170,6 +1206,126 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 					    ADIS16495_BURST_MAX_DATA * 2,
 					    6000000),
 	},
+	[ADIS16545_1] = {
+		.channels = adis16545_channels,
+		.num_channels = ARRAY_SIZE(adis16545_channels),
+		.gyro_max_val = 20000 << 16,
+		.gyro_max_scale = IIO_DEGREE_TO_RAD(125),
+		.accel_max_val = IIO_M_S_2_TO_G(32000 << 16),
+		.accel_max_scale = 8,
+		.temp_scale = 7000, /* 7 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(360),
+		.deltvel_max_val = 100,
+		.int_clk = 4250000,
+		.max_dec_rate = 4250,
+		.filter_freqs = adis16495_def_filter_freqs,
+		.has_pps_clk_mode = true,
+		.has_burst_delta_data = true,
+		/* 20 elements of 16bits */
+		.adis_data = ADIS16480_DATA(16545, &adis16545_timeouts,
+					    ADIS16495_BURST_MAX_DATA * 2,
+					    6500000),
+	},
+	[ADIS16545_2] = {
+		.channels = adis16545_channels,
+		.num_channels = ARRAY_SIZE(adis16545_channels),
+		.gyro_max_val = 18000 << 16,
+		.gyro_max_scale = IIO_DEGREE_TO_RAD(450),
+		.accel_max_val = IIO_M_S_2_TO_G(32000 << 16),
+		.accel_max_scale = 8,
+		.temp_scale = 7000, /* 7 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(720),
+		.deltvel_max_val = 100,
+		.int_clk = 4250000,
+		.max_dec_rate = 4250,
+		.filter_freqs = adis16495_def_filter_freqs,
+		.has_pps_clk_mode = true,
+		.has_burst_delta_data = true,
+		/* 20 elements of 16bits */
+		.adis_data = ADIS16480_DATA(16545, &adis16545_timeouts,
+					    ADIS16495_BURST_MAX_DATA * 2,
+					    6500000),
+	},
+	[ADIS16545_3] = {
+		.channels = adis16545_channels,
+		.num_channels = ARRAY_SIZE(adis16545_channels),
+		.gyro_max_val = 20000 << 16,
+		.gyro_max_scale = IIO_DEGREE_TO_RAD(2000),
+		.accel_max_val = IIO_M_S_2_TO_G(32000 << 16),
+		.accel_max_scale = 8,
+		.temp_scale = 7000, /* 7 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(2160),
+		.deltvel_max_val = 100,
+		.int_clk = 4250000,
+		.max_dec_rate = 4250,
+		.filter_freqs = adis16495_def_filter_freqs,
+		.has_pps_clk_mode = true,
+		.has_burst_delta_data = true,
+		/* 20 elements of 16bits */
+		.adis_data = ADIS16480_DATA(16545, &adis16545_timeouts,
+					    ADIS16495_BURST_MAX_DATA * 2,
+					    6500000),
+	},
+	[ADIS16547_1] = {
+		.channels = adis16545_channels,
+		.num_channels = ARRAY_SIZE(adis16545_channels),
+		.gyro_max_val = 20000 << 16,
+		.gyro_max_scale = IIO_DEGREE_TO_RAD(125),
+		.accel_max_val = IIO_M_S_2_TO_G(32000 << 16),
+		.accel_max_scale = 40,
+		.temp_scale = 7000, /* 7 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(360),
+		.deltvel_max_val = 400,
+		.int_clk = 4250000,
+		.max_dec_rate = 4250,
+		.filter_freqs = adis16495_def_filter_freqs,
+		.has_pps_clk_mode = true,
+		.has_burst_delta_data = true,
+		/* 20 elements of 16bits */
+		.adis_data = ADIS16480_DATA(16547, &adis16545_timeouts,
+					    ADIS16495_BURST_MAX_DATA * 2,
+					    6500000),
+	},
+	[ADIS16547_2] = {
+		.channels = adis16545_channels,
+		.num_channels = ARRAY_SIZE(adis16545_channels),
+		.gyro_max_val = 18000 << 16,
+		.gyro_max_scale = IIO_DEGREE_TO_RAD(450),
+		.accel_max_val = IIO_M_S_2_TO_G(32000 << 16),
+		.accel_max_scale = 40,
+		.temp_scale = 7000, /* 7 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(720),
+		.deltvel_max_val = 400,
+		.int_clk = 4250000,
+		.max_dec_rate = 4250,
+		.filter_freqs = adis16495_def_filter_freqs,
+		.has_pps_clk_mode = true,
+		.has_burst_delta_data = true,
+		/* 20 elements of 16bits */
+		.adis_data = ADIS16480_DATA(16547, &adis16545_timeouts,
+					    ADIS16495_BURST_MAX_DATA * 2,
+					    6500000),
+	},
+	[ADIS16547_3] = {
+		.channels = adis16545_channels,
+		.num_channels = ARRAY_SIZE(adis16545_channels),
+		.gyro_max_val = 20000 << 16,
+		.gyro_max_scale = IIO_DEGREE_TO_RAD(2000),
+		.accel_max_val = IIO_M_S_2_TO_G(32000 << 16),
+		.accel_max_scale = 40,
+		.temp_scale = 7000, /* 7 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(2160),
+		.deltvel_max_val = 400,
+		.int_clk = 4250000,
+		.max_dec_rate = 4250,
+		.filter_freqs = adis16495_def_filter_freqs,
+		.has_pps_clk_mode = true,
+		.has_burst_delta_data = true,
+		/* 20 elements of 16bits */
+		.adis_data = ADIS16480_DATA(16547, &adis16545_timeouts,
+					    ADIS16495_BURST_MAX_DATA * 2,
+					    6500000),
+	},
 };

 static bool adis16480_validate_crc(const u16 *buf, const u8 n_elem, const u32 crc)
@@ -1194,7 +1350,7 @@ static irqreturn_t adis16480_trigger_handler(int irq, void *p)
 	struct adis16480 *st = iio_priv(indio_dev);
 	struct adis *adis = &st->adis;
 	struct device *dev = &adis->spi->dev;
-	int ret, bit, offset, i = 0;
+	int ret, bit, offset, i = 0, buff_offset = 0;
 	__be16 *buffer;
 	u32 crc;
 	bool valid;
@@ -1227,8 +1383,8 @@ static irqreturn_t adis16480_trigger_handler(int irq, void *p)
 	 * 16-bit responses containing the BURST_ID depending on the sclk. If
 	 * clk > 3.6MHz, then we will have two BURST_ID in a row. If clk < 3MHZ,
 	 * we have only one. To manage that variation, we use the transition from the
-	 * BURST_ID to the SYS_E_FLAG register, which will not be equal to 0xA5A5. If
-	 * we not find this variation in the first 4 segments, then the data should
+	 * BURST_ID to the SYS_E_FLAG register, which will not be equal to 0xA5A5/0xC3C3.
+	 * If we not find this variation in the first 4 segments, then the data should
 	 * not be valid.
 	 */
 	buffer = adis->buffer;
@@ -1236,7 +1392,7 @@ static irqreturn_t adis16480_trigger_handler(int irq, void *p)
 		u16 curr = be16_to_cpu(buffer[offset]);
 		u16 next = be16_to_cpu(buffer[offset + 1]);

-		if (curr == ADIS16495_BURST_ID && next != ADIS16495_BURST_ID) {
+		if (curr == st->burst_id && next != st->burst_id) {
 			offset++;
 			break;
 		}
@@ -1263,11 +1419,24 @@ static irqreturn_t adis16480_trigger_handler(int irq, void *p)
 		switch (bit) {
 		case ADIS16480_SCAN_TEMP:
 			st->data[i++] = buffer[offset + 1];
+			/*
+			 * The temperature channel has 16-bit storage size.
+			 * We need to perform the padding to have the buffer
+			 * elements naturally aligned in case there are any
+			 * 32-bit storage size channels enabled which are added
+			 * in the buffer after the temprature data. In case
+			 * there is no data being added after the temperature
+			 * data, the padding is harmless.
+			 */
+			st->data[i++] = 0;
 			break;
+		case ADIS16480_SCAN_DELTANG_X ... ADIS16480_SCAN_DELTVEL_Z:
+			buff_offset = ADIS16480_SCAN_DELTANG_X;
+			fallthrough;
 		case ADIS16480_SCAN_GYRO_X ... ADIS16480_SCAN_ACCEL_Z:
 			/* The lower register data is sequenced first */
-			st->data[i++] = buffer[2 * bit + offset + 3];
-			st->data[i++] = buffer[2 * bit + offset + 2];
+			st->data[i++] = buffer[2 * (bit - buff_offset) + offset + 3];
+			st->data[i++] = buffer[2 * (bit - buff_offset) + offset + 2];
 			break;
 		}
 	}
@@ -1279,10 +1448,41 @@ static irqreturn_t adis16480_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }

+static const unsigned long adis16545_channel_masks[] = {
+	ADIS16545_BURST_DATA_SEL_0_CHN_MASK | BIT(ADIS16480_SCAN_TEMP) | BIT(17),
+	ADIS16545_BURST_DATA_SEL_1_CHN_MASK | BIT(ADIS16480_SCAN_TEMP) | BIT(17),
+	0,
+};
+
+static int adis16480_update_scan_mode(struct iio_dev *indio_dev,
+				      const unsigned long *scan_mask)
+{
+	u16 en;
+	int ret;
+	struct adis16480 *st = iio_priv(indio_dev);
+
+	if (st->chip_info->has_burst_delta_data) {
+		if (*scan_mask & ADIS16545_BURST_DATA_SEL_0_CHN_MASK) {
+			en = FIELD_PREP(ADIS16545_BURST_DATA_SEL_MASK, 0);
+			st->burst_id = ADIS16495_GYRO_ACCEL_BURST_ID;
+		} else {
+			en = FIELD_PREP(ADIS16545_BURST_DATA_SEL_MASK, 1);
+			st->burst_id = ADIS16545_DELTA_ANG_VEL_BURST_ID;
+		}
+
+		ret = __adis_update_bits(&st->adis, ADIS16480_REG_CONFIG,
+					 ADIS16545_BURST_DATA_SEL_MASK, en);
+		if (ret)
+			return ret;
+	}
+
+	return adis_update_scan_mode(indio_dev, scan_mask);
+}
+
 static const struct iio_info adis16480_info = {
 	.read_raw = &adis16480_read_raw,
 	.write_raw = &adis16480_write_raw,
-	.update_scan_mode = adis_update_scan_mode,
+	.update_scan_mode = &adis16480_update_scan_mode,
 	.debugfs_reg_access = adis_debugfs_reg_access,
 };

@@ -1479,6 +1679,8 @@ static int adis16480_probe(struct spi_device *spi)
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
+	if (st->chip_info->has_burst_delta_data)
+		indio_dev->available_scan_masks = adis16545_channel_masks;
 	indio_dev->info = &adis16480_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;

@@ -1492,6 +1694,13 @@ static int adis16480_probe(struct spi_device *spi)
 	if (ret)
 		return ret;

+	/*
+	 * By default, use burst id for gyroscope and accelerometer data.
+	 * This is the only option for devices which do not offer delta angle
+	 * and delta velocity burst readings.
+	 */
+	st->burst_id = ADIS16495_GYRO_ACCEL_BURST_ID;
+
 	if (st->chip_info->has_sleep_cnt) {
 		ret = devm_add_action_or_reset(dev, adis16480_stop, indio_dev);
 		if (ret)
@@ -1565,6 +1774,12 @@ static const struct spi_device_id adis16480_ids[] = {
 	{ "adis16497-1", ADIS16497_1 },
 	{ "adis16497-2", ADIS16497_2 },
 	{ "adis16497-3", ADIS16497_3 },
+	{ "adis16545-1", ADIS16545_1 },
+	{ "adis16545-2", ADIS16545_2 },
+	{ "adis16545-3", ADIS16545_3 },
+	{ "adis16547-1", ADIS16547_1 },
+	{ "adis16547-2", ADIS16547_2 },
+	{ "adis16547-3", ADIS16547_3 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adis16480_ids);
@@ -1581,6 +1796,12 @@ static const struct of_device_id adis16480_of_match[] = {
 	{ .compatible = "adi,adis16497-1" },
 	{ .compatible = "adi,adis16497-2" },
 	{ .compatible = "adi,adis16497-3" },
+	{ .compatible = "adi,adis16545-1" },
+	{ .compatible = "adi,adis16545-2" },
+	{ .compatible = "adi,adis16545-3" },
+	{ .compatible = "adi,adis16547-1" },
+	{ .compatible = "adi,adis16547-2" },
+	{ .compatible = "adi,adis16547-3" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, adis16480_of_match);
--
2.34.1


