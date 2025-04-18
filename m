Return-Path: <linux-iio+bounces-18280-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A6CA93C08
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 19:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7991A7A72EE
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 17:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B65215F5F;
	Fri, 18 Apr 2025 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nh3izjpx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72761487F4;
	Fri, 18 Apr 2025 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744997606; cv=none; b=Xmigz2RCdSjjhKHFaSJ9GX6KVxfGr28fW2ynXS1FfhtsyDjror5c/SSAibHWuB0mmxCedjjndSd4vqVjwWvEDyVcs6tbjCFwzx+ZhAieD6k0hO9+dAVELtymJRCALql7pFQqIRNV9t1hiiYX2lW8AcBTYB/XyqT4BKaz6GhE6O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744997606; c=relaxed/simple;
	bh=SJZAuEqKXmhALWmYOXKFLmd3w3nQUws2fGTQHVOurCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iRKK8f97HibtSVakfiVegwkCdDp83TnX6hcQy5ZfCiwtbIktmeL0D9348qvAmDNM1uY+udmZuGvFnK9Z8/GoqC9miVpx3Rnzy8YpsKdA4WGpwlVb3GRaWi282//oxq6WdJpF5jSB6x+uGru5Favwl3nxwm4FgIZCTTZCMiKKVyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nh3izjpx; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c081915cf3so275029385a.1;
        Fri, 18 Apr 2025 10:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744997603; x=1745602403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KPoq3aflqbH39XCuDdhyU0hYsjcWA8sDyaLTiOfT/KY=;
        b=nh3izjpxaqf245octS0RP4K+FW+7/A2VTO+MHGC/ERCMODRadnsF2nuWrKFLUSQRKN
         k1pqItxSgdBgwfgp8kMSnWh8P5UvW5TO6si7i9/W0fGfmbmxwClMFzVlEEHBZKMqlBhm
         c0Sc7wNrowT2GKwvg6dosKNAMSOct5Sh822K8wtnLv7J3gSckBUaUHfVEpNwtALIDsJH
         M/uHPpVwrP7PcumhAIoARs3xO54Aanftw8ILHeEaC3LyooclEVkqypB1ek0q+cWU707W
         kmIXZ7rsV28ILti6TS2JEL+8rUFdXB1gS7Gb6EslJ/TTxVQ3CYslOFoLFw7A1gJ96rc5
         G9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744997603; x=1745602403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPoq3aflqbH39XCuDdhyU0hYsjcWA8sDyaLTiOfT/KY=;
        b=aWuH2OUDgXvmwfFsHQp2INJaY6S6sd5WY9reNwy0j8tI1gI0+7JfEwfQY+8aX20JUm
         +RGE193Xh420/xHIPEYw7b5QRwP4nzZfb8gPSsC22OWM+/ryH26+elPbZMr1uEpyOC5e
         vdbBGmKTfULwQ56rLqa6oeqGwZ2/2s7avmjTd98YTxpO3cCdddgt7aAScqCHMyWVEHJa
         SZGcTi23pYnx9GVWk4B6LKMZCptecIMliV+kjUGd2Sge/7AhQtLYt3xDsDgBDZdpScAw
         c+2yXaOFEQSEHrGppOgrbms/1b/7Jw8ejm1kys4GzWLGwHnG4GtBWKaIYAlgtbVK89pU
         UAUg==
X-Forwarded-Encrypted: i=1; AJvYcCVerH79M+cN7luRZs0iBCPPbEoIlTLsUzVKRJpzAF0ctzB6iBhAlCubotcNCN6gvi7O+32lbMlhW4A=@vger.kernel.org, AJvYcCWAljYjcMFgnmZ1CAvVh9C3f0liGMOEoK3wMXt1vPYqYdDjbsqZW/Y8lAkrhOFQu/OABh2TkKQ2c4dzK/Ar@vger.kernel.org
X-Gm-Message-State: AOJu0YxY1W9tT8tv5LK6O7SC7HngQbzS6rwkzj8KWrjD4+u7y4PhrK65
	HSUzMCTDiTjEJ9vqPyUHOZZheOJo1NQzRy4GpQTyBwZcrji64SA1
X-Gm-Gg: ASbGnctGAQ52ghJ/cfT4zVz5yvExLn1DnyKc++bEkTPkpyZTZFXJeT1+MfInORBHN/O
	wKsr/QotszTyH/pbm33mLQrz+mycyw0LjUtGn4EgrYwZHUJTQbbcpxvpGTtw/cRoS7J4o6VkvS3
	I+X83MQ0cGyHNfpWeYm38TVQriG+U5Lq+ta4TtXx3gyj2Wmj/m7U67Em4bABGHsNgkviH9Bwu/f
	0jelgfQf2C5Gj6FoYKhmnXGNXYVY0osqtt0rrjoGKwtNqIoPMwwKlKDgCUftLUTwexUi9EBS+Tv
	fCM0FPrkTeVBu1WzxytGGDmMudnax7hidWiSAkU7s9FdwbK2HAL8XdYsQOj/RTOaWCMZ0znO50L
	1zaGRO/9y8ne+5Nnx1cs=
X-Google-Smtp-Source: AGHT+IFnLePQm7kXWpY2CuLdLExZj4cttiuv8NDIp5CUUJMcriJSGlJof2gfryFKXUa4IRKWmb+U6g==
X-Received: by 2002:a05:620a:288d:b0:7c5:4a51:238 with SMTP id af79cd13be357-7c927e491e9mr505177085a.0.1744997603405;
        Fri, 18 Apr 2025 10:33:23 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a8fff2sm128914585a.38.2025.04.18.10.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 10:33:23 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Michael.Hennerich@analog.com
