Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7FC32B3B6
	for <lists+linux-iio@lfdr.de>; Wed,  3 Mar 2021 05:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238849AbhCCEJv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Mar 2021 23:09:51 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:37218 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1448618AbhCBPIL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Mar 2021 10:08:11 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 122EeoRO025076;
        Tue, 2 Mar 2021 15:44:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=oONoIdGfPczi+ljXGpeeDFb41fuDUkn+9QagP/RsyGM=;
 b=kXUKxlCIjBQEJDbjy2/4thPlsCHLtv3WeDbjy4ZG3XxQk4fzIc9BdI14IaDqgyMxdOpb
 cZIvUK3r6lXkw+EAFZQMqbEaM2y3KOeCWKp4c15j/tepr5Czm9VCzuY8aCVV5FKk8wnG
 nFqbbPNQdhm3xFefaMppMoi756E31vd/gSInXRLlcr03IcuunhU5UTFnS9TCaFNb+U8w
 wXy9j0PSRR5EYcODGRMBO7vSj6QWN9+RwL7fB2xDxJtHC4s/ejHCLWjD7JGZ6m+yH4Bb
 UMu07ks/vLmFJnwum3MZoy25smObFj2tVSKnVKIne120CWbrdnEnaEQXTWhCf9ulj+l7 LA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 370xehqk1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Mar 2021 15:44:08 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3174E10002A;
        Tue,  2 Mar 2021 15:44:07 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 21D32241615;
        Tue,  2 Mar 2021 15:44:07 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Mar 2021 15:44:06
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <vilhelm.gray@gmail.com>, <jic23@kernel.org>
CC:     <david@lechnology.com>, <alexandre.torgue@foss.st.com>,
        <mcoquelin.stm32@gmail.com>, <olivier.moysan@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] counter: stm32-timer-cnt: fix ceiling write max value
Date:   Tue, 2 Mar 2021 15:43:55 +0100
Message-ID: <1614696235-24088-1-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-02_06:2021-03-01,2021-03-02 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ceiling value isn't checked before writing it into registers. The user
could write a value higher than the counter resolution (e.g. 16 or 32 bits
indicated by max_arr). This makes most significant bits to be truncated.
Fix it by checking the max_arr to report a range error [1] to the user.

Fixes: ad29937e206f ("counter: Add STM32 Timer quadrature encoder")

[1] https://lkml.org/lkml/2021/2/12/358

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/counter/stm32-timer-cnt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index ef2a974..2cf0c05 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -32,6 +32,7 @@ struct stm32_timer_cnt {
 	struct regmap *regmap;
 	struct clk *clk;
 	u32 ceiling;
+	u32 max_arr;
 	bool enabled;
 	struct stm32_timer_regs bak;
 };
@@ -185,6 +186,9 @@ static ssize_t stm32_count_ceiling_write(struct counter_device *counter,
 	if (ret)
 		return ret;
 
+	if (ceiling > priv->max_arr)
+		return -ERANGE;
+
 	/* TIMx_ARR register shouldn't be buffered (ARPE=0) */
 	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
 	regmap_write(priv->regmap, TIM_ARR, ceiling);
@@ -360,6 +364,7 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
 	priv->regmap = ddata->regmap;
 	priv->clk = ddata->clk;
 	priv->ceiling = ddata->max_arr;
+	priv->max_arr = ddata->max_arr;
 
 	priv->counter.name = dev_name(dev);
 	priv->counter.parent = dev;
-- 
2.7.4

