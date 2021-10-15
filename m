Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E5F42EB8B
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 10:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbhJOIS2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 04:18:28 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:59259 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236939AbhJOIRx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Oct 2021 04:17:53 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 7C20D20015;
        Fri, 15 Oct 2021 08:15:45 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 28/48] mfd: ti_am335x_tscadc: Clarify the maximum values for DT entries
Date:   Fri, 15 Oct 2021 10:14:46 +0200
Message-Id: <20211015081506.933180-29-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211015081506.933180-1-miquel.raynal@bootlin.com>
References: <20211015081506.933180-1-miquel.raynal@bootlin.com>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
index ae694fa2d711..31cffb6e8b17 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -84,7 +84,9 @@
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

