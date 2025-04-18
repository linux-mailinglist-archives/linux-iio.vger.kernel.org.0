Return-Path: <linux-iio+bounces-18301-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8074A93E93
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 22:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D311890C02
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 20:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64748253324;
	Fri, 18 Apr 2025 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xbtDKJ7a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A6F2528FB
	for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 20:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745006406; cv=none; b=cqTjyF4/tWRswWGYCB3RhHEHAef7scjV9ANWZjQG3j1XuFsMBamN7UjgXUTw8QNms1iqEgFE/Kpa96MDykU3Ut3jceAbOhAAq7qUNWR7SnSO25kCu5FGV6Esf+yQeC7Rpy4jo7uuw41CWryfLxbXC4JsDvn4JKCo1P+JbXX8FJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745006406; c=relaxed/simple;
	bh=SKCpF0rSJSY06g0qoJ4XgXpVJV0JPJb8oLvnwY1CUvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iGUyD9Ip1/kuPm4bLqHj6jKp/KIIFoMz+/ObhNF4wWZe+mPSuw2MBdmH3tKJcIaxXVHgwQa7lrwb47GmSNGh3PgKW3ScPS2CkY2jiapxDkKiyn46BBl3YhXdG0OY7/TrFrUZANLbfH4EeVNhT99HO4srtm0IVzINqb76RNL8sMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xbtDKJ7a; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2c769da02b0so1768740fac.3
        for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 13:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745006403; x=1745611203; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwEV6MZFJIchPoMNTCpHkxpHxz93usoOxoRUm2ZA0bk=;
        b=xbtDKJ7aQQIzlC6MVYkrP7YJkY1qL46jx9lTvxtDEmX8iOtdOKMo5bgFGPBm7/a5Jo
         Wt7rbkaVcVLLBkG016YXDYSKBGHMmX7EVWMDh70xNrwE3Fdih0hRdlpvmAqmcCB19kh9
         t18i72ot2WiRUotacNMzx4yFKxUtRgnpQk9CyQ0ywXidIthnCI5TWT+FMnCaH9hamHqD
         smMAHLIOQtNF5CDuWozW+wbJR7KEnMd0ux5puDTVQBJm7MSVzmB2gdfdS6SkZIfiTGcy
         ogWb1sHh/aJU4Yqho0Zt38AqJixZifXg7E6ZGMj8p2fqn29WjYj7JeQNJiN+uBwLEAHf
         QPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745006403; x=1745611203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwEV6MZFJIchPoMNTCpHkxpHxz93usoOxoRUm2ZA0bk=;
        b=TeRTpaSTC/uGVsV+EV3IWLr5l9diwhXBc4/7UhFaIcqthHFcCndVHpa9KzLGH7H9uz
         KJvYwpHWV4izat/TjBply2g12MrRD9z1osiLqQFV1BfMv1RTCRqKiU0z4lJpVk2J/FCy
         iVwmjeHWu+BVwLZYnRf/fSNcg4ESZzazqAbNTGw6ULn+ENfiivXy6AwJ5ZE4Y5ua41tl
         rLsywcw5dhhvIKmVvqQBYsyrN3VrM20/TVI9eUUStxcS+tW9CwfQ/Ndgw9tHajOB17zD
         Kvgn9ETyT0KoxflSFEWyQ9F8PDepqri+IiPx26WRos2B7qnr6DwUGx2c1OgTQuvPfKoK
         f5qw==
X-Gm-Message-State: AOJu0YzGmf1GouRXQbUMCmCIc8fShvQfw7bRCqtnp3GSsXyPdVcDnXDk
	QhaNfFo2tkUoKhWLk/hCDSUxlbrbMDuQ0jR9t+FRU9JiZI7R7cAHe8WQIEvRrfo=
X-Gm-Gg: ASbGncubotKYUuQW1r8zUNyqmfYOqzcm3aeWB+cxEAXvM9iKdio3aVq/32yeuyII4UU
	Nb1QLMvdT4uuhYlYeSXVM453Fkvye/6WykWfeB/Ca6JCw7+sz7jxdtrbvvQVEBVB3QCqnz7GdPk
	lrqmBATOUtvIO2JU6JpeVVSj5i/IKg8nZ91T9dLI8v5X+m96SfncpGdi2E6flu2RB/Jh7/hK333
	SZYr1Pln3X9x6XS9eMMjoeE5mY4pp6QwlGXbECzdzdHvP18yAgtr2bpjr4H6MCymdbXTy/7nGRM
	8/2IwW5dqx8ER/sPvbyvLgH6bcFb0/C8UYfUTjVyojzu6EU=
