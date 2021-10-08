Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDB04270C5
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 20:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241720AbhJHSb5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 14:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240503AbhJHSbj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Oct 2021 14:31:39 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7833AC061772
        for <linux-iio@vger.kernel.org>; Fri,  8 Oct 2021 11:29:42 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 77so9157845qkh.6
        for <linux-iio@vger.kernel.org>; Fri, 08 Oct 2021 11:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=KaxjXbd9QQSyixl6jirzIzQXQmAG5ig/YyofwUGoqJs=;
        b=lzNTFLJPpoogk80sZ/3rmnYg4rO0rXz9eujeKVyD5GBfr8zGvrbdQXP/BNoBxeBC7Q
         EPVe98Sv9fnzBcsSx3y6eZvxDC/hn++qy9z6J6R18I6omjoV2Ip/dzlTObXftarGMvCx
         8qtNHdFJxpJysOgDfCOoX7+5oPDFlV3cv6cObUAqP2D9maxgbBk/tXk1XfM2yBjDV4Cy
         wj6C6VPXvakWTETDNadFJZBo2X8V+OrplQ1tJL9Mk+WUs34tZ1uBqDmd0Eh87rFQoI69
         M4jjAoCP0RLsZWJp6ch8839vvifEEzf/uho7n8crdcIzOyRtPAYXMhcedkrxb0sVGAjq
         W83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=KaxjXbd9QQSyixl6jirzIzQXQmAG5ig/YyofwUGoqJs=;
        b=snlAsdN1869VxN7OaFoG9Z2RPRSoCBSVbA1NrVm7qlLtN4O7ULDPrf7xlj/DiCSJQL
         oQgDd8FT3pu0yUwdaGTVHE1GUORBjx6bPXfOkO29QC8E8ccbGK9NQQvwoZaF3h15KtU4
         3JF6I7+fISiP5tdS8rJn/pWxgpf+JopnfuqRKD7RoWFiBcdYCVXJgVrYq3O7FqhJ6l0j
         ELFOHhO+FAeEScgakWZZrLj0keCNKXXYhE1p251ANBezOkOjkWafhCHoPGbivPgpfzkF
         Czs2ddxdEDPPFdyn+pIHrf/Abewn2VHyYLdL/6uDRmQBMGlEmcv4v59H4sf2qUSxGlBy
         FJmA==
X-Gm-Message-State: AOAM53368G7LoTTRNQqhZWJlSXGRPJQppdQ6/aym/X3IxFHiUVtB/fks
        UqgLuuBDsOwuA0J7dtpkT7RNQK1fKtzL5A==
X-Google-Smtp-Source: ABdhPJxwHAzMsk4VqiWbdqFduWB/UvyzsE2IlMScFKDx9IOlkQ4AaN81iW+sLbOe0BjtCKsl8LxFEw==
X-Received: by 2002:a05:620a:29c6:: with SMTP id s6mr3233300qkp.233.1633717781593;
        Fri, 08 Oct 2021 11:29:41 -0700 (PDT)
Received: from Andryuu.br ([2804:431:c7fd:e4dc:3e3e:a653:b135:3239])
        by smtp.gmail.com with ESMTPSA id x18sm116594qkx.94.2021.10.08.11.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 11:29:41 -0700 (PDT)
Date:   Fri, 8 Oct 2021 15:29:37 -0300
From:   =?iso-8859-1?Q?Andr=E9?= Gustavo Nakagomi Lopez <andregnl@usp.br>
To:     jic23@kernel.org, lars@metafoo.de, vz@mleia.com
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, andregnl@usp.br
Subject: [PATCH] iio: adc: lpc18xx_adc: Convert probe to device managed
 version
Message-ID: <YWCOERbPXRrvaRN8@Andryuu.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The remove function and the goto sections are not necessary if devm
functions are used.

Convert device register to devm version. Add hook functions to release
device resources, and use them inside probe with devm_add_action,
which will release resources on driver detach.

To maintain the order of which device resources were released/reseted,
register the hook functions as soon as resources are obtained/initialized.
Since devres actions are called on driver detach, the remove
function and the error-handling goto sections are no longer necessary.

Signed-off-by: André Gustavo Nakagomi Lopez <andregnl@usp.br>
---
I was not able to test the patch due to the fact I do not have the necessary hardware.
 drivers/iio/adc/lpc18xx_adc.c | 60 +++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/adc/lpc18xx_adc.c b/drivers/iio/adc/lpc18xx_adc.c
index 3566990ae87d..7b6ba5e4a003 100644
--- a/drivers/iio/adc/lpc18xx_adc.c
+++ b/drivers/iio/adc/lpc18xx_adc.c
@@ -115,6 +115,23 @@ static const struct iio_info lpc18xx_adc_info = {
 	.read_raw = lpc18xx_adc_read_raw,
 };
 
+static void lpc18xx_writel(void *data)
+{
+	struct lpc18xx_adc *adc = data;
+
+	writel(0, adc->base + LPC18XX_ADC_CR);
+}
+
+static void lpc18xx_clk_disable_unprepare(void *clk)
+{
+	clk_disable_unprepare(clk);
+}
+
+static void lpc18xx_regulator_disable(void *vref)
+{
+	regulator_disable(vref);
+}
+
 static int lpc18xx_adc_probe(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev;
@@ -163,46 +180,36 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(&pdev->dev, lpc18xx_regulator_disable, adc->vref);
+	if (ret)
+		return ret;
+
 	ret = clk_prepare_enable(adc->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to enable clock\n");
-		goto dis_reg;
+		return ret;
 	}
 
+	ret = devm_add_action_or_reset(&pdev->dev, lpc18xx_clk_disable_unprepare,
+				       adc->clk);
+	if (ret)
+		return ret;
+
 	adc->cr_reg = (clkdiv << LPC18XX_ADC_CR_CLKDIV_SHIFT) |
 			LPC18XX_ADC_CR_PDN;
 	writel(adc->cr_reg, adc->base + LPC18XX_ADC_CR);
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to register device\n");
-		goto dis_clk;
-	}
+	ret = devm_add_action_or_reset(&pdev->dev, lpc18xx_writel, adc);
+	if (ret)
+		return ret;
 
-	return 0;
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
+	if (ret)
+		dev_err(&pdev->dev, "unable to register device\n");
 
-dis_clk:
-	writel(0, adc->base + LPC18XX_ADC_CR);
-	clk_disable_unprepare(adc->clk);
-dis_reg:
-	regulator_disable(adc->vref);
 	return ret;
 }
 
-static int lpc18xx_adc_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct lpc18xx_adc *adc = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-
-	writel(0, adc->base + LPC18XX_ADC_CR);
-	clk_disable_unprepare(adc->clk);
-	regulator_disable(adc->vref);
-
-	return 0;
-}
-
 static const struct of_device_id lpc18xx_adc_match[] = {
 	{ .compatible = "nxp,lpc1850-adc" },
 	{ /* sentinel */ }
@@ -211,7 +218,6 @@ MODULE_DEVICE_TABLE(of, lpc18xx_adc_match);
 
 static struct platform_driver lpc18xx_adc_driver = {
 	.probe	= lpc18xx_adc_probe,
-	.remove	= lpc18xx_adc_remove,
 	.driver	= {
 		.name = "lpc18xx-adc",
 		.of_match_table = lpc18xx_adc_match,
-- 
2.33.0

