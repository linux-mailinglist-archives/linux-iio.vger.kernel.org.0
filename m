Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC4F3B3DD8
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jun 2021 09:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhFYHqZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Jun 2021 03:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhFYHqZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Jun 2021 03:46:25 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3420EC061756
        for <linux-iio@vger.kernel.org>; Fri, 25 Jun 2021 00:44:04 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i24so12141494edx.4
        for <linux-iio@vger.kernel.org>; Fri, 25 Jun 2021 00:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0oSVleYVjbJ0iAd6D04N2IadYoidHNoFrcmT8l8IGEo=;
        b=IgOpAYl4F5RE1hLnxr9LfWgzygYiRzQBELuycEavw1ixs6p97ue1GFZT/FxYEzVgnZ
         OTsIuRuGjw+007BDnex5YYxdiaEC0DfkoELnJWqGOUf3/CRtOC1JiJvwk5+Gw6GLjKPa
         hB9ZolGEptFiB2gGRkLyu79fBFwDHemb7FlU4jEWVDxIW+pOSFN5rfvV23bI5QXzmO3d
         y2Krzh9QYLPX7Vw3NocUywZv6hSIYOJVoolAinGp8OEcgIYS7nSfPUhgRG+d7lbz8buF
         dc4Crl+vYALtYWx3Fqtoyz0K2liU6xh6BA5ScqFpfuT9hBihSeGYJa1NIRvqVBM1uSYN
         UPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0oSVleYVjbJ0iAd6D04N2IadYoidHNoFrcmT8l8IGEo=;
        b=lgsXh1ZixzFe0ricUia6BpHgPSzpY4mWECwMA8A/KJrUJZvOGi+h5XpR1QW6TGAfPq
         dD6pnR4UqjSgSY/u0tWrnmdwz+wzb+auxTwsEETct/ZXaDgvmv5+GOPGY9fgCLnN4/Wq
         rVXhCaI6u/sJ1QnQpJs2P5IhkC6ezmAfzk4KCAm3UELCOgzw4bsjS7oTcob7xN7BjSC4
         /5lJNer69gO5L3CmABUdekLjUrUpUFT5uF4UQs8HqswHo423+XbsY4ToVn3x2GbL4u55
         aZnTV6ycG8kWzHUfRay0EPu0ppXUy8+zmB8+ut58FtmgoZi8WWUH547MJRSOB0ORmdtC
         vNdA==
X-Gm-Message-State: AOAM532rND/t/t+qADsWWb18KMQTIwTC6aI64NErOETSaQJmyoHeYD06
        KBmZwojTqndI2iStY/sR5eGILnlV9Q4iNJmpLeo=
X-Google-Smtp-Source: ABdhPJyYrBWE8qukWNfXA7mG/1kJPWEPVuNcDjy9Vqsju5EwUDJS9aU+F2sWtVIhyKHPk6mtpjdkOg==
X-Received: by 2002:a05:6402:120b:: with SMTP id c11mr12832968edw.209.1624607042538;
        Fri, 25 Jun 2021 00:44:02 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id x17sm3472471edr.88.2021.06.25.00.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 00:44:02 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] iio: adc: fsl-imx25-gcq: initialize regulators as needed
Date:   Fri, 25 Jun 2021 10:43:25 +0300
Message-Id: <20210625074325.9237-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver tries to initialize all possible regulators from the DT, then
match the external regulators with each channel and then release all unused
regulators.

We can change the logic a bit to initialize regulators only when at least
one channel needs them.

This change creates a mx25_gcq_ext_regulator_setup() function that is
called only for the external regulators. If there's already a reference to
an external regulator, the function will just exit early with no error.

This way, the driver doesn't need to keep any track of these regulators
during init.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/fsl-imx25-gcq.c | 57 ++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
index ab5139e911c3..31776f80f847 100644
--- a/drivers/iio/adc/fsl-imx25-gcq.c
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -172,13 +172,37 @@ static const struct regmap_config mx25_gcq_regconfig = {
 	.reg_stride = 4,
 };
 
+static int mx25_gcq_ext_regulator_setup(struct device *dev,
+					struct mx25_gcq_priv *priv, u32 refp)
+{
+	char reg_name[12];
+	int ret;
+
+	if (priv->vref[refp])
+		return 0;
+
+	ret = snprintf(reg_name, sizeof(reg_name), "vref-%s",
+		       mx25_gcq_refp_names[refp]);
+	if (ret < 0)
+		return ret;
+
+	priv->vref[refp] = devm_regulator_get_optional(dev, reg_name);
+	if (IS_ERR(priv->vref[refp])) {
+		dev_err(dev,
+			"Error, trying to use external voltage reference without a %s regulator.",
+			reg_name);
+		return PTR_ERR(priv->vref[refp]);
+	}
+
+	return 0;
+}
+
 static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 			       struct mx25_gcq_priv *priv)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *child;
 	struct device *dev = &pdev->dev;
-	unsigned int refp_used[4] = {};
 	int ret, i;
 
 	/*
@@ -194,19 +218,6 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 			     MX25_ADCQ_CFG_IN(i) |
 			     MX25_ADCQ_CFG_REFN_NGND2);
 
-	/*
-	 * First get all regulators to store them in channel_vref_mv if
-	 * necessary. Later we use that information for proper IIO scale
-	 * information.
-	 */
-	priv->vref[MX25_ADC_REFP_INT] = NULL;
-	priv->vref[MX25_ADC_REFP_EXT] =
-		devm_regulator_get_optional(&pdev->dev, "vref-ext");
-	priv->vref[MX25_ADC_REFP_XP] =
-		devm_regulator_get_optional(&pdev->dev, "vref-xp");
-	priv->vref[MX25_ADC_REFP_YP] =
-		devm_regulator_get_optional(&pdev->dev, "vref-yp");
-
 	for_each_child_of_node(np, child) {
 		u32 reg;
 		u32 refp = MX25_ADCQ_CFG_REFP_INT;
@@ -233,11 +244,10 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 		case MX25_ADC_REFP_EXT:
 		case MX25_ADC_REFP_XP:
 		case MX25_ADC_REFP_YP:
-			if (IS_ERR(priv->vref[refp])) {
-				dev_err(dev, "Error, trying to use external voltage reference without a vref-%s regulator.",
-					mx25_gcq_refp_names[refp]);
+			ret = mx25_gcq_ext_regulator_setup(&pdev->dev, priv, refp);
+			if (ret) {
 				of_node_put(child);
-				return PTR_ERR(priv->vref[refp]);
+				return ret;
 			}
 			priv->channel_vref_mv[reg] =
 				regulator_get_voltage(priv->vref[refp]);
@@ -253,8 +263,6 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 			return -EINVAL;
 		}
 
-		++refp_used[refp];
-
 		/*
 		 * Shift the read values to the correct positions within the
 		 * register.
@@ -285,15 +293,6 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 	regmap_write(priv->regs, MX25_ADCQ_CR,
 		     MX25_ADCQ_CR_PDMSK | MX25_ADCQ_CR_QSM_FQS);
 
-	/* Remove unused regulators */
-	for (i = 0; i != 4; ++i) {
-		if (!refp_used[i]) {
-			if (!IS_ERR_OR_NULL(priv->vref[i]))
-				devm_regulator_put(priv->vref[i]);
-			priv->vref[i] = NULL;
-		}
-	}
-
 	return 0;
 }
 
-- 
2.31.1

