Return-Path: <linux-iio+bounces-13011-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595169E1BAF
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 13:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86ADCB44165
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 11:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937AE1E3DF0;
	Tue,  3 Dec 2024 11:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Z+2gqJEx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2471E5710
	for <linux-iio@vger.kernel.org>; Tue,  3 Dec 2024 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224425; cv=none; b=Tnpg/ZNe2tGYr7/nTXbW4c08Hm6t2KBt5i4hXbi/MeW8gAm/luVUSeeWbCQuUruTctPw2AY+A960jEvu5tCFP1wS1Rqvypqhz0pfdXM57Z29dB1uq+70S74/41yJK2faQzwlMDWsYqpMDMq9OELujI0SsowZ49w8cRAxtgdOKb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224425; c=relaxed/simple;
	bh=dJ66VqH1lPKbG1vJ5uyMkdnhCZK/cj9xWl8VrZo+eZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VQp3QVp04VuwquO7tisF8EvG6NpgV5Fl1wNwRs9T75vZ1Ha6cNlwgdnnZiGos9wYimitraew2C8t1McE98ai0nDVOEJCm2jeWUEifR/wNwM62ACOq2WnhqETDMZrO3SPGV8TsXf2EBkr1AGp9/+24feosig5u+LvzUJucI40Xgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Z+2gqJEx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a45f05feso66628995e9.3
        for <linux-iio@vger.kernel.org>; Tue, 03 Dec 2024 03:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733224421; x=1733829221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGjJNxAUoLlbHeze5dKZ8rYLCdUS04mEhaX4QA4tgNs=;
        b=Z+2gqJExQdzuRiPv9DPdYMSZwZ5IdAbriIf91XWR916L8+vIxd4nR6+x5WeJtL9BuV
         bGQzsrLyFcBToFHCiOHVrC+16vXjoVi5XiodBOLM4KyEdUa7bujkBN2liLc9GjE3+Sh/
         NMER/kcmbuI17iMa32Pq4r0H+TI3Q1kEd3qFvU9YEB524KuuWy7VisMkdIGaof+t3FOi
         Qrp8o79MZu69kJ6XgUpamlAJqPWpcCwQxi7bgfS845vRXOD92ujjh41zbUULSNO3S7Et
         +7BDQnnQBXx4ZjWIUN4ABT6PeJrpyw9dg4QerBeYSZcFsCer9HWVnnQpRmnyya1/4VvK
         pC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733224421; x=1733829221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGjJNxAUoLlbHeze5dKZ8rYLCdUS04mEhaX4QA4tgNs=;
        b=HwMN18Nke289lCPg5Z46dgoY6OMcCJCDVns0FF9kSeNdrmuRNV3gbGBb8nIdcgVaz0
         wZdXv3UPOf4nBhoAa7RGR8RBMliaLKrYANAHJ+I6mleBji/SRtNENja9xO6XVpkr+a7j
         dcdrhRgeLUqoUC7+uMvpJujzGr53bhAPL/dRqx64aGhYB69OV9xM9u0PfrDWWqoDk404
         QDputibaEE/eO1xDjSHvLUrqvfJeMBVSvNg6p75PHcYtEyZKugDI0JiPWTB2xPvCjWHy
         nR1XTV6pe2kHb8fC1FRTGbaMI4I7zIjQ20GwQPfSovSf0STnAwGQd5HSBUxNDaZvk5rh
         vVGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhhcVECTR7RTxPFI9RrmEu3qjotKXF8oZKieYPrxSs2VA2Vyc4VK8xsHj2cSM1pPPAIjvIsidprdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw04AsRFAeE4F9Er5KqCi0fGFDb7UoRfbQvZim6ixlWqsPXr1pw
	P9cip15kBofpTZYMLlFZ/WZifoO/ZK93S/IFrdcDgFYPzTcLNLDy6qcvSgvPdk4=
X-Gm-Gg: ASbGncsAN5uLLl/ZDyGlWa4H/SbWAYDJdQDv5SKEPq/YZVkwsUsvH3QWaq5mhU4keXf
	5AOlQzXVEfPq9Y3Ol7iby9cao9IjEUfqDEElEdgWV+DlgmeEjrolpkYEXkEZv6Oo7IHP8xdHD6A
	8eLKtKmQvpHZKNpHDRTdG4YuzKnQ/QKAwu1y/4lO+hh/0RSjIQlhKmUkgLCHRC1R6zsZIjyj/48
	AmKNmj6fsA84X5k0NHy+lEmj++kvCoAo92Kc8V+M0k/NlkdytsMK07tDdxgCiX37auAkom5TGaO
	WMX5
X-Google-Smtp-Source: AGHT+IE+s1yoVLBzbwgkBBIAjbk6p+3eCyfk26hAJKZF4jfFJbnwH4ZzJ60DDcfVvJaXNdjv9UMOjA==
X-Received: by 2002:a05:600c:138a:b0:434:a684:984 with SMTP id 5b1f17b1804b1-434d09b2f31mr20189215e9.4.1733224420880;
        Tue, 03 Dec 2024 03:13:40 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e0117069sm11794315f8f.60.2024.12.03.03.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:13:40 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 06/14] iio: adc: rzg2l_adc: Simplify the locking scheme in rzg2l_adc_read_raw()
Date: Tue,  3 Dec 2024 13:13:06 +0200
Message-Id: <20241203111314.2420473-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Simplify the locking scheme in rzg2l_adc_read_raw() by saving the converted
value only if the rzg2l_adc_conversion() returns success. The approach
simplifies the addition of thermal sensor support (that will be done in the
next commits). The downside is that the ret variable need to be checked
twice.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 62932f9295b6..eed2944bd98d 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -227,14 +227,11 @@ static int rzg2l_adc_read_raw(struct iio_dev *indio_dev,
 		mutex_lock(&adc->lock);
 		ch = chan->channel & RZG2L_ADC_CHN_MASK;
 		ret = rzg2l_adc_conversion(indio_dev, adc, ch);
-		if (ret) {
-			mutex_unlock(&adc->lock);
-			return ret;
-		}
-		*val = adc->last_val[ch];
+		if (!ret)
+			*val = adc->last_val[ch];
 		mutex_unlock(&adc->lock);
 
-		return IIO_VAL_INT;
+		return ret ? ret : IIO_VAL_INT;
 
 	default:
 		return -EINVAL;
-- 
2.39.2


