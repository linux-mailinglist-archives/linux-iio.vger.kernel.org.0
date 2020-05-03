Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4571C2E0D
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 19:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgECRFw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 13:05:52 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:60595 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbgECRFv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 May 2020 13:05:51 -0400
X-Originating-IP: 195.189.32.242
Received: from pc.localdomain (unknown [195.189.32.242])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id C81144000F;
        Sun,  3 May 2020 17:05:47 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v6 2/7] IIO: Ingenic JZ47xx: Error check clk_enable calls.
Date:   Sun,  3 May 2020 19:14:46 +0200
Message-Id: <20200503171451.44034-2-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200503171451.44034-1-contact@artur-rojek.eu>
References: <20200503171451.44034-1-contact@artur-rojek.eu>
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

 drivers/iio/adc/ingenic-adc.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 39c0a609fc94..6c3bbba7c44b 100644
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
@@ -317,6 +328,13 @@ static int ingenic_adc_read_chan_info_raw(struct ingenic_adc *adc,
 					  int *val)
 {
 	int bit, ret, engine = (chan->channel == INGENIC_ADC_BATTERY);
+	struct device *dev = iio_priv_to_dev(adc)->dev.parent;
+
+	ret = clk_enable(adc->clk);
+	if (ret) {
+		dev_err(dev, "Failed to enable clock: %d\n", ret);
+		return ret;
+	}
 
 	/* We cannot sample AUX/AUX2 in parallel. */
 	mutex_lock(&adc->aux_lock);
@@ -325,7 +343,6 @@ static int ingenic_adc_read_chan_info_raw(struct ingenic_adc *adc,
 		ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_AUX_MD, bit);
 	}
 
-	clk_enable(adc->clk);
 	ret = ingenic_adc_capture(adc, engine);
 	if (ret)
 		goto out;
-- 
2.26.2

