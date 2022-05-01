Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655E251629E
	for <lists+linux-iio@lfdr.de>; Sun,  1 May 2022 10:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244476AbiEAITI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 May 2022 04:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244156AbiEAIS6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 May 2022 04:18:58 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CBC61133;
        Sun,  1 May 2022 01:15:30 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,189,1647270000"; 
   d="scan'208";a="118506505"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 01 May 2022 17:15:29 +0900
Received: from localhost.localdomain (unknown [10.226.92.14])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6F8924007F20;
        Sun,  1 May 2022 17:15:26 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
Date:   Sun,  1 May 2022 09:15:23 +0100
Message-Id: <20220501081523.22479-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ADC found on RZ/G2UL SoC is almost identical to RZ/G2L SoC, but RZ/G2UL
has 2 analog input channels compared to 8 channels on RZ/G2L. Therefore,
added a new compatible to handle this difference.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 7585144b9715..703b08254c9f 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
@@ -61,6 +62,8 @@
 #define RZG2L_ADC_CHN_MASK		0x7
 #define RZG2L_ADC_TIMEOUT		usecs_to_jiffies(1 * 4)
 
+#define RZG2UL_ADC_MAX_CHANNELS		2
+
 struct rzg2l_adc_data {
 	const struct iio_chan_spec *channels;
 	u8 num_channels;
@@ -76,6 +79,7 @@ struct rzg2l_adc {
 	const struct rzg2l_adc_data *data;
 	struct mutex lock;
 	u16 last_val[RZG2L_ADC_MAX_CHANNELS];
+	u8 max_channels;
 };
 
 static const char * const rzg2l_adc_channel_name[] = {
@@ -260,7 +264,9 @@ static int rzg2l_adc_read_label(struct iio_dev *iio_dev,
 				const struct iio_chan_spec *chan,
 				char *label)
 {
-	if (chan->channel >= RZG2L_ADC_MAX_CHANNELS)
+	struct rzg2l_adc *adc = iio_priv(iio_dev);
+
+	if (chan->channel >= adc->max_channels)
 		return -EINVAL;
 
 	return sysfs_emit(label, "%s\n", rzg2l_adc_channel_name[chan->channel]);
@@ -290,7 +296,7 @@ static irqreturn_t rzg2l_adc_isr(int irq, void *dev_id)
 	if (!intst)
 		return IRQ_NONE;
 
-	for_each_set_bit(ch, &intst, RZG2L_ADC_MAX_CHANNELS)
+	for_each_set_bit(ch, &intst, adc->max_channels)
 		adc->last_val[ch] = rzg2l_adc_readl(adc, RZG2L_ADCR(ch)) & RZG2L_ADCR_AD_MASK;
 
 	/* clear the channel interrupt */
@@ -321,7 +327,7 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
 		return -ENODEV;
 	}
 
-	if (num_channels > RZG2L_ADC_MAX_CHANNELS) {
+	if (num_channels > adc->max_channels) {
 		dev_err(&pdev->dev, "num of channel children out of range\n");
 		return -EINVAL;
 	}
@@ -337,7 +343,7 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
 		if (ret)
 			return ret;
 
-		if (channel >= RZG2L_ADC_MAX_CHANNELS)
+		if (channel >= adc->max_channels)
 			return -EINVAL;
 
 		chan_array[i].type = IIO_VOLTAGE;
@@ -437,6 +443,7 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 
 	adc = iio_priv(indio_dev);
 
+	adc->max_channels = (uintptr_t)of_device_get_match_data(dev);
 	ret = rzg2l_adc_parse_properties(pdev, adc);
 	if (ret)
 		return ret;
@@ -540,7 +547,8 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id rzg2l_adc_match[] = {
-	{ .compatible = "renesas,rzg2l-adc",},
+	{ .compatible = "renesas,r9a07g043-adc", .data = (void *)RZG2UL_ADC_MAX_CHANNELS },
+	{ .compatible = "renesas,rzg2l-adc", .data = (void *)RZG2L_ADC_MAX_CHANNELS },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzg2l_adc_match);
-- 
2.25.1

