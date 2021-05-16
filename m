Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36715382035
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 19:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhEPR1n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 13:27:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhEPR1n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 13:27:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A12661177;
        Sun, 16 May 2021 17:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621185988;
        bh=MjUfJKUaNt5QBQpBVsED2ywmZ8xShQiagy03eEw5FRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IZHbWsro8VpEf4Z7VZIG+zeS4/i4Yjo4ikkhO4wtXBSTkwVTndngoPlWCEcmU/NVw
         ojqciDn3vTaSohSMSDRTFzIFFqLlALpGXJX39dsX/4MlZIa1A97pwnAW+fMGvTCwkU
         FMoigIR/zsrmUCdH5josZ8us0X+iw8LsVpHGylypMuvF5C/bjgOu62pFwKrfXQFAU1
         cEvNGC6nVp2U0KNiNa6nmyIFa/dHYHDc/WScE7JFdQDM5El6P2k/Df/u5fgtfpmgq7
         XOBfVwyoR70WGaDT4kvaEEwVo6VITKDjzlh+adJfPqN9rva3B3Lh1lcUXyx3JFzXgP
         nkcUzKBgmARUQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <aardelean@deviqon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 6/8] iio: adc: ti-adc0832: Use devm managed functions for all of probe()
Date:   Sun, 16 May 2021 18:25:18 +0100
Message-Id: <20210516172520.1398835-7-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210516172520.1398835-1-jic23@kernel.org>
References: <20210516172520.1398835-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simplifies error handling, plus allows us to drop the remove()
function entirely.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/iio/adc/ti-adc0832.c | 39 +++++++++++-------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/adc/ti-adc0832.c b/drivers/iio/adc/ti-adc0832.c
index 0261b3cfc92b..fb5e72600b96 100644
--- a/drivers/iio/adc/ti-adc0832.c
+++ b/drivers/iio/adc/ti-adc0832.c
@@ -236,6 +236,11 @@ static irqreturn_t adc0832_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static void adc0832_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
 static int adc0832_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -287,36 +292,17 @@ static int adc0832_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	spi_set_drvdata(spi, indio_dev);
-
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 adc0832_trigger_handler, NULL);
+	ret = devm_add_action_or_reset(&spi->dev, adc0832_reg_disable,
+				       adc->reg);
 	if (ret)
-		goto err_reg_disable;
+		return ret;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
+					      adc0832_trigger_handler, NULL);
 	if (ret)
-		goto err_buffer_cleanup;
-
-	return 0;
-err_buffer_cleanup:
-	iio_triggered_buffer_cleanup(indio_dev);
-err_reg_disable:
-	regulator_disable(adc->reg);
-
-	return ret;
-}
-
-static int adc0832_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct adc0832 *adc = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-	regulator_disable(adc->reg);
+		return ret;
 
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct of_device_id adc0832_dt_ids[] = {
@@ -343,7 +329,6 @@ static struct spi_driver adc0832_driver = {
 		.of_match_table = adc0832_dt_ids,
 	},
 	.probe = adc0832_probe,
-	.remove = adc0832_remove,
 	.id_table = adc0832_id,
 };
 module_spi_driver(adc0832_driver);
-- 
2.31.1

