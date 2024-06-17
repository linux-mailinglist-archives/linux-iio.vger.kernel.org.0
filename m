Return-Path: <linux-iio+bounces-6371-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B5B90B263
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 16:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6501C23647
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 14:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FED1C8FD0;
	Mon, 17 Jun 2024 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WsddIHuG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907611C68AA
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632228; cv=none; b=OQ79287T8grY7mzCNXrttkD2EyaIol2lrtmnOdWjDU171iJ6l7/5/vv92xnCCzV8sX0KvePpPoD6q1g1ehO4sA3kcUyn3Jr+Ew4miOs4u9VK9CBiFZqBL0Blk+h+9EryntVS5gJsvl0967DPVIOpBxwLSeDu4J6IlStpi7bq1UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632228; c=relaxed/simple;
	bh=vF9eCSFK9zsl5BTxl6iZi/Jw5sWK8MiJQHD/bb1xgts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RrA11vzFzbn+BgneFykefOJ/EV4omM7tYao23HZWyeLwSAQp88XI6j4LOqQHudocRHjCOjn79efuddMHc7ZaCVH7JMWs5uHD/HF8mpNZkF2FNh9vWfexnV3Krl7wV2owVUu7ngZo9eYndU8HHpBACSpHHAwHe8fLKfq6wsZxqVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WsddIHuG; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b96a78639aso1725946eaf.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 06:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632225; x=1719237025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TsjL1PDi95mMX5sXzypBRu5MAqP+mGu/27hW1rxKMDQ=;
        b=WsddIHuGoPLbiwQ9fZO9e6Q01j04Kr1Eyajx/IEPmW6HybYvwYjvstz051uiqnG202
         by1Up2/AD2yYRghZ7vH4BdjHZ4KkesLB2rpTb/SZHefdT3RaSG5QqnF9PQK9k64Yk+Bs
         rRaPPGZdS+LAPqq69VHBba5FJ5VOtsBOc1JFNpVX+zRrJ95xIbHnZoAGUJwnb1PBzdny
         W15ASpND+A79ir44wIfJGiZIKwMF9TaNCB1DlJONWu364IC6i7bccOxaAxFRaA0iM2uW
         RMHVWqyxB/nFSZrtbEUfdDek0a+RaoK2mC5tWJ1PXf5yA0QUGT7OeH6MktirMsBhVhOk
         75TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632225; x=1719237025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsjL1PDi95mMX5sXzypBRu5MAqP+mGu/27hW1rxKMDQ=;
        b=AAo/28TAbHLXv8AB2tZcl4EdBcHVc8re/SFehzTssAiGVHv3XlGpggqzK7j61xNdTV
         qb+GiHMXV7OV6ff8hXG/qvlVzcVHB2GeHvSoymwEIrSxjWXhiSGmLoc3mRJ1tJy7B0s6
         DAUOwNOsh3LhNw09Sj7jTt8My5a40KpMJxoX3SU5TGxGX470+proHVLkjOrIs2aZS6oS
         SNT1kIpEzWdORNks67t2ekei+2n4cJYNlk8fLVo7d3coD5NL5sUj0D3g69ZAAWbaU1y6
         p/MCHxgW3rm0zJ8mn7wATbuTmHdHg80HDP9P7IHKzaKBt+HQDt0EwjTvg2dOJSqFk0ma
         NuEQ==
X-Gm-Message-State: AOJu0Yw5ZzAiFd4Nth9txz3/T8lgpSpINu4xxxAfz0AKE3xZlAWdGDpX
	d2VSL5wiZNoaJFPaOxx+i44QXXFtkYCavfkWO3XlI9SOU8WcdE9tafOlM3EY9dc=
X-Google-Smtp-Source: AGHT+IFvblxIubOLu7csKqd2DaYsYhFE9mHOS6tHSYRNjsfIzum/J8kKl7oiGVOQ0fHTuqtXTzPk8w==
X-Received: by 2002:a05:6870:d383:b0:254:ac99:1152 with SMTP id 586e51a60fabf-25842baade0mr8855321fac.58.1718632225631;
        Mon, 17 Jun 2024 06:50:25 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:50:25 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:49:59 -0400
Subject: [PATCH v3 19/41] iio: dac: ltc2688: make use of regmap_set_bits()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-19-88d1338c4cca@baylibre.com>
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
 drivers/iio/dac/ltc2688.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ltc2688.c b/drivers/iio/dac/ltc2688.c
index c4b1ba30f935..af50d2a95898 100644
--- a/drivers/iio/dac/ltc2688.c
+++ b/drivers/iio/dac/ltc2688.c
@@ -860,9 +860,8 @@ static int ltc2688_setup(struct ltc2688_state *st, struct regulator *vref)
 		/* bring device out of reset */
 		gpiod_set_value_cansleep(gpio, 0);
 	} else {
-		ret = regmap_update_bits(st->regmap, LTC2688_CMD_CONFIG,
-					 LTC2688_CONFIG_RST,
-					 LTC2688_CONFIG_RST);
+		ret = regmap_set_bits(st->regmap, LTC2688_CMD_CONFIG,
+				      LTC2688_CONFIG_RST);
 		if (ret)
 			return ret;
 	}

-- 
2.45.2


