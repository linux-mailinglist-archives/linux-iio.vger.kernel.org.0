Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3463C58C521
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 10:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbiHHI4j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 04:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238111AbiHHI4K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 04:56:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C0F10CF
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 01:56:08 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKyY7-0007S8-Pp; Mon, 08 Aug 2022 10:55:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKyXy-002Smz-QV; Mon, 08 Aug 2022 10:55:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKyY0-00AJqH-3t; Mon, 08 Aug 2022 10:55:40 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] iio: Make use of devm_clk_get_enabled()
Date:   Mon,  8 Aug 2022 10:55:26 +0200
Message-Id: <20220808085526.280066-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=18154; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=mPhoSLI48zFUej6kOmZiWNmq8wyMyw02z5tdwIZ0sXI=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi8M4EqvVwjVZ38i1TaJqggBb5V+uJvlYAmG3t2iWQ Jo1sPiCJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYvDOBAAKCRDB/BR4rcrsCcFKB/ 9yOpXWkpQdDIlKR68mdjSKCvWN1huguUFzQ8QqeSMsZeaMTMHO22h7mCizW0mmXIhWP4L9s/0AVaSn DA7j92Yh6J4x5Whfj1n7EWCQSWtFeW6Hj9Dxw+34PhvUsF2jHcs8q0uzWvOcmX4SJ+VzaIwOraM13f KKoSrLEjTIzuK2B4TV1lQIhZGKyaKx+o7ijC/T7BuxRN8N3dlY/qUXB9gAbrgmTsvJX1F0zBnsni2F m9AF27AWrzoHn+o67lB1C29ZfHHBm4otb0MgwK/FbGzzl2z0J3N0fiD5RXqj1Ja9VvrqODmuL/E8oX jNoWC+LJvdPuizA9+bFrRpWN10LFLy
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Several drivers manually register a devm handler to disable their clk.
Convert them to devm_clk_get_enabled().

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

previously this patch was an example to show the benefits of adding
devm_clk_get_enabled() and its variants. Last submission was on 14 Mar
2022
(https://lore.kernel.org/all/20220314141643.22184-5-u.kleine-koenig@pengutronix.de).

This patch obviously depends on

        7ef9651e9792 clk: Provide new devm_clk helpers for prepared and enabled clocks

and to actually work needs

        8b3d743fc9e2 clk: Fix pointer casting to prevent oops in devm_clk_release()

which are both in Linus' tree now and should be included in the upcoming
-rc1.

Best regards
Uwe

 drivers/iio/adc/ad7124.c           | 15 +---------
 drivers/iio/adc/ad7768-1.c         | 17 +-----------
 drivers/iio/adc/ad9467.c           | 17 +-----------
 drivers/iio/adc/ingenic-adc.c      | 15 ++--------
 drivers/iio/adc/lpc18xx_adc.c      | 18 +-----------
 drivers/iio/adc/rockchip_saradc.c  | 44 ++----------------------------
 drivers/iio/adc/ti-ads131e08.c     | 19 +------------
 drivers/iio/adc/xilinx-ams.c       | 15 +---------
 drivers/iio/adc/xilinx-xadc-core.c | 18 +-----------
 drivers/iio/frequency/adf4371.c    | 17 +-----------
 drivers/iio/frequency/admv1013.c   | 15 +---------
 drivers/iio/frequency/adrf6780.c   | 16 +----------
 drivers/iio/imu/adis16475.c        | 15 +---------
 13 files changed, 15 insertions(+), 226 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index c5b785d8b241..4088786e1026 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -936,11 +936,6 @@ static void ad7124_reg_disable(void *r)
 	regulator_disable(r);
 }
 
-static void ad7124_clk_disable(void *c)
-{
-	clk_disable_unprepare(c);
-}
-
 static int ad7124_probe(struct spi_device *spi)
 {
 	const struct ad7124_chip_info *info;
@@ -993,18 +988,10 @@ static int ad7124_probe(struct spi_device *spi)
 			return ret;
 	}
 
-	st->mclk = devm_clk_get(&spi->dev, "mclk");
+	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
 	if (IS_ERR(st->mclk))
 		return PTR_ERR(st->mclk);
 
