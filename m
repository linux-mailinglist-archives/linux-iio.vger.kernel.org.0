Return-Path: <linux-iio+bounces-18667-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6636DA9D3EB
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 23:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB7B1BA561B
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 21:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0511122687B;
	Fri, 25 Apr 2025 21:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Dr7Y/nJR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096C7224AFB
	for <linux-iio@vger.kernel.org>; Fri, 25 Apr 2025 21:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745615384; cv=none; b=Q8k4WZGoaL+ZV4W50PRns5I/pL6x5+DKtFdG9cEULlIfN2Jz525qukgzQ8O3Af1zpcFau0tG1fHUfJbW6b2IEOKjN9UawKr0gvEYg/RymWu9fxGxmVy1cjS0v9Qeev9oHytnpd6+AsleD7QAbydNf1pMulDyJ/XFoIfDMtsSQs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745615384; c=relaxed/simple;
	bh=Vr9wDkA3SNoSLT9FCnDYkBa0JumGawTzg2ZkCcTYUYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XkoNZJnf3AUPzvwNDbHJR3LMcnTFHlaL0TB/bdsUtmFk/ajZ+p5RdHCgpy/kM2WsGQSvDibNVWdam20NF785nwVhMby1n3xZrm5+xpSoyqxG22BT/gqf1u9SGKDlRkV80pQcSCsQ2n+qafbJ6Ne5x9H2m/Pn64OZs8SYMNmf/v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Dr7Y/nJR; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72c3b863b8eso2147734a34.2
        for <linux-iio@vger.kernel.org>; Fri, 25 Apr 2025 14:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745615382; x=1746220182; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uIY1UYaU1fvtHky+5YvUDY5xMfkarvlEBEV1oBc96LA=;
        b=Dr7Y/nJR8i1ldlUICIw+SVcx7th21GceAbUditOvLJHtiz/twT0F4myhZM4uyOgtbB
         IoEDrIu4chAhNSV1dGNz/4etW4mnxbMC2fMvSLn8zdHmwi0YuY9KQ0V+frPs9yoK4QmH
         xRRTirwdAr+n6tOnE8Xmr3jsP2bKOCDV5hIwAFdMkyYhg3xNDP85htorh+qSo4AgJcu5
         urEL8dtS/F9XVQG8p6zPeTPViVinjigNqi2SpfqLf/DMV46rZj/EUv4pumOPt2YU5Btj
         SPIdI7qzn02+Negxbc5aFJcu6RJ6/D7yjgrMq3Tz+x+yX6Roun/n9tlVNQ2OsBs8L/nK
         /7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745615382; x=1746220182;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIY1UYaU1fvtHky+5YvUDY5xMfkarvlEBEV1oBc96LA=;
        b=BvZa8jb+hLz0s54F0/CeEoF7c1fSOihUyQjQwrG1iuGO5qD5xmzdz2kp8/newsly8o
         TTehPGIf2qzSZyW3G1k5ObLXW1GWAb39c+55quSfzOvM32y5PBbBwFfFhKbfkM3LhqjY
         L9UqNRD/p0nZr7WL+1+Ih+1g1lgkJJpIrwlgd5rfXFspZedj1HVxCRzBoeDT0aagb00x
         6Mlcse2e18PjQzx/B/fpc1idgYwcqrjFqnfn5aa4BzhyC0Gy3vKSA01NvnG2EoGpPrpc
         C4JAyR5IoWk9m0Dktea6S86yDSS1LzXtqp28ds+uM7yM6P9phx0wDoqX1sF7XfAN1Dzz
         IA5g==
X-Gm-Message-State: AOJu0YwjzjqPbDtzTLh43bhAJlgpOzU82wKaKo/iHuhrRqyra1FkgqLV
	U7IXOOnaxtwSMjCkWh+09+ccfgsxR3bW+d5tZsyglD7pD1zPqo0SAMPmMhHANyc=
