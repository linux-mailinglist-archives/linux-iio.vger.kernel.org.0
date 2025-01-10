Return-Path: <linux-iio+bounces-14108-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D3EA098C0
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 18:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0911884FAA
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 17:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BC421420D;
	Fri, 10 Jan 2025 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p1lzPf6P"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F722135AA
	for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736530817; cv=none; b=S9dNt0w4KrvdYUhLtHZ8tCCFzz4bSEtWLWSOFAZa+VfmFe2DTJtbxdhzW1BK2ufzazzds8ayUa5u1yDO23K08Bry6LjCgWA0RQ3I34souFO9fdDgzr+oBzPI75Zi1+TFykr8TZOsAamxfNMUWddocbGk/rrA1E34DJP8JkwH5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736530817; c=relaxed/simple;
	bh=M6Fcbwc3PbjlPukv9xod6YdOA5v1mZleHYkzNCORguw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a3VLdihYz070cPNKpYP8zWpFRQvDfK71eTvU19wTSBlnSs9zkNnzf7YAHZ8bjZDNUqBuZ+abBccI/Me+drQqYmu9CyubHVaXH0q2Z0fOYMkAx7HR8LciGu7cW9qAydkw9cmGYRhGmY2x1u7h7DRh0whkMgYkJiTveHvRE7BhyUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=p1lzPf6P; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3eb98ad8caaso934766b6e.0
        for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 09:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736530814; x=1737135614; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tx4/GBkv0m6R1EJU0MqLGBWVuvonzJEQkiaHtLTW0dg=;
        b=p1lzPf6PvPs3kp1Mfz3AgD8b1npFunJJh+QSkCfDo2t8k+f79mHxhS779Vdz1EQIwN
         dGclDkoxwoM7JP6J4YiB6RgPKk5+UD7o+KtLnTGTE9cXx0ImB5TI5dWEmEhPNLGKgCrF
         urXin2U7+0/Vq1P6VZ6rTfyYN3bUiA/1792lVdrNy68k4Cy08B0kr9SFbL/ANzf9rqOH
         F6lmgm8GVIZpnd2RImmiOibepYaxsFjRwQgykc9zhguSQXWSdoOFo8OVgsFvUg1XsTFg
         aq1/Dq/tYSj9905Ni5PDZfDPPJ+blQwN8SyJE8DCuRLH0FD9FsCghjC3bTVXq1zoLvri
         Rd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736530814; x=1737135614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tx4/GBkv0m6R1EJU0MqLGBWVuvonzJEQkiaHtLTW0dg=;
        b=fPUrZoTt1frdcISj5D+phi/VV4NFc4uJ1IkVjDGhy+F7RAZSdSLcK9fXOLkFCf30C6
         GZZ4Rbyg35ur+i51tscXKDkO7i3QGZ+v2XcgQz2eXhvjs54kB7U1fKuY61I3Q0h6jJUI
         KZA+iy+y+QwnVTelFGSL4c2iYavEHFd34BodwO40oCHA+JAgGcNPJWGhQRln6B3HpYjD
         8je0CWd/grXp8y3Mf4dedXu/N1O+wiujCnbY8IbBIRZXKYUrzRTHHN78sYNgX9bPF4lz
         QjSWjWK+uRbkLJcFiSN5eINQidKH2W2lParbC833FdneGs5dreP2B/JPaDHe81PYChOz
         hEIA==
X-Forwarded-Encrypted: i=1; AJvYcCU5BqkfU2M7Xx6TA1QDDGBbfc6p2u1ALx8MnWCjo99VeWVpNfiP+0FD67Brv/GbDk0gY+LSaPjwpJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxurMVrWMBhtUjv6exgqrVvH4Mn5rb2Oiw68SDnzQVU8u8pIuNF
	b3vLZWknQoaMaXZ2EceQ2xwTI1rWTCtJe+69Y+Jy+hhn5EZcArC2lML/AHLz8es=
X-Gm-Gg: ASbGnctqU4wwi1L202PSn7/sbjnhjB9EWAD7W9bRWK94/6kKmh8r7rvn1ord+swvS7S
	on+lV6OZDgGe0bDa08jTdpZ5k/rpMoTnaytHnq+Q9XOlqbI1MEohQ9axhPf34ACOsKiFz7WUsH4
	HStN9ffSeGYTkOP3UKyzysY30OvtMrscIbtQNDf1DGRM6msrNprFeIKtozZX762CA7wnRogDgKE
	JwRodbZPawMy3a5+mg4T7v7iY+oU0Hu+BenVk7xMfdhQlo97acuRes1tqCFTM8pUg59mHakM6uw
	WqRDqdK+MqzF
