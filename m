Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74DD5C044E
	for <lists+linux-iio@lfdr.de>; Wed, 21 Sep 2022 18:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiIUQgb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Sep 2022 12:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiIUQgO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Sep 2022 12:36:14 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75088AB05C
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 09:19:10 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MXk8539GQz6T8Jj
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 00:17:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.102.38])
        by APP1 (Coremail) with SMTP id cCh0CgCHDTF5OStjcRGBBA--.52958S5;
        Thu, 22 Sep 2022 00:19:07 +0800 (CST)
From:   Wei Yongjun <weiyongjun@huaweicloud.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: [PATCH 1/5 v3] iio: adc: ti-ads131e08: Silence no spi_device_id warnings
Date:   Wed, 21 Sep 2022 16:36:16 +0000
Message-Id: <20220921163620.805879-2-weiyongjun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220921163620.805879-1-weiyongjun@huaweicloud.com>
References: <20220921163620.805879-1-weiyongjun@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCHDTF5OStjcRGBBA--.52958S5
X-Coremail-Antispam: 1UD129KBjvJXoW7CF48CF43CFW8uw1rXw1DWrg_yoW8CF4Dpa
        98WFyYyFyDGr4UWF93X347Za47uwn7t3yFgF47G3Za9wsxZryrXr1xtF1jy3WDJFyjq3W3
        try5Cr4UGa18XF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjxUzl1vUUUUU
X-CM-SenderInfo: 5zhl50pqjm3046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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

SPI driver ads131e08 has no spi_device_id for ti,ads131e04
SPI driver ads131e08 has no spi_device_id for ti,ads131e06

Add spi_device_id entries to silence the warnings, and ensure driver
module autoloading works.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/iio/adc/ti-ads131e08.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index 5235a93f28bc..fcfc46254313 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -807,6 +807,8 @@ static int ads131e08_probe(struct spi_device *spi)
 	int ret;
 
 	info = device_get_match_data(&spi->dev);
+	if (!info)
+		info = (void *)spi_get_device_id(spi)->driver_data;
 	if (!info) {
 		dev_err(&spi->dev, "failed to get match data\n");
 		return -ENODEV;
@@ -926,12 +928,21 @@ static const struct of_device_id ads131e08_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ads131e08_of_match);
 
+static const struct spi_device_id ads131e08_ids[] = {
+	{ "ads131e04", (kernel_ulong_t)&ads131e08_info_tbl[ads131e04] },
+	{ "ads131e06", (kernel_ulong_t)&ads131e08_info_tbl[ads131e06] },
+	{ "ads131e08", (kernel_ulong_t)&ads131e08_info_tbl[ads131e08] },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ads131e08_ids);
+
 static struct spi_driver ads131e08_driver = {
 	.driver = {
 		.name = "ads131e08",
 		.of_match_table = ads131e08_of_match,
 	},
 	.probe = ads131e08_probe,
+	.id_table = ads131e08_ids,
 };
 module_spi_driver(ads131e08_driver);
 
-- 
2.34.1

