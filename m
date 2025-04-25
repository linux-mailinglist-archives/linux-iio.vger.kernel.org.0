Return-Path: <linux-iio+bounces-18668-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40893A9D3ED
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 23:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B7A3BC0C7
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 21:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB730227E83;
	Fri, 25 Apr 2025 21:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XNa6+8rB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B549B224882
	for <linux-iio@vger.kernel.org>; Fri, 25 Apr 2025 21:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745615385; cv=none; b=Wd2r6B5CkFDKRzVBj6pMH68GooNor8SeXb0o03fWyBOJj2P9urlzznB5aAxFaYTNdV47t0hjQESF/9r08Yxng7Evjl0F8iskU/Vk9pCxA/FiqUCmnkKjD2jfiZcFXalNd0tJsQWLYyXazMnkCgPdaNBpsSTgEeot+MfaWaRerb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745615385; c=relaxed/simple;
	bh=htzNMPXlRVfXDBCUzoC72qPIY7Dbustt/aeF0u587HA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ciVWi9c+rv4+H7+tY4SEjmZtwrJXKiV9X+xF7OVdgKz1JBur85mm/Q6lvWPsZNZRG5uqFIdJ7Z+WrAKcacyQib/8M1dN+02jCrUp0gGNM+1ooFMSqzRVTk3EutaFmDv33d7FiA9M/KoyRUVA2RMGVK6MnyfyjWZcXMKM1rjA2D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XNa6+8rB; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-72ec926e828so841486a34.0
        for <linux-iio@vger.kernel.org>; Fri, 25 Apr 2025 14:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745615382; x=1746220182; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ml14j4CWVwjgejgx5bGL2isKAmgSSnndW82GfrPbAUk=;
        b=XNa6+8rBulJNNrKeacA3uBndgqIlUPFmwRxTDYW58fUqOddRTsI1vm94mVvffDn9PI
         9bm6D8XbTltR5Xr72+ob+CHzb+zlxeF4Gin9nIFfU9VPBd8/YEq/rTj2fs7nwVRnpauz
         ghD6/8JAlqStkJePGeLX6L3l9ADL2P6v4uArMkIUx81HqoBHcKBYh/gmerLtlI//TGxn
         m9o/v5dbWvdVnOsx7i46Eii3JBCjph1iHyn+zcyBh/CB/E7Vk5s7Dtp2HzVuhASi8rOa
         bNwk9MOUodklIC78EH5lRLLdGZbI/RLRtdn4TnhvR6GBZ8a3vPgnlEweB/o/8dSqA31m
         eOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745615382; x=1746220182;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ml14j4CWVwjgejgx5bGL2isKAmgSSnndW82GfrPbAUk=;
        b=WaHpdvi7DJ3rICcsZ2Kj5o5yAjIZfPBPjmVSbLzCYWGcjpdXOB1KpIVreFdhtjhEr8
         xZPE2EHFbV0hsL3bxuGpgpOtHWQmkQjqRBk10aDrOY0qJXenv1qfAVFAf7KQFi3M95tt
         RkJV/6ccNUU9ADzMLn4ZKDNoy+Jsjr4ov/2NgVB3zwmxDpQHzG2+/CEMCAtEOzLpjJRp
         pEFPlAjAtvxcVVUZ2SPiBlQUcxjwX3bpNs8VyNfIzHXFKkZ1r4VGHhUXhQ7vm4RSRMg0
         tV506D+l44C6EgMErdpjoOgR0ibc3nZ0fDhkJTpRihfofTD2LLv1U940PIsZGHiXzWhP
         CvOA==
X-Gm-Message-State: AOJu0Yxh++5laDG5Ak9eLd+txk0fq6QbRHyFJIl5HUO6ZvJzXrA6Em8O
	vzhTM1ydbGOiw2UNpjvoVmGBs+Vr8kPCssfN4NLTGEw1Tq/wbpgZ4tkxXC/JD50=
X-Gm-Gg: ASbGncvOHgBN4tWVTnSbZJAzSMbHNJh0enjjnSc8pPHSLYbbGeyYyrLrqiKrDjCqiEP
	39+a+uesx3uS7OgpVnSLletr7GBB6uOhU92QExwXVpaFgA1hKTuH8Qp9//TJ7ZO24j7sTySBoA5
	GjCe0J76RmV9aKWqeo4eVgIaN+zfCUI14DarfnpSZ9stxQgrySdn8xXu+LkF9+fXfWdZcRhoLaS
	d7Rm9RsC7OutmSEfOhIAgdKYLSERyW5oVN+q5qUKuQROmIJY9B8wbXgcOFGXQjZZIYqpIIzMNf9
	Yd/6L5FGSDFcFkh8Y7Fv9b1V73Mt0/qX7WTEZQARRaNE
X-Google-Smtp-Source: AGHT+IHLgQHGW0PActt52m77uug4cyBdR0f29K9AKJZKuS1/OMf1wtoVjtXc0QZ+kbE0ZSOMbu7xqw==
X-Received: by 2002:a05:6830:6c16:b0:72c:3289:ab9e with SMTP id 46e09a7af769-7306528fbbamr857002a34.27.1745615382663;
        Fri, 25 Apr 2025 14:09:42 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:96a3:e28:3f6:dbac])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f188052sm847673a34.8.2025.04.25.14.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 14:09:42 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 25 Apr 2025 16:08:47 -0500
