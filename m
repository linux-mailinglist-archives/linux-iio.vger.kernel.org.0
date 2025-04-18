Return-Path: <linux-iio+bounces-18302-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2D0A93E95
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 22:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B4077B1D76
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 20:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B9824EA87;
	Fri, 18 Apr 2025 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SssKJbLt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6843D253B54
	for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745006409; cv=none; b=X/2Exfe0U7UsEqWQOAPS65V5QppTY9uGI0bg97slZO7WEFs9gKVfcqDTHSXsAPk4OtJmkDEP8IQKfd4bzfLHRuXqqz4IrUBV46+S6VPZOs1t9d5pGJayCSs7+FK0XK1Hc6/hYmO5Tjny0ARcX8uWOpejIUtVskCP7DOsyLIN6gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745006409; c=relaxed/simple;
	bh=ARIVPfAYjojNb4iBMLsUhX2LD/OFISQyTpJFmR/jUmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GlZ2Q/ywR5Xa+ITdAdSiC8x5Z5vIY8x8FGn//Uv9t63nqEyIu9wBcgBTOVBLMd4TLuZ8hCmw5hIAytaSE2VJqAmaHcKmc4spM6I7p9+k137hR7LFT+5Cp0ljhJkqN48pnxZoHoSVFX85ypZ7FoGUcyjhYJkHqRi9BFRJngvar+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SssKJbLt; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-72bd5f25ea6so505270a34.1
        for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 13:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745006406; x=1745611206; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qDqqSLn17t5025nkyBHLLdQZLsyBrfKDeHjL9m8bNdc=;
        b=SssKJbLtZ/fQqMg9QAKLKEvWhqwja9r5RRZn9WtTwnuObFLmGdtvLyzu6DM/DyqFES
         efVdhR5itnusXm82JzwgNiP3iXxnnA0QkHJHCJl6d7fx5p1EDwkN4ZSApCSozARnGDWN
         wKPNB7Gr5j8uLGrabkp26Is+75/fYop50YhOPSdOOI+1AhQaLC4gRf5g0/gRLK3dunZF
         xwrMyADK3d7993Sg2sK27AjfdpKJ5e9xCmg1yK9kuCGaKuE+fCgX4iRxh/dacxwGYiJ1
         wqc+xLp071361LddX8Ak0Gi2drfdklTjFBEZEVa3Aq+G52qLInKy+wMmVwpPxB+qRpSs
         r6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745006406; x=1745611206;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDqqSLn17t5025nkyBHLLdQZLsyBrfKDeHjL9m8bNdc=;
        b=cjYF50ZuDMSxCrZklsBglbqtGwO5kMAa0nSZHR0vAjVOzu53OL2QRI9CH9goDUxvLv
         D8tjkhk7wUJUM6DE4OUa77D3NxJjZfee4r6wkVjGh1wPZmH3W8I9eEf4CreiF7emfn84
         HwIg92KiCFAN69tB9up9GUZz7yehCR61W+9rRFClzA8VV2UfC6DSj/XxTXWZl2lNVahP
         4VtdHm1RwEanjrpwGu0gyqCYsh7JAEOzWPEC1ofu3YXEwRMXWt3KBuOWGWpJ/FdANv1d
         FbbrhcX9cuAmTHomiZddqDrTrXtGqmPaA3TvStYvH3e32X4Ac/63Ju3Ox6+ePUJP/vdO
         LhLQ==
X-Gm-Message-State: AOJu0YzFMU+OJPlx1ARqVj+FV91MxHVDxUFJ6HnEVLiazNy3OK7Huk1u
	8566X01D6jlt2pJVlbjew8pHkF0+4t6YW7Vsi0opeNdbJJFQJyd/CIL2icg/RUg=
