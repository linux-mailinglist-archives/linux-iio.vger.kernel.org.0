Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADA91A7967
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 13:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439103AbgDNL23 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 07:28:29 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39850 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729545AbgDNL2Y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Apr 2020 07:28:24 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jOJjh-00088x-7p; Tue, 14 Apr 2020 13:28:13 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        heiko@sntech.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        xxm@rock-chips.com, kever.yang@rock-chips.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH v4 1/2] iio: adc: rockchip_saradc: move all of probe to devm-functions
Date:   Tue, 14 Apr 2020 13:27:55 +0200
Message-Id: <20200414112756.3015153-1-heiko@sntech.de>
X-Mailer: git-send-email 2.24.1
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
changes in v4:
- new patch as suggested by Jonathan

 drivers/iio/adc/rockchip_saradc.c | 37 ++++++++++++++++---------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 582ba047c4a6..270eb7e83823 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -193,6 +193,15 @@ static void rockchip_saradc_reset_controller(struct reset_control *reset)
 	reset_control_deassert(reset);
 }
 
+static void rockchip_saradc_disable(void *data)
+{
+	struct rockchip_saradc *info = data;
+
+	clk_disable_unprepare(info->clk);
+	clk_disable_unprepare(info->pclk);
+	regulator_disable(info->vref);
+}
+
 static int rockchip_saradc_probe(struct platform_device *pdev)
 {
 	struct rockchip_saradc *info = NULL;
@@ -304,6 +313,14 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 		goto err_pclk;
 	}
 
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       rockchip_saradc_disable, info);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register devm action, %d\n",
+			ret);
+		return ret;
+	}
+
 	platform_set_drvdata(pdev, indio_dev);
 
 	indio_dev->name = dev_name(&pdev->dev);
@@ -315,14 +332,12 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	indio_dev->channels = info->data->channels;
 	indio_dev->num_channels = info->data->num_channels;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
 	if (ret)
-		goto err_clk;
+		return ret;
 
 	return 0;
 
-err_clk:
-	clk_disable_unprepare(info->clk);
 err_pclk:
 	clk_disable_unprepare(info->pclk);
 err_reg_voltage:
@@ -330,19 +345,6 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int rockchip_saradc_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct rockchip_saradc *info = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	clk_disable_unprepare(info->clk);
-	clk_disable_unprepare(info->pclk);
-	regulator_disable(info->vref);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int rockchip_saradc_suspend(struct device *dev)
 {
@@ -383,7 +385,6 @@ static SIMPLE_DEV_PM_OPS(rockchip_saradc_pm_ops,
 
 static struct platform_driver rockchip_saradc_driver = {
 	.probe		= rockchip_saradc_probe,
-	.remove		= rockchip_saradc_remove,
 	.driver		= {
 		.name	= "rockchip-saradc",
 		.of_match_table = rockchip_saradc_match,
-- 
2.24.1

