Return-Path: <linux-iio+bounces-19128-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1224BAA9927
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 18:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16BF01B61DC4
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 16:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C056A26D4E8;
	Mon,  5 May 2025 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BWq9WfPJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF1E26C38B
	for <linux-iio@vger.kernel.org>; Mon,  5 May 2025 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462771; cv=none; b=G2AEAGBOD4MbyuiD2QejvRnXBVKVG1yGKK4NpTp7IJeRUylj1EjL+o5EllnjpW64ynBWhW/9uor5qCF3OUC/6HeFi8aVQMzoQ2GY3XeKRAPlE41l6Oj92kCRFmiSqyRLLTWKdT7uunvEYMZkXo2+w3KloKs8Ta8wFYOem8GebCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462771; c=relaxed/simple;
	bh=eFnLQvdsVmKraQh8aq+xo4eSFo2W/BSjPzBiG7P/W9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=riBvUp12CIiPyvU6VWMdPRXeOJetiTruFYKVluUjv1G9+EgpdUdkpvolOH+aQw0tjv7qYF7wg1aZgJ3BDDaZFvNkEVcqdG57cOgKDkKgZPmDLgu9pPBSvE37on6i+HPXHUI4G26ckgeArGOAL6q3cCcDmh16MJkmtfI5OEZ4ftE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BWq9WfPJ; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3f7f7b70aebso3371972b6e.2
        for <linux-iio@vger.kernel.org>; Mon, 05 May 2025 09:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746462768; x=1747067568; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NoTdUTbEoyHl0+vrXiyaUVCxUuEGKzeZRmULGNvEl7M=;
        b=BWq9WfPJVDrGRKTFgS6SvbjdZVaKZTMykdzdeqCq06NPAF0o90PPfmOvOjfgesDhQu
         YtwIwpOHENxxTdmW3aJhWEzjrzCNxWN44Q1l1HNouWyipYZdVaR26ef+9oEDktoNEuN6
         Cu2BT6yUHY0omY5jpkkh3863Og6R6JMfA5AtBb96YoS2PvBkpSKrvehasLkLDigR97BN
         X8QBQix5z/f7uvWeS7jSxbKMCgNe3MnMJdfk2YcJnl5lodjxXZ5opBbU71GD0Qt230g4
         +qyFIhyuSuQUA0fyNckRZAN3GFHPYZtkKcVCXYjNm6Az9BXLcdBlwNKbF7NhloGGjhVU
         fwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746462768; x=1747067568;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoTdUTbEoyHl0+vrXiyaUVCxUuEGKzeZRmULGNvEl7M=;
        b=XBMpBITHm8NdnNg9UKLGPAxwfy6Fwrl5X7tVrVjdmdG73SKKXJrI4dUPj7V0Uqj3N8
         BPGvAlVbl4EFze9jEziJTz22fpSrE/tR2tk0UcKQhhZ8YtLsj58iOhkrCsdhB7OssYSU
         aPwcF+55FfLWTx+6Wmijyx1rvZsi0TWiUQHhbME8aHWdRk7lPFoNqtE2XzL8YOVnNlT0
         H6nXFK5ExMA6Fr6WzjqXcw5mF7hMu96ZnqvT/WAi2RD2qOGx1y/lkzBWcf4MKatZ6c2V
         jOvf5rexo+OFULtHJ4QnZtFgKR3fYEilecYhMK5ce6lIZjGh1qv1iRuVqry19Xyb1I8j
         1IUA==
X-Gm-Message-State: AOJu0YxtM3xA48CoADPlQLFSYXFuNzvaxfqNSxyj4Dn6n4lGX20FCfLc
	yjBdInKicv0f5lVOSKd6KES4FK9ZAfhvZVurBJn7CLjNp1NVi1MwClgk8Z1grdo=
