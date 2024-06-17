Return-Path: <linux-iio+bounces-6380-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6348290B281
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 16:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F72285869
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 14:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830F91CD5D2;
	Mon, 17 Jun 2024 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GhRMTbMD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C886F1CD5B5
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632247; cv=none; b=FkL4lL5rfr7oV90YYGc9YALSo70tzu4ny/KLbx/pFVW1KvdIzZKYMOJ/1QsCQrtR/yOk64nlnqAj34Fso0m3pwArl1g69SVRVQWuLSapvg+vs0MTJilhPYnWuh7ndKMSqwEd35UpF3FepRKnO5A1xhhtw11sy5jeJqmsRYR9Myo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632247; c=relaxed/simple;
	bh=1krSrNHMvqxkLSx9XrKqBiSQEiLu8ivJ1Vl5F9eXcBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O9DP/rbqbAx7pHknB7BE6SSQ17R5yDvvImctl/u/ZX5yLEtLZGHKB3K7Dl3jWU/9Y9uWAhMnJYIF8xoZdqcU8ePXiw/6MCotzf7xke2M3qfRl+TgclLsyEgdxMDOPWB66eq7fXIGlooDsG01pEB5zB+mo6V14wVRBrCXLP67tEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GhRMTbMD; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-25545664f37so2394025fac.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 06:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632245; x=1719237045; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=no5e4JgYnxUL9VEAR0MyhLfYZ2Dji3NZkE6FFtqTn2Y=;
        b=GhRMTbMDAj3CwE078Hb5oAwGmKnZXOmh9PKZsFONAQAZyKGFxh9yXflGbycQTAf3mV
         Bqe6mzaUKwIZ21ZyalBET8kunE1TdaNjPYbzcIsDG7c4LMBNRJPyqop+lXVvqahYYVfV
         ZJ7ecWzUuAIwSAjgEnRHRtadKdLH9JaVygSRfwPsfR146ePBN9+FARN+FGmHDVv4xdb+
         vGfNBboqC5w0+EXrVqGWy9KcNgD+EzUn/w6toUgMjlFyTB6oStss/jJr6yeeB6PfGva1
         GJowoAAs4RMO3Q8G/3bkOd5YqoUoK1ymOCt4oVPGHxIdzUB5RbgJrta3900LSnotG26m
         Ek/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632245; x=1719237045;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=no5e4JgYnxUL9VEAR0MyhLfYZ2Dji3NZkE6FFtqTn2Y=;
        b=Fxhu+hqMMiF04WnOPWhIsq6WaX8SCtdh+f0wUbRXenPhtVby8zdBNndnp4JsFfMSBq
         tKCeLD/29+7BpXiy9CtzSMHUroIjWPAZvAOOOyeINEs/XpZSWEoGF+n4xImr5NOmQhKZ
         1w8J2O3RrDKNM0ypfISsPszb/cfPQ3hBE6fYBWWlXbU3Wa1h9K/TX4BvjIqy3x4HKCLM
         IOx5ToJV6xf16M7iB5aikXEz0f8UTinUtdN+O6VJP9iG7K/7IpyA1zZ1BrtW53KR7I23
         qbH7fo6+nil/6okmAVdKmSkO8P6uugmIQAv46o0LVS+XsgEQaSe0YxG1yCqw3NoOgkRP
         eujQ==
X-Gm-Message-State: AOJu0YxPWBvLKkd+jAh8CzRdQh80Eb4PU3cMAmy5uuHSyLMTszuof/ih
	qJi+IjnlG2NoByJzLrnOUKxv9mhsUNz7YBbFMnfSswbmxb847YjrR+9uB6RaKNc=
X-Google-Smtp-Source: AGHT+IGU9b+YnJX5hCRw1ClyleRAxjZc2rSg4p660bR5sIf4JFOEx4FbnA14YINHS71KeMJAZo8MSg==
X-Received: by 2002:a05:6870:472c:b0:24f:c95b:ab6 with SMTP id 586e51a60fabf-2584288ca57mr11986485fac.8.1718632244964;
        Mon, 17 Jun 2024 06:50:44 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:50:44 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:50:08 -0400
Subject: [PATCH v3 28/41] iio: light: adux1020: make use of
 regmap_clear_bits(), regmap_set_bits()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-28-88d1338c4cca@baylibre.com>
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

Instead of using regmap_update_bits() and passing val = 0, use
regmap_clear_bits().

Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/light/adux1020.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
index aa4a6c78f0aa..34230e699d27 100644
--- a/drivers/iio/light/adux1020.c
+++ b/drivers/iio/light/adux1020.c
@@ -539,9 +539,8 @@ static int adux1020_write_event_config(struct iio_dev *indio_dev,
 		 * Trigger proximity interrupt when the intensity is above
 		 * or below threshold
 		 */
-		ret = regmap_update_bits(data->regmap, ADUX1020_REG_PROX_TYPE,
-					 ADUX1020_PROX_TYPE,
-					 ADUX1020_PROX_TYPE);
+		ret = regmap_set_bits(data->regmap, ADUX1020_REG_PROX_TYPE,
+				      ADUX1020_PROX_TYPE);
 		if (ret < 0)
 			goto fail;
 
@@ -748,8 +747,8 @@ static int adux1020_chip_init(struct adux1020_data *data)
 
 	dev_dbg(&client->dev, "Detected ADUX1020 with chip id: 0x%04x\n", val);
 
-	ret = regmap_update_bits(data->regmap, ADUX1020_REG_SW_RESET,
-				 ADUX1020_SW_RESET, ADUX1020_SW_RESET);
+	ret = regmap_set_bits(data->regmap, ADUX1020_REG_SW_RESET,
+			      ADUX1020_SW_RESET);
 	if (ret < 0)
 		return ret;
 
@@ -764,8 +763,8 @@ static int adux1020_chip_init(struct adux1020_data *data)
 		return ret;
 
 	/* Use LED_IREF for proximity mode */
-	ret = regmap_update_bits(data->regmap, ADUX1020_REG_LED_CURRENT,
-				 ADUX1020_LED_PIREF_EN, 0);
+	ret = regmap_clear_bits(data->regmap, ADUX1020_REG_LED_CURRENT,
+				ADUX1020_LED_PIREF_EN);
 	if (ret < 0)
 		return ret;
 

-- 
2.45.2


