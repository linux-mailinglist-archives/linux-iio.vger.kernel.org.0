Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71A2441DAC
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2019 09:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbfFLHZl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Jun 2019 03:25:41 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:27572 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731309AbfFLHZk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Jun 2019 03:25:40 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5C7LR7t019818;
        Wed, 12 Jun 2019 09:25:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=6qaOOTyHrNsrJS+2fQ2Aj0gbIenq5jh+c1GY5P/uHDE=;
 b=MUnuUO/e+4Qbi+4GZnRij5KVKMn9YM7lSTx48TQMb8WuDgmFf2o8XBro8X4z0//5qzxx
 aWt1I19eL0QkAxGe/6i4wFT62Ra/vtZO6M1FHFXEe9gXK9fnFwDmyvfMmPAHX9PorDiJ
 pXwNCxa/AaV4YaycBUN8GfVUBcLK84DKHNH4ncL5lSEXXahfjd2ZkHlGhAnYx6FQ2hpc
 N2Xr38gxFGDbA0E5YcBEFYTYQaqR6PP93elEW9fM9Ea13lR1Tr2l2f9RjTXyjgDycz5+
 QCSADeMa5RgZiBODdEIr1fz9Weo4yd5+m4flS1VZHjqQa051MiD3KtLpGCRdcMbtQBCo YQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t2f8e3ks9-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 12 Jun 2019 09:25:01 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5E28531;
        Wed, 12 Jun 2019 07:25:00 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 32C6A164B;
        Wed, 12 Jun 2019 07:25:00 +0000 (GMT)
Received: from localhost (10.75.127.48) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 12 Jun 2019 09:24:59
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
Subject: [PATCH 1/3] dt-bindings: iio: adc: stm32: add analog switches supply control
Date:   Wed, 12 Jun 2019 09:24:34 +0200
Message-ID: <1560324276-681-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560324276-681-1-git-send-email-fabrice.gasnier@st.com>
References: <1560324276-681-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-12_04:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On stm32h7 and stm32mp1, the ADC inputs are multiplexed with analog
switches which have reduced performances when their supply is below 2.7V
(vdda by default).

Add documentation for optional vdda-supply & vdd-supply that can be used
to supply analog circuitry (controlled by syscfg bits).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
index 8346bcb..3af48b9 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
@@ -46,6 +46,12 @@ Required properties:
 Optional properties:
 - A pinctrl state named "default" for each ADC channel may be defined to set
   inX ADC pins in mode of operation for analog input on external pin.
+- vdda-supply: Phandle to the vdda input voltage. It can be used to supply ADC
+  analog inputs switches on stm32h7 and stm32mp1.
+- vdd-supply: Phandle to the vdd input voltage. It can be used to supply ADC
+  analog inputs switches on stm32mp1.
+- st,syscfg: Phandle to system configuration controller. It can be used to
+  control the analog circuitry on stm32h7 and stm32mp1.
 
 Contents of a stm32 adc child node:
 -----------------------------------
-- 
2.7.4

