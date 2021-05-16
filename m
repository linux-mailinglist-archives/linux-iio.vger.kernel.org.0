Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CC3382032
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 19:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhEPR1i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 13:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230001AbhEPR1h (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 13:27:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4695D61185;
        Sun, 16 May 2021 17:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621185982;
        bh=vcGighXB/nwMBylhUKgt5zNuF4UXauX4YRaDaFit/2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GzipMHge0evsMyVTQpfAQl5ynqOJWdThb/xhBbfMYldX27z8noZTSn45hMz7RV8Nm
         GJxCT7uvSuLMaYCDi9xTRt8rZW7NADtgrY5AtapHFbgkCK/M/2YqrZSIIZUfXUQRVN
         8bNkYRt9kkFBkrpaKVAprYghDg5n8yXYaxSyUHCjYl7MPdS74T/0p8/7OniQuoa4T7
         GQWH/+qvbkRJfJqMkVpUeYcOzjFXNrk2shXDXKjQl7XMoPlz2SrjgrZSRroNOk9Rzw
         atAJ1ej0dVcPIEyCpg5z0xGreWFwoY4RP6E9jgcLo89+qMobt+8kkd0Z+quHDmdRvI
         1zIk/fQbegmgg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <aardelean@deviqon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 3/8] iio: adc: max1118: Use devm_ managed functions for all of probe
Date:   Sun, 16 May 2021 18:25:15 +0100
Message-Id: <20210516172520.1398835-4-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210516172520.1398835-1-jic23@kernel.org>
References: <20210516172520.1398835-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This simplifies error handling and allows us to drop the remove
function entirely.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/iio/adc/max1118.c | 46 +++++++++++++--------------------------
 1 file changed, 15 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/adc/max1118.c b/drivers/iio/adc/max1118.c
index 6efb0b43d938..4dfbed63ad7f 100644
--- a/drivers/iio/adc/max1118.c
+++ b/drivers/iio/adc/max1118.c
@@ -201,6 +201,11 @@ static irqreturn_t max1118_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static void max1118_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
 static int max1118_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -225,6 +230,12 @@ static int max1118_probe(struct spi_device *spi)
 		ret = regulator_enable(adc->reg);
 		if (ret)
 			return ret;
+
+		ret = devm_add_action_or_reset(&spi->dev, max1118_reg_disable,
+					       adc->reg);
+		if (ret)
+			return ret;
+
 	}
 
 	spi_set_drvdata(spi, indio_dev);
@@ -243,38 +254,12 @@ static int max1118_probe(struct spi_device *spi)
 	 */
 	max1118_read(spi, 0);
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					max1118_trigger_handler, NULL);
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
+					      max1118_trigger_handler, NULL);
 	if (ret)
-		goto err_reg_disable;
-
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto err_buffer_cleanup;
-
-	return 0;
-
-err_buffer_cleanup:
-	iio_triggered_buffer_cleanup(indio_dev);
-err_reg_disable:
-	if (id->driver_data == max1118)
-		regulator_disable(adc->reg);
-
-	return ret;
-}
-
-static int max1118_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct max1118 *adc = iio_priv(indio_dev);
-	const struct spi_device_id *id = spi_get_device_id(spi);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-	if (id->driver_data == max1118)
-		return regulator_disable(adc->reg);
+		return ret;
 
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id max1118_id[] = {
@@ -299,7 +284,6 @@ static struct spi_driver max1118_spi_driver = {
 		.of_match_table = max1118_dt_ids,
 	},
 	.probe = max1118_probe,
-	.remove = max1118_remove,
 	.id_table = max1118_id,
 };
 module_spi_driver(max1118_spi_driver);
-- 
2.31.1

