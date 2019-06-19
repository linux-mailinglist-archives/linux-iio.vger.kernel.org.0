Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7CF84B881
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2019 14:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731982AbfFSMb1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Jun 2019 08:31:27 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1545 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731976AbfFSMb0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Jun 2019 08:31:26 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5JCQNaW013623;
        Wed, 19 Jun 2019 14:30:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=kxAUn6YKO/6reWm+S4P6PSKzShP240Rigo7ZQoE8C8M=;
 b=Ar7HMxacmbYTf5gEF8rpp907cGkQmoofbHV19CJ0Hr2/E9baYNAfy6tMHFBRX93GYGh5
 xswIqwZUXSVAt1Rv+YCY9d4J2r4/vzuYnaG57C9amNcCOvy++MlwKpUg0OwygIPmmJVG
 ijZ/YBnE1X9QSXps+3lv3SbuDIIuuUaHxZp6edTfBGO/bEpB9bHNtOXFBBkLTPM6S77N
 Z/hJloy+zPpflVsemzEvgM+xvOdvA65AYq9EXlQ8F2NVFZu5raRbqQ8fhRWCmkEJ16tz
 AvCyFM5UlNsOUpJ1mcbCEyeFcNO7dYQiJrJD+J9qVHSi6MZa0TojAVYDRc3wiuIOfhnH nw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t781uux8t-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 19 Jun 2019 14:30:55 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1233634;
        Wed, 19 Jun 2019 12:30:55 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E500D27A5;
        Wed, 19 Jun 2019 12:30:54 +0000 (GMT)
Received: from localhost (10.75.127.44) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Jun 2019 14:30:54
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <alexandre.torgue@st.com>
CC:     <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] ARM: dts: stm32: add missing vdda-supply to adc on stm32h743i-eval
Date:   Wed, 19 Jun 2019 14:29:58 +0200
Message-ID: <1560947398-11592-6-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560947398-11592-1-git-send-email-fabrice.gasnier@st.com>
References: <1560947398-11592-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_07:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add missing vdda-supply required by STM32 ADC.

Fixes: 090992a9ca54 ("ARM: dts: stm32: enable ADC on stm32h743i-eval
board")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32h743i-eval.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stm32h743i-eval.dts b/arch/arm/boot/dts/stm32h743i-eval.dts
index ab78ad5..e4d3c58 100644
--- a/arch/arm/boot/dts/stm32h743i-eval.dts
+++ b/arch/arm/boot/dts/stm32h743i-eval.dts
@@ -87,6 +87,7 @@
 };
 
 &adc_12 {
+	vdda-supply = <&vdda>;
 	vref-supply = <&vdda>;
 	status = "okay";
 	adc1: adc@0 {
-- 
2.7.4

