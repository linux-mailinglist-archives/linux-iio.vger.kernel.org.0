Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24BB416E03
	for <lists+linux-iio@lfdr.de>; Fri, 24 Sep 2021 10:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244807AbhIXIhX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Sep 2021 04:37:23 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:47004 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244722AbhIXIhW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Sep 2021 04:37:22 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18O82UZu001303;
        Fri, 24 Sep 2021 10:35:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=ljjaZUBXtszXsUCqJX2Wbg58kZebxTbHrmKULo2rDBo=;
 b=VxnqWhINv6P2wnbEvwFpvAQxCYdoZOUpcj/ZC/g+tYLX9A+szJPivZJ/99sZtMnWEatK
 hGjnBlJWCGiDu9BBNplqIIajPqH8cGxUeO8/qDr3nJU64AxiuyS7jSxcZo10SFik3cB5
 +iF4dzsdYpEdYylMVILTsBxJ78nx25264z6XTinsUIdL4N28ZkflEGjGkRubA2S2uR2q
 wX6TXgfq0rgwKc06FRlXEE7FHNYgbcwy9E+tdyCUxtjaxLrMjD8ElyEyPNSrQHMIs3L+
 ykBb9sqvtmfzYlSBARZvV0RBousBycjUzlMpp4B7kCZt8nTFme2nq+MEY5+tgN9DMkx+ yg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3b93dxae0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Sep 2021 10:35:27 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A68E310002A;
        Fri, 24 Sep 2021 10:35:26 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9BE6B226FB0;
        Fri, 24 Sep 2021 10:35:26 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 24 Sep 2021 10:35:26
 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v3 2/7] dt-bindings: iio: stm32-adc: add nvmem support for vrefint internal channel
Date:   Fri, 24 Sep 2021 10:34:05 +0200
Message-ID: <20210924083410.12332-3-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210924083410.12332-1-olivier.moysan@foss.st.com>
References: <20210924083410.12332-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-24_02,2021-09-23_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support of nvmem. This allows to retrieve calibration data from OTP
for vrefint internal channel.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
index 1c13921b0556..6a5d0181e784 100644
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

