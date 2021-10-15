Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A02D42EBBE
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 10:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237293AbhJOIT3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 04:19:29 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:34997 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237068AbhJOISL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Oct 2021 04:18:11 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 6816220019;
        Fri, 15 Oct 2021 08:16:03 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 42/48] iio: adc: ti_am335x_adc: Gather the checks on the delays
Date:   Fri, 15 Oct 2021 10:15:00 +0200
Message-Id: <20211015081506.933180-43-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211015081506.933180-1-miquel.raynal@bootlin.com>
References: <20211015081506.933180-1-miquel.raynal@bootlin.com>
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
 drivers/iio/adc/ti_am335x_adc.c | 50 ++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index aa151d702a14..6f47a1ace3d4 100644
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
-			dev_warn(dev, "chan %d: wrong step avg, truncated to %ld\n",
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
 
-		if (adc_dev->open_delay[i] > STEPCONFIG_MAX_OPENDLY) {
-			dev_warn(dev, "chan %d: wrong open delay, truncated to 0x%lX\n",
-				 chan, STEPCONFIG_MAX_OPENDLY);
-			adc_dev->open_delay[i] = STEPCONFIG_MAX_OPENDLY;
-		}
-
-		if (adc_dev->sample_delay[i] > STEPCONFIG_MAX_SAMPLE) {
-			dev_warn(dev, "chan %d: wrong sample delay, truncated to 0x%lX\n",
-				 chan, STEPCONFIG_MAX_SAMPLE);
-			adc_dev->sample_delay[i] = STEPCONFIG_MAX_SAMPLE;
-		}
-
 		tiadc_writel(adc_dev, REG_STEPDELAY(steps),
 			     STEPDELAY_OPEN(adc_dev->open_delay[i]) |
 			     STEPDELAY_SAMPLE(adc_dev->sample_delay[i]));
@@ -572,6 +553,7 @@ static int tiadc_parse_dt(struct platform_device *pdev,
 	const __be32 *cur;
 	int channels = 0;
 	u32 val;
+	int i;
 
 	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
 		adc_dev->channel_line[channels] = val;
@@ -584,6 +566,8 @@ static int tiadc_parse_dt(struct platform_device *pdev,
 		channels++;
 	}
 
+	adc_dev->channels = channels;
+
 	of_property_read_u32_array(node, "ti,chan-step-avg",
 				   adc_dev->step_avg, channels);
 	of_property_read_u32_array(node, "ti,chan-step-opendelay",
@@ -591,7 +575,33 @@ static int tiadc_parse_dt(struct platform_device *pdev,
 	of_property_read_u32_array(node, "ti,chan-step-sampledelay",
 				   adc_dev->sample_delay, channels);
 
-	adc_dev->channels = channels;
+	for (i = 0; i < adc_dev->channels; i++) {
+		int chan;
+
+		chan = adc_dev->channel_line[i];
+
+		if (adc_dev->step_avg[i] > STEPCONFIG_AVG_16) {
+			dev_warn(&pdev->dev,
+				 "chan %d: wrong step avg, truncated to %ld\n",
+				 chan, STEPCONFIG_AVG_16);
+			adc_dev->step_avg[i] = STEPCONFIG_AVG_16;
+		}
+
+		if (adc_dev->open_delay[i] > STEPCONFIG_MAX_OPENDLY) {
+			dev_warn(&pdev->dev,
+				 "chan %d: wrong open delay, truncated to 0x%lX\n",
+				 chan, STEPCONFIG_MAX_OPENDLY);
+			adc_dev->open_delay[i] = STEPCONFIG_MAX_OPENDLY;
+		}
+
+		if (adc_dev->sample_delay[i] > STEPCONFIG_MAX_SAMPLE) {
+			dev_warn(&pdev->dev,
+				 "chan %d: wrong sample delay, truncated to 0x%lX\n",
+				 chan, STEPCONFIG_MAX_SAMPLE);
+			adc_dev->sample_delay[i] = STEPCONFIG_MAX_SAMPLE;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.27.0

