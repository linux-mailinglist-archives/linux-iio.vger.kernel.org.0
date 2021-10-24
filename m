Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A575E438BAC
	for <lists+linux-iio@lfdr.de>; Sun, 24 Oct 2021 21:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhJXTqH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Oct 2021 15:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhJXTqG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Oct 2021 15:46:06 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E373C061745
        for <linux-iio@vger.kernel.org>; Sun, 24 Oct 2021 12:43:45 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id y11so8452272qtn.13
        for <linux-iio@vger.kernel.org>; Sun, 24 Oct 2021 12:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=4T1h/6MdNJIw0PPm4TEcxKFEMqXNYmxYZcwSKomTJoU=;
        b=ePhq4DD4vYJwbaIb2ECaxBpkPV3hzJPWQgjoe7AdGOK3R4UGX8PSPO3cv2JFLhDOiv
         w0qhRX0w1yx+rZZIvnzMzcwt7DrgPafaVbOFK5klrrt7G6r87ZwbQauhYcmKPRJXZld5
         fY9qQIxW2x+kqN0VfxP5OtYplUJJgdnvmhiSsRw/8+Owju8F+gkcHZwX74EwazMBKWda
         N2Vp/UENJxPzlHYnDi5X7dzbEq986OQyPekwx+/0XQLrJGJ7disE5iq5ce8TyjIZUdRW
         dXZjWwynf6Z3OEjm1jIHox8dtAAR9IdaqZ61VZElFQLT4RvVq8TLfKE+OehmVotgadpB
         cc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=4T1h/6MdNJIw0PPm4TEcxKFEMqXNYmxYZcwSKomTJoU=;
        b=Y+Ejbu0P4BLUD8CcQYRu++mRBlxRhV58wNehdQGjYJAY3XanGoCKweJzdgFIpzVq0G
         iI4b8lDTGqImVhSGjI1TlmMD44Ja9iZfrz7QyQj95e5+cYDbyK84FhH6dmemp+DUgR0x
         kGzQZf9KsMHh+x3ZJ6nNjJ7BeIk4owh+yTk/Td91B2aoTJ1ycTdlMAKUwkMUhIBIItLM
         46L+QhCAuNP/WKr5tGyILAU4UqxwTEm8orQJhFj5zXWsqv8POZtgU9bZDK3OHjWXDtzm
         JtkqsgBhBTLyiK5wi+ec461OV3NktvsE9q8B/pL6q0pGO54a55R0MKURWxENO+bqJb27
         Pl4Q==
X-Gm-Message-State: AOAM533lwYmk2SnDdo1fMI4LLdhoaZGWbEK6SkIp/9rv76hSwzBsNmvx
        95BwLjAJ2A4p/ze/Bm1tdviNFg==
X-Google-Smtp-Source: ABdhPJyj4j7EzR6DsNeSrBj8n/XeKi48Tc9FcFD/6edaoTvrtJRsPP7TBfb4OJGLA68gn5La79/o3Q==
X-Received: by 2002:ac8:58d3:: with SMTP id u19mr13440124qta.29.1635104624242;
        Sun, 24 Oct 2021 12:43:44 -0700 (PDT)
Received: from Andryuu.br ([2804:431:c7fd:423:9dac:f639:6086:598])
        by smtp.gmail.com with ESMTPSA id m66sm7521178qkb.87.2021.10.24.12.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 12:43:43 -0700 (PDT)
Date:   Sun, 24 Oct 2021 16:43:39 -0300
From:   =?iso-8859-1?Q?Andr=E9?= Gustavo Nakagomi Lopez <andregnl@usp.br>
To:     jic23@kernel.org, lars@metafoo.de, vz@mleia.com
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, andregnl@usp.br
Subject: [PATCH] iio: adc: lpc18xx_adc: Reorder clk_get_rate function call
Message-ID: <YXW3azIjPzGjvjTX@Andryuu.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

clk_get_rate is not garanteed to work if called before clk_prepare_enable.

Reorder clk_get_rate, so it's called after clk_prepare_enable and
after devm_add_action_or_reset of lpc18xx_clk_disable.

Signed-off-by: André Gustavo Nakagomi Lopez <andregnl@usp.br>
---
 drivers/iio/adc/lpc18xx_adc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/lpc18xx_adc.c b/drivers/iio/adc/lpc18xx_adc.c
index ceefa4d793cf..ae9c9384f23e 100644
--- a/drivers/iio/adc/lpc18xx_adc.c
+++ b/drivers/iio/adc/lpc18xx_adc.c
@@ -157,9 +157,6 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(adc->clk),
 				     "error getting clock\n");
 
-	rate = clk_get_rate(adc->clk);
-	clkdiv = DIV_ROUND_UP(rate, LPC18XX_ADC_CLK_TARGET);
-
 	adc->vref = devm_regulator_get(&pdev->dev, "vref");
 	if (IS_ERR(adc->vref))
 		return dev_err_probe(&pdev->dev, PTR_ERR(adc->vref),
@@ -192,6 +189,9 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	rate = clk_get_rate(adc->clk);
+	clkdiv = DIV_ROUND_UP(rate, LPC18XX_ADC_CLK_TARGET);
+
 	adc->cr_reg = (clkdiv << LPC18XX_ADC_CR_CLKDIV_SHIFT) |
 			LPC18XX_ADC_CR_PDN;
 	writel(adc->cr_reg, adc->base + LPC18XX_ADC_CR);
-- 
2.33.0

