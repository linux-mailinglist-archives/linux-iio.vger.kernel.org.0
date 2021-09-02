Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9327B3FF64F
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 23:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347740AbhIBVxj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 17:53:39 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:37681 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347753AbhIBVxg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 17:53:36 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 48B76240004;
        Thu,  2 Sep 2021 21:52:35 +0000 (UTC)
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
Subject: [PATCH v2 25/46] mfd: ti_am335x_tscadc: Use BIT() and GENMASK() when relevant in the header
Date:   Thu,  2 Sep 2021 23:51:23 +0200
Message-Id: <20210902215144.507243-26-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902215144.507243-1-miquel.raynal@bootlin.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert masks to GENMASK() and regular shifts to BIT() in
ti_am335x_tscadc.h header.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/mfd/ti_am335x_tscadc.h | 40 ++++++++++++++--------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index efafecfc87a7..4de16fc3d74f 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -39,11 +39,11 @@
 #define IRQWKUP_ENB		BIT(0)
 
 /* Step Enable */
-#define STEPENB_MASK		(0x1FFFF << 0)
+#define STEPENB_MASK		GENMASK(16, 0)
 #define STEPENB(val)		((val) << 0)
-#define ENB(val)		(1 << (val))
-#define STPENB_STEPENB		STEPENB(0x1FFFF)
-#define STPENB_STEPENB_TC	STEPENB(0x1FFF)
+#define ENB(val)		BIT(val)
+#define STPENB_STEPENB		STEPENB(GENMASK(16, 0))
+#define STPENB_STEPENB_TC	STEPENB(GENMASK(12, 0))
 
 /* IRQ enable */
 #define IRQENB_HW_PEN		BIT(0)
@@ -57,11 +57,11 @@
 #define IRQENB_PENUP		BIT(9)
 
 /* Step Configuration */
-#define STEPCONFIG_MODE_MASK	(3 << 0)
+#define STEPCONFIG_MODE_MASK	GENMASK(1, 0)
 #define STEPCONFIG_MODE(val)	((val) << 0)
 #define STEPCONFIG_MODE_SWCNT	STEPCONFIG_MODE(1)
 #define STEPCONFIG_MODE_HWSYNC	STEPCONFIG_MODE(2)
-#define STEPCONFIG_AVG_MASK	(7 << 2)
+#define STEPCONFIG_AVG_MASK	GENMASK(4, 2)
 #define STEPCONFIG_AVG(val)	((val) << 2)
 #define STEPCONFIG_AVG_16	STEPCONFIG_AVG(4)
 #define STEPCONFIG_XPP		BIT(5)
@@ -71,41 +71,41 @@
 #define STEPCONFIG_XNP		BIT(9)
 #define STEPCONFIG_YPN		BIT(10)
 #define STEPCONFIG_RFP(val)	((val) << 12)
-#define STEPCONFIG_RFP_VREFP	(0x3 << 12)
-#define STEPCONFIG_INM_MASK	(0xF << 15)
+#define STEPCONFIG_RFP_VREFP	GENMASK(13, 12)
+#define STEPCONFIG_INM_MASK	GENMASK(18, 15)
 #define STEPCONFIG_INM(val)	((val) << 15)
 #define STEPCONFIG_INM_ADCREFM	STEPCONFIG_INM(8)
-#define STEPCONFIG_INP_MASK	(0xF << 19)
+#define STEPCONFIG_INP_MASK	GENMASK(22, 19)
 #define STEPCONFIG_INP(val)	((val) << 19)
 #define STEPCONFIG_INP_AN4	STEPCONFIG_INP(4)
 #define STEPCONFIG_INP_ADCREFM	STEPCONFIG_INP(8)
 #define STEPCONFIG_FIFO1	BIT(26)
 #define STEPCONFIG_RFM(val)	((val) << 23)
-#define STEPCONFIG_RFM_VREFN	(0x3 << 23)
+#define STEPCONFIG_RFM_VREFN	GENMASK(24, 23)
 
 /* Delay register */
-#define STEPDELAY_OPEN_MASK	(0x3FFFF << 0)
+#define STEPDELAY_OPEN_MASK	GENMASK(17, 0)
 #define STEPDELAY_OPEN(val)	((val) << 0)
 #define STEPCONFIG_OPENDLY	STEPDELAY_OPEN(0x098)
-#define STEPDELAY_SAMPLE_MASK	(0xFF << 24)
+#define STEPDELAY_SAMPLE_MASK	GENMASK(31, 24)
 #define STEPDELAY_SAMPLE(val)	((val) << 24)
 #define STEPCONFIG_SAMPLEDLY	STEPDELAY_SAMPLE(0)
 
 /* Charge Config */
-#define STEPCHARGE_RFP_MASK	(7 << 12)
+#define STEPCHARGE_RFP_MASK	GENMASK(14, 12)
 #define STEPCHARGE_RFP(val)	((val) << 12)
 #define STEPCHARGE_RFP_XPUL	STEPCHARGE_RFP(1)
-#define STEPCHARGE_INM_MASK	(0xF << 15)
+#define STEPCHARGE_INM_MASK	GENMASK(18, 15)
 #define STEPCHARGE_INM(val)	((val) << 15)
 #define STEPCHARGE_INM_AN1	STEPCHARGE_INM(1)
-#define STEPCHARGE_INP_MASK	(0xF << 19)
+#define STEPCHARGE_INP_MASK	GENMASK(22, 19)
 #define STEPCHARGE_INP(val)	((val) << 19)
-#define STEPCHARGE_RFM_MASK	(3 << 23)
+#define STEPCHARGE_RFM_MASK	GENMASK(24, 23)
 #define STEPCHARGE_RFM(val)	((val) << 23)
 #define STEPCHARGE_RFM_XNUR	STEPCHARGE_RFM(1)
 
 /* Charge delay */
-#define CHARGEDLY_OPEN_MASK	(0x3FFFF << 0)
+#define CHARGEDLY_OPEN_MASK	GENMASK(17, 0)
 #define CHARGEDLY_OPEN(val)	((val) << 0)
 #define CHARGEDLY_OPENDLY	CHARGEDLY_OPEN(0x400)
 
@@ -114,7 +114,7 @@
 #define CNTRLREG_STEPID		BIT(1)
 #define CNTRLREG_STEPCONFIGWRT	BIT(2)
 #define CNTRLREG_POWERDOWN	BIT(4)
-#define CNTRLREG_AFE_CTRL_MASK	(3 << 5)
+#define CNTRLREG_AFE_CTRL_MASK	GENMASK(6, 5)
 #define CNTRLREG_AFE_CTRL(val)	((val) << 5)
 #define CNTRLREG_4WIRE		CNTRLREG_AFE_CTRL(1)
 #define CNTRLREG_5WIRE		CNTRLREG_AFE_CTRL(2)
@@ -122,8 +122,8 @@
 #define CNTRLREG_TSCENB		BIT(7)
 
 /* FIFO READ Register */
-#define FIFOREAD_DATA_MASK	(0xfff << 0)
-#define FIFOREAD_CHNLID_MASK	(0xf << 16)
+#define FIFOREAD_DATA_MASK	GENMASK(11, 0)
+#define FIFOREAD_CHNLID_MASK	GENMASK(19, 16)
 
 /* DMA ENABLE/CLEAR Register */
 #define DMA_FIFO0		BIT(0)
-- 
2.27.0

