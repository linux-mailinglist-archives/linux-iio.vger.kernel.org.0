Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBAD206869
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jun 2020 01:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388045AbgFWXaX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Jun 2020 19:30:23 -0400
Received: from gloria.sntech.de ([185.11.138.130]:60784 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387818AbgFWXaW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Jun 2020 19:30:22 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jnsMp-0002Nq-CX; Wed, 24 Jun 2020 01:30:15 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        heiko@sntech.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        xxm@rock-chips.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH v6 1/3] iio: adc: rockchip_saradc: move all of probe to devm-functions
Date:   Wed, 24 Jun 2020 01:30:09 +0200
Message-Id: <20200623233011.2319035-1-heiko@sntech.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

Parts of the saradc probe rely on devm functions and later parts do not.
This makes it more difficult to for example enable triggers via their
devm-functions and would need more undo-work in remove.

So to make life easier for the driver, move the rest of probe calls
also to their devm-equivalents.

This includes moving the clk- and regulator-disabling to a devm_action
so that they gets disabled both during remove and in the error case
in probe, after the action is registered.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
changes in v6:
- move devm actions into separate functions as suggested by Jonathan
changes in v5:
- none
changes in v4:
- new patch as suggested by Jonathan

 drivers/iio/adc/rockchip_saradc.c | 72 ++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 582ba047c4a6..1a7990d60f9f 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -193,6 +193,27 @@ static void rockchip_saradc_reset_controller(struct reset_control *reset)
 	reset_control_deassert(reset);
 }
 
+static void rockchip_saradc_clk_disable(void *data)
+{
+	struct rockchip_saradc *info = data;
+
+	clk_disable_unprepare(info->clk);
+}
+
+static void rockchip_saradc_pclk_disable(void *data)
+{
+	struct rockchip_saradc *info = data;
+
+	clk_disable_unprepare(info->pclk);
+}
+
+static void rockchip_saradc_regulator_disable(void *data)
+{
+	struct rockchip_saradc *info = data;
+
+	regulator_disable(info->vref);
+}
+
 static int rockchip_saradc_probe(struct platform_device *pdev)
 {
 	struct rockchip_saradc *info = NULL;
@@ -291,17 +312,38 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to enable vref regulator\n");
 		return ret;
 	}
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       rockchip_saradc_regulator_disable, info);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register devm action, %d\n",
+			ret);
+		return ret;
+	}
 
 	ret = clk_prepare_enable(info->pclk);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to enable pclk\n");
-		goto err_reg_voltage;
+		return ret;
+	}
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       rockchip_saradc_pclk_disable, info);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register devm action, %d\n",
+			ret);
+		return ret;
 	}
 
 	ret = clk_prepare_enable(info->clk);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to enable converter clock\n");
-		goto err_pclk;
+		return ret;
+	}
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       rockchip_saradc_clk_disable, info);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register devm action, %d\n",
+			ret);
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, indio_dev);
@@ -315,30 +357,9 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	indio_dev->channels = info->data->channels;
 	indio_dev->num_channels = info->data->num_channels;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
 	if (ret)
-		goto err_clk;
-
-	return 0;
-
-err_clk:
-	clk_disable_unprepare(info->clk);
-err_pclk:
-	clk_disable_unprepare(info->pclk);
-err_reg_voltage:
-	regulator_disable(info->vref);
-	return ret;
-}
-
-static int rockchip_saradc_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct rockchip_saradc *info = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	clk_disable_unprepare(info->clk);
-	clk_disable_unprepare(info->pclk);
-	regulator_disable(info->vref);
+		return ret;
 
 	return 0;
 }
@@ -383,7 +404,6 @@ static SIMPLE_DEV_PM_OPS(rockchip_saradc_pm_ops,
 
 static struct platform_driver rockchip_saradc_driver = {
 	.probe		= rockchip_saradc_probe,
-	.remove		= rockchip_saradc_remove,
 	.driver		= {
 		.name	= "rockchip-saradc",
 		.of_match_table = rockchip_saradc_match,
-- 
2.26.2

