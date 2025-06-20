Return-Path: <linux-iio+bounces-20801-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4F1AE2595
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 00:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795FA5A3130
	for <lists+linux-iio@lfdr.de>; Fri, 20 Jun 2025 22:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F74248F5A;
	Fri, 20 Jun 2025 22:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1OVCScBd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86CA2472AA
	for <linux-iio@vger.kernel.org>; Fri, 20 Jun 2025 22:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750458090; cv=none; b=M0+D+dOAr6nKbhygLrdCvAA4ZRwmKRPKjlPm8ET8B74BBaeIMyOH/mIGO2gBHnZ5FrqXiYXwwlhpcSTKYUQ4Q3hjhYJCPa0NR3E4TwAaxVFlcLI9FF7cO7Wds8AVxy9VUvYbiSRcuGZInHF5SKnMJgkIIR7vVU/9DnWzI1ES/M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750458090; c=relaxed/simple;
	bh=ndollx0hHuXyYrWgV+w7a0yS9z8LaB+bJawqeWV7C1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TwqXpHn7jO85nOEST6MxBgu0Vl8apZIWMZfpaxaJz0df1JhAaRR2lRMdTDgqo8By18zzfIUka5rvsfwbpeOX86xS7NnalWoVGLwQjICEICPxksNLn9RxA6G4BmqkSqpeXxD6gu3d7A2Eb+HSzv7LzzOhb+gabw8VS6p7UHrDLNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1OVCScBd; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2ea0086338eso1372806fac.1
        for <linux-iio@vger.kernel.org>; Fri, 20 Jun 2025 15:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750458088; x=1751062888; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3u6qop3BKgIw2zioaLcZOAXEzoElBarrBAd4z+BUYE=;
        b=1OVCScBd4yrIlZmue9sSiZMcFX6Wmxed5oX6wU8BgFDG8uTs0Q9+z2fZwP/tEEg3Cn
         +0dc4vTYDtW2aUryy+H9bYGPcXg1ZHonnLTKQ4Qc+QUkMJPgCuwSP4vhIQvDvReepcpN
         9v1DR+tBHa0F2GCBH3MDY7V7zlZ/47fxLOpR8PJB3VvhZTQPchDU8Gz7zENTkb7Appbc
         0qKUd8lHUfkck1juG2d4GgkLFstxPTTuns6IjboDVh6gwS6ILK5JGFo+tSDtVk2CGWRu
         1w0tb+VPmXOnTohAyqToxaDnjxaMFTT4JrHWBYHL7PUCOzix7cW0GMAMZCqpykcHQDsu
         5FGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750458088; x=1751062888;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3u6qop3BKgIw2zioaLcZOAXEzoElBarrBAd4z+BUYE=;
        b=Hn6sBkJRc0rJxznl8fIL/al42/pStKETBZQ9TuIaFJYoaakpJ2tbT7JeCHQhxqkJCb
         4OAMa3+bhj9JGhBihXVlxsSF9vBOooMkInD1JMqoLzvwPOnP1nHyJ+mNERchDX5JShZK
         MvxlWkJ5jG5x9ri4QCfdwAEtfWLrubqE3eMVC1dQErE9YEQR/DTUArhqcRdJysOON0X8
         wn8aNdksqC6Cy7NGr/+kYDHrk+CXOdZVu5W5jyI/z4wUhQYqXtadkz1Ktd7iaF+Hqwi/
         MkvBq4miC3Qo5LzKmNd7/dJ5UjUE5HzPYvYhtWct0MzVx1kRlAtbEPwwnDPZu1WuKZFb
         xBXQ==
X-Gm-Message-State: AOJu0YygHyFS4Y8VramEf/PgjifqKlvbYr8B3Ob68iSUtgRJrQqvO/yy
	H4OAPvkpOVxiTeWwF8dpI4NGOfXtgT8bWJ6RoQa4WbQWN532P0l8nRS3hDtpsWDXh9Y=
X-Gm-Gg: ASbGncsU3pFXOwiurLop8oqbr7vgbLRSkrW9zDqLfd1Y/6D5ob4dySmDMWxll1KdOp5
	IIgv4d9K7xNMQrUPSnpbe1UAJznbHegnOXGSR/5+h+Yt3w5CEmJT6BmXsAjxl/rofjLlXgvYokq
	TOEpBjFbaz/HNf23VfoNC88fdGfCQ+MK9uzvMCNcQ0tII3gsr7/9S9yM5RMtleZRV+/J7fm2jyn
	1P4QgleetC/AMn9nxqxWO/2T+EV8TCW8ZtQq5dHpIJvaz5c6EYqdlN1dTqVfztCas6PA+oP8bSh
	Ub99sygqIFXJVHBiq+fioREixhYpP/sju+CqGDg03H6sAfZS/fO3TSQL9515TIpJmitGp9Svbuy
	MCio=
