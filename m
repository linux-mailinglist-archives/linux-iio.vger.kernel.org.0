Return-Path: <linux-iio+bounces-6368-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F3290B257
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 16:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3311F21F8C
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 14:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269BD1C231B;
	Mon, 17 Jun 2024 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VPFZGOSI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7B1C2316
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632221; cv=none; b=Uy3UhE/eY1GAKt6t048ymhKiOO054QVZjl98Dpy3U9voMyF1N/juk904NqpFxlh1IrVnthDP87pgEMx1pQIjtBBe+2hYt+UC0Zc62KjTKBnwwsvhyDyLCwPw6bfB1rcsz9ehoXnOIWXtTZ+6JDPycxGoop4qhAusMK51IMUJnXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632221; c=relaxed/simple;
	bh=guuqVXSs2s7BD/iWi4IU8Nf6aEgnRuSwwDipuP5iGhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OrUKQLxpHJ5vbvZEf2FUAvp0Q8oAXPLin5Nj4C2RW5JJIeHEVJmR+mZBrYDD/SLNOAjj/UBhSz3+SBpk1lb+2DLuHJOvt2mu6XkSHLVT17y3b5C/E5o187ZNbyO26jqAxsqhFpGPQxbx4kestwbcP/+OqjfEUhSYNdsbhScAHv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VPFZGOSI; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7955af79812so246246485a.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 06:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632219; x=1719237019; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KVb/0PilAc52B9kaVfDX+4rlv8WRgZtRLdvIf/r6J1Y=;
        b=VPFZGOSIU+ATWrnG0MtWNcbxIzHeGg69BwxPm1ffYq2Ee/txS5/Z9QXS6C97HPG3Id
         SMmItMonq6y/ctKYYHTbUFV/ydlkTMdMdPHMZDlTM+iEu2JGFE/+uMcXdIp++/8OtQJn
         NBP0M2gVxNEU00dS4VNwF5dvRl9S7KlECw043qfoGfoaadIYNHE7KDoVrRpmpI+dpgRC
         VjufO1/T7O28DkAvbkysSJ1HQLBwI/0L53Qeh5HKn9rJ7sgKrWBY8wI2BTH+ljbWut2k
         dFxCMWuW80gpTTjB6jgV4DPDrnrpwD9bBA86Gy+rM9iFqhCs84xMGlv0N+Jd32lvk8pb
         Kdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632219; x=1719237019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVb/0PilAc52B9kaVfDX+4rlv8WRgZtRLdvIf/r6J1Y=;
        b=U4hj+uO99yDdqpOpE1TDcltA1DnjSmU3FWI9XXXbFNHDpbkLBDowqvjNIDWFqXRFDI
         Hks5o5oX6ADrXPGJTHfDQpu+qau+H7LsVN+20ybMF63TTUvpLfeeETbYgjLGB7u+U3Ox
         liprgEUl+4bhTh+0CliQevOC3kzwLdtt0pI1SrTZQI+2SAzggHI8+4xOpSA+MtpVXQCv
         EcvMaY6hc4f7wJSgGnnbac3yP44rJGQPo+bV6+/Z4ccrx4SOxSt5kwYS3RYOJR5l+8tl
         qWbGKMNniGM0xFZb5l1omGIQU0Tfx2dHaGe3TW2N+cepLZukcnqfI4ePT/o3jTBrn5fD
         UYjA==
X-Gm-Message-State: AOJu0YyfXcX27G7Je0lHRPDZtTLeFutzuBpc3z5NV5D2L/EN3dT4skxo
	WQyMQOcJJtGFAhxUwfnMQwZXqFSeyX92vz9HuBV6VWKH7El+TaV3Z+RemJDaXtg=
X-Google-Smtp-Source: AGHT+IEhAnjjomgk19gOfh4FY6+tmL+ftVg/dpR5n10Qt2NpVGAkWAorRIXV5RllBFaajmvErpGqLg==
X-Received: by 2002:a05:620a:370d:b0:796:842c:77f1 with SMTP id af79cd13be357-798d243aaa6mr1278103785a.36.1718632219186;
        Mon, 17 Jun 2024 06:50:19 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:50:18 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:49:56 -0400
Subject: [PATCH v3 16/41] iio: adc: rn5t618-adc: make use of
 regmap_set_bits()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-16-88d1338c4cca@baylibre.com>
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
 drivers/iio/adc/rn5t618-adc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/rn5t618-adc.c b/drivers/iio/adc/rn5t618-adc.c
index 6bf32907f01d..ce5f3011fe00 100644
--- a/drivers/iio/adc/rn5t618-adc.c
+++ b/drivers/iio/adc/rn5t618-adc.c
@@ -137,9 +137,8 @@ static int rn5t618_adc_read(struct iio_dev *iio_dev,
 
 	init_completion(&adc->conv_completion);
 	/* single conversion */
-	ret = regmap_update_bits(adc->rn5t618->regmap, RN5T618_ADCCNT3,
-				 RN5T618_ADCCNT3_GODONE,
-				 RN5T618_ADCCNT3_GODONE);
+	ret = regmap_set_bits(adc->rn5t618->regmap, RN5T618_ADCCNT3,
+			      RN5T618_ADCCNT3_GODONE);
 	if (ret < 0)
 		return ret;
 

-- 
2.45.2


