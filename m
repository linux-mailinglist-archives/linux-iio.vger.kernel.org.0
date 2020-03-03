Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C77BC1779CD
	for <lists+linux-iio@lfdr.de>; Tue,  3 Mar 2020 16:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbgCCPBk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Mar 2020 10:01:40 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:26706 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728332AbgCCPBi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Mar 2020 10:01:38 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 023EhwCN018149;
        Tue, 3 Mar 2020 16:01:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=fWFfDFYfimmf+DsBDy5H5k1WaDJAP0YrTF65xFfzfiw=;
 b=BdXQDzkoRENYYcxjUKyaZjI4UJaZurVbTIQiQ5vVDkqHC5dVBSGCYXb8NrT+Cszhd/oc
 B17V3Ym+27WIVuKyUmPX+MuuxRuZrsyGUnREBib4bfQfZ5INVxwTQZIYPiOH0DIkUoqu
 5B8pGZsWpAhH7xfi9JiJ/WifpI5JlC0w/EoNtFLN+uuxoxyw38SZ7x5yfV9bjiBj4YeL
 MqsrRExM1DrSIyqhhKR0xvJv+EmYyFbcAioyoYPRLZPccqMPQ7EvKz4rgMaxuJeuEoNt
 YjCb4aZxahzie0g24c/ew9zLQH9R63h6tCT/mj6131GTWYuPmhO0Ce2fwzgadR8TJ94C 2Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yfem0tu08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Mar 2020 16:01:13 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 701AD10002A;
        Tue,  3 Mar 2020 16:01:11 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5B1272B4213;
        Tue,  3 Mar 2020 16:01:11 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Mar 2020 16:01:10
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <benjamin.gaignard@st.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <olivier.moysan@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 1/2] iio: trigger: stm32-timer: rename enabled flag
Date:   Tue, 3 Mar 2020 15:59:44 +0100
Message-ID: <1583247585-16698-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583247585-16698-1-git-send-email-fabrice.gasnier@st.com>
References: <1583247585-16698-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-03_05:2020-03-03,2020-03-03 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

"clk_enabled" flag reflects enabled state of the timer, for master mode,
slave mode or trigger (with sampling_frequency). So rename it to "enabled".

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/trigger/stm32-timer-trigger.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index 16a3b6b..32e1249 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -79,7 +79,7 @@ struct stm32_timer_trigger {
 	struct device *dev;
 	struct regmap *regmap;
 	struct clk *clk;
-	bool clk_enabled;
+	bool enabled;
 	u32 max_arr;
 	const void *triggers;
 	const void *valids;
@@ -140,8 +140,8 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
 		return -EBUSY;
 
 	mutex_lock(&priv->lock);
-	if (!priv->clk_enabled) {
-		priv->clk_enabled = true;
+	if (!priv->enabled) {
+		priv->enabled = true;
 		clk_enable(priv->clk);
 	}
 
@@ -185,8 +185,8 @@ static void stm32_timer_stop(struct stm32_timer_trigger *priv)
 	/* Make sure that registers are updated */
 	regmap_update_bits(priv->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
 
-	if (priv->clk_enabled) {
-		priv->clk_enabled = false;
+	if (priv->enabled) {
+		priv->enabled = false;
 		clk_disable(priv->clk);
 	}
 	mutex_unlock(&priv->lock);
@@ -305,9 +305,9 @@ static ssize_t stm32_tt_store_master_mode(struct device *dev,
 		if (!strncmp(master_mode_table[i], buf,
 			     strlen(master_mode_table[i]))) {
 			mutex_lock(&priv->lock);
-			if (!priv->clk_enabled) {
+			if (!priv->enabled) {
 				/* Clock should be enabled first */
-				priv->clk_enabled = true;
+				priv->enabled = true;
 				clk_enable(priv->clk);
 			}
 			regmap_update_bits(priv->regmap, TIM_CR2, mask,
@@ -476,8 +476,8 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_ENABLE:
 		mutex_lock(&priv->lock);
 		if (val) {
-			if (!priv->clk_enabled) {
-				priv->clk_enabled = true;
+			if (!priv->enabled) {
+				priv->enabled = true;
 				clk_enable(priv->clk);
 			}
 			regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
@@ -485,8 +485,8 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
 		} else {
 			regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
 					   0);
-			if (priv->clk_enabled) {
-				priv->clk_enabled = false;
+			if (priv->enabled) {
+				priv->enabled = false;
 				clk_disable(priv->clk);
 			}
 		}
@@ -594,9 +594,9 @@ static int stm32_set_enable_mode(struct iio_dev *indio_dev,
 	 * enable counter clock, so it can use it. Keeps it in sync with CEN.
 	 */
 	mutex_lock(&priv->lock);
-	if (sms == 6 && !priv->clk_enabled) {
+	if (sms == 6 && !priv->enabled) {
 		clk_enable(priv->clk);
-		priv->clk_enabled = true;
+		priv->enabled = true;
 	}
 	mutex_unlock(&priv->lock);
 
@@ -806,7 +806,7 @@ static int stm32_timer_trigger_remove(struct platform_device *pdev)
 	if (!(val & TIM_CCER_CCXE))
 		regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
 
-	if (priv->clk_enabled)
+	if (priv->enabled)
 		clk_disable(priv->clk);
 
 	return 0;
-- 
2.7.4

