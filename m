Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4469F3492C6
	for <lists+linux-iio@lfdr.de>; Thu, 25 Mar 2021 14:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhCYNL2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Mar 2021 09:11:28 -0400
Received: from www381.your-server.de ([78.46.137.84]:34748 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhCYNLL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Mar 2021 09:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=xqzQUQSa5ulj5MbZ4WbaCYwA7p9yxAZqLfjv3Z6lorQ=; b=lJinFmKXBKz+02+iedwHUSQKvs
        23acK3ivCN9C4bl78VtY/v55fo+djyrZF2mER2NsxFn/O3CgLPFpgeohfdqAvFseQdB1sxEZDEqxg
        XHCTkJ0U8CohiDmx96xKxJ+Zuk2uMdoj5Da9myQykn5UwTkAErM0/n+j+H3nAreTb0/btIRrX088O
        BoyxZe6W8RDbyVj+lbLU9wgORiF51WZFZNOGNQvE6i1lk6tED1GWhgC9IfdOilywmViwHTEuUQZPV
        Ny4mseNNVXhMAdhmCtTu8gjrH2eHXOdrHYmxUtS/CG3gf6Vw5ZLhyj3PqODk8g5S5Bh1t4OJYlkgT
        56eTrGIQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lPPlM-0007gO-Uc; Thu, 25 Mar 2021 14:11:00 +0100
Received: from [2001:a61:2aba:2d01:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lPPlM-000Ol3-Qu; Thu, 25 Mar 2021 14:11:00 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] iio: inv_mpu6050: Make interrupt optional
Date:   Thu, 25 Mar 2021 14:10:46 +0100
Message-Id: <20210325131046.13383-2-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210325131046.13383-1-lars@metafoo.de>
References: <20210325131046.13383-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26120/Thu Mar 25 12:15:49 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The inv_mpu6050 driver requires an interrupt for buffered capture. But non
buffered reading for measurements works just fine without an interrupt
connected.

Make the interrupt optional to support this case.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 51 ++++++++++++++--------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 99ee0a218875..cda7b48981c9 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1458,15 +1458,21 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		st->plat_data = *pdata;
 	}
 
-	desc = irq_get_irq_data(irq);
-	if (!desc) {
-		dev_err(dev, "Could not find IRQ %d\n", irq);
-		return -EINVAL;
-	}
+	if (irq > 0) {
+		desc = irq_get_irq_data(irq);
+		if (!desc) {
+			dev_err(dev, "Could not find IRQ %d\n", irq);
+			return -EINVAL;
+		}
 
-	irq_type = irqd_get_trigger_type(desc);
-	if (!irq_type)
+		irq_type = irqd_get_trigger_type(desc);
+		if (!irq_type)
+			irq_type = IRQF_TRIGGER_RISING;
+	} else {
+		/* Doesn't really matter, use the default */
 		irq_type = IRQF_TRIGGER_RISING;
+	}
+
 	if (irq_type & IRQF_TRIGGER_RISING)	// rising or both-edge
 		st->irq_mask = INV_MPU6050_ACTIVE_HIGH;
 	else if (irq_type == IRQF_TRIGGER_FALLING)
@@ -1592,18 +1598,25 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 
 	indio_dev->info = &mpu_info;
 
-	result = devm_iio_triggered_buffer_setup(dev, indio_dev,
-						 iio_pollfunc_store_time,
-						 inv_mpu6050_read_fifo,
-						 NULL);
-	if (result) {
-		dev_err(dev, "configure buffer fail %d\n", result);
-		return result;
-	}
-	result = inv_mpu6050_probe_trigger(indio_dev, irq_type);
-	if (result) {
-		dev_err(dev, "trigger probe fail %d\n", result);
-		return result;
+	if (irq > 0) {
+		/*
+		 * The driver currently only supports buffered capture with its
+		 * own trigger. So no IRQ, no trigger, no buffer
+		 */
+		result = devm_iio_triggered_buffer_setup(dev, indio_dev,
+							 iio_pollfunc_store_time,
+							 inv_mpu6050_read_fifo,
+							 NULL);
+		if (result) {
+			dev_err(dev, "configure buffer fail %d\n", result);
+			return result;
+		}
+
+		result = inv_mpu6050_probe_trigger(indio_dev, irq_type);
+		if (result) {
+			dev_err(dev, "trigger probe fail %d\n", result);
+			return result;
+		}
 	}
 
 	result = devm_iio_device_register(dev, indio_dev);
-- 
2.20.1