-	ret = clk_prepare_enable(st->mclk);
-	if (ret < 0)
-		return ret;
-
-	ret = devm_add_action_or_reset(&spi->dev, ad7124_clk_disable, st->mclk);
-	if (ret)
-		return ret;
-
 	ret = ad7124_soft_reset(st);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index aa42ba759fa1..8ae34ed8fabd 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -539,13 +539,6 @@ static void ad7768_regulator_disable(void *data)
 	regulator_disable(st->vref);
 }
 
-static void ad7768_clk_disable(void *data)
-{
-	struct ad7768_state *st = data;
-
-	clk_disable_unprepare(st->mclk);
-}
-
 static int ad7768_set_channel_label(struct iio_dev *indio_dev,
 						int num_channels)
 {
@@ -600,18 +593,10 @@ static int ad7768_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	st->mclk = devm_clk_get(&spi->dev, "mclk");
+	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
 	if (IS_ERR(st->mclk))
 		return PTR_ERR(st->mclk);
 
-	ret = clk_prepare_enable(st->mclk);
-	if (ret < 0)
-		return ret;
-
-	ret = devm_add_action_or_reset(&spi->dev, ad7768_clk_disable, st);
-	if (ret)
-		return ret;
-
 	st->mclk_freq = clk_get_rate(st->mclk);
 
 	mutex_init(&st->lock);
diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index dbfc8517cb8a..a07df0fd3329 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -378,13 +378,6 @@ static int ad9467_preenable_setup(struct adi_axi_adc_conv *conv)
 	return ad9467_outputmode_set(st->spi, st->output_mode);
 }
 
-static void ad9467_clk_disable(void *data)
-{
-	struct ad9467_state *st = data;
-
-	clk_disable_unprepare(st->clk);
-}
-
 static int ad9467_probe(struct spi_device *spi)
 {
 	const struct ad9467_chip_info *info;
@@ -404,18 +397,10 @@ static int ad9467_probe(struct spi_device *spi)
 	st = adi_axi_adc_conv_priv(conv);
 	st->spi = spi;
 
-	st->clk = devm_clk_get(&spi->dev, "adc-clk");
+	st->clk = devm_clk_get_enabled(&spi->dev, "adc-clk");
 	if (IS_ERR(st->clk))
 		return PTR_ERR(st->clk);
 
-	ret = clk_prepare_enable(st->clk);
-	if (ret < 0)
-		return ret;
-
-	ret = devm_add_action_or_reset(&spi->dev, ad9467_clk_disable, st);
-	if (ret)
-		return ret;
-
 	st->pwrdown_gpio = devm_gpiod_get_optional(&spi->dev, "powerdown",
 						   GPIOD_OUT_LOW);
 	if (IS_ERR(st->pwrdown_gpio))
diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 2b3912c6ca6b..b6433bcd53f5 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -732,11 +732,6 @@ static int ingenic_adc_of_xlate(struct iio_dev *iio_dev,
 	return -EINVAL;
 }
 
-static void ingenic_adc_clk_cleanup(void *data)
-{
-	clk_unprepare(data);
-}
-
 static const struct iio_info ingenic_adc_info = {
 	.write_raw = ingenic_adc_write_raw,
 	.read_raw = ingenic_adc_read_raw,
@@ -856,13 +851,13 @@ static int ingenic_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(adc->base))
 		return PTR_ERR(adc->base);
 
-	adc->clk = devm_clk_get(dev, "adc");
+	adc->clk = devm_clk_get_prepared(dev, "adc");
 	if (IS_ERR(adc->clk)) {
 		dev_err(dev, "Unable to get clock\n");
 		return PTR_ERR(adc->clk);
 	}
 
-	ret = clk_prepare_enable(adc->clk);
+	ret = clk_enable(adc->clk);
 	if (ret) {
 		dev_err(dev, "Failed to enable clock\n");
 		return ret;
@@ -891,12 +886,6 @@ static int ingenic_adc_probe(struct platform_device *pdev)
 	usleep_range(2000, 3000); /* Must wait at least 2ms. */
 	clk_disable(adc->clk);
 
-	ret = devm_add_action_or_reset(dev, ingenic_adc_clk_cleanup, adc->clk);
-	if (ret) {
-		dev_err(dev, "Unable to add action\n");
-		return ret;
-	}
-
 	iio_dev->name = "jz-adc";
 	iio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
 	iio_dev->setup_ops = &ingenic_buffer_setup_ops;
diff --git a/drivers/iio/adc/lpc18xx_adc.c b/drivers/iio/adc/lpc18xx_adc.c
index ae9c9384f23e..8bbc18aaa474 100644
--- a/drivers/iio/adc/lpc18xx_adc.c
+++ b/drivers/iio/adc/lpc18xx_adc.c
@@ -122,11 +122,6 @@ static void lpc18xx_clear_cr_reg(void *data)
 	writel(0, adc->base + LPC18XX_ADC_CR);
 }
 
-static void lpc18xx_clk_disable(void *clk)
-{
-	clk_disable_unprepare(clk);
-}
-
 static void lpc18xx_regulator_disable(void *vref)
 {
 	regulator_disable(vref);
@@ -152,7 +147,7 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(adc->base))
 		return PTR_ERR(adc->base);
 
-	adc->clk = devm_clk_get(&pdev->dev, NULL);
+	adc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(adc->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(adc->clk),
 				     "error getting clock\n");
@@ -178,17 +173,6 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(adc->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to enable clock\n");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(&pdev->dev, lpc18xx_clk_disable,
-				       adc->clk);
-	if (ret)
-		return ret;
-
 	rate = clk_get_rate(adc->clk);
 	clkdiv = DIV_ROUND_UP(rate, LPC18XX_ADC_CLK_TARGET);
 
diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index b87ea7148b58..db1190faa223 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -233,20 +233,6 @@ static void rockchip_saradc_reset_controller(struct reset_control *reset)
 	reset_control_deassert(reset);
 }
 
