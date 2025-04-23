Return-Path: <linux-iio+bounces-18560-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E08E3A98DA5
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 16:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29CB344697E
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 14:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9021128137E;
	Wed, 23 Apr 2025 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRsK6etV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3DD280CE6;
	Wed, 23 Apr 2025 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419638; cv=none; b=UhCdEANp0hL1bTGkXQMWk7hIIpH9W8Ga8XNUuaZ1KYoe7hlrqsaQcKsUxKnEHh6nXLUdhi4yTlW6NyjaNe+H0BQVVywrR2+RLqAMTl84HyquOURGsVf6mvfRyt2heLjufD7u1ffJP+Km1sFL9ou0Sa07mN3L9tSstN3dA5sHApw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419638; c=relaxed/simple;
	bh=m2DiDOnxwo7P6r/Y2g3QKf2ugQ/iTUOqEpyk4isYXD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HeE6ZiLoeDrXf1LwmdQ9hM3tBCDTrmcnU/Nwl4pr2gipOM2TeWtUu8msF9NPfvfYoB2Hz2zs4au95IUKHAWufW1LX4b8W1bmv4jOl3GWR/9z+p9gWn+4rji1hjXu4BlyUcP1GJuLP1GDM0e1bxzpOuOeOxuUs7YbXK1JTU3qYrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRsK6etV; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-549967c72bcso6848368e87.3;
        Wed, 23 Apr 2025 07:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745419634; x=1746024434; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bzzj3T3cP+6gwpi0+nfotNm30mzZZCWntfumX+NdTyY=;
        b=ZRsK6etVnQ8/1TuyOVMC2acHVTnMbp1QVtDBHWBpZKt8ITkERNxZLzFYBnyBTWuZxz
         N1qLnbsWDQ1uEF347QR1WQiHp3QbHCv+T+K55Lxyj3EhuCv40mGNZdZho39jTXVtYtju
         9o0yYnPvg2gwbOHPwiTZCymPbYFC3BTn+XzM+VygUtdYhypi4E5o2ABQndIz2ydxqghJ
         qu1NOCxQSonAsFWBtRKQ2f1XWFGclh0WY6ibmp6yzhbG8Qabq8rYHJleHTPuWtaPuoW9
         nduqdoiVBmg7HRi3R3XOYFc/U7OwBhdhcK+si9ZJf8zZX2i+lSqrP4iRkNBOHLz2VdET
         Oizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745419634; x=1746024434;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bzzj3T3cP+6gwpi0+nfotNm30mzZZCWntfumX+NdTyY=;
        b=PHpFV0BFDTYjVfmtaqZnfBudWhmep8CQ2UGozyG4t1atNdZuia7CfRVJS9Nn4v40yw
         p26R0qr+jtlLT+v7rQ/Mhd9aFfTBLk3GwWOf/Yh931jDdpz1durdR3b91xcL2ACuEWNa
         q3bZAfsiaH//hmuzRZvPQCSFtsA45wBmQNDP6yZsbVtUiT4p1JVopjRIhoiSOGe1ZgeN
         GINOy2sCzqb18PjNX5MAyvAaFNwDbs8O5d6CLPOG8oBG1VqEhD2sU/Ud26NYcVLQneWh
         dU36gcpFUjeVc4z9Blobb+G7iYCC5TSigM/v3NzUZFvLyPzGhe666TGHZ4swBHVBbf8L
         5YEg==
X-Forwarded-Encrypted: i=1; AJvYcCV2ZowZtBxO6SokPtCcRSTq6fjzAWYcfFSwZZnG+t24hFD+2n2sFzLF/LIeCJnrQImnSHHGZGWUetZAVQEI@vger.kernel.org, AJvYcCWEyNISg+Q7m+tzq1FZSIfcjo7AjpbHfhl/kJCwoaTbi6HAhY4ccRISGcsTYjtb6rTo2c2URjRdDQrY@vger.kernel.org, AJvYcCWyePspmFe2HO+gZfrcpYPzGuOcJFAF4hzupDsXNJpLB3fQ8lSXHREqIAV+YIL4sbs3iDRx6wHAn+6Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yye5RV86/kvt71Aag6XRgxWQf+SAcD4hy4pRlTUv5zQBKg4h/Dm
	vCkP69prCQCWse8sT0UWOlpOulMAcq48ChQbHrADhtRSg6I44bgaiq+4mpX90Xs=
X-Gm-Gg: ASbGncvAj0bV0xKiv03Y+NmA8ZhsSdeuefmOinn9+cM7rlzLZw3zUpiolwQnruz5+pj
	bfy3L6k1UpqoMQiV9W47I25bHZM79GUghZbISIQ8+9LiKKxyDVu3VyVzCy/LWMaS3U93uW45ikE
	12Z3gJTrg/7WIiFJV/3imgo02xQeqMVVKnAl/WeFFqL5ixbO8o+wkMT51bbBWvUTdBF2+Gc3my6
	wRcJJmtEiGEXHsEctSDO1Jc8TAFuh8JVR7iZvt+oYnwusbiUmqQPmBqnM54dng2s1YWtAp9HmMF
	jwCdomnqhle0hsGKW20UWkS1qv7KRWCgy23QIjjuraZaqoztHHNDdrZIS+pxupbWBUw2WOJfqhl
	PnuChTn2R
