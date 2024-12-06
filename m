Return-Path: <linux-iio+bounces-13140-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E04449E6CE3
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 12:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D1D281D8B
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 11:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5111FF7D0;
	Fri,  6 Dec 2024 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="KTyk/JTS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7AC1FF606
	for <linux-iio@vger.kernel.org>; Fri,  6 Dec 2024 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483642; cv=none; b=uZKV+AW0x57V1jTUTljz3OMcxuwrTebbbtJffDcfH1UmpRWJhlN8Rys1PFFEqCijHJ9tcbBQUCPT1MEM0rGkwjW3TWCdJ1hIIbuPmg3qxZECQbuh49dbyoD3ZRI1pgQXo8zpvGHAPKftzyjNnEYvhmyT1BtwF9CUjJJz0H+5LhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483642; c=relaxed/simple;
	bh=pFeVqwq5TdQjxpLyK7iTM1W+bmcdyJjKWS9gDr7aPgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ggy4/RgjkKDat6tP40cVxSo4iw0mWHzllHOMtgmQVpzpEsmME6NzVI2qWjZ+Z8gOmvoxCDVQXQS2BzQX8esy6c/UYZIOuLniBZHGtPxzfkjmIN7PHIHsU6OhTgd94FjilVpaqd31rPOfd1Swy6OnBQdgJwBgXNSLBaWJPwpmJQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=KTyk/JTS; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d0d4a2da4dso3154027a12.1
        for <linux-iio@vger.kernel.org>; Fri, 06 Dec 2024 03:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733483639; x=1734088439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IF+3d6YLoFd8ymBLjEJf+CI6Y+EI/atf0HIxguIiGOc=;
        b=KTyk/JTSj84SQaukd1UW5/e2pUXUmY4LMfK3scIgA5GUK5NXxh1JUjIOy2mvdCKPoc
         4RUOzTCk5ejmI4TMxPI3IwlvgJjccg1KUm6GMuMzUzjZc+HWNEj8NwF8fse4+ucyoKg+
         SDm/FliQmJHkw1u9yJtjMtAyvUjx/EsHww0B4qy5WoTGpkUDAnvI4fQqEhQthyRwxEDM
         5gkzMPLMBvwF4AkmMYF59/a3vKFgNjklGsCTjrJYjkFXemCR2JL54Trv7bbgoyuMxm0Y
         FUD3dKOJMLvLka7DIOiO+PwSXNGSqFFeDqWAWM2CHIwKpRHFdvsze5IgCdmo6d+gZSaW
         we4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733483639; x=1734088439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IF+3d6YLoFd8ymBLjEJf+CI6Y+EI/atf0HIxguIiGOc=;
        b=K6fSYUBKIBLL7mTyrNXLss2PWPgcvePGElOGfB7O8YiLHKnyOcccQqDyjwVCCJwfjD
         0zxYSzPASwRNl7c53OC92+8AcomXndFP9KPVX4oJEj5TWYBMRrqoVgszc5jIsQ/UDi1t
         e8YRFYCWFYcFLdpECivAgpnyXO4fDiq8Bda6AH7rHFpKGqiU2Q+OqfS1B7L3DKlUC5hI
         cRNZqU/Toyn1AZQBIvXPMNr3Z88U70yRmDOzHgy2MKCVLdfVuWCZ4KrF9iAxo577iBz0
         bLXsgmGv5o6PsKfvrEB4h3gZA9pwX/khIBYEWVK4dZ2yMTgBE0nuOM7ZTlQO1I9Sam5I
         Y1ow==
X-Forwarded-Encrypted: i=1; AJvYcCXd6cPNyUbBPTxLsufiCRSelpmBttHUGNyF1U+WsCwmZYibs5AuWNC1xklIIgfQXd72v+dkXEa9oHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRJBghGVyKewcTw47cCP/PyGXtnyxpnyvDbbQ72Ta3cZNys/dc
	pdabUW0Sz/9GJp4eD3XwErTnyLEdG2lKUFyNwRI+QbPS/RgpokLDQt7dbOaoVgA=
