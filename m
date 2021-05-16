Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAF8382037
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 19:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhEPR1s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 13:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229942AbhEPR1r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 13:27:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F19061159;
        Sun, 16 May 2021 17:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621185992;
        bh=FYLnYsIF9gx0a4haz/QfWKTSPpLrKEedYkGMqxKASII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oKee4MHgjdCARmdzOJsk8xAWfsGBhyrTRLPgzpvmRcRgkzPfx3dTN5XysgxtkpVwM
         q728YU4y39Nj0a0UNC2La1110G3u6s5s0jajx18eUcX/rXMY40s406okOhxufB6I8T
         irRVNQcQ3Fu5AR7sERoEx5Ju0lDSqKjlQlCmITa74NytaN3ljd+2Gru4z4rrQHYWid
         ROMF1KkBeBheZXzhaPkDvvXQWibi8ehoDOahgWm8OwtFSoGBLF5VY9Zwtdkr8w+CPW
         YK7xSxG71bqVZ/N2Ix3liIt5cD8PhLqnZNcpDckRE673WbZnO8izVzByzp4PJxCHKJ
         dHYwkqdJS4j7A==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <aardelean@deviqon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 8/8] iio: adc: ti-adc161s626: Use devm managed functions for all of probe.
Date:   Sun, 16 May 2021 18:25:20 +0100
Message-Id: <20210516172520.1398835-9-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210516172520.1398835-1-jic23@kernel.org>
References: <20210516172520.1398835-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simplifies error handling and allows us to drop remove entirely.

The regulator handling in this driver was unusual as it would try to
acquire the regulator, but if that failed with an error would continue.

We should get a stub regulator if one isn't provided in DT and an error
could indicate an actual problem preventing the device being powered
(perhaps a need to defer). So this handling is cleaned up (arguably
that might be a fix but given no one has run into it, I haven't broken
it out separately.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/adc/ti-adc161s626.c | 50 ++++++++++++---------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
index 607791ffe7f0..9f2f25cf9a49 100644
--- a/drivers/iio/adc/ti-adc161s626.c
+++ b/drivers/iio/adc/ti-adc161s626.c
@@ -169,6 +169,11 @@ static const struct iio_info ti_adc_info = {
 	.read_raw = ti_adc_read_raw,
 };
 
+static void ti_adc_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
 static int ti_adc_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -203,42 +208,24 @@ static int ti_adc_probe(struct spi_device *spi)
 	}
 
 	data->ref = devm_regulator_get(&spi->dev, "vdda");
-	if (!IS_ERR(data->ref)) {
-		ret = regulator_enable(data->ref);
-		if (ret < 0)
-			return ret;
-	}
+	if (IS_ERR(data->ref))
+		return PTR_ERR(data->ref);
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 ti_adc_trigger_handler, NULL);
-	if (ret)
-		goto error_regulator_disable;
+	ret = regulator_enable(data->ref);
+	if (ret < 0)
+		return ret;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_add_action_or_reset(&spi->dev, ti_adc_reg_disable,
+				       data->ref);
 	if (ret)
-		goto error_unreg_buffer;
-
-	return 0;
+		return ret;
 
-error_unreg_buffer:
-	iio_triggered_buffer_cleanup(indio_dev);
-
-error_regulator_disable:
-	regulator_disable(data->ref);
-
-	return ret;
-}
-
-static int ti_adc_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ti_adc_data *data = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-	regulator_disable(data->ref);
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
+					      ti_adc_trigger_handler, NULL);
+	if (ret)
+		return ret;
 
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct of_device_id ti_adc_dt_ids[] = {
@@ -261,7 +248,6 @@ static struct spi_driver ti_adc_driver = {
 		.of_match_table = ti_adc_dt_ids,
 	},
 	.probe		= ti_adc_probe,
-	.remove		= ti_adc_remove,
 	.id_table	= ti_adc_id,
 };
 module_spi_driver(ti_adc_driver);
-- 
2.31.1

