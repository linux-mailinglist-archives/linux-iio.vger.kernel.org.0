Return-Path: <linux-iio+bounces-18151-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A85C6A8AB46
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 00:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2480189823C
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 22:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF961284687;
	Tue, 15 Apr 2025 22:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OliikUH7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236EC2517BC;
	Tue, 15 Apr 2025 22:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744756020; cv=none; b=q1MA3BsiVaZCJ13bzPor0ZqrPPjETxLkK1ZJCVsRaWZ6wW97QwrwOjoCBuVR42Hzme/TktMebJ2Yne+LXm5bPB8pI2ZcX9yjbawTg6uk+/Bf9xA8wBKnxOo2PtA/I+F2a2Mbt8L7BXpgxEK4bj9UVN2zMGMnnSNUnHBOTttbV1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744756020; c=relaxed/simple;
	bh=zsi89bgSmtU7lZblT+BF8md3DDnpqHXHre5LbRWl+o4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YuX6WPwqyeMMVw7DF18AItIKB4pPtnU8o24yZk0F5ImZQ59cl/FGdDi38E1JFgTix9HXRNTIQWrmaIc2DRB6+XWBixbt6oXlBZU72FfLIe0KlDreaIBN1q7L2VgHH66ifFq8XHajNzPLWDIVMUMhnEFmgZgxJy0tH9Pr/RCu8fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OliikUH7; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c08f9d0ef3so358844085a.2;
        Tue, 15 Apr 2025 15:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744756018; x=1745360818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tEYNZDctBCSE23/ne3WNMM44X6P5xxUVs1sGie06hNs=;
        b=OliikUH7gnYvgkoOtXLt8ljQ2nDvaMRMGS5vVzn7+PTiVyqRg4ZJmvKV92vRigU3Wt
         sCs9Eg/SyXiCg1LOxlvEwx9I/WrGfgGJMiwRPsB3nJ3zbTbVlpqmXvKWtPVh3wAkfbL7
         CsxBzE026vQcRC/5PYV8watREqX4eZwGwJrTJ2NTNdsmHrh6zsw4RSNaIZGHXmeJUqa4
         o+018zz7rZ05S9DOMDgvhWsJq2HzuEzBPLaV4NS53wyYeXDcGMeyltQNyJtclPCl4wd0
         xFhlVxXdmPu29eLT7zP7Sv9pQ0/aPKXXufo2TnFyAZfy/bTLRjgeM1L64hMdoEdnUTrf
         +2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744756018; x=1745360818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tEYNZDctBCSE23/ne3WNMM44X6P5xxUVs1sGie06hNs=;
        b=rWWTKaX5/c+tRDm4e+gV+OXB5Xmvfm5luekfr3fgBVOpWu+/0vR4Dwv9yA2veixZo5
         XuvhjFv03sL90PJ56QN1AaxxoTkC+Q3RhYOpQAnh9EBeyxkixzjbR5RGOCl35proKeJW
         orbLTFbIuvcZHc7A5k8kVHYNl41olYktxvmV0hBxLu8MoHYOOdW3f974aCRPVs83XyuF
         tJlM1PvlWiXu2b0IeRHMZM9shsXNKiUsa4Y9AxIJ5m3dTBcKACd94BW3dfs4kB5NbKq0
         fjKJBJm2F6d5YRKN3Gd0oJ8e2ZpjKfPcKQg9pxMvzrfGb/AOg+KYsB8Q4FJ6OCSx/YrC
         rnFw==
X-Forwarded-Encrypted: i=1; AJvYcCV046dcZvJ7lNWegFP2wEoSIsyM/jOQxp+FIt1kbosT0iylBiYpNqZRTUJ0iViieCaw12YH4Vy9flk=@vger.kernel.org, AJvYcCXHcqU/ACoRFw+MYLW4ucfDFqUf5WsxiFZ6OgVtOTnD5efCHKSGM+gYJn+B6TyFpJxDtQciS0P7h5Rm8mFX@vger.kernel.org
X-Gm-Message-State: AOJu0YywoEYxM7eLam6F40AYqYc1hC28VXRv9dl52UdRWKiW6GzlnXMS
	LbtTjS1UpnwTgBDeyBdkCWI7vcHnjrwF/UDq1kNbEdZcDSMqtvHr
