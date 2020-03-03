Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C470D1779CB
	for <lists+linux-iio@lfdr.de>; Tue,  3 Mar 2020 16:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbgCCPBk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Mar 2020 10:01:40 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53088 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728102AbgCCPBi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Mar 2020 10:01:38 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 023Ehphs031189;
        Tue, 3 Mar 2020 16:01:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=8S/BtVhGihcu9yRtTn3kkYtnt8trr7aY12jPLpvXZZI=;
 b=SM/SzjvdJ3okqd9CrI+OHCTixrq0hl26o2gs85OfiKFMPsH2KJzuckkKF31Ch2OtvG/r
 kXbTpw8ZNpnIwMKxiMsB5DlmgJylK/KitstNEPXYExclpIoOQyPPKWs9ANhWqSKB/f+w
 A/xXnbwREbTF9YTNgxPXD6oOAE64WA0h9VAcRYjz017TlEHUvo3K0q5DNN2djk9XpCPv
 UcXz1ZL5z/DbOAiHrbDGBc3YJU5TmPfN7lzU92eP0vbcClrtKMJJNZBFtgOTct77RRSY
 ZLu63N8JQ5k1UjNY0aTtABqhJJxHVECMg7C4stYRB1c+str+J+pdw+MBsnJHICj6EiSZ 8g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yffqptvhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Mar 2020 16:01:12 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 238AF10003A;
        Tue,  3 Mar 2020 16:01:12 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 104FD2BEC4A;
        Tue,  3 Mar 2020 16:01:12 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Mar 2020 16:01:11
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <benjamin.gaignard@st.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <olivier.moysan@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 2/2] iio: trigger: stm32-timer: add power management support
Date:   Tue, 3 Mar 2020 15:59:45 +0100
Message-ID: <1583247585-16698-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583247585-16698-1-git-send-email-fabrice.gasnier@st.com>
References: <1583247585-16698-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-03_05:2020-03-03,2020-03-03 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add suspend/resume PM sleep ops to stm32-timer-trigger driver.
Register contents may be lost depending on low power modes.
When going to low power, enforce the timer isn't active. Gracefully
restore its state upon resume in case it's been left enabled prior to
suspend.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/trigger/stm32-timer-trigger.c | 63 +++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index 32e1249..37545a8 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -75,6 +75,15 @@ static const void *stm32h7_valids_table[][MAX_VALIDS] = {
 	{ }, /* timer 17 */
 };
 
+struct stm32_timer_trigger_regs {
+	u32 cr1;
+	u32 cr2;
+	u32 psc;
+	u32 arr;
+	u32 cnt;
+	u32 smcr;
+};
+
 struct stm32_timer_trigger {
 	struct device *dev;
 	struct regmap *regmap;
@@ -86,6 +95,7 @@ struct stm32_timer_trigger {
 	bool has_trgo2;
 	struct mutex lock; /* concurrent sysfs configuration */
 	struct list_head tr_list;
+	struct stm32_timer_trigger_regs bak;
 };
 
 struct stm32_timer_trigger_cfg {
@@ -812,6 +822,58 @@ static int stm32_timer_trigger_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused stm32_timer_trigger_suspend(struct device *dev)
+{
+	struct stm32_timer_trigger *priv = dev_get_drvdata(dev);
+
+	/* Only take care of enabled timer: don't disturb other MFD child */
+	if (priv->enabled) {
+		/* Backup registers that may get lost in low power mode */
+		regmap_read(priv->regmap, TIM_CR1, &priv->bak.cr1);
+		regmap_read(priv->regmap, TIM_CR2, &priv->bak.cr2);
+		regmap_read(priv->regmap, TIM_PSC, &priv->bak.psc);
+		regmap_read(priv->regmap, TIM_ARR, &priv->bak.arr);
+		regmap_read(priv->regmap, TIM_CNT, &priv->bak.cnt);
+		regmap_read(priv->regmap, TIM_SMCR, &priv->bak.smcr);
+
+		/* Disable the timer */
+		regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
+		clk_disable(priv->clk);
+	}
+
+	return 0;
+}
+
+static int __maybe_unused stm32_timer_trigger_resume(struct device *dev)
+{
+	struct stm32_timer_trigger *priv = dev_get_drvdata(dev);
+	int ret;
+
+	if (priv->enabled) {
+		ret = clk_enable(priv->clk);
+		if (ret)
+			return ret;
+
+		/* restore master/slave modes */
+		regmap_write(priv->regmap, TIM_SMCR, priv->bak.smcr);
+		regmap_write(priv->regmap, TIM_CR2, priv->bak.cr2);
+
+		/* restore sampling_frequency (trgo / trgo2 triggers) */
+		regmap_write(priv->regmap, TIM_PSC, priv->bak.psc);
+		regmap_write(priv->regmap, TIM_ARR, priv->bak.arr);
+		regmap_write(priv->regmap, TIM_CNT, priv->bak.cnt);
+
+		/* Also re-enables the timer */
+		regmap_write(priv->regmap, TIM_CR1, priv->bak.cr1);
+	}
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(stm32_timer_trigger_pm_ops,
+			 stm32_timer_trigger_suspend,
+			 stm32_timer_trigger_resume);
+
 static const struct stm32_timer_trigger_cfg stm32_timer_trg_cfg = {
 	.valids_table = valids_table,
 	.num_valids_table = ARRAY_SIZE(valids_table),
@@ -840,6 +902,7 @@ static struct platform_driver stm32_timer_trigger_driver = {
 	.driver = {
 		.name = "stm32-timer-trigger",
 		.of_match_table = stm32_trig_of_match,
+		.pm = &stm32_timer_trigger_pm_ops,
 	},
 };
 module_platform_driver(stm32_timer_trigger_driver);
-- 
2.7.4

