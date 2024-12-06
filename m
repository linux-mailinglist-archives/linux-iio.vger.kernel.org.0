Return-Path: <linux-iio+bounces-13139-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1E29E6CDD
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 12:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5704E1678C1
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 11:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B327D1FECCB;
	Fri,  6 Dec 2024 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Tpf7fTGG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57491FCF58
	for <linux-iio@vger.kernel.org>; Fri,  6 Dec 2024 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483640; cv=none; b=dk8heOSEaZhLiGRs4GXY31wLFem9xo+VYUPirpneruzW9k4dBwDV4iPh9tHeOe22l/VI8sXsno4biRq3lT8r4AM249m4khVk2Q1+fr05jlzoakHIpVRkeh6/6iV//RhkDwARI0G0nIQob/0q8E4C3H26pxsA5XJnRvzs/h9lgAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483640; c=relaxed/simple;
	bh=SIi46sAJ3akHceZIRoH2XmfFqxFkyS3eT+KqHD6fe7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Du+cRmD+HA20iTFZ2rUsZHXev/lRAGyF8gdaKbZfEnoyIwozQqG30Z9ABb2JhWEJMqj9B3oVkcQEyZBbLi76e5rKN34DaFwlNOpmHgZE4ikpy9xHdwofhaEcQyNWQLfLmX62s0UvUuYQruTAGLSrzQm1t/pBxKlE8fJIwPxZDrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Tpf7fTGG; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa543c4db92so385751466b.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Dec 2024 03:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733483637; x=1734088437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3NK3+VvNXvn4/X99VXMNRx8LERvbPVlsDcIxAPbW7c=;
        b=Tpf7fTGGqWRvvVKmxhqZPhxTHemi3z83lVgludb3y7timQBHx47S1IFFBreNwj8a+/
         hw3hJ4Fk8wtWmIhzg23F6roQOzgpFQKBPldF2BJ4LGVWMpYkwWY3sOy/pe5yfmrZq9Q1
         cpJtjp/fyCa9TZsRgm1oLmLdL1ve/mDRycnBifJDdc25pdsPwyWfJFCKewHMI0BDVdxj
         wjiMZIW5E3u0p/J1pcRYD84XwRr8H4awCv1nl0mTkr6pa1PVJ0EG+U0aIl8r3X66V9fc
         +B1+oPJBfY9viAL65b7No+0gswkJj2RYF4kKzoClpb5oYtGn1wjPtvpwaJN1ASkoJSYA
         2Ngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733483637; x=1734088437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3NK3+VvNXvn4/X99VXMNRx8LERvbPVlsDcIxAPbW7c=;
        b=f+d9SMuK2GoaaK3Dau22rfgplnyI9gckfjn/wGkMgIPWBmOKrJArOmRJY179UcZFYt
         Cg0AbpryCzDgcVeZf9r5XCa3ukPZD+4Oc1urRqL7JMn91w1zW1lkyuQFOBzNQYrGuWJA
         U1vJ8RCErYuwMK/SxOU2BCMbcYkqC4aCp3racy4RYlVtr8L4hpcKHEwKRvZX08BtOgb7
         VlT3SZgDIgOLOVxufJtrWJ34jtNGK+Fsn3wyBc8ZMW1qA1Hsl5AFd4hQFDLtazci0ffu
         B9LuDoCvCrBWMSlIAUpQjnGWbBv+fYFTiCu+P6NDhYf/DP01nZ1NilnePdQ0OC0SAdTm
         ujjg==
X-Forwarded-Encrypted: i=1; AJvYcCUNnd5iEZ/MRl21B01+ofK56Fx+DX8xXRpmyO01kAQ4CHWC025ucoIJ9v5hYX/mFww6vMAxEah3d+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXnusXoIoArneeI8OT2Sbh0h86mt0+mol3NJ8V6x57l7NTU/J2
	fErmoe8+0T4j4iB8Q5qTvvzbVS3GBAmqc8D/pPAEucpNZ0OB1gM9/v02Rr2hkf4=
X-Gm-Gg: ASbGncsBP5m4XV5twV3ifiq6gGgFqSc+aPKamgpxfjwUAxn1bCDJmaWINLfPnXJmegY
	k2DoCfZxGZp+jTZYVMsiZ4XVFmpTWJuZqryH/14Iar8TMvnLkgHEa8pM0JAFGhDHDSmyRS6gE/p
	7LMqjXrEaaksepPUNKZPEXU3nW4wIGBFfQVQvhCRnxpIUNFSwZva5yy8M0KmLkvP/tqeRfVYFLw
	8iq/QjLsjHbUPb2RzVPxGIaIsjq+45zCJHx2Rz0uZE7AzgigqUmMyN3Y1OYVlH2R5OJZupOhlRx
	bBaK
