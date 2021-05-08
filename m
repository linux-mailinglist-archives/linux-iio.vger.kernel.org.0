Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7713C377399
	for <lists+linux-iio@lfdr.de>; Sat,  8 May 2021 20:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhEHSZh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 May 2021 14:25:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhEHSZg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 May 2021 14:25:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B04C611BE;
        Sat,  8 May 2021 18:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620498275;
        bh=2YIUztgQys0rC77/fi0wyJ5hjTZ0q0AGYDBVLa4bD8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SqwVbjdi/EC/tI/OG0ns2l+32cqzk2QYTSQxBuAJoICVKDi5i0uuZzMKxkNMDVrSV
         kOoyi6nBu+QDRZneM3Rx+njPMU6JQNf0g/Y8W1ikLX1nPE51Xqyimz2qSQibKZx3iX
         l5ZGUYEvG8MTaPIl96/T1+ZKZpui3VBueWUFt6PRdz/Et6MwLPyY6H8OUskm3nnfca
         0p3R6fl+PjL7qFR4et2jQUw3lnwgaPXhcQQg0yY/K2cAFSmiMH/11UXSZc/l1VpFaT
         OzACY11HMbkEWiBYJZy1VA7JP58ej3KeqXZEZKTNfaACzySP/xrp7YtYQEbCSdm0cF
         uiSyeVa3trWhw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>, alexandru.tachici@analog.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/3] iio: adc: ad7124: Fix missbalanced regulator enable / disable on error.
Date:   Sat,  8 May 2021 19:23:17 +0100
Message-Id: <20210508182319.488551-2-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210508182319.488551-1-jic23@kernel.org>
References: <20210508182319.488551-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

If the devm_regulator_get() call succeeded but not the regulator_enable()
then regulator_disable() would be called on a regulator that was not
enabled.

Fix this by moving regulator enabling / disabling over to
devm_ management via devm_add_action_or_reset.

Fixes: b3af341bbd96 ("iio: adc: Add ad7124 support")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
---
 drivers/iio/adc/ad7124.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 766c73333604..c0d0870a29ff 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -707,6 +707,11 @@ static int ad7124_setup(struct ad7124_state *st)
 	return ret;
 }
 
+static void ad7124_reg_disable(void *r)
+{
+	regulator_disable(r);
+}
+
 static int ad7124_probe(struct spi_device *spi)
 {
 	const struct ad7124_chip_info *info;
@@ -752,17 +757,20 @@ static int ad7124_probe(struct spi_device *spi)
 		ret = regulator_enable(st->vref[i]);
 		if (ret)
 			return ret;
+
+		ret = devm_add_action_or_reset(&spi->dev, ad7124_reg_disable,
+					       st->vref[i]);
+		if (ret)
+			return ret;
 	}
 
 	st->mclk = devm_clk_get(&spi->dev, "mclk");
-	if (IS_ERR(st->mclk)) {
-		ret = PTR_ERR(st->mclk);
-		goto error_regulator_disable;
-	}
+	if (IS_ERR(st->mclk))
+		return PTR_ERR(st->mclk);
 
 	ret = clk_prepare_enable(st->mclk);
 	if (ret < 0)
-		goto error_regulator_disable;
+		return ret;
 
 	ret = ad7124_soft_reset(st);
 	if (ret < 0)
@@ -792,11 +800,6 @@ static int ad7124_probe(struct spi_device *spi)
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
 error_clk_disable_unprepare:
 	clk_disable_unprepare(st->mclk);
-error_regulator_disable:
-	for (i = ARRAY_SIZE(st->vref) - 1; i >= 0; i--) {
-		if (!IS_ERR_OR_NULL(st->vref[i]))
-			regulator_disable(st->vref[i]);
-	}
 
 	return ret;
 }
@@ -805,17 +808,11 @@ static int ad7124_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7124_state *st = iio_priv(indio_dev);
-	int i;
 
 	iio_device_unregister(indio_dev);
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
 	clk_disable_unprepare(st->mclk);
 
-	for (i = ARRAY_SIZE(st->vref) - 1; i >= 0; i--) {
-		if (!IS_ERR_OR_NULL(st->vref[i]))
-			regulator_disable(st->vref[i]);
-	}
-
 	return 0;
 }
 
-- 
2.31.1

