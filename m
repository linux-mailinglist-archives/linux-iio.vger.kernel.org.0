Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F5540C96C
	for <lists+linux-iio@lfdr.de>; Wed, 15 Sep 2021 18:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238464AbhIOQB1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Sep 2021 12:01:27 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:58173 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238457AbhIOQB0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Sep 2021 12:01:26 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id E85A71BF203;
        Wed, 15 Sep 2021 16:00:03 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 27/47] mfd: ti_am335x_tscadc: Clarify the maximum values for DT entries
Date:   Wed, 15 Sep 2021 17:58:48 +0200
Message-Id: <20210915155908.476767-28-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210915155908.476767-1-miquel.raynal@bootlin.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Clearly define the maximum open delay and sample delay. Use these
definitions in place of a mask (which works because this is the first
field in the register) and an open-coded value. While at it reword a
little bit the error messages to make them look clearer and similar.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/ti_am335x_adc.c      | 18 +++++++++---------
 include/linux/mfd/ti_am335x_tscadc.h |  2 ++
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 3dec115e68ee..a241e6fa3564 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -126,7 +126,7 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
 		chan = adc_dev->channel_line[i];
 
 		if (adc_dev->step_avg[i] > STEPCONFIG_AVG_16) {
-			dev_warn(dev, "chan %d step_avg truncating to %ld\n",
+			dev_warn(dev, "chan %d: wrong step avg, truncated to %ld\n",
 				 chan, STEPCONFIG_AVG_16);
 			adc_dev->step_avg[i] = STEPCONFIG_AVG_16;
 		}
@@ -147,16 +147,16 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
 				STEPCONFIG_RFP_VREFP |
 				STEPCONFIG_RFM_VREFN);
 
-		if (adc_dev->open_delay[i] > STEPDELAY_OPEN_MASK) {
-			dev_warn(dev, "chan %d open delay truncating to 0x3FFFF\n",
-				 chan);
-			adc_dev->open_delay[i] = STEPDELAY_OPEN_MASK;
+		if (adc_dev->open_delay[i] > STEPCONFIG_MAX_OPENDLY) {
+			dev_warn(dev, "chan %d: wrong open delay, truncated to 0x%lX\n",
+				 chan, STEPCONFIG_MAX_OPENDLY);
+			adc_dev->open_delay[i] = STEPCONFIG_MAX_OPENDLY;
 		}
 
-		if (adc_dev->sample_delay[i] > 0xFF) {
-			dev_warn(dev, "chan %d sample delay truncating to 0xFF\n",
-				 chan);
-			adc_dev->sample_delay[i] = 0xFF;
+		if (adc_dev->sample_delay[i] > STEPCONFIG_MAX_SAMPLE) {
+			dev_warn(dev, "chan %d: wrong sample delay, truncated to 0x%lX\n",
+				 chan, STEPCONFIG_MAX_SAMPLE);
+			adc_dev->sample_delay[i] = STEPCONFIG_MAX_SAMPLE;
 		}
 
 		tiadc_writel(adc_dev, REG_STEPDELAY(steps),
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index e6fe623bb1aa..babc2e36c5d0 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -91,7 +91,9 @@
 #define STEPCONFIG_OPENDLY	STEPDELAY_OPEN(0x098)
 #define STEPDELAY_SAMPLE_MASK	GENMASK(31, 24)
 #define STEPDELAY_SAMPLE(val)	FIELD_PREP(STEPDELAY_SAMPLE_MASK, (val))
+#define STEPCONFIG_MAX_OPENDLY	GENMASK(17, 0)
 #define STEPCONFIG_SAMPLEDLY	STEPDELAY_SAMPLE(0)
+#define STEPCONFIG_MAX_SAMPLE	GENMASK(7, 0)
 
 /* Charge Config */
 #define STEPCHARGE_RFP_MASK	GENMASK(14, 12)
-- 
2.27.0