X-Gm-Gg: ASbGnctk6nFDLyafuRM8yrJDHSoBFB3Wptr8Pn1dse/L9bFFUmEa+/YedesUoEputRp
	86lNNKbi1ogwN1IaHd5ATTC/p1yvaJrC/UkHBOPakrWs6fm+Lf1pbD+sbmhqEzJLnRywAZwMkZd
	TGH0hD8IZnQ8a9jc8jC5ssspkaolK6p1jjvOv28wdSCjw2eApJAb07uhpvoLQ7nooFLitpIhmpE
	ryTPP+DgxNSFFj1pcp8ssE7nflF86hZD5nJU7TUkm5jwQCjvxyFBiueC38ShJ7s3sdQ8RGFvSrr
	A5E4H1ahtayCHRjoklQCnwUIRZvsaIUKl6ZHBafMKIFhewOZZHjxLChN0g==
X-Google-Smtp-Source: AGHT+IGyvAhFlRCsX12Lhwr22tKkpHolc2Tt6LGi5+wwx4p3gTPOGLhHmLju7HF0T94FQvgvVlBiHw==
X-Received: by 2002:a05:6870:4413:b0:29e:6547:bffa with SMTP id 586e51a60fabf-2d526af61c3mr1982271fac.21.1745006406486;
        Fri, 18 Apr 2025 13:00:06 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d5213f8e4asm606941fac.23.2025.04.18.13.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 13:00:05 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 18 Apr 2025 14:58:28 -0500
Subject: [PATCH 09/10] iio: adc: ti-ads8688: use struct with aligned_s64
 timestamp
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-iio-prefer-aligned_s64-timestamp-v1-9-4c6080710516@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1627; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=ARIVPfAYjojNb4iBMLsUhX2LD/OFISQyTpJFmR/jUmA=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoAq8gnMqNGtdNT2ZIPYnYVdyTTiuNmSwk6ytsh
 TVb3PrODfaJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAKvIAAKCRDCzCAB/wGP
 wBNxCACdVaOqC9XUOO3XNtkEYvq9VgXfioFD1KTARQagGK8F4RZ52Ql+vvMTIfwlpvJZ2gt1C6p
 2H95DFKR9LUWM73Oc2uor9X8qIw+B85vCeAZAV4Ux5UDRP16K0Q7Ick+F/d72GPdBKSM3cnPUAq
 wNHPB/7otHliUHUsABIkKUC45xghvbM3+0JbwXMEuLAcC0xgu3XU2XGzKcuqbj39kBioJKPOLje
 7uhR6CGsgbp8xEjN+n3V/Q9CdEC0y1JBy7RPnbUXTJkQiccRgPr7kgv7T+7V2Qm3YGDkxz7YnDa
 0zhX+IsfH+cnM/RBIpCAFz6Fa+Uz/hbt5JnBiJfw2/EJvSyj
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use a struct with aligned s64_timestamp instead of a padded array for
the buffer used for iio_push_to_buffers_with_ts(). This makes it easier
to see the correctness of the size and alignment of the buffer.

Changed from struct initializer to memset() in case the size ever
changes and there could be holes in the struct. The compiler generally
optimizes calls to memset() anyway.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-ads8688.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index b0bf46cae0b69eb1fe8d7734c8a32ac642c5d0cd..2a9cb7d9bbfae4b282682d755992acd47fb88b99 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -380,16 +380,20 @@ static irqreturn_t ads8688_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	/* Ensure naturally aligned timestamp */
-	u16 buffer[ADS8688_MAX_CHANNELS + sizeof(s64)/sizeof(u16)] __aligned(8) = { };
+	struct {
+		u16 data[ADS8688_MAX_CHANNELS];
+		aligned_s64 timestamp;
+	} buffer;
 	int i, j = 0;
 
+	memset(&buffer, 0, sizeof(buffer));
+
 	iio_for_each_active_channel(indio_dev, i) {
-		buffer[j] = ads8688_read(indio_dev, i);
+		buffer.data[j] = ads8688_read(indio_dev, i);
 		j++;
 	}
 
-	iio_push_to_buffers_with_ts(indio_dev, buffer, sizeof(buffer),
+	iio_push_to_buffers_with_ts(indio_dev, &buffer, sizeof(buffer),
 				    iio_get_time_ns(indio_dev));
 
 	iio_trigger_notify_done(indio_dev->trig);

-- 
2.43.0