-static void rockchip_saradc_clk_disable(void *data)
-{
-	struct rockchip_saradc *info = data;
-
-	clk_disable_unprepare(info->clk);
-}
-
-static void rockchip_saradc_pclk_disable(void *data)
-{
-	struct rockchip_saradc *info = data;
-
-	clk_disable_unprepare(info->pclk);
-}
-
 static void rockchip_saradc_regulator_disable(void *data)
 {
 	struct rockchip_saradc *info = data;
@@ -380,12 +366,12 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	info->pclk = devm_clk_get(&pdev->dev, "apb_pclk");
+	info->pclk = devm_clk_get_enabled(&pdev->dev, "apb_pclk");
 	if (IS_ERR(info->pclk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(info->pclk),
 				     "failed to get pclk\n");
 
-	info->clk = devm_clk_get(&pdev->dev, "saradc");
+	info->clk = devm_clk_get_enabled(&pdev->dev, "saradc");
 	if (IS_ERR(info->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk),
 				     "failed to get adc clock\n");
@@ -427,32 +413,6 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 
 	info->uv_vref = ret;
 
-	ret = clk_prepare_enable(info->pclk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to enable pclk\n");
-		return ret;
-	}
-	ret = devm_add_action_or_reset(&pdev->dev,
-				       rockchip_saradc_pclk_disable, info);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register devm action, %d\n",
-			ret);
-		return ret;
-	}
-
-	ret = clk_prepare_enable(info->clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to enable converter clock\n");
-		return ret;
-	}
-	ret = devm_add_action_or_reset(&pdev->dev,
-				       rockchip_saradc_clk_disable, info);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register devm action, %d\n",
-			ret);
-		return ret;
-	}
-
 	platform_set_drvdata(pdev, indio_dev);
 
 	indio_dev->name = dev_name(&pdev->dev);
diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index 0c2025a22575..7d7a8f0d3ab5 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -793,13 +793,6 @@ static void ads131e08_regulator_disable(void *data)
 	regulator_disable(st->vref_reg);
 }
 
-static void ads131e08_clk_disable(void *data)
-{
-	struct ads131e08_state *st = data;
-
-	clk_disable_unprepare(st->adc_clk);
-}
-
 static int ads131e08_probe(struct spi_device *spi)
 {
 	const struct ads131e08_info *info;
@@ -892,21 +885,11 @@ static int ads131e08_probe(struct spi_device *spi)
 		st->vref_reg = NULL;
 	}
 