X-Google-Smtp-Source: AGHT+IGOnbfbgHvkykmuoWWumpe/zQvoKx6ZttBWLA1bqT+37tvAXi4z2gJDa6nDw9JVR42V4KG3Zg==
X-Received: by 2002:a05:6870:aa9a:b0:2c1:44a9:fc16 with SMTP id 586e51a60fabf-2d526ec9824mr2328947fac.38.1745006403477;
        Fri, 18 Apr 2025 13:00:03 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d5213f8e4asm606941fac.23.2025.04.18.13.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 13:00:02 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 18 Apr 2025 14:58:27 -0500
Subject: [PATCH 08/10] iio: adc: ti-ads124s08: use struct with aligned_s64
 timestamp
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-iio-prefer-aligned_s64-timestamp-v1-8-4c6080710516@baylibre.com>
References: <20250418-iio-prefer-aligned_s64-timestamp-v1-0-4c6080710516@baylibre.com>
In-Reply-To: <20250418-iio-prefer-aligned_s64-timestamp-v1-0-4c6080710516@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Eugen Hristev <eugen.hristev@linaro.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andreas Klinger <ak@it-klinger.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-stm32@st-md-mailman.stormreply.com, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2005; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=SKCpF0rSJSY06g0qoJ4XgXpVJV0JPJb8oLvnwY1CUvQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoAq8ZpjC92ceussgPgpBKBLXA1tO4DdY6Pfv+q
 jbN1Cv80eqJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAKvGQAKCRDCzCAB/wGP
 wNhbB/419+xS1/MlezzwDnTGWqQSMnAh1Q2CLkNfdMRF68px0+3K710C9xuAgCWfWqc+HY4d/gd
 0Z6Ek4aSyCx9NVF+d9REpdeTCbkAjzL0yt1UBHDq7hsMFQOylHBCYJFxtxStm16dSE9AByAHWcp
 ztS2vlc/Dgu77OXzBjdmjGD0dhTrhCxBJHEAVudLPfh/WAoVrFRmc5QXkl5E57hP1EQoHD1p8CV
 iob437dhuhV1doZeSuFDEMRKbhsa1awJs7IRtPIZywjnzRwZ9s4wgjSYJSr0o+bYCyQ6Y1y1JLq
 bo67Oufp7S8gpeHG7/yyq/tHcStfArgOiFqPlRhGWaoDoT8L
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use a struct with aligned s64_timestamp instead of a padded array for
the buffer used for iio_push_to_buffers_with_ts(). This makes it easier
to see the correctness of the size and alignment of the buffer.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-ads124s08.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index 8ea1269f74db09427a4a8d434ba1d63e7c63d038..ecaffe83fcc911f99afbeae7ef51440d150bef73 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -98,14 +98,10 @@ struct ads124s_private {
 	struct gpio_desc *reset_gpio;
 	struct spi_device *spi;
 	struct mutex lock;
-	/*
-	 * Used to correctly align data.
-	 * Ensure timestamp is naturally aligned.
-	 * Note that the full buffer length may not be needed if not
-	 * all channels are enabled, as long as the alignment of the
-	 * timestamp is maintained.
-	 */
-	u32 buffer[ADS124S08_MAX_CHANNELS + sizeof(s64)/sizeof(u32)] __aligned(8);
+	struct {
+		u32 data[ADS124S08_MAX_CHANNELS];
+		aligned_s64 timestamp;
+	} buffer;
 	u8 data[5] __aligned(IIO_DMA_MINALIGN);
 };
 
@@ -289,7 +285,7 @@ static irqreturn_t ads124s_trigger_handler(int irq, void *p)
 		if (ret)
 			dev_err(&priv->spi->dev, "Start ADC conversions failed\n");
 
-		priv->buffer[j] = ads124s_read(indio_dev);
+		priv->buffer.data[j] = ads124s_read(indio_dev);
 		ret = ads124s_write_cmd(indio_dev, ADS124S08_STOP_CONV);
 		if (ret)
 			dev_err(&priv->spi->dev, "Stop ADC conversions failed\n");
@@ -297,8 +293,8 @@ static irqreturn_t ads124s_trigger_handler(int irq, void *p)
 		j++;
 	}
 
-	iio_push_to_buffers_with_ts(indio_dev, priv->buffer, sizeof(priv->buffer),
-				    pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &priv->buffer,
+				    sizeof(priv->buffer), pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 

-- 
2.43.0


