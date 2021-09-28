Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E7741B096
	for <lists+linux-iio@lfdr.de>; Tue, 28 Sep 2021 15:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241374AbhI1Ne4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Sep 2021 09:34:56 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:39363 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241238AbhI1Nel (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Sep 2021 09:34:41 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 693AE60013;
        Tue, 28 Sep 2021 13:32:58 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>, <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 29/48] mfd: ti_am335x_tscadc: Drop useless definitions from the header
Date:   Tue, 28 Sep 2021 15:31:24 +0200
Message-Id: <20210928133143.157329-30-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210928133143.157329-1-miquel.raynal@bootlin.com>
References: <20210928133143.157329-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Drop useless definitions from the header like the "masks" definitions
which are only used by the following definition.

It could be possible to got even further by removing these definitions
entirely and use FIELD_PREP() macros from the code directly, but while I
have no troubles making these changes in the header, changing the values
in the code directly could darkening a bit the logic and
hardening future git-blames for very little added value IMHO (but this
is of course a personal taste).

Certain macros are using GENMASK() to define the value of a particular
field, while this is purely "by chance" that the value and the mask have
the same value. In this case, drop the "mask" definition, use
FIELD_PREP() and GENMASK() in the macro defining the field, and use the
new macro to define the particular value by feeding directly the actual
number advertised in the datasheet into that macro, as in:
	-#define STEPCONFIG_RFM_VREFN   GENMASK(24, 23)
	-#define STEPCONFIG_RFM(val)    FIELD_PREP(STEPCONFIG_RFM_VREFN, (val))
	+#define STEPCONFIG_RFM(val)    FIELD_PREP(GENMASK(24, 23), (val))
	+#define STEPCONFIG_RFM_VREFN   STEPCONFIG_RFM(3)

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/mfd/ti_am335x_tscadc.h | 44 ++++++++++------------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index 31cffb6e8b17..51d987080cd3 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -52,12 +52,10 @@
 #define IRQENB_PENUP		BIT(9)
 
 /* Step Configuration */
-#define STEPCONFIG_MODE_MASK	GENMASK(1, 0)
-#define STEPCONFIG_MODE(val)	FIELD_PREP(STEPCONFIG_MODE_MASK, (val))
+#define STEPCONFIG_MODE(val)	FIELD_PREP(GENMASK(1, 0), (val))
 #define STEPCONFIG_MODE_SWCNT	STEPCONFIG_MODE(1)
 #define STEPCONFIG_MODE_HWSYNC	STEPCONFIG_MODE(2)
-#define STEPCONFIG_AVG_MASK	GENMASK(4, 2)
-#define STEPCONFIG_AVG(val)	FIELD_PREP(STEPCONFIG_AVG_MASK, (val))
+#define STEPCONFIG_AVG(val)	FIELD_PREP(GENMASK(4, 2), (val))
 #define STEPCONFIG_AVG_16	STEPCONFIG_AVG(4)
 #define STEPCONFIG_XPP		BIT(5)
 #define STEPCONFIG_XNN		BIT(6)
@@ -65,45 +63,36 @@
 #define STEPCONFIG_YNN		BIT(8)
 #define STEPCONFIG_XNP		BIT(9)
 #define STEPCONFIG_YPN		BIT(10)
-#define STEPCONFIG_RFP_VREFP	GENMASK(13, 12)
-#define STEPCONFIG_RFP(val)	FIELD_PREP(STEPCONFIG_RFP_VREFP, (val))
-#define STEPCONFIG_INM_MASK	GENMASK(18, 15)
-#define STEPCONFIG_INM(val)	FIELD_PREP(STEPCONFIG_INM_MASK, (val))
+#define STEPCONFIG_RFP(val)	FIELD_PREP(GENMASK(13, 12), (val))
+#define STEPCONFIG_RFP_VREFP	STEPCONFIG_RFP(3)
+#define STEPCONFIG_INM(val)	FIELD_PREP(GENMASK(18, 15), (val))
 #define STEPCONFIG_INM_ADCREFM	STEPCONFIG_INM(8)
-#define STEPCONFIG_INP_MASK	GENMASK(22, 19)
-#define STEPCONFIG_INP(val)	FIELD_PREP(STEPCONFIG_INP_MASK, (val))
+#define STEPCONFIG_INP(val)	FIELD_PREP(GENMASK(22, 19), (val))
 #define STEPCONFIG_INP_AN4	STEPCONFIG_INP(4)
 #define STEPCONFIG_INP_ADCREFM	STEPCONFIG_INP(8)
 #define STEPCONFIG_FIFO1	BIT(26)
