Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F4E5E6163
	for <lists+linux-iio@lfdr.de>; Thu, 22 Sep 2022 13:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiIVLmC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Sep 2022 07:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiIVLl7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2022 07:41:59 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5467E3ED6
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 04:41:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MYCxN45pBzKP9L
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 19:39:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.102.38])
        by APP2 (Coremail) with SMTP id Syh0CgAnenPuSSxjgavkBA--.10939S4;
        Thu, 22 Sep 2022 19:41:36 +0800 (CST)
From:   Wei Yongjun <weiyongjun@huaweicloud.com>
To:     linux-iio@vger.kernel.org
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio: filter: admv8818: fix out-of-bounds read in __admv8818_read_[h|l]pf_freq()
Date:   Thu, 22 Sep 2022 11:58:48 +0000
Message-Id: <20220922115848.1800021-1-weiyongjun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnenPuSSxjgavkBA--.10939S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Gw4kAF1rWF1fur18AFWxtFb_yoW8Jr48pr
        s093y3Ar1xKrn3Jwn3XFyDXFy5JFs5urW8KFWq9as3Xay5Za95KF4Uta40gF1xtr93Cr1U
        tF42grZ8ua1ayaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
        Cq3wCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 5zhl50pqjm3046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

ADMV8818_SW_IN_WR0_MSK and ADMV8818_SW_OUT_WR0_MSK have 3 bits,
which means a length of 8, but freq_range_hpf and freq_range_lpf
array size is 4, may end up reading 4 elements beyond the end of
those arrays.

Fix to check value first before access freq_range_hpf and
freq_range_lpf.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/iio/filter/admv8818.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index 68de45fe21b4..fe8d46cb7f1d 100644
--- a/drivers/iio/filter/admv8818.c
+++ b/drivers/iio/filter/admv8818.c
@@ -265,7 +265,7 @@ static int __admv8818_read_hpf_freq(struct admv8818_state *st, u64 *hpf_freq)
 		return ret;
 
 	hpf_band = FIELD_GET(ADMV8818_SW_IN_WR0_MSK, data);
-	if (!hpf_band) {
+	if (!hpf_band || hpf_band > 4) {
 		*hpf_freq = 0;
 		return ret;
 	}
@@ -303,7 +303,7 @@ static int __admv8818_read_lpf_freq(struct admv8818_state *st, u64 *lpf_freq)
 		return ret;
 
 	lpf_band = FIELD_GET(ADMV8818_SW_OUT_WR0_MSK, data);
-	if (!lpf_band) {
+	if (!lpf_band || lpf_band > 4) {
 		*lpf_freq = 0;
 		return ret;
 	}
-- 
2.34.1

