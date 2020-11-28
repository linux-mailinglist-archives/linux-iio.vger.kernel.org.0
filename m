Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE3B2C760A
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731627AbgK1W3N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 17:29:13 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:49527 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729330AbgK1W3L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Nov 2020 17:29:11 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 706ED60004;
        Sat, 28 Nov 2020 22:28:27 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 01/10] iio: adc: at91_adc: remove at91_adc_ids
Date:   Sat, 28 Nov 2020 23:28:09 +0100
Message-Id: <20201128222818.1910764-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201128222818.1910764-1-alexandre.belloni@bootlin.com>
References: <20201128222818.1910764-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver is DT only since commit ead1c9f376db ("iio: adc: at91_adc:
remove platform data and move defs in driver file"). Remove the leftover
platform_device_id array.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/iio/adc/at91_adc.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 601708168082..8501f3aeeb4e 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -1425,29 +1425,9 @@ static const struct of_device_id at91_adc_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, at91_adc_dt_ids);
 
-static const struct platform_device_id at91_adc_ids[] = {
-	{
-		.name = "at91sam9260-adc",
-		.driver_data = (unsigned long)&at91sam9260_caps,
-	}, {
-		.name = "at91sam9rl-adc",
-		.driver_data = (unsigned long)&at91sam9rl_caps,
-	}, {
-		.name = "at91sam9g45-adc",
-		.driver_data = (unsigned long)&at91sam9g45_caps,
-	}, {
-		.name = "at91sam9x5-adc",
-		.driver_data = (unsigned long)&at91sam9x5_caps,
-	}, {
-		/* terminator */
-	}
-};
-MODULE_DEVICE_TABLE(platform, at91_adc_ids);
-
 static struct platform_driver at91_adc_driver = {
 	.probe = at91_adc_probe,
 	.remove = at91_adc_remove,
-	.id_table = at91_adc_ids,
 	.driver = {
 		   .name = DRIVER_NAME,
 		   .of_match_table = at91_adc_dt_ids,
-- 
2.28.0

