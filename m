Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DC532C6D1
	for <lists+linux-iio@lfdr.de>; Thu,  4 Mar 2021 02:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238530AbhCDAaH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Mar 2021 19:30:07 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:43124 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376364AbhCCSn7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Mar 2021 13:43:59 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 123Hf1lb021617;
        Wed, 3 Mar 2021 18:50:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=tZbRr9XduT63pSmgY3cChQ8LE10buNg7X9yGMbcw3f0=;
 b=ardA4KVhqVSHNapkXWguss+YzAkKTJ4/Si+Qc2uto69LpMN6basP6lmXe8s4A800i5AZ
 KCY79sh54JtHXmf435C+bAngY1OW3lIYZwA+/UV7wkjHOZ5vFVUl58LR/lPjIDATw7Sn
 X9vfKXIEuUtaJqVKKnHOS2qT0z/G6SwkEdGdfCM+iR211dYdkRluAv+zJWSt6KN3WBGs
 nRI/X23kiWS68z5Lf4SiI6pBewG14hPbobmLu96UDaKSecyVRWakG25PFZHzOYy9t+Jx
 XLtA4Hb0ZKDiIpQSXYYLgirztJpQaQDoQ3eaVBZHyBdKlRH5U+HgfSQpdyH0KWJao5A9 mw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 370xehy4vt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Mar 2021 18:50:20 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CA66F10002A;
        Wed,  3 Mar 2021 18:50:19 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B5B9225D036;
        Wed,  3 Mar 2021 18:50:19 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 3 Mar 2021 18:50:19
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <vilhelm.gray@gmail.com>, <jic23@kernel.org>
CC:     <alexandre.torgue@foss.st.com>, <mcoquelin.stm32@gmail.com>,
        <olivier.moysan@foss.st.com>, <fabrice.gasnier@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] counter: stm32-timer-cnt: fix ceiling miss-alignment with reload register
Date:   Wed, 3 Mar 2021 18:49:49 +0100
Message-ID: <1614793789-10346-1-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-03_05:2021-03-03,2021-03-03 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Ceiling value may be miss-aligned with what's actually configured into the
ARR register. This is seen after probe as currently the ARR value is zero,
whereas ceiling value is set to the maximum. So:
- reading ceiling reports zero
- in case the counter gets enabled without any prior configuration,
  it won't count.
- in case the function gets set by the user 1st, (priv->ceiling) is used.

Fix it by getting rid of the cached "priv->ceiling" variable. Rather use
the ARR register value directly by using regmap read or write when needed.
There should be no drawback on performance as priv->ceiling isn't used in
performance critical path.
There's also no point in writing ARR while setting function (sms), so
it can be safely removed.

Fixes: ad29937e206f ("counter: Add STM32 Timer quadrature encoder")

Suggested-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Note: this applies on top of:
- "counter: stm32-timer-cnt: fix ceiling write max value"
---
 drivers/counter/stm32-timer-cnt.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 2295be3..75bc401 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -31,7 +31,6 @@ struct stm32_timer_cnt {
 	struct counter_device counter;
 	struct regmap *regmap;
 	struct clk *clk;
-	u32 ceiling;
 	u32 max_arr;
 	bool enabled;
 	struct stm32_timer_regs bak;
@@ -75,8 +74,10 @@ static int stm32_count_write(struct counter_device *counter,
 			     const unsigned long val)
 {
 	struct stm32_timer_cnt *const priv = counter->priv;
+	u32 ceiling;
 
-	if (val > priv->ceiling)
+	regmap_read(priv->regmap, TIM_ARR, &ceiling);
+	if (val > ceiling)
 		return -EINVAL;
 
 	return regmap_write(priv->regmap, TIM_CNT, val);
@@ -138,10 +139,6 @@ static int stm32_count_function_set(struct counter_device *counter,
 
 	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
 
-	/* TIMx_ARR register shouldn't be buffered (ARPE=0) */
-	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
-	regmap_write(priv->regmap, TIM_ARR, priv->ceiling);
-
 	regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_SMS, sms);
 
 	/* Make sure that registers are updated */
@@ -199,7 +196,6 @@ static ssize_t stm32_count_ceiling_write(struct counter_device *counter,
 	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
 	regmap_write(priv->regmap, TIM_ARR, ceiling);
 
-	priv->ceiling = ceiling;
 	return len;
 }
 
@@ -374,7 +370,6 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
 
 	priv->regmap = ddata->regmap;
 	priv->clk = ddata->clk;
-	priv->ceiling = ddata->max_arr;
 	priv->max_arr = ddata->max_arr;
 
 	priv->counter.name = dev_name(dev);
-- 
2.7.4