X-Google-Smtp-Source: AGHT+IEX1777Y06ItcBBP4l8QpCXPpcGQh9aDgmKoVRPlC3y0zOyjItWT/vafA/dCJ6lPmB+M/q+RQ==
X-Received: by 2002:a05:6870:d68a:b0:296:a67c:d239 with SMTP id 586e51a60fabf-2eeee37f070mr3109724fac.12.1750458087845;
        Fri, 20 Jun 2025 15:21:27 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:c4bf:cf27:203c:f8b0])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ef481fe06esm7561fac.35.2025.06.20.15.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 15:21:26 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Jun 2025 17:20:09 -0500
Subject: [PATCH 3/9] iio: adc: ad_sigma_delta: use BITS_TO_BYTES() macro
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-3-0766f6297430@baylibre.com>
References: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
In-Reply-To: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2415; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=ndollx0hHuXyYrWgV+w7a0yS9z8LaB+bJawqeWV7C1E=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoVd6wKUFl+BJbccGKOMPDZhFwWwlJmZlKp6484
 HjZvLArD6SJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaFXesAAKCRDCzCAB/wGP
 wKsgB/9q9AuTiwp7lOJRANwMucpfkpzJOrpHn8CkltOpI+aWNp+Kfyl6OBefNM8op2eNGutdhyG
 VapTsUmBy0YlNJe7zvGtVAyLLM77dKAWW+fHlZHAim6sSbO7dqepIrFVLEcPVaLOi94ij59dHeV
 XgJRxbNmWmeOBxCd4a3hj9ktQZw1X6YW89PXT9SJOxmtZJC2VdAq4p5iik434ZpESQ1vOFdBLc+
 oUtDwBLov6N/UG3U+Ids7BV8Gt1HIgLGMT5wLP3kfqKjHRsUfb+nZ0QKU1O1YJtuirDAzJVRZ8z
 RUCX8asPQ3mICKuA90/dTn0yya84VK9/4anBMUm3qqpUXhuS
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use the BITS_TO_BYTES() macro instead of dividing by 8 to convert bits
to bytes.

This makes it more obvious what unit conversion is taking place.

In once instance, we also avoid the temporary assignment to a variable
as it was confusing that reg_size was being used with two different
units (bits and bytes).

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 1657f64f1c0465b249adcc8a70dda8faf4a90565..fa792c800c80f960aca75b28a60cb2588e69fe7d 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/align.h>
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -190,7 +191,7 @@ int ad_sd_reset(struct ad_sigma_delta *sigma_delta)
 	unsigned int size;
 	int ret;
 
-	size = DIV_ROUND_UP(reset_length, 8);
+	size = BITS_TO_BYTES(reset_length);
 	buf = kcalloc(size, sizeof(*buf), GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
@@ -419,7 +420,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 		data_reg = AD_SD_REG_DATA;
 
 	ret = ad_sd_read_reg(sigma_delta, data_reg,
-		DIV_ROUND_UP(chan->scan_type.realbits + chan->scan_type.shift, 8),
+		BITS_TO_BYTES(chan->scan_type.realbits + chan->scan_type.shift),
 		&raw_sample);
 
 out:
@@ -552,9 +553,8 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 	unsigned int reg_size;
 	unsigned int data_reg;
 
-	reg_size = indio_dev->channels[0].scan_type.realbits +
-			indio_dev->channels[0].scan_type.shift;
-	reg_size = DIV_ROUND_UP(reg_size, 8);
+	reg_size = BITS_TO_BYTES(indio_dev->channels[0].scan_type.realbits +
+				 indio_dev->channels[0].scan_type.shift);
 
 	if (sigma_delta->info->data_reg != 0)
 		data_reg = sigma_delta->info->data_reg;
@@ -616,7 +616,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 		}
 	}
 
-	sample_size = indio_dev->channels[0].scan_type.storagebits / 8;
+	sample_size = BITS_TO_BYTES(indio_dev->channels[0].scan_type.storagebits);
 	sample_pos = sample_size * sigma_delta->current_slot;
 	memcpy(&sigma_delta->samples_buf[sample_pos], data, sample_size);
 	sigma_delta->current_slot++;

-- 
2.43.0


