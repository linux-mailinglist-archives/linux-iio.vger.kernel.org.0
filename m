Return-Path: <linux-iio+bounces-4212-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D38D8A38E4
	for <lists+linux-iio@lfdr.de>; Sat, 13 Apr 2024 01:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A7A1F21FF9
	for <lists+linux-iio@lfdr.de>; Fri, 12 Apr 2024 23:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B84152532;
	Fri, 12 Apr 2024 23:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dqw/ELXu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7067715217D
	for <linux-iio@vger.kernel.org>; Fri, 12 Apr 2024 23:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712964311; cv=none; b=Phfi35fES2T8xfwdbw53pmx27o2GR/dKOULrK20H5xkOO1P0cOB+tcj0LLYmdArJHj7N8n7/JpSXU7l2LwB3JhJezR8c95tmhaycxwO8G2LXR7izjJiiMy5qWlm6uRTVDDQv6Nml4tw3YRMyV5MXKHipkq8HjtprLCu2TQ4NIno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712964311; c=relaxed/simple;
	bh=KGyMekWTlazKBqS5Mf0nI0xFELlChiDJZMmvQrG+A+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fFNo0z3XPUKoiAXvfgwRN7tOqsxag9Wfi5hY14IrlVBqlirJmcGDUMQrmv0sJPyiDFexZJ71auSmzpaE8l/orfv/XyXM+tXo7F18EWTfFM3trql61PeH4Cy1H0h5IY4IHWpZjJTuCTRFDzao93941WKEpKe9GrCPRfPUx/ruYcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dqw/ELXu; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6eb5887f225so1009489a34.2
        for <linux-iio@vger.kernel.org>; Fri, 12 Apr 2024 16:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712964306; x=1713569106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lmhooQqIc2chRcc2CAcdYrKYNFL3maDSCzi5ZTdPPdo=;
        b=dqw/ELXuyY+mPMEQBBcaMcuPrESkGoJJ/exIivvVmKpijjq04YOuqVln0osFb45XP5
         cQJFN7ylI099jWf8BromQLiovz4H9j/5gZyI7wgwX6PGI20vypXx7PxKDStG7gN5N0Fg
         YPzsdO+MvgZDHidM1dt4IuqrdtWLKW8noMUyNq0zRybmNZs+Fl1mbymbzqKT1sIRA1pq
         VuTivesSBuvTZxO5185cJ8R8pP84vp2acDNN9UgBL0MEEzrpt6sN/0IhA4hqG993vBz6
         jhWK9MgxFZ4ssNltWt/2SOWiVL0eDmp1MT3FZnEovyNg4fWaACuCcyPmF9xn3yOfTT2S
         tQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712964306; x=1713569106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lmhooQqIc2chRcc2CAcdYrKYNFL3maDSCzi5ZTdPPdo=;
        b=FvWWnCsXlxMNRvaaDa5yuGPUbgr+78IpNktaDNcTTOwj74+qu5tv3WxBZ67spEPI/I
         p+KgVD0JzwM/NYNDRL+JgfauH27nAux1z19v2To/X3f053eE281/xS8NnXuekkRTO3AQ
         hvOlLcjb2+INjDaI3tziSqm1J5NSp6POFYdkMFVk6/Ejj3+apuduSeEyYhsFb3KdGllW
         2JJpydGvX/UkRqlBBwxigb1+zAVUGdgsjGWJoyX+sE8Vcoh/38+E7Yz45VfVUqK8JPNx
         QuRATUFCDoIUGEl9hILLOY0akeZXdyj29Id+LBjzRxwmC9P1G6HEyY2uMqIyYKSQU7Fv
         iksg==
X-Forwarded-Encrypted: i=1; AJvYcCVKw8BmyG48aHENgj37siyv1gbVvWIhzp8V/YnBCdVw7wdKxxK6rzy7qR8TwUCZyW0Xunj5lgOPWRKp/duqzzNhOdqDWc5zA559
X-Gm-Message-State: AOJu0YwZfenAikFAx1qfV+mO9OpE1dBcyp5HJXk9HPdJ4JwhdmkGNvyx
	WfExWPDPah27PWAKDYk9Y0bg6wYa3bBL4RBMAxxK65D1D4qwk+6oHgIIaPY8wpc=
X-Google-Smtp-Source: AGHT+IFKhbeDy09RPmweEEU2kr604GNlIZ6syKQfPoxLifZv0u4Qu3LWVrmTGfIVSOd1G+fOG0HqtA==
X-Received: by 2002:aca:1107:0:b0:3c5:e03a:8f51 with SMTP id 7-20020aca1107000000b003c5e03a8f51mr3716220oir.48.1712964306530;
        Fri, 12 Apr 2024 16:25:06 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5-20020aca2805000000b003c5f72e5a6asm751372oix.58.2024.04.12.16.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 16:25:06 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ad7944: Consolidate spi_sync() wrapper
