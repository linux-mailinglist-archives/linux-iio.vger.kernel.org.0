Return-Path: <linux-iio+bounces-12485-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F33889D5E2D
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 12:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6956BB226BE
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 11:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319EF1DE4FB;
	Fri, 22 Nov 2024 11:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MHIb072r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2873B1DE2C0
	for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732275245; cv=none; b=Urhb51ud6iKuJI6lcoswlT57H5aJPNznCwEkXE5MzvgF5ISeOn1HlMrehi7w5xsjAKdIk3ndYHUEf6d+xYGUEZm0oORA/0AV+SQrnmOqxhcQ5xnVWT2FTOmCTNK6vLf0PYY88wLlZ23Yuy+dt+nZz0BS/x20+1uK5Cpkh9Sen8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732275245; c=relaxed/simple;
	bh=sUW8vIxfv4BfM2wnxDmei7rYENfZBPESOqgmgidvtHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CoN0cHwsYHmGU8SWdiuwpGG4rz2zVsJ5EKT5yfvlBzLXnLI8UxbhocoRjeIxgTIi669hEnkgQQZzLetkfm6xrg98Xm1CESH9DWNwhKKQ4vJt3jQJ2U6fAR8qQdGYIKw/mqFvDzc3DvKHutOqhvYUqCZ7u7Ni9GWPqHfUGfQiA+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MHIb072r; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53d9ff92ee9so2276671e87.1
        for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 03:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732275242; x=1732880042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2YBz8TSJ/wQwdEWCNJcg595g05SvWsgpN9AQhkbH0E=;
        b=MHIb072rioDssqQlLaLpq3hN0xwq2yw6/1cz/UCxsleVn7cOnYsHleDA2MjpBTOBBn
         kGr4ZDjZAcKCDuOqLUJkJcMTJ9lKHWMQbitaEj2OlrF83RI9b80fabyIXokxflY4Xaim
         DgVA5RJjoNWWsLXyQZhWOTvIvAac3TQgY1cGLE4pWkRBXS/VEzQ1YVBzFFz42ndbvPBQ
         /VKl0AqMFxevE0VTQmY2BbrHYM27dnQjEGV4mgp9hJUxdXmvJ3xWjthZFMsIxEQO3QuB
         MmgTXqR4ziNqqCuo4s47Ou//2KPzir2UMUXAgQkv2pMrAxj6go/FhwRdtOztMT53lExq
         SJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732275242; x=1732880042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2YBz8TSJ/wQwdEWCNJcg595g05SvWsgpN9AQhkbH0E=;
        b=PRiHmIGKPOuneESG43vrY9ggLQz4Ky/n2tZBt0pvuP250gkoTCj5v5EcfjqpTSX93+
         Vo+o/rwdtPOg7W9UATa1Nmaxn9sPs0FmbqgWnrpOZyDFlSLdgV0JMd5aYhh47e9YINPb
         pSEyXOSQ8CbA9mLC6DzS3BhgVQRZ65QhPke7qf5eYb2UQGDETraVcJ6oBOIqCoaFNyL7
         9sPeLTGMVY9cL6CDnvN64j+TMsqIlJc66Gy0dNHxbWH9L3mecQaKaKZWwJ0Bhrga+hj5
         KRFV3SA8hk/mgKlSBHoel0QrhHyAlucCpoH3WewsWKM8rF0AITHva9pK8qRfrgl9xMfe
         do3A==
X-Forwarded-Encrypted: i=1; AJvYcCU9v3W9TxXPyOdFaeK18WxAJxsdO/B/PTgaGRaf89bhyEeTefhmNgLpMys7MPHqUXZFW07aT4wuHws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXnA/sHRIA+22pm5EjHyu2KMX4ZjRzxQFfso18QzIUDaZCy0cH
	Qw0wifVC/74xPWgpvCon/n5saya6+MoWlqbVuVq6ZjfjITGkPcoc2TuAZr7LOJc=
X-Gm-Gg: ASbGncvqgs4onxP6GRSIPVVXtbOVcOYQMqNzJU6zVrf1O0sVJsSR8znH/3QoIH/SlHU
	p/2RE4ZbSfSkeL2llasykI1rxLn8eAXY0PErOFwWadTOZimIG1xiGx+Q0kJj5/m7TsHLpOyRA3u
	jtiJQK+u9tl/s+kIwF06Gme9xRElgWT085lqX0xaj3UV8E/1npLOI8Qj7QzfVsUpRIBSt8VoV1W
	7Cn2ZijqsKrhh6hzyyBpxZCIAw/2EpHsrR1dZ546OpflpIZZByhlxZzEbl6FqtYr2r7qLliRPp/
	cQQ=
X-Google-Smtp-Source: AGHT+IFTjFBny5aoe0n7bZuFkvivpcYbYcV2t6thsKVVD+xX2yD+tIQrArcuNDydxMpFcu43+piQvA==
X-Received: by 2002:a05:6512:281c:b0:53d:d592:cf46 with SMTP id 2adb3069b0e04-53dd592cfa7mr1008180e87.8.1732275242307;
        Fri, 22 Nov 2024 03:34:02 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc42d4sm2186558f8f.85.2024.11.22.03.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 03:34:01 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Alexandru Ardelean <aardelean@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Dumitru Ceclan <dumitru.ceclan@analog.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nuno Sa <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 04/10] iio: adc: ad_sigma_delta: Add support for reading irq status using a GPIO
