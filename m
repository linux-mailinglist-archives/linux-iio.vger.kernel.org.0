Return-Path: <linux-iio+bounces-6372-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C24DA90B269
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 16:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E901F23E38
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 14:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855861C9EC2;
	Mon, 17 Jun 2024 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I8Et/r4t"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67D81C8FD8
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632230; cv=none; b=ueLXQYliw/AfIWqbecv9dOgNKM7hzIGKH3Y8xCL1m60JC8jQ+yf/UvfzcL/eX1BKJq8O1aby6Y3MPp5IeUSvogA/6Lnyt2syBIa/EieVaOorpCSPSz/iyL8wq8r6cTrxhqPx3PPqMFIZvNpc52nvmgS43aYcKRXmJDWz6m+T4Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632230; c=relaxed/simple;
	bh=Q7aNKMVQoMCDJLMDKdU1X+EFFJ/s/U4Tzm3jjRZeQ7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BuQF4SJfgPJGatBHUPxhj3mCqPuMrvyNmspSHlbVTFk7udrBMDlFAtVyPW2ybNSCD7nmmTOX2YePUqhDvnq8cuwPPR1MBBNsB7bDouaTR/trldxmdewcENwczi3sNPDV5CRNLkJflqaMDN86TDX2pL5KnryX5yW64pEfP1upVdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=I8Et/r4t; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7979198531fso327523985a.0
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 06:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632228; x=1719237028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/XakTIALlxEv0HYj2MxlbOtZFxZOxjUYZWhXJH4zlh0=;
        b=I8Et/r4tRKyvCJZ7dJoX44gsscL9lSIE+KUccmhR3Rx2TMmrtXkQy+ULuXLjTZ1hK9
         7ZhCpC3Rkqycoh6sFI1wNiAQEe9uuLJqayvNofrFxzgiG/MK7mG/TQdL0FdxaunKKAi5
         VpMowXUdbmsVpbB6u5qmtiGo56dgU5qrWY3n7+zLLoeJLF7cemrzqw/zfpT7+Qe5UNPz
         9R00SGwm40k45V5rFjL3PSP9jpR0FmNErfJkghp+wzZrpu7cKp20ZZ/8JtJ9muJKS6rT
         EnpSMdoo4h5PLFNdGsrU8LOsTJe6Zfh+aBU3cPhJXiez/1lbnqJhhzCYilgSzindLmjB
         +VYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632228; x=1719237028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XakTIALlxEv0HYj2MxlbOtZFxZOxjUYZWhXJH4zlh0=;
        b=Fl4N0CdmPc6bpmHV1GqQrcrSNo/EX5Pf3C7Dv6tDB+hAV0Kke6vm7FCr1efcglmwEl
         lxKUl6la9L2soUXhS2wUs3o+9uIUqZHH6QYgawzJDJv2uv+MT5tON2E7nLBcii3FEMOP
         XXPxu+RSDW6m78AxfRXxdni9WVjNmo0ewH2GjZgqucyGglbetHyTcef69NcR9Mq6kc9m
         nlwOCwXNlX2Lr2x9Z8HJ2MnI9+fI9cZvjLYZPRB3Jy38KdavIWeuN8AsjcZlxMzJIo8A
         9jRLaOwy76fqFSTtDeWdWNrQH362lIy1ZkumYJA9rKZ9sjLuaEzzpByQevgR1Sxk0k83
         WAZQ==
X-Gm-Message-State: AOJu0Yw2I2NoFEvbni6edt3yF5r0QQz+n7StwtqWVkJReTULOvp7swp0
	qU80WjBq2Bvz1IbVehyxsp1H6is5m9dKAp0KEqdMS+EopmEwTF0DE0cIoc68SM4=
X-Google-Smtp-Source: AGHT+IG8ABD9tEwAKr1/xa6bdVCx92iQnTrVgELPE/Lymo3q9zF8m5xvFoyu+g0K7+PoHeaETQDP6g==
X-Received: by 2002:a05:620a:29d1:b0:795:967d:b1f4 with SMTP id af79cd13be357-798d26b5261mr1162014985a.70.1718632227786;
        Mon, 17 Jun 2024 06:50:27 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:50:27 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:50:00 -0400
Subject: [PATCH v3 20/41] iio: dac: stm32-dac-core: make use of
 regmap_set_bits()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-20-88d1338c4cca@baylibre.com>
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
 drivers/iio/dac/stm32-dac-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/stm32-dac-core.c b/drivers/iio/dac/stm32-dac-core.c
index e150ac729154..2d567073996b 100644
--- a/drivers/iio/dac/stm32-dac-core.c
+++ b/drivers/iio/dac/stm32-dac-core.c
@@ -200,9 +200,8 @@ static int stm32_dac_core_resume(struct device *dev)
 
 	if (priv->common.hfsel) {
 		/* restore hfsel (maybe lost under low power state) */
-		ret = regmap_update_bits(priv->common.regmap, STM32_DAC_CR,
-					 STM32H7_DAC_CR_HFSEL,
-					 STM32H7_DAC_CR_HFSEL);
+		ret = regmap_set_bits(priv->common.regmap, STM32_DAC_CR,
+				      STM32H7_DAC_CR_HFSEL);
 		if (ret)
 			return ret;
 	}

-- 
2.45.2


