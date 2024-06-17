Return-Path: <linux-iio+bounces-6373-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 125A890B26D
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 16:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0FED1F21871
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 14:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0731CB318;
	Mon, 17 Jun 2024 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MChG/Nlg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C9E1C9EDC
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632232; cv=none; b=KMb/uUgm4Zb2S4xLBBsrPQBfrSJWikwrRQn8uddS+eGJPWNxlMde8lR/aO7nlaYnz15nHFcfiI8j+NxLd4XyD8U1b2l6LMC3E73F403Jr4d5kb7eG0f9i1QjUCTh0tHV+0f4M1GvKlIDxSmlh7nK8S2RvWUxqk84izBselSqlvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632232; c=relaxed/simple;
	bh=QPP25hzXGRebbNyApfbw/ePtiR6pqeVKltbiG7kR1ck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SVt8pE/j1aZtDuIe4VfwEL4wg56/tc3M5MrXqILtOLZ+CRDeZhjCAKgqBxQ2YYa1Xxml4UBYAtm5ve9VlIuhIkCJLDARv4n3/8PoeXjac2mbRYznt4a/K+EtdOf10qFPJ1GnzikvEu6kfln15SFVSUl9G8fhV+s8qkFbjMKHUW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MChG/Nlg; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-79550284502so267251885a.2
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 06:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632230; x=1719237030; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DerxFnnoYXb7MP4GOUVN2xlgxjAao77OyLSOrDCydO0=;
        b=MChG/NlgqN5oIvipm7hig1cOCo00rbrUJSOPK8uKNfGR9JLzg8p3IidvCtg350jeID
         HCzsEjsaCgEMs7kAkQ4SJois0nIxP8JOP5CcaugPfWkITTvWHSZGNYiibZyyx9yF2JQM
         +kg4BUEEoKyy61PxiPJMw3/A7tT16RBrAJXLQrUjsgfKJHy5ChaomO4uh8cDam3QpA5k
         yMM6/V9AoVmTqUuJEbwRzYuoiWmlRndO/p6xdH6rUMidpca9ilsyEvE8R9mIugQEVP6X
         5/xtNr7Ksz3oQb51gHNtRLkOep75NR4BiVAnK0oX2fbMBvc7IlLhZO6GR2Lh08tjIS1n
         awtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632230; x=1719237030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DerxFnnoYXb7MP4GOUVN2xlgxjAao77OyLSOrDCydO0=;
        b=N8x8fzFaL87LiGzC6HH8xc7F5gh4pY1mJbgF4J/ouA9tZroe+ZzLF4PikUVVT7jkOL
         bJk5sbOPtsmnmDWgC/7lg8At3pkJjMGK6DxwHH0nE1jF4l4x9KFkT5Y0zUPqMIin+lam
         JH0qQARekfUWhLTbD/qB5Fg87cu8S935ReSjQ82KXSMZd4CFFQLG95XAnbRvjsFH4pAJ
         DONXZ+XOxYOhQ79V6IFbRyWnp+aKjgLWd91tRzbIRvG4Pfs113Z23Ja3ia6avWG0H7ML
         f0zJp6spfLKW6Ui+3slf68eHNEztt6O4LTkzDt0CVHmPH7UxmUmKtmFUDDcn/ouwG4FX
         +aPA==
X-Gm-Message-State: AOJu0Yygdb9LY2yB5IpUCeCh+Tmyqae3tozh9L86TIV78mchBe7GTuxE
	DBoE4W6ydwGgWzn/FFOwjcxFQnEp75qPddrsW07/2/gV10ud2/FDVi1meG3Z/nI=
X-Google-Smtp-Source: AGHT+IHxtzkdFJwlDchh8tO2N+M/GUfc/zgUMeSNzO08CBN63HSCP+uPJVwg8RWxzdMRcwiKU/TPZA==
X-Received: by 2002:a05:620a:2443:b0:795:4e2c:eabf with SMTP id af79cd13be357-798d240dcf1mr1259752585a.26.1718632229931;
        Mon, 17 Jun 2024 06:50:29 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:50:29 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:50:01 -0400
Subject: [PATCH v3 21/41] iio: gyro: bmg160_core: make use of
 regmap_clear_bits()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-21-88d1338c4cca@baylibre.com>
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
 drivers/iio/gyro/bmg160_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 0e2eb0e98235..10728d5ccae3 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -285,8 +285,8 @@ static int bmg160_chip_init(struct bmg160_data *data)
 	data->slope_thres = val;
 
 	/* Set default interrupt mode */
-	ret = regmap_update_bits(data->regmap, BMG160_REG_INT_EN_1,
-				 BMG160_INT1_BIT_OD, 0);
+	ret = regmap_clear_bits(data->regmap, BMG160_REG_INT_EN_1,
+				BMG160_INT1_BIT_OD);
 	if (ret < 0) {
 		dev_err(dev, "Error updating bits in reg_int_en_1\n");
 		return ret;

-- 
2.45.2


