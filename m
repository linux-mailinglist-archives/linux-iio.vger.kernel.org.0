Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C203F6AAC
	for <lists+linux-iio@lfdr.de>; Tue, 24 Aug 2021 22:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbhHXUxi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Aug 2021 16:53:38 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:41702 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbhHXUxh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Aug 2021 16:53:37 -0400
Received: from pop-os.home ([90.126.253.178])
        by mwinf5d09 with ME
        id lYsq2500B3riaq203YsqZq; Tue, 24 Aug 2021 22:52:51 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 24 Aug 2021 22:52:51 +0200
X-ME-IP: 90.126.253.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     ardeleanalex@gmail.com, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] iio: adc128s052: Simplify 'adc128_probe()'
Date:   Tue, 24 Aug 2021 22:52:49 +0200
Message-Id: <f20a0eb45957c6931a8f35d035514484a2ac0f3d.1629838169.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Turn 'adc128_probe()' into a full resource managed function to simplify the
code.

This way, the .remove function can be removed.
Doing so, the only 'spi_get_drvdata()' call is removed and the
corresponding 'spi_set_drvdata()' can be removed as well.

Suggested-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

When reviewing, pay special attention to the 'spi_set_drvdata()' call
removal. I recently introduced a regression with a too aggressive cleanup
like that.

This patch should be applied after
https://lore.kernel.org/linux-iio/f33069f0-601b-4bbb-3766-026f7a161912@wanadoo.fr/T/#meb792dcd6540f87d9ae041660ca4738a776e924a
---
 drivers/iio/adc/ti-adc128s052.c | 34 +++++++++++----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index 83c1ae07b3e9..e1afdb775100 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -132,6 +132,13 @@ static const struct iio_info adc128_info = {
 	.read_raw = adc128_read_raw,
 };
 
+static void adc128_disable_regulator(void *data)
+{
+	struct regulator *reg = data;
+
+	regulator_disable(reg);
+}
+
 static int adc128_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -151,8 +158,6 @@ static int adc128_probe(struct spi_device *spi)
 	adc = iio_priv(indio_dev);
 	adc->spi = spi;
 
-	spi_set_drvdata(spi, indio_dev);
-
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &adc128_info;
@@ -167,29 +172,13 @@ static int adc128_probe(struct spi_device *spi)
 	ret = regulator_enable(adc->reg);
 	if (ret < 0)
 		return ret;
-
-	mutex_init(&adc->lock);
-
-	ret = iio_device_register(indio_dev);
+	ret = devm_add_action_or_reset(&spi->dev, adc128_disable_regulator, adc->reg);
 	if (ret)
-		goto err_disable_regulator;
-
-	return 0;
-
-err_disable_regulator:
-	regulator_disable(adc->reg);
-	return ret;
-}
-
-static int adc128_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct adc128 *adc = iio_priv(indio_dev);
+		return ret;
 
-	iio_device_unregister(indio_dev);
-	regulator_disable(adc->reg);
+	mutex_init(&adc->lock);
 
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct of_device_id adc128_of_match[] = {
@@ -231,7 +220,6 @@ static struct spi_driver adc128_driver = {
 		.acpi_match_table = ACPI_PTR(adc128_acpi_match),
 	},
 	.probe = adc128_probe,
-	.remove = adc128_remove,
 	.id_table = adc128_id,
 };
 module_spi_driver(adc128_driver);
-- 
2.30.2

