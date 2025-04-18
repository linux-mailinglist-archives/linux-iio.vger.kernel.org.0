Return-Path: <linux-iio+bounces-18295-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F177AA93E88
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 22:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FB7F7B42E9
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 19:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B2D23A9B1;
	Fri, 18 Apr 2025 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HC3P4PDu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A413022FDE8
	for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745006391; cv=none; b=Ko9OjkSmPspTncfJH9o1lI5Y1sw0PFofmvm0MvFlJgIP2RtqOBzc8um8Mxs6GCqfCO4NzXNDiDAPcj0hfwoqYhqnCFoA8hLucLrBLSg60RlqA335Td5FuGmApIQaGDJSZw3BW1Z3TTOuusw+rSSqDKhhjGODHre2GPLnCdAyp3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745006391; c=relaxed/simple;
	bh=uGEGli6agFbSIEZPgrYVG1FE8mDYaDMCfJyp/lazgiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jjj+TGfy8fhEZnVv9Z+J3BZUS7P+xWnMlrSI1ylQWK8gvd8ZvmudxIcobfi7d2MwchXvgfQkNbzXJqG248WGUcvURWnvcrRmf3JsRjwKPhnjcyamGJCGwNIqH1ry0HRrEsH5CDqYZXPVGSGFR+wi0oi+KfsT9QA9x9f6lbrG4Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HC3P4PDu; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6047ec0c998so569789eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 12:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745006388; x=1745611188; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ksSqxXQXgKq3MEdL/jjg1tyq7wfP3KlJsiMdvfm/kDA=;
        b=HC3P4PDuwWjmZHn1NV2atHpeI88rsWvlQjNqT6Kks9smJm2Yme6gsTUe967WKG+k2X
         oKg3+/1Ao1jvMbWk6TWMPnJ2RJ8ORTsf6AjGARYr4YYhxqQciv56FCeYQx33wK4DOdJA
         qkNtoxXFv9MlG+QxuMoPCUDG4QPeR4sAXovkSdf53WG450xxiDb3/RvvhOGQcehWP2GY
         aBXf6fzoI3u0rj3nVyfA9mxpZlfBwKMU4wbpEYn2A6wPm9oJiRVBD8+6d8yBEJWbi/MW
         XytFzwz0vEHBHNG4VqSeIlxG1wwNR2t6NmLAJbDUCYt+P5ouCqArny87lO7HzH0ZW9Y4
         cDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745006388; x=1745611188;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksSqxXQXgKq3MEdL/jjg1tyq7wfP3KlJsiMdvfm/kDA=;
        b=WIzVj0Ba4PNAsNPYHOphYtg6aVnNHWND7Myluzd5scS+inS26Fh7m+2lr4B+SQBo3J
         HPJq3yWSLWTPVmv6pHEyPlqJLkj7X/t8VG21HjNvVFCYuEQoP9WDFNAixsnXU0qqpwGd
         CW/JnYI4/TXYFeAmo8np4aIX5XBO16DUSNk/z8krpASs9x60iTUcTK5mneLni5ltPHln
         mq4Yux/WGY9x8OR02OioWdz4qo0dyrv9y+JbPnArl/X7JO3+0Ry5lHC///vv8FEOjnnB
         8KBjLcTBbYKmEnnboTczIbq8QFjh9mnot3Yrht3FIkw+c6NC2Kxe9jxo2XH9FXLgnjwA
         EG5Q==
X-Gm-Message-State: AOJu0Yxo48C5tI+5DbuASTW2kefsXF4r54YvGaYz4EcODek7wGKpeOiU
	wtCHmHNx3sqDyI2sjQUZf7ZG8pVUzzPr4BnJsJbrOdx5bk8MiT78vz5/QIT0Ddk=
X-Gm-Gg: ASbGncvdG+aBQOJJkmKiQmMy6cLP+W1Wn/NLcYDNfI+HSTkBIyv/VgjqdUcBOr4YrY0
	2RAmYwq6HgmzVDDeP0etOLob9i0uJ60ECnWat8eSb6znFvUWfboZfF3VNT1kjq2RRS3ejryB0MM
	PILbM+JgC0+oYZ84U5J664HuqI7jEnRPX3unNFGO6hMWxxU5mj5llu/oXR3gVfo++nsFlKYov/k
	3lqixImoxma9iZ1lQzyIVYLtPIX1Cm19kAeNHIWuO4x26X76Z1p+jYxkccvrFanUrBmyuTSCNcE
	aDdKcmY7EA9d9f1S/J9BeQ0yZ/oclXQJyhj0j3+As3mFFjA=
