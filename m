Return-Path: <linux-iio+bounces-5398-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B458D1E96
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 16:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720851F23523
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 14:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D03E16FF5A;
	Tue, 28 May 2024 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrcvOnc4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5115616F911;
	Tue, 28 May 2024 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906284; cv=none; b=J0J4ZLKeJP0512kcNec0rOZaCsfYVCnFRMGAQYR+zqRJytFdyRghR4is1ut0RMhwqjSvWuEBIVWNz1hR5Jp5Xz2waZtJp6ptcbjgphqlr5S6CdbALJM/vLttrND7apU7wk3yK9gOMIwaOPToAViOdRfOtx/l2QWXC1jfHV1tB+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906284; c=relaxed/simple;
	bh=m3YhbMcdopdM6w302xpbQOzRJW7uCT/KmmmUaQ4g2qk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gdj8VbkbFYVG/RbaOTnp1MKYHTWMVkABrOqdsPnEgTp+fOCp0vDhD7Gj8P5HDCZN47pYOaSnNwnFN58JljwhS2Sqxg1LaGLTyar32ydHei5bAwUYV7zwB2Zz3b9hpjlXlKuZXKWiSP0lKzbqXioeZCT4toG7UHe2JBXpRb/LdAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrcvOnc4; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso1515027a12.1;
        Tue, 28 May 2024 07:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716906280; x=1717511080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHgsvsU29VBXGFaV2q8xu0tkNZNo7YIfhvej54NDxL4=;
        b=HrcvOnc4j3tUN/3R3aELKxD6y04JV747L+PfuJx8Ito3cqft1tOGxDeGDwDjvZJh0r
         5CQQDp4sr0bNno94NVk2OBNhRfzDMQMhbIMaa6kKhz/wXudSUm03nk+pKajEhozLkL56
         7p5VXxgKyG4yyUs07xPqE3MCWYZOi80s/lwPJ3BqHlJ78k4U4NfmcI1jyrb/eageLTM6
         oMimB09ew/2QZbc2paQRWsWg21TxRMNrtuAaYVvvqZAGa+kh6XIm8zsjgp0T+9tLN1Cd
         v2qtQegOfWSWMb2rz5du0oE6a+H6/zZ6Mvb9bd2g3rgusYyFhNMg0uPE+eOtfZ7wW+Jq
         FprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716906280; x=1717511080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHgsvsU29VBXGFaV2q8xu0tkNZNo7YIfhvej54NDxL4=;
        b=a56T0szetxN+Vd9J9xXRiKIFcthT/+DImlwywh+AGz30FeNgzViFn2sRTR77ONNLVx
         R3S3nPsYctQzAY3iHeWoLJl5wsECsZC1pbcFW6H5+IBy+bhNVdDvLxvQSN4fgF9Ro4U6
         xhjNr8KUClcVweHsB9Qfe7j1N3VEnVXqivr5Ii28iTY7+bFNY6AjP+VwHukXllszzzAN
         sLw+Z1TUekojh0Nv0HK5dHBwU+wYmhqDAlwn54W60DO4ueR0J+wDxLpUjRYxBBL24E5I
         Csxyhi3yJBTgdMlGtOG2VLdvl4KhbbrZrsm11nxqDfUm734dGDF7d+8Mn8qXuxKZc7JH
         WAbg==
X-Forwarded-Encrypted: i=1; AJvYcCWMilxT4/+b/YYmmua3CfA/+EohQvKnznJAcsbxrhHBzJ9GRkeBk3/Xp8LAogIWU5Xq1BjbiZwM6Dp0UjQrdwir0SEXQZtvErB+Ntya8NzwaXJM+44rYEMHZV7M/Gfl7qWtMmfuBStPU1qqKWiVsYUa/ZYuHTld0glZqh9BFtGuHA==
X-Gm-Message-State: AOJu0YxZGOjgQ+EONn4znZtcTcdlqkIoxcRudtGrU+FGDugYBnOUb4fl
	jkxUHd495HKa4OaNTeJ8JQhfznCAXv02HONgWQQB9wgejr/EHh7RO7edg+5KWF0=
