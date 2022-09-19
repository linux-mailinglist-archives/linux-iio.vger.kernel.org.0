Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1335BCF55
	for <lists+linux-iio@lfdr.de>; Mon, 19 Sep 2022 16:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiISOmv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Sep 2022 10:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiISOmu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2022 10:42:50 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB6C114E
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 07:42:47 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MWS696SqJzl7fS
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 22:41:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.102.38])
        by APP2 (Coremail) with SMTP id Syh0CgC3VW_lfyhj3v9UBA--.41321S4;
        Mon, 19 Sep 2022 22:42:45 +0800 (CST)
From:   Wei Yongjun <weiyongjun@huaweicloud.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: ad9467: Silent no spi_device_id warnings
Date:   Mon, 19 Sep 2022 15:00:03 +0000
Message-Id: <20220919150003.823364-1-weiyongjun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgC3VW_lfyhj3v9UBA--.41321S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4kCryrtF18WryUGr17KFg_yoWkKwb_Cr
        y8ZryxWrWxGryIyF9Fgr1furnxt3WI9rZav3W0yFyFkFy7Xry5tF93Z3W7Jr15ur1YqayD
        uF1fXF1rCr17JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUboxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
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

Add spi_device_id entries to silent following SPI warnings:

SPI driver ad9467 has no spi_device_id for adi,ad9265
SPI driver ad9467 has no spi_device_id for adi,ad9434

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/iio/adc/ad9467.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 7534572f7475..67decbf2e119 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -447,12 +447,21 @@ static const struct of_device_id ad9467_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ad9467_of_match);
 
+static const struct spi_device_id ad9467_ids[] = {
+	{ "ad9265", (kernel_ulong_t)&ad9467_chip_tbl[ID_AD9265] },
+	{ "ad9434", (kernel_ulong_t)&ad9467_chip_tbl[ID_AD9434] },
+	{ "ad9467", (kernel_ulong_t)&ad9467_chip_tbl[ID_AD9467] },
+	{ },
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

