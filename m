Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1D33F480E
	for <lists+linux-iio@lfdr.de>; Mon, 23 Aug 2021 11:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhHWJ7m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Aug 2021 05:59:42 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:20357 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbhHWJ7l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Aug 2021 05:59:41 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee9612371520a7-03f0e; Mon, 23 Aug 2021 17:58:42 +0800 (CST)
X-RM-TRANSID: 2ee9612371520a7-03f0e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56123714e86b-c2292;
        Mon, 23 Aug 2021 17:58:42 +0800 (CST)
X-RM-TRANSID: 2ee56123714e86b-c2292
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] iio: adc: twl6030-gpadc: Use the defined variable to clean code
Date:   Mon, 23 Aug 2021 17:59:21 +0800
Message-Id: <20210823095921.16828-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use the defined variable "dev" to make the code cleaner.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/iio/adc/twl6030-gpadc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index 0859f3f7d..5e4fbb033 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -897,7 +897,7 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
 
 	ret = pdata->calibrate(gpadc);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to read calibration registers\n");
+		dev_err(dev, "failed to read calibration registers\n");
 		return ret;
 	}
 
@@ -911,14 +911,14 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
 
 	ret = twl6030_gpadc_enable_irq(TWL6030_GPADC_RT_SW1_EOC_MASK);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to enable GPADC interrupt\n");
+		dev_err(dev, "failed to enable GPADC interrupt\n");
 		return ret;
 	}
 
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, TWL6030_GPADCS,
 					TWL6030_REG_TOGGLE1);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to enable GPADC module\n");
+		dev_err(dev, "failed to enable GPADC module\n");
 		return ret;
 	}
 
-- 
2.20.1.windows.1



