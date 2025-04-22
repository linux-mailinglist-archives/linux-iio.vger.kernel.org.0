Return-Path: <linux-iio+bounces-18539-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234ADA97A22
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 00:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2BC217F972
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 22:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6A82D0270;
	Tue, 22 Apr 2025 22:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AjFjSY4P"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C202C1E0D
	for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 22:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745359732; cv=none; b=J1FPKPFA9WPByWfduCjWBA37wF4CuI0wZgvRKQYLY6PUtEUmOx2PukZEPiWrr7/3EeAbc+r0gO7Ns4QyKqPqkeTEFYVUxe0oo9pMup5w5zNbvxgN3YhNBxB/lO9SS/6aji0fGXeqjPvlgZN9roUiNMMvgOCLTYKoU1doPLr5TMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745359732; c=relaxed/simple;
	bh=KW72H2rhOsjzvWAD/gfaompbIwAhtAiVxmdxvtY6glI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=spxhu+sIwZ3HCjvQwKADhf7J8KTkHGL7iS+4Vq3HCHtiYIRgWIMRMqMlj4syJZJfxl1JVMMTHiJt0c9Mz1b+F8wTqCTawImZTGntBG92IQW2fyFv8oS+5i9jCBgqXsfHKGg88ebWGzb0BjizEKOydkngLIHklMOVc4hfxrOmglA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AjFjSY4P; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72c7336ed99so1692216a34.0
        for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 15:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745359729; x=1745964529; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GV/JKg4cCCUHZO4DcegT8p+GY8kK4vHWejOXinE1p04=;
        b=AjFjSY4PGLnBV7NZOg+7xZYOcx6JpcZBie9jymRQ0BcnKD3imFNG+hiJQUvNgZ5PYA
         OkLSjJN7Sm4SnLt2YhRkOwPdsdFyQxaoY8F0NsvXVkyi8ZSc4SGuwuNV6qhMZsNGLrV3
         cFELAM7+dLfSosdCkDfP7GB92yqjg2rMDkFWYQPGC3s4h2Iyv2vVWmVWVYi+8W+QQMA/
         VPYU069bf/hiJtnUlfZCvbl8cuyOmHYFZCf+l6cede8xGQTP4ipdFUc2X3Hh2hpLr2F+
         HZiGdh1rOd5PPM681siZd24MjgIYGGkUmZmNz2HbomLzM1cL6egd8jBpXV3kehcOz6Tf
         DgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745359729; x=1745964529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GV/JKg4cCCUHZO4DcegT8p+GY8kK4vHWejOXinE1p04=;
        b=pXEPY009ctBaNs3jzbsfXAwdKd0xTS8V4ShpN1an+d14rivCshDLwHCSdJ9Ov8Ow9r
         LZtx4KaEWEWIghyF9BahctItiW8OL/HCbuUa02n7cp7SFh9I2hwZWB3GsOZI6ZHP2jYI
         8Hlm5wBQQwk4+dx+HGJ+a0BqtxkyenCP6XRj5jrQ3jkYm5NlL48tFtG48keyJpir+fyp
         HcU4VaTQXEySYyLEM9ZlBMIqwgH87AMc0zhugYbakr16pspiYCaQluIL/ECeJVwOVlry
         wN1uFE49WIdMv3CQaPhYe6I/U+CzBpqxBgNcpqbSgbmKZpdQ5dqALovvTctsYDcmmZYd
         vOIw==
X-Gm-Message-State: AOJu0YzqIjrI8id9bFzMDazKVY39PpwE+r5HkWvdz45X4L0MFTSQQ4Rr
	g1gsze4RdkxCYvawDRa9bieiv2r6fu6UE2qXCRkv1hp3ZLmISkebAR6lMDzLiMA=
