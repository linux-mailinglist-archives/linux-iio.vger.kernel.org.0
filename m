Return-Path: <linux-iio+bounces-21362-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBBFAF9807
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 18:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9445A5E31
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 16:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2292DC326;
	Fri,  4 Jul 2025 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bmhY4JYz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123702D59EB
	for <linux-iio@vger.kernel.org>; Fri,  4 Jul 2025 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751646130; cv=none; b=AxWb9Xa/TOiDCAl8pXVHRZ5DQFj5kkWXR1zNCQqqiYf2R1mr9DFz7RFdgT5PVLWbkEGvBk2KTc4ba7NZHzCpqHOe1IOb7tCxEQWTjGghRH9rWVNWPvqnjWfHaayYbQ8zlBDNO+0NNz+xemkMRRm/w63MQtjK8DO/seLAbRh1B3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751646130; c=relaxed/simple;
	bh=1Z40vuaBlcXcT2gL2CRMf2qopjmWhxCM91PHcGJPMXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BWWRDXNTWmiY5vC3z65yy6qlWAW0/0wWiE6ubY4pn6D5mnOlg3pkjzViofkTF1ULlx0/HtIWOfnfowpq96Flo85ctpf1eb7b7ugOFQVnjnwBlXzzQY3reJ7QDYNSHxq4mXEg9Erjcq8SnSYWg6bm4FZbGv4dPQflX20IteIF+Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bmhY4JYz; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2ea080f900cso330227fac.2
        for <linux-iio@vger.kernel.org>; Fri, 04 Jul 2025 09:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751646127; x=1752250927; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sbIxRJgDwSO6eFNbPIOvHsJciGlnmaV0CB/OfWkp75M=;
        b=bmhY4JYzXO/ScIEgx5qUwRe3fMpnI+R6WzwTqlq8vXAXktcyEoja8jpxprHjhnAipE
         /KyBiKiOvv6RBVVzAgBeYoeKMccl6+i5Vyayjaudkv75WkfON+3xjRFX/rxbpefbtVnn
         YtD6AyEp2+Bhe1ej9/AInUsjOx56bZaIXc7NxPM/0GUUyCTSjQF7yi8b4MHs7qAU7pqE
         B17E2K8u/lXs331nQYwWnGnH6UKTR4OM8rmPFuq7htDsOEeL0X5eCJeOB3EtlT1Sm/Tr
         +wTHqR99LNxkjqI6zj7BWznIeQ2Hh+i0Aoi3h8ZxWAB+PrPYyIf884g/n/jY7C/1w6FP
         wrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751646127; x=1752250927;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbIxRJgDwSO6eFNbPIOvHsJciGlnmaV0CB/OfWkp75M=;
        b=cXI3wfP7K/L/OJLU+rAcsx5tEEcKZUJoRXHmvzhquXhoWz+sjeCwVHeXhTSNFtTFBr
         TBSxoGKPzxLXZA0xT9zDmqteRL3/s2grLTlyattSuq6wViBQdnfLtv1lpM4QVrUJvQQe
         NlDkT3lKQ9KfORGtvHpcnXoIs2VFj7liVq8cMjKN14ClSVqssqEM4TYvJDdoTnkBXnBR
         S1O1IiVpL/AbB8+GnvfeYW7GGPOZcuwTeysGeopgEFjVDbwzzwJ3VCboTwr96LoLqcNj
         qeKjpwI9feHYA3Ox53fjlt921/TqH/HnlNjH9FG5SnlItQDNvc+bIloA8KbuCvn7wyLr
         ZRjw==
X-Forwarded-Encrypted: i=1; AJvYcCW0Fo3w4WtVidZqs8xr7Z7CqMUjsQOGZgeEALqXRfKCirSkHPaKlLt3FoHgqLHTYg2W5XbCxdDHFfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ITFajpIZ9yA3LUigvzrZU/sUNUpgrkhR/nQtaJKFkHlFoRAX
	RL0k14xK7mjL6mDPI340utsnxJHnabeQKcqHjrMymv0P/HOrrGRtBQTq9F3Fpbz5hcI=
