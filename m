Return-Path: <linux-iio+bounces-6391-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED07690B3D9
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 17:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFE14B3B999
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 14:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDFD1D18E2;
	Mon, 17 Jun 2024 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oazY+j9j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A014A1CEA1A
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632271; cv=none; b=fr/r0w+qPgwn53oke3DCoHnnPxc7ZmZd/Gw46xEvWI+6RuAJV/fJM5oDxJ4+zAZ+i/XNZItSyxommJcZjT31B7VkNHkPwZ+af3I9liA/fm/KQIjhHRHLQp4y41URPVfTLYHFMg0O53FVbiherxzhAQyL/yJs9wbvVPGkAHtUTJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632271; c=relaxed/simple;
	bh=lrT4UVJxbYPigfpUfvDqNd6ndl1eVcIzUfVJ/1QCCbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=snyywR1Kwy9xuirKVltW4M9gJEC1XAuB/9MFgCOFPQcsaIrKzosNQiiRq3ndyZav2hDsIhDSvaw1YSaehr+v6eFcLghX1Dv6dUHvAnL292oJrII5Z/4cTOH3246eYncNiJSeF5ZU42xw2bqzeGCjbYLMSYdjuNhb/sUgk5LuAIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oazY+j9j; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-44051a92f37so35894601cf.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 06:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632268; x=1719237068; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tvabn+RMpG3uovvK1+JaZOuuhTQ0Y5v5qxh3XvN8Rq8=;
        b=oazY+j9jwiHu0wxRO+kO36SdiQE/16HGaJhB4FIWY5UrZ0KsiD6p+Gd9qRuS1Vcw6u
         C9kjFmUwnRGZ/kYmgeXlDQ9WBmPJUzoeOqDJMKgbItUFuqHB26M2343sNgn0D/PBKclg
         TpmoiCWRVK0CD0JBqzqNpMNsYf3D7CjWKY7/MCq6AqlaU4eYgGz6i1jArVfQzzUVKV/p
         VFoneSUaG/HOwh8a3O+hd9q3V+O5gPWPENe6Z1j/OxUqNTMKPMqEQ80UvQ6Nzt4ztsUr
         UYi49OqvZJtFBZOC8DxCCm41vvVWjNUglGzoLV1i8X9k5nEijO0wiG9v//HY60KfvA7f
         qoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632268; x=1719237068;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tvabn+RMpG3uovvK1+JaZOuuhTQ0Y5v5qxh3XvN8Rq8=;
        b=hXGYMTmjMI+EzuNwViV6EiIe8IL9ymym3g4XOpDtkYSBZCalJfIscQBDiItXqIiwK9
         BscXR1WC/JtaGOokZ4To1RXtM/OxsSMqp3oRyS3jPPw/jGuCmswloww/Mu3aJneEMzwZ
         htgzQo6ZJFpRQ/QQ+DaLzxak6E4fA1f+2lWHiffTIgyyWL+U69DUVdvAk/hw7ah6Bse/
         xbNyDfxSLYfkP9fnV3VPkLLCMA+qr2skCcENtzVhvipBxZMur73OaLyO6VyJOISYolCt
         p76tyU+yiQdwDVaonxxPnVCnKtHeeJuKJooUGqd+lV01QnDXeNwRxTog0Is0m9f4KPcz
         lxkA==
X-Gm-Message-State: AOJu0YxEEhf0C8aqytYrbBQCGvrVQS60XmOneBBgGfhR2YZdkfm6LORk
	4yBJtnV7lcyHg4FXO1V9YoCsDni3+cx3Xu24jTabs7sXbxjixV3/oPkEBRGIghY=
X-Google-Smtp-Source: AGHT+IGCNTX7XI85nrdMwm8HgjdhSBF2upAbofRDQ4N0lo0/7MseIEDdacRNTzR/tFRJhwns3PxO2A==
X-Received: by 2002:ac8:71d7:0:b0:442:198e:cb9 with SMTP id d75a77b69052e-442198e0e4bmr132788711cf.27.1718632268400;
        Mon, 17 Jun 2024 06:51:08 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:51:08 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:50:19 -0400
Subject: [PATCH v3 39/41] iio: proximity: sx_common: make use of
 regmap_clear_bits(), regmap_set_bits()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-39-88d1338c4cca@baylibre.com>
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
 drivers/iio/proximity/sx_common.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
index fe07d1444ac3..a95e9814aaf2 100644
--- a/drivers/iio/proximity/sx_common.c
+++ b/drivers/iio/proximity/sx_common.c
@@ -111,17 +111,16 @@ static int sx_common_enable_irq(struct sx_common_data *data, unsigned int irq)
 {
 	if (!data->client->irq)
 		return 0;
-	return regmap_update_bits(data->regmap, data->chip_info->reg_irq_msk,
-				  irq << data->chip_info->irq_msk_offset,
-				  irq << data->chip_info->irq_msk_offset);
+	return regmap_set_bits(data->regmap, data->chip_info->reg_irq_msk,
+			       irq << data->chip_info->irq_msk_offset);
 }
 
 static int sx_common_disable_irq(struct sx_common_data *data, unsigned int irq)
 {
 	if (!data->client->irq)
 		return 0;
-	return regmap_update_bits(data->regmap, data->chip_info->reg_irq_msk,
-				  irq << data->chip_info->irq_msk_offset, 0);
+	return regmap_clear_bits(data->regmap, data->chip_info->reg_irq_msk,
+				 irq << data->chip_info->irq_msk_offset);
 }
 
 static int sx_common_update_chan_en(struct sx_common_data *data,

-- 
2.45.2