X-Gm-Gg: ASbGncuKwuIppNAM//5uP1/kEVrwJ1EMGD3DFDQVtK6ApgG9lkUuUC+/tZXCqWezqdr
	cY0ElRHUfLmJYdaz6kBqHt4OUk3wIk9mvqBvZrJXofoLAHJVjhGOBf0fZfocL6CmK35pvy8Fik3
	ln8GHAeqPzdfOc0LkYt0bPIONwzPpDSx22sARxUU6GAhRLthqbMFLyRmMv6us+xNX7KlcF2o7LE
	0Gg/QSF0nZfHIdJSPgQWJFnTf9JkzsWJsANya3Yh6sDZu/ilLVOdiSIZFoDMqU1uBNR7pKkS95i
	oM8LwvkWWU38bfGXndVDl17wX96iK31xuhEWLJtIMykv7cE=
X-Google-Smtp-Source: AGHT+IE7FZA50BnSF8oJmn4vSYvHiYeflUDA8NfUYzI4hEr4A9R06F1OXjWW8PDV78GuxROjjrL/nQ==
X-Received: by 2002:a05:6830:6606:b0:72b:9de0:891 with SMTP id 46e09a7af769-73006222b11mr11700069a34.13.1745359728753;
        Tue, 22 Apr 2025 15:08:48 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:c8d1:e0ed:ce8b:96a3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-730048848dfsm2265938a34.52.2025.04.22.15.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 15:08:48 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 22 Apr 2025 17:07:49 -0500
Subject: [PATCH v2 4/6] iio: adc: ad7380: use IIO_DECLARE_BUFFER_WITH_TS
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-4-3fd36475c706@baylibre.com>
References: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-0-3fd36475c706@baylibre.com>
In-Reply-To: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-0-3fd36475c706@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=KW72H2rhOsjzvWAD/gfaompbIwAhtAiVxmdxvtY6glI=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoCBNUYLKuoL2l8v5qYxFzyitlCg/RLQk56/h0w
 bWbsz80RzqJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAgTVAAKCRDCzCAB/wGP
 wOFTB/9YeOb2rt8UjFsVZfIlZEmMagVgNxYObu4fQAmL0GyrRub+pif2Ln/S81nDJAOw8uvfdYl
 JH4+CkLnoCMaiuj5bsrR2T3kVhyAuD0L2zqmYyZLMvrHBnkBUzn6c6+6MxfiqzDxMegf312U0UC
 I0QHm7GNU7Q1HqSxBojySMCGlzL9vQi1FtuZ3nw3q86r3fP05Tw9Ycgj6mG8tJKirKk5O5on141
 YD5UgkTJuyRaXIY7lVs7VtewokCoo4aJv97l6WeDdyDiwU3iinkFo1hl26Ozjx2Z55qh85CZxAZ
 Z24lYaIyx1Gy8mL2VGG0INwPKSuHd25sZraxcL2r30GDs1X4
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_DECLARE_BUFFER_WITH_TS to declare the buffer that gets used with
iio_push_to_buffers_with_ts(). This makes the code a bit easier to read
and understand.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

As discussed in v1, this one stays u8 because it is used with both 16
and 32-bit word sizes.
---
 drivers/iio/adc/ad7380.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index f93e6c67766aa89b18c1a7dec02ae8912f65261c..f89b195c644024151c14977fd43e279a67439fb1 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -909,8 +909,8 @@ struct ad7380_state {
 	 * Make the buffer large enough for MAX_NUM_CHANNELS 32-bit samples and
 	 * one 64-bit aligned 64-bit timestamp.
 	 */
-	u8 scan_data[ALIGN(MAX_NUM_CHANNELS * sizeof(u32), sizeof(s64))
-			   + sizeof(s64)] __aligned(IIO_DMA_MINALIGN);
+	IIO_DECLARE_BUFFER_WITH_TS(u8, scan_data, MAX_NUM_CHANNELS * sizeof(u32))
+		__aligned(IIO_DMA_MINALIGN);
 	/* buffers for reading/writing registers */
 	u16 tx;
 	u16 rx;

-- 
2.43.0