X-Gm-Gg: ASbGncu/iPN4jt7SD3WrLIqDc2WdvxLmLjXb+pevq0OMr5DZLw625yiosTlA/7dmxOn
	6aWB5/f0Od4MWLVlFFBG5waho4tp5/s3eAZ5nOWZcXFDbxT6iRVEqbGZs36WaPiruB1tc0gnBsu
	tqHL/U2rSq4ax0BSjQBVv5e1RF2mKEiCyD2QZ3y+1R6HFgIgK+nkzOUmnSU36jySzvQgncxutJJ
	aAkIKfGx3proud50g5CTqmNHn5BMjDRVFE8oLD9WkZ6MK+hNhAVKYsIpyNCnwgn2QNS2gxZQIGq
	z5IuSwU3zbqOknEnoPOytNnZ6gcfn/kdhZT4VHTZCgyAdPaD7V4x1is3Ywjwjx6mLuzu
X-Google-Smtp-Source: AGHT+IHu3uXF+dk/Nho7ZxH20VneUtU5w5z5usD8PtyZUwU3MbU+wVKFavOLlChdnSeFT+w6ff1QqQ==
X-Received: by 2002:a05:6871:5009:b0:2c1:5448:3941 with SMTP id 586e51a60fabf-2f791fa7cebmr2199132fac.18.1751646126861;
        Fri, 04 Jul 2025 09:22:06 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:d956:6ab3:7240:6bd9])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2f78ff048absm588075fac.5.2025.07.04.09.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 09:22:05 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 04 Jul 2025 11:21:54 -0500
Subject: [PATCH v2] iio: adc: ad7173: fix num_slots
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-iio-adc-ad7173-fix-num_slots-on-most-chips-v2-1-a74941609143@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAKH/Z2gC/52NQQ6CMBBFr0K6dkynDaCuuIchpi1VJoGWdJBIC
 He3cgQXf/F+fv7bBPtEnsWt2ETyCzHFkEGdCuF6E14eqMsslFSlrKUGogimczk11hqe9IHwHh8
 8xJkhBhgjz+B6mhjs9aKUrIySFkU+nJLP80N2bzP3xHNM6+Fe8Nf+pVkQELSqXNkhao9lY806k
 E3+7OIo2n3fv6lEpnfnAAAA
X-Change-ID: 20250703-iio-adc-ad7173-fix-num_slots-on-most-chips-b982206a20b1
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6043; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=1Z40vuaBlcXcT2gL2CRMf2qopjmWhxCM91PHcGJPMXc=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoZ/+jF5xf7dykqORLe/NNBtPf7hGtoYaLkIa4p
 hsNGcSbYTOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGf/owAKCRDCzCAB/wGP
 wAuoB/4n58J7TLyJWOTfU3AvZYQ/6NnhQ1WKop7g9CqY5cPQF8tFizAe6UV5+f9gayhvqkBhkqV
 7qwCjqpxKQDFufYowzZP8+YnSHzokb2CjMZVs8LYYl0yuuUJ06320GKU8V4QnTTAHZTeOwHuoSs
 6wM5O58ys0JICrlrC7aihHhR9VksyUqBlhIFlTZpPby+X5Lnpp85CQmdJjtIkcE5ELKTquKCxHI
 44xfkehU41JA9mUu68bo+8WKxnli6oWl3q2VzsR4Z0DqsK15fnvSvAmBOG4BevslRD/jvxOtXdY
 ipBq8ZjjhQlDSPt/HEZMEEfFyIonPRKrESWCwJ027WdD8W+H
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix the num_slots value for most chips in the ad7173 driver. The correct
value is the number of CHANNELx registers on the chip.

