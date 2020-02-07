Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AACF3155BCA
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2020 17:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgBGQbT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Feb 2020 11:31:19 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:54950 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726936AbgBGQbS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Feb 2020 11:31:18 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 017GRDex029779;
        Fri, 7 Feb 2020 17:30:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=eynS2NWJgzJPsFwfn39rO+Ib4H8Lzadaw2c3N+8nz14=;
 b=la2ykJAW/nMDix22ZSfhtrmn8NCghZzei0MsqCmvjZk8n7hUbPFIK5e/sjk3aYOXissE
 uv+fcatEt/ED7/5W8+4Posfkub6EWrkf6A1FbSzx0r3U40XT66cqVfSrwR1ov2dqxM0s
 O2PVzVW0LDMQTacEqtxOwwiisoWoDQ58Y6Zc2BFlLW7Lw8LXEVmsWnkaiQfsJR39JNtc
 mwvZIuKuvu7iqx/pEs/BvXXOyNN+g7jj8S74rXXp4uiIApwt7M0YghcevP0KyM7z9JUi
 V4qXRQB1lEv98FxcjT4oGBsf51OMEGnqA5dNpifDweSSYXO1wwWpbVYJaMRXC8SvWmlZ ZQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xyhkucn68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Feb 2020 17:30:52 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 332BB10002A;
        Fri,  7 Feb 2020 17:30:48 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1D3C42B0C8F;
        Fri,  7 Feb 2020 17:30:48 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Feb 2020 17:30:47
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <benjamin.gaignard@st.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <olivier.moysan@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2] iio: trigger: stm32-timer: enable clock when in master mode
Date:   Fri, 7 Feb 2020 17:30:31 +0100
Message-ID: <1581093031-9871-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-07_02:2020-02-07,2020-02-07 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Clock should be enabled as soon as using master modes, even before
enabling timer. Or, this may provoke bad behavior on the other end
(slave timer). Then, introduce 'clk_enabled' flag, instead of relying
on CR1 EN bit, to keep track of clock being enabled (balanced refcount).
Propagate this anywhere else in the driver.

Also add 'remove' routine to stop timer and disable clock in case it
has been left enabled. Enforce the user interface has been unregistered
in the remove routine, before disabling the hardware to avoid possible
race. So, remove use of devm_ variant to register triggers and unregister
them before the hardware gets disabled [1].
[1] https://patchwork.kernel.org/patch/9956247/

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- enforce the user interface has been unregistered in the remove routine,
  before disabling the hardware to avoid possible race.
