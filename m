Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2E081391F1
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 14:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgAMNQE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 08:16:04 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11282 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726480AbgAMNP6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 08:15:58 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00DDCXEO025692;
        Mon, 13 Jan 2020 14:15:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=yDCgA3kxJZEHgyyrr5sS+bbWlkEZUo6bKQ+58eLac0k=;
 b=lTniZJLMvQIj8q/BxA4i4Ud7OigTIqXbjMed/ApdxbjFueGhHOt0hPhUK/ZOSZrrOLrX
 J6icXbKNNUTtLvUGB+rG93hmTQP8m9jxNcxSaGWeoxBxya5OF2U79nKj1kmt+RG9ACBb
 UaBQmJWZuxUhulm7srRgUOLGG9pnmjxTPdZ3P9XkBWBi7T05t6D+fBL2NXYnKPqWN2LA
 ikQEfkta0JjeZfaosrK7ui7jVNDMbsn9bPTDiQo0M/MmonISuHTg9pp+2QB2v4DMo1k8
 JYQQTkZX5JL3GQk6hvDxYkcTtp8+/r+HcedtoBL58TH34AHvFNefgFToQ4yQvUsv0m3y cg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xf78s07dt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jan 2020 14:15:34 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0A9C6100034;
        Mon, 13 Jan 2020 14:15:34 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E96E42B8212;
        Mon, 13 Jan 2020 14:15:33 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jan 2020 14:15:33
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <olivier.moysan@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <etienne.carriere@st.com>
Subject: [PATCH 1/2] iio: dac: stm32-dac: use reset controller only at probe time
Date:   Mon, 13 Jan 2020 14:14:25 +0100
Message-ID: <1578921266-6025-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578921266-6025-1-git-send-email-fabrice.gasnier@st.com>
References: <1578921266-6025-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_03:2020-01-13,2020-01-13 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Etienne Carriere <etienne.carriere@st.com>

This change removes the reset controller reference from the local
DAC instance since it is used only at probe time.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/dac/stm32-dac-core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/stm32-dac-core.c b/drivers/iio/dac/stm32-dac-core.c
index 9e6b4cd..4d93446 100644
--- a/drivers/iio/dac/stm32-dac-core.c
+++ b/drivers/iio/dac/stm32-dac-core.c
@@ -20,13 +20,11 @@
 /**
  * struct stm32_dac_priv - stm32 DAC core private data
  * @pclk:		peripheral clock common for all DACs
- * @rst:		peripheral reset control
  * @vref:		regulator reference
  * @common:		Common data for all DAC instances
  */
 struct stm32_dac_priv {
 	struct clk *pclk;
-	struct reset_control *rst;
 	struct regulator *vref;
 	struct stm32_dac_common common;
 };
@@ -94,6 +92,7 @@ static int stm32_dac_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	struct resource *res;
 	void __iomem *mmio;
+	struct reset_control *rst;
 	int ret;
 
 	if (!dev->of_node)
@@ -148,11 +147,11 @@ static int stm32_dac_probe(struct platform_device *pdev)
 	priv->common.vref_mv = ret / 1000;
 	dev_dbg(dev, "vref+=%dmV\n", priv->common.vref_mv);
 
-	priv->rst = devm_reset_control_get_exclusive(dev, NULL);
-	if (!IS_ERR(priv->rst)) {
-		reset_control_assert(priv->rst);
+	rst = devm_reset_control_get_exclusive(dev, NULL);
+	if (!IS_ERR(rst)) {
+		reset_control_assert(rst);
 		udelay(2);
-		reset_control_deassert(priv->rst);
+		reset_control_deassert(rst);
 	}
 
 	if (cfg && cfg->has_hfsel) {
-- 
2.7.4