X-Google-Smtp-Source: AGHT+IGvG4TqQXVJRPgtlOTlk4Q/5oV1YPrJZ7HZfl8Z5jkIIndaLv71DjeZBDGuGgWv0oHh93TVYA==
X-Received: by 2002:a05:6808:3024:b0:3eb:42d0:f3c with SMTP id 5614622812f47-3ef2eba742fmr6484284b6e.3.1736530814261;
        Fri, 10 Jan 2025 09:40:14 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f03769a8f8sm842165b6e.26.2025.01.10.09.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 09:40:12 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jan 2025 11:40:06 -0600
Subject: [PATCH v3 1/2] iio: adc: ad7173: remove special handling for irq
 number
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-iio-adc-ad7313-fix-non-const-info-struct-v3-1-41e1c9cdd1a7@baylibre.com>
References: <20250110-iio-adc-ad7313-fix-non-const-info-struct-v3-0-41e1c9cdd1a7@baylibre.com>
In-Reply-To: <20250110-iio-adc-ad7313-fix-non-const-info-struct-v3-0-41e1c9cdd1a7@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Michael Walle <michael@walle.cc>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Guillaume Ranquet <granquet@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Remove the int irq_line field in struct ad_sigma_delta_info and all code
that referenced it.

This struct is intended to be used as static const data. Currently, the
only user that doesn't uses the static const struct directly, namely the
ad7173 driver is making a copy of this struct to be able to modify the
irq_line field. However, this field is written and never used due to the
fact that ad_sd_init() which reads the field is called before
ad7173_fw_parse_device_config() which writes it.

The runtime behavior does not change since ad_sd_init() was already
(unintentionally) being called with irq_line = 0.  But, even though
this could be considered a bug, the behavior was still correct. The SPI
subsystem always uses the first interrupt in the interrupts array from
the devicetree and the devicetree bindings for this family of chips
specify that the RDY interrupt is always the first interrupt. Therefore,
we don't actually need the special call to fwnode_irq_get_byname(), so
it is removed in this patch instead of moving it to the correct place.

Tested-by: Guillaume Ranquet <granquet@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v3 changes:
* Removed spurious change that was causing compiler error.
* Rebased on iio/testing and resolved some merge conflicts.

v2 changes:
* Fixed chip name is subject line
* Uwe's comment made me realize that the special case was actually never
being used because of the ordering bug and could safely be removed
rather than trying to preserve it.
---
 drivers/iio/adc/ad7173.c               | 6 ------
 drivers/iio/adc/ad_sigma_delta.c       | 5 +----
 include/linux/iio/adc/ad_sigma_delta.h | 2 --
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 6c4ed10ae580d66287857252ce9a69cfaa45db0b..b92aca39d117a315d6b55951fba7c3b51787555a 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -1515,12 +1515,6 @@ static int ad7173_fw_parse_device_config(struct iio_dev *indio_dev)
 			return ret;
 	}
 
-	ret = fwnode_irq_get_byname(dev_fwnode(dev), "rdy");
-	if (ret < 0)
-		return dev_err_probe(dev, ret, "Interrupt 'rdy' is required\n");
-
-	st->sigma_delta_info.irq_line = ret;
-
 	return ad7173_fw_parse_channel_config(indio_dev);
 }
 
diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index d5d81581ab34099cef30ec63944ce1171c80ec14..38a72ced10326656b30fd39d7a72cefe8c4c1aa5 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -801,10 +801,7 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
 
 	spin_lock_init(&sigma_delta->irq_lock);
 
-	if (info->irq_line)
-		sigma_delta->irq_line = info->irq_line;
-	else
-		sigma_delta->irq_line = spi->irq;
+	sigma_delta->irq_line = spi->irq;
 
 	sigma_delta->rdy_gpiod = devm_gpiod_get_optional(&spi->dev, "rdy", GPIOD_IN);
 	if (IS_ERR(sigma_delta->rdy_gpiod))
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 417073c52380f60a1a45a4924f4f556b64832295..521e3dc95db9117b7df12710eaae3f373d1df7bc 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -53,7 +53,6 @@ struct iio_dev;
  *   be used.
  * @irq_flags: flags for the interrupt used by the triggered buffer
  * @num_slots: Number of sequencer slots
- * @irq_line: IRQ for reading conversions. If 0, spi->irq will be used
  * @num_resetclks: Number of SPI clk cycles with MOSI=1 to reset the chip.
  */
 struct ad_sigma_delta_info {
@@ -70,7 +69,6 @@ struct ad_sigma_delta_info {
 	unsigned int data_reg;
 	unsigned long irq_flags;
 	unsigned int num_slots;
-	int irq_line;
 	unsigned int num_resetclks;
 };
 

-- 
2.43.0


