Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CDE5BCF5A
	for <lists+linux-iio@lfdr.de>; Mon, 19 Sep 2022 16:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiISOnG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Sep 2022 10:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiISOnF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2022 10:43:05 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84475647D
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 07:43:03 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MWS682l4DzKFHs
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 22:41:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.102.38])
        by APP2 (Coremail) with SMTP id Syh0CgBHmnP1fyhjSQJVBA--.59126S4;
        Mon, 19 Sep 2022 22:43:01 +0800 (CST)
From:   Wei Yongjun <weiyongjun@huaweicloud.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        Tomas Melin <tomas.melin@vaisala.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: [PATCH] iio: accel: sca3300: Silent no spi_device_id warning
Date:   Mon, 19 Sep 2022 15:00:18 +0000
Message-Id: <20220919150019.823401-1-weiyongjun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBHmnP1fyhjSQJVBA--.59126S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4kCryrtr1DZr47uFyDZFb_yoWDKrb_C3
        45Xry3WF4fury8Way5tr13Zr9Yg3yjvrn5Xr1DtFZxCFySgrnYkFWkZF47JryrW34UJas8
        AF97XFn5Cr47tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUboxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUCVW8Jw
        CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
        WIevJa73UjIFyTuYvjxUrku4UUUUU
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

Add spi_device_id entries to silent following SPI warning:

SPI driver sca3300 has no spi_device_id for murata,scl3300

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/iio/accel/sca3300.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index eaa0c9cfda44..693fbe8d6cb9 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -679,12 +679,20 @@ static const struct of_device_id sca3300_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, sca3300_dt_ids);
 
+static const struct spi_device_id sca3300_ids[] = {
+	{ "sca3300" },
+	{ "scl3300" },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, sca3300_ids);
+
 static struct spi_driver sca3300_driver = {
-	.driver = {
+	.driver   = {
 		.name		= SCA3300_ALIAS,
 		.of_match_table = sca3300_dt_ids,
 	},
-	.probe	= sca3300_probe,
+	.probe	  = sca3300_probe,
+	.id_table = sca3300_ids,
 };
 module_spi_driver(sca3300_driver);
 
-- 
2.34.1

