Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93783261EB
	for <lists+linux-iio@lfdr.de>; Fri, 26 Feb 2021 12:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhBZLXW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Feb 2021 06:23:22 -0500
Received: from first.geanix.com ([116.203.34.67]:42184 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229953AbhBZLXU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 26 Feb 2021 06:23:20 -0500
X-Greylist: delayed 638 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Feb 2021 06:23:19 EST
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 27D001023542;
        Fri, 26 Feb 2021 11:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1614337916; bh=6vr/bG1gH33fuG+X2JUsbjB3HstKZPBBGtJ14iDCJ6E=;
        h=From:To:Cc:Subject:Date;
        b=RRhaISA6Hoh88tM3W9Nd+BCMvHSMnr0A94D7ZE1VCfU2VFIJyCm72ZvXzQDD3nO0i
         2QWhRDuVp1L9H/5EmNM7pg3RZW+Yc88O2/nLuRP0NkyCJPDqhCK02RU0bYDKjRZ7LX
         wq1Q1GfkBzkLVFTxGrxU08uMi7zemAE7Xt92bp+TOQyv19B8zQZ9p7v0160MeDZmNQ
         ySdzGCNGlXGAfU67EM/h99j/GzC6ATAQ8YRJBfwtjgq6+A0QtOAgtYglzNNUde2mte
         DSHCilV5Q+jociDPUBsXSUpLuzpcp3cmf0hWIiaYAew9Bn22+6Kc3yMiqdioUNDDJ5
         +HjRCwzHoOxZQ==
From:   Sean Nyekjaer <sean@geanix.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: accel: mma8452: fix indentation
Date:   Fri, 26 Feb 2021 12:11:42 +0100
Message-Id: <20210226111142.1526909-1-sean@geanix.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=4.0 tests=ALL_TRUSTED,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Improve readability by using empty linies instead of extra spaces.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/accel/mma8452.c | 120 ++++++++++++++++++++----------------
 1 file changed, 67 insertions(+), 53 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index b0176d936423..9fc1f7550b9c 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -34,52 +34,66 @@
 #include <linux/regulator/consumer.h>
 
 #define MMA8452_STATUS				0x00
-#define  MMA8452_STATUS_DRDY			(BIT(2) | BIT(1) | BIT(0))
+#define MMA8452_STATUS_DRDY			(BIT(2) | BIT(1) | BIT(0))
+
 #define MMA8452_OUT_X				0x01 /* MSB first */
 #define MMA8452_OUT_Y				0x03
 #define MMA8452_OUT_Z				0x05
 #define MMA8452_INT_SRC				0x0c
 #define MMA8452_WHO_AM_I			0x0d
+
 #define MMA8452_DATA_CFG			0x0e
-#define  MMA8452_DATA_CFG_FS_MASK		GENMASK(1, 0)
-#define  MMA8452_DATA_CFG_FS_2G			0
-#define  MMA8452_DATA_CFG_FS_4G			1
-#define  MMA8452_DATA_CFG_FS_8G			2
-#define  MMA8452_DATA_CFG_HPF_MASK		BIT(4)
+#define MMA8452_DATA_CFG_FS_MASK		GENMASK(1, 0)
+#define MMA8452_DATA_CFG_FS_2G			0
+#define MMA8452_DATA_CFG_FS_4G			1
+#define MMA8452_DATA_CFG_FS_8G			2
+#define MMA8452_DATA_CFG_HPF_MASK		BIT(4)
+
 #define MMA8452_HP_FILTER_CUTOFF		0x0f
-#define  MMA8452_HP_FILTER_CUTOFF_SEL_MASK	GENMASK(1, 0)
+#define MMA8452_HP_FILTER_CUTOFF_SEL_MASK	GENMASK(1, 0)
+
 #define MMA8452_FF_MT_CFG			0x15
-#define  MMA8452_FF_MT_CFG_OAE			BIT(6)
-#define  MMA8452_FF_MT_CFG_ELE			BIT(7)
+#define MMA8452_FF_MT_CFG_OAE			BIT(6)
+#define MMA8452_FF_MT_CFG_ELE			BIT(7)
+
 #define MMA8452_FF_MT_SRC			0x16
-#define  MMA8452_FF_MT_SRC_XHE			BIT(1)
-#define  MMA8452_FF_MT_SRC_YHE			BIT(3)
-#define  MMA8452_FF_MT_SRC_ZHE			BIT(5)
+#define MMA8452_FF_MT_SRC_XHE			BIT(1)
+#define MMA8452_FF_MT_SRC_YHE			BIT(3)
+#define MMA8452_FF_MT_SRC_ZHE			BIT(5)
+
 #define MMA8452_FF_MT_THS			0x17
-#define  MMA8452_FF_MT_THS_MASK			0x7f
+#define MMA8452_FF_MT_THS_MASK			0x7f
+
 #define MMA8452_FF_MT_COUNT			0x18
-#define MMA8452_FF_MT_CHAN_SHIFT	3
+#define MMA8452_FF_MT_CHAN_SHIFT		3
+
 #define MMA8452_TRANSIENT_CFG			0x1d
-#define  MMA8452_TRANSIENT_CFG_CHAN(chan)	BIT(chan + 1)
-#define  MMA8452_TRANSIENT_CFG_HPF_BYP		BIT(0)
-#define  MMA8452_TRANSIENT_CFG_ELE		BIT(4)
+#define MMA8452_TRANSIENT_CFG_CHAN(chan)	BIT(chan + 1)
+#define MMA8452_TRANSIENT_CFG_HPF_BYP		BIT(0)
+#define MMA8452_TRANSIENT_CFG_ELE		BIT(4)
+
 #define MMA8452_TRANSIENT_SRC			0x1e
-#define  MMA8452_TRANSIENT_SRC_XTRANSE		BIT(1)
-#define  MMA8452_TRANSIENT_SRC_YTRANSE		BIT(3)
-#define  MMA8452_TRANSIENT_SRC_ZTRANSE		BIT(5)
+#define MMA8452_TRANSIENT_SRC_XTRANSE		BIT(1)
+#define MMA8452_TRANSIENT_SRC_YTRANSE		BIT(3)
+#define MMA8452_TRANSIENT_SRC_ZTRANSE		BIT(5)
+
 #define MMA8452_TRANSIENT_THS			0x1f
-#define  MMA8452_TRANSIENT_THS_MASK		GENMASK(6, 0)
+#define MMA8452_TRANSIENT_THS_MASK		GENMASK(6, 0)
+
 #define MMA8452_TRANSIENT_COUNT			0x20
-#define MMA8452_TRANSIENT_CHAN_SHIFT 1
+#define MMA8452_TRANSIENT_CHAN_SHIFT		1
+
 #define MMA8452_CTRL_REG1			0x2a
-#define  MMA8452_CTRL_ACTIVE			BIT(0)
-#define  MMA8452_CTRL_DR_MASK			GENMASK(5, 3)
-#define  MMA8452_CTRL_DR_SHIFT			3
-#define  MMA8452_CTRL_DR_DEFAULT		0x4 /* 50 Hz sample frequency */
+#define MMA8452_CTRL_ACTIVE			BIT(0)
+#define MMA8452_CTRL_DR_MASK			GENMASK(5, 3)
+#define MMA8452_CTRL_DR_SHIFT			3
+#define MMA8452_CTRL_DR_DEFAULT			0x4 /* 50 Hz sample frequency */
+
 #define MMA8452_CTRL_REG2			0x2b
-#define  MMA8452_CTRL_REG2_RST			BIT(6)
-#define  MMA8452_CTRL_REG2_MODS_SHIFT		3
-#define  MMA8452_CTRL_REG2_MODS_MASK		0x1b
+#define MMA8452_CTRL_REG2_RST			BIT(6)
+#define MMA8452_CTRL_REG2_MODS_SHIFT		3
+#define MMA8452_CTRL_REG2_MODS_MASK		0x1b
+
 #define MMA8452_CTRL_REG4			0x2d
 #define MMA8452_CTRL_REG5			0x2e
 #define MMA8452_OFF_X				0x2f
@@ -88,9 +102,9 @@
 
 #define MMA8452_MAX_REG				0x31
 
-#define  MMA8452_INT_DRDY			BIT(0)
-#define  MMA8452_INT_FF_MT			BIT(2)
-#define  MMA8452_INT_TRANS			BIT(5)
+#define MMA8452_INT_DRDY			BIT(0)
+#define MMA8452_INT_FF_MT			BIT(2)
+#define MMA8452_INT_TRANS			BIT(5)
 
 #define MMA8451_DEVICE_ID			0x1a
 #define MMA8452_DEVICE_ID			0x2a
@@ -134,33 +148,33 @@ struct mma8452_data {
   * used for different chips and the relevant registers are included here.
   */
 struct mma8452_event_regs {
-		u8 ev_cfg;
-		u8 ev_cfg_ele;
-		u8 ev_cfg_chan_shift;
-		u8 ev_src;
-		u8 ev_ths;
-		u8 ev_ths_mask;
-		u8 ev_count;
+	u8 ev_cfg;
+	u8 ev_cfg_ele;
+	u8 ev_cfg_chan_shift;
+	u8 ev_src;
+	u8 ev_ths;
+	u8 ev_ths_mask;
+	u8 ev_count;
 };
 
 static const struct mma8452_event_regs ff_mt_ev_regs = {
-		.ev_cfg = MMA8452_FF_MT_CFG,
-		.ev_cfg_ele = MMA8452_FF_MT_CFG_ELE,
-		.ev_cfg_chan_shift = MMA8452_FF_MT_CHAN_SHIFT,
-		.ev_src = MMA8452_FF_MT_SRC,
-		.ev_ths = MMA8452_FF_MT_THS,
-		.ev_ths_mask = MMA8452_FF_MT_THS_MASK,
-		.ev_count = MMA8452_FF_MT_COUNT
+	.ev_cfg = MMA8452_FF_MT_CFG,
+	.ev_cfg_ele = MMA8452_FF_MT_CFG_ELE,
+	.ev_cfg_chan_shift = MMA8452_FF_MT_CHAN_SHIFT,
+	.ev_src = MMA8452_FF_MT_SRC,
+	.ev_ths = MMA8452_FF_MT_THS,
+	.ev_ths_mask = MMA8452_FF_MT_THS_MASK,
+	.ev_count = MMA8452_FF_MT_COUNT
 };
 
 static const struct mma8452_event_regs trans_ev_regs = {
-		.ev_cfg = MMA8452_TRANSIENT_CFG,
-		.ev_cfg_ele = MMA8452_TRANSIENT_CFG_ELE,
-		.ev_cfg_chan_shift = MMA8452_TRANSIENT_CHAN_SHIFT,
-		.ev_src = MMA8452_TRANSIENT_SRC,
-		.ev_ths = MMA8452_TRANSIENT_THS,
-		.ev_ths_mask = MMA8452_TRANSIENT_THS_MASK,
-		.ev_count = MMA8452_TRANSIENT_COUNT,
+	.ev_cfg = MMA8452_TRANSIENT_CFG,
+	.ev_cfg_ele = MMA8452_TRANSIENT_CFG_ELE,
+	.ev_cfg_chan_shift = MMA8452_TRANSIENT_CHAN_SHIFT,
+	.ev_src = MMA8452_TRANSIENT_SRC,
+	.ev_ths = MMA8452_TRANSIENT_THS,
+	.ev_ths_mask = MMA8452_TRANSIENT_THS_MASK,
+	.ev_count = MMA8452_TRANSIENT_COUNT,
 };
 
 /**
-- 
2.29.2

