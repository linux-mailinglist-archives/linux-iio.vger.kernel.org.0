Return-Path: <linux-iio+bounces-25104-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CB5BDF9B2
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 18:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D4E402C33
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 16:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939FD2D3A7C;
	Wed, 15 Oct 2025 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fagthP9B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6988E29C351
	for <linux-iio@vger.kernel.org>; Wed, 15 Oct 2025 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544986; cv=none; b=hC+x2Y0sulGBCCD8Ffq8WjnG88Vz/+BQUZtgNm40epdIOwG4esB0EFLKERf2QWXjyZ79p0yjDT7sUF1ZFvLBYtU9bcmi7SO0OQkOqlUwvgHpEUdntA38W7vbUB4h0NyJB8bEzcKxKto21iP9wPOxx89KwJFQ5wAge7/WwtKx5oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544986; c=relaxed/simple;
	bh=ABsvn3CifAgPNbiNNauHoJn45SqYrllPKwIsUYgWcok=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NLMBh6qc3Q/v6DZcOM0WynKGo7A0Gw2H0ev+bM/YrxMu5p90/PEjJbYAcJJEBTLqF6eKWAYjyZNUgLlaYfnBFAsHojkOEbURXm7be1IXcDjBmjFE2LaghK6bALCHgO2aG07O2TsELnvjHGIbBjQSMUqna4Pjx6ddaOEXjv7PpmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fagthP9B; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee1381b835so4522543f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 15 Oct 2025 09:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760544983; x=1761149783; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1jhFeHhxricwTrw7zKiCatYtcIZJsLq8LCeG7tZdkc=;
        b=fagthP9B2lnlOjQ0CwRDGj48stZvJsdAqoQ8CesHOMEDfnwIjdNpHe+PbGsOAAptQH
         Bpnqlm67GKPP5qrz/BmOe2kUpYB50Rg68qYfGN6+iBefgrUVwKJnJlABP/IXPzOkZA4+
         FJIThW1eKa1wMnrXaPTfhfAeOq6nvnRKvRPNt8Vr2Im8IFEe18YOFnFNfyKi4cw+I4IP
         sd76j0ruF9WpTkoPzvUxOuHnDBvi6p0OEwYJ/UtrX9ofMBrd96+brexgZRO2HKUxxB7Y
         E6Q7wHQY5TxrTi+8+9tJruSEP6TYmpfX6acmn85RU91CBzE05rZfX5E9NF5sklTGk4OV
         CCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760544983; x=1761149783;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1jhFeHhxricwTrw7zKiCatYtcIZJsLq8LCeG7tZdkc=;
        b=AuuKJKN4DfXO4F6Ex5wkX/pJPzAocCznaVCUhNCAYcfx2Zx3Sns/zUSbGraTZ/2ysa
         n7mMWKjkKKo7x5rU91kVDdDnKI7Au1VwFqg/HXICCOBcZa8WrJnUUW7cESOgJaA82A3Y
         31S8NTpy51WfxQkXepldF/KOlval7TLI9dsdltG2MUZdWy1PrutX6h5mKMcSmsYAFE7y
         wepjjsJUAOXd9LOBY5xP0+8bb4XmnNpM3sjlvWQx7HlVdn6IMFOMlR7ovAna7jIrzyuP
         5VvPNtK3yk0BSqzSbGx6VzFtrSOya9AX6J01hdzYiY/PFxe7dhQgffz0Ma/1mjpRxryo
         iCUA==
X-Forwarded-Encrypted: i=1; AJvYcCVjgHBF33KIAuof8muyZGVoE/iT1l6epum45SldjOJWVXUUo9X8WsN/b4E6k3uAbhAPOKhOlzi/5BM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1be8N3ggfqGQAJ0LJTMuRdAQtxcBkcnBmEGVnXfAz6S70vZ4W
	Yn6ynG7UVKfFX472r+1Lz+PoB6iY8hQAC4GTd5u67sjwVnun/bbi88dI
X-Gm-Gg: ASbGncvtTcNoGcIGuY4h4SQqzmZrfyaeDVHhzLj89XhS8J6PPGKGk9Y8DWN8T6/mnhg
	BIPhY0ub82hgJhN2Xv/+uWuzm3+r4Kx7jVakSe+eLS6sQnQAEDBUM5DNV3sZ76lVXJ4PHdq8NeJ
	wSQQhp/x8AMQd7f1TlKvCfdWsqB/JmQf/2ikmRbtmRMJbd7CCrrp8flszU/vGDu5nW/rGzy+uC5
	MGuWsaHdNqWFOCqPEYYNCt08W6kbc54Ew35ztagQYv0AExmjBfDwFQtbMXb67T9Ofxl7tXewW5b
	y9BGPeIYs9fn5fBNUxNnNK+5gBegtgIzqfe6FuHdSRWRzTVSe5R/JdtwLQAQEp+E+yaBpboofcq
	F5m/b9iRrAcW/5NlSm9sFw6iSN5WqRyH40Iu6wExwU5x6A7cR0McXL87IasR5+hc=
X-Google-Smtp-Source: AGHT+IEDFLngjLhH+qa5J3SdfKbetfYwDdtqRpZ172a3AEduhHeAZwUjGeGS3B4m2q6J/gfPbFxn8A==
X-Received: by 2002:a05:6000:2586:b0:425:73ef:b034 with SMTP id ffacd0b85a97d-4266e8f7f4cmr20106882f8f.36.1760544982479;
        Wed, 15 Oct 2025 09:16:22 -0700 (PDT)