Cc: gshahrouzi@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2] staging: iio: accel: adis16203: Fix single-axis representation
Date: Fri, 18 Apr 2025 13:33:12 -0400
Message-ID: <20250418173313.629606-1-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADIS16203 is a single-axis 360 degree inclinometer. The previous
driver code incorrectly represented this by defining separate X and Y
inclination channels based on the two different output format registers
(0x0C for 0-360 deg, 0x0E for +/-180 deg). This violated IIO conventions
and misrepresented the hardware's single angle output. The 'Fixme'
comment on the original Y channel definition indicated this known issue.

Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
Changes in v2:
	- Check write value range in adis16203_write_raw.
	- Remove 0x3FFF mask in adis16203_write_raw.
	- Remove explicit shift = 0 in channel definition.
	- Keep original channel ordering.
	- Add staging prefix to subject line.
---
 drivers/staging/iio/accel/adis16203.c | 53 ++++++++++++++++-----------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index c1c73308800c5..620e0b96d3b22 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -28,11 +28,11 @@
 /* Output, temperature */
 #define ADIS16203_TEMP_OUT       0x0A
 
-/* Output, x-axis inclination */
-#define ADIS16203_XINCL_OUT      0x0C
+/* Output, 360 deg format */
+#define ADIS16203_INCL_OUT       0x0C
 
-/* Output, y-axis inclination */
-#define ADIS16203_YINCL_OUT      0x0E
+/* Output, +/-180 deg format */
+#define ADIS16203_INCL_180_OUT   0x0E
 
 /* Incline null calibration */
 #define ADIS16203_INCL_NULL      0x18
@@ -128,8 +128,7 @@
 #define ADIS16203_ERROR_ACTIVE          BIT(14)
 
 enum adis16203_scan {
-	 ADIS16203_SCAN_INCLI_X,
-	 ADIS16203_SCAN_INCLI_Y,
+	 ADIS16203_SCAN_INCLI,
 	 ADIS16203_SCAN_SUPPLY,
 	 ADIS16203_SCAN_AUX_ADC,
 	 ADIS16203_SCAN_TEMP,
@@ -137,10 +136,6 @@ enum adis16203_scan {
 
 #define DRIVER_NAME		"adis16203"
 
-static const u8 adis16203_addresses[] = {
-	[ADIS16203_SCAN_INCLI_X] = ADIS16203_INCL_NULL,
-};
-
 static int adis16203_write_raw(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan,
 			       int val,
@@ -148,10 +143,17 @@ static int adis16203_write_raw(struct iio_dev *indio_dev,
 			       long mask)
 {
 	struct adis *st = iio_priv(indio_dev);
-	/* currently only one writable parameter which keeps this simple */
-	u8 addr = adis16203_addresses[chan->scan_index];
 
-	return adis_write_reg_16(st, addr, val & 0x3FFF);
+	switch (mask) {
+	case IIO_CHAN_INFO_CALIBBIAS:
+		if (chan->scan_index != ADIS16203_SCAN_INCLI)
+			return -EINVAL;
+		if (val < -BIT(13) || val >= BIT(13))
+			return -EINVAL;
+		return adis_write_reg_16(st, ADIS16203_INCL_NULL, val);
+	default:
+		return -EINVAL;
+	}
 }
 
 static int adis16203_read_raw(struct iio_dev *indio_dev,
@@ -161,7 +163,6 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 {
 	struct adis *st = iio_priv(indio_dev);
 	int ret;
-	u8 addr;
 	s16 val16;
 
 	switch (mask) {
@@ -194,8 +195,9 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 		*val = 25000 / -470 - 1278; /* 25 C = 1278 */
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBBIAS:
-		addr = adis16203_addresses[chan->scan_index];
-		ret = adis_read_reg_16(st, addr, &val16);
+		if (chan->scan_index != ADIS16203_SCAN_INCLI)
+			return -EINVAL;
+		ret = adis_read_reg_16(st, ADIS16203_INCL_NULL, &val16);
 		if (ret)
 			return ret;
 		*val = sign_extend32(val16, 13);
@@ -208,11 +210,20 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 static const struct iio_chan_spec adis16203_channels[] = {
 	ADIS_SUPPLY_CHAN(ADIS16203_SUPPLY_OUT, ADIS16203_SCAN_SUPPLY, 0, 12),
 	ADIS_AUX_ADC_CHAN(ADIS16203_AUX_ADC, ADIS16203_SCAN_AUX_ADC, 0, 12),
-	ADIS_INCLI_CHAN(X, ADIS16203_XINCL_OUT, ADIS16203_SCAN_INCLI_X,
-			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
-	/* Fixme: Not what it appears to be - see data sheet */
-	ADIS_INCLI_CHAN(Y, ADIS16203_YINCL_OUT, ADIS16203_SCAN_INCLI_Y,
-			0, 0, 14),
+	{
+		.type = IIO_INCLI,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+					BIT(IIO_CHAN_INFO_SCALE) |
+					BIT(IIO_CHAN_INFO_CALIBBIAS),
+		.address = ADIS16203_INCL_180_OUT,
+		.scan_index = ADIS16203_SCAN_INCLI,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 14,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
 	ADIS_TEMP_CHAN(ADIS16203_TEMP_OUT, ADIS16203_SCAN_TEMP, 0, 12),
 	IIO_CHAN_SOFT_TIMESTAMP(5),
 };
-- 
2.43.0


