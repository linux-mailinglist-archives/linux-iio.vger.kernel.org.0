Return-Path: <linux-iio+bounces-24382-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7AAB9778F
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 22:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD8E1B2364F
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 20:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5632765D1;
	Tue, 23 Sep 2025 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lRTmUeQy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72D2BE49
	for <linux-iio@vger.kernel.org>; Tue, 23 Sep 2025 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758658696; cv=none; b=ZMP9IpnLAvSRCkWP3VSk7wcA3ksDf1mWJWv7toN3CFTwdfFz7jGWT8zYMPgT5OD08YYeH5fvVwIy1RZXw6Xbdmk6OFJ9PYqcRoNYil6MSWVSSgWFz0cgFVlXnhel8NfAqX1SxQYACjFqWFLusEytB9PiLLVvCmqGmLnzgnHJ5OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758658696; c=relaxed/simple;
	bh=PdloU9lUcNigpqawRG614VYXEABIgO+DNrSDB0byo0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZgqRkpVSC4bRROzT3s/ElDl3UD9uCJDtKwHKbbr2Eq3xTeGEE/BsrbeGXqx6jEqq1ff2giN0o/id/HeqLgS8pkMbLw7Hfa3nJxn3JymVW5ICbecrBsraxMzyYGoKcmYaEf3PDd17iZhpGfay9JDYBQ40KiChRVk9EZdkfPsxQAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lRTmUeQy; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7827025e548so1451035a34.2
        for <linux-iio@vger.kernel.org>; Tue, 23 Sep 2025 13:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758658693; x=1759263493; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aDPZEX1Se6QeCt3KvdyPFqtPVMI5PCpL90eCVP8oByc=;
        b=lRTmUeQyOOsDCS3VUdXlDYgZ9rXyySEvuq6gD+9luT4K1xSBKzbhOLgj0JRwgFrU92
         jXDJI17LULLBk3yTHsX82HX0RN5wCP8Lh2YFCdkLTYRQ4AzUreW8iuSIgwET8+Nkb0mY
         bVUldWtf2LbZekvs+UlIZIFaqzJcPtewNhTmgqxSttnfJUrCDATgsqFJ9tJCFymNja31
         zU4vtvyRQjXh+KowWbSbHOompySNQeCjV45cXLidPe7mc0De3RSwNbgFueq02kCzPYRv
         d4ovEjuXIItaTGFNP3lg8EcjQaRcfalbZHfBA7z+tL2Cvt9+sBjibIghW25FN65GgN7a
         SHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758658693; x=1759263493;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDPZEX1Se6QeCt3KvdyPFqtPVMI5PCpL90eCVP8oByc=;
        b=T5P3tZwV6TpRnY5s+koPDMA2MzqjJPJJCrgRcQCZNI2APe9F6Hl9HlfyNI0LurF9ad
         lGfZeJMAKWw30AA70X//ZxEr2HWuiL2wQXxFXGhiOo6DpZu5KmJknJsAUeLukB44Fesg
         kc/RiSlmyDgxQPwTczxTMUGxW2muuniglEzoBKS0991mn/zwlE4Tm1uhyT28qUTNAjtW
         otNcbJLq5I2ccI9Hypz9Rq2Ls00uUzwlk5ruRDWnXuajUhaJeBYXPmY9RO6l0DJgyIr0
         kjvGBlobOZfSlolXgpABXSPVG0g96tzs3bwjKuUvIhEwdfL302TMBuWnH3p2dTEeLfE6
         cd9A==
X-Forwarded-Encrypted: i=1; AJvYcCUr5fB+LKnUTNV8uAWX2c2COEef9+5KXTcbWikf++qFKSAZq8jYwUgeaaS2quxzSx8rwUyx4rUo6Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUQsGMgj8s1kcLENE+0XphaIffsB/kWFJ50kpjWx+fVVUQRoXT
	zNuLGErbRvsOTcIFCvygonn3uQLfH3Ks+wht+v8q2etlER9q3f4gYBL5nqDoBEymBYE=
X-Gm-Gg: ASbGncv8icBuoT2LZ3z3gKXr2RmGsX7Nb8ZvxU93T0l5OiwOWkQrngrHAzyDRo3HeC9
	ErQzZVDmutaCg65+7PKs5iVaEQrMt7X7ZHIAdUaVSgr/bvokleF68Jwi5dn6Nd63eeF34fBIQoW
	A42V69FxbH7J/qleinGBfXvv6qwPVTy0aLqgNptaJbV0aheo25ICBBUHzVlv451aC98DXh7YbqM
	vpN1Wh8UxiGOi6W2ZWPM23rTjeIoMjBo/52TA9vJ0/qBpDHp2td7Bh+XzjroDGKzI4rb2HgsMMT
	Id+64kBYah66x9LFVnJgKAxSwyNB/GO/00RD7SOoCCEWxQTT7mwUpNR6Odh1bBp6l6lykFRoEw/
	80u1rieJvkw1N+PmF9exLYBHpDek9