-#define STEPCONFIG_RFM_VREFN	GENMASK(24, 23)
-#define STEPCONFIG_RFM(val)	FIELD_PREP(STEPCONFIG_RFM_VREFN, (val))
+#define STEPCONFIG_RFM(val)	FIELD_PREP(GENMASK(24, 23), (val))
+#define STEPCONFIG_RFM_VREFN	STEPCONFIG_RFM(3)
 
 /* Delay register */
-#define STEPDELAY_OPEN_MASK	GENMASK(17, 0)
-#define STEPDELAY_OPEN(val)	FIELD_PREP(STEPDELAY_OPEN_MASK, (val))
+#define STEPDELAY_OPEN(val)	FIELD_PREP(GENMASK(17, 0), (val))
 #define STEPCONFIG_OPENDLY	STEPDELAY_OPEN(0x098)
-#define STEPDELAY_SAMPLE_MASK	GENMASK(31, 24)
-#define STEPDELAY_SAMPLE(val)	FIELD_PREP(STEPDELAY_SAMPLE_MASK, (val))
 #define STEPCONFIG_MAX_OPENDLY	GENMASK(17, 0)
+#define STEPDELAY_SAMPLE(val)	FIELD_PREP(GENMASK(31, 24), (val))
 #define STEPCONFIG_SAMPLEDLY	STEPDELAY_SAMPLE(0)
 #define STEPCONFIG_MAX_SAMPLE	GENMASK(7, 0)
 
 /* Charge Config */
-#define STEPCHARGE_RFP_MASK	GENMASK(14, 12)
-#define STEPCHARGE_RFP(val)	FIELD_PREP(STEPCHARGE_RFP_MASK, (val))
+#define STEPCHARGE_RFP(val)	FIELD_PREP(GENMASK(14, 12), (val))
 #define STEPCHARGE_RFP_XPUL	STEPCHARGE_RFP(1)
-#define STEPCHARGE_INM_MASK	GENMASK(18, 15)
-#define STEPCHARGE_INM(val)	FIELD_PREP(STEPCHARGE_INM_MASK, (val))
+#define STEPCHARGE_INM(val)	FIELD_PREP(GENMASK(18, 15), (val))
 #define STEPCHARGE_INM_AN1	STEPCHARGE_INM(1)
-#define STEPCHARGE_INP_MASK	GENMASK(22, 19)
-#define STEPCHARGE_INP(val)	FIELD_PREP(STEPCHARGE_INP_MASK, (val))
-#define STEPCHARGE_RFM_MASK	GENMASK(24, 23)
-#define STEPCHARGE_RFM(val)	FIELD_PREP(STEPCHARGE_RFM_MASK, (val))
+#define STEPCHARGE_INP(val)	FIELD_PREP(GENMASK(22, 19), (val))
+#define STEPCHARGE_RFM(val)	FIELD_PREP(GENMASK(24, 23), (val))
 #define STEPCHARGE_RFM_XNUR	STEPCHARGE_RFM(1)
 
 /* Charge delay */
-#define CHARGEDLY_OPEN_MASK	GENMASK(17, 0)
-#define CHARGEDLY_OPEN(val)	FIELD_PREP(CHARGEDLY_OPEN_MASK, (val))
+#define CHARGEDLY_OPEN(val)	FIELD_PREP(GENMASK(17, 0), (val))
 #define CHARGEDLY_OPENDLY	CHARGEDLY_OPEN(0x400)
 
 /* Control register */
@@ -111,8 +100,7 @@
 #define CNTRLREG_STEPID		BIT(1)
 #define CNTRLREG_STEPCONFIGWRT	BIT(2)
 #define CNTRLREG_POWERDOWN	BIT(4)
-#define CNTRLREG_AFE_CTRL_MASK	GENMASK(6, 5)
-#define CNTRLREG_AFE_CTRL(val)	FIELD_PREP(CNTRLREG_AFE_CTRL_MASK, (val))
+#define CNTRLREG_AFE_CTRL(val)	FIELD_PREP(GENMASK(6, 5), (val))
 #define CNTRLREG_4WIRE		CNTRLREG_AFE_CTRL(1)
 #define CNTRLREG_5WIRE		CNTRLREG_AFE_CTRL(2)
 #define CNTRLREG_8WIRE		CNTRLREG_AFE_CTRL(3)
-- 
2.27.0

