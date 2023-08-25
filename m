Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A64778841F
	for <lists+linux-iio@lfdr.de>; Fri, 25 Aug 2023 11:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjHYJ4x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Aug 2023 05:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjHYJ4c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Aug 2023 05:56:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454551FD3
        for <linux-iio@vger.kernel.org>; Fri, 25 Aug 2023 02:56:29 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RXFg20SCRzfbms;
        Fri, 25 Aug 2023 17:54:54 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 25 Aug
 2023 17:56:26 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <linux-iio@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] staging: iio: Use devm_clk_get_enabled() helper function
Date:   Fri, 25 Aug 2023 17:56:12 +0800
Message-ID: <20230825095612.2972892-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The devm_clk_get_enabled() helper:
    - calls devm_clk_get()
    - calls clk_prepare_enable() and registers what is needed in order to
      call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the need of a dedicated function used
with devm_add_action_or_reset().

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/staging/iio/frequency/ad9832.c        | 15 +------------
 drivers/staging/iio/frequency/ad9834.c        | 20 ++---------------
 .../staging/iio/impedance-analyzer/ad5933.c   | 22 ++-----------------
 3 files changed, 5 insertions(+), 52 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 6f9eebd6c7ee..6c390c4eb26d 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -299,11 +299,6 @@ static void ad9832_reg_disable(void *reg)
 	regulator_disable(reg);
 }
 
-static void ad9832_clk_disable(void *clk)
-{
-	clk_disable_unprepare(clk);
-}
-
 static int ad9832_probe(struct spi_device *spi)
 {
 	struct ad9832_platform_data *pdata = dev_get_platdata(&spi->dev);
@@ -350,18 +345,10 @@ static int ad9832_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	st->mclk = devm_clk_get(&spi->dev, "mclk");
+	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
 	if (IS_ERR(st->mclk))
 		return PTR_ERR(st->mclk);
 
-	ret = clk_prepare_enable(st->mclk);
-	if (ret < 0)
-		return ret;
-
-	ret = devm_add_action_or_reset(&spi->dev, ad9832_clk_disable, st->mclk);
-	if (ret)
-		return ret;
-
 	st->spi = spi;
 	mutex_init(&st->lock);
 
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 285df0e489a6..4f35def05fb7 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -394,13 +394,6 @@ static void ad9834_disable_reg(void *data)
 	regulator_disable(reg);
 }
 
-static void ad9834_disable_clk(void *data)
-{
-	struct clk *clk = data;
-
-	clk_disable_unprepare(clk);
-}
-
 static int ad9834_probe(struct spi_device *spi)
 {
 	struct ad9834_state *st;
@@ -429,22 +422,13 @@ static int ad9834_probe(struct spi_device *spi)
 	}
 	st = iio_priv(indio_dev);
 	mutex_init(&st->lock);
-	st->mclk = devm_clk_get(&spi->dev, NULL);
+	st->mclk = devm_clk_get_enabled(&spi->dev, NULL);
 	if (IS_ERR(st->mclk)) {
-		ret = PTR_ERR(st->mclk);
-		return ret;
-	}
-
-	ret = clk_prepare_enable(st->mclk);
-	if (ret) {
 		dev_err(&spi->dev, "Failed to enable master clock\n");
+		ret = PTR_ERR(st->mclk);
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(&spi->dev, ad9834_disable_clk, st->mclk);
-	if (ret)
-		return ret;
-
 	st->spi = spi;
 	st->devid = spi_get_device_id(spi)->driver_data;
 	indio_dev->name = spi_get_device_id(spi)->name;
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 46db6d91542a..e748a5d04e97 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -667,13 +667,6 @@ static void ad5933_reg_disable(void *data)
 	regulator_disable(st->reg);
 }
 
-static void ad5933_clk_disable(void *data)
-{
-	struct ad5933_state *st = data;
-
-	clk_disable_unprepare(st->mclk);
-}
-
 static int ad5933_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
@@ -712,23 +705,12 @@ static int ad5933_probe(struct i2c_client *client)
 
 	st->vref_mv = ret / 1000;
 
-	st->mclk = devm_clk_get(&client->dev, "mclk");
+	st->mclk = devm_clk_get_enabled(&client->dev, "mclk");
 	if (IS_ERR(st->mclk) && PTR_ERR(st->mclk) != -ENOENT)
 		return PTR_ERR(st->mclk);
 
-	if (!IS_ERR(st->mclk)) {
-		ret = clk_prepare_enable(st->mclk);
-		if (ret < 0)
-			return ret;
-
-		ret = devm_add_action_or_reset(&client->dev,
-					       ad5933_clk_disable,
-					       st);
-		if (ret)
-			return ret;
-
+	if (!IS_ERR(st->mclk))
 		ext_clk_hz = clk_get_rate(st->mclk);
-	}
 
 	if (ext_clk_hz) {
 		st->mclk_hz = ext_clk_hz;
-- 
2.34.1