---
 drivers/iio/trigger/stm32-timer-trigger.c | 98 ++++++++++++++++++++++++-------
 1 file changed, 76 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index a5dfe65..473853e 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -79,10 +79,13 @@ struct stm32_timer_trigger {
 	struct device *dev;
 	struct regmap *regmap;
 	struct clk *clk;
+	bool clk_enabled;
 	u32 max_arr;
 	const void *triggers;
 	const void *valids;
 	bool has_trgo2;
+	struct mutex lock; /* concurrent sysfs configuration */
+	struct list_head tr_list;
 };
 
 struct stm32_timer_trigger_cfg {
@@ -106,7 +109,7 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
 {
 	unsigned long long prd, div;
 	int prescaler = 0;
-	u32 ccer, cr1;
+	u32 ccer;
 
 	/* Period and prescaler values depends of clock rate */
 	div = (unsigned long long)clk_get_rate(priv->clk);
@@ -136,9 +139,11 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
 	if (ccer & TIM_CCER_CCXE)
 		return -EBUSY;
 
-	regmap_read(priv->regmap, TIM_CR1, &cr1);
-	if (!(cr1 & TIM_CR1_CEN))
+	mutex_lock(&priv->lock);
+	if (!priv->clk_enabled) {
+		priv->clk_enabled = true;
 		clk_enable(priv->clk);
+	}
 
 	regmap_write(priv->regmap, TIM_PSC, prescaler);
 	regmap_write(priv->regmap, TIM_ARR, prd - 1);
@@ -157,22 +162,20 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
 
 	/* Enable controller */
 	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, TIM_CR1_CEN);
+	mutex_unlock(&priv->lock);
 
 	return 0;
 }
 
 static void stm32_timer_stop(struct stm32_timer_trigger *priv)
 {
-	u32 ccer, cr1;
+	u32 ccer;
 
 	regmap_read(priv->regmap, TIM_CCER, &ccer);
 	if (ccer & TIM_CCER_CCXE)
 		return;
 
-	regmap_read(priv->regmap, TIM_CR1, &cr1);
-	if (cr1 & TIM_CR1_CEN)
-		clk_disable(priv->clk);
-
+	mutex_lock(&priv->lock);
 	/* Stop timer */
 	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
 	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
@@ -181,6 +184,12 @@ static void stm32_timer_stop(struct stm32_timer_trigger *priv)
 
 	/* Make sure that registers are updated */
 	regmap_update_bits(priv->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
+
+	if (priv->clk_enabled) {
+		priv->clk_enabled = false;
+		clk_disable(priv->clk);
+	}
+	mutex_unlock(&priv->lock);
 }
 
 static ssize_t stm32_tt_store_frequency(struct device *dev,
@@ -295,11 +304,18 @@ static ssize_t stm32_tt_store_master_mode(struct device *dev,
 	for (i = 0; i <= master_mode_max; i++) {
 		if (!strncmp(master_mode_table[i], buf,
 			     strlen(master_mode_table[i]))) {
+			mutex_lock(&priv->lock);
+			if (!priv->clk_enabled) {
+				/* Clock should be enabled first */
+				priv->clk_enabled = true;
+				clk_enable(priv->clk);
+			}
 			regmap_update_bits(priv->regmap, TIM_CR2, mask,
 					   i << shift);
 			/* Make sure that registers are updated */
 			regmap_update_bits(priv->regmap, TIM_EGR,
 					   TIM_EGR_UG, TIM_EGR_UG);
+			mutex_unlock(&priv->lock);
 			return len;
 		}
 	}
@@ -357,11 +373,21 @@ static const struct attribute_group *stm32_trigger_attr_groups[] = {
 static const struct iio_trigger_ops timer_trigger_ops = {
 };
 
-static int stm32_setup_iio_triggers(struct stm32_timer_trigger *priv)
+static void stm32_unregister_iio_triggers(struct stm32_timer_trigger *priv)
+{
+	struct iio_trigger *tr;
+
+	list_for_each_entry(tr, &priv->tr_list, alloc_list)
+		iio_trigger_unregister(tr);
+}
+
+static int stm32_register_iio_triggers(struct stm32_timer_trigger *priv)
 {
 	int ret;
 	const char * const *cur = priv->triggers;
 
+	INIT_LIST_HEAD(&priv->tr_list);
+
 	while (cur && *cur) {
 		struct iio_trigger *trig;
 		bool cur_is_trgo = stm32_timer_is_trgo_name(*cur);
@@ -388,9 +414,13 @@ static int stm32_setup_iio_triggers(struct stm32_timer_trigger *priv)
 
 		iio_trigger_set_drvdata(trig, priv);
 
-		ret = devm_iio_trigger_register(priv->dev, trig);
-		if (ret)
+		ret = iio_trigger_register(trig);
+		if (ret) {
+			stm32_unregister_iio_triggers(priv);
 			return ret;
+		}
+
+		list_add_tail(&trig->alloc_list, &priv->tr_list);
 		cur++;
 	}
 
@@ -437,7 +467,6 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
 				   int val, int val2, long mask)
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
-	u32 dat;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -448,19 +477,23 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
 		return -EINVAL;
 
 	case IIO_CHAN_INFO_ENABLE:
+		mutex_lock(&priv->lock);
 		if (val) {
-			regmap_read(priv->regmap, TIM_CR1, &dat);
-			if (!(dat & TIM_CR1_CEN))
+			if (!priv->clk_enabled) {
+				priv->clk_enabled = true;
 				clk_enable(priv->clk);
+			}
 			regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
 					   TIM_CR1_CEN);
 		} else {
-			regmap_read(priv->regmap, TIM_CR1, &dat);
 			regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
 					   0);
-			if (dat & TIM_CR1_CEN)
+			if (priv->clk_enabled) {
+				priv->clk_enabled = false;
 				clk_disable(priv->clk);
+			}
 		}
+		mutex_unlock(&priv->lock);
 		return 0;
 	}
 
@@ -556,7 +589,6 @@ static int stm32_set_enable_mode(struct iio_dev *indio_dev,
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
 	int sms = stm32_enable_mode2sms(mode);
-	u32 val;
 
 	if (sms < 0)
 		return sms;
@@ -564,11 +596,12 @@ static int stm32_set_enable_mode(struct iio_dev *indio_dev,
 	 * Triggered mode sets CEN bit automatically by hardware. So, first
 	 * enable counter clock, so it can use it. Keeps it in sync with CEN.
 	 */
-	if (sms == 6) {
-		regmap_read(priv->regmap, TIM_CR1, &val);
-		if (!(val & TIM_CR1_CEN))
-			clk_enable(priv->clk);
+	mutex_lock(&priv->lock);
+	if (sms == 6 && !priv->clk_enabled) {
+		clk_enable(priv->clk);
+		priv->clk_enabled = true;
 	}
+	mutex_unlock(&priv->lock);
 
 	regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_SMS, sms);
 
@@ -752,8 +785,9 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
 	priv->triggers = triggers_table[index];
 	priv->valids = cfg->valids_table[index];
 	stm32_timer_detect_trgo2(priv);
+	mutex_init(&priv->lock);
 
-	ret = stm32_setup_iio_triggers(priv);
+	ret = stm32_register_iio_triggers(priv);
 	if (ret)
 		return ret;
 
@@ -762,6 +796,25 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int stm32_timer_trigger_remove(struct platform_device *pdev)
+{
+	struct stm32_timer_trigger *priv = platform_get_drvdata(pdev);
+	u32 val;
+
+	/* Unregister triggers before everything can be safely turned off */
+	stm32_unregister_iio_triggers(priv);
+
+	/* Check if nobody else use the timer, then disable it */
+	regmap_read(priv->regmap, TIM_CCER, &val);
+	if (!(val & TIM_CCER_CCXE))
+		regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
+
+	if (priv->clk_enabled)
+		clk_disable(priv->clk);
+
+	return 0;
+}
+
 static const struct stm32_timer_trigger_cfg stm32_timer_trg_cfg = {
 	.valids_table = valids_table,
 	.num_valids_table = ARRAY_SIZE(valids_table),
@@ -786,6 +839,7 @@ MODULE_DEVICE_TABLE(of, stm32_trig_of_match);
 
 static struct platform_driver stm32_timer_trigger_driver = {
 	.probe = stm32_timer_trigger_probe,
+	.remove = stm32_timer_trigger_remove,
 	.driver = {
 		.name = "stm32-timer-trigger",
 		.of_match_table = stm32_trig_of_match,
-- 
2.7.4

