Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791B5210E25
	for <lists+linux-iio@lfdr.de>; Wed,  1 Jul 2020 16:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgGAO4a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Jul 2020 10:56:30 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:42046 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726854AbgGAO43 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Jul 2020 10:56:29 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061EtrS5003069;
        Wed, 1 Jul 2020 16:56:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=nGDxePmF8IHyOLxj56WyGmH8rDztYQ7/Xj77p7TVsIY=;
 b=wpXgP/rpD0IANM8/tkoEOdkQWEETKMnvIvHdvYz/RnTNlb/T9hYWhL/hRDfBxv8YFH/g
 q0pcI2muFSjnAz89Zjo6N3lL1hZpAkjfYj8kevyScHcluxdmTEDW05zjQciBmBcxr4wR
 O4MhmBrZZT46RR5YuFouOnSL2usw1wHaDvrHKzKHtWtkOLNclPEjCiZO3b0xVMwvG7Zy
 L3FNKVzXsCmTpk2tpDh1v5S4scfP48xfXDozmU7kqAisBH+mcX79tA68FBB7zVWlSsbe
 yW8HHdy0eoVr9uEBDqdcHSFtRvHlFo7D4HeEGKZyyNA9f2G3LKcv2C8iT4dUYhE7glVN cg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31wuk1jsy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 16:56:11 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1F6E210002A;
        Wed,  1 Jul 2020 16:56:10 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0F0502BE22C;
        Wed,  1 Jul 2020 16:56:10 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Jul 2020 16:56:09
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>, <rafael.j.wysocki@intel.com>
CC:     <rjw@rjwysocki.net>, <ulf.hansson@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <olivier.moysan@st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [RESEND PATCH v2] iio: adc: stm32-adc: fix runtime autosuspend delay when slow polling
Date:   Wed, 1 Jul 2020 16:55:28 +0200
Message-ID: <1593615328-5180-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_08:2020-07-01,2020-07-01 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When the ADC is runtime suspended and starting a conversion, the stm32-adc
driver calls pm_runtime_get_sync() that gets cascaded to the parent
(e.g. runtime resume of stm32-adc-core driver). This also kicks the
autosuspend delay (e.g. 2s) of the parent.
Once the ADC is active, calling pm_runtime_get_sync() again (upon a new
capture) won't kick the autosuspend delay for the parent (stm32-adc-core
driver) as already active.

Currently, this makes the stm32-adc-core driver go in suspend state
every 2s when doing slow polling. As an example, doing a capture, e.g.
cat in_voltageY_raw at a 0.2s rate, the auto suspend delay for the parent
isn't refreshed. Once it expires, the parent immediately falls into
runtime suspended state, in between two captures, as soon as the child
driver falls into runtime suspend state:
- e.g. after 2s, + child calls pm_runtime_put_autosuspend() + 100ms
  autosuspend delay of the child.
- stm32-adc-core switches off regulators, clocks and so on.
- They get switched on back again 100ms later in this example (at 2.2s).

So, use runtime_idle() callback in stm32-adc-core driver to call
pm_runtime_mark_last_busy() for the parent driver (stm32-adc-core),
to avoid this.

Fixes: 9bdbb1139ca1 ("iio: adc: stm32-adc: add power management support")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- Use runtime_idle callback in stm32-adc-core driver, instead of refreshing
  last_busy from the child (for the parent) at many place. Initial patch v1
  looked like "somewhat adhoc solution" as commented by Jonathan.
---
 drivers/iio/adc/stm32-adc-core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 0e2068e..3586369 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -794,6 +794,13 @@ static int stm32_adc_core_runtime_resume(struct device *dev)
 {
 	return stm32_adc_core_hw_start(dev);
 }
+
+static int stm32_adc_core_runtime_idle(struct device *dev)
+{
+	pm_runtime_mark_last_busy(dev);
+
+	return 0;
+}
 #endif
 
 static const struct dev_pm_ops stm32_adc_core_pm_ops = {
@@ -801,7 +808,7 @@ static const struct dev_pm_ops stm32_adc_core_pm_ops = {
 				pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(stm32_adc_core_runtime_suspend,
 			   stm32_adc_core_runtime_resume,
-			   NULL)
+			   stm32_adc_core_runtime_idle)
 };
 
 static const struct stm32_adc_priv_cfg stm32f4_adc_priv_cfg = {
-- 
2.7.4

