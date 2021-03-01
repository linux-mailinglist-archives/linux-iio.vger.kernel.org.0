Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB8B3278CF
	for <lists+linux-iio@lfdr.de>; Mon,  1 Mar 2021 09:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbhCAIBn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Mar 2021 03:01:43 -0500
Received: from first.geanix.com ([116.203.34.67]:37620 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232617AbhCAIBl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Mar 2021 03:01:41 -0500
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id A146F1023BE2;
        Mon,  1 Mar 2021 08:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1614585633; bh=LSfeAQBaJdp4FrJX+ge+unO0yjFPS9yC37TGoYqeC3k=;
        h=From:To:Cc:Subject:Date;
        b=F5Q4k40NiV2GM3qoMlG6EoceSrjGeSFEM3Na93zYfPhBajeaqs7ft0jPSkc64K9QH
         W9w0zIgcVQf6W/NsRckHL/XZjNU1MHmnHGgT4ur2kCtQmwLX0n0+bL29ikg+XgHV13
         lt7Nlt01kCp4KaH3r7/F5JjU1Sj4V31TEdsp9pJANJHv6mycQWZpBAFLy4lYXfv0yw
         OUnrW0+rNxy9Rd6hLIeNy19RrIS9GHjIUYNhkhpAT7S2ag9SksNRvCuaHDaRTgKqH5
         qeLjlvWoChSY+hi3s4e/yAkyRa5DIJ1pjLCNCupGZkvh8+JNut+lNz1/psFaVokvkk
         +o56U34kZjLnw==
From:   Sean Nyekjaer <sean@geanix.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: accel: mma8452: fix indentation
Date:   Mon,  1 Mar 2021 09:00:28 +0100
Message-Id: <20210301080029.1974797-1-sean@geanix.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Improve readability by fixing indentation.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
v2: removed fixing of register values indentation

 drivers/iio/accel/mma8452.c | 46 ++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index b0176d936423..33f0c419d8ff 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -58,7 +58,7 @@
 #define MMA8452_FF_MT_THS			0x17
 #define  MMA8452_FF_MT_THS_MASK			0x7f
 #define MMA8452_FF_MT_COUNT			0x18
-#define MMA8452_FF_MT_CHAN_SHIFT	3
+#define MMA8452_FF_MT_CHAN_SHIFT		3
 #define MMA8452_TRANSIENT_CFG			0x1d
 #define  MMA8452_TRANSIENT_CFG_CHAN(chan)	BIT(chan + 1)
 #define  MMA8452_TRANSIENT_CFG_HPF_BYP		BIT(0)
@@ -70,7 +70,7 @@
 #define MMA8452_TRANSIENT_THS			0x1f
 #define  MMA8452_TRANSIENT_THS_MASK		GENMASK(6, 0)
 #define MMA8452_TRANSIENT_COUNT			0x20
-#define MMA8452_TRANSIENT_CHAN_SHIFT 1
+#define MMA8452_TRANSIENT_CHAN_SHIFT		1
 #define MMA8452_CTRL_REG1			0x2a
 #define  MMA8452_CTRL_ACTIVE			BIT(0)
 #define  MMA8452_CTRL_DR_MASK			GENMASK(5, 3)
@@ -134,33 +134,33 @@ struct mma8452_data {
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