X-Gm-Gg: ASbGncu6FjvblOwPxe31f3tzTgDv+usiLeLqz2IH0uPU6aAfQcakUwSrwRmaDjulG7J
	0CpEArZddvCY67qbExCHbEPDfTpiv+InLtWU4qTOoaM8oX6+PZGIjb98hXfKq7oR85dRp4NLI7G
	P7/UQ9oY3sPnhTpaXozUyd9F7DmxSYADPbRYrxZ86Olj6hm5GT/uYNMdBPhxX4JkqA3mvMqFTZF
	lFJoJiozzBjxjT1ozOPtd13cnlr/tsVFw6mU4vpdjYtqK8tmJqorGe0mgao3CJrDQhesB3qnov0
	yqHRfsxKpabD+OFtcAX+AEN1hOwz8puhF/OS2Kx/vhOIHA==
X-Google-Smtp-Source: AGHT+IHi1BqJMwn2+ePu/bE4tm+OAhNfcyLxdr7TQkYJqCf+3YKLVqRO9ann0RXlkmT0oNmwsKWWAg==
X-Received: by 2002:a05:6808:444c:b0:3fe:aecb:5c49 with SMTP id 5614622812f47-4035a584bcfmr6037754b6e.21.1746462768685;
        Mon, 05 May 2025 09:32:48 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:2151:6806:9b7:545d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4033dae68f7sm1971854b6e.26.2025.05.05.09.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 09:32:48 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 May 2025 11:31:48 -0500
Subject: [PATCH v5 7/7] iio: adc: at91-sama5d2: use
 IIO_DECLARE_BUFFER_WITH_TS
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-iio-introduce-iio_declare_buffer_with_ts-v5-7-814b72b1cae3@baylibre.com>
References: <20250505-iio-introduce-iio_declare_buffer_with_ts-v5-0-814b72b1cae3@baylibre.com>
In-Reply-To: <20250505-iio-introduce-iio_declare_buffer_with_ts-v5-0-814b72b1cae3@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1736; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=eFnLQvdsVmKraQh8aq+xo4eSFo2W/BSjPzBiG7P/W9k=;
 b=owEBbAGT/pANAwAKAcLMIAH/AY/AAcsmYgBoGOghEdJgEI8ojT+f7QjlFDY6MQvZNWiXIAZEE
 nX4deedFwCJATIEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaBjoIQAKCRDCzCAB/wGP
 wHgbB/ioLShqxO7D+Edwq5N6S/xksypDEeWYWgeqd58uDkS3sWFGok58Ummx8bHd+QSXm4fmNLt
 7RczIGWSscvNnlTnqXVve8vv0hxKCkoT0oskVJ2J9/6WdrjU69XMJRbOSZn2YcgGTgOQwaWHmHo
 f4Xq9kbDYbkW+QWFtIJ40Ox7fqCK2Mv73rsCrsQeyc0riR7qbsCL2LO/PrZCzRxv08PNHrXvMY4
 gflzTcE8HvZsw9KILWQRiL8HL1U+5ztA97fs7ofw6HmkxalS0rny0fPxaf+e+/j12vO/JaW7ka1
 ROOR8pSMG+DyiD1+fL4zz5CkIQTdQqo6LpT/eXDllIwFABk=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_DECLARE_BUFFER_WITH_TS() to declare the buffer that gets used
with iio_push_to_buffers_with_ts(). This makes the code a bit easier to
read and understand.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v5 changes:
* Fixed missing space at end of comment.

This is an alternative to [1].

[1]: https://lore.kernel.org/linux-iio/20250418-iio-prefer-aligned_s64-timestamp-v1-2-4c6080710516@baylibre.com/
---
 drivers/iio/adc/at91-sama5d2_adc.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 414610afcb2c4128a63cf76767803c32cb01ac5e..c3450246730e08cdacc975ed19f46044dc76848f 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -586,15 +586,6 @@ struct at91_adc_temp {
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
@@ -616,8 +607,8 @@ struct at91_adc_state {
 	struct at91_adc_temp		temp_st;
 	struct iio_dev			*indio_dev;
 	struct device			*dev;
-	/* Ensure naturally aligned timestamp */
-	u16				buffer[AT91_BUFFER_MAX_HWORDS] __aligned(8);
+	/* We assume 32 channels for now, has to be increased if needed. */
+	IIO_DECLARE_BUFFER_WITH_TS(u16, buffer, 32);
 	/*
 	 * lock to prevent concurrent 'single conversion' requests through
 	 * sysfs.

-- 
2.43.0


