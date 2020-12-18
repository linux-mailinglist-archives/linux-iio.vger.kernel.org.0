Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96CF2DE094
	for <lists+linux-iio@lfdr.de>; Fri, 18 Dec 2020 10:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732182AbgLRJro (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Dec 2020 04:47:44 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:54104 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728240AbgLRJro (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Dec 2020 04:47:44 -0500
Received: from localhost.localdomain (unknown [124.16.141.242])
        by APP-05 (Coremail) with SMTP id zQCowAC3p3CJetxf_O4SAA--.42642S2;
        Fri, 18 Dec 2020 17:46:50 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] iio: frequency: adf4350: Remove redundant null check before clk_disable_unprepare
Date:   Fri, 18 Dec 2020 09:46:47 +0000
Message-Id: <20201218094647.1386-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zQCowAC3p3CJetxf_O4SAA--.42642S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFy8CFy8AFW3tr4UAFW5KFg_yoWDWrX_C3
        W8urZ2gF4rur9ayw1UGr4qvF98G3Zava1SgrySyFyfKry7X39xZrW8Zrs8A3y7uw4UtF15
        X3yDGr4fC34fCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2xYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_GFWl42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4pVbDUUUU
X-Originating-IP: [124.16.141.242]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCgkOA1z4jO9-VwABsg
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Because clk_disable_unprepare() already checked NULL clock parameter,
so the additional check is unnecessary, just remove it.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/iio/frequency/adf4350.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 82c050a3899d..1462a6a5bc6d 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -582,8 +582,7 @@ static int adf4350_probe(struct spi_device *spi)
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
 error_disable_clk:
-	if (clk)
-		clk_disable_unprepare(clk);
+	clk_disable_unprepare(clk);
 
 	return ret;
 }
@@ -599,8 +598,7 @@ static int adf4350_remove(struct spi_device *spi)
 
 	iio_device_unregister(indio_dev);
 
-	if (st->clk)
-		clk_disable_unprepare(st->clk);
+	clk_disable_unprepare(st->clk);
 
 	if (!IS_ERR(reg))
 		regulator_disable(reg);
-- 
2.17.1