-	st->adc_clk = devm_clk_get(&spi->dev, "adc-clk");
+	st->adc_clk = devm_clk_get_enabled(&spi->dev, "adc-clk");
 	if (IS_ERR(st->adc_clk))
 		return dev_err_probe(&spi->dev, PTR_ERR(st->adc_clk),
 				     "failed to get the ADC clock\n");
 
-	ret = clk_prepare_enable(st->adc_clk);
-	if (ret) {
-		dev_err(&spi->dev, "failed to prepare/enable the ADC clock\n");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(&spi->dev, ads131e08_clk_disable, st);
-	if (ret)
-		return ret;
-
 	adc_clk_hz = clk_get_rate(st->adc_clk);
 	if (!adc_clk_hz) {
 		dev_err(&spi->dev, "failed to get the ADC clock rate\n");
diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index a55396c1f8b2..2cab7f0c0633 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -1351,11 +1351,6 @@ static const struct of_device_id ams_of_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, ams_of_match_table);
 
-static void ams_clk_disable_unprepare(void *data)
-{
-	clk_disable_unprepare(data);
-}
-
 static int ams_probe(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev;
@@ -1380,18 +1375,10 @@ static int ams_probe(struct platform_device *pdev)
 	if (IS_ERR(ams->base))
 		return PTR_ERR(ams->base);
 
-	ams->clk = devm_clk_get(&pdev->dev, NULL);
+	ams->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(ams->clk))
 		return PTR_ERR(ams->clk);
 
-	ret = clk_prepare_enable(ams->clk);
-	if (ret < 0)
-		return ret;
-
-	ret = devm_add_action_or_reset(&pdev->dev, ams_clk_disable_unprepare, ams->clk);
-	if (ret < 0)
-		return ret;
-
 	ret = devm_delayed_work_autocancel(&pdev->dev, &ams->ams_unmask_work,
 					   ams_unmask_worker);
 	if (ret < 0)
diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 823c8e5f9809..a520e07e4e08 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1299,13 +1299,6 @@ static const char * const xadc_type_names[] = {
 	[XADC_TYPE_US] = "xilinx-system-monitor",
 };
 
-static void xadc_clk_disable_unprepare(void *data)
-{
-	struct clk *clk = data;
-
-	clk_disable_unprepare(clk);
-}
-
 static void xadc_cancel_delayed_work(void *data)
 {
 	struct delayed_work *work = data;
@@ -1383,19 +1376,10 @@ static int xadc_probe(struct platform_device *pdev)
 		}
 	}
 
-	xadc->clk = devm_clk_get(dev, NULL);
+	xadc->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(xadc->clk))
 		return PTR_ERR(xadc->clk);
 