X-Gm-Gg: ASbGncu1P82h4fCca2r268vDz7poz02z5CyMupDnCl7Y+NxAr9zYDm9vuS/1qI0T2QN
	VCXIYqKMTQsQpQ30SiA+8vasqfy5MVwvZmcaDbBtgzBetPWrY4fkpQ6pnRv2/EAMCOIw6bO6f+N
	QzRXjxhUgdLAxYllLtDoViiwfFG3djGr4wH/8fL6MrCgB/9gUjH4E0yTjVJ2SW9Vc7+cy5zRUNg
	P1bSkB6JlI9H21Rf2a6MV34BdHaKUeyjCuvXKfCTFsq7K1g6w0BytPzOcpfDm6Z3r+7a1hr4Sre
	ELtpXhjS4wsiMpYQlXChP4f0Lbvk4QbthKzmjsNWbtbw
X-Google-Smtp-Source: AGHT+IFwss8X+LYquqRQKkNZMlIU9cSEM6k0mCA5Laa6xLd+BG1valjceigoU4pMW6TLwZRzhyDhZA==
X-Received: by 2002:a05:6830:3903:b0:72b:7d52:85b with SMTP id 46e09a7af769-7305c8c5f3bmr2177788a34.16.1745615381827;
        Fri, 25 Apr 2025 14:09:41 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:96a3:e28:3f6:dbac])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f188052sm847673a34.8.2025.04.25.14.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 14:09:41 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 25 Apr 2025 16:08:46 -0500
Subject: [PATCH v3 4/6] iio: adc: ad7380: use
 IIO_DECLARE_DMA_BUFFER_WITH_TS
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-iio-introduce-iio_declare_buffer_with_ts-v3-4-f12df1bff248@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Vr9wDkA3SNoSLT9FCnDYkBa0JumGawTzg2ZkCcTYUYM=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoC/n7nD6/HmRUEekDdufnRBs06xB+EFaZcg9cW
 13ajpadrTqJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAv5+wAKCRDCzCAB/wGP
 wGnMCAChmYyO/9wpFZGWSnd3q7aKAUh84O17VLdiX8nlnneXQRtE/XeKj3zCS3AC46VHYMEJIUG
 fmoVgWPPhlUvxtkOVVkjmYcNQlDXlumos56vpQ+W5cO/6ZwpuMeIlvTWa+02VyjECcwByliHBVk
 tzTCme1/iQJyUbYMafDFiMw+2xlofm37ALqOL8P4E7Ri5fHnYLcWkZ7+FMJZ+vdWwxl5udW9JVh
 py3CvafsBETqRBUyG8V/olwIXDZpyPcqV4MjVjqPNbnEygm8/gmk421rwh353l1oBd5YNo1svyL
 2OQF/zEycb4m9UL/L5UPiJWX85ICOf3+5MWsIgOvgDI2c7mC
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_DECLARE_DMA_BUFFER_WITH_TS() to declare the buffer that gets
used with iio_push_to_buffers_with_ts(). This makes the code a bit
easier to read and understand.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

As discussed in v1, this one stays u8 because it is used with both 16
and 32-bit word sizes.

v3 changes:
* Use IIO_DECLARE_DMA_BUFFER_WITH_TS() and drop __align()

v2 changes:
* None (but I messed up and there was supposed to be a change).
---
 drivers/iio/adc/ad7380.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index f93e6c67766aa89b18c1a7dec02ae8912f65261c..ed5e43c8c84cfcc9c4ce1866659a05787c1d6f5e 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -909,8 +909,7 @@ struct ad7380_state {
 	 * Make the buffer large enough for MAX_NUM_CHANNELS 32-bit samples and
 	 * one 64-bit aligned 64-bit timestamp.
 	 */
-	u8 scan_data[ALIGN(MAX_NUM_CHANNELS * sizeof(u32), sizeof(s64))
-			   + sizeof(s64)] __aligned(IIO_DMA_MINALIGN);
+	IIO_DECLARE_DMA_BUFFER_WITH_TS(u8, scan_data, MAX_NUM_CHANNELS * sizeof(u32));
 	/* buffers for reading/writing registers */
 	u16 tx;
 	u16 rx;

-- 
2.43.0


