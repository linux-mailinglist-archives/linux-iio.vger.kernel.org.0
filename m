Return-Path: <linux-iio+bounces-12456-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E199D4AA4
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 11:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95EC1F22970
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 10:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF791D2B04;
	Thu, 21 Nov 2024 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V9f9Ww4t"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF81CCB26
	for <linux-iio@vger.kernel.org>; Thu, 21 Nov 2024 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732184313; cv=none; b=qmZpbYByOQ5NOLDVtIPe0gZEfWhpiNdZkCzlcZc2EmdLAqE6CvsFvhmSj3hdiub43QGKb7p2a47mkgGd1eVf5ts87pn7meVgIygTIAUj5fyarJHWvC5V+sPkmqQvgh1djGNYZng79Khz6HsbYlGKEH7b+OsjbV47OXQuCjfjqdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732184313; c=relaxed/simple;
	bh=2RdUP0opgSj121kEt066DF0V8khGTWZlShuPPaqbCi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lmvBMCkrjJroxYBOnvH26kGqz+2GgyDGt2YYojnTtBCjeJkAGXs1bja4FPSPV/ZYaFCalNgXKqVe6v5eZq9ZJcmVzxOzYobSbDHPgGixyv8iG/ZTbkTdxGa0vuiGKks5STiIDWC16UWE9aRCaQ129zs9UQJvLT2Q2EJb6wMuBIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=V9f9Ww4t; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-382588b7a5cso497417f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 21 Nov 2024 02:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732184308; x=1732789108; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NnR4UV0w6VSKY/f8yPux4iBG+LYvQ7mliatLzcIQdBM=;
        b=V9f9Ww4tyqz0n6oEURYAOXPqlup7oxzLucuhvRjX7zp8pg++J8yL+0m1GTFaovql9z
         pnn3q+m1b51pvbxWMx417U8Cex3FTpH/Wwm3TZm+LM+WD8wUfIb4dHPfn6V1Lbnt2woh
         DbaX+bmgzdjv1OH/DNKcUK0Q1ICwF0CMTvW+Lq8N3pOexhQ+Ge/uaAfStM8UiHfDHUvi
         8b9HzmgyHgcmUOTHrVs3Vo9x4jsQigvk6BvZXHKRTntZMK3xJpBq71W2f0HM/0JRETbi
         lo8ssBhimOLRDWKY6pLx7njwM6qbdP4I1aurmw/zXvhtMFP9+aJecXNbyDhBVoqEA95F
         pfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732184308; x=1732789108;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnR4UV0w6VSKY/f8yPux4iBG+LYvQ7mliatLzcIQdBM=;
        b=ruVXDgE7GALLPCx2nQ/oRq9h612jPMX0Sjg0WPlO4GNPwwV1wFCaB9Ic4WVbBI6pON
         rDin/qx3+S9rd35S2wMHmYFSbRhsgVTErNG4Iqf1NyGPgHLjtY+/d7RCqD/VEnNyXItH
         cD/pBsg7K6EIbJ/jin7kRiYDpgKT2tsbs35CUhvmVKVdgOHt9TH9LNGF7fJS6AejvRGn
         bBLKjSmfhKnEmt7mH/77+xBwo7aE3TjRd9GGkysmFIHWiDCFnvU43TT0l4R/NRaoWVB4
         eIdMOWBx14qDxrKzKZQgd1w+FtzjGtBt3C7qwJ+6sbC6QehwVBU+UlLMC0qnMGli543i
         olTg==
X-Forwarded-Encrypted: i=1; AJvYcCVnbnh2hIQEkUnGNgHYhIZExKEblAJY6DOoo8wiT774XD6ThpE4DrlUzLM6wT/6NAr/Lr0OhyHssDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4B/Y2Y5w0Bt6Ho9G/W7LgekEgKF+S12PFKEDTD6A8nnCrJwLB
	Mg6LlOCmWxLsNe/zdYG4epdEG6d7uJZ3eadrWJeOAv7OpirhZrY2Or1vjidYM0s=