X-Google-Smtp-Source: AGHT+IG5ns28LlIO5EKzt3jy9KG0NXWjALwAdfE48ssUd8bpZB71xSWH7xVctc2Y/hSvsPovXL1IRQ==
X-Received: by 2002:a17:906:3292:b0:aa6:4494:e354 with SMTP id a640c23a62f3a-aa64494e742mr62432466b.42.1733483637032;
        Fri, 06 Dec 2024 03:13:57 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eee2a6sm226877866b.90.2024.12.06.03.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 03:13:56 -0800 (PST)
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
Subject: [PATCH v2 02/15] iio: adc: rzg2l_adc: Convert dev_err() to dev_err_probe()
Date: Fri,  6 Dec 2024 13:13:24 +0200
Message-Id: <20241206111337.726244-3-claudiu.beznea.uj@bp.renesas.com>
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

Convert all occurrences of dev_err() in the probe path to dev_err_probe().
This improves readability and simplifies the code.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none, this patch is new

 drivers/iio/adc/rzg2l_adc.c | 64 +++++++++++++------------------------
 1 file changed, 22 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index cd3a7e46ea53..8a804f81c04b 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -313,15 +313,11 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
 		return -ENOMEM;
 
 	num_channels = device_get_child_node_count(&pdev->dev);
-	if (!num_channels) {
-		dev_err(&pdev->dev, "no channel children\n");
-		return -ENODEV;
-	}
+	if (!num_channels)
+		return dev_err_probe(&pdev->dev, -ENODEV, "no channel children\n");
 
-	if (num_channels > RZG2L_ADC_MAX_CHANNELS) {
-		dev_err(&pdev->dev, "num of channel children out of range\n");
-		return -EINVAL;
-	}
+	if (num_channels > RZG2L_ADC_MAX_CHANNELS)
+		return dev_err_probe(&pdev->dev, -EINVAL, "num of channel children out of range\n");
 
 	chan_array = devm_kcalloc(&pdev->dev, num_channels, sizeof(*chan_array),
 				  GFP_KERNEL);
@@ -445,62 +441,46 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 		return PTR_ERR(adc->base);
 
 	adc->pclk = devm_clk_get(dev, "pclk");
-	if (IS_ERR(adc->pclk)) {
-		dev_err(dev, "Failed to get pclk");
-		return PTR_ERR(adc->pclk);
-	}
+	if (IS_ERR(adc->pclk))
+		return dev_err_probe(dev, PTR_ERR(adc->pclk), "Failed to get pclk");
 
 	adc->adclk = devm_clk_get(dev, "adclk");
-	if (IS_ERR(adc->adclk)) {
-		dev_err(dev, "Failed to get adclk");
-		return PTR_ERR(adc->adclk);
-	}
+	if (IS_ERR(adc->adclk))
+		return dev_err_probe(dev, PTR_ERR(adc->adclk), "Failed to get adclk");
 
 	adc->adrstn = devm_reset_control_get_exclusive(dev, "adrst-n");
-	if (IS_ERR(adc->adrstn)) {
-		dev_err(dev, "failed to get adrstn\n");
-		return PTR_ERR(adc->adrstn);
-	}
+	if (IS_ERR(adc->adrstn))
+		return dev_err_probe(dev, PTR_ERR(adc->adrstn), "failed to get adrstn\n");
 
 	adc->presetn = devm_reset_control_get_exclusive(dev, "presetn");
-	if (IS_ERR(adc->presetn)) {
-		dev_err(dev, "failed to get presetn\n");
-		return PTR_ERR(adc->presetn);
-	}
+	if (IS_ERR(adc->presetn))
+		return dev_err_probe(dev, PTR_ERR(adc->presetn), "failed to get presetn\n");
 
 	ret = reset_control_deassert(adc->adrstn);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to deassert adrstn pin, %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to deassert adrstn pin, %d\n", ret);
 
 	ret = devm_add_action_or_reset(&pdev->dev,
 				       rzg2l_adc_reset_assert, adc->adrstn);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register adrstn assert devm action, %d\n",
-			ret);
-		return ret;
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to register adrstn assert devm action, %d\n", ret);
 	}
 
 	ret = reset_control_deassert(adc->presetn);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to deassert presetn pin, %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to deassert presetn pin, %d\n", ret);
 
 	ret = devm_add_action_or_reset(&pdev->dev,
 				       rzg2l_adc_reset_assert, adc->presetn);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register presetn assert devm action, %d\n",
-			ret);
-		return ret;
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to register presetn assert devm action, %d\n", ret);
 	}
 
 	ret = rzg2l_adc_hw_init(adc);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to initialize ADC HW, %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to initialize ADC HW, %d\n", ret);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-- 
2.39.2


