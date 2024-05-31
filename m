Return-Path: <linux-iio+bounces-5566-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B718D6B75
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 23:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57C11C22C3B
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 21:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90CE8248D;
	Fri, 31 May 2024 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="107lfdKu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2698F78C91
	for <linux-iio@vger.kernel.org>; Fri, 31 May 2024 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717190388; cv=none; b=PLwGZx44a+cSbAfugXeB3lZ3lFYHVWbKiRZzo8dyd+GU80QuGI+lys5cJOrvc0K6Ky5JBqz0/pcPQ8+jjP34aK7LjgmFLHpuh0/G5vaElKAVjGb+hjep+5OhwPcwXdWplaNW5UWIYQMaS2JoOFIos6PAanmaDxm8HjkwbjL5cow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717190388; c=relaxed/simple;
	bh=Rk5dJF2+TsUg7IjzcoRV/lfTyzQjoNRqKiXdm3UK0Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jTnOwvu9/NREAKxcSPH+dMJzs0zHtsbCfClHiUM/U5iBU5Y2GLbG8/EdiUhufZPGBDRzWSu9tKu78p0cRdZhNix7U62rBJP3OQ73Vrw6CjWHVmq36dcWaMtWwFFh2sVpZeRFeklFxUoH+veG2HEXs2hDV7r/6UG6EZal8JP9isI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=107lfdKu; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6f12ff2da3fso1374726a34.3
        for <linux-iio@vger.kernel.org>; Fri, 31 May 2024 14:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717190386; x=1717795186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9A//l2lq6uILJm9YAojX9V6DCWgOioR04paBfYh0fho=;
        b=107lfdKuw0FJ0OAefK4gEdmGxm68DVH97Usj30qV9cLCS3ZPsiJgJLf2+Lu20P5czW
         L2hrB5cKF+oK3itpwoQXLTFhbn8bG4PiECdOozsUgYjqqEFIfs9+j78oOWzS1HaIvQUW
         aBz6s7qo2xrwztNqN/zY5fsShCFPK4v7mXfI2rAD3RIn6Kb3KUaihDrqhMBPGVRtZfoy
         kYFJmExIcbb0jw53hykMFWbs+1rQ2OnVolRd5eNYf6JmQY4ndWdq8qFXZQ40VMji/e9G
         u23EGuR+X8qcw01f2H/ew9xSNZJD2eQDE7lV4HXf1NqK1us7fmMUdQe6asYwNl7wD/7s
         r6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717190386; x=1717795186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9A//l2lq6uILJm9YAojX9V6DCWgOioR04paBfYh0fho=;
        b=JT9sSXEMSu/j08MtmDCK0HWsfMaoNH1VDfy22dsK0dgxCA3ivoq9LduyNHZ6QljGuf
         5lFaswhdDFcUW9pzIGqlNl37vjh3rf0dK8z8TzdlSBlzeWO2z24oFaPioP8tQaR/YSCE
         6CxPccWatDuFf7GTl0tGmCMxZB2RekaDKgqluDukAm/385EFT99tcEj2Fxp7Yc7Fm4Ny
         rVQT6/wQ3Jm24zb8oQeJTqiVWaYYtF+LzEZt2dUN6ycDGD4rTH6L3zrk9kusN85WFfM7
         O/NEVpDK3VkZhTvQE6JET8KDjgSpLmBuzwmQyfO/vtwoAqGhCjdOzzTC23wpPNPnvtM6
         GoWg==
X-Forwarded-Encrypted: i=1; AJvYcCX67lf7PY1l2VrkVkELodJHOVxTBm3ixsPexWbTCqaDNE4h9trviCd6mWeHROvXJsDJWEWq9Dlfy6+4Xk2mZkMViwB/ghq9rJSi
X-Gm-Message-State: AOJu0Yx7likGdkoZPf6cA2UmzsKHAAuMGCg+y8sllGeQJLXXNggoQ1mg
	v8I2Q4WD2bSDnVfeXoWlXmaSZslIyM2zz1qm7gwmGjFgk4ae1oLJYMPj5kGD1yM=
X-Google-Smtp-Source: AGHT+IFZqCqnS3kUd3hk3iucp3Cuy8ZZvP7npz4Meb1RMFDg8tPygLXtuWL/5NNZMCRB8EHI2oNxdw==
X-Received: by 2002:a9d:66c5:0:b0:6f8:f355:8c08 with SMTP id 46e09a7af769-6f911f3fe70mr3122093a34.21.1717190386027;
        Fri, 31 May 2024 14:19:46 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f91054f6c5sm470176a34.38.2024.05.31.14.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 14:19:45 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] iio: adc: ad7292: use devm_regulator_get_enable_read_voltage
Date: Fri, 31 May 2024 16:19:34 -0500
Message-ID: <20240531-iio-adc-ref-supply-refactor-v1-3-4b313c0615ad@baylibre.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531-iio-adc-ref-supply-refactor-v1-0-4b313c0615ad@baylibre.com>
References: <20240531-iio-adc-ref-supply-refactor-v1-0-4b313c0615ad@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This makes use of the new devm_regulator_get_enable_read_voltage()
function to reduce boilerplate code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7292.c | 40 ++++++++++------------------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
index 6aadd14f459d..aad4b782a3d2 100644
--- a/drivers/iio/adc/ad7292.c
+++ b/drivers/iio/adc/ad7292.c
@@ -79,7 +79,6 @@ static const struct iio_chan_spec ad7292_channels_diff[] = {
 
 struct ad7292_state {
 	struct spi_device *spi;
-	struct regulator *reg;
 	unsigned short vref_mv;
 
 	__be16 d16 __aligned(IIO_DMA_MINALIGN);
@@ -250,13 +249,6 @@ static const struct iio_info ad7292_info = {
 	.read_raw = ad7292_read_raw,
 };
 
-static void ad7292_regulator_disable(void *data)
-{
-	struct ad7292_state *st = data;
-
-	regulator_disable(st->reg);
-}
-
 static int ad7292_probe(struct spi_device *spi)
 {
 	struct ad7292_state *st;
@@ -277,29 +269,17 @@ static int ad7292_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	st->reg = devm_regulator_get_optional(&spi->dev, "vref");
-	if (!IS_ERR(st->reg)) {
-		ret = regulator_enable(st->reg);
-		if (ret) {
-			dev_err(&spi->dev,
-				"Failed to enable external vref supply\n");
-			return ret;
-		}
-
-		ret = devm_add_action_or_reset(&spi->dev,
-					       ad7292_regulator_disable, st);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(st->reg);
-		if (ret < 0)
-			return ret;
-
-		st->vref_mv = ret / 1000;
-	} else {
-		/* Use the internal voltage reference. */
+	/*
+	 * Use external reference from vref if present, otherwise use 1.25V
+	 * internal reference.
+	 */
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
+	if (ret == -ENODEV)
 		st->vref_mv = 1250;
-	}
+	else if (ret < 0)
+		return ret;
+	else
+		st->vref_mv = ret / 1000;
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;

-- 
2.45.1


