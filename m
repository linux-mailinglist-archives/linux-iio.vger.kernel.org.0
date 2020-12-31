Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CDE2E7ED5
	for <lists+linux-iio@lfdr.de>; Thu, 31 Dec 2020 10:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgLaJCw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 31 Dec 2020 04:02:52 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:42954 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbgLaJCv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 31 Dec 2020 04:02:51 -0500
X-Greylist: delayed 498 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Dec 2020 04:02:50 EST
Received: from localhost.localdomain (unknown [124.16.141.241])
        by APP-01 (Coremail) with SMTP id qwCowABHThaFke1f1bhfAA--.41536S2;
        Thu, 31 Dec 2020 16:53:25 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        krzk@kernel.org, andy.shevchenko@gmail.com,
        bobo.shaobowang@huawei.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: stm32-dfsdm: Remove redundant null check before clk_disable_unprepare
Date:   Thu, 31 Dec 2020 08:53:22 +0000
Message-Id: <20201231085322.24398-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: qwCowABHThaFke1f1bhfAA--.41536S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFy8CFy8Aw1xGryrKr48Zwb_yoW3tFXEy3
        WUu39rKF4aqrnay3y8WFn8Zr90vry8Zws3ur10yrWrGFy7Z3y7ZrWavr43Jw1UAanFya47
        A3WDX34fAr1xCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbV8YjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8Jr0_Cr
        1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kI
        c2xKxwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x07jeApnUUUUU=
X-Originating-IP: [124.16.141.241]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQkHA102Z1ecAwAAsA
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ecause clk_disable_unprepare() already checked NULL clock parameter,
so the additional check is unnecessary, just remove it.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/iio/adc/stm32-dfsdm-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
index 42a7377704a4..bb925a11c8ae 100644
--- a/drivers/iio/adc/stm32-dfsdm-core.c
+++ b/drivers/iio/adc/stm32-dfsdm-core.c
@@ -117,8 +117,7 @@ static void stm32_dfsdm_clk_disable_unprepare(struct stm32_dfsdm *dfsdm)
 {
 	struct dfsdm_priv *priv = to_stm32_dfsdm_priv(dfsdm);
 
-	if (priv->aclk)
-		clk_disable_unprepare(priv->aclk);
+	clk_disable_unprepare(priv->aclk);
 	clk_disable_unprepare(priv->clk);
 }
 
-- 
2.17.1

