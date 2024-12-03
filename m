Return-Path: <linux-iio+bounces-13007-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64299E1A7B
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 12:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C966166A00
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 11:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94781E47B6;
	Tue,  3 Dec 2024 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="aDJ2pHQu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091981E377C
	for <linux-iio@vger.kernel.org>; Tue,  3 Dec 2024 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224416; cv=none; b=l12RVtbgpylDQwUWWie281xgfc3NU0wVCNUDCBtoJHsb50kz3HpreqwuZgH45nk4FJxZrBllr9hZebPf0A0JxoMkqnKmemn4fe/BMr3g/5Be569G5fi4o5YrdQizBfeMnZkxYWRWwo3ltaeIBtOGhMTg2jqwZHuLi160BRc6oL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224416; c=relaxed/simple;
	bh=BcEAbdEHxUPJxpN9iz2s+l1806K8m+gV9WQUDwylyDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mgD6NEcxYIitRlhSdda0+x+3YT7dG6Cu5GkPHzf1NzFg/1JTatMSwBcPM5B4emyJbL5eMZ2yScwegAwkWbfB/yGqi0HViaqLQszRF2vgpnPOjt3vaMekUJS/4vJW+2h3GFBX5N909AsTQPbfgbPJnQiWutb6yX40Tp6VNPVvRe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=aDJ2pHQu; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434ab938e37so34641755e9.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Dec 2024 03:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733224413; x=1733829213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFkXoCiMae7P06R3aL018K4E10+cR+uVvjH8Q6yLu4c=;
        b=aDJ2pHQu1OZG2wIgUcWuObqA/klww66smDFcuhZ/9DhTpKNk4ok/8hR4LGGjNCpQi+
         61QyACpK1dTeJcHE8q8w2OpW2JlZRpRs6V4WJHfHh2VWpfRwPt190eFjUXAyzyp65qCT
         9aVDbO9feiD6SLOiIyhZ3SwzYpQ8D9rTU1tIYaBna4O8IMZiFj1VMMhU4Fcs/FYuHdwW
         atILyLqI27pPYZEldeh0Qq2wYe7JVwbnrIdWQL6Rya3kDSe9Vp68s5vyRMnF+HXQ79+r
         YKi3rHdwP08w/BUvASJ+Tpo7JzWaMkyCZmSNOoxXa9ss01y5jBDxwZCpp1AM1uWE4i1R
         XrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733224413; x=1733829213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFkXoCiMae7P06R3aL018K4E10+cR+uVvjH8Q6yLu4c=;
        b=M5o24ZOBjyDKaiz0m16JS9mgWqotVwNQWCVV4vyEssRsKPbNa+3VFRYRRUN+WBB6hJ
         uJvFBrvjNiQieUuaoyVybNkWomA5e+dnVu6k073S6SOxQD9bBRxi1h3gkkRNgmPu5RM9
         o4JLW3roeM39OaK29PEB84y7ReloDBWoEZsjdvY91Q8ZSbV7VDq/U2HdfCf2g+YQpAZg
         5Ta7pCT013QXmQOo42nscP9EGDR8rfgVjdQYGpMC1VFUqffg7Z/F3tOZYWiPRtllZrC/
         V8LVnZ1osNhj//mD+B7XvuyKo07KXmIVRK3UpHI5yY04ZND1i27I9lKPvasOOK8EUhQk
         dS2w==
X-Forwarded-Encrypted: i=1; AJvYcCVIKphpGZUG6yGl9wRodaiWdCfOC/jNsB6ZJiukJFLu5gsUMdJq1McKfhzyN2OWt0wQaBxoLKu+q58=@vger.kernel.org
X-Gm-Message-State: AOJu0YxryTSqxJFZiQNpvoPL20NKsec/FdEzKhzNeJ+eEHH8FoKBACu/
	YGkEhWuQVuDsUC/xSFcILSjWBGT43fZdb/HcELcYWGfQiAfgA7H2wniW8nkvDmY=
X-Gm-Gg: ASbGncuhmtFSYMwqit0FTGno4+Hq7qSJ4Y479qNNQZxVr+XLN0Rljd7TD5sFglGOLpa
	RiXtNP7zmE3YWl532vzS1EJ/x6alTz/C/jMnekWUtvJDkzMv7/SXQ9u5ZZEp82UdFSTNiK1YL32
	TY4q0amPdUSSekakjK0t8AcfjkYW0mIJQAl0jK/HYX/RTOcaDuSTMs/8rP334tw6Iae0vBkEc0f
	xRI60zLvJCAltUVkk39S6RFr65RVD2IgrUPOJLAQSHUKQFbrc6tfaAXcbFjmjJ6FvfomtlFwBPb
	Mgqe
X-Google-Smtp-Source: AGHT+IFkZu5C0h2sbZOiZRIaZuOCtAXNGDMgH12fsdQqjcZgjRt6MoD0p4jbpPqOpgH8L01J3EEzPA==
X-Received: by 2002:a5d:5f85:0:b0:385:edd1:2245 with SMTP id ffacd0b85a97d-385fd3e698fmr1516635f8f.30.1733224413258;
        Tue, 03 Dec 2024 03:13:33 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e0117069sm11794315f8f.60.2024.12.03.03.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:13:32 -0800 (PST)
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
Subject: [PATCH 02/14] iio: adc: rzg2l_adc: Use devres helpers to request pre-deasserted reset controls
Date: Tue,  3 Dec 2024 13:13:02 +0200
Message-Id: <20241203111314.2420473-3-claudiu.beznea.uj@bp.renesas.com>
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

Starting with commit d872bed85036 ("reset: Add devres helpers to request
pre-deasserted reset controls"), devres helpers are available to simplify
the process of requesting pre-deasserted reset controls. Update the
rzg2l_adc driver to utilize these helpers, reducing complexity in this
way.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 37 ++-----------------------------------
 1 file changed, 2 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index cd3a7e46ea53..7039949a7554 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -415,11 +415,6 @@ static void rzg2l_adc_pm_runtime_set_suspended(void *data)
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
@@ -456,46 +451,18 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 		return PTR_ERR(adc->adclk);
 	}
 
-	adc->adrstn = devm_reset_control_get_exclusive(dev, "adrst-n");
+	adc->adrstn = devm_reset_control_get_exclusive_deasserted(dev, "adrst-n");
 	if (IS_ERR(adc->adrstn)) {
 		dev_err(dev, "failed to get adrstn\n");
 		return PTR_ERR(adc->adrstn);
 	}
 
-	adc->presetn = devm_reset_control_get_exclusive(dev, "presetn");
+	adc->presetn = devm_reset_control_get_exclusive_deasserted(dev, "presetn");
 	if (IS_ERR(adc->presetn)) {
 		dev_err(dev, "failed to get presetn\n");
 		return PTR_ERR(adc->presetn);
 	}
 
-	ret = reset_control_deassert(adc->adrstn);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to deassert adrstn pin, %d\n", ret);
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(&pdev->dev,
-				       rzg2l_adc_reset_assert, adc->adrstn);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register adrstn assert devm action, %d\n",
-			ret);
-		return ret;
-	}
-
-	ret = reset_control_deassert(adc->presetn);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to deassert presetn pin, %d\n", ret);
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(&pdev->dev,
-				       rzg2l_adc_reset_assert, adc->presetn);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register presetn assert devm action, %d\n",
-			ret);
-		return ret;
-	}
-
 	ret = rzg2l_adc_hw_init(adc);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to initialize ADC HW, %d\n", ret);
-- 
2.39.2


