Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90ED941DA3
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2019 09:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbfFLHZm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Jun 2019 03:25:42 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:3938 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729080AbfFLHZk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Jun 2019 03:25:40 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5C7LXNM032480;
        Wed, 12 Jun 2019 09:25:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=mscPIPZ3FaNG1fi5inSmP9H7jFv8oBUHJnCQ3UPmBlE=;
 b=acMmyrCwj6N46GmEph6JwKd35yXOV71CZZlDPjJ3TYyG1LfBriKSz6H3Xg4mT0QTNJIc
 apRV1Lq8OdtXeYqfkWxEb0HF8pMi5+OWtd+bQdEPw73+D9J/ni1zFRFdkDEpRiDebMcv
 O9Mfsqf6ut9ZcQ4w3iXhazPoTKSNjqFxHQSRPAaoApScRlWo/3yPL+oV0cfO6J8okujh
 sEivAA8CaZggmlbBfIBKOuenOH/yIvQAZBpfKPF6kCT9yJF+d6q4kmPSadddkKynUEHr
 joqgQCjfL2Rtz5LdK9DtnS6JP8bhipdawayoBuvgDipL1leC18zifKehN5GiZJkr1SV2 1w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t2f8bukdj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 12 Jun 2019 09:25:04 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 798D63D;
        Wed, 12 Jun 2019 07:25:03 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0C0C7164B;
        Wed, 12 Jun 2019 07:25:03 +0000 (GMT)
Received: from localhost (10.75.127.48) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 12 Jun 2019 09:25:02
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
Subject: [PATCH 3/3] ARM: dts: stm32: add ADC analog switches syscfg on stm32mp157c
Date:   Wed, 12 Jun 2019 09:24:36 +0200
Message-ID: <1560324276-681-4-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560324276-681-1-git-send-email-fabrice.gasnier@st.com>
References: <1560324276-681-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-12_04:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On stm32mp157c, the ADC inputs are multiplexed with analog switches which
have reduced performances when their supply is below 2.7V (vdda by
default).
Add syscfg registers that can be used on stm32mp157c, to get full ADC
analog performances.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 2afeee6..64d71c9 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -856,6 +856,7 @@
 			clocks = <&rcc ADC12>, <&rcc ADC12_K>;
 			clock-names = "bus", "adc";
 			interrupt-controller;
+			st,syscfg = <&syscfg>;
 			#interrupt-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.7.4

