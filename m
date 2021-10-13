Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D1842CAF5
	for <lists+linux-iio@lfdr.de>; Wed, 13 Oct 2021 22:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhJMUeq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Oct 2021 16:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhJMUep (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Oct 2021 16:34:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14885C06174E
        for <linux-iio@vger.kernel.org>; Wed, 13 Oct 2021 13:32:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1makvR-0007Ec-Rk; Wed, 13 Oct 2021 22:32:33 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1makvQ-0005mV-Fl; Wed, 13 Oct 2021 22:32:32 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1makvQ-0000Ps-Es; Wed, 13 Oct 2021 22:32:32 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-iio@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 03/15] iio: accel: bmi088: Make bmi088_accel_core_remove() return void
Date:   Wed, 13 Oct 2021 22:32:11 +0200
Message-Id: <20211013203223.2694577-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013203223.2694577-1-u.kleine-koenig@pengutronix.de>
References: <20211013203223.2694577-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=47b07Tl6Kkb0cBFoLDA3POhzluluk58LiCtxdyy8nM0=; m=MHX9YV6gq1NLCJ2dPZ71KGY8ElRJr9RbowJQ7VgmlTw=; p=cWMbetov6SRlF4mtcqhmc7uOUmFm3pucHYE0XYh2WMI=; g=0d4cb60fa1fdfd38c668842f931ab30f626a9912
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFnQeoACgkQwfwUeK3K7Al99Qf/c9n XdRfOoXMzYI3jxyObbVkKKUdnzb0qvMbiH0j4eMuIupyxmh7lWIYRZxS0mf7NTRUQHzqWNA1z1g0o Sj7pKarAP9T+VdiIDru9prQanLIEZrzaL03tsCk7Hx4YPcnxljLosEu5ZahhqfCG6TwfEwOTiXFwD htuU1GWsPt1ZFmyLwA8k+7eizBBy0ccIxbqQ8sJsEuCAzKWLjOkFjBrMw27+mCMoaUr6WaYhhqEF8 K7DrxDKioKCsCvBzm2npg4j5xyuHOFQKLSufy3/ldHKcNiM/BY7vuKq1XtRemC6/vRnzFBbLOVxIc mh+sG+/BLFa+9obJxvJ8WoYXZCv973w==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Up to now bmi088_accel_core_remove() returns zero unconditionally. Make
it return void instead which makes it easier to see in the callers that
there is no error to handle.

Also the return value of spi remove callbacks is ignored anyway.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/accel/bmi088-accel-core.c | 4 +---
 drivers/iio/accel/bmi088-accel-spi.c  | 4 +++-
 drivers/iio/accel/bmi088-accel.h      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index a06dae5c971d..d74465214feb 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -536,7 +536,7 @@ int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap,
 EXPORT_SYMBOL_GPL(bmi088_accel_core_probe);
 
 
-int bmi088_accel_core_remove(struct device *dev)
+void bmi088_accel_core_remove(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmi088_accel_data *data = iio_priv(indio_dev);
@@ -546,8 +546,6 @@ int bmi088_accel_core_remove(struct device *dev)
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
 	bmi088_accel_power_down(data);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(bmi088_accel_core_remove);
 
diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bmi088-accel-spi.c
index dd1e3f6cf211..758ad2f12896 100644
--- a/drivers/iio/accel/bmi088-accel-spi.c
+++ b/drivers/iio/accel/bmi088-accel-spi.c
@@ -58,7 +58,9 @@ static int bmi088_accel_probe(struct spi_device *spi)
 
 static int bmi088_accel_remove(struct spi_device *spi)
 {
-	return bmi088_accel_core_remove(&spi->dev);
+	bmi088_accel_core_remove(&spi->dev);
+
+	return 0;
 }
 
 static const struct spi_device_id bmi088_accel_id[] = {
diff --git a/drivers/iio/accel/bmi088-accel.h b/drivers/iio/accel/bmi088-accel.h
index 5c25f16b672c..5d40c7cf1cbc 100644
--- a/drivers/iio/accel/bmi088-accel.h
+++ b/drivers/iio/accel/bmi088-accel.h
@@ -13,6 +13,6 @@ extern const struct dev_pm_ops bmi088_accel_pm_ops;
 
 int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 			    const char *name, bool block_supported);
-int bmi088_accel_core_remove(struct device *dev);
+void bmi088_accel_core_remove(struct device *dev);
 
 #endif /* BMI088_ACCEL_H */
-- 
2.30.2

