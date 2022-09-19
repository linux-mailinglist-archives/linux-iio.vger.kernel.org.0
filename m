Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7E25BD168
	for <lists+linux-iio@lfdr.de>; Mon, 19 Sep 2022 17:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiISPrW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Sep 2022 11:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiISPrU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2022 11:47:20 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2623869B
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 08:47:19 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MWTXH5QtNz6PYly
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 23:45:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.102.38])
        by APP2 (Coremail) with SMTP id Syh0CgAnenMDjyhjjUlXBA--.54978S4;
        Mon, 19 Sep 2022 23:47:16 +0800 (CST)
From:   Wei Yongjun <weiyongjun@huaweicloud.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: adc: ti-ads131e08: Silent no spi_device_id warnings
Date:   Mon, 19 Sep 2022 16:04:33 +0000
Message-Id: <20220919160433.1436035-1-weiyongjun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnenMDjyhjjUlXBA--.54978S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CF48CF43CFW8uw1rXw1DWrg_yoW8Ar1rpa
        98WryYyFyDGr4UuF97X347Ga47uwnayayFgF47G3Za9rsxZryrWr13tF1jv3WDJr4jqw1f
        try3Cr4UGa18JFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUCVW8Jw
        CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
        WIevJa73UjIFyTuYvjxUrcTmDUUUU
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

SPI driver ads131e08 has no spi_device_id for ti,ads131e04
SPI driver ads131e08 has no spi_device_id for ti,ads131e06

Add spi_device_id entries to silent the warnings, and fix the
module autoloading for the driver.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
v1 -> v2: add more info to commit message
          remove comma for the terminator entry as Andy's comment
---
 drivers/iio/adc/ti-ads131e08.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index 5235a93f28bc..9a6bc1be2877 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -926,12 +926,21 @@ static const struct of_device_id ads131e08_of_match[] = {
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