Date: Fri, 12 Apr 2024 18:25:02 -0500
Message-ID: <20240412-ad7944-consolidate-msg-v1-1-7fdeff89172f@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Since commit 6020ca4de8e5 ("iio: adc: ad7944: use spi_optimize_message()"),
The helper functions wrapping spi_sync() for 3-wire and 4-wire modes are
virtually identical. Since gpiod_set_value_cansleep() does a NULL check
internally, we can consolidate the two functions into one and avoid
switch statements at the call sites.

The default cases of the removed switch statement were just to make the
compiler happy and are not reachable since the mode is validated in the
probe function. So removing those should be safe.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7944.c | 67 ++++++++++--------------------------------------
 1 file changed, 13 insertions(+), 54 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index 9dc86ec23c36..4af574ffa864 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -214,40 +214,26 @@ static int ad7944_4wire_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 	return devm_add_action_or_reset(dev, ad7944_unoptimize_msg, &adc->msg);
 }
 
-/*
- * ad7944_3wire_cs_mode_conversion - Perform a 3-wire CS mode conversion and
- *                                   acquisition
+/**
+ * ad7944_convert_and_acquire - Perform a single conversion and acquisition
  * @adc: The ADC device structure
  * @chan: The channel specification
  * Return: 0 on success, a negative error code on failure
  *
- * This performs a conversion and reads data when the chip is wired in 3-wire
- * mode with the CNV line on the ADC tied to the CS line on the SPI controller.
- *
- * Upon successful return adc->sample.raw will contain the conversion result.
- */
-static int ad7944_3wire_cs_mode_conversion(struct ad7944_adc *adc,
-					   const struct iio_chan_spec *chan)
-{
-	return spi_sync(adc->spi, &adc->msg);
-}
-
-/*
- * ad7944_4wire_mode_conversion - Perform a 4-wire mode conversion and acquisition
- * @adc: The ADC device structure
- * @chan: The channel specification
- * Return: 0 on success, a negative error code on failure
+ * Perform a conversion and acquisition of a single sample using the
+ * pre-optimized adc->msg.
  *
  * Upon successful return adc->sample.raw will contain the conversion result.
  */
-static int ad7944_4wire_mode_conversion(struct ad7944_adc *adc,
-					const struct iio_chan_spec *chan)
+static int ad7944_convert_and_acquire(struct ad7944_adc *adc,
+				      const struct iio_chan_spec *chan)
 {
 	int ret;
 
 	/*
 	 * In 4-wire mode, the CNV line is held high for the entire conversion
-	 * and acquisition process.
+	 * and acquisition process. In other modes adc->cnv is NULL and is
+	 * ignored (CS is wired to CNV in those cases).
 	 */
 	gpiod_set_value_cansleep(adc->cnv, 1);
 	ret = spi_sync(adc->spi, &adc->msg);
@@ -262,22 +248,9 @@ static int ad7944_single_conversion(struct ad7944_adc *adc,
 {
 	int ret;
 
-	switch (adc->spi_mode) {
-	case AD7944_SPI_MODE_DEFAULT:
-		ret = ad7944_4wire_mode_conversion(adc, chan);
-		if (ret)
-			return ret;
-
-		break;
-	case AD7944_SPI_MODE_SINGLE:
-		ret = ad7944_3wire_cs_mode_conversion(adc, chan);
-		if (ret)
-			return ret;
-
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
+	ret = ad7944_convert_and_acquire(adc, chan);
+	if (ret)
+		return ret;
 
 	if (chan->scan_type.storagebits > 16)
 		*val = adc->sample.raw.u32;
@@ -338,23 +311,9 @@ static irqreturn_t ad7944_trigger_handler(int irq, void *p)
 	struct ad7944_adc *adc = iio_priv(indio_dev);
 	int ret;
 
-	switch (adc->spi_mode) {
-	case AD7944_SPI_MODE_DEFAULT:
-		ret = ad7944_4wire_mode_conversion(adc, &indio_dev->channels[0]);
-		if (ret)
-			goto out;
-
-		break;
-	case AD7944_SPI_MODE_SINGLE:
-		ret = ad7944_3wire_cs_mode_conversion(adc, &indio_dev->channels[0]);
-		if (ret)
-			goto out;
-
-		break;
-	default:
-		/* not supported */
+	ret = ad7944_convert_and_acquire(adc, &indio_dev->channels[0]);
+	if (ret)
 		goto out;
-	}
 
 	iio_push_to_buffers_with_timestamp(indio_dev, &adc->sample.raw,
 					   pf->timestamp);

---
base-commit: aabc0aa90c927a03d509d0b592720d9897894ce4
change-id: 20240412-ad7944-consolidate-msg-378515e51628

