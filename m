Return-Path: <linux-iio+bounces-3784-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE8988B041
	for <lists+linux-iio@lfdr.de>; Mon, 25 Mar 2024 20:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26FC1FA3851
	for <lists+linux-iio@lfdr.de>; Mon, 25 Mar 2024 19:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ECD1CA9C;
	Mon, 25 Mar 2024 19:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ffR0YzS1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D47B1C68A
	for <linux-iio@vger.kernel.org>; Mon, 25 Mar 2024 19:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395644; cv=none; b=Ud373Atkrl6zT9D8mIwSyVTVYgvS9POlqmc4IoTBmQw4IH4P3uvMNCTmD8/H6pmNjXLsiJGZJ7UNOxPyVroEqBaLmqwNnavzZx+QzORy4+2A21TJTNcMrh7+AJtCxOWq2DyRPi0lI2SwOEiD3cYUkgfQozqT/YIhKl3rp/mDu14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395644; c=relaxed/simple;
	bh=6zCujOYaTCPgwFb4TRVnXKAm1KvhcyIh/4UUj9uy3D4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jAEjEzTDWni9P+yVaFdnQZedwG2fxmNgPpsNjMiI3s6H8nOWrB5oBjkNShqGEdwEsbxeicIgCUInbQZqQLAxU9I5fQiz91LNu7NXiWNAKzUuYrtTGhHgWIPO6EIVpO5X4nFgNLH8IcQMIstpDu6DbTuMwhNBAULrAw+V81zE9QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ffR0YzS1; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a49261093cso2359979eaf.3
        for <linux-iio@vger.kernel.org>; Mon, 25 Mar 2024 12:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711395640; x=1712000440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cu4UkxchV2M53KPLFlI+CnD5WRrZCvujRJAKi+5DJjo=;
        b=ffR0YzS1uosNzzpBcwXyiaIDDNdN5tL4pf3uzGyl1CZ0v9GjtVO6ogBcktRqwyopID
         aNtUENOXQj+1UBsVfpRcMIx0G3cKU88GtcHHqQjjxuksUcFz0IT87ITgOvEo5TXMktcf
         /IYJYXLPb/lt8ZoU47RSGwppitfmHDouBF03zHJGcAIOUoXm7oWdXFPtDmSyb1k77wzp
         GvXUqZFJwjHOYUMTn4KCHAPRI7rvfisu320f2eef1hsHL0cjrSVf8UtcKEgvGtIyoBXk
         2z78sokDpfaRn6D2sgJwIc6Kyn6nsQXfhH97CHcQ/xgVQyjKdG19ULzJZwGAuYKmicBL
         DqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711395640; x=1712000440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cu4UkxchV2M53KPLFlI+CnD5WRrZCvujRJAKi+5DJjo=;
        b=gnKMfxnrKrHx+2GW/rzxWZe+cj+ZcJvjuN0P9fbDCcg/2O6aVaLPtUzwSaCT9OE8Zp
         StxDoV0b6P36ZX0mFOislqvhWGihjF/+vYToYwdLdb6vDoeA2b32kG/2dKqlgOuakYkS
         npTZmCkt7Brxivhnb9hJbN8RiZUy+QaDw4Xyg2AbX9TTwz0tj3rMo7MqeMBuJPljyPGI
         nBLUSeJMXkNF10Q8aRnywkU1VQxmSQeN7DL0YgOxZ6tlHXR/LL03mMs6F2sj3omyTXjN
         yCKMn2F4gjbQ+dZ1xKOoFZomGRdO/LfRVylabGB39KSmAihIPjxRgT1HTdlHtU8QWANz
         fTeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD1XqhDGYTx+obFVeH3PjnfHd6pTg176axmbzyKsx71Ix0fA4/BiJEXHqE2RpIY8i+AQpeXPw35K1Ee46FnDzR8un7Zzb4c0hY
X-Gm-Message-State: AOJu0YztYamTFUadYbN0Ob4Oj/ob+eTaFLXZ+29puKt3d8s6JBlJt8F2
	01wSf6wDWwMAETdiGScsMY6mbBxxaa3e5xAxwSDJZxdLlV2DaA1iFd2CO9uli/s=
X-Google-Smtp-Source: AGHT+IGw7NPFevROk+cVlQFzRhkKFe8w6rJLeHSWp9/RPJSgWlvH8NmK4IghYVHNVG1/nnOuFvYSVw==
X-Received: by 2002:a05:6870:6125:b0:222:3792:d968 with SMTP id s37-20020a056870612500b002223792d968mr8679490oae.4.1711395640637;
        Mon, 25 Mar 2024 12:40:40 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id bx22-20020a056830601600b006e6d4cffa31sm617068otb.51.2024.03.25.12.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:40:40 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3] iio: adc: ad7944: simplify adi,spi-mode property parsing
Date: Mon, 25 Mar 2024 14:40:36 -0500
Message-ID: <20240325-ad7944-cleanups-v3-1-3a19120cdd06@baylibre.com>
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

This simplifies the adi,spi-mode property parsing by using
device_property_match_property_string() instead of two separate
functions. Also, the error return value is now more informative
in cases where there was a problem parsing the property.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v3:
- Fix "a problem" in commit message.
- Remove nested if to save a few lines.
- Link to v2: https://lore.kernel.org/r/20240319-ad7944-cleanups-v2-1-50e77269351b@baylibre.com

Changes in v2:
- Reorder error path to avoid else statement
- Link to v1: https://lore.kernel.org/r/20240318-ad7944-cleanups-v1-1-0cbb0349a14f@baylibre.com
---
 drivers/iio/adc/ad7944.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index d5ec6b5a41c7..9aa3e98cd75c 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -366,7 +366,6 @@ static int ad7944_probe(struct spi_device *spi)
 	struct ad7944_adc *adc;
 	bool have_refin = false;
 	struct regulator *ref;
-	const char *str_val;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
@@ -382,17 +381,17 @@ static int ad7944_probe(struct spi_device *spi)
 
 	adc->timing_spec = chip_info->timing_spec;
 
-	if (device_property_read_string(dev, "adi,spi-mode", &str_val) == 0) {
-		ret = sysfs_match_string(ad7944_spi_modes, str_val);
-		if (ret < 0)
-			return dev_err_probe(dev, -EINVAL,
-					     "unsupported adi,spi-mode\n");
-
-		adc->spi_mode = ret;
-	} else {
-		/* absence of adi,spi-mode property means default mode */
+	ret = device_property_match_property_string(dev, "adi,spi-mode",
+						    ad7944_spi_modes,
+						    ARRAY_SIZE(ad7944_spi_modes));
+	/* absence of adi,spi-mode property means default mode */
+	if (ret == -EINVAL)
 		adc->spi_mode = AD7944_SPI_MODE_DEFAULT;
-	}
+	else if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "getting adi,spi-mode property failed\n");
+	else
+		adc->spi_mode = ret;
 
 	if (adc->spi_mode == AD7944_SPI_MODE_CHAIN)
 		return dev_err_probe(dev, -EINVAL,

---
base-commit: 1446d8ef48196409f811c25071b2cc510a49fc60
change-id: 20240318-ad7944-cleanups-9f95a7c598b6

