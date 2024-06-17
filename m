Return-Path: <linux-iio+bounces-6384-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C401490B2E9
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 16:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBBA9B34637
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 14:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3661E1CEA05;
	Mon, 17 Jun 2024 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="04EFDOwg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786B31CE9E5
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632256; cv=none; b=QKv4sj2SUVRtRQ1/aRThMSRcu1Nlj7HC7uwkXE6m6whSE09vHR1oVMM79Af9e0OtkQdyY37rV0RLYiGX14fg3iQXRrVnMHk3eWwqpGk5d1CKFZgAcAhCTF70BD+luLwsqedYsORs15m2ry/InRlfbahBZBa3qU0UxZ1yFVfxPgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632256; c=relaxed/simple;
	bh=9Ek5rCXvCt90Gabaa6g12uHkTZTPMxmCN9hdijlBa5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OI3/6N9IiV88QTUMmNO4usEdummFlmDVmCmvl/FomEcwguNHev5z6UYLPOrGqnOMlXxa1TqOaYYRHXwVhJfsucJmOPIMd6MSxSivaHDo1L2XmeexGH41mGPLAR956iedQas8/0zKnoTZb0vqF3v5ePiTn6I0D6gcsiaZVDoy4Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=04EFDOwg; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-795482e114cso363679285a.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 06:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632253; x=1719237053; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8+9CxU2CvbNCydIwkwVi62wLJsPjXvn/mOpa7x+p1k8=;
        b=04EFDOwgWeQu7w8BPl2pZJUKe1Uwxh6gEnR3e2kZ7xF0rQvBhJWcexyE3YK3yOI1tx
         PxgZBWHq0BkwzXpi1T9c+EK+nTXzqvcbRxJMCMScbx7UcTq/cwoBRxLR8ECcZqPbeSm0
         5RhnAtcGutI7+jOsHxoVxCebNLmx5ab1KVeRsEZLl8oIC6/psgNrn9LzTKGotRdx6qqL
         HfYF/ACm3io1S724uSzqLxk97KtqfuMNqcbbMC+ulE8PT6A7equ9rJQ8sjufH+Dhg/9A
         o5yKL09JWYpsxbXw30E+Ci2vFuzrcz4AVDOdraRCW9Bhjd0WU+c+04fDQuYMomQClMO6
         gH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632253; x=1719237053;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+9CxU2CvbNCydIwkwVi62wLJsPjXvn/mOpa7x+p1k8=;
        b=W1ml4YrB2ODME6ZcIxOsT/B/swrF9DQKKdzRGeY/Su6v9y+BiDSw+EvGynqW8GLZsV
         iwDdg0kOsvMC69iMCqOIz3bOx87ip0H/kluqBiluBMp+tZh8O11jR7e93JFVfNAfB4F7
         JLfo63C2y2Vx4cYQ9Koy5y9sZv2hfpWHiGW990BGARKNC5+5gk6Z4ac6JTDZB9EyAvf7
         UfLPQkhU45NUKIbhoO2rV/tgdb61LyDzCN47TEfQuaP5O0WBba5IVyzNmucOQOkRg+ZV
         gcO4/3YYfBb/xyK6DVZmYlhnKYbS0A0gE48EG5wNqp/ahxzBNLRkku2vxYBWPWax1Po1
         U0ig==
X-Gm-Message-State: AOJu0Yz7mc5v03rbDcAlNK9+aRorTN8Qx/y3dWP7EznrVAqdZJ+vNObW
	MY4vFiKFtpZzrMGv9PXAU2Gt3MURTkqrUQQBkvC+UaWyq62eV8isaAQRdhl65eM=
X-Google-Smtp-Source: AGHT+IF0QBpD3doG6Fp1c+vnf+YJQ81FC5gB6//3DNzmC1F9GzI4GVFvf6U3tYk3LEdICO36nL3YKg==
X-Received: by 2002:a05:620a:2a0a:b0:795:5c3e:eb45 with SMTP id af79cd13be357-798d2531f98mr1137480985a.34.1718632253384;
        Mon, 17 Jun 2024 06:50:53 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:50:53 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:50:12 -0400
Subject: [PATCH v3 32/41] iio: light: veml6030: make use of
 regmap_clear_bits()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-32-88d1338c4cca@baylibre.com>
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
 drivers/iio/light/veml6030.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 043f233d9bdb..f7ccbce45f38 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -144,8 +144,8 @@ static const struct attribute_group veml6030_event_attr_group = {
 
 static int veml6030_als_pwr_on(struct veml6030_data *data)
 {
-	return regmap_update_bits(data->regmap, VEML6030_REG_ALS_CONF,
-				 VEML6030_ALS_SD, 0);
+	return regmap_clear_bits(data->regmap, VEML6030_REG_ALS_CONF,
+				 VEML6030_ALS_SD);
 }
 
 static int veml6030_als_shut_down(struct veml6030_data *data)

-- 
2.45.2


