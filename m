Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6654C2A99EB
	for <lists+linux-iio@lfdr.de>; Fri,  6 Nov 2020 17:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgKFQ5z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Nov 2020 11:57:55 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:26764 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726034AbgKFQ5z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Nov 2020 11:57:55 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6Gq9uk030614;
        Fri, 6 Nov 2020 17:57:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=qJ5g4+BsJ2ro+DNS0P3N/BkqpRkYSggwgfeaYoIQ6QM=;
 b=xi1OazMft+2qavfr8UxD/+1hpoLSv0oHMmIpkJLAJHZqtmT/ckum6tZZxw/f/si3uEFp
 q+eIay4O64Mmb4MOVLJ+5XBi1M/0dE7N6wOg2AK4fwbtDhXCIR4CqEhGizRPJ4Q860UL
 G5ZNe3dk9Axk8b/itmh7j0242INT0wk9yuxc9nASTsxpaeU6NHUGQp6q4J8cScKDk/0N
 K3USH4SesgJejYP0LBcyewJVwOfXaRgjV/zmAw/zofzoeGguVuTqviWJU8HnDwXp0yTB
 7yt7adX0GaKQVXaO1jC4yVC/c5hijuoSBJc01eW5bbik3D1P4tcHLbd67rEP73CRaBpa kQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34h00ewjuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 17:57:46 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3F52C10002A;
        Fri,  6 Nov 2020 17:57:46 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag1node3.st.com [10.75.127.3])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2D2922C38D3;
        Fri,  6 Nov 2020 17:57:46 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG1NODE3.st.com (10.75.127.3)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov 2020 17:57:45
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <olivier.moysan@st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] iio: adc: stm32-adc: adapt clock duty cycle for proper operation
Date:   Fri, 6 Nov 2020 17:57:26 +0100
Message-ID: <1604681846-31234-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG1NODE3.st.com
 (10.75.127.3)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_06:2020-11-05,2020-11-06 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

For proper operation, STM32 ADC should be used with a clock duty cycle
of 50%, in the range of 49% to 51%. Depending on the clock tree, divider
can be used in case clock duty cycle is out of this range.
In case clk_get_scaled_duty_cycle() returns an error, kindly apply a
divider by default (don't make the probe fail).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-adc-core.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index cd870c0..d64a9e8 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -202,7 +202,7 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
 {
 	u32 ckmode, presc, val;
 	unsigned long rate;
-	int i, div;
+	int i, div, duty;
 
 	/* stm32h7 bus clock is common for all ADC instances (mandatory) */
 	if (!priv->bclk) {
@@ -226,6 +226,11 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
 			return -EINVAL;
 		}
 
+		/* If duty is an error, kindly use at least /2 divider */
+		duty = clk_get_scaled_duty_cycle(priv->aclk, 100);
+		if (duty < 0)
+			dev_warn(&pdev->dev, "adc clock duty: %d\n", duty);
+
 		for (i = 0; i < ARRAY_SIZE(stm32h7_adc_ckmodes_spec); i++) {
 			ckmode = stm32h7_adc_ckmodes_spec[i].ckmode;
 			presc = stm32h7_adc_ckmodes_spec[i].presc;
@@ -234,6 +239,13 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
 			if (ckmode)
 				continue;
 
+			/*
+			 * For proper operation, clock duty cycle range is 49%
+			 * to 51%. Apply at least /2 prescaler otherwise.
+			 */
+			if (div == 1 && (duty < 49 || duty > 51))
+				continue;
+
 			if ((rate / div) <= priv->max_clk_rate)
 				goto out;
 		}
@@ -246,6 +258,10 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
+	duty = clk_get_scaled_duty_cycle(priv->bclk, 100);
+	if (duty < 0)
+		dev_warn(&pdev->dev, "bus clock duty: %d\n", duty);
+
 	for (i = 0; i < ARRAY_SIZE(stm32h7_adc_ckmodes_spec); i++) {
 		ckmode = stm32h7_adc_ckmodes_spec[i].ckmode;
 		presc = stm32h7_adc_ckmodes_spec[i].presc;
@@ -254,6 +270,9 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
 		if (!ckmode)
 			continue;
 
+		if (div == 1 && (duty < 49 || duty > 51))
+			continue;
+
 		if ((rate / div) <= priv->max_clk_rate)
 			goto out;
 	}
-- 
2.7.4