X-Gm-Gg: ASbGncuz1rDu02OPzS8072b5pFlHvLDdKShciOMcMot1JpgFca8A9fXuNEBl/7kPVof
	cHDp8Edv/OCQO+YDpBYG69T/mDU43JVbiQRWUTpRsUPqz2hwh0vB3PtEPge5Lr47W82qu8icLpi
	RUwEWUjdQC8xfrdRJeQLI0Nube8ezBlnnAFfI/yJCkauRObo4dvRVKln7DAQCmEJr4MlwN7EHTG
	k16rJwE/Cw1MHTshz0cPRPUKlf+KueIkPC2dTlt59EQdK6FTtObpHDdAYzFEgXncVxnznd/dYSx
	q03i
X-Google-Smtp-Source: AGHT+IE8/6k5bsY8E9y5ISlKPNleG7y4yY/FFLd5nbbFNGCG10Rgtm0MhHvZLaSwwmr1LC62i+/LQg==
X-Received: by 2002:a17:907:3a57:b0:aa5:1cdf:7bb1 with SMTP id a640c23a62f3a-aa63a03afedmr192091466b.24.1733483639246;
        Fri, 06 Dec 2024 03:13:59 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eee2a6sm226877866b.90.2024.12.06.03.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 03:13:58 -0800 (PST)
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
Subject: [PATCH v2 03/15] iio: adc: rzg2l_adc: Use devres helpers to request pre-deasserted reset controls
Date: Fri,  6 Dec 2024 13:13:25 +0200
Message-Id: <20241206111337.726244-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Starting with commit d872bed85036 ("reset: Add devres helpers to request
pre-deasserted reset controls"), devres helpers are available to simplify
the process of requesting pre-deasserted reset controls. Update the
rzg2l_adc driver to utilize these helpers, reducing complexity in this
way.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- rebased on top of patch 2/15 from this version
- used "failed to get/deassert" failure messages

 drivers/iio/adc/rzg2l_adc.c | 37 ++++++-------------------------------
 1 file changed, 6 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 8a804f81c04b..c0c13e99aa92 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -411,11 +411,6 @@ static void rzg2l_adc_pm_runtime_set_suspended(void *data)
 	pm_runtime_set_suspended(dev->parent);
 }
 
-static void rzg2l_adc_reset_assert(void *data)
-{
-	reset_control_assert(data);
-}
-
 static int rzg2l_adc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -448,34 +443,14 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(adc->adclk))
 		return dev_err_probe(dev, PTR_ERR(adc->adclk), "Failed to get adclk");
 
-	adc->adrstn = devm_reset_control_get_exclusive(dev, "adrst-n");
+	adc->adrstn = devm_reset_control_get_exclusive_deasserted(dev, "adrst-n");
 	if (IS_ERR(adc->adrstn))
-		return dev_err_probe(dev, PTR_ERR(adc->adrstn), "failed to get adrstn\n");
-
-	adc->presetn = devm_reset_control_get_exclusive(dev, "presetn");
-	if (IS_ERR(adc->presetn))
-		return dev_err_probe(dev, PTR_ERR(adc->presetn), "failed to get presetn\n");
-
-	ret = reset_control_deassert(adc->adrstn);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "failed to deassert adrstn pin, %d\n", ret);
-
-	ret = devm_add_action_or_reset(&pdev->dev,
-				       rzg2l_adc_reset_assert, adc->adrstn);
-	if (ret) {
-		return dev_err_probe(&pdev->dev, ret,
-				     "failed to register adrstn assert devm action, %d\n", ret);
-	}
+		return dev_err_probe(dev, PTR_ERR(adc->adrstn), "failed to get/deassert adrst-n\n");
 
-	ret = reset_control_deassert(adc->presetn);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "failed to deassert presetn pin, %d\n", ret);
-
-	ret = devm_add_action_or_reset(&pdev->dev,
-				       rzg2l_adc_reset_assert, adc->presetn);
-	if (ret) {
-		return dev_err_probe(&pdev->dev, ret,
-				     "failed to register presetn assert devm action, %d\n", ret);
+	adc->presetn = devm_reset_control_get_exclusive_deasserted(dev, "presetn");
+	if (IS_ERR(adc->presetn)) {
+		return dev_err_probe(dev, PTR_ERR(adc->presetn),
+				     "failed to get/deassert presetn\n");
 	}
 
 	ret = rzg2l_adc_hw_init(adc);
-- 
2.39.2


