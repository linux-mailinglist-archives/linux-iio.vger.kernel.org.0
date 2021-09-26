Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8300418AC2
	for <lists+linux-iio@lfdr.de>; Sun, 26 Sep 2021 21:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhIZT21 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Sep 2021 15:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhIZT21 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Sep 2021 15:28:27 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65800C061570
        for <linux-iio@vger.kernel.org>; Sun, 26 Sep 2021 12:26:50 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id l8so12182884edw.2
        for <linux-iio@vger.kernel.org>; Sun, 26 Sep 2021 12:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MjFc4qpdSBS8qeywuUDP1DYg3DGmfu9tyeJ/HZHA26w=;
        b=URLhrsBbVcZzrEKxtP+L1BeVdakxp6+4O7NCymsdQvAbchVWa/q1imWa0N740vjQKj
         ZMahEITTJPS3s3c8TiLmHK9E69KHzY3e6vWd6OB75fi4NkUcpo7tEiklYKTegyAJcyjI
         LQRAeOeGoK7vMluCr5XuZoCdTfPpJ320ijXF9Tgw6Gb+vSFYw3JPojaS+5VVEuNyV4rv
         ZJ4yxtrm+4t3TERQ7ycDf2jy2OI01JtWorlgevP8hOejejgZ72HCslpsOtaDRLxAvsey
         psDEzso1M8D2a7u6lwLNJmEaBAJFS5cSUFe3Cf+UsITe0Mx0oYAHKQEwtz1XmNLI3Xqy
         TN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MjFc4qpdSBS8qeywuUDP1DYg3DGmfu9tyeJ/HZHA26w=;
        b=brL9n6vau+U00lRRTKCBpFoNzT+l25wlq/vCjO+jNDaubdVc+duhXs65EjzEVKFzU5
         EhRRPB6F3koaYEDYLiotg5Cw4YmfrDNwBDFIN9/0xszhvNbaqkq8F7VGthaLE8lMnxAR
         YFCTpwx8fDDKXXNZtsKiA64I49hYx4LFn8y7BghHjRBWq/onIoL7j+uU2nr7WgSluNzB
         Ppy3VVrLY9y1X1R3T4H5wrUOOw/WIZ3A+JwfCq04oSRUL9Nw1w/YzxIQFmNGaVnI0nKA
         vGYv9lQ/3FnZCnGlT6mVByyo2Nu0WZX+L4dj4lYsnBJjtj1mPj9n/TSU1UyWSkFhsyH2
         IdPg==
X-Gm-Message-State: AOAM531KQY5qfDVMKNfYQevEroIX5kiKcH792oeuQejLTcxANwPMnrzE
        GAodFeBBJD7RTTnZGeBdP4cM95TutNLprA==
X-Google-Smtp-Source: ABdhPJz+wRgSGku9dd+vBllmqVI0rc2Rbxy2N4TLILRmNl6CW9Rdash0m8SMy9tRPXCs+nSzRE3ArA==
X-Received: by 2002:a05:6402:1e88:: with SMTP id f8mr18443735edf.126.1632684409035;
        Sun, 26 Sep 2021 12:26:49 -0700 (PDT)
Received: from neptune.. ([188.27.128.17])
        by smtp.gmail.com with ESMTPSA id z18sm9183078edq.29.2021.09.26.12.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 12:26:48 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 1/2] iio: adc: berlin2-adc: convert probe to device-managed only
Date:   Sun, 26 Sep 2021 22:26:41 +0300
Message-Id: <20210926192642.4051329-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This driver requires only a devm_add_action_or_reset() hook for the
power-down of the device, and then devm_iio_device_register() can be used
directly.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/berlin2-adc.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
index 8b04b95b7b7a..03987d7e6b3d 100644
--- a/drivers/iio/adc/berlin2-adc.c
+++ b/drivers/iio/adc/berlin2-adc.c
@@ -280,6 +280,13 @@ static const struct iio_info berlin2_adc_info = {
 	.read_raw	= berlin2_adc_read_raw,
 };
 
+static void berlin2_adc_powerdown(void *regmap)
+{
+	regmap_update_bits(regmap, BERLIN2_SM_CTRL,
+			   BERLIN2_SM_CTRL_ADC_POWER, 0);
+
+}
+
 static int berlin2_adc_probe(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev;
@@ -293,7 +300,6 @@ static int berlin2_adc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv = iio_priv(indio_dev);
-	platform_set_drvdata(pdev, indio_dev);
 
 	priv->regmap = syscon_node_to_regmap(parent_np);
 	of_node_put(parent_np);
@@ -333,29 +339,12 @@ static int berlin2_adc_probe(struct platform_device *pdev)
 			   BERLIN2_SM_CTRL_ADC_POWER,
 			   BERLIN2_SM_CTRL_ADC_POWER);
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		/* Power down the ADC */
-		regmap_update_bits(priv->regmap, BERLIN2_SM_CTRL,
-				   BERLIN2_SM_CTRL_ADC_POWER, 0);
+	ret = devm_add_action_or_reset(&pdev->dev, berlin2_adc_powerdown,
+				       priv->regmap);
+	if (ret)
 		return ret;
-	}
-
-	return 0;
-}
-
-static int berlin2_adc_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct berlin2_adc_priv *priv = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-
-	/* Power down the ADC */
-	regmap_update_bits(priv->regmap, BERLIN2_SM_CTRL,
-			   BERLIN2_SM_CTRL_ADC_POWER, 0);
 
-	return 0;
+	return devm_iio_device_register(&pdev->dev, indio_dev);
 }
 
 static const struct of_device_id berlin2_adc_match[] = {
@@ -370,7 +359,6 @@ static struct platform_driver berlin2_adc_driver = {
 		.of_match_table	= berlin2_adc_match,
 	},
 	.probe	= berlin2_adc_probe,
-	.remove	= berlin2_adc_remove,
 };
 module_platform_driver(berlin2_adc_driver);
 
-- 
2.31.1