X-Google-Smtp-Source: AGHT+IFj8rQZMZvtPmVYvlswaBgMb9r1fm1cQCciAYKz5X9YEKQwhLXdNPStKbPWJNkdDXJj7/qY+g==
X-Received: by 2002:a05:6870:9e0d:b0:29e:671b:6003 with SMTP id 586e51a60fabf-2d526e0b311mr3083100fac.32.1745006388641;
        Fri, 18 Apr 2025 12:59:48 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d5213f8e4asm606941fac.23.2025.04.18.12.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 12:59:47 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 18 Apr 2025 14:58:21 -0500
Subject: [PATCH 02/10] iio: adc: at91-sama5d2_adc: use struct with
 aligned_s64 timestamp
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-iio-prefer-aligned_s64-timestamp-v1-2-4c6080710516@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2897; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=uGEGli6agFbSIEZPgrYVG1FE8mDYaDMCfJyp/lazgiE=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoAq7vX8GGgAAxPwrJ/N9bdFji+tUrDObD7oWs0
 DvLOxngo0WJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAKu7wAKCRDCzCAB/wGP
 wPcDB/9Rn9JB9hcWF+vXoNFbgTyeYaeIohNCTpSNvM8pHIkYDyV+bTUeYPRDtYP+ubhiUNbAVy3
 3VZ841HJG9nqewSUOCOlBAE5AkziGAUm5bSrkL5ifXr3DSLzxkPnrQ3Ao3AiutbhF1sclOUJ3ye
 nheGCoAyzEluF3FJD2g70v8IDaD6bh6vaEe2yMQL8BSBuuaP5NZQw8HIM6Ek1xhsC1GWZ86urbo
 8Xxzad8bX2Qv8/zWuuH7qTCszseLNJdsXQXnyGDF5WJ/xCTvHU0VOpfaB/PB1RPj58Y97aA9QDD
 PTkAvQX6xnNlTfsPVMqA6uDJtbSh6vQzTQnrXLTEGHqPBUM2
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use a struct with aligned s64 timestamp_instead of a padded array for
the buffer used for iio_push_to_buffers_with_ts(). This makes it easier
to see the correctness of the size and alignment of the buffer.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 414610afcb2c4128a63cf76767803c32cb01ac5e..07ced924f7a6ae36fe538021a45adbf7d76c2e69 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/sched.h>
+#include <linux/types.h>
 #include <linux/units.h>
 #include <linux/wait.h>
 #include <linux/iio/iio.h>
@@ -586,15 +587,6 @@ struct at91_adc_temp {
 	u16				saved_oversampling;
 };
 
-/*
- * Buffer size requirements:
- * No channels * bytes_per_channel(2) + timestamp bytes (8)
- * Divided by 2 because we need half words.
- * We assume 32 channels for now, has to be increased if needed.
- * Nobody minds a buffer being too big.
- */
-#define AT91_BUFFER_MAX_HWORDS ((32 * 2 + 8) / 2)
-
 struct at91_adc_state {
 	void __iomem			*base;
 	int				irq;
@@ -617,7 +609,10 @@ struct at91_adc_state {
 	struct iio_dev			*indio_dev;
 	struct device			*dev;
 	/* Ensure naturally aligned timestamp */
-	u16				buffer[AT91_BUFFER_MAX_HWORDS] __aligned(8);
+	struct {
+		u16 data[32];
+		aligned_s64 timestamp;
+	} buffer;
 	/*
 	 * lock to prevent concurrent 'single conversion' requests through
 	 * sysfs.
@@ -1481,14 +1476,14 @@ static void at91_adc_trigger_handler_nodma(struct iio_dev *indio_dev,
 		if (chan->type == IIO_VOLTAGE) {
 			val = at91_adc_read_chan(st, chan->address);
 			at91_adc_adjust_val_osr(st, &val);
-			st->buffer[i] = val;
+			st->buffer.data[i] = val;
 		} else {
-			st->buffer[i] = 0;
+			st->buffer.data[i] = 0;
 			WARN(true, "This trigger cannot handle this type of channel");
 		}
 		i++;
 	}
-	iio_push_to_buffers_with_timestamp(indio_dev, st->buffer,
+	iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
 					   pf->timestamp);
 }
 
@@ -1643,7 +1638,7 @@ static void at91_adc_touch_data_handler(struct iio_dev *indio_dev)
 			at91_adc_read_pressure(st, chan->channel, &val);
 		else
 			continue;
-		st->buffer[i] = val;
+		st->buffer.data[i] = val;
 		i++;
 	}
 	/*
@@ -1691,7 +1686,7 @@ static void at91_adc_workq_handler(struct work_struct *workq)
 					struct at91_adc_state, touch_st);
 	struct iio_dev *indio_dev = st->indio_dev;
 
-	iio_push_to_buffers(indio_dev, st->buffer);
+	iio_push_to_buffers(indio_dev, st->buffer.data);
 }
 
 static irqreturn_t at91_adc_interrupt(int irq, void *private)

-- 
2.43.0


