Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CBB788549
	for <lists+linux-iio@lfdr.de>; Fri, 25 Aug 2023 12:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236991AbjHYK6X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Aug 2023 06:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238611AbjHYK6Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Aug 2023 06:58:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1447B1BCC
        for <linux-iio@vger.kernel.org>; Fri, 25 Aug 2023 03:58:14 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RXGzj3jf7ztSJw;
        Fri, 25 Aug 2023 18:54:25 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 25 Aug
 2023 18:58:11 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@tuxon.dev>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <Michael.Hennerich@analog.com>, <heiko@sntech.de>,
        <yangyingliang@huawei.com>, <robh@kernel.org>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next 4/4] iio: frequency: adf4350: Use devm_clk_get_enabled() helper function
Date:   Fri, 25 Aug 2023 18:57:46 +0800
Message-ID: <20230825105746.2999548-5-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825105746.2999548-1-ruanjinjie@huawei.com>
References: <20230825105746.2999548-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

This simplifies the code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/iio/frequency/adf4350.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 85e289700c3c..22330d1768ff 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -491,20 +491,14 @@ static int adf4350_probe(struct spi_device *spi)
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
 
@@ -512,7 +506,7 @@ static int adf4350_probe(struct spi_device *spi)
 	if (!IS_ERR(st->reg)) {
 		ret = regulator_enable(st->reg);
 		if (ret)
-			goto error_disable_clk;
+			return ret;
 	}
 
 	spi_set_drvdata(spi, indio_dev);
@@ -564,8 +558,6 @@ static int adf4350_probe(struct spi_device *spi)
 error_disable_reg:
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
-error_disable_clk:
-	clk_disable_unprepare(clk);
 
 	return ret;
 }
@@ -581,8 +573,6 @@ static void adf4350_remove(struct spi_device *spi)
 
 	iio_device_unregister(indio_dev);
 
-	clk_disable_unprepare(st->clk);
-
 	if (!IS_ERR(reg))
 		regulator_disable(reg);
 }
-- 
2.34.1