Received: from ctocxl9700.oa.cto.st.com ([37.161.98.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47101be3468sm38033775e9.2.2025.10.15.09.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 09:16:21 -0700 (PDT)
From: Mario Tesi <martepisa@gmail.com>
X-Google-Original-From: Mario Tesi <mario.tesi@st.com>
Date: Wed, 15 Oct 2025 18:16:19 +0200
To: lorenzo@kernel.org, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: st_lsm6dsx: Fixed calibrated timestamp calculation
Message-ID: <20251015161619.GA87736@ctocxl9700.cto.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The calibrated timestamp is calculated from the nominal value using the
formula:
  ts_gain[ns] ≈ ts_sensitivity - (ts_trim_coeff * val) / 1000.

The values of ts_sensitivity and ts_trim_coeff are not the same for all
devices, so it is necessary to differentiate them based on the part name.
For the correct values please consult the relevant AN.

Signed-off-by: Mario Tesi <mario.tesi@st.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      | 18 ++++++++++++++++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 19 ++++++++-----------
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index c225b246c8a5..f8486a1b02d0 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -192,6 +192,22 @@ struct st_lsm6dsx_fifo_ops {
  * @fifo_en: Hw timer FIFO enable register info (addr + mask).
  * @decimator: Hw timer FIFO decimator register info (addr + mask).
  * @freq_fine: Difference in % of ODR with respect to the typical.
+ * @ts_sensitivity: Nominal timestamp sensitivity.
+ * @ts_trim_coeff: Coefficient for calculating the calibrated timestamp gain.
+ *                 This coefficient comes into play when linearizing the formula
+ *                 used to calculate the calibrated timestamp (please see the
+ *                 relevant formula in the AN for the specific IMU).
+ *                 For example, in the case of LSM6DSO we have:
+ *
+ *                  1 / (1 + x) ~= 1 - x (Taylor’s Series)
+ *                  ttrim[s] = 1 / (40000 * (1 + 0.0015 * val)) (from AN5192)
+ *                  ttrim[ns] ~= 25000 - 37.5 * val
+ *                  ttrim[ns] ~= 25000 - (37500 * val) / 1000
+ *
+ *                  so, replacing ts_sensitivity = 25000 and
+ *                  ts_trim_coeff = 37500
+ *
+ *                  ttrim[ns] ~= ts_sensitivity - (ts_trim_coeff * val) / 1000
  */
 struct st_lsm6dsx_hw_ts_settings {
 	struct st_lsm6dsx_reg timer_en;
@@ -199,6 +215,8 @@ struct st_lsm6dsx_hw_ts_settings {
 	struct st_lsm6dsx_reg fifo_en;
 	struct st_lsm6dsx_reg decimator;
 	u8 freq_fine;
+	u16 ts_sensitivity;
+	u16 ts_trim_coeff;
 };
 
 /**
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index d8cb4b0218d5..a2daf0c14d96 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -94,8 +94,6 @@
 
 #define ST_LSM6DSX_REG_WHOAMI_ADDR		0x0f
 
-#define ST_LSM6DSX_TS_SENSITIVITY		25000UL /* 25us */
-
 static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
 	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
 	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x2a, IIO_MOD_Y, 1),
@@ -983,6 +981,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(7, 6),
 			},
 			.freq_fine = 0x63,
+			.ts_sensitivity = 25000,
+			.ts_trim_coeff = 37500,
 		},
 		.shub_settings = {
 			.page_mux = {
@@ -1196,6 +1196,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(7, 6),
 			},
 			.freq_fine = 0x63,
+			.ts_sensitivity = 25000,
+			.ts_trim_coeff = 37500,
 		},
 		.event_settings = {
 			.enable_reg = {
@@ -1371,6 +1373,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(7, 6),
 			},
 			.freq_fine = 0x4f,
+			.ts_sensitivity = 21701,
+			.ts_trim_coeff = 28212,
 		},
 		.shub_settings = {
 			.page_mux = {
@@ -2248,20 +2252,13 @@ static int st_lsm6dsx_init_hw_timer(struct st_lsm6dsx_hw *hw)
 	}
 
 	/* calibrate timestamp sensitivity */
-	hw->ts_gain = ST_LSM6DSX_TS_SENSITIVITY;
+	hw->ts_gain = ts_settings->ts_sensitivity;
 	if (ts_settings->freq_fine) {
 		err = regmap_read(hw->regmap, ts_settings->freq_fine, &val);
 		if (err < 0)
 			return err;
 
-		/*
-		 * linearize the AN5192 formula:
-		 * 1 / (1 + x) ~= 1 - x (Taylor’s Series)
-		 * ttrim[s] = 1 / (40000 * (1 + 0.0015 * val))
-		 * ttrim[ns] ~= 25000 - 37.5 * val
-		 * ttrim[ns] ~= 25000 - (37500 * val) / 1000
-		 */
-		hw->ts_gain -= ((s8)val * 37500) / 1000;
+		hw->ts_gain -= ((s8)val * ts_settings->ts_trim_coeff) / 1000;
 	}
 
 	return 0;
-- 
2.25.1


