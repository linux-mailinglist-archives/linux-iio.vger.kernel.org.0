Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F2340C963
	for <lists+linux-iio@lfdr.de>; Wed, 15 Sep 2021 18:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238432AbhIOQBU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Sep 2021 12:01:20 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:51937 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238442AbhIOQBS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Sep 2021 12:01:18 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 17AD81BF20E;
        Wed, 15 Sep 2021 15:59:57 +0000 (UTC)
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
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 24/47] mfd: ti_am335x_tscadc: Fix header spacing
Date:   Wed, 15 Sep 2021 17:58:45 +0200
Message-Id: <20210915155908.476767-25-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210915155908.476767-1-miquel.raynal@bootlin.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Harmonize the spacing within macro definitions.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/mfd/ti_am335x_tscadc.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index 334ce1a879df..efafecfc87a7 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -41,7 +41,7 @@
 /* Step Enable */
 #define STEPENB_MASK		(0x1FFFF << 0)
 #define STEPENB(val)		((val) << 0)
-#define ENB(val)			(1 << (val))
+#define ENB(val)		(1 << (val))
 #define STPENB_STEPENB		STEPENB(0x1FFFF)
 #define STPENB_STEPENB_TC	STEPENB(0x1FFF)
 
@@ -122,15 +122,15 @@
 #define CNTRLREG_TSCENB		BIT(7)
 
 /* FIFO READ Register */
-#define FIFOREAD_DATA_MASK (0xfff << 0)
-#define FIFOREAD_CHNLID_MASK (0xf << 16)
+#define FIFOREAD_DATA_MASK	(0xfff << 0)
+#define FIFOREAD_CHNLID_MASK	(0xf << 16)
 
 /* DMA ENABLE/CLEAR Register */
 #define DMA_FIFO0		BIT(0)
 #define DMA_FIFO1		BIT(1)
 
 /* Sequencer Status */
-#define SEQ_STATUS BIT(5)
+#define SEQ_STATUS		BIT(5)
 #define CHARGE_STEP		0x11
 
 #define ADC_CLK			3000000
@@ -150,7 +150,7 @@
  *
  * max processing time: 266431 * 308ns = 83ms(approx)
  */
-#define IDLE_TIMEOUT 83 /* milliseconds */
+#define IDLE_TIMEOUT		83 /* milliseconds */
 
 #define TSCADC_CELLS		2
 
-- 
2.27.0

