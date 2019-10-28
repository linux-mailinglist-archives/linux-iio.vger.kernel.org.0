Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6928FE75DB
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2019 17:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbfJ1QM0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Oct 2019 12:12:26 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:44731 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730436AbfJ1QMZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Oct 2019 12:12:25 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9SFu2aq023368;
        Mon, 28 Oct 2019 17:11:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=CM9gDRKKxbqasjyuOfTE0X/UG/yfSLvoQfkO2xJSMkU=;
 b=eipmSO+CXc1j0cU38m0HAn+OGIpV1ILX9Fy2IvNLSEBTrYS/gV0WHkrWkm/LIFr1fG1Z
 M8bU2jkArGGi4gcvN97WQyirUUmS90WM2lHtAU62eRCzZxajl0JKf3CBXGUe9mkaaLQi
 1bb9ZREKkAcY0ptcyuj8vGAVvY7WlvjbUz0AQmK2jvrD1UiIE7KTrPVSdl6GUJd299Vj
 sCQ87vZ+YjvZYV+j6JG4vexoM+Ys4TC8nwgTIUF4kR8iQNzfa3RhB89axWhgXvY0U53S
 GS0Z4k1A1XsN/KTsSUK6UAjzaAaqfLevykid0cJaRATAoH4//DIF9AmFyXUg2GDUN7xP 8g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vvbww33yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Oct 2019 17:11:57 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1F3D3100034;
        Mon, 28 Oct 2019 17:11:57 +0100 (CET)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0EE9F2B1E73;
        Mon, 28 Oct 2019 17:11:57 +0100 (CET)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 28 Oct
 2019 17:11:56 +0100
Received: from localhost (10.48.0.192) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 28 Oct 2019 17:11:56 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     <alexandre.torgue@st.com>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] iio: adc: stm32: allow to tune analog clock
Date:   Mon, 28 Oct 2019 17:11:48 +0100
Message-ID: <1572279108-25916-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572279108-25916-1-git-send-email-fabrice.gasnier@st.com>
References: <1572279108-25916-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.192]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-28_06:2019-10-28,2019-10-28 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add new optional dt property to tune analog clock prescaler.
Driver looks for optional "st,max-clk-rate-hz", then computes
best approximation below that rate, using ADC internal prescaler.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-adc-core.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 20c626c..6537f4f 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -79,6 +79,7 @@ struct stm32_adc_priv_cfg {
  * @domain:		irq domain reference
  * @aclk:		clock reference for the analog circuitry
  * @bclk:		bus clock common for all ADCs, depends on part used
+ * @max_clk_rate:	desired maximum clock rate
  * @booster:		booster supply reference
  * @vdd:		vdd supply reference
  * @vdda:		vdda analog supply reference
@@ -95,6 +96,7 @@ struct stm32_adc_priv {
 	struct irq_domain		*domain;
 	struct clk			*aclk;
 	struct clk			*bclk;
+	u32				max_clk_rate;
 	struct regulator		*booster;
 	struct regulator		*vdd;
 	struct regulator		*vdda;
@@ -141,7 +143,7 @@ static int stm32f4_adc_clk_sel(struct platform_device *pdev,
 	}
 
 	for (i = 0; i < ARRAY_SIZE(stm32f4_pclk_div); i++) {
-		if ((rate / stm32f4_pclk_div[i]) <= priv->cfg->max_clk_rate_hz)
+		if ((rate / stm32f4_pclk_div[i]) <= priv->max_clk_rate)
 			break;
 	}
 	if (i >= ARRAY_SIZE(stm32f4_pclk_div)) {
@@ -230,7 +232,7 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
 			if (ckmode)
 				continue;
 
-			if ((rate / div) <= priv->cfg->max_clk_rate_hz)
+			if ((rate / div) <= priv->max_clk_rate)
 				goto out;
 		}
 	}
@@ -250,7 +252,7 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
 		if (!ckmode)
 			continue;
 
-		if ((rate / div) <= priv->cfg->max_clk_rate_hz)
+		if ((rate / div) <= priv->max_clk_rate)
 			goto out;
 	}
 
@@ -655,6 +657,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = pdev->dev.of_node;
 	struct resource *res;
+	u32 max_rate;
 	int ret;
 
 	if (!pdev->dev.of_node)
@@ -731,6 +734,13 @@ static int stm32_adc_probe(struct platform_device *pdev)
 	priv->common.vref_mv = ret / 1000;
 	dev_dbg(&pdev->dev, "vref+=%dmV\n", priv->common.vref_mv);
 
+	ret = of_property_read_u32(pdev->dev.of_node, "st,max-clk-rate-hz",
+				   &max_rate);
+	if (!ret)
+		priv->max_clk_rate = min(max_rate, priv->cfg->max_clk_rate_hz);
+	else
+		priv->max_clk_rate = priv->cfg->max_clk_rate_hz;
+
 	ret = priv->cfg->clk_sel(pdev, priv);
 	if (ret < 0)
 		goto err_hw_stop;
-- 
2.7.4

