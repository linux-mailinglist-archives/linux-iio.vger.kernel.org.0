Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52211382034
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 19:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhEPR1m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 13:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhEPR1l (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 13:27:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44DB861159;
        Sun, 16 May 2021 17:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621185986;
        bh=wC6NGX0CdW+D0twiApCtPQfyK7VKTpDO3JIp9AfM7s4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s9ekQCr3q1p2NcJ52QXJ0zdn3OwCV/AmVsPvyB+9PX9+gtjkS3PUpuTNt0Q38JLzI
         baAD2JhQCjHpPJhjXuRbtS8rT7hoZz1rDLM2ZEiDSH0lqjZsZ60naUF9CisajY2ibR
         3bqJxJU8ytQ+z1hUA6bM07pWGmiy4fEUbtSLdhP4UcSfQIZVcBViSGFN4KzDN7/6dS
         rV3mwNCu0Opkpr406aSUzVF7x7Od4SZy+SI+iSq/2wpbaDEt0tyCd3MK/On8by/1lO
         /uEw4jLTahDLdczhuv94oAOtowhQ2E+CK2pu/yfQUctz2h6Z9ASG4jWWS84VAJ43xf
         rJqaEOXH8gWdQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <aardelean@deviqon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5/8] iio: adc: ti-adc081c: Use devm managed functions for all of probe()
Date:   Sun, 16 May 2021 18:25:17 +0100
Message-Id: <20210516172520.1398835-6-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210516172520.1398835-1-jic23@kernel.org>
References: <20210516172520.1398835-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simplifies error handling and allows us to drop remove() entirely.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-adc081c.c | 43 ++++++++++++------------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index b64718daa201..16fc608db36a 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -146,6 +146,11 @@ static irqreturn_t adc081c_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static void adc081c_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
 static int adc081c_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -175,6 +180,11 @@ static int adc081c_probe(struct i2c_client *client,
 	if (err < 0)
 		return err;
 
+	err = devm_add_action_or_reset(&client->dev, adc081c_reg_disable,
+				       adc->ref);
+	if (err)
+		return err;
+
 	iio->name = dev_name(&client->dev);
 	iio->modes = INDIO_DIRECT_MODE;
 	iio->info = &adc081c_info;
@@ -182,38 +192,14 @@ static int adc081c_probe(struct i2c_client *client,
 	iio->channels = model->channels;
 	iio->num_channels = ADC081C_NUM_CHANNELS;
 
-	err = iio_triggered_buffer_setup(iio, NULL, adc081c_trigger_handler, NULL);
+	err = devm_iio_triggered_buffer_setup(&client->dev, iio, NULL,
+					      adc081c_trigger_handler, NULL);
 	if (err < 0) {
 		dev_err(&client->dev, "iio triggered buffer setup failed\n");
-		goto err_regulator_disable;
+		return err;
 	}
 
-	err = iio_device_register(iio);
-	if (err < 0)
-		goto err_buffer_cleanup;
-
-	i2c_set_clientdata(client, iio);
-
-	return 0;
-
-err_buffer_cleanup:
-	iio_triggered_buffer_cleanup(iio);
-err_regulator_disable:
-	regulator_disable(adc->ref);
-
-	return err;
-}
-
-static int adc081c_remove(struct i2c_client *client)
-{
-	struct iio_dev *iio = i2c_get_clientdata(client);
-	struct adc081c *adc = iio_priv(iio);
-
-	iio_device_unregister(iio);
-	iio_triggered_buffer_cleanup(iio);
-	regulator_disable(adc->ref);
-
-	return 0;
+	return devm_iio_device_register(&client->dev, iio);
 }
 
 static const struct i2c_device_id adc081c_id[] = {
@@ -238,7 +224,6 @@ static struct i2c_driver adc081c_driver = {
 		.of_match_table = adc081c_of_match,
 	},
 	.probe = adc081c_probe,
-	.remove = adc081c_remove,
 	.id_table = adc081c_id,
 };
 module_i2c_driver(adc081c_driver);
-- 
2.31.1

