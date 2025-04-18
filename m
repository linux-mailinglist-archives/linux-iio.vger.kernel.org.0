Return-Path: <linux-iio+bounces-18296-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5C9A93E89
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 22:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12861B669B7
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 20:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97AC22D789;
	Fri, 18 Apr 2025 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r/Xi/TxD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A950B238173
	for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745006392; cv=none; b=aHxY1o5Rud9Syyw5TFf9AjTYCJ/cHclH9NJLhaM1jBd3Ip3/vDn+DP6k5UZmwpBJx3X4k7rKz5TxA7AjD9YowlX0kObrkepNedmCK9UYRTm/k2oiH51HG6FCSz8uN2RAd1wc3HwmYjYF8B5pCJZdhqqqwzR4zzSwYX2wFhPFMuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745006392; c=relaxed/simple;
	bh=lGbQ3dZga8UFYhE2RmKRRSTA6YHIjjV8TI3JBRQo+eI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YIVkQCZftpES4CX0cNMMazGqBzSphiKrf1JIvxmuRCA6q3Jiv3R9LfnGkeSo/nHRc015KrLl6Yualso3Gk2Q7wk06xnwzNIFCjGQJ8V4EQ821oNqkwfq3ZLWiD3+TAOxILyq9gSX6q1+4dyq2UqLNDxgZxj4nxVD9J3iGpii5po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=r/Xi/TxD; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2c6ed7efb1dso1279527fac.2
        for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 12:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745006389; x=1745611189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwf2pqYvTfZAKWRzV4AAx6ws0t+3hl5RqCYYJcwd3fg=;
        b=r/Xi/TxDZe1kDxXHfioivIkdDNQxdg8YPCbrONNu0OiHzE115MgSImVceZ1QDiLfoF
         9MpXhFc9WlAVi4mJSbwjmugNcnny0zIstmmJkeA/8oiDr5TD2eaNs8xmC+MK+Bch2cCI
         Fqe/99R74xPFyukgSiruicRdZG0ynwN/R6wKOHtAhhmBRrn9VzWk0Nz0jigj+8c4S2zS
         SxO9bNeA0t9RbuTyshJrrw+dKR0SSjSGOszRcd90uJiVkGw1jE1/5fwx08jONrL3310h
         t2gG7qXyfPeVr+mmRJiP48ihQveDaWhvsn98JUu+1NNlUTeF+Nj6fQCzECkCCyzCcMdp
         oudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745006389; x=1745611189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwf2pqYvTfZAKWRzV4AAx6ws0t+3hl5RqCYYJcwd3fg=;
        b=hqyojrdKnm4kfxszMzDunWOpuUHNdEt5mTkWDKRK4KVeNniZiG/4Uo82SpYruS2GYp
         LN+rWQVp8Otux7Gfa0Y22Hd4hHHm93Ut7a3HCAaXMSJVYEYBnbK+/25g/Bc5akrix4cU
         JiKeNVkcOgNZw/Z7obh9dW7uZm65Sm1udBG+Vj92IBmoZiAzq+5f2kcDBk/LDTG6MIOj
         D7Yk44PsT24/rYRlbenPFNeYaoYqad6uzE43kUaJdElbFXf0VLHCh/JiX4btwYbQtjX1
         U475vmGBXMIJXejbfw6nTvspIRkK4QYOObAdkzPSTzGe7Fr+gO/dcSG94A1EdJpOgL4I
         Jjqw==
X-Gm-Message-State: AOJu0YwFKp1cXtOZ5qdAhzcsxZ8ObMkOlvkIwdA7+XLOi3tGTcFTia/0
	z9bAqq5UaVvKi3WZctpszUMTws6Fqj6mk9TU5IANYb9t3yhQQMukD1++LXYhvV0=
