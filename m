Return-Path: <linux-iio+bounces-19124-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D47E0AA9921
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 18:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751A9189EC47
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 16:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF2426B2DF;
	Mon,  5 May 2025 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="H89KeW32"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD6226989B
	for <linux-iio@vger.kernel.org>; Mon,  5 May 2025 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462768; cv=none; b=G8cdkw9m03TA9e6wY0elGovWweaI5tap/cW/Wx+ycaBXlBy8Nsc/Nn3zilcuCqXKsenYf1PIoTNvLBSGgbx6WXTXsqzqYeYJ5P7s1IRQz07v1OpR+uuCedo6h7CAKYdo2EGZfuScss13xmIr/3wEDbAt92fsCaoYPsdW8haMuUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462768; c=relaxed/simple;
	bh=Bss/MM4pMUG+funKZXn/aR/hWEcoDzCMv41P7cSelc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mcyh9IkUt23ftBQRPBn66d14KRrmU4r3eVHvQGhXLz4T4TBvVyuIkWM7fk8mfQQBVdeeEOTCd91Le344FXcnxbvPAXeevpm4G8MxZrvyE08Ou/XPwjDFlKmhTz5OYxu2HscTPgXbbaAl/jjQom48oMcVeR3Jwpo5/6u1N480KE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=H89KeW32; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-40356cb3352so1451578b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 05 May 2025 09:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746462765; x=1747067565; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7IPN5zjvUiujE84L8mSRQW14VNC1zQsKq5wxQYikpNA=;
        b=H89KeW32J1qnUSkjhYSI/XAKbYwGBTd+SoyXLHkXq9ftno8563eqh/qVpWZmOH1oJy
         7oNrqzHuTodQ7G0VGjtCVIaudUOVUQPhEPct9KDpVxyV5JAYzI9eHX/QU84mGuR8Lqu3
         pzTCbzMFm3tRg6aBx5qTYRloYfZVu9QtIniMy9DFiROWpy4njvYEorO0Ctpgb+BOgwi6
         vu1dTOlzBhLwDbX5Wk5xUhPBmtihPhjmFeBUDj9RTS0tFwQzZx0qbeVGsMGA46Mqk23s
         hCDJVdOXULZtnul1VONcPWyoaqGYUoZjbz53TsK0l6N/sABMdsONlpP038clononqvI6
         wX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746462765; x=1747067565;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IPN5zjvUiujE84L8mSRQW14VNC1zQsKq5wxQYikpNA=;
        b=mP61dcq3yeCx/9Jowcvj5DYiKbIPjJf0icRM6LNpdjxSwl4pIzRjBiViY7trJ5H1Yv
         QfwYHpeHQfHq40LL5OqLowmdsiASyvFZ+7ZO108Spf+GCLSqa1uUgNZ4BTD0pPY7Op+A
         v97vksxsT7CsmMwz343ehqv4pIU7BVhVOITW67PI9NQOBarevUvGSzsOVtY0aq9z/J+c
         EtSlVpVivhSF2Zz4bk2rpXOMRnfWWBDpGRlja3cdoefyNSTyLF8hVKWIZiZy5KT5bfit
         iIIKjsOhskFAMEDW+eU6ieeDx8tneYG8zvf52gMaQMX+CuJk+5On+M93ou4w66fzjD4Y
         IYyQ==
X-Gm-Message-State: AOJu0Yyo7emxqvy700eW67sJIvuvyp3X7otsW1RpmThxf5KmhgdMQBJO
	6TIFgocii/OwrjG2x36vOQLtuP6P/ccL8/odwwTlTq08kAMF2l/Z+eIQhtxKt5A=
X-Gm-Gg: ASbGnctXwxJ3cEuahg5T5+TdyIhAWczgMBBmZVk3M96OR9MGzFHtEY1wS0+CL4NXfgS
	y24KCK874ixNCGD8fAWisZW0+VazcviQRWYnxaTcVfWDAIsXSKKmFekDWco8QGCNkKx+2IwmmPd
	1orVvd1TifYp/j4gbESAp6yMwU/GHGd8f58mtABclrXESoBzX5SF7+AOI2s2HYAccgw2vPHEc9s
	WyeMXak6qdX65SHx0ZYU+cdc52VrglQplapSRV6BnHVZhRXgACYK5iiq0RSXTXVKvcPPOhpxXTe
	OWL7xjdQ3M50YgKZcqqPcAwdevVQdVDbYSrkTPurm9Vocw==
X-Google-Smtp-Source: AGHT+IEFUEDmgHRmBqQ8B5zxNYM6/HsizxzM2vpvn/QoFOlX3G5WG8djuuoSv4JBpEGGSMZ04czZcg==
X-Received: by 2002:a05:6808:22a9:b0:3f6:a851:fe85 with SMTP id 5614622812f47-4036883782fmr91899b6e.14.1746462765301;
        Mon, 05 May 2025 09:32:45 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:2151:6806:9b7:545d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4033dae68f7sm1971854b6e.26.2025.05.05.09.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 09:32:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 May 2025 11:31:44 -0500
Subject: [PATCH v5 3/7] iio: adc: ad4695: use
 IIO_DECLARE_DMA_BUFFER_WITH_TS
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-iio-introduce-iio_declare_buffer_with_ts-v5-3-814b72b1cae3@baylibre.com>
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
 linux-arm-kernel@lists.infradead.org, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Bss/MM4pMUG+funKZXn/aR/hWEcoDzCMv41P7cSelc4=;
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGDIkXrBxrO9yZ/pqWRHQ8+feW2/xBhe5u73nF/cwMRSpf
 s7OfLe/k9GYhYGRi0FWTJHljcTNeUl8zdfm3MiYATOIlQlkCgMXpwBMZNZr9v+5ruc312X+li+y
 53IzV7yYuM599YuoKcu2/XI0yuUq855i+PprWPxfrkph/lY92SlPy40auDZ0cdj2Rif6fKvL37t
 Yi229QKSzaMUktTWPJNg+bn9du1W6W7CDteO5kkXVT/fS+nVKFdfdp15XXThbpn1Hho/rDrPXve
 sEveMcTuxR0OuQ+JA881pgRk/Mq2vWW+z+G0gVu2QlXdVbZcXAslFh5TPVlbmsH4RTkp4I2wewH
 DYKcFatVTihbLL3bcsfHTeDWQ+qzJ496rg+57DRLIOHSZVK/kpPvKv5eBjYF25+oPPBzCRqw7z/
 +i6Ou85q5rq/S7X9eutV7tK/md5Pd57uzTGInHFD/mojAA==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_DECLARE_DMA_BUFFER_WITH_TS() to declare the buffer that gets
used with iio_push_to_buffers_with_ts(). This makes the code a bit
easier to read and understand.

Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad4695.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 0c633d43e480d5404074e9fa35f1d330b448f0a2..992abf6c63b51dee222caf624e172455fb9b9900 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -160,8 +160,7 @@ struct ad4695_state {
 	struct spi_transfer buf_read_xfer[AD4695_MAX_CHANNELS * 2 + 3];
 	struct spi_message buf_read_msg;
 	/* Raw conversion data received. */
-	u16 buf[ALIGN((AD4695_MAX_CHANNELS + 1) * sizeof(u16),
-		      sizeof(s64)) + sizeof(s64)] __aligned(IIO_DMA_MINALIGN);
+	IIO_DECLARE_DMA_BUFFER_WITH_TS(u16, buf, AD4695_MAX_CHANNELS + 1);
 	u16 raw_data;
 	/* Commands to send for single conversion. */
 	u16 cnv_cmd;

-- 
2.43.0


