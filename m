Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C2261F6F7
	for <lists+linux-iio@lfdr.de>; Mon,  7 Nov 2022 16:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbiKGPAg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Nov 2022 10:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbiKGPAW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Nov 2022 10:00:22 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C53724E
        for <linux-iio@vger.kernel.org>; Mon,  7 Nov 2022 06:58:22 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N5Z9N16F4z4f42rG
        for <linux-iio@vger.kernel.org>; Mon,  7 Nov 2022 22:58:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.102.38])
        by APP4 (Coremail) with SMTP id gCh0CgCXu9gJHWljrcqLAA--.24151S4;
        Mon, 07 Nov 2022 22:58:19 +0800 (CST)
From:   Wei Yongjun <weiyongjun@huaweicloud.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, "Andrew F. Davis" <afd@ti.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: [PATCH v3] iio: health: afe4403: Fix oob read in afe4403_read_raw
Date:   Mon,  7 Nov 2022 15:19:46 +0000
Message-Id: <20221107151946.89260-1-weiyongjun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCXu9gJHWljrcqLAA--.24151S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CFW3WFyrKryxAw4xuFy7Awb_yoW8Zw4kpF
        15JFWUGr47JFWqkFsrXa1kCa4Fy398Ga4xXa4aya4avw15uFnIkr9Yga4jqrykCry8Aw42
        qFnxX3yruryUKaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 5zhl50pqjm3046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

KASAN report out-of-bounds read as follows:

BUG: KASAN: global-out-of-bounds in afe4403_read_raw+0x42e/0x4c0
Read of size 4 at addr ffffffffc02ac638 by task cat/279

Call Trace:
 afe4403_read_raw
 iio_read_channel_info
 dev_attr_show

The buggy address belongs to the variable:
 afe4403_channel_leds+0x18/0xffffffffffffe9e0

This issue can be reproduced by singe command:

 $ cat /sys/bus/spi/devices/spi0.0/iio\:device0/in_intensity6_raw

The array size of afe4403_channel_leds is less than channels, so access
with chan->address cause OOB read in afe4403_read_raw. Fix it by moving
access before use it.

Fixes: b36e8257641a ("iio: health/afe440x: Use regmap fields")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Andrew Davis <afd@ti.com>
---
v2 -> v3: re-format backtraces
v1 -> v2: also moved 'reg' to right before we use it
          added Acked-by

 drivers/iio/health/afe4403.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 3bb4028c5d74..df3bc5c3d378 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -245,14 +245,14 @@ static int afe4403_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct afe4403_data *afe = iio_priv(indio_dev);
-	unsigned int reg = afe4403_channel_values[chan->address];
-	unsigned int field = afe4403_channel_leds[chan->address];
+	unsigned int reg, field;
 	int ret;
 
 	switch (chan->type) {
 	case IIO_INTENSITY:
 		switch (mask) {
 		case IIO_CHAN_INFO_RAW:
+			reg = afe4403_channel_values[chan->address];
 			ret = afe4403_read(afe, reg, val);
 			if (ret)
 				return ret;
@@ -262,6 +262,7 @@ static int afe4403_read_raw(struct iio_dev *indio_dev,
 	case IIO_CURRENT:
 		switch (mask) {
 		case IIO_CHAN_INFO_RAW:
+			field = afe4403_channel_leds[chan->address];
 			ret = regmap_field_read(afe->fields[field], val);
 			if (ret)
 				return ret;
-- 
2.34.1

