Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FD82B26AE
	for <lists+linux-iio@lfdr.de>; Fri, 13 Nov 2020 22:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgKMV1I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Nov 2020 16:27:08 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:39991 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgKMV1I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Nov 2020 16:27:08 -0500
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 21D30240005;
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
Subject: [PATCH 6/9] iio: adc: at91_adc: remove forward declaration
Date:   Fri, 13 Nov 2020 22:26:47 +0100
Message-Id: <20201113212650.507680-7-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201113212650.507680-1-alexandre.belloni@bootlin.com>
References: <20201113212650.507680-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Remove the forward declaration of at91_adc_dt_ids by using
device_get_match_data. Also add const were possible since it is not
discarded by the cast anymore.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/iio/adc/at91_adc.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 9f05eb722f5e..76aeebce6f4d 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -224,7 +224,6 @@ struct at91_adc_state {
 	struct mutex		lock;
 	u8			num_channels;
 	void __iomem		*reg_base;
-	struct at91_adc_reg_desc *registers;
 	u32			startup_time;
 	u8			sample_hold_time;
 	bool			sleep_mode;
@@ -233,7 +232,8 @@ struct at91_adc_state {
 	u32			vref_mv;
 	u32			res;		/* resolution used for convertions */
 	wait_queue_head_t	wq_data_avail;
-	struct at91_adc_caps	*caps;
+	const struct at91_adc_caps *caps;
+	const struct at91_adc_reg_desc *registers;
 
 	/*
 	 * Following ADC channels are shared by touchscreen:
@@ -569,7 +569,7 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
 {
 	struct iio_dev *idev = iio_trigger_get_drvdata(trig);
 	struct at91_adc_state *st = iio_priv(idev);
-	struct at91_adc_reg_desc *reg = st->registers;
+	const struct at91_adc_reg_desc *reg = st->registers;
 	u32 status = at91_adc_readl(st, reg->trigger_register);
 	int value;
 	u8 bit;
@@ -796,8 +796,6 @@ static u32 calc_startup_ticks_9x5(u32 startup_time, u32 adc_clk_khz)
 	return ticks;
 }
 
-static const struct of_device_id at91_adc_dt_ids[];
-
 static int at91_adc_probe_dt_ts(struct device_node *node,
 	struct at91_adc_state *st, struct device *dev)
 {
@@ -1011,8 +1009,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 
 	st = iio_priv(idev);
 
-	st->caps = (struct at91_adc_caps *)
-		of_match_device(at91_adc_dt_ids, &pdev->dev)->data;
+	st->caps = device_get_match_data(&pdev->dev);
 
 	st->use_external = of_property_read_bool(node, "atmel,adc-use-external-triggers");
 
-- 
2.28.0

