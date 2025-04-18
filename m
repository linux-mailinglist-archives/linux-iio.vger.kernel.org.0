Return-Path: <linux-iio+bounces-18300-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D14A93E92
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 22:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01950467AB5
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 20:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AA9214201;
	Fri, 18 Apr 2025 20:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bGwsBn2f"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E635250C18
	for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 20:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745006403; cv=none; b=R4IicjBHM8sTr5/kz4xNwQbSkHugQdolZ0WwSWYUJxE1Hak+41w0ysRbNHsjvyAAMUF0ChYHT/xrpX6BiPkDBN+2HF65vdujJnZOLM1ezNKkvBIOFKAuNzA51c6HA9YlTUQxel1awfjHrYT5s4uuhDwD2NcaG/+CMp3UBzT4DJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745006403; c=relaxed/simple;
	bh=s4l8P5OcPMgo24O003DNQ+152ZESYZRIhpn5OwsYUsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sT8oKBgmxFhfhj+jZBld4l0LTd7Cwgg9yOoMUiffhoHciXaAFeFP4/96W2zE9ZtpJ6TX2wzb7VyYx5vWUKJzzW3CnE/R6fFw6UJTixh3fvV4pu4rTS2x10vikg+/6tUc+cWVCbc3oitoF6HlR+wWz19NpN+wEHAX7w9hZF0kuaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bGwsBn2f; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-601f3674116so559646eaf.2
        for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 13:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745006400; x=1745611200; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1rBDR1U//AMtHVJOkZ/ynz5adiM1MIpFrbiMNuOexx0=;
        b=bGwsBn2fJo8DFeZufXc1RiPpSOiYKFQoQWuFzDhFbvLO+NgGLxp4QWKyJ7WsZS16ii
         KDtt7CuaFYGGZnLMrBd8nrBCDc1FfooQEVYxBX1W7jnXIzIycZEj5ZTnTa77ERgWKdK+
         QWdBbBi2KA+8BsePpy6/YZpQM7wLNDwdHf7D3NEdmJk0g7p8EobTQc4NjcKXmt+pg5rh
         KIVjE/+ysmcd+1J7XPKx+JWt695tsmyRYZmMy3Ui8gQFSjQSAXvYozwHkGNv+DLEmGj9
         8t/EHOnLVHtqpoll9owrzKhAJlYSZlYcQxwha6OpxEFXj3aKrP+IM/x3nm8uynAe6lH9
         BdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745006400; x=1745611200;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1rBDR1U//AMtHVJOkZ/ynz5adiM1MIpFrbiMNuOexx0=;
        b=rXCkFAsfRVhPHiFdew3d7D27S/94n+h6EYhvn+N5seLLwpP2iDW1HDu8cBwQUyhoda
         QwzVPr8Z2iMJCF8SIS/UktxiYJkX7V0iSZ15kfKlKsE9ebD2HCRkjUGZifyz6IHuq7KG
         t5UgUoPJoit0zRXFtcOY6PSn5MlHalbewSizJU/PyA3yph27B2GwWApU2SIE4jV6p2c7
         hOzEzWfSwDVRfkqvtOVXIR073ETA9Io24C8e99KPYcZ+DpxHuPTYyRqOt4y0ka8gqP6/
         bhk9ljIhb2QXxXfhYvHCIn/FLYY8HOCurFPjBahz9OMqqiCQmcUsq4dKIkmXcKy9bR0u
         BcjA==
X-Gm-Message-State: AOJu0YzkN+pvntRdgF06q1sG6eujLU/fDazVrZwG39vX7S1rem50rqHO
	isJTuKScqAwjBMP3RV9S+8bQFWsb0YFPDO5WRiI+eUxfgQlGXAtZTXGrTHo13n8=
X-Gm-Gg: ASbGncsxb2Qkm/BQTA5WofLK5CbdnEaWZF/MW5HsdkAmGexqQUXis73wK98oZWjm4fU
	GtRbU139Oe/2OrzJvkQWEGi6oE+aCuWQTPY1jQV4wrVDnFmEU1NU2Xwk2tTOeQ78i3rE6okCPF3
	pDKzeDKKDQg8Uq0x0E6Aw6vd2oPGuIgoelk+ckdJFicJldXxhZr1w6q92qSSCHNXPs5nbGHykis
	6JG0yfsxCRCKbF5dxyZjWCp9mei//aLrd9FxrNKfhdiAjgIynt9sJvZaFokcF//cSGbV6s9t0/Q
	BlNoIBk7wqNcgzidizffSi/8EIHoTmQcludADc63mrXBmH0=
