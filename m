Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640D83A2C0D
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 14:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhFJM4D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 08:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhFJM4D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 08:56:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5290EC061760
        for <linux-iio@vger.kernel.org>; Thu, 10 Jun 2021 05:54:07 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lrKCD-00032s-Oc
        for linux-iio@vger.kernel.org; Thu, 10 Jun 2021 14:54:05 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 04C9C63841A
        for <linux-iio@vger.kernel.org>; Thu, 10 Jun 2021 12:54:02 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 6A459638401;
        Thu, 10 Jun 2021 12:54:01 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8187c9a2;
        Thu, 10 Jun 2021 12:54:00 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Lang <Oliver.Lang@gossenmetrawatt.com>
Subject: [PATCH 1/4] iio: ltr501: mark register holding upper 8 bits of ALS_DATA{0,1} and PS_DATA as volatile, too
Date:   Thu, 10 Jun 2021 14:53:55 +0200
Message-Id: <20210610125358.2096497-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210610125358.2096497-1-mkl@pengutronix.de>
References: <20210610125358.2096497-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The regmap is configured for 8 bit registers, uses a RB-Tree cache and
marks several registers as volatile (i.e. do not cache).

The ALS and PS data registers in the chip are 16 bit wide and spans
two regmap registers. In the current driver only the base register is
marked as volatile, resulting in the upper register only read once.

Further the data sheet notes:

| When the I2C read operation starts, all four ALS data registers are
| locked until the I2C read operation of register 0x8B is completed.

Which results in the registers never update after the 2nd read.

This patch fixes the problem by marking the upper 8 bits of the ALS
and PS registers as volatile, too.

Fixes: 2f2c96338afc ("iio: ltr501: Add regmap support.")
Reported-by: Oliver Lang <Oliver.Lang@gossenmetrawatt.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/iio/light/ltr501.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index b4323d2db0b1..0ed3392a33cf 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -32,9 +32,12 @@
 #define LTR501_PART_ID 0x86
 #define LTR501_MANUFAC_ID 0x87
 #define LTR501_ALS_DATA1 0x88 /* 16-bit, little endian */
+#define LTR501_ALS_DATA1_UPPER 0x89 /* upper 8 bits of LTR501_ALS_DATA1 */
 #define LTR501_ALS_DATA0 0x8a /* 16-bit, little endian */
+#define LTR501_ALS_DATA0_UPPER 0x8b /* upper 8 bits of LTR501_ALS_DATA0 */
 #define LTR501_ALS_PS_STATUS 0x8c
 #define LTR501_PS_DATA 0x8d /* 16-bit, little endian */
+#define LTR501_PS_DATA_UPPER 0x8e /* upper 8 bits of LTR501_PS_DATA */
 #define LTR501_INTR 0x8f /* output mode, polarity, mode */
 #define LTR501_PS_THRESH_UP 0x90 /* 11 bit, ps upper threshold */
 #define LTR501_PS_THRESH_LOW 0x92 /* 11 bit, ps lower threshold */
@@ -1354,9 +1357,12 @@ static bool ltr501_is_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case LTR501_ALS_DATA1:
+	case LTR501_ALS_DATA1_UPPER:
 	case LTR501_ALS_DATA0:
+	case LTR501_ALS_DATA0_UPPER:
 	case LTR501_ALS_PS_STATUS:
 	case LTR501_PS_DATA:
+	case LTR501_PS_DATA_UPPER:
 		return true;
 	default:
 		return false;
-- 
2.30.2