X-Gm-Gg: ASbGnctV/x23OXvR71MmffkYSvz6FB4NTBxZPfw1R/fKDRbZCte/QTaAqGGyI6pnZCA
	UspG8RS0vC73FoAKXkbS30vgBSWpZcAF6OkJdT1pj/DR/+l3guP//++aBIXkxwyfg/2m5kNAGcV
	xCmjOdTWkCEBgqeRT1fe8Z2HUSlEjfmgQ0o6s8NP1n/kNbRD0DPSG3Q+ftCdDqHna/ztW7EODSi
	UqatgOHFwf84OaE22Znj+sfYPMSrtxIajRMH9MPOXoDqvGZj3AqLMWTvpkHJuuNDWsju6RFweAy
	XQ39hAWcnTPT3Lf1P4tV8TT6Df7RyMbN5sBVQPheMXmfSrUa5lTTxPQ=
X-Google-Smtp-Source: AGHT+IFBHn0VTQXG525RZ9QG9jMGNPm1rALizW+qaDZYU0/aS/yRxxUN3aj2878kI9kfa9Z9sCaOVg==
X-Received: by 2002:a05:620a:31a3:b0:7c5:9b93:8f64 with SMTP id af79cd13be357-7c91424103emr213318985a.37.1744756017807;
        Tue, 15 Apr 2025 15:26:57 -0700 (PDT)
Received: from theriatric.mshome.net ([73.123.232.110])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4796edc1af2sm98154531cf.69.2025.04.15.15.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 15:26:57 -0700 (PDT)
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
	kernelmentees@lists.linuxfoundation.org
Subject: [PATCH] iio: accel: adis16203: Fix single-axis representation and CALIBBIAS handling
Date: Tue, 15 Apr 2025 18:26:52 -0400
Message-ID: <20250415222652.545026-1-gshahrouzi@gmail.com>
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
Not sure to put a fixes tag here or not because the driver used to be
spread out across multiple files until it was whittled down to one file
using a common interface for similar devices.
---
 drivers/staging/iio/accel/adis16203.c | 52 ++++++++++++++++-----------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index c1c73308800c5..73288121bf0bd 100644
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
@@ -148,10 +143,15 @@ static int adis16203_write_raw(struct iio_dev *indio_dev,
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
+		return adis_write_reg_16(st, ADIS16203_INCL_NULL, val & 0x3FFF);
+	default:
+		return -EINVAL;
+	}
 }
 
 static int adis16203_read_raw(struct iio_dev *indio_dev,
@@ -161,7 +161,6 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 {
 	struct adis *st = iio_priv(indio_dev);
 	int ret;
-	u8 addr;
 	s16 val16;
 
 	switch (mask) {
@@ -194,8 +193,9 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
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
@@ -206,13 +206,23 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_chan_spec adis16203_channels[] = {
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
+			.shift = 0,
+			.endianness = IIO_CPU,
+		},
+	},
 	ADIS_SUPPLY_CHAN(ADIS16203_SUPPLY_OUT, ADIS16203_SCAN_SUPPLY, 0, 12),
 	ADIS_AUX_ADC_CHAN(ADIS16203_AUX_ADC, ADIS16203_SCAN_AUX_ADC, 0, 12),
-	ADIS_INCLI_CHAN(X, ADIS16203_XINCL_OUT, ADIS16203_SCAN_INCLI_X,
-			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
-	/* Fixme: Not what it appears to be - see data sheet */
-	ADIS_INCLI_CHAN(Y, ADIS16203_YINCL_OUT, ADIS16203_SCAN_INCLI_Y,
-			0, 0, 14),
 	ADIS_TEMP_CHAN(ADIS16203_TEMP_OUT, ADIS16203_SCAN_TEMP, 0, 12),
 	IIO_CHAN_SOFT_TIMESTAMP(5),
 };
-- 
2.43.0


