Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE2937739B
	for <lists+linux-iio@lfdr.de>; Sat,  8 May 2021 20:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhEHSZl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 May 2021 14:25:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhEHSZl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 May 2021 14:25:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 925AA6140F;
        Sat,  8 May 2021 18:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620498279;
        bh=lauP138cIHeiwsPYhU9Sowp8TxNDkBL7ETNWKJD5jIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H130zbrLH/mFCQfPdWd9IpYPVbjIqUeySGkIEoIU/DmRNNXpv1bkPCsk/g+U6HpJN
         1GSkNCwUyakb11UxbtaRA84Sre9+Mwiu2W6K7sfaugiHWoVgtwRWc7ETR0kvZrVVUR
         y6zx9xNdDE1nA6gJTYdCkP2I5XRYOSsSM7yqFZhCjXTOz0UZX7rLtQKcV3qJPZmHed
         dY0U4lDHFTpBot1KjiQ0gofzU98wO9vaM4UZL7sQUuxTI9CsVvGAdnrJowyzzrY7cU
         Fqg0NYsgKL6sM8DM7XC0acjEiuAhTCmQmgjqWpC/AJZ1kc64IjPPMOen7XhbYJGlHu
         CX85YR0cI1BDw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>, alexandru.tachici@analog.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 3/3] iio: adc: ad7124: Use devm_ managed calls for all of probe() + drop remove()
Date:   Sat,  8 May 2021 19:23:19 +0100
Message-Id: <20210508182319.488551-4-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210508182319.488551-1-jic23@kernel.org>
References: <20210508182319.488551-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

As not many steps were not already devm_ managed, use
devm_add_action_or_reset() to handle the rest.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
---
 drivers/iio/adc/ad7124.c | 53 ++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 9c2401c5848e..deb166d2b645 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -719,6 +719,16 @@ static void ad7124_reg_disable(void *r)
 	regulator_disable(r);
 }
 
+static void ad7124_clk_disable(void *c)
+{
+	clk_disable_unprepare(c);
+}
+
+static void ad7124_buffer_cleanup(void *idev)
+{
+	ad_sd_cleanup_buffer_and_trigger(idev);
+}
+
 static int ad7124_probe(struct spi_device *spi)
 {
 	const struct ad7124_chip_info *info;
@@ -740,8 +750,6 @@ static int ad7124_probe(struct spi_device *spi)
 
 	ad_sd_init(&st->sd, indio_dev, spi, &ad7124_sigma_delta_info);
 
-	spi_set_drvdata(spi, indio_dev);
-
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ad7124_info;
@@ -779,48 +787,36 @@ static int ad7124_probe(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
+	ret = devm_add_action_or_reset(&spi->dev, ad7124_clk_disable, st->mclk);
+	if (ret)
+		return ret;
+
 	ret = ad7124_soft_reset(st);
 	if (ret < 0)
-		goto error_clk_disable_unprepare;
+		return ret;
 
 	ret = ad7124_check_chip_id(st);
 	if (ret)
-		goto error_clk_disable_unprepare;
+		return ret;
 
 	ret = ad7124_setup(st);
 	if (ret < 0)
-		goto error_clk_disable_unprepare;
+		return ret;
 
 	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
 	if (ret < 0)
-		goto error_clk_disable_unprepare;
-
-	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(&spi->dev, "Failed to register iio device\n");
-		goto error_remove_trigger;
-	}
+		return ret;
 
-	return 0;
+	ret = devm_add_action_or_reset(&spi->dev, ad7124_buffer_cleanup, indio_dev);
+	if (ret)
+		return ret;
 
-error_remove_trigger:
-	ad_sd_cleanup_buffer_and_trigger(indio_dev);
-error_clk_disable_unprepare:
-	clk_disable_unprepare(st->mclk);
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
+	if (ret)
+		dev_err(&spi->dev, "Failed to register iio device\n");
 
 	return ret;
-}
 
-static int ad7124_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad7124_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	ad_sd_cleanup_buffer_and_trigger(indio_dev);
-	clk_disable_unprepare(st->mclk);
-
-	return 0;
 }
 
 static const struct of_device_id ad7124_of_match[] = {
@@ -838,7 +834,6 @@ static struct spi_driver ad71124_driver = {
 		.of_match_table = ad7124_of_match,
 	},
 	.probe = ad7124_probe,
-	.remove	= ad7124_remove,
 };
 module_spi_driver(ad71124_driver);
 
-- 
2.31.1

