Return-Path: <linux-iio+bounces-7345-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB4B9286F5
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 12:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5D52825CE
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 10:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790DD149C78;
	Fri,  5 Jul 2024 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SiNH4KMn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948051494CB
	for <linux-iio@vger.kernel.org>; Fri,  5 Jul 2024 10:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176063; cv=none; b=G/h0wgJrHaEi4IM8bLbB4g5W4Z5mca1EeKEy7/J1zAdh+N5I3va79Ln91A2t3tXJYXbVMCFj6JpvUUcGhQC1r8Gx5yuomlKITXXqGpCm9baUABolcG+cWDnYmeXt9HGf5hpX89/mpdTYbTTSlWj6uZP0T3W5M42EVtirLUn8dHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176063; c=relaxed/simple;
	bh=8UqNvu97RyQCvnTqNuJYZZnXKv3X2QTRkCh8H7bl7SE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kw9X38jM2bp/5qoQQlI3KNmi+EjoG9H70cl1WoZHEJKrisMRjHqdWs6xa98t9Lkawa67Pdp0Fzx1cxklLQgqhpEbLJ0VbNcUIYj93IkusYDX3SwzCX4VPHszIaADuXZHXbNNhOABp9o5l5CLhpl0cOLa8kMQgEhbTJ4daUPIBgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SiNH4KMn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4257a390a4eso10186365e9.0
        for <linux-iio@vger.kernel.org>; Fri, 05 Jul 2024 03:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720176060; x=1720780860; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTC/Azk6QuGeCqi4nXZfSzWiS7YtP2rKGZn+knA+oxU=;
        b=SiNH4KMn4/W5UrURy7iRNUkdTW2nR5pQCry48i/9dBH7GJkCZ3j7SdyRGMW1LA+Ha3
         yReU965Z1p6/GedPT4OihCuesExJ5oz9dQ5KkJn9DDuB6fS22zQWXNJwhQc8r/t4nJ0q
         FE2eqLGzzyQXHH4nJemhfE59CFJCEORiAmNgaG0Dlnq9YPR/PE2pRQtfHWo4CKj2pown
         soUmsoctNudhR6ShYXhtLRY12w1TSKEuFgyvETa2w+V/yZ0APgYbKNcK+gCCHkZ1kT70
         uZkt26mFOX2lYrqL1HkB+yTKIXKjpZ+nJpZrX/o7SXr5QMcQMjHYkv13eDvTjN8lfZSl
         fhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720176060; x=1720780860;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTC/Azk6QuGeCqi4nXZfSzWiS7YtP2rKGZn+knA+oxU=;
        b=VBKCOjfH8gqBvR9cKLr6Kt6rfx616YIk4z1Rj2LAnxjja7pqS+B6Wut+NLW1Tiz6RF
         7Ph+nJs9NoSsu9CJ/slAHmu82UXaDKh03WtcsJxwCqv3QI7aKt3TNQB7gy33iZtUj7EF
         hPm4pR9sta6y7mQ1HMQedBiSJYO4aqF1vE1Hc4g8EzAK4PxZuqR9DdAeKm93uMdagOFy
         AwgTjCP2HXA4JduwaV0bk7RxgJqU1aHLeD1pS4hnOSuyBNjzeEQGss/rYxGnlLWu6j+O
         wCbWOSOiHzwomFNpRy6Y9t7tPIKtxMHqzIO6n1mqdsZDR3c1hP5wmc6Na5O52STZN3uz
         nX2g==
X-Gm-Message-State: AOJu0Yw+ZDJCrOy6Kbh6rQrIh8EhDEYD9Zzdujed3VyFQWgVx7mh3/sF
	ye9pCzVq7gmonOUccr5dEMXmSDBMoXcLRwtMtJGDOsIfrD6odJsi5iF8D5kS+BXJTPP/Sfgufoi
	z
X-Google-Smtp-Source: AGHT+IFpPHqmjxp2CPDg1mV84p7LQ3rhp2DLU/4rV2/xi9+XlRjQpCs244ba3YRg8O8NY0lubgaIhw==
X-Received: by 2002:adf:f7d1:0:b0:366:eade:bfbb with SMTP id ffacd0b85a97d-3679dd651ddmr2544484f8f.46.1720176060011;
        Fri, 05 Jul 2024 03:41:00 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36789d5ec1csm8680446f8f.37.2024.07.05.03.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:40:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 05 Jul 2024 12:40:47 +0200