In commit 4310e15b3140 ("iio: adc: ad7173: don't make copy of
ad_sigma_delta_info struct"), we refactored struct ad_sigma_delta_info
to be static const data instead of being dynamically populated during
driver probe. However, there was an existing bug in commit 76a1e6a42802
("iio: adc: ad7173: add AD7173 driver") where num_slots was incorrectly
set to the number of CONFIGx registers instead of the number of
CHANNELx registers. This bug was partially propagated to the refactored
code in that the 16-channel chips were only given 8 slots instead of
16 although we did managed to fix the 8-channel chips and one of the
4-channel chips in that commit. However, we botched two of the 4-channel
chips and ended up incorrectly giving them 8 slots during the
refactoring.

This patch fixes that mistake on the 4-channel chips and also
corrects the 16-channel chips to have 16 slots.

Fixes: 4310e15b3140 ("iio: adc: ad7173: don't make copy of ad_sigma_delta_info struct")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Improve commit message.
- Link to v1: https://lore.kernel.org/r/20250703-iio-adc-ad7173-fix-num_slots-on-most-chips-v1-1-326c5d113e15@baylibre.com
---
 drivers/iio/adc/ad7173.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index dd9fa35555c79ead5a1b88d1dc6cc3db122502be..9c197cea11eb955becf4b9b97246379fa9c5da13 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -771,10 +771,27 @@ static const struct ad_sigma_delta_info ad7173_sigma_delta_info_8_slots = {
 	.num_slots = 8,
 };
 
+static const struct ad_sigma_delta_info ad7173_sigma_delta_info_16_slots = {
+	.set_channel = ad7173_set_channel,
+	.append_status = ad7173_append_status,
+	.disable_all = ad7173_disable_all,
+	.disable_one = ad7173_disable_one,
+	.set_mode = ad7173_set_mode,
+	.has_registers = true,
+	.has_named_irqs = true,
+	.supports_spi_offload = true,
+	.addr_shift = 0,
+	.read_mask = BIT(6),
+	.status_ch_mask = GENMASK(3, 0),
+	.data_reg = AD7173_REG_DATA,
+	.num_resetclks = 64,
+	.num_slots = 16,
+};
+
 static const struct ad7173_device_info ad4111_device_info = {
 	.name = "ad4111",
 	.id = AD4111_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_16_slots,
 	.num_voltage_in_div = 8,
 	.num_channels = 16,
 	.num_configs = 8,
@@ -796,7 +813,7 @@ static const struct ad7173_device_info ad4111_device_info = {
 static const struct ad7173_device_info ad4112_device_info = {
 	.name = "ad4112",
 	.id = AD4112_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_16_slots,
 	.num_voltage_in_div = 8,
 	.num_channels = 16,
 	.num_configs = 8,
@@ -817,7 +834,7 @@ static const struct ad7173_device_info ad4112_device_info = {
 static const struct ad7173_device_info ad4113_device_info = {
 	.name = "ad4113",
 	.id = AD4113_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_16_slots,
 	.num_voltage_in_div = 8,
 	.num_channels = 16,
 	.num_configs = 8,
@@ -836,7 +853,7 @@ static const struct ad7173_device_info ad4113_device_info = {
 static const struct ad7173_device_info ad4114_device_info = {
 	.name = "ad4114",
 	.id = AD4114_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_16_slots,
 	.num_voltage_in_div = 16,
 	.num_channels = 16,
 	.num_configs = 8,
@@ -855,7 +872,7 @@ static const struct ad7173_device_info ad4114_device_info = {
 static const struct ad7173_device_info ad4115_device_info = {
 	.name = "ad4115",
 	.id = AD4115_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_16_slots,
 	.num_voltage_in_div = 16,
 	.num_channels = 16,
 	.num_configs = 8,
@@ -874,7 +891,7 @@ static const struct ad7173_device_info ad4115_device_info = {
 static const struct ad7173_device_info ad4116_device_info = {
 	.name = "ad4116",
 	.id = AD4116_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_16_slots,
 	.num_voltage_in_div = 11,
 	.num_channels = 16,
 	.num_configs = 8,
@@ -893,7 +910,7 @@ static const struct ad7173_device_info ad4116_device_info = {
 static const struct ad7173_device_info ad7172_2_device_info = {
 	.name = "ad7172-2",
 	.id = AD7172_2_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_4_slots,
 	.num_voltage_in = 5,
 	.num_channels = 4,
 	.num_configs = 4,
@@ -926,7 +943,7 @@ static const struct ad7173_device_info ad7172_4_device_info = {
 static const struct ad7173_device_info ad7173_8_device_info = {
 	.name = "ad7173-8",
 	.id = AD7173_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_16_slots,
 	.num_voltage_in = 17,
 	.num_channels = 16,
 	.num_configs = 8,
@@ -943,7 +960,7 @@ static const struct ad7173_device_info ad7173_8_device_info = {
 static const struct ad7173_device_info ad7175_2_device_info = {
 	.name = "ad7175-2",
 	.id = AD7175_2_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_4_slots,
 	.num_voltage_in = 5,
 	.num_channels = 4,
 	.num_configs = 4,
@@ -960,7 +977,7 @@ static const struct ad7173_device_info ad7175_2_device_info = {
 static const struct ad7173_device_info ad7175_8_device_info = {
 	.name = "ad7175-8",
 	.id = AD7175_8_ID,
-	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.sd_info = &ad7173_sigma_delta_info_16_slots,
 	.num_voltage_in = 17,
 	.num_channels = 16,
 	.num_configs = 8,

---
base-commit: 6742eff60460e77158d4f1b233f17e0345c9e66a
change-id: 20250703-iio-adc-ad7173-fix-num_slots-on-most-chips-b982206a20b1

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


