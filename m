Return-Path: <linux-iio+bounces-6378-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F3690B4BC
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 17:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A42BB274E6
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 14:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858C41CCCD8;
	Mon, 17 Jun 2024 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hmg/2m3m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7791CCCB7
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632243; cv=none; b=OecH9+iAw/R8uDJTPWKsGAwWwBUoGEEUMLh4FIaDD3x7oId3uMofzBewrGVVtwQ1dRoIZXRhOClgs+kufKIF65ab8FHcPNGIF8tEInyQYcvf1aLVBEyoRpgBLBL+fHeqUAOrcv7ge6CcR/hg4j0/zrbYTApy/Mk/J86MYC5/dno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632243; c=relaxed/simple;
	bh=hNgP/6iNEg0nlsLXnblRZQOFGnL8J5KYM7/zOiP/Ot0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=APENY0QFN3N8dYeZun5SB3U+or4TSm/oiaAkLn0BNTfVCoFJokpyV61oRClE1K9hvwlIwv1RQtIBVLIU4o+sZ97kiuWcfl5w3nMffbf4eCkufXxBU+dBGnpr31X37ABzzQrF9XNMvKVd809NqmnoFw5+skFwoPCoUIO2zS9eXK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hmg/2m3m; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-795fb13b256so419738785a.0
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 06:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632241; x=1719237041; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s9IxtXAJpg0zoHi2O9sRGBPOMzr1DfcZ9EisZFYQElQ=;
        b=hmg/2m3mnpz822la2rVyOvA4ybsG6j+0lNYbkiTyDyToRMLAyb2FLZ0UKQz7GyoTeR
         WUA8fIaLVuV5a2gmlrQsgrDWs8cUzWhMitpJqfpCmA0F+MQE3alGZvyXNhviAaiMEj6V
         FKtUoXV0Y9sAXQQM2KcgceeGTHCS0dWLPJDpj9L9N6BPSGJvE7MhX8hNfT+3gYCXzH/2
         ulvb+p8RKQ0e0xr5LIhgWW4usZhsWA2jJXcDjJW6vGR8G5EaodChPZuka8LKWe06Nveb
         0WUGzROzb228+Q5GpLRHZc63N8fx34/5DjH4H6+pJR3pwBS1EpRD0J9MOFmCT0f5101m
         AsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632241; x=1719237041;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9IxtXAJpg0zoHi2O9sRGBPOMzr1DfcZ9EisZFYQElQ=;
        b=Cpm7nzP7YoDjgSQtMdPdyna61zG0Sap4oD4TEtAzW/UfQEaofumMcv57paUcDwMEDw
         XZb2iSXFPvVVOTVDZMloscHhsEKXAKFEWUHOt5uxEXzB3gRgn+qrwOfQ/jCqTdvsS1EO
         iv5fv3X7H0Zk7csFurKERJwcP3sQw7GPboRlGTdNTBizzxBEJdY4RyQMCQTJWGOUfb9m
         zov4Tg/pNFF+XB1EL4aiYUFUxkg2YLO9dM7gM0kVu6oif+R7N3GmKQ8sTTsBDceE/3nz
         PIHfJnNk9iMRKAVKz9/JsbHYuY5j6tvWLGPxmFiBIAakBW4bzXHXwTL9v3qDFRyE9/vE
         xC3g==
X-Gm-Message-State: AOJu0YwaUtZ5PgQzfUTcB+eaKVGdtOXdKWq7mMeycJuYJbhzPGOeNDdu
	Ih5vq3e+T9TtWcf46L+QWD79kL6OQT8W8XOnLQJuc4KI3BFd8vGKQhFcKVH2Ow0=
X-Google-Smtp-Source: AGHT+IEvNWEsHTIz+Kh5SLMDJk99l/NCyLAOM78IKPUk0tI5a9ZCslYv7WlkhqmAtTcQfPh0VS34pA==
X-Received: by 2002:a05:620a:2981:b0:795:5469:1b32 with SMTP id af79cd13be357-798d0242f64mr1752044785a.18.1718632240726;
        Mon, 17 Jun 2024 06:50:40 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:50:40 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:50:06 -0400
Subject: [PATCH v3 26/41] iio: health: max30102: make use of
 regmap_set_bits()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-26-88d1338c4cca@baylibre.com>
References: <20240617-review-v3-0-88d1338c4cca@baylibre.com>
In-Reply-To: <20240617-review-v3-0-88d1338c4cca@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, Chen-Yu Tsai <wens@csie.org>, 
 Hans de Goede <hdegoede@redhat.com>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Saravanan Sekar <sravanhome@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 Crt Mori <cmo@melexis.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.13.0

Instead of using regmap_update_bits() and passing the mask twice, use
regmap_set_bits().

Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/health/max30102.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 6616729af5b7..07a343e35a81 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -448,9 +448,8 @@ static int max30102_get_temp(struct max30102_data *data, int *val, bool en)
 	}
 
 	/* start acquisition */
-	ret = regmap_update_bits(data->regmap, MAX30102_REG_TEMP_CONFIG,
-				 MAX30102_REG_TEMP_CONFIG_TEMP_EN,
-				 MAX30102_REG_TEMP_CONFIG_TEMP_EN);
+	ret = regmap_set_bits(data->regmap, MAX30102_REG_TEMP_CONFIG,
+			      MAX30102_REG_TEMP_CONFIG_TEMP_EN);
 	if (ret)
 		goto out;
 

-- 
2.45.2