X-Google-Smtp-Source: AGHT+IGcXCDXeLXJPEW1koiq4CtmxFU6hVAFkjl67TZ+C9VF7n0TCGjERyPLqMgN7iba2Hs6LYkIMQ==
X-Received: by 2002:a05:6512:4020:b0:54c:a49:d3de with SMTP id 2adb3069b0e04-54d6e61ba8amr6160594e87.10.1745419634058;
        Wed, 23 Apr 2025 07:47:14 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d6e5f61afsm1598498e87.246.2025.04.23.07.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 07:47:12 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 23 Apr 2025 16:46:49 +0200
Subject: [PATCH 1/3] iio: adc: mcp3911: fix device dependent mappings for
 conversion result registers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-mcp3911-fixes-v1-1-5bd0b68ec481@gmail.com>
References: <20250423-mcp3911-fixes-v1-0-5bd0b68ec481@gmail.com>
In-Reply-To: <20250423-mcp3911-fixes-v1-0-5bd0b68ec481@gmail.com>
To: Kent Gustavsson <kent@minoris.se>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kent Gustavsson <nedo80@gmail.com>, devicetree@vger.kernel.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Lukas Rauber <lukas.rauber@janitza.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5186;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=m2DiDOnxwo7P6r/Y2g3QKf2ugQ/iTUOqEpyk4isYXD4=;
 b=kA0DAAgBiIBOb1ldUjIByyZiAGgI/V+hDU8d/oMRPjuYOPlaFQqGaK8ltId7Qp3Fpcf23fuDL
 okCMwQAAQgAHRYhBAVRoui2bLVNZMEsZYiATm9ZXVIyBQJoCP1fAAoJEIiATm9ZXVIyAmkQAN2s
 vgoReL7rIBZs0xcpWv/PLKMlJSod6vKxlq8Zw3vuPsvziO0awuxT6sySNZvGg6hU9fvjfWg+9wS
 RfNRMy9K/EsSV36PzKK5w4c/7y4hQoqaT2PpmL8ivtzbjKwPdRaJtJZ8lFzg4k+PjyeD9qJA+a/
 7G2ipevP0I/PNGxy1V3mk8/J5Llyt3n14L7olPymkmB7DAKm5t6h5VcGP8vTFY7/hWSsBPoQGMC
 NT8fzxFAV/m1L1cj90UacFMkCDEVG8gU4LWdfc5x/TwelPGztWNtDrgjPwJQ/LpXSaErr1ReaDl
 /YJL01ChcejuKrYjR+5px5p6wzXv3EaxTZWmUebrtsMD66yGoCgYCXpNhW5/LTW/RtiLT/8fdV2
 Q7BCCKCkrd/HZfH9WOggfqUFs6UsmiMnfh5gbYaXTT5VBuB4gm51sW9hDktFyAHPn8RJKJM+Dul
 nsuh3bu5kKf+i7cuyRJacEv1/0+QrkfjS/6Hbgqnx3YVTZqU8M+0zjyngf9w4TFdNc9EGlTgKDG
 bSCPLZnuJwEcpcXs00ZY1G0Z9Xft0kPRlkfbU8G7pFBjgb/aslacu6VPKq2+vKpmZU77wlig4kq
 oH0LJy/cqGsoGkdJXKmJU+Vn8q4583jgSp6x8g+8jJtJTf53pkn3BhBiA35Ridu2t1s9/aZ59j/
 lLCS0
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

The conversion result registers differs between devices. Make sure the
mapping is correct by using a device dependent .get_raw() callback function.

Fixes: 732ad34260d3 ("iio: adc: mcp3911: add support for the whole MCP39xx family")

Co-developed-by: Lukas Rauber <lukas.rauber@janitza.de>
Signed-off-by: Lukas Rauber <lukas.rauber@janitza.de>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 6748b44d568db68120172a950bbfffb6adc7cfa3..b72ed4928da88664a00dc143ebf218cb4a7be421 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -79,6 +79,8 @@
 #define MCP3910_CONFIG1_CLKEXT		BIT(6)
 #define MCP3910_CONFIG1_VREFEXT		BIT(7)
 
+#define MCP3910_CHANNEL(ch)		(MCP3911_REG_CHANNEL0 + (ch))
+
 #define MCP3910_REG_OFFCAL_CH0		0x0f
 #define MCP3910_OFFCAL(ch)		(MCP3910_REG_OFFCAL_CH0 + (ch) * 6)
 