X-Google-Smtp-Source: AGHT+IGYuFMOBtN+MRlBqbaM3vIufu2aQP+VIVxkfJ3IU7O/Q6FGwWPAvlE8f/F4JRy9gSs1s6xtUw==
X-Received: by 2002:a05:6830:6ac5:b0:748:8b42:779e with SMTP id 46e09a7af769-791590a4e7fmr2703856a34.27.1758658692847;
        Tue, 23 Sep 2025 13:18:12 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:505f:96cd:1359:fff4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-787303d25bfsm2199731a34.15.2025.09.23.13.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 13:18:12 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 23 Sep 2025 15:18:02 -0500
Subject: [PATCH] iio: adc: ad7124: fix temperature channel
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-iio-adc-ad7124-fix-temperature-channel-v1-1-e421c98c0d72@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAHkA02gC/x2NywqDUAxEf0WyNhBjrY9fKV1cNNpAe5VcWwTx3
 01dzOLAnJkdkphKgi7bweSnSefoUOQZ9K8QJ0EdnIGJK2q5RNUZw9B76oJvOOqGq3wWsbB+TfA
 vRXlj1RKNdUncNHfwscXEq9fR43kcJ8u74oR4AAAA
X-Change-ID: 20250923-iio-adc-ad7124-fix-temperature-channel-5900f7302886
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2032; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=PdloU9lUcNigpqawRG614VYXEABIgO+DNrSDB0byo0w=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBo0wB8eCDSh+bOkroC6WLZKngB6ZWixGjr4TgtX
 YZ11zWDRkeJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaNMAfAAKCRDCzCAB/wGP
 wB5PCACMNUp9YoiBK0muwuQDUUbDJGbEOhUdY8z6+dY3vIqNwzK/UOXbumhdQTs41fzje2I/DGi
 rAoE/Vt+m28mAUSVpbX2DQu3HDjwMJGFNrWsImQBqS9SQxtlWlvtVxHY4Scn/ZUQut09tIG5JBB
 ewmqBTbJQWhVD0w5NyhXfZhRTC1VC0QDz8GI/yYhOwknjShGh6hKfx/LXLSyk/AQnoGs2uRJQrQ
 DiX+GO1/Fd3AtjbCB4uWXKJjqoOqdVie4pD0II2Tw8BC0gMCFp8KDG5beyw8+2mkJjekOShOUAC
 GBjZ/bvcoKzHAui5Cn0pXnS2Xck3mV5Jb+e74VB6yWv5R3rj
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix temperature channel not working due to gain and offset not being
initialized. This was causing the raw temperature readings to be always
8388608 (0x800000).

To fix it, we just make sure the gain and offset values are set to the
default values and still return early without doing an internal
calibration.

While here, add a comment explaining why we don't bother calibrating
the temperature channel.

Fixes: 47036a03a303 ("iio: adc: ad7124: Implement internal calibration at probe time")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 374e39736584f55c1290db3e257dff2c60f884d2..94d90a63987c0f9886586db0c4bc1690855be2c1 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -1518,10 +1518,6 @@ static int __ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio
 	int ret, i;
 
 	for (i = 0; i < st->num_channels; i++) {
-
-		if (indio_dev->channels[i].type != IIO_VOLTAGE)
-			continue;
-
 		/*
 		 * For calibration the OFFSET register should hold its reset default
 		 * value. For the GAIN register there is no such requirement but
@@ -1531,6 +1527,13 @@ static int __ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio
 		st->channels[i].cfg.calibration_offset = 0x800000;
 		st->channels[i].cfg.calibration_gain = st->gain_default;
 
+		/*
+		 * Only the main voltage input channels are important enough
+		 * to be automatically calibrated here.
+		 */
+		if (indio_dev->channels[i].type != IIO_VOLTAGE)
+			continue;
+
 		/*
 		 * Full-scale calibration isn't supported at gain 1, so skip in
 		 * that case. Note that untypically full-scale calibration has

---
base-commit: 411e8b72c181e4f49352c12ced0fd8426eb683aa
change-id: 20250923-iio-adc-ad7124-fix-temperature-channel-5900f7302886

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


