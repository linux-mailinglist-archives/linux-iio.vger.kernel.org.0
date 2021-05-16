Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526D9382036
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 19:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhEPR1p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 13:27:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhEPR1p (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 13:27:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1198761152;
        Sun, 16 May 2021 17:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621185990;
        bh=EUl4UrCZlkYhrr8A5mA8PR0dEHDpfyRuzx+44D3rhuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CPhZQV23LB1IVooE3oqk1oWS4qK4XAs1Q5guM1oup1sOHzj6nzlUBT7DGfX7fhtr1
         gAc8YoIveb8JO3AvA0WeIQZeFKmSHgX+xT8I0JtlQPQDd+u+C6OBryoISxKEysaV5P
         wc+s4iNyGz5fm8NyxVoYBSXWyIcZqg3ESczyF/0KWddK3IWERzSIUYdZe1vc+mWp6K
         FAr9XtDEIt3EiAZgodeeIrXck5Hw0ApShbLyzayDXAlknJ+15VBtEQIVmdopVtjCTz
         sI5CoCAhlBRZKBIFUDAeHib+yTKVJZ4Ockvn3KNIkyHPZegYLYNYYkeLBGLKfbEUTY
         ie80BUWykzE9A==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <aardelean@deviqon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bogdan Pricop <bogdan.pricop@emutex.com>
Subject: [PATCH 7/8] iio: adc: ti-adc108s102: Use devm managed functions for all of probe()
Date:   Sun, 16 May 2021 18:25:19 +0100
Message-Id: <20210516172520.1398835-8-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210516172520.1398835-1-jic23@kernel.org>
References: <20210516172520.1398835-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simplifies error handling and lets us drop remove() entirely.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Bogdan Pricop <bogdan.pricop@emutex.com>
---
 drivers/iio/adc/ti-adc108s102.c | 45 +++++++++++----------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s102.c
index 183b2245e89b..db902aef2abe 100644
--- a/drivers/iio/adc/ti-adc108s102.c
+++ b/drivers/iio/adc/ti-adc108s102.c
@@ -215,6 +215,11 @@ static const struct iio_info adc108s102_info = {
 	.update_scan_mode	= &adc108s102_update_scan_mode,
 };
 
+static void adc108s102_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
 static int adc108s102_probe(struct spi_device *spi)
 {
 	struct adc108s102_state *st;
@@ -239,6 +244,10 @@ static int adc108s102_probe(struct spi_device *spi)
 			dev_err(&spi->dev, "Cannot enable vref regulator\n");
 			return ret;
 		}
+		ret = devm_add_action_or_reset(&spi->dev, adc108s102_reg_disable,
+					       st->reg);
+		if (ret)
+			return ret;
 
 		ret = regulator_get_voltage(st->reg);
 		if (ret < 0) {
@@ -249,7 +258,6 @@ static int adc108s102_probe(struct spi_device *spi)
 		st->va_millivolt = ret / 1000;
 	}
 
-	spi_set_drvdata(spi, indio_dev);
 	st->spi = spi;
 
 	indio_dev->name = spi->modalias;
@@ -266,40 +274,18 @@ static int adc108s102_probe(struct spi_device *spi)
 	spi_message_init_with_transfers(&st->scan_single_msg,
 					&st->scan_single_xfer, 1);
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 &adc108s102_trigger_handler, NULL);
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
+					      &adc108s102_trigger_handler,
+					      NULL);
 	if (ret)
-		goto error_disable_reg;
+		return ret;
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
+	if (ret)
 		dev_err(&spi->dev, "Failed to register IIO device\n");
-		goto error_cleanup_triggered_buffer;
-	}
-	return 0;
-
-error_cleanup_triggered_buffer:
-	iio_triggered_buffer_cleanup(indio_dev);
-
-error_disable_reg:
-	regulator_disable(st->reg);
-
 	return ret;
 }
 
-static int adc108s102_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct adc108s102_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	regulator_disable(st->reg);
-
-	return 0;
-}
-
 static const struct of_device_id adc108s102_of_match[] = {
 	{ .compatible = "ti,adc108s102" },
 	{ }
@@ -327,7 +313,6 @@ static struct spi_driver adc108s102_driver = {
 		.acpi_match_table = ACPI_PTR(adc108s102_acpi_ids),
 	},
 	.probe		= adc108s102_probe,
-	.remove		= adc108s102_remove,
 	.id_table	= adc108s102_id,
 };
 module_spi_driver(adc108s102_driver);
-- 
2.31.1

