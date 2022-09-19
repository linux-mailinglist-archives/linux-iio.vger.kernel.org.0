Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881585BCF53
	for <lists+linux-iio@lfdr.de>; Mon, 19 Sep 2022 16:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiISOme (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Sep 2022 10:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiISOmd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2022 10:42:33 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7A225D9
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 07:42:31 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MWS5X3Tz3z6S1Sj
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 22:40:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.102.38])
        by APP1 (Coremail) with SMTP id cCh0CgCndirTfyhjSW4fBA--.65447S4;
        Mon, 19 Sep 2022 22:42:29 +0800 (CST)
From:   Wei Yongjun <weiyongjun@huaweicloud.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: ad7124: Silent no spi_device_id warnings
Date:   Mon, 19 Sep 2022 14:59:45 +0000
Message-Id: <20220919145945.823327-1-weiyongjun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCndirTfyhjSW4fBA--.65447S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4kCryrtF18Xr1Duw48JFb_yoWkurbEkF
        W5XrWxWF1xCF1xAFZYgr1xZr18tayvgrZ5C3W09as3uFyavr1Fka1qyF17Jr1Uur1jga4D
        Cr1rXr1rCry7JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbokYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
        0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
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

SPI driver ad7124 has no spi_device_id for adi,ad7124-4
SPI driver ad7124 has no spi_device_id for adi,ad7124-8

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/iio/adc/ad7124.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 4088786e1026..10a3fc6d26a2 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -1021,12 +1021,20 @@ static const struct of_device_id ad7124_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ad7124_of_match);
 
+static const struct spi_device_id ad71124_ids[] = {
+	{ "ad7124-4", (kernel_ulong_t)&ad7124_chip_info_tbl[ID_AD7124_4] },
+	{ "ad7124-8", (kernel_ulong_t)&ad7124_chip_info_tbl[ID_AD7124_8] },
+	{ },
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

