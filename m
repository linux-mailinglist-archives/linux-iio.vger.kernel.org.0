Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCA5225428
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jul 2020 22:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgGSUyR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jul 2020 16:54:17 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:37081 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgGSUyR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2020 16:54:17 -0400
X-Originating-IP: 195.189.32.242
Received: from pc.localdomain (unknown [195.189.32.242])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id BF667FF804;
        Sun, 19 Jul 2020 20:54:10 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v9 1/5] IIO: Ingenic JZ47xx: Error check clk_enable calls.
Date:   Sun, 19 Jul 2020 22:53:03 +0200
Message-Id: <20200719205307.87385-1-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce error checks for the clk_enable calls used in this driver.
As part of the changes, move clk_enable/clk_disable calls out of
ingenic_adc_set_config and into respective logic of its callers.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
Tested-by: Paul Cercueil <paul@crapouillou.net>
---

 Changes:

 v6: new patch

 v7: no change

 v8: move `clk_disable` outside the lock

 v9: remove `iio_priv_to_dev` usage

 drivers/iio/adc/ingenic-adc.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 39c0a609fc94..059c2573e4a9 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -73,7 +73,6 @@ static void ingenic_adc_set_config(struct ingenic_adc *adc,
 {
 	uint32_t cfg;
 
-	clk_enable(adc->clk);
 	mutex_lock(&adc->lock);
 
 	cfg = readl(adc->base + JZ_ADC_REG_CFG) & ~mask;
@@ -81,7 +80,6 @@ static void ingenic_adc_set_config(struct ingenic_adc *adc,
 	writel(cfg, adc->base + JZ_ADC_REG_CFG);
 
 	mutex_unlock(&adc->lock);
-	clk_disable(adc->clk);
 }
 
 static void ingenic_adc_enable(struct ingenic_adc *adc,
@@ -124,6 +122,8 @@ static int ingenic_adc_write_raw(struct iio_dev *iio_dev,
 				 long m)
 {
 	struct ingenic_adc *adc = iio_priv(iio_dev);
+	struct device *dev = iio_dev->dev.parent;
+	int ret;
 
 	switch (m) {
 	case IIO_CHAN_INFO_SCALE:
@@ -131,6 +131,14 @@ static int ingenic_adc_write_raw(struct iio_dev *iio_dev,
 		case INGENIC_ADC_BATTERY:
 			if (!adc->soc_data->battery_vref_mode)
 				return -EINVAL;
+
+			ret = clk_enable(adc->clk);
+			if (ret) {
+				dev_err(dev, "Failed to enable clock: %d\n",
+					ret);
+				return ret;
+			}
+
 			if (val > JZ_ADC_BATTERY_LOW_VREF) {
 				ingenic_adc_set_config(adc,
 						       JZ_ADC_REG_CFG_BAT_MD,
@@ -142,6 +150,9 @@ static int ingenic_adc_write_raw(struct iio_dev *iio_dev,
 						       JZ_ADC_REG_CFG_BAT_MD);
 				adc->low_vref_mode = true;
 			}
+
+			clk_disable(adc->clk);
+
 			return 0;
 		default:
 			return -EINVAL;
@@ -312,11 +323,19 @@ static int ingenic_adc_read_avail(struct iio_dev *iio_dev,
 	};
 }
 
-static int ingenic_adc_read_chan_info_raw(struct ingenic_adc *adc,
+static int ingenic_adc_read_chan_info_raw(struct iio_dev *iio_dev,
 					  struct iio_chan_spec const *chan,
 					  int *val)
 {
 	int bit, ret, engine = (chan->channel == INGENIC_ADC_BATTERY);
+	struct ingenic_adc *adc = iio_priv(iio_dev);
+
+	ret = clk_enable(adc->clk);
+	if (ret) {
+		dev_err(iio_dev->dev.parent, "Failed to enable clock: %d\n",
+			ret);
+		return ret;
+	}
 
 	/* We cannot sample AUX/AUX2 in parallel. */
 	mutex_lock(&adc->aux_lock);
@@ -325,7 +344,6 @@ static int ingenic_adc_read_chan_info_raw(struct ingenic_adc *adc,
 		ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_AUX_MD, bit);
 	}
 
-	clk_enable(adc->clk);
 	ret = ingenic_adc_capture(adc, engine);
 	if (ret)
 		goto out;
@@ -342,8 +360,8 @@ static int ingenic_adc_read_chan_info_raw(struct ingenic_adc *adc,
 
 	ret = IIO_VAL_INT;
 out:
-	clk_disable(adc->clk);
 	mutex_unlock(&adc->aux_lock);
+	clk_disable(adc->clk);
 
 	return ret;
 }
@@ -358,7 +376,7 @@ static int ingenic_adc_read_raw(struct iio_dev *iio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		return ingenic_adc_read_chan_info_raw(adc, chan, val);
+		return ingenic_adc_read_chan_info_raw(iio_dev, chan, val);
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->channel) {
 		case INGENIC_ADC_AUX:
-- 
2.27.0