X-Gm-Gg: ASbGncvhFwrGI/mdDb0jshWJWLmFy2nKRFnizP3taLKOQYUzXCZg0273hFEvuPtZsQu
	A/1p3ZgDZoToqCnrfL0FWA6L00cQEQ0F+hFn6wTwPiTfY/Cic6NjvXTfAxt+yYSMyS+v0ojQlNl
	ho8uXVzlKqQc7K3WjtSINvO7o/mE99QPAbjaZIFhBob4NrnZ9CC3HhCFmdvZR2fcma5swfdWxjS
	Crqw/XXP4KYAH59b+uAqVW8oirU6082sIkFRCFTTaKFjunbQoZuBT7uNDkKMpWJPYKcTtluuw==
X-Google-Smtp-Source: AGHT+IEFrv/RthM6qz+7szeDYPM6+coRBlRKnKO/IHtuqFfBkoi0rE1EWyE4uO8xzlFLoYrtCCfo9w==
X-Received: by 2002:a05:6000:144d:b0:382:397f:3df5 with SMTP id ffacd0b85a97d-38254b21914mr4328291f8f.38.1732184308058;
        Thu, 21 Nov 2024 02:18:28 -0800 (PST)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254910796sm4598065f8f.47.2024.11.21.02.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 02:18:27 -0800 (PST)
From: Guillaume Stols <gstols@baylibre.com>
Date: Thu, 21 Nov 2024 10:18:25 +0000
Subject: [PATCH 3/9] iio:adc: ad7606: Move the software mode configuration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-ad7606_add_iio_backend_software_mode-v1-3-8a693a5e3fa9@baylibre.com>
References: <20241121-ad7606_add_iio_backend_software_mode-v1-0-8a693a5e3fa9@baylibre.com>
In-Reply-To: <20241121-ad7606_add_iio_backend_software_mode-v1-0-8a693a5e3fa9@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com, 
 aardelean@baylibre.com, adureghello@baylibre.com, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732184304; l=2020;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=2RdUP0opgSj121kEt066DF0V8khGTWZlShuPPaqbCi8=;
 b=h2ujr71zPBn32R8QCoM2rO5GdcOeQwiHdz8qEQORU/AXJdpiejQlKCfEYCdxWP2UUsq8DD6jk
 ldIWgG6+mHBBDZzv5osKXZMHnV4EXY0SlPnf0jydyZi25SVnsOFQAeO
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

This is a preparation for the intoduction of the sofware functions in
the iio backend version of the driver.
The software mode configuration must be executed once the channels are
configured, and the number of channels is known. This is not the case
before iio-backend's configuration is called, and iio backend version of
the driver does not have a timestamp channel.
Also the sw_mode_config callback is configured during the
iio-backend configuration.
For clarity purpose, I moved the entire block instead of just the
concerned function calls.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 893b93b86aa7..828603ed18f6 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -1246,17 +1246,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 			return -ERESTARTSYS;
 	}
 
-	st->write_scale = ad7606_write_scale_hw;
-	st->write_os = ad7606_write_os_hw;
-
-	ret = ad7606_sw_mode_setup(indio_dev);
-	if (ret)
-		return ret;
-
-	ret = ad7606_chan_scales_setup(indio_dev);
-	if (ret)
-		return ret;
-
 	/* If convst pin is not defined, setup PWM. */
 	if (!st->gpio_convst) {
 		st->cnvst_pwm = devm_pwm_get(dev, NULL);
@@ -1334,6 +1323,20 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 			return ret;
 	}
 
+	st->write_scale = ad7606_write_scale_hw;
+	st->write_os = ad7606_write_os_hw;
+
+	st->sw_mode_en = st->chip_info->sw_setup_cb &&
+			 device_property_present(st->dev, "adi,sw-mode");
+	if (st->sw_mode_en) {
+		indio_dev->info = &ad7606_info_sw_mode;
+		st->chip_info->sw_setup_cb(indio_dev);
+	}
+
+	ret = ad7606_chan_scales_setup(indio_dev);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(ad7606_probe, IIO_AD7606);

-- 
2.34.1


