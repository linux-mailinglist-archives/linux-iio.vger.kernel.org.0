Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2EE61951D
	for <lists+linux-iio@lfdr.de>; Fri,  4 Nov 2022 12:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKDLGo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Nov 2022 07:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKDLGl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Nov 2022 07:06:41 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBEADF
        for <linux-iio@vger.kernel.org>; Fri,  4 Nov 2022 04:06:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N3d6v5h7hzlCp4
        for <linux-iio@vger.kernel.org>; Fri,  4 Nov 2022 19:04:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.102.38])
        by APP4 (Coremail) with SMTP id gCh0CgCHlug68mRjnC7OAg--.32801S4;
        Fri, 04 Nov 2022 19:06:36 +0800 (CST)
From:   Wei Yongjun <weiyongjun@huaweicloud.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Paul Cercueil <paul@crapouillou.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>, "Andrew F. Davis" <afd@ti.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: [PATCH] iio: health: afe4403: Fix oob read in afe4403_read_raw
Date:   Fri,  4 Nov 2022 11:28:07 +0000
Message-Id: <20221104112808.346719-1-weiyongjun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCHlug68mRjnC7OAg--.32801S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZw45CFW7GrW8uw13Ary3twb_yoW5GFy7pr
        1rtFWUGr18Ja4qkFnIvF1DXa4Fvas8Ga4xXryfu34avw15urnIkrWvgayjqF1DCry8Aw4x
        XFn3X3y8ur1UGaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
        0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
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

BUG: KASAN: global-out-of-bounds in afe4403_read_raw+0x42e/0x4c0 [afe4403]
Read of size 4 at addr ffffffffc02ac638 by task cat/279

CPU: 2 PID: 279 Comm: cat Tainted: G                 N
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 afe4403_read_raw+0x42e/0x4c0 [afe4403 141d77410f5466ef049ee2376f5136b77a168de0]
 iio_read_channel_info+0x249/0x2e0 [industrialio d0627df60a92bbb9630e68c3e2f98d20dac889ef]
 dev_attr_show+0x4b/0xa0 drivers/base/core.c:2195
 sysfs_kf_seq_show+0x1ec/0x390 fs/sysfs/file.c:59
 seq_read_iter+0x48d/0x10b0 fs/seq_file.c:230
 kernfs_fop_read_iter+0x4e6/0x710 fs/kernfs/file.c:275
 call_read_iter include/linux/fs.h:2153 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x5f2/0x890 fs/read_write.c:470
 ksys_read+0x106/0x220 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xa0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7fd8611cf992
 </TASK>

The buggy address belongs to the variable:
 afe4403_channel_leds+0x18/0xffffffffffffe9e0 [afe4403]

This issue can be reproduced by singe command:

 $ cat /sys/bus/spi/devices/spi0.0/iio\:device0/in_intensity6_raw

The array size of afe4403_channel_leds is less than channels, so access
with chan->address cause OOB read in afe4403_read_raw. Fix it by moving
access before use it.

Fixes: b36e8257641a ("iio: health/afe440x: Use regmap fields")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/iio/health/afe4403.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 3bb4028c5d74..14213a48e349 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -246,7 +246,7 @@ static int afe4403_read_raw(struct iio_dev *indio_dev,
 {
 	struct afe4403_data *afe = iio_priv(indio_dev);
 	unsigned int reg = afe4403_channel_values[chan->address];
-	unsigned int field = afe4403_channel_leds[chan->address];
+	unsigned int field;
 	int ret;
 
 	switch (chan->type) {
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

