Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424572B26BF
	for <lists+linux-iio@lfdr.de>; Fri, 13 Nov 2020 22:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgKMV3L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Nov 2020 16:29:11 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:52356 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgKMV3J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Nov 2020 16:29:09 -0500
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id CFDB53AA3A7
        for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2020 21:27:33 +0000 (UTC)
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id F1947C0005;
        Fri, 13 Nov 2020 21:27:04 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 7/9] iio: adc: at91_adc: use devm_input_allocate_device
Date:   Fri, 13 Nov 2020 22:26:48 +0100
Message-Id: <20201113212650.507680-8-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201113212650.507680-1-alexandre.belloni@bootlin.com>
References: <20201113212650.507680-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use devm_input_allocate_device to allocate the input device to simplify the
error and remove paths.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/iio/adc/at91_adc.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 76aeebce6f4d..d09ceb315c5a 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -937,9 +937,8 @@ static int at91_ts_register(struct iio_dev *idev,
 {
 	struct at91_adc_state *st = iio_priv(idev);
 	struct input_dev *input;
-	int ret;
 
-	input = input_allocate_device();
+	input = devm_input_allocate_device(&pdev->dev);
 	if (!input) {
 		dev_err(&idev->dev, "Failed to allocate TS device!\n");
 		return -ENOMEM;
@@ -964,8 +963,7 @@ static int at91_ts_register(struct iio_dev *idev,
 		if (st->touchscreen_type != ATMEL_ADC_TOUCHSCREEN_4WIRE) {
 			dev_err(&pdev->dev,
 				"This touchscreen controller only support 4 wires\n");
-			ret = -EINVAL;
-			goto err;
+			return -EINVAL;
 		}
 
 		input_set_abs_params(input, ABS_X, 0, (1 << MAX_RLPOS_BITS) - 1,
@@ -977,20 +975,7 @@ static int at91_ts_register(struct iio_dev *idev,
 	st->ts_input = input;
 	input_set_drvdata(input, st);
 
-	ret = input_register_device(input);
-	if (ret)
-		goto err;
-
-	return ret;
-
-err:
-	input_free_device(st->ts_input);
-	return ret;
-}
-
-static void at91_ts_unregister(struct at91_adc_state *st)
-{
-	input_unregister_device(st->ts_input);
+	return input_register_device(input);
 }
 
 static int at91_adc_probe(struct platform_device *pdev)
@@ -1203,8 +1188,6 @@ static int at91_adc_probe(struct platform_device *pdev)
 	if (!st->touchscreen_type) {
 		at91_adc_trigger_remove(idev);
 		at91_adc_buffer_remove(idev);
-	} else {
-		at91_ts_unregister(st);
 	}
 error_disable_adc_clk:
 	clk_disable_unprepare(st->adc_clk);
@@ -1224,8 +1207,6 @@ static int at91_adc_remove(struct platform_device *pdev)
 	if (!st->touchscreen_type) {
 		at91_adc_trigger_remove(idev);
 		at91_adc_buffer_remove(idev);
-	} else {
-		at91_ts_unregister(st);
 	}
 	clk_disable_unprepare(st->adc_clk);
 	clk_disable_unprepare(st->clk);
-- 
2.28.0