X-Google-Smtp-Source: AGHT+IHcWsentQhufxYPJdb7Au4CruOkJkjBSyRzos3fpy/VbMMN/VAbmH6z0PwQmW3QoJ1pH9neWA==
X-Received: by 2002:a50:d516:0:b0:578:d846:fc0a with SMTP id 4fb4d7f45d1cf-578d846fdb8mr7000498a12.20.1716906280514;
        Tue, 28 May 2024 07:24:40 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:3736:ef2a:a857:c911])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579d7dc9efesm2495580a12.48.2024.05.28.07.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:24:39 -0700 (PDT)
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
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH v2 2/6] iio: imu: adis16480.c: Add delta angle and delta velocity channels
Date: Tue, 28 May 2024 17:24:05 +0300
Message-Id: <20240528142409.239187-3-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528142409.239187-1-ramona.gradinariu@analog.com>
References: <20240528142409.239187-1-ramona.gradinariu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for delta angle and delta velocity raw readings to
adis16480 driver.
The following devices do not support delta readings in burst mode:
ADIS16375, ADIS16480, ADIS16485, ADIS16488, ADIS16490, ADIS16495-1,
ADIS16495-2, ADIS16495-3, ADIS16497-1, ADIS16497-2, ADIS16497-3, thus
they cannot be retrieved via the buffer interface.
For these devices, the delta measurements are retrieved by performing
normal register readings and are made available through the raw
attributes of the specific channels.

Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
---
changes in v2:
 - updated commit message
 drivers/iio/imu/adis16480.c | 72 +++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index bc6cbd00cd4b..0cd55040db93 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -140,6 +140,8 @@ struct adis16480_chip_info {
 	unsigned int accel_max_val;
 	unsigned int accel_max_scale;
 	unsigned int temp_scale;
+	unsigned int deltang_max_val;
+	unsigned int deltvel_max_val;
 	unsigned int int_clk;
 	unsigned int max_dec_rate;
 	const unsigned int *filter_freqs;
@@ -445,6 +447,12 @@ enum {
 	ADIS16480_SCAN_MAGN_Z,
 	ADIS16480_SCAN_BARO,
 	ADIS16480_SCAN_TEMP,
+	ADIS16480_SCAN_DELTANG_X,
+	ADIS16480_SCAN_DELTANG_Y,
+	ADIS16480_SCAN_DELTANG_Z,
+	ADIS16480_SCAN_DELTVEL_X,
+	ADIS16480_SCAN_DELTVEL_Y,
+	ADIS16480_SCAN_DELTVEL_Z,
 };

 static const unsigned int adis16480_calibbias_regs[] = {
@@ -688,6 +696,14 @@ static int adis16480_read_raw(struct iio_dev *indio_dev,
 			*val = 131; /* 1310mbar = 131 kPa */
 			*val2 = 32767 << 16;
 			return IIO_VAL_FRACTIONAL;
+		case IIO_DELTA_ANGL:
+			*val = st->chip_info->deltang_max_val;
+			*val2 = 31;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		case IIO_DELTA_VELOCITY:
+			*val = st->chip_info->deltvel_max_val;
+			*val2 = 31;
+			return IIO_VAL_FRACTIONAL_LOG2;
 		default:
 			return -EINVAL;
 		}
@@ -761,6 +777,24 @@ static int adis16480_write_raw(struct iio_dev *indio_dev,
 	BIT(IIO_CHAN_INFO_CALIBSCALE), \
 	32)

+#define ADIS16480_DELTANG_CHANNEL(_mod) \
+	ADIS16480_MOD_CHANNEL(IIO_DELTA_ANGL, IIO_MOD_ ## _mod, \
+	ADIS16480_REG_ ## _mod ## _DELTAANG_OUT, ADIS16480_SCAN_DELTANG_ ## _mod, \
+	0, 32)
+
+#define ADIS16480_DELTANG_CHANNEL_NO_SCAN(_mod) \
+	ADIS16480_MOD_CHANNEL(IIO_DELTA_ANGL, IIO_MOD_ ## _mod, \
+	ADIS16480_REG_ ## _mod ## _DELTAANG_OUT, -1, 0, 32)
+
+#define ADIS16480_DELTVEL_CHANNEL(_mod) \
+	ADIS16480_MOD_CHANNEL(IIO_DELTA_VELOCITY, IIO_MOD_ ## _mod, \
+	ADIS16480_REG_ ## _mod ## _DELTAVEL_OUT, ADIS16480_SCAN_DELTVEL_ ## _mod, \
+	0, 32)
+
+#define ADIS16480_DELTVEL_CHANNEL_NO_SCAN(_mod) \
+	ADIS16480_MOD_CHANNEL(IIO_DELTA_VELOCITY, IIO_MOD_ ## _mod, \
+	ADIS16480_REG_ ## _mod ## _DELTAVEL_OUT, -1, 0,	32)
+
 #define ADIS16480_MAGN_CHANNEL(_mod) \
 	ADIS16480_MOD_CHANNEL(IIO_MAGN, IIO_MOD_ ## _mod, \
 	ADIS16480_REG_ ## _mod ## _MAGN_OUT, ADIS16480_SCAN_MAGN_ ## _mod, \
@@ -816,7 +850,13 @@ static const struct iio_chan_spec adis16480_channels[] = {
 	ADIS16480_MAGN_CHANNEL(Z),
 	ADIS16480_PRESSURE_CHANNEL(),
 	ADIS16480_TEMP_CHANNEL(),
-	IIO_CHAN_SOFT_TIMESTAMP(11)
+	IIO_CHAN_SOFT_TIMESTAMP(11),
+	ADIS16480_DELTANG_CHANNEL_NO_SCAN(X),
+	ADIS16480_DELTANG_CHANNEL_NO_SCAN(Y),
+	ADIS16480_DELTANG_CHANNEL_NO_SCAN(Z),
+	ADIS16480_DELTVEL_CHANNEL_NO_SCAN(X),
+	ADIS16480_DELTVEL_CHANNEL_NO_SCAN(Y),
+	ADIS16480_DELTVEL_CHANNEL_NO_SCAN(Z),
 };

 static const struct iio_chan_spec adis16485_channels[] = {
@@ -827,7 +867,13 @@ static const struct iio_chan_spec adis16485_channels[] = {
 	ADIS16480_ACCEL_CHANNEL(Y),
 	ADIS16480_ACCEL_CHANNEL(Z),
 	ADIS16480_TEMP_CHANNEL(),
-	IIO_CHAN_SOFT_TIMESTAMP(7)
+	IIO_CHAN_SOFT_TIMESTAMP(7),
+	ADIS16480_DELTANG_CHANNEL_NO_SCAN(X),
+	ADIS16480_DELTANG_CHANNEL_NO_SCAN(Y),
+	ADIS16480_DELTANG_CHANNEL_NO_SCAN(Z),
+	ADIS16480_DELTVEL_CHANNEL_NO_SCAN(X),
+	ADIS16480_DELTVEL_CHANNEL_NO_SCAN(Y),
+	ADIS16480_DELTVEL_CHANNEL_NO_SCAN(Z),
 };

 enum adis16480_variant {
@@ -938,6 +984,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_val = IIO_M_S_2_TO_G(21973 << 16),
 		.accel_max_scale = 18,
 		.temp_scale = 5650, /* 5.65 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(180),
+		.deltvel_max_val = 100,
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
 		.has_sleep_cnt = true,
@@ -952,6 +1000,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_val = IIO_M_S_2_TO_G(12500 << 16),
 		.accel_max_scale = 10,
 		.temp_scale = 5650, /* 5.65 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(720),
+		.deltvel_max_val = 200,
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
 		.has_sleep_cnt = true,
@@ -966,6 +1016,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_val = IIO_M_S_2_TO_G(20000 << 16),
 		.accel_max_scale = 5,
 		.temp_scale = 5650, /* 5.65 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(720),
+		.deltvel_max_val = 50,
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
 		.has_sleep_cnt = true,
@@ -980,6 +1032,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_val = IIO_M_S_2_TO_G(22500 << 16),
 		.accel_max_scale = 18,
 		.temp_scale = 5650, /* 5.65 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(720),
+		.deltvel_max_val = 200,
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
 		.has_sleep_cnt = true,
@@ -994,6 +1048,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_val = IIO_M_S_2_TO_G(16000 << 16),
 		.accel_max_scale = 8,
 		.temp_scale = 14285, /* 14.285 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(720),
+		.deltvel_max_val = 200,
 		.int_clk = 4250000,
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
@@ -1008,6 +1064,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_val = IIO_M_S_2_TO_G(32000 << 16),
 		.accel_max_scale = 8,
 		.temp_scale = 12500, /* 12.5 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(360),
+		.deltvel_max_val = 100,
 		.int_clk = 4250000,
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
@@ -1025,6 +1083,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_val = IIO_M_S_2_TO_G(32000 << 16),
 		.accel_max_scale = 8,
 		.temp_scale = 12500, /* 12.5 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(720),
+		.deltvel_max_val = 100,
 		.int_clk = 4250000,
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
@@ -1042,6 +1102,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_val = IIO_M_S_2_TO_G(32000 << 16),
 		.accel_max_scale = 8,
 		.temp_scale = 12500, /* 12.5 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(2160),
+		.deltvel_max_val = 100,
 		.int_clk = 4250000,
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
@@ -1059,6 +1121,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_val = IIO_M_S_2_TO_G(32000 << 16),
 		.accel_max_scale = 40,
 		.temp_scale = 12500, /* 12.5 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(360),
+		.deltvel_max_val = 400,
 		.int_clk = 4250000,
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
@@ -1076,6 +1140,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_val = IIO_M_S_2_TO_G(32000 << 16),
 		.accel_max_scale = 40,
 		.temp_scale = 12500, /* 12.5 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(720),
+		.deltvel_max_val = 400,
 		.int_clk = 4250000,
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
@@ -1093,6 +1159,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_val = IIO_M_S_2_TO_G(32000 << 16),
 		.accel_max_scale = 40,
 		.temp_scale = 12500, /* 12.5 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(2160),
+		.deltvel_max_val = 400,
 		.int_clk = 4250000,
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
--
2.34.1