X-Gm-Gg: ASbGncvIxXp0K6iTfuDLFxg3f6FVLIifRl39RtVvUUjCDJbV57DSAvmPdoe19g0tVk+
	01hDXX0+kNbOpT7YXmdNHcOAJAbAw8ip+FLc0PAhJjGGlT2afSkqqK/9QY9RjPvH4SnVinKHuPK
	kZU0kkG5azTlktMBnV/lA+2z8bxOFWM0DUKc/sXDfPZHBIxfuBTw8Sirskx1PftWf9nCXB+xOD4
	FlBr1Zeq7T2RpaNieVPvuqininqDztkXvk+qxFxqbVVNEAyoMjSzg6KhAgjzqrA5LO1wjj8s4Sx
	WucvDl6G92o1HAzzocuvjLQdDqTEvoZNNe7ptcFzlUF6t+w3SXfgXAoJ6Q==
X-Google-Smtp-Source: AGHT+IFwZ3EWj8a1332iU/6yoy+sVrn6yZp+kcyFC3R5X2BbUGWBQCdaSARBWT9nwdH3ywi0Y6UEcg==
X-Received: by 2002:a05:6870:1b11:b0:2d0:4a2c:7c22 with SMTP id 586e51a60fabf-2d526ae9243mr2222694fac.18.1745006389633;
        Fri, 18 Apr 2025 12:59:49 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d5213f8e4asm606941fac.23.2025.04.18.12.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 12:59:49 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 18 Apr 2025 14:58:22 -0500
Subject: [PATCH 03/10] iio: adc: hx711: use struct with aligned_s64
 timestamp
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-iio-prefer-aligned_s64-timestamp-v1-3-4c6080710516@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1648; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=lGbQ3dZga8UFYhE2RmKRRSTA6YHIjjV8TI3JBRQo+eI=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoAq736zDtgasDsEkD9rWkk6FaF1wjLFLYYEylg
 PumkP1NSyGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAKu9wAKCRDCzCAB/wGP
 wGuVCACVD/U6ho5K+XhYyv2ZNkNciwcFJPn/JPwQupiAbpUPj2JNFkyuR6gPyuLTUVWvVmzG4s9
 FeA62PoeKoiQkB2DMCf/dAnzaaifeKAjLoJ0IrqCYNoyxwMa5JNelAZOuNDyAilVXoH8vdGWVjy
 qpMHWiMGa8zdWFx5cTHLVkqj+fvO4I6AtQvTm4/k2nejdcLCE6Lm/6NF5HnwgrBgP9IZ2jOcMx4
 0RxycD8GgRzI6AiAJv+nN7K1NWEz8zjk/ja29Z347y8KgnYnl5dckBrqu858JTt1s8lEvLS1jml
 BgZmOJfTqI6VwbEvW3F38Hc51xsFx9QMlH2Dhe9oF5v8D+xK
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use a struct with aligned s64_timestamp instead of a padded array for
the buffer used for iio_push_to_buffers_with_ts(). This makes it easier
to see the correctness of the size and alignment of the buffer.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/hx711.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 8da0419ecfa3575aa54a93707c681ec8ced28be8..7235fa9e13d57c693751757c5d40e8a799622f17 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -87,7 +87,10 @@ struct hx711_data {
 	 * triggered buffer
 	 * 2x32-bit channel + 64-bit naturally aligned timestamp
 	 */
-	u32			buffer[4] __aligned(8);
+	struct {
+		u32 channel[2];
+		aligned_s64 timestamp;
+	} buffer;
 	/*
 	 * delay after a rising edge on SCK until the data is ready DOUT
 	 * this is dependent on the hx711 where the datasheet tells a
@@ -361,15 +364,15 @@ static irqreturn_t hx711_trigger(int irq, void *p)
 
 	mutex_lock(&hx711_data->lock);
 
-	memset(hx711_data->buffer, 0, sizeof(hx711_data->buffer));
+	memset(&hx711_data->buffer, 0, sizeof(hx711_data->buffer));
 
 	iio_for_each_active_channel(indio_dev, i) {
-		hx711_data->buffer[j] = hx711_reset_read(hx711_data,
+		hx711_data->buffer.channel[j] = hx711_reset_read(hx711_data,
 					indio_dev->channels[i].channel);
 		j++;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, hx711_data->buffer,
+	iio_push_to_buffers_with_timestamp(indio_dev, &hx711_data->buffer,
 							pf->timestamp);
 
 	mutex_unlock(&hx711_data->lock);

-- 
2.43.0


