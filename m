Return-Path: <linux-iio+bounces-16011-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF2BA42965
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 18:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8467F1885839
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 17:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17EE2641E9;
	Mon, 24 Feb 2025 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="FUDrhTvW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B5C263F54;
	Mon, 24 Feb 2025 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740417573; cv=none; b=taQ6AGA7jpizzbmr3cyL5OYBTQ4ma3DGza7NDnMj0OpnwQOnfJIztD5KBZmZdSgjT7ifwYCcO5AmETBv6r0GmqNowNlRbCRPkABNjh04v+J/6lpnwJuutL3Qx1GoezAXFYkBx0hzHeS95N7uOFIdeieOi0jX8pJ2hp7rfv0pb5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740417573; c=relaxed/simple;
	bh=YVrfmmpuiZl97lPSQ+Q4oYh5oqB3+D2NaV+FRnSnx34=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iHomqysS4Z8ZzpNtanNZqM3uHpk4bdcV+e9UlpuvZ5FPcTi2/SowQP79Rid4BMeTn5vs4f7Xi7C8lnqAaNK4K539ernIsSjlSY9iqFx/A/psSbGotvj2ob7Pi/vry99V7hPa5rhT+Pxqk6D/TkNCrcL+Ljddq4rXX+y3rdJWWxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=FUDrhTvW; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OCixFa013141;
	Mon, 24 Feb 2025 18:18:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=GTr3MiF+X8E++5/d1k9zNi
	whyWX8NQucbTgDgyPXgzM=; b=FUDrhTvWnYasctYRtyGBXE9jaB4Bb2fd9efqkz
	U0icqpJMn4T+2PKvta5rvS3Ovu1JM0cXFy/eTYjh9gqTWmAyR6fyvovwYnJgbFWM
	bg2RG0PdeEvQs4Cn/iABWV+uMzcoJLfYZ6ovLb9eJcVs8nKsW0ksVFFeYn0Qz1x6
	pHGP5gRfJLlC4sVthXChcXruHPGgvIT5xI/q4+xDG8jTA5vYzPYDTJf2si1s2Yug
	GoQuKbknH2VNCz5CJwmkqQPyAJzlR2KFA34H0LMECIX9l5XGM8KE/dHZO4NiJF9a
	GGtSSqKkrJazdZsg9JOgyjN8h7BhRHZtORuRJIxQ985ml4Tg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44y6t20jjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 18:18:53 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3B60640044;
	Mon, 24 Feb 2025 18:17:49 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BC8145387F7;
	Mon, 24 Feb 2025 18:07:40 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 18:07:40 +0100
Received: from localhost (10.252.23.75) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 18:07:40 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <wbg@kernel.org>
CC: <alexandre.torgue@foss.st.com>, <olivier.moysan@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] counter: stm32-lptimer-cnt: fix error handling when enabling
Date: Mon, 24 Feb 2025 18:06:57 +0100
Message-ID: <20250224170657.3368236-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_08,2025-02-24_02,2024-11-22_01

In case the stm32_lptim_set_enable_state() fails to update CMP and ARR,
a timeout error is raised, by regmap_read_poll_timeout. It may happen,
when the lptimer runs on a slow clock, and the clock is gated only
few times during the polling.

Badly, when this happen, STM32_LPTIM_ENABLE in CR register has been set.
So the 'enable' state in sysfs wrongly lies on the counter being
correctly enabled, due to CR is read as one in stm32_lptim_is_enabled().

To fix both issues:
- enable the clock before writing CMP, ARR and polling ISR bits. It will
avoid the possible timeout error.
- clear the ENABLE bit in CR and disable the clock in the error path.

Fixes: d8958824cf07 ("iio: counter: Add support for STM32 LPTimer")
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/counter/stm32-lptimer-cnt.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index cf73f65baf60..b249c8647639 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -58,37 +58,43 @@ static int stm32_lptim_set_enable_state(struct stm32_lptim_cnt *priv,
 		return 0;
 	}
 
+	ret = clk_enable(priv->clk);
+	if (ret)
+		goto disable_cnt;
+
 	/* LP timer must be enabled before writing CMP & ARR */
 	ret = regmap_write(priv->regmap, STM32_LPTIM_ARR, priv->ceiling);
 	if (ret)
-		return ret;
+		goto disable_clk;
 
 	ret = regmap_write(priv->regmap, STM32_LPTIM_CMP, 0);
 	if (ret)
-		return ret;
+		goto disable_clk;
 
 	/* ensure CMP & ARR registers are properly written */
 	ret = regmap_read_poll_timeout(priv->regmap, STM32_LPTIM_ISR, val,
 				       (val & STM32_LPTIM_CMPOK_ARROK) == STM32_LPTIM_CMPOK_ARROK,
 				       100, 1000);
 	if (ret)
-		return ret;
+		goto disable_clk;
 
 	ret = regmap_write(priv->regmap, STM32_LPTIM_ICR,
 			   STM32_LPTIM_CMPOKCF_ARROKCF);
 	if (ret)
-		return ret;
+		goto disable_clk;
 
-	ret = clk_enable(priv->clk);
-	if (ret) {
-		regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
-		return ret;
-	}
 	priv->enabled = true;
 
 	/* Start LP timer in continuous mode */
 	return regmap_update_bits(priv->regmap, STM32_LPTIM_CR,
 				  STM32_LPTIM_CNTSTRT, STM32_LPTIM_CNTSTRT);
+
+disable_clk:
+	clk_disable(priv->clk);
+disable_cnt:
+	regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
+
+	return ret;
 }
 
 static int stm32_lptim_setup(struct stm32_lptim_cnt *priv, int enable)
-- 
2.25.1


