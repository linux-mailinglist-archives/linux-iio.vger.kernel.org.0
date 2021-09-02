Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B293FF689
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 23:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347768AbhIBVyM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 17:54:12 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:44843 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347604AbhIBVyF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 17:54:05 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 4934A24000F;
        Thu,  2 Sep 2021 21:53:04 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 40/46] iio: adc: ti_am335x_adc: Gather the checks on the delays
Date:   Thu,  2 Sep 2021 23:51:38 +0200
Message-Id: <20210902215144.507243-41-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902215144.507243-1-miquel.raynal@bootlin.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Move the checks over the delays provided in the device tree to the
location where these values are read to clarify where they come from.

There are no functional changes besides the device structure used to
display the warnings: let's use the ADC instead of the MFD device.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti_am335x_adc.c | 47 +++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index fcd5283bda2e..0c72845e2b4f 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -107,7 +107,6 @@ static int tiadc_wait_idle(struct tiadc_device *adc_dev)
 static void tiadc_step_config(struct iio_dev *indio_dev)
 {
 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
-	struct device *dev = adc_dev->mfd_tscadc->dev;
 	unsigned int stepconfig;
 	int i, steps = 0;
 
@@ -125,12 +124,6 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
 
 		chan = adc_dev->channel_line[i];
 
-		if (adc_dev->step_avg[i] > STEPCONFIG_AVG_16) {
-			dev_warn(dev, "chan %d step_avg truncating to %ld\n",
-				 chan, STEPCONFIG_AVG_16);
-			adc_dev->step_avg[i] = STEPCONFIG_AVG_16;
-		}
-
 		if (adc_dev->step_avg[i])
 			stepconfig = STEPCONFIG_AVG(ffs(adc_dev->step_avg[i]) - 1) |
 				     STEPCONFIG_FIFO1;
@@ -145,18 +138,6 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
 			     STEPCONFIG_INM_ADCREFM | STEPCONFIG_RFP_VREFP |
 			     STEPCONFIG_RFM_VREFN);
 
-		if (adc_dev->open_delay[i] > STEPDELAY_OPEN_MASK) {
-			dev_warn(dev, "chan %d open delay truncating to 0x3FFFF\n",
-				 chan);
-			adc_dev->open_delay[i] = STEPDELAY_OPEN_MASK;
-		}
-
-		if (adc_dev->sample_delay[i] > 0xFF) {
-			dev_warn(dev, "chan %d sample delay truncating to 0xFF\n",
-				 chan);
-			adc_dev->sample_delay[i] = 0xFF;
-		}
-
 		tiadc_writel(adc_dev, REG_STEPDELAY(steps),
 			     STEPDELAY_OPEN(adc_dev->open_delay[i]) |
 			     STEPDELAY_SAMPLE(adc_dev->sample_delay[i]));
@@ -580,6 +561,7 @@ static int tiadc_parse_dt(struct platform_device *pdev,
 	const __be32 *cur;
 	int channels = 0;
 	u32 val;
+	int i;
 
 	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
 		adc_dev->channel_line[channels] = val;
@@ -592,6 +574,8 @@ static int tiadc_parse_dt(struct platform_device *pdev,
 		channels++;
 	}
 
+	adc_dev->channels = channels;
+
 	of_property_read_u32_array(node, "ti,chan-step-avg",
 				   adc_dev->step_avg, channels);
 	of_property_read_u32_array(node, "ti,chan-step-opendelay",
@@ -599,7 +583,30 @@ static int tiadc_parse_dt(struct platform_device *pdev,
 	of_property_read_u32_array(node, "ti,chan-step-sampledelay",
 				   adc_dev->sample_delay, channels);
 
-	adc_dev->channels = channels;
+	for (i = 0; i < adc_dev->channels; i++) {
+		int chan;
+
+		chan = adc_dev->channel_line[i];
+
+		if (adc_dev->step_avg[i] > STEPCONFIG_AVG_16) {
+			dev_warn(&pdev->dev, "chan %d step_avg truncating to %ld\n",
+				 chan, STEPCONFIG_AVG_16);
+			adc_dev->step_avg[i] = STEPCONFIG_AVG_16;
+		}
+
+		if (adc_dev->open_delay[i] > STEPDELAY_OPEN_MASK) {
+			dev_warn(&pdev->dev, "chan %d open delay truncating to 0x3FFFF\n",
+				 chan);
+			adc_dev->open_delay[i] = STEPDELAY_OPEN_MASK;
+		}
+
+		if (adc_dev->sample_delay[i] > 0xFF) {
+			dev_warn(&pdev->dev, "chan %d sample delay truncating to 0xFF\n",
+				 chan);
+			adc_dev->sample_delay[i] = 0xFF;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.27.0