Subject: [PATCH 4/6] iio: adc: max1363: simplify with cleanup.h
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-cleanup-h-iio-v1-4-77114c7e84c5@linaro.org>
References: <20240705-cleanup-h-iio-v1-0-77114c7e84c5@linaro.org>
In-Reply-To: <20240705-cleanup-h-iio-v1-0-77114c7e84c5@linaro.org>
To: Dan Robertson <dan@dlrobertson.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2264;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=8UqNvu97RyQCvnTqNuJYZZnXKv3X2QTRkCh8H7bl7SE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmh82wGqZAMadIz1XR5aj+8tdWoDISp1r2Kw1oO
 rXfx9a4AMKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZofNsAAKCRDBN2bmhouD
 16lzD/9AhnxwXv5OrwJjGIWy8uU3qbq+Ay+EYJfL4l7G5eN2ahNnoKc2trvkQGgIk4WpPVAl/We
 GkkGk91bFiIseEUezi8Pq2WkeJE4jah4gZ1ygbkxeSoKAVnlO+SAGNANz7jDm41gc/Cdxfb7gfw
 RoxJrHybC9EUzc/Snj1m8vWzWcqbw6cMpbaZwsYGNA3hOxzdM41aC0zySf1oV/XpDuUoaAfthbA
 M0YWsOzOt987EMMYpFobfLLz9XC3M6CZ3vX4dvm/RRnGqtwg99piq5uPgVHV0lSgCi8EfyJLSZN
 zejEnA1hsYNUX8M22MABU7/A5LHcKcuT54Qm2bqIBl0vV4VqDMnHp1QcTyiVAG9TVcbk4ikpMCM
 iSd3V+bj1cxn2zQfR8C+UxzTzHX92pK5G0YYcL8x4MFdemOQ6VN0Icb46+2qHYmirioczwvybFJ
 500larK7cxtaZ75pdWVz0Snsfwk6C7wcsPY7n1gf0NZOG14tx2Cc5K6LyWNsfoB9xFndwAAKiUJ
 WETcQ86+nEMU0vwIPBMsPc30EF36mLPmM1ImODNcM9VXC5Myq5luyWftG3KqH+BJXoGGg/KYA8+
 rs9rV6DqNRDyFhplpy3WFo7+5A//cOVA98Oo548YWTh2Qgmbe/ynrm7kVPK6pVp6ACc5YkeH/sx
 FBbXnIJipqkVO6g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Allocate the memory with scoped/cleanup.h to reduce error handling and
make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/adc/max1363.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index bf4b6dc53fd2..d0c6e94f7204 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -13,6 +13,7 @@
   */
 
 #include <linux/interrupt.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/sysfs.h>
@@ -818,7 +819,6 @@ static int max1363_read_event_config(struct iio_dev *indio_dev,
 
 static int max1363_monitor_mode_update(struct max1363_state *st, int enabled)
 {
-	u8 *tx_buf;
 	int ret, i = 3, j;
 	unsigned long numelements;
 	int len;
@@ -850,11 +850,10 @@ static int max1363_monitor_mode_update(struct max1363_state *st, int enabled)
 	}
 	numelements = bitmap_weight(modemask, MAX1363_MAX_CHANNELS);
 	len = 3 * numelements + 3;
-	tx_buf = kmalloc(len, GFP_KERNEL);
-	if (!tx_buf) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	u8 *tx_buf __free(kfree) = kmalloc(len, GFP_KERNEL);
+	if (!tx_buf)
+		return -ENOMEM;
+
 	tx_buf[0] = st->configbyte;
 	tx_buf[1] = st->setupbyte;
 	tx_buf[2] = (st->monitor_speed << 1);
@@ -893,11 +892,9 @@ static int max1363_monitor_mode_update(struct max1363_state *st, int enabled)
 
 	ret = st->send(st->client, tx_buf, len);
 	if (ret < 0)
-		goto error_ret;
-	if (ret != len) {
-		ret = -EIO;
-		goto error_ret;
-	}
+		return ret;
+	if (ret != len)
+		return -EIO;
 
 	/*
 	 * Now that we hopefully have sensible thresholds in place it is
@@ -910,18 +907,13 @@ static int max1363_monitor_mode_update(struct max1363_state *st, int enabled)
 	tx_buf[1] = MAX1363_MON_INT_ENABLE | (st->monitor_speed << 1) | 0xF0;
 	ret = st->send(st->client, tx_buf, 2);
 	if (ret < 0)
-		goto error_ret;
-	if (ret != 2) {
-		ret = -EIO;
-		goto error_ret;
-	}
-	ret = 0;
+		return ret;
+	if (ret != 2)
+		return -EIO;
+
 	st->monitor_on = true;
-error_ret:
 
-	kfree(tx_buf);
-
-	return ret;
+	return 0;
 }
 
 /*

-- 
2.43.0


