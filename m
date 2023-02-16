Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125E069969E
	for <lists+linux-iio@lfdr.de>; Thu, 16 Feb 2023 15:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBPOHq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Feb 2023 09:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBPOHq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Feb 2023 09:07:46 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF6F1B335
        for <linux-iio@vger.kernel.org>; Thu, 16 Feb 2023 06:07:44 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSev9-0002pN-1z; Thu, 16 Feb 2023 15:07:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSev4-005NMl-29; Thu, 16 Feb 2023 15:07:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSev4-00432u-Av; Thu, 16 Feb 2023 15:07:30 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, kernel@pengutronix.de
Cc:     Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: adc: meson_saradc: Better handle BL30 not releaseing the hardware
Date:   Thu, 16 Feb 2023 15:07:25 +0100
Message-Id: <20230216140725.1181867-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2539; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=KZdpbbbUsYmkCke9LHHnK/zq1DqCnV5CR7J0anvetnE=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBj7jiZLIduR6lon2oWtpeLvCnuQmd4PLmHteVCZ Z6gIajQhR+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY+44mQAKCRDB/BR4rcrs CQBNB/928xQq4fPeOYoLbi0j2ro5FOg5WJAuYzDjfwf36vP+Bc5SzH6JIlqIDnp31ZidP/WKzKR 3yzzkuFEQqNH1x0oKvehaZpX1jaiKhxsIYRnUeNf4ir1TKT9XIXjbJYwXJjAn644+RvYiNGae5U 3aNVF3ksW7BGlY1R8X6FDOesyRkkkmQCXI7AlBZffcl+WcNoVyMw480/Ac8bp52Z4xR/8+JRzSz OF98G2eI9aPKkWeqv5RdifESBcnPA2ah4KIKcyQOghGcysDh1JTvWHgPATbRuVbr0N0UUQmg3jj LhGyJS8EzNPDSOjx4uItw+tqM1345BnMh0Ze9TmwEL9fuihO
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

So only skip hardware accesses with an error message if
meson_sar_adc_lock() fails, but disable clocks and regulator and return
zero to suppress another error message by the driver core.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

maybe someone with more hardware specific knowledge can improve the
procedure here. Maybe some HW access is fine even without the lock to
quiescent it, or maybe the lock can be dropped completely? Or the
ordering can be changed to reduce the number of if blocks.

Best regards
Uwe

 drivers/iio/adc/meson_saradc.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 85b6826cc10c..636fee27b6b2 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -957,29 +957,30 @@ static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
 	return ret;
 }
 
-static int meson_sar_adc_hw_disable(struct iio_dev *indio_dev)
+static void meson_sar_adc_hw_disable(struct iio_dev *indio_dev)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
 	int ret;
 
 	ret = meson_sar_adc_lock(indio_dev);
 	if (ret)
-		return ret;
+		dev_err(indio_dev->dev.parent, "Failed to lock ADC (%pE)\n", ERR_PTR(ret));
 
 	clk_disable_unprepare(priv->adc_clk);
 
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
-			   MESON_SAR_ADC_REG3_ADC_EN, 0);
+	if (!ret) {
+		regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
+				   MESON_SAR_ADC_REG3_ADC_EN, 0);
 
-	meson_sar_adc_set_bandgap(indio_dev, false);
+		meson_sar_adc_set_bandgap(indio_dev, false);
+	}
 
 	clk_disable_unprepare(priv->core_clk);
 
 	regulator_disable(priv->vref);
 
-	meson_sar_adc_unlock(indio_dev);
-
-	return 0;
+	if (!ret)
+		meson_sar_adc_unlock(indio_dev);
 }
 
 static irqreturn_t meson_sar_adc_irq(int irq, void *data)
@@ -1283,7 +1284,9 @@ static int meson_sar_adc_remove(struct platform_device *pdev)
 
 	iio_device_unregister(indio_dev);
 
-	return meson_sar_adc_hw_disable(indio_dev);
+	meson_sar_adc_hw_disable(indio_dev);
+
+	return 0;
 }
 
 static int meson_sar_adc_suspend(struct device *dev)

base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
-- 
2.39.1

