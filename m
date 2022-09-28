Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6125ED399
	for <lists+linux-iio@lfdr.de>; Wed, 28 Sep 2022 05:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiI1DsC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Sep 2022 23:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiI1DsA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Sep 2022 23:48:00 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC2511A68E
        for <linux-iio@vger.kernel.org>; Tue, 27 Sep 2022 20:47:57 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Mcj7z1fXXzK1vW
        for <linux-iio@vger.kernel.org>; Wed, 28 Sep 2022 11:45:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.102.38])
        by APP2 (Coremail) with SMTP id Syh0CgBH53DqwzNjlSkKBg--.31859S4;
        Wed, 28 Sep 2022 11:47:55 +0800 (CST)
From:   Wei Yongjun <weiyongjun@huaweicloud.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Ciprian Regus <ciprian.regus@analog.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: ltc2496: Fix possible null-ptr-deref in ltc2496_probe()
Date:   Wed, 28 Sep 2022 04:09:48 +0000
Message-Id: <20220928040949.581092-1-weiyongjun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBH53DqwzNjlSkKBg--.31859S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4Duw43Jr18Wryfur1DGFg_yoW8Wr4kpa
        1DAryDCrWF9FWUKF15Xw4UZFy5tw4fCa47WF95Gas09F1ruryYvw42ka47Zr4xJFW0yasI
        y3WUGrWUKFWDZw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
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
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

KASAN report null-ptr-deref as follows:

KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 282 Comm: python3 Tainted: G N 6.0.0-rc7-next-20220927+ #153
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:ltc2497core_probe+0x77/0x440 [ltc2497_core]
Call Trace:
 <TASK>
 ltc2496_probe+0xf4/0x150
 spi_probe+0x158/0x1f0 drivers/spi/spi.c:421
 call_driver_probe drivers/base/dd.c:560 [inline]
 really_probe+0x207/0x750 drivers/base/dd.c:639
 __driver_probe_device+0x229/0x2a0 drivers/base/dd.c:778
 device_driver_attach+0xb8/0x1e0 drivers/base/dd.c:1105

This happend when probe ltc2496 device with spi device id but without
dts, device_get_match_data() return null chip_info. Fix it by adding
null check for chip_info in ltc2496_probe().

Fixes: 1695c52a1260 ("drivers: iio: adc: ltc2497: Rename the LTC2499 iio device")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

diff --git a/drivers/iio/adc/ltc2496.c b/drivers/iio/adc/ltc2496.c
index 2593fa4322eb..a7353c3dd006 100644
--- a/drivers/iio/adc/ltc2496.c
+++ b/drivers/iio/adc/ltc2496.c
@@ -76,6 +76,8 @@ static int ltc2496_probe(struct spi_device *spi)
 	st->spi = spi;
 	st->common_ddata.result_and_measure = ltc2496_result_and_measure;
 	st->common_ddata.chip_info = device_get_match_data(dev);
+	if (!st->common_ddata.chip_info)
+		return -ENODEV;
 
 	return ltc2497core_probe(dev, indio_dev);
 }
-- 
2.34.1

