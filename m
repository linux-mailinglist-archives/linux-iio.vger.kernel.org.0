Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C125C044F
	for <lists+linux-iio@lfdr.de>; Wed, 21 Sep 2022 18:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiIUQgd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Sep 2022 12:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiIUQgP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Sep 2022 12:36:15 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A79AB06B
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 09:19:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MXk865tQYz6T8ly
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 00:17:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.102.38])
        by APP1 (Coremail) with SMTP id cCh0CgCHDTF5OStjcRGBBA--.52958S9;
        Thu, 22 Sep 2022 00:19:09 +0800 (CST)
From:   Wei Yongjun <weiyongjun@huaweicloud.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: [PATCH 5/5 v3] iio: adc: ad7124: Silence no spi_device_id warnings
Date:   Wed, 21 Sep 2022 16:36:20 +0000
Message-Id: <20220921163620.805879-6-weiyongjun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220921163620.805879-1-weiyongjun@huaweicloud.com>
References: <20220921163620.805879-1-weiyongjun@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCHDTF5OStjcRGBBA--.52958S9
X-Coremail-Antispam: 1UD129KBjvJXoW7CF48CF4UGr45ZF4rGrWfKrg_yoW8Ww4kpa
        1rXFyrArZrWFs3CFn3Xw4UuFy5Gw1Sk3yFgF47Ga9I93ZxZa4rWa1xtF17Ar1UtFWUGay3
        tFW7JryUWF4rArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7Cj
        xVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4
        xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCa
        FVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFV
        Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
        x4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r
        4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
        JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
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

SPI driver ad7124 has no spi_device_id for adi,ad7124-4
SPI driver ad7124 has no spi_device_id for adi,ad7124-8

Add spi_device_id entries to silence the warnings, and ensure driver
module autoloading works.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/iio/adc/ad7124.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 4088786e1026..050a2fbf5c49 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -944,6 +944,8 @@ static int ad7124_probe(struct spi_device *spi)
 	int i, ret;
 
 	info = of_device_get_match_data(&spi->dev);
+	if (!info)
+		info = (void *)spi_get_device_id(spi)->driver_data;
 	if (!info)
 		return -ENODEV;
 
@@ -1021,12 +1023,20 @@ static const struct of_device_id ad7124_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ad7124_of_match);
 
+static const struct spi_device_id ad71124_ids[] = {
+	{ "ad7124-4", (kernel_ulong_t)&ad7124_chip_info_tbl[ID_AD7124_4] },
+	{ "ad7124-8", (kernel_ulong_t)&ad7124_chip_info_tbl[ID_AD7124_8] },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad71124_ids);
+
 static struct spi_driver ad71124_driver = {
 	.driver = {
 		.name = "ad7124",
 		.of_match_table = ad7124_of_match,
 	},
 	.probe = ad7124_probe,
+	.id_table = ad71124_ids,
 };
 module_spi_driver(ad71124_driver);
 
-- 
2.34.1

