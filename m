Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DF0545BAC
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jun 2022 07:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243795AbiFJFaa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jun 2022 01:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241539AbiFJFa3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2022 01:30:29 -0400
Received: from smtp.ruc.edu.cn (m177126.mail.qiye.163.com [123.58.177.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E34114A80;
        Thu,  9 Jun 2022 22:30:25 -0700 (PDT)
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp.ruc.edu.cn (Hmail) with ESMTPSA id 2D63E800A3;
        Fri, 10 Jun 2022 13:30:19 +0800 (CST)
From:   Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
To:     Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jongpil Jung <jongpil19.jung@samsung.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] iio:proximity:sx9360: Fix hardware gain read/write
Date:   Fri, 10 Jun 2022 13:30:12 +0800
Message-Id: <20220610053012.27279-1-xiaohuizhang@ruc.edu.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUMeSUxWQh0fSEhNGh9PS0
        MaVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSUtDTk1VS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nww6Hgw4Oj0zFwoeEAFOLQgT
        KgxPFD9VSlVKTU5PQ0hCS0lKSUtLVTMWGhIXVQMSGhQTDhIBExoVHDsJDhhVHh8OVRgVRVlXWRIL
        WUFZSUtJVUpKSVVKSkhVSUpJWVdZCAFZQU9IQ0k3Bg++
X-HM-Tid: 0a814c178baa2c20kusn2d63e800a3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Similar to the handling of read/write in commit 108e4d4de2b5
("iio:proximity:sx9324: Fix hardware gain read/write"), we thought
a patch might be needed here as well.

There are four possible gain values according to 'sx9360_gain_vals[]':

	1, 2, 4, and 8

The values are off by one when writing and reading the register. The
bits should be set according to this equation:

	ilog2(<gain>) + 1

so that a gain of 8 is 0x4 in the register field and a gain of 4 is 0x3
in the register field, etc. Note that a gain of 0 is reserved per the
datasheet. The default gain (SX9360_REG_PROX_CTRL0_GAIN_1) is also
wrong. It should be 0x1 << 3, i.e. 0x8, not 0x80 which is setting the
reserved bit 7.

Fix this all up to properly handle the hardware gain and return errors
for invalid settings.

Signed-off-by: Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
---
 drivers/iio/proximity/sx9360.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 3ebb30c8a4f6..f231929debb7 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -64,7 +64,10 @@
 #define SX9360_REG_PROX_CTRL0_PHR	0x40
 #define SX9360_REG_PROX_CTRL0_PHM	0x41
 #define SX9360_REG_PROX_CTRL0_GAIN_MASK	GENMASK(5, 3)
-#define SX9360_REG_PROX_CTRL0_GAIN_1		0x80
+#define SX9360_REG_PROX_CTRL0_GAIN_SHIFT	3
+#define SX9360_REG_PROX_CTRL0_GAIN_RSVD	0x0
+#define SX9360_REG_PROX_CTRL0_GAIN_1	0x1
+#define SX9360_REG_PROX_CTRL0_GAIN_8	0x4
 #define SX9360_REG_PROX_CTRL0_RAWFILT_MASK	GENMASK(2, 0)
 #define SX9360_REG_PROX_CTRL0_RAWFILT_1P50	0x01
 #define SX9360_REG_PROX_CTRL1		0x42
@@ -288,7 +291,14 @@ static int sx9360_read_gain(struct sx_common_data *data,
 	if (ret)
 		return ret;
 
-	*val = 1 << FIELD_GET(SX9360_REG_PROX_CTRL0_GAIN_MASK, regval);
+	regval = FIELD_GET(SX9360_REG_PROX_CTRL0_GAIN_MASK, regval);
+	if (regval)
+		regval--;
+	else if (regval == SX9360_REG_PROX_CTRL0_GAIN_RSVD ||
+		 regval > SX9360_REG_PROX_CTRL0_GAIN_8)
+		return -EINVAL;
+
+	*val = 1 << regval;
 
 	return IIO_VAL_INT;
 }
@@ -630,8 +640,12 @@ static int sx9360_write_gain(struct sx_common_data *data,
 	unsigned int gain, reg;
 	int ret;
 
-	gain = ilog2(val);
 	reg = SX9360_REG_PROX_CTRL0_PHR + chan->channel;
+
+	gain = ilog2(val) + 1;
+	if (val <= 0 || gain > SX9360_REG_PROX_CTRL0_GAIN_8)
+		return -EINVAL;
+
 	gain = FIELD_PREP(SX9360_REG_PROX_CTRL0_GAIN_MASK, gain);
 
 	mutex_lock(&data->mutex);
@@ -681,9 +695,11 @@ static const struct sx_common_reg_default sx9360_default_regs[] = {
 	{ SX9360_REG_AFE_PARAM1_PHM, SX9360_REG_AFE_PARAM1_AGAIN_PHM_6PF |
 		SX9360_REG_AFE_PARAM1_FREQ_83_33HZ },
 
-	{ SX9360_REG_PROX_CTRL0_PHR, SX9360_REG_PROX_CTRL0_GAIN_1 |
+	{ SX9360_REG_PROX_CTRL0_PHR,
+		SX9360_REG_PROX_CTRL0_GAIN_1 << SX9360_REG_PROX_CTRL0_GAIN_SHIFT |
 		SX9360_REG_PROX_CTRL0_RAWFILT_1P50 },
-	{ SX9360_REG_PROX_CTRL0_PHM, SX9360_REG_PROX_CTRL0_GAIN_1 |
+	{ SX9360_REG_PROX_CTRL0_PHM,
+		SX9360_REG_PROX_CTRL0_GAIN_1 << SX9360_REG_PROX_CTRL0_GAIN_SHIFT |
 		SX9360_REG_PROX_CTRL0_RAWFILT_1P50 },
 	{ SX9360_REG_PROX_CTRL1, SX9360_REG_PROX_CTRL1_AVGNEG_THRESH_16K },
 	{ SX9360_REG_PROX_CTRL2, SX9360_REG_PROX_CTRL2_AVGDEB_2SAMPLES |
-- 
2.17.1