-	ret = clk_prepare_enable(xadc->clk);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(dev,
-				       xadc_clk_disable_unprepare, xadc->clk);
-	if (ret)
-		return ret;
-
 	/*
 	 * Make sure not to exceed the maximum samplerate since otherwise the
 	 * resulting interrupt storm will soft-lock the system.
diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
index ecd5e18995ad..54040b5fded0 100644
--- a/drivers/iio/frequency/adf4371.c
+++ b/drivers/iio/frequency/adf4371.c
@@ -540,13 +540,6 @@ static int adf4371_setup(struct adf4371_state *st)
 	return regmap_bulk_write(st->regmap, ADF4371_REG(0x30), st->buf, 5);
 }
 
-static void adf4371_clk_disable(void *data)
-{
-	struct adf4371_state *st = data;
-
-	clk_disable_unprepare(st->clkin);
-}
-
 static int adf4371_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
@@ -579,18 +572,10 @@ static int adf4371_probe(struct spi_device *spi)
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
-	st->clkin = devm_clk_get(&spi->dev, "clkin");
+	st->clkin = devm_clk_get_enabled(&spi->dev, "clkin");
 	if (IS_ERR(st->clkin))
 		return PTR_ERR(st->clkin);
 
-	ret = clk_prepare_enable(st->clkin);
-	if (ret < 0)
-		return ret;
-
-	ret = devm_add_action_or_reset(&spi->dev, adf4371_clk_disable, st);
-	if (ret)
-		return ret;
-
 	st->clkin_freq = clk_get_rate(st->clkin);
 
 	ret = adf4371_setup(st);
diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index b0e1f6571afb..1346d77df77f 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -490,11 +490,6 @@ static int admv1013_init(struct admv1013_state *st)
 					  st->input_mode);
 }
 
-static void admv1013_clk_disable(void *data)
-{
-	clk_disable_unprepare(data);
-}
-
 static void admv1013_reg_disable(void *data)
 {
 	regulator_disable(data);
@@ -559,7 +554,7 @@ static int admv1013_properties_parse(struct admv1013_state *st)
 		return dev_err_probe(&spi->dev, PTR_ERR(st->reg),
 				     "failed to get the common-mode voltage\n");
 
-	st->clkin = devm_clk_get(&spi->dev, "lo_in");
+	st->clkin = devm_clk_get_enabled(&spi->dev, "lo_in");
 	if (IS_ERR(st->clkin))
 		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
 				     "failed to get the LO input clock\n");
@@ -601,14 +596,6 @@ static int admv1013_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(st->clkin);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(&spi->dev, admv1013_clk_disable, st->clkin);
-	if (ret)
-		return ret;
-
 	st->nb.notifier_call = admv1013_freq_change;
 	ret = devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
 	if (ret)
diff --git a/drivers/iio/frequency/adrf6780.c b/drivers/iio/frequency/adrf6780.c
index 8255ffd174f6..d7bf34ceedd8 100644
--- a/drivers/iio/frequency/adrf6780.c
+++ b/drivers/iio/frequency/adrf6780.c
@@ -441,11 +441,6 @@ static void adrf6780_properties_parse(struct adrf6780_state *st)
 	st->vdet_out_en = device_property_read_bool(&spi->dev, "adi,vdet-out-en");
 }
 
-static void adrf6780_clk_disable(void *data)
-{
-	clk_disable_unprepare(data);
-}
-
 static void adrf6780_powerdown(void *data)
 {
 	/* Disable all components in the Enable Register */
@@ -473,20 +468,11 @@ static int adrf6780_probe(struct spi_device *spi)
 
 	adrf6780_properties_parse(st);
 
-	st->clkin = devm_clk_get(&spi->dev, "lo_in");
+	st->clkin = devm_clk_get_enabled(&spi->dev, "lo_in");
 	if (IS_ERR(st->clkin))
 		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
 				     "failed to get the LO input clock\n");
 
-	ret = clk_prepare_enable(st->clkin);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(&spi->dev, adrf6780_clk_disable,
-				       st->clkin);
-	if (ret)
-		return ret;
-
 	mutex_init(&st->lock);
 
 	ret = adrf6780_init(st);
diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index ff2b0fab840a..aec55f7e1f26 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -1120,11 +1120,6 @@ static irqreturn_t adis16475_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-static void adis16475_disable_clk(void *data)
-{
-	clk_disable_unprepare((struct clk *)data);
-}
-
 static int adis16475_config_sync_mode(struct adis16475 *st)
 {
 	int ret;
@@ -1150,19 +1145,11 @@ static int adis16475_config_sync_mode(struct adis16475 *st)
 
 	/* All the other modes require external input signal */
 	if (sync->sync_mode != ADIS16475_SYNC_OUTPUT) {
-		struct clk *clk = devm_clk_get(dev, NULL);
+		struct clk *clk = devm_clk_get_enabled(dev, NULL);
 
 		if (IS_ERR(clk))
 			return PTR_ERR(clk);
 
-		ret = clk_prepare_enable(clk);
-		if (ret)
-			return ret;
-
-		ret = devm_add_action_or_reset(dev, adis16475_disable_clk, clk);
-		if (ret)
-			return ret;
-
 		st->clk_freq = clk_get_rate(clk);
 		if (st->clk_freq < sync->min_rate ||
 		    st->clk_freq > sync->max_rate) {

base-commit: 8b3d743fc9e2542822826890b482afabf0e7522a
-- 
2.36.1

