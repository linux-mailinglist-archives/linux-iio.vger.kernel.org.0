Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FA145ADE3
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbhKWVJW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:39972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234770AbhKWVJW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EA2E60FD8;
        Tue, 23 Nov 2021 21:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701573;
        bh=jhEvIBqlIJt6sfaGuXhurm2bthJCKDNTF1l/blf1JgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EjcAxptoGWNzEePfL/1NVcSd7DYDN3p+Jm/DxI5gUEzGu0VZT5IR3/s5d6U1M6m48
         RjVWBmpq92H/V0g78Do1RbF7NQ3MBsFqr25XbHuNdCL6NJBoh75SSOsMmd9IKXlLs4
         JvS26skrqmIh5dV8zjo5pOGsNLOTPS/R3XJWWvBfa3rwOt1ydywfWLP1hLXUuMhlBI
         y9+Ge/AhNgnB39aDE9bE0WUJ6hiC0pLd1GCqNxjTA5206ZFrjEzLuDmhzlSF/8Q6kA
         ImsTe33e78xlPgvQcrnNE8qtpBcOf66482J+cLpIO8DeO1tSWZiKDHwmQXijQ+QoFN
         giEJC5glbVZPw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 12/49] iio:adc:ad7606: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:42 +0000
Message-Id: <20211123211019.2271440-13-jic23@kernel.org>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123211019.2271440-1-jic23@kernel.org>
References: <20211123211019.2271440-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

The pm_ptr() macro only removes the reference if CONFIG_PM is not
set. It is possible for CONFIG_PM=y without CONFIG_SLEEP, so this
will not always remove the pm_ops structure.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7606.c     | 8 ++------
 drivers/iio/adc/ad7606.h     | 5 -----
 drivers/iio/adc/ad7606_par.c | 2 +-
 drivers/iio/adc/ad7606_spi.c | 2 +-
 4 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 0a60ecc69d38..16a013aad20f 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -695,9 +695,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 }
 EXPORT_SYMBOL_GPL(ad7606_probe);
 
-#ifdef CONFIG_PM_SLEEP
-
-static int ad7606_suspend(struct device *dev)
+static __maybe_unused int ad7606_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad7606_state *st = iio_priv(indio_dev);
@@ -710,7 +708,7 @@ static int ad7606_suspend(struct device *dev)
 	return 0;
 }
 
-static int ad7606_resume(struct device *dev)
+static __maybe_unused int ad7606_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad7606_state *st = iio_priv(indio_dev);
@@ -727,8 +725,6 @@ static int ad7606_resume(struct device *dev)
 SIMPLE_DEV_PM_OPS(ad7606_pm_ops, ad7606_suspend, ad7606_resume);
 EXPORT_SYMBOL_GPL(ad7606_pm_ops);
 
-#endif
-
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 9350ef1f63b5..fd545836790e 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -162,11 +162,6 @@ enum ad7606_supported_device_ids {
 	ID_AD7616,
 };
 
-#ifdef CONFIG_PM_SLEEP
 extern const struct dev_pm_ops ad7606_pm_ops;
-#define AD7606_PM_OPS (&ad7606_pm_ops)
-#else
-#define AD7606_PM_OPS NULL
-#endif
 
 #endif /* IIO_ADC_AD7606_H_ */
diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
index f732b3ac7878..60be3fb4ae39 100644
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -92,7 +92,7 @@ static struct platform_driver ad7606_driver = {
 	.id_table = ad7606_driver_ids,
 	.driver = {
 		.name = "ad7606",
-		.pm = AD7606_PM_OPS,
+		.pm = pm_ptr(&ad7606_pm_ops),
 		.of_match_table = ad7606_of_match,
 	},
 };
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 29945ad07dca..8cc525b4b960 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -352,7 +352,7 @@ static struct spi_driver ad7606_driver = {
 	.driver = {
 		.name = "ad7606",
 		.of_match_table = ad7606_of_match,
-		.pm = AD7606_PM_OPS,
+		.pm = pm_ptr(&ad7606_pm_ops),
 	},
 	.probe = ad7606_spi_probe,
 	.id_table = ad7606_id_table,
-- 
2.34.0