X-Google-Smtp-Source: AGHT+IFESQi/ZfA50kegJe4RtMSS4PZyQ9d46ZiXlLlHIdLoF/HU+gKoBW8lEVWEJo4/bW8fFvnACw==
X-Received: by 2002:a05:6870:ac10:b0:29e:2bbd:51cb with SMTP id 586e51a60fabf-2d526d6e952mr2256820fac.24.1745006400470;
        Fri, 18 Apr 2025 13:00:00 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d5213f8e4asm606941fac.23.2025.04.18.12.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 12:59:59 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 18 Apr 2025 14:58:26 -0500
Subject: [PATCH 07/10] iio: adc: ti-adc12138: use struct with aligned_s64
 timestamp
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-iio-prefer-aligned_s64-timestamp-v1-7-4c6080710516@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2220; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=s4l8P5OcPMgo24O003DNQ+152ZESYZRIhpn5OwsYUsI=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoAq8Sfs2AclmrDLeJi56Pk//ih6Hw7R97L6d4q
 buJJAK8DOyJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAKvEgAKCRDCzCAB/wGP
 wNv2B/9ot5lFQsMp+EgjDd/QqmcvuIydEgfUNbhAvAbPepUmk89W4MY9JTUT4zxZqWE11B6m2F0
 3zIVrrIDDZ3e56OlvCdt+U/BqUKLhOsnt7igGBmtKpP4ySz0oU2RYl8BXUeKuguiIw3XupttbFi
 Ud5X97R0RJStNPy0+C0JjSr57E5J3u491cFFhlTvKsUyIMaK6HYbPkpCBGv6hdWrAhBbiabbSc6
 alXYEmMVK+RiMRZLEJr6bRGjTVLLmbdbPxrlSC0y8KZMqtcCsp066Fsuz9VN4sGrWXrTyiwPLwr
 dyjbqaoUlUuymOoPka1GF4PxTtk/WfwzI4cG7/T/LHnfv+HX
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use a struct with aligned s64_timestamp instead of a padded array for
the buffer used for iio_push_to_buffers_with_ts(). This makes it easier
to see the correctness of the size and alignment of the buffer.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-adc12138.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-adc12138.c b/drivers/iio/adc/ti-adc12138.c
index 9dc465a10ffc8d9f596e34215af685999235d690..27cafc2954e8956fbd674eb2bc32c59980ffb746 100644
--- a/drivers/iio/adc/ti-adc12138.c
+++ b/drivers/iio/adc/ti-adc12138.c
@@ -19,6 +19,7 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/regulator/consumer.h>
+#include <linux/types.h>
 
 #define ADC12138_MODE_AUTO_CAL			0x08
 #define ADC12138_MODE_READ_STATUS		0x0c
@@ -53,7 +54,10 @@ struct adc12138 {
 	 * Less may be need if not all channels are enabled, as long as
 	 * the 8 byte alignment of the timestamp is maintained.
 	 */
-	__be16 data[20] __aligned(8);
+	struct {
+		__be16 data[16];
+		aligned_s64 timestamp;
+	} buffer;
 
 	u8 tx_buf[2] __aligned(IIO_DMA_MINALIGN);
 	u8 rx_buf[2];
@@ -351,7 +355,7 @@ static irqreturn_t adc12138_trigger_handler(int irq, void *p)
 		reinit_completion(&adc->complete);
 
 		ret = adc12138_start_and_read_conv(adc, scan_chan,
-					i ? &adc->data[i - 1] : &trash);
+					i ? &adc->buffer.data[i - 1] : &trash);
 		if (ret) {
 			dev_warn(&adc->spi->dev,
 				 "failed to start conversion\n");
@@ -368,7 +372,7 @@ static irqreturn_t adc12138_trigger_handler(int irq, void *p)
 	}
 
 	if (i) {
-		ret = adc12138_read_conv_data(adc, &adc->data[i - 1]);
+		ret = adc12138_read_conv_data(adc, &adc->buffer.data[i - 1]);
 		if (ret) {
 			dev_warn(&adc->spi->dev,
 				 "failed to get conversion data\n");
@@ -376,7 +380,7 @@ static irqreturn_t adc12138_trigger_handler(int irq, void *p)
 		}
 	}
 
-	iio_push_to_buffers_with_ts(indio_dev, adc->data, sizeof(adc->data),
+	iio_push_to_buffers_with_ts(indio_dev, &adc->buffer, sizeof(adc->buffer),
 				    iio_get_time_ns(indio_dev));
 out:
 	mutex_unlock(&adc->lock);

-- 
2.43.0