Date: Fri, 22 Nov 2024 12:33:23 +0100
Message-ID: <20241122113322.242875-16-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3790; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=sUW8vIxfv4BfM2wnxDmei7rYENfZBPESOqgmgidvtHE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnQGwMkeVRPlBCDIXN05q38+9ftBM2B8Nxh7jYa KUjbePFP9yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ0BsDAAKCRCPgPtYfRL+ Tl94B/9wAwfVq1gfejPKim6bMzkJepByvnAStoHY1yUe1K9TLbw6n2S9DractZ76kpYX/OTy8EH CkypjR5ftqznGM5gddWo+5rFrFAZ/HTA7RKM+Zk+Ff3HHZt2jGKSs8Gagy6DsfGSt6GZIvrKj6C apJHEp3GQxvDWWfE75yfX0f8P+EmIEdmAEDEoVB6KK7Kj8jxn//Wx9O0oSnAb1Xa4i1fYtU3dOE c3aH/dHk/ORGpB7ZjJ0gt6cD7o0UcmE/3nRfMDoxi3q0XL6a1cXlWITjGnAaCyi7OAqniJRmC/o Hi7zzG49WD2iFwa6fSGiK7Kh/k4fSWyP4SM9SIEzUGifH3Ov
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Some of the ADCs by Analog signal their irq condition on the MISO line.
So typically that line is connected to an SPI controller and a GPIO. The
GPIO is used as input and the respective interrupt is enabled when the
last SPI transfer is completed.

Depending on the GPIO controller the toggling MISO line might make the
interrupt pending even while it's masked. In that case the irq handler
is called immediately after irq_enable() and so before the device
actually pulls that line low which results in non-sense values being
reported to the upper layers.

The only way to find out if the line was actually pulled low is to read
the GPIO. (There is a flag in AD7124's status register that also signals
if an interrupt was asserted, but reading that register toggles the MISO
line and so might trigger another spurious interrupt.)

Add the possibility to specify an interrupt GPIO in the machine
description in addition to the plain interrupt. This GPIO is used then
to check if the irq line is actually active in the irq handler.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c       | 35 ++++++++++++++++++++++----
 include/linux/iio/adc/ad_sigma_delta.h |  1 +
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index ea4aabd3960a..4c8d986b6609 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -539,12 +539,29 @@ static irqreturn_t ad_sd_data_rdy_trig_poll(int irq, void *private)
 {
 	struct ad_sigma_delta *sigma_delta = private;
 
-	complete(&sigma_delta->completion);
-	disable_irq_nosync(irq);
-	sigma_delta->irq_dis = true;
-	iio_trigger_poll(sigma_delta->trig);
+	/*
+	 * AD7124 and a few others use the same physical line for interrupt
+	 * reporting (nRDY) and MISO.
+	 * As MISO toggles when reading a register, this likely results in a
+	 * pending interrupt. This has two consequences: a) The irq might
+	 * trigger immediately after it's enabled even though the conversion
+	 * isn't done yet; and b) checking the STATUS register's nRDY flag is
+	 * off-limits as reading that would trigger another irq event.
+	 *
+	 * So read the MOSI line as GPIO (if available) and only trigger the irq
+	 * if the line is active.
+	 */
 
-	return IRQ_HANDLED;
+	if (!sigma_delta->rdy_gpiod || gpiod_get_value(sigma_delta->rdy_gpiod)) {
+		complete(&sigma_delta->completion);
+		disable_irq_nosync(irq);
+		sigma_delta->irq_dis = true;
+		iio_trigger_poll(sigma_delta->trig);
+
+		return IRQ_HANDLED;
+	} else {
+		return IRQ_NONE;
+	}
 }
 
 /**
@@ -679,6 +696,14 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
 	else
 		sigma_delta->irq_line = spi->irq;
 
+	sigma_delta->rdy_gpiod = devm_gpiod_get_optional(&spi->dev, "rdy", GPIOD_IN);
+	if (IS_ERR(sigma_delta->rdy_gpiod))
+		return dev_err_probe(&spi->dev, PTR_ERR(sigma_delta->rdy_gpiod),
+				     "Failed to find rdy gpio\n");
+
+	if (sigma_delta->rdy_gpiod && !sigma_delta->irq_line)
+		sigma_delta->irq_line = gpiod_to_irq(sigma_delta->rdy_gpiod);
+
 	iio_device_set_drvdata(indio_dev, sigma_delta);
 
 	return 0;
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index f8c1d2505940..866b4c21794b 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -96,6 +96,7 @@ struct ad_sigma_delta {
 	unsigned int		active_slots;
 	unsigned int		current_slot;
 	unsigned int		num_slots;
+	struct gpio_desc	*rdy_gpiod;
 	int		irq_line;
 	bool			status_appended;
 	/* map slots to channels in order to know what to expect from devices */
-- 
2.45.2


