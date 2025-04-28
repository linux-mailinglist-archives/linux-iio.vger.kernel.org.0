Return-Path: <linux-iio+bounces-18792-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96197A9FA79
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 22:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B8277AF909
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 20:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06ECD202F92;
	Mon, 28 Apr 2025 20:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pHY+MHUf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173031FE468
	for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745871855; cv=none; b=DF8j/+CG0Bvo4PcdN1JjNxOquIvCTtiyIWdAVyihIprEAlNZZKnAxONvk0hw2lIpMnQ8STPG95HEadWP4GqQ3PXWmFDbIsIcazPBeBWH/v17uKpnMFFnzL8xHi6z/QGB8HEBlOyexK9vVTOjVhELMMFpkFVYPK7rc6ENfrZSkMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745871855; c=relaxed/simple;
	bh=Vr9wDkA3SNoSLT9FCnDYkBa0JumGawTzg2ZkCcTYUYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ANS1n5DaZVeS3XieBYYz5fwhS5so1rPyiZzQbioSJ5GQt4uoEslqsQUlURtwiImy6TUmE4jvxB2Ed+DaVShzktTOUa/q5J8eUgxkVzFQ7WYF2xUDz0zO89dNAMs6t6y5AjCjnw1+HWHOU5R0uZbS0kfc2uXlmrrsbwrjXxm+uwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pHY+MHUf; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3fa6c54cdb2so5330826b6e.3
        for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 13:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745871853; x=1746476653; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uIY1UYaU1fvtHky+5YvUDY5xMfkarvlEBEV1oBc96LA=;
        b=pHY+MHUfBzSYKTO26gPodATZe7bgipHpf1Zqr9/KqMR+OeK0xrSz6w/JkvmgDo/c13
         nUkhQVL6mVeUn6bNtooORoAXHfKGyUExb7yPNdKbYJyyO0YIJyLsSH3lkaM1+xnSo2yz
         9LbmzrpRHA9ACsGdf72E47u175+QXBEXl+eqpb4cb3pHKdMUD90jPGIv1Kh0Lib5wLC6
         zd/jIxznqXrnslaVVsNed8W6TCRKH18zLSNkCCCdjxqRgiphz6h5tfw5d46CzcWlB7LW
         DcokTK8H5EjF06n8/oUydwSJe1Qj+F90/eW/bY+cfRctrxAijtGdoZTvOPZF4vk6vOQB
         pbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745871853; x=1746476653;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIY1UYaU1fvtHky+5YvUDY5xMfkarvlEBEV1oBc96LA=;
        b=o3OMIwOv789bBD05IHorU5oLPv4nadF+3m9TUVgtXuR8pze8ELdDelK0uYX/P/ghNk
         u6oohIl71EdD4m0PXd1a2Vj1rV4kyISG7RzHsB9CmJzz6HQxpeHhsHwRJAy++WRpT2kr
         QvrBmpQBhYT36J6Gz9RTruek2TpeB93+7e6NBUHEE2G5VcKxk/cL00vOFvI7wy62gFyB
         +KKqkPhtr4pZ8RqrNDcL5hvg3TTm93qiZSOFLcMyssG1ZNVVhwn4fGcC1AKWPLZYxKNZ
         ue/poF/R58++Wj0hSPCa5+6XwmL4zWxFQTYHj+dNvt/PWn5ylakpKO77VG2jq4VxuKfX
         jmlQ==
X-Gm-Message-State: AOJu0YwGSwwLzZZoib/eAYmUd/swleKfJFYM2I1Av+QHU5lMj+O0twW0
	YjNle1Eo0B8pzkbDjJ4zq1njvV64uYFOHz0KTiOiUhVvnjj1Cc7BvcB7MssuCYk=
X-Gm-Gg: ASbGncv7wlzULcBXJy+cQcOt4OYbIaCBKxZR7MVdJLbRdgyQ/inBq9SN2Vi7ljQqXy+
	Sea3EEBWwgDfuzSbSJzQfOjTu0H8+vZwQLPVrn5fH+0du8FqM4HU3b5lHMftVRuunnPm9lB6UU3
	+bvgWb+vZK1gZcWPJ65Xk5VdVCNuExKeOnQP8+Wc2DyZSy29WjgrcqHKV3F5YPbwnM28PnuRIpA
	qh2LlQ9ym8R6jOU9SQwlUzaVqf1pj5QS/JbAv7nRhwQUY09VT2I0n1FxQRF9D0b1D4Cxiy6G6eI
	f3gst6D7KEWXawib36VwZE5yeKQGAKf0FPAKWPDHUTk7u5J/8d9EzBc/PA==
X-Google-Smtp-Source: AGHT+IFMSSYxN7PK63XVoFOxHQkyZ8JEzuE0uzWukzKAPCdxZRACSzzcrQRpXZPMCEOaZ577NXiY7g==
X-Received: by 2002:a05:6808:6f93:b0:3fe:f4c6:a053 with SMTP id 5614622812f47-402107c0d8cmr718547b6e.4.1745871853106;
        Mon, 28 Apr 2025 13:24:13 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:cff6:9ed0:6e45:1ff9])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401ec970ec5sm2196187b6e.34.2025.04.28.13.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 13:24:12 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 28 Apr 2025 15:23:07 -0500
Subject: [PATCH v4 5/7] iio: adc: ad7380: use
 IIO_DECLARE_DMA_BUFFER_WITH_TS
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-5-6f7f6126f1cb@baylibre.com>
References: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-0-6f7f6126f1cb@baylibre.com>
In-Reply-To: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-0-6f7f6126f1cb@baylibre.com>
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
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoD+PMWNKFP7ZhFMvFOuiJ7rcZBKKOsujRDG4Os
 CIHO4PxOY2JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaA/jzAAKCRDCzCAB/wGP
 wFmoB/9c4ABl1VBly/ge4NLl3iDZmPa8fsd5u8MhDN3q4RgHIjRoWV3Vn2ypZk5O/wO6jSI3Y5g
 8Vi8Y9ASJ7k4FUo+us7y6o/9Nq27euWZ/uOWxbC1iJueH1HgWYcaUBhIrZSq2qMFW+HaB8V8OAM
 g5obAma5H3SKK4Zcx4YyG6xgvM/SzEO1SB1etFTw28vVc+Z8HCa64wdILIhF7rVS6JK+qQY6NgU
 wtEWuN5caQfN5xosKwIGyC8GTMrU0D9siB9mn2YUdGNWBFwj+3ecHDV6invWY8I6A1Q+DVvjzTE
 iV4NSAqtnYANrywdxzgMJkqvADUn8Re2UUV+CkV0yz1nT/hD
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