@@ -110,6 +112,7 @@ struct mcp3911_chip_info {
 	int (*get_offset)(struct mcp3911 *adc, int channel, int *val);
 	int (*set_offset)(struct mcp3911 *adc, int channel, int val);
 	int (*set_scale)(struct mcp3911 *adc, int channel, u32 val);
+	int (*get_raw)(struct mcp3911 *adc, int channel, int *val);
 };
 
 struct mcp3911 {
@@ -170,6 +173,18 @@ static int mcp3911_update(struct mcp3911 *adc, u8 reg, u32 mask, u32 val, u8 len
 	return mcp3911_write(adc, reg, val, len);
 }
 
+static int mcp3911_read_s24(struct mcp3911 *const adc, u8 const reg, s32 *const val)
+{
+	u32 uval;
+	int const ret = mcp3911_read(adc, reg, &uval, 3);
+
+	if (ret)
+		return ret;
+
+	*val = sign_extend32(uval, 23);
+	return ret;
+}
+
 static int mcp3910_enable_offset(struct mcp3911 *adc, bool enable)
 {
 	unsigned int mask = MCP3910_CONFIG0_EN_OFFCAL;
@@ -194,6 +209,11 @@ static int mcp3910_set_offset(struct mcp3911 *adc, int channel, int val)
 	return adc->chip->enable_offset(adc, 1);
 }
 
+static int mcp3910_get_raw(struct mcp3911 *adc, int channel, s32 *val)
+{
+	return mcp3911_read_s24(adc, MCP3910_CHANNEL(channel), val);
+}
+
 static int mcp3911_enable_offset(struct mcp3911 *adc, bool enable)
 {
 	unsigned int mask = MCP3911_STATUSCOM_EN_OFFCAL;
@@ -218,6 +238,11 @@ static int mcp3911_set_offset(struct mcp3911 *adc, int channel, int val)
 	return adc->chip->enable_offset(adc, 1);
 }
 
+static int mcp3911_get_raw(struct mcp3911 *adc, int channel, s32 *val)
+{
+	return mcp3911_read_s24(adc, MCP3911_CHANNEL(channel), val);
+}
+
 static int mcp3910_get_osr(struct mcp3911 *adc, u32 *val)
 {
 	int ret;
@@ -321,12 +346,9 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 	guard(mutex)(&adc->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = mcp3911_read(adc,
-				   MCP3911_CHANNEL(channel->channel), val, 3);
+		ret = adc->chip->get_raw(adc, channel->channel, val);
 		if (ret)
 			return ret;
-
-		*val = sign_extend32(*val, 23);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
 		ret = adc->chip->get_offset(adc, channel->channel, val);
@@ -799,6 +821,7 @@ static const struct mcp3911_chip_info mcp3911_chip_info[] = {
 		.get_offset = mcp3910_get_offset,
 		.set_offset = mcp3910_set_offset,
 		.set_scale = mcp3910_set_scale,
+		.get_raw = mcp3910_get_raw,
 	},
 	[MCP3911] = {
 		.channels = mcp3911_channels,
@@ -810,6 +833,7 @@ static const struct mcp3911_chip_info mcp3911_chip_info[] = {
 		.get_offset = mcp3911_get_offset,
 		.set_offset = mcp3911_set_offset,
 		.set_scale = mcp3911_set_scale,
+		.get_raw = mcp3911_get_raw,
 	},
 	[MCP3912] = {
 		.channels = mcp3912_channels,
@@ -821,6 +845,7 @@ static const struct mcp3911_chip_info mcp3911_chip_info[] = {
 		.get_offset = mcp3910_get_offset,
 		.set_offset = mcp3910_set_offset,
 		.set_scale = mcp3910_set_scale,
+		.get_raw = mcp3910_get_raw,
 	},
 	[MCP3913] = {
 		.channels = mcp3913_channels,
@@ -832,6 +857,7 @@ static const struct mcp3911_chip_info mcp3911_chip_info[] = {
 		.get_offset = mcp3910_get_offset,
 		.set_offset = mcp3910_set_offset,
 		.set_scale = mcp3910_set_scale,
+		.get_raw = mcp3910_get_raw,
 	},
 	[MCP3914] = {
 		.channels = mcp3914_channels,
@@ -843,6 +869,7 @@ static const struct mcp3911_chip_info mcp3911_chip_info[] = {
 		.get_offset = mcp3910_get_offset,
 		.set_offset = mcp3910_set_offset,
 		.set_scale = mcp3910_set_scale,
+		.get_raw = mcp3910_get_raw,
 	},
 	[MCP3918] = {
 		.channels = mcp3918_channels,
@@ -854,6 +881,7 @@ static const struct mcp3911_chip_info mcp3911_chip_info[] = {
 		.get_offset = mcp3910_get_offset,
 		.set_offset = mcp3910_set_offset,
 		.set_scale = mcp3910_set_scale,
+		.get_raw = mcp3910_get_raw,
 	},
 	[MCP3919] = {
 		.channels = mcp3919_channels,
@@ -865,6 +893,7 @@ static const struct mcp3911_chip_info mcp3911_chip_info[] = {
 		.get_offset = mcp3910_get_offset,
 		.set_offset = mcp3910_set_offset,
 		.set_scale = mcp3910_set_scale,
+		.get_raw = mcp3910_get_raw,
 	},
 };
 static const struct of_device_id mcp3911_dt_ids[] = {

-- 
2.49.0


