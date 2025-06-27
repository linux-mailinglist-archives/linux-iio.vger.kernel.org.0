Return-Path: <linux-iio+bounces-21017-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FE9AEC31F
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 01:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4C51C21CA6
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 23:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5452292B43;
	Fri, 27 Jun 2025 23:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ehz02Agl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CFF290DBB
	for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751067689; cv=none; b=P/G9VExto8ny165qHBixJCbrSk/2MsYmdjdaAly7/bku8erPZvhanr+7gVpMlKQ06xF6uwHf4rGXxfQO+OyzoRLEG7VPbFlj77zuzRvYvDCRv+j6+YYFiQrNkpursd8j/Gx4EKOI2pW9YsSjWMM4CgacSay4W3DgL7lmz0VqB0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751067689; c=relaxed/simple;
	bh=0yYId7CmKo/+nPN29+4m0T9CC1yhegBE9FCPgm6tkyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dDENO8XbYoWJLmaUtyGX7/aVPCQ0i331Tg4ig1hFONX498mRA1RQD7eokdBuywz3KWcM2Ri4bd7jaiKDIfHVvgcqyD1cOu249zn/ZW2Q34VdrXuDUD0LoByvRj6yfVPXIDacZa66Le7Z32x0qjjUlinRzUVpTB5ZjSsGE2uawXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ehz02Agl; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-40abe6f8f08so338270b6e.0
        for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 16:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751067686; x=1751672486; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xaL2xzco1uO7UeMG0BpmNABPZ9hJVHgxxIybCcO0RO8=;
        b=Ehz02AglaaqgD8918b18JM8JM6ttx/innhaR0RLjDSkjhUs2aOh2CKIadCv5/uToQe
         cxfz1nNfY4dCjTAxCfNj5xALpbO5EedD4Z8xqs0/hcM0R5dP3eAn532U4Jz1EqvaannE
         okCMNvfPbOZMQ3asmIJnaZf132RE32OUzmfWNw0x+2llQbweVqYlMvJrs52rLIinBfqj
         VTcDC3is5rx0gVj1qGO+XAIe9pawgeoQ3CAiH1bRXKKOksgL9+y6IJ3uO3yRtWXFBwrR
         BJE6KXySDL0YF1HkGEYz9DQhsKT+357W4WOzsmEcKY2hP02O6C2Yjj0azsY7nPDWrFyX
         Aepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751067686; x=1751672486;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaL2xzco1uO7UeMG0BpmNABPZ9hJVHgxxIybCcO0RO8=;
        b=nCr3HGvynMyy+G4pEDrxLBvLy6Er5AqbRl+wz+uDu+jlwEbRsj8mw189WUnQFVR5+b
         d8iWdRPErutQuj+G2bKu//X7LnyEmuT4fQbJRUO/T5zP9gVAh7icfMyX3A2HjmcdQcZv
         LVe7ua1NnxUjgizNzJs4JF4T1ZrQaj0NQRN1DcUcZ43ek835i/BI7Cpi1MuNhGznTw2w
         2vSfaZQgDbxbwMq0JAFpPLcr3PELEtac9nc6eqvNvVkuig5a64nr8tcfqJD8wQoDckKY
         MeMqbQGtrv5CRilhTswfhntGzqH7DnEZFL0zzR6r6Lrp71szZcCkhEZnZ5vFyQwS24sY
         sBzQ==
X-Gm-Message-State: AOJu0YyKYfRz8lz82CAajLOR3I+iVAMOh4MrZqpRGJh2Cae8YM2WG4N4
	jDL9smj+Az1txVqUmnmECtPxjDG9htddAOM/Ph1mbYzZTVk/zPpELE4KA0heLdDp1GI=
X-Gm-Gg: ASbGncsMBg/eCh7d8EK/hLaBuVNLOHGi7MR/byYv3tpR4Grat7pPfx4Ji9lQ+mo89Nv
	CvOM5GiPi+K/k2AX9OeELaQJNZA0XqjTrgQXvxvwZ2opnS91p2oyU3iCuc7OWCb8B910Owm2KXA
	/5GvOvXYBpN3cv7B1rF+kGjQUMGEn6cUOfBSH8cfOVcu7nXApY5TPIfShEn073jU4Aw5cn7hGmu
	FqwPaPILqClVlsU7FFYiytWvfwjjR/2ENJrEk+MESaIflfmhvUHtwOs+NvI0VqNp/2fCtgbcRjG
	Qte09xnsDcMiqFL3ituY9Gb3vV77nt0g1Q6Q7A5r0GOatlqwOQ0IfToSq5WoeQpq7cM=
X-Google-Smtp-Source: AGHT+IGO6lAxDYiAUSvgyLFtpRPPATaclvQB+pcm3lsuX6smcfmglueV4fyHhGV2aVGGAamMVe90Nw==
X-Received: by 2002:a05:6808:80c9:b0:3f7:d16c:e283 with SMTP id 5614622812f47-40b33c78e69mr4539437b6e.11.1751067686119;
        Fri, 27 Jun 2025 16:41:26 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:1715:453e:e133:7d6])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b322ae4e9sm568483b6e.17.2025.06.27.16.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 16:41:24 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 27 Jun 2025 18:39:57 -0500
Subject: [PATCH v2 01/11] iio: adc: ad_sigma_delta: don't overallocate scan
 buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-1-f49c55599113@baylibre.com>
References: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
In-Reply-To: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=0yYId7CmKo/+nPN29+4m0T9CC1yhegBE9FCPgm6tkyc=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoXyvZJrVOeLE2k6/aVVIHrXp2W07Q3xZQASTEO
 QVFiFjP/faJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaF8r2QAKCRDCzCAB/wGP
 wB/aB/wJwURJXvafTrvrK8ufRZppvAXSjMZBuIT85AEXQRrU0MUsYobunJ5v2lPFVC8SvR8a5Xz
 KlyQBuKbLk5QMcP8Qc4M+TiQhNuCmzWOnzwAvhzOLEVAPr1uxcVYloODK0D01eXYKNfvOHyeudz
 j/VbzqO8gS+tukC9Pyx8g9IeF4JcsdVx9tjv0hUt8pDM7vH19rFaiSeicQgWOEF4KeLRYPLDjwF
 tZ5QGM53wWGpTtDt5r0SEzd8+orrafRaOMCQCZlT1VcXvHkgqZHwRl1k+bHXfN2uY0qS0E+MHCg
 RBoRQuP5eZO8K+8iHYxyZ6z1UcMstYROq0xH6kqND0vznmoE
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix overallocating the size of the scan buffer by converting bits to
bytes. The size is meant to be in bytes, so scanbits needs to be
divided by 8.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 4c5f8d29a559fea7226b84141bcb148fb801f62c..6b3ef7ef403e00804abeb81025ed293b188e492b 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -489,7 +489,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 			return ret;
 	}
 
-	samples_buf_size = ALIGN(slot * indio_dev->channels[0].scan_type.storagebits, 8);
+	samples_buf_size = ALIGN(slot * indio_dev->channels[0].scan_type.storagebits / 8, 8);
 	samples_buf_size += sizeof(int64_t);
 	samples_buf = devm_krealloc(&sigma_delta->spi->dev, sigma_delta->samples_buf,
 				    samples_buf_size, GFP_KERNEL);

-- 
2.43.0