Subject: [PATCH v3 5/6] iio: accel: sca3300: use IIO_DECLARE_BUFFER_WITH_TS
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-iio-introduce-iio_declare_buffer_with_ts-v3-5-f12df1bff248@baylibre.com>
References: <20250425-iio-introduce-iio_declare_buffer_with_ts-v3-0-f12df1bff248@baylibre.com>
In-Reply-To: <20250425-iio-introduce-iio_declare_buffer_with_ts-v3-0-f12df1bff248@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2980; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=htzNMPXlRVfXDBCUzoC72qPIY7Dbustt/aeF0u587HA=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoC/oC99c7vmgahKavaaqiaEwFgXFazfdsIHWhn
 /S6WuWWb5yJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAv6AgAKCRDCzCAB/wGP
 wBmKB/4lJcLjJW0z//7l87DZoFSQnUkGM1DBpTGiF647U0XkqoDbOqJ49+vuOFHBVBnpQtn6F+K
 I4UkBG8x6x4TFqWHY7jHgHI80t9kBAvmB9fE17HEu5jgdmydpfe0RAHxNsQP4OW/NNf0rg3DJOb
 +/NpEmjvyUNUQXjp68euE+DXBg159TtrzYwvJyxHZMh4X8HGoh8PRiuzbmflcShlZdS96i9SSL5
 bMiOhQE9+hy1LTX+O8bh0oRdjVzK/Wst21kN/sEW4SwfEZGNrhJyqisqJN0dXjJLg0HFpMRFBA0
 T1VPuE5WvvVTNli/8uj7ck+N48jC754QNaLmK8ELHvPBVBlS
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_DECLARE_BUFFER_WITH_TS() to declare the buffer that gets used
with iio_push_to_buffers_with_ts(). This makes the code a bit easier to
read and understand.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This is an alternative to [1]. Also, this serves as a test to see if we
can get a rule of thumb to decide how much is too much to put on the
stack vs. needing to put the buffer in a static struct. SCA3300_SCAN_MAX
is 7, so this add a bit over 64 bytes to the stack, make the stack now
roughly double what it was before.

[1]: https://lore.kernel.org/linux-iio/20250418-iio-prefer-aligned_s64-timestamp-v1-1-4c6080710516@baylibre.com/
---
 drivers/iio/accel/sca3300.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index 1132bbaba75bcca525fac2f3e19f63546380fd4f..67416a406e2f43e4e417210410904d44c93111d2 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -58,15 +58,6 @@ enum sca3300_scan_indexes {
 	SCA3300_SCAN_MAX
 };
 
-/*
- * Buffer size max case:
- * Three accel channels, two bytes per channel.
- * Temperature channel, two bytes.
- * Three incli channels, two bytes per channel.
- * Timestamp channel, eight bytes.
- */
-#define SCA3300_MAX_BUFFER_SIZE (ALIGN(sizeof(s16) * SCA3300_SCAN_MAX, sizeof(s64)) + sizeof(s64))
-
 #define SCA3300_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
 	.address = reg,							\
@@ -193,9 +184,6 @@ struct sca3300_chip_info {
  * @spi: SPI device structure
  * @lock: Data buffer lock
  * @chip: Sensor chip specific information
- * @buffer: Triggered buffer:
- *          -SCA3300: 4 channel 16-bit data + 64-bit timestamp
- *          -SCL3300: 7 channel 16-bit data + 64-bit timestamp
  * @txbuf: Transmit buffer
  * @rxbuf: Receive buffer
  */
@@ -203,7 +191,6 @@ struct sca3300_data {
 	struct spi_device *spi;
 	struct mutex lock;
 	const struct sca3300_chip_info *chip;
-	u8 buffer[SCA3300_MAX_BUFFER_SIZE] __aligned(sizeof(s64));
 	u8 txbuf[4] __aligned(IIO_DMA_MINALIGN);
 	u8 rxbuf[4];
 };
@@ -492,7 +479,7 @@ static irqreturn_t sca3300_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct sca3300_data *data = iio_priv(indio_dev);
 	int bit, ret, val, i = 0;
-	s16 *channels = (s16 *)data->buffer;
+	IIO_DECLARE_BUFFER_WITH_TS(s16, channels, SCA3300_SCAN_MAX);
 
 	iio_for_each_active_channel(indio_dev, bit) {
 		ret = sca3300_read_reg(data, indio_dev->channels[bit].address, &val);
@@ -505,8 +492,7 @@ static irqreturn_t sca3300_trigger_handler(int irq, void *p)
 		channels[i++] = val;
 	}
 
-	iio_push_to_buffers_with_ts(indio_dev, data->buffer,
-				    sizeof(data->buffer),
+	iio_push_to_buffers_with_ts(indio_dev, channels, sizeof(channels),
 				    iio_get_time_ns(indio_dev));
 out:
 	iio_trigger_notify_done(indio_dev->trig);

-- 
2.43.0


