Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3A742D9EC
	for <lists+linux-iio@lfdr.de>; Thu, 14 Oct 2021 15:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhJNNPs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Oct 2021 09:15:48 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40520 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230010AbhJNNPr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Oct 2021 09:15:47 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19EBkTaA020330;
        Thu, 14 Oct 2021 15:13:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=aV08SqbAMcMfMc2tv8tumhWBDoZ1vN9XbFUHNfHVQpM=;
 b=xRmAWxBDtlGttemkIwzllslb3vVnt7lHLVD2XHOHIUMUea8vil1gX6h1j1iVkS98OQ7o
 BwqZFNxX20mKpw4ujLrwFhgkfLNSRuufD3qywsWQz5oQ8EyXiOApGAVLy89zipui7nDA
 zsRIbqOHYeobY6GNnRSnGpn9LUil6Y1+OHTpkuAfHGe/DpvH9k1Nko4XC7TTCSUy1UxF
 cTVmJdxpdQYH20qNLqFDIZVXSTMUn+mkTWTppLR9UQV6SDIPZeaERM/FjEQ8jrbQ1496
 nCeUs22PVv/t45P5bTkHvNUZot/zbTwvMGCzTwQqYaqeKR1UmV2PTohz8yPlx6dfHBTA VA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bpkye8fyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 15:13:22 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 06FDE10002A;
        Thu, 14 Oct 2021 15:13:22 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0039422179A;
        Thu, 14 Oct 2021 15:13:22 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 14 Oct 2021 15:13:21
 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v5 2/7] dt-bindings: iio: stm32-adc: add nvmem support for vrefint internal channel
Date:   Thu, 14 Oct 2021 15:12:23 +0200
Message-ID: <20211014131228.4692-3-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211014131228.4692-1-olivier.moysan@foss.st.com>
References: <20211014131228.4692-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-14_08,2021-10-14_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support of nvmem. This allows to retrieve calibration data from OTP
for vrefint internal channel.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
index 2083e1723970..ec0450d111a9 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
@@ -301,6 +301,14 @@ patternProperties:
         $ref: /schemas/types.yaml#/definitions/uint32-array
         deprecated: true
 
+      nvmem-cells:
+        items:
+          - description: Phandle to the calibration vrefint data provided by otp
+
+      nvmem-cell-names:
+        items:
+          - const: vrefint
+
     patternProperties:
       "^channel@([0-9]|1[0-9])$":
         type: object
-- 
2.17.1

