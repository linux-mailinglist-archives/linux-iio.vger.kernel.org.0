Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E572B61E861
	for <lists+linux-iio@lfdr.de>; Mon,  7 Nov 2022 02:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiKGBnB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Nov 2022 20:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiKGBnA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Nov 2022 20:43:00 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E533D10F
        for <linux-iio@vger.kernel.org>; Sun,  6 Nov 2022 17:42:59 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N5DWd3QS7z4f3vbw
        for <linux-iio@vger.kernel.org>; Mon,  7 Nov 2022 09:42:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.102.38])
        by APP1 (Coremail) with SMTP id cCh0CgDHcK+fYmhjQitmAA--.1344S4;
        Mon, 07 Nov 2022 09:42:56 +0800 (CST)
From:   Wei Yongjun <weiyongjun@huaweicloud.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        "Andrew F. Davis" <afd@ti.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: health: afe4404: Fix oob read in afe4404_[read|write]_raw
Date:   Mon,  7 Nov 2022 02:04:25 +0000
Message-Id: <20221107020425.72577-1-weiyongjun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDHcK+fYmhjQitmAA--.1344S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1kZFWrXF18Xr1DKF17ZFb_yoWrWryDpr
        y3AFW5WF47tFyDCrsrZr4DuFyFv3sIq3WxXr9Ika429w1UZFnIkr4xKa4jqrn5Cr1qywnr
        XFn3XrZ5Zr15Ww7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Gr0_Zr
        1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
        vfC2KfnxnUUI43ZEXa7IUbPEf5UUUUU==
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

BUG: KASAN: global-out-of-bounds in afe4404_read_raw+0x2ce/0x380 [afe4404]
Read of size 4 at addr ffffffffc00e4658 by task cat/278

CPU: 1 PID: 278 Comm: cat Tainted: G
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 afe4404_read_raw+0x2ce/0x380 [afe4404]
 iio_read_channel_info+0x249/0x2e0 [industrialio]
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
RIP: 0033:0x7fe9c5ef6992
 </TASK>

The buggy address belongs to the variable:
 afe4404_channel_leds+0x18/0xffffffffffffe9c0 [afe4404]

This issue can be reproduce by singe command:

 $ cat /sys/bus/i2c/devices/0-0058/iio\:device0/in_intensity6_raw

The array size of afe4404_channel_leds and afe4404_channel_offdacs
are less than channels, so access with chan->address cause OOB read
in afe4404_[read|write]_raw. Fix it by moving access before use them.

Fixes: b36e8257641a ("iio: health/afe440x: Use regmap fields")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Andrew Davis <afd@ti.com>
---
v1 -> v2: also moved 'reg' to right before we use it
          added Acked-by
---
 drivers/iio/health/afe4404.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index 8fca787b2524..836da31b7e30 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -250,20 +250,20 @@ static int afe4404_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct afe4404_data *afe = iio_priv(indio_dev);
-	unsigned int value_reg = afe4404_channel_values[chan->address];
-	unsigned int led_field = afe4404_channel_leds[chan->address];
-	unsigned int offdac_field = afe4404_channel_offdacs[chan->address];
+	unsigned int value_reg, led_field, offdac_field;
 	int ret;
 
 	switch (chan->type) {
 	case IIO_INTENSITY:
 		switch (mask) {
 		case IIO_CHAN_INFO_RAW:
+			value_reg = afe4404_channel_values[chan->address];
 			ret = regmap_read(afe->regmap, value_reg, val);
 			if (ret)
 				return ret;
 			return IIO_VAL_INT;
 		case IIO_CHAN_INFO_OFFSET:
+			offdac_field = afe4404_channel_offdacs[chan->address];
 			ret = regmap_field_read(afe->fields[offdac_field], val);
 			if (ret)
 				return ret;
@@ -273,6 +273,7 @@ static int afe4404_read_raw(struct iio_dev *indio_dev,
 	case IIO_CURRENT:
 		switch (mask) {
 		case IIO_CHAN_INFO_RAW:
+			led_field = afe4404_channel_leds[chan->address];
 			ret = regmap_field_read(afe->fields[led_field], val);
 			if (ret)
 				return ret;
@@ -295,19 +296,20 @@ static int afe4404_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long mask)
 {
 	struct afe4404_data *afe = iio_priv(indio_dev);
-	unsigned int led_field = afe4404_channel_leds[chan->address];
-	unsigned int offdac_field = afe4404_channel_offdacs[chan->address];
+	unsigned int led_field, offdac_field;
 
 	switch (chan->type) {
 	case IIO_INTENSITY:
 		switch (mask) {
 		case IIO_CHAN_INFO_OFFSET:
+			offdac_field = afe4404_channel_offdacs[chan->address];
 			return regmap_field_write(afe->fields[offdac_field], val);
 		}
 		break;
 	case IIO_CURRENT:
 		switch (mask) {
 		case IIO_CHAN_INFO_RAW:
+			led_field = afe4404_channel_leds[chan->address];
 			return regmap_field_write(afe->fields[led_field], val);
 		}
 		break;
-- 
2.34.1

