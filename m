Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4565C044D
	for <lists+linux-iio@lfdr.de>; Wed, 21 Sep 2022 18:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiIUQgb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Sep 2022 12:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiIUQgO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Sep 2022 12:36:14 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B7BAB06C
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 09:19:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MXk8539CWzKQ9J
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 00:17:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.102.38])
        by APP1 (Coremail) with SMTP id cCh0CgCHDTF5OStjcRGBBA--.52958S7;
        Thu, 22 Sep 2022 00:19:08 +0800 (CST)
From:   Wei Yongjun <weiyongjun@huaweicloud.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: [PATCH 3/5 v3] iio: adc: ad9467: Silence no spi_device_id warnings
Date:   Wed, 21 Sep 2022 16:36:18 +0000
Message-Id: <20220921163620.805879-4-weiyongjun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220921163620.805879-1-weiyongjun@huaweicloud.com>
References: <20220921163620.805879-1-weiyongjun@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCHDTF5OStjcRGBBA--.52958S7
X-Coremail-Antispam: 1UD129KBjvJXoW7CF48CF4kJFy7Cw1xKrWxWFg_yoW8AryxpF
        45GFy5CrZ8GF4UCa1Syw4UuFyjkws7CayFga17G3WagwnxZryrXr4S9F17Ar1jqFWUW3W3
        tFW7ury8GF48ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: 5zhl50pqjm3046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

SPI devices use the spi_device_id for module autoloading even on
systems using device tree, after commit 5fa6863ba692 ("spi: Check
we have a spi_device_id for each DT compatible"), kernel warns as
follows since the spi_device_id is missing:

SPI driver ad9467 has no spi_device_id for adi,ad9265
SPI driver ad9467 has no spi_device_id for adi,ad9434

Add spi_device_id entries to silence the warnings, and ensure driver
module autoloading works.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/iio/adc/ad9467.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 7534572f7475..0621cf59d614 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -387,6 +387,8 @@ static int ad9467_probe(struct spi_device *spi)
 	int ret;
 
 	info = of_device_get_match_data(&spi->dev);
+	if (!info)
+		info = (void *)spi_get_device_id(spi)->driver_data;
 	if (!info)
 		return -ENODEV;
 
@@ -447,12 +449,21 @@ static const struct of_device_id ad9467_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ad9467_of_match);
 
+static const struct spi_device_id ad9467_ids[] = {
+	{ "ad9265", (kernel_ulong_t)&ad9467_chip_tbl[ID_AD9265] },
+	{ "ad9434", (kernel_ulong_t)&ad9467_chip_tbl[ID_AD9434] },
+	{ "ad9467", (kernel_ulong_t)&ad9467_chip_tbl[ID_AD9467] },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad9467_ids);
+
 static struct spi_driver ad9467_driver = {
 	.driver = {
 		.name = "ad9467",
 		.of_match_table = ad9467_of_match,
 	},
 	.probe = ad9467_probe,
+	.id_table = ad9467_ids,
 };
 module_spi_driver(ad9467_driver);
 
-- 
2.34.1

