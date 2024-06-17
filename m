Return-Path: <linux-iio+bounces-6356-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3946190B30E
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 16:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 520E1B37BD0
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 14:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9D11BB6B8;
	Mon, 17 Jun 2024 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lbi+Psxt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5165E1BB69B
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632195; cv=none; b=WgTrU4HDWIrUaFCJL9rf4qsEVNPMe9mMRemPdvLGEiWWHzYEt8KT+B1rnsCGXX523VfDN6THAC1pQJW4cQ9xNqTWhRbAFWlUb/vLPd9uJyLJWTrc1GwyaCkhZThMrEBz9dA23TaN5/WcwF8HzgGXMjd7phcA5653HW2DAJHiQ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632195; c=relaxed/simple;
	bh=F6edunFIUcDZTIb1mqBjURHwGYYpBYudXYPFSJXncC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uuT6ScRok6iBP4aGKGgWDedJhKutUUs/KPztvFZ5p5yA07vqyKTlKW6G0ywS59HAHEcBgtqvORIw15ULp1xetUHyjTRIzAs7eehzH8W6oUAr1TrjfJLEmz1v4ZTJMFuny9S2+KeuRK8P6k5cMMn3HjEimsQASDbS7YUq51RWEBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lbi+Psxt; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-24542b8607fso2288432fac.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 06:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632193; x=1719236993; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EcLjABCmPDgHOzLEYjNK5DROGA4JTxd15k6kwWpFoxg=;
        b=lbi+Psxtto/X6B21cjIvaI9jHqK1D47qOVQtJMs7qWWJkF+yzwmq9vI19sICfXj7xc
         ymsvVVVPpkidITO52EWJBBh3ke0UJMjnpkROyK2JQDrbLU0G798WVYFjG8LmrHPXkmOY
         YfOwezi/5suN6SVWCCzocztLAU4hEX85isuIulfGRATkUmfMVNKMAnqlSOQ75STFD0qz
         i6PA0r/pxW1z+zcqtMue19iD9gXmy/ylzWzE8ngfL3VFIKde5ddOh0fBkvnAvgP/+uq8
         sk6pcjdKkVTDHYWoLmokXzaGT7DICnA9XJ5EKCArENSmDnMFTJxe1hm2inWIr4OymefW
         HaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632193; x=1719236993;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcLjABCmPDgHOzLEYjNK5DROGA4JTxd15k6kwWpFoxg=;
        b=dJwTrlOyxjLooUEMkHUiBEBJbEjTQGVUTIPJkGvGobUKRtkSsoEnMiyc/GTsOXJt20
         eXQ6B73TLN6l6VqEgPmyoaiMuwszO1Mn6Zx4MHOfRopYUm0WJcAKpbhXsFY+KixYgpDB
         kQbaKej0E174iQslOs+OiebpLSamBjv0q1KQRnAFsgYJZzzXrdUNYh0SOWYHlAYRn+oa
         L+BVuXOViXXRErJ7HHDl70yewkFUHcm395AmBo/1oO0yHAZH8DUMdWVxIaWevHOMWVh5
         PgjLLyksx1kqwXm1A+aWAIUraF8SJvOqN9Ncj7oy9t8xvIOH/pZEopDgUfKAaJQi3osA
         Llow==
X-Gm-Message-State: AOJu0Yy/Zg24b1L9bcDWdrz3fB92oJ22/aVg7Aj7RoHb/Tz8sQCny/lV
	aI3DVcTUjTVTEV+WasRGUm5VB7hc2yKCvyVTJXrqj7NlJV6m4FjenG61L7cgmuM=
X-Google-Smtp-Source: AGHT+IGzXK8LLO+jQf8g3iL5MCifYqjIipjPlFcW7eDQk67H8aKJxfmuoG4FYBXo33Z8PvtltK6jug==
X-Received: by 2002:a05:6870:4728:b0:24f:d9de:3bed with SMTP id 586e51a60fabf-25842b793famr10756815fac.41.1718632193273;
        Mon, 17 Jun 2024 06:49:53 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:49:53 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:49:44 -0400
Subject: [PATCH v3 04/41] iio: adc: ad4130: make use of regmap_clear_bits()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-4-88d1338c4cca@baylibre.com>
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

Instead of using regmap_update_bits() and passing val = 0, use
regmap_clear_bits().

Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/adc/ad4130.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index aaf1fb0ac447..e134d6497827 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -1883,8 +1883,8 @@ static int ad4130_setup(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	ret = regmap_update_bits(st->regmap, AD4130_FIFO_CONTROL_REG,
-				 AD4130_FIFO_CONTROL_HEADER_MASK, 0);
+	ret = regmap_clear_bits(st->regmap, AD4130_FIFO_CONTROL_REG,
+				AD4130_FIFO_CONTROL_HEADER_MASK);
 	if (ret)
 		return ret;
 

-- 
2.45.2


