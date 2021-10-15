Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C0F42EBB2
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 10:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbhJOITK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 04:19:10 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:51139 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236916AbhJOIRs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Oct 2021 04:17:48 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id C82EE20008;
        Fri, 15 Oct 2021 08:15:40 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 24/48] mfd: ti_am335x_tscadc: Fix header spacing
Date:   Fri, 15 Oct 2021 10:14:42 +0200
Message-Id: <20211015081506.933180-25-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211015081506.933180-1-miquel.raynal@bootlin.com>
References: <20211015081506.933180-1-miquel.raynal@bootlin.com>
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
index 2b8a5f58a3b6..893c474c1f8c 100644
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

