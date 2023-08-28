Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5992978A5BE
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 08:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjH1G2G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 02:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjH1G17 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 02:27:59 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4979D109
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 23:27:56 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RZ0tx5BjZzrSV0;
        Mon, 28 Aug 2023 14:26:17 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 28 Aug
 2023 14:27:53 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next v3] iio: frequency: adf4350: Use device managed functions and fix power down issue.
Date:   Mon, 28 Aug 2023 14:27:16 +0800
Message-ID: <20230828062717.2310219-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The devm_clk_get_enabled() helper:
    - calls devm_clk_get()
    - calls clk_prepare_enable() and registers what is needed in order to
      call clk_disable_unprepare() when needed, as a managed resource.

Also replace devm_regulator_get() and regulator_enable() with
devm_regulator_get_enable() helper and remove regulator_disable().

Replace iio_device_register() with devm_iio_device_register() and remove
iio_device_unregister().

And st->reg is not used anymore, so remove it.

As Jonathan pointed out, couple of things that are wrong:

1) The device is powered down 'before' we unregister it with the
   subsystem and as such userspace interfaces are still exposed which
   probably won't do the right thing if the chip is powered down.

2) This isn't done in the error paths in probe.

To solve this problem, register a new callback adf4350_power_down()
with devm_add_action_or_reset(), to enable software power down in both
error and device detach path. So the remove function can be removed.

Remove spi_set_drvdata() from the probe function, since spi_get_drvdata()
is not used anymore.

Fixes: e31166f0fd48 ("iio: frequency: New driver for Analog Devices ADF4350/ADF4351 Wideband Synthesizers")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Jonathan Cameron <jic23@kernel.org>
---
v3:
- Add a device managed hook to enable software power down.
- Remove the remove function.
- Remove the spi_set_drvdata() call in probe function.
- Add the fix tag.
- Update the commit message and title.
v2:
- Also use devm_regulator_get_enable() and devm_iio_device_register().
- Update the commit message and title.
---
 drivers/iio/frequency/adf4350.c | 77 +++++++++++----------------------
 1 file changed, 26 insertions(+), 51 deletions(-)

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 85e289700c3c..2c17110f3b61 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -33,7 +33,6 @@ enum {
 
 struct adf4350_state {
 	struct spi_device		*spi;
-	struct regulator		*reg;
 	struct gpio_desc		*lock_detect_gpiod;
 	struct adf4350_platform_data	*pdata;
 	struct clk			*clk;
@@ -469,6 +468,15 @@ static struct adf4350_platform_data *adf4350_parse_dt(struct device *dev)
 	return pdata;
 }
 
+static void adf4350_power_down(void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct adf4350_state *st = iio_priv(indio_dev);
+
+	st->regs[ADF4350_REG2] |= ADF4350_REG2_POWER_DOWN_EN;
+	adf4350_sync_config(st);
+}
+
 static int adf4350_probe(struct spi_device *spi)
 {
 	struct adf4350_platform_data *pdata;
@@ -491,31 +499,21 @@ static int adf4350_probe(struct spi_device *spi)
 	}
 
 	if (!pdata->clkin) {
-		clk = devm_clk_get(&spi->dev, "clkin");
+		clk = devm_clk_get_enabled(&spi->dev, "clkin");
 		if (IS_ERR(clk))
-			return -EPROBE_DEFER;
-
-		ret = clk_prepare_enable(clk);
-		if (ret < 0)
-			return ret;
+			return PTR_ERR(clk);
 	}
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
-	if (indio_dev == NULL) {
-		ret =  -ENOMEM;
-		goto error_disable_clk;
-	}
+	if (indio_dev == NULL)
+		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
 
-	st->reg = devm_regulator_get(&spi->dev, "vcc");
-	if (!IS_ERR(st->reg)) {
-		ret = regulator_enable(st->reg);
-		if (ret)
-			goto error_disable_clk;
-	}
+	ret = devm_regulator_get_enable(&spi->dev, "vcc");
+	if (ret)
+		return ret;
 
-	spi_set_drvdata(spi, indio_dev);
 	st->spi = spi;
 	st->pdata = pdata;
 
@@ -544,47 +542,25 @@ static int adf4350_probe(struct spi_device *spi)
 
 	st->lock_detect_gpiod = devm_gpiod_get_optional(&spi->dev, NULL,
 							GPIOD_IN);
-	if (IS_ERR(st->lock_detect_gpiod)) {
-		ret = PTR_ERR(st->lock_detect_gpiod);
-		goto error_disable_reg;
-	}
+	if (IS_ERR(st->lock_detect_gpiod))
+		return PTR_ERR(st->lock_detect_gpiod);
 
 	if (pdata->power_up_frequency) {
 		ret = adf4350_set_freq(st, pdata->power_up_frequency);
 		if (ret)
-			goto error_disable_reg;
+			return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_add_action_or_reset(&spi->dev, adf4350_power_down, indio_dev);
 	if (ret)
-		goto error_disable_reg;
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to add action to managed power down\n");
 
-	return 0;
-
-error_disable_reg:
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
-error_disable_clk:
-	clk_disable_unprepare(clk);
-
-	return ret;
-}
-
-static void adf4350_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct adf4350_state *st = iio_priv(indio_dev);
-	struct regulator *reg = st->reg;
-
-	st->regs[ADF4350_REG2] |= ADF4350_REG2_POWER_DOWN_EN;
-	adf4350_sync_config(st);
-
-	iio_device_unregister(indio_dev);
-
-	clk_disable_unprepare(st->clk);
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
+	if (ret)
+		return ret;
 
-	if (!IS_ERR(reg))
-		regulator_disable(reg);
+	return 0;
 }
 
 static const struct of_device_id adf4350_of_match[] = {
@@ -607,7 +583,6 @@ static struct spi_driver adf4350_driver = {
 		.of_match_table = adf4350_of_match,
 	},
 	.probe		= adf4350_probe,
-	.remove		= adf4350_remove,
 	.id_table	= adf4350_id,
 };
 module_spi_driver(adf4350_driver);
-- 
2.34.1

