Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB483390D
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2019 21:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfFCT0l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jun 2019 15:26:41 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:55492 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfFCT0l (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 3 Jun 2019 15:26:41 -0400
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Jun 2019 15:26:40 EDT
Received: from localhost.localdomain (80-110-121-20.cgn.dynamic.surfer.at [80.110.121.20])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id A794AC0101;
        Mon,  3 Jun 2019 19:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1559589657; bh=0ZOQ8oo0MRQTYnRxEe5Ztp+WG3N9bT3TzGBVaCY33eA=;
        h=From:To:Cc:Subject:Date;
        b=oLOzOFaNi+UanyTvl65bDSpLVo7pkbCsfAitG6cfQ5FTxlHTjQkzVkkKqON6CLvwq
         sXkADZ31m7oqL24vC70ViNBeBPxoHVAWaVaX2G5HjVBhfYqb5086/pDuPccWawedy5
         +WD6iAwcriLI7GLmSD0ogWd+/loG82HDl5kzh3nY=
From:   Luca Weiss <luca@z3ntu.xyz>
Cc:     Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iio: light: stk3310: Add support for stk3335
Date:   Mon,  3 Jun 2019 21:20:39 +0200
Message-Id: <20190603192040.24101-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Martijn Braam <martijn@brixit.nl>

The stk3335 light/proximity sensor is similar to the stk3310 and stk3311
sensors and works with the stk3310 driver.

Signed-off-by: Martijn Braam <martijn@brixit.nl>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/iio/light/stk3310.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 6e2a169da950..a25cc35f334e 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -40,6 +40,7 @@
 
 #define STK3310_CHIP_ID_VAL			0x13
 #define STK3311_CHIP_ID_VAL			0x1D
+#define STK3335_CHIP_ID_VAL			0x51
 #define STK3310_PSINT_EN			0x01
 #define STK3310_PS_MAX_VAL			0xFFFF
 
@@ -454,7 +455,8 @@ static int stk3310_init(struct iio_dev *indio_dev)
 		return ret;
 
 	if (chipid != STK3310_CHIP_ID_VAL &&
-	    chipid != STK3311_CHIP_ID_VAL) {
+	    chipid != STK3311_CHIP_ID_VAL &&
+	    chipid != STK3335_CHIP_ID_VAL) {
 		dev_err(&client->dev, "invalid chip id: 0x%x\n", chipid);
 		return -ENODEV;
 	}
@@ -666,6 +668,7 @@ static SIMPLE_DEV_PM_OPS(stk3310_pm_ops, stk3310_suspend, stk3310_resume);
 static const struct i2c_device_id stk3310_i2c_id[] = {
 	{"STK3310", 0},
 	{"STK3311", 0},
+	{"STK3335", 0},
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, stk3310_i2c_id);
@@ -673,6 +676,7 @@ MODULE_DEVICE_TABLE(i2c, stk3310_i2c_id);
 static const struct acpi_device_id stk3310_acpi_id[] = {
 	{"STK3310", 0},
 	{"STK3311", 0},
+	{"STK3335", 0},
 	{}
 };
 
-- 
2.21.0

