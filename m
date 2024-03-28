Return-Path: <linux-iio+bounces-3374-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9BF87501A
	for <lists+linux-iio@lfdr.de>; Thu,  7 Mar 2024 14:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76CF1284E12
	for <lists+linux-iio@lfdr.de>; Thu,  7 Mar 2024 13:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B92D12D207;
	Thu,  7 Mar 2024 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="0h+P8tzj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD7612D1E6;
	Thu,  7 Mar 2024 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818520; cv=none; b=QdR2M39LrDAGqhUYBDTeyxcUsbUNkZN7IPDTYU8XsWCJtdLGFM3t9wIaUOVZHQr+L2j9OiwlbBRJjTSG8uk0QQIcu5+ZREQDSnGy0kaMp0CHmd0bJepJwYrIaB5L07xQqdr6+BS18yvQw4LRbgeQPrDlqal6vwzSda+0g19vYBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818520; c=relaxed/simple;
	bh=4MV3yiEP4CbmzVs4TIOaCa08KW+aB7L6ZlCGa1jf5kM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T6IKkcszv9Nih/v1VkBeo90H/P/SPE0vLAssXcz6QvjfwNrCKcqG73/udw/QesUA0smNILrjpw/HMHvlCJ3GPCVjlmSiU8AtRsDTijlq0NaYLFNCqbVY0IK8cJGnCJipDLIuk0tLen5sSR1gZcvsDjZILpNMu43vJzssWRe+15Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=0h+P8tzj; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4279Ya15007106;
	Thu, 7 Mar 2024 14:35:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=ElfAaGaHRlTpUHfuhu7chh+EcaBsNYx6kELVdLzTaZI=; b=0h
	+P8tzjmaQAP6ZQE/TbjNxBauUHHWc7Ncle9h89wN40Vk/jRhtGWVSq3xLzL/RIsd
	+2s2kbuDEUOSDxrYVA6nlMLD6jtdxGsNApo77mZIvsewdCOWbud1C9EWVbikk8dC
	EhpOwQhJd8F/kiq8aKiZ15gcGo9ofDsPrV4bEix/4wp+abxAYNBNA8PuuzOa1HOF
	zLpRYKtAzLNOPf/tasDG5lLxg1jyGkYj9gEg9cYtZpOcSjNWUqEWm2RPTpWzczNf
	ibrYKeP8GPL7+ASGxE+oXSW8jITfkaaOnF1IHDmtvHHw7td7MyN7K1YtbaEhQS3i
	jRllMwbVuvbpAB3gkYQw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wmej5dtv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 14:35:08 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 26C1E40048;
	Thu,  7 Mar 2024 14:35:05 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E2C7327A500;
	Thu,  7 Mar 2024 14:34:39 +0100 (CET)
Received: from localhost (10.201.22.191) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Mar
 2024 14:34:39 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <william.gray@linaro.org>
CC: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 05/10] counter: stm32-timer-cnt: add counter prescaler extension
Date: Thu, 7 Mar 2024 14:33:01 +0100
Message-ID: <20240307133306.383045-6-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240307133306.383045-1-fabrice.gasnier@foss.st.com>
References: <20240307133306.383045-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02

There's a prescaler in between the selected input signal used for
counting (CK_PSC), and the counter input (CK_CNT).
So add the "prescaler" extension to the counter.

Reviewed-by: William Breathitt Gray <william.gray@linaro.org>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v4:
- Add William's Reviewed-by tag
Changes in v3:
- New patch split from "counter: stm32-timer-cnt: introduce clock signal"
---
 drivers/counter/stm32-timer-cnt.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 65b447b42e75..b969d550e90a 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -220,11 +220,40 @@ static int stm32_count_enable_write(struct counter_device *counter,
 	return 0;
 }
 
+static int stm32_count_prescaler_read(struct counter_device *counter,
+				      struct counter_count *count, u64 *prescaler)
+{
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
+	u32 psc;
+
+	regmap_read(priv->regmap, TIM_PSC, &psc);
+
+	*prescaler = psc + 1;
+
+	return 0;
+}
+
+static int stm32_count_prescaler_write(struct counter_device *counter,
+				       struct counter_count *count, u64 prescaler)
+{
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
+	u32 psc;
+
+	if (!prescaler || prescaler > MAX_TIM_PSC + 1)
+		return -ERANGE;
+
+	psc = prescaler - 1;
+
+	return regmap_write(priv->regmap, TIM_PSC, psc);
+}
+
 static struct counter_comp stm32_count_ext[] = {
 	COUNTER_COMP_DIRECTION(stm32_count_direction_read),
 	COUNTER_COMP_ENABLE(stm32_count_enable_read, stm32_count_enable_write),
 	COUNTER_COMP_CEILING(stm32_count_ceiling_read,
 			     stm32_count_ceiling_write),
+	COUNTER_COMP_COUNT_U64("prescaler", stm32_count_prescaler_read,
+			       stm32_count_prescaler_write),
 };
 
 static const enum counter_synapse_action stm32_clock_synapse_actions[] = {
-- 
2.25.1


