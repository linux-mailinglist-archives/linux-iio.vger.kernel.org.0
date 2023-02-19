Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D8669C27D
	for <lists+linux-iio@lfdr.de>; Sun, 19 Feb 2023 21:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjBSUpO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Feb 2023 15:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjBSUpN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2023 15:45:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237C2193D8
        for <linux-iio@vger.kernel.org>; Sun, 19 Feb 2023 12:45:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pTqYG-0002Zv-Em; Sun, 19 Feb 2023 21:44:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pTqYB-0066oS-9b; Sun, 19 Feb 2023 21:44:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pTqYB-004trh-PA; Sun, 19 Feb 2023 21:44:47 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH v2] iio: adc: meson_saradc: Better handle BL30 not releaseing the hardware
Date:   Sun, 19 Feb 2023 21:44:39 +0100
Message-Id: <20230219204439.1641640-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2545; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=UFb/C7xXSmr0LKHXSvPXadmaMrdeCgJrt6qsOgXktPA=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBj8oo0s1jtpBKhA696qEv+cQLED42WqCqwi4fam y48gJ9dgVuJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY/KKNAAKCRDB/BR4rcrs CeejB/9OmUvOfyvHfDjjyWCsorSUvO1jy2RVvo6aU55Xu8NQspq9ntKSUpz1vwFymaYhjkcADr+ QoiCQMQqfkUtOeECpb0aIO4fuey/2+vUeydRiystje/dPU+xLg1YpAuDFD59SPjwreWOuFkUb6q dvetVwVIEi7SZQgrFPM8nweGWb7hFm/V6iTXT9vE4wzVeQdkINFJvZSvXOTm5Sv81DZEzd3BZ2N HoVxMdH8zMJ92VYp2ny+zCfzdr8eCu0P551TN/gE6uadx1YnuTo23FQadmMNWZKtQvqLhiYf5mD tlO3C+Kn+vCxAxowG7nMk43l3+TzCCpOyQN5mN5RPuE69adL
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

meson_sar_adc_lock() might return an error if BL30 doesn't release its
lock on the hardware. Just returning early from .remove() is wrong
however as this keeps the clocks and regulators on which is never
cleaned up later.

Given the BL30 not giving up its lock is a strong hint for broken
behaviour, and there is nothing we can do about that: Just clean up
ignoring the fact that we're not holding the lock.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

changes since (implicit) v1:

 - Ignore failure to get the lock as suggested by Martin.
 - Adapt a caller for meson_sar_adc_hw_disable() returning void now
   (which used the return value)

 drivers/iio/adc/meson_saradc.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 85b6826cc10c..18937a262af6 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -957,14 +957,18 @@ static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
 	return ret;
 }
 
-static int meson_sar_adc_hw_disable(struct iio_dev *indio_dev)
+static void meson_sar_adc_hw_disable(struct iio_dev *indio_dev)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
 	int ret;
 
+	/*
+	 * If taking the lock fails we have to assume that BL30 is broken. The
+	 * best we can do then is to release the resources anyhow.
+	 */
 	ret = meson_sar_adc_lock(indio_dev);
 	if (ret)
-		return ret;
+		dev_err(indio_dev->dev.parent, "Failed to lock ADC (%pE)\n", ERR_PTR(ret));
 
 	clk_disable_unprepare(priv->adc_clk);
 
@@ -977,9 +981,8 @@ static int meson_sar_adc_hw_disable(struct iio_dev *indio_dev)
 
 	regulator_disable(priv->vref);
 
-	meson_sar_adc_unlock(indio_dev);
-
-	return 0;
+	if (!ret)
+		meson_sar_adc_unlock(indio_dev);
 }
 
 static irqreturn_t meson_sar_adc_irq(int irq, void *data)
@@ -1283,14 +1286,18 @@ static int meson_sar_adc_remove(struct platform_device *pdev)
 
 	iio_device_unregister(indio_dev);
 
-	return meson_sar_adc_hw_disable(indio_dev);
+	meson_sar_adc_hw_disable(indio_dev);
+
+	return 0;
 }
 
 static int meson_sar_adc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 
-	return meson_sar_adc_hw_disable(indio_dev);
+	meson_sar_adc_hw_disable(indio_dev);
+
+	return 0;
 }
 
 static int meson_sar_adc_resume(struct device *dev)

base-commit: 925cf0457d7e62ce08878ffb789189ac08ca8677
-- 
2.39.1

