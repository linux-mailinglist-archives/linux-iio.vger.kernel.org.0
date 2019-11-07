Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B959CF320D
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2019 16:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388530AbfKGPI2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Nov 2019 10:08:28 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:13082 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729804AbfKGPI1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Nov 2019 10:08:27 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA7F3dwC020943;
        Thu, 7 Nov 2019 10:07:57 -0500
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2052.outbound.protection.outlook.com [104.47.49.52])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w41vktgfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Nov 2019 10:07:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eR66SYdXnkinFP53nM+XxKkUfwJe84tjOr+/Zeuc3Z346m7tSgMHS7UY0PYGxmMSk2eNGANz5fCsfXg1jUxMRKwp6zZIsHfvqSnc9PlnwmTrjGUPMxykWhLnURLcmsOZohNc4aX8kquWoqsorAMwn7c/KI5eyDAvKc4a2tiHhnoeByjm+TLTutHOCBG+9NyIqR4o8PJ5E2BHpx90qL6ruvmnse4nDUVpovfr+/mBBQUpga+4hRFYU2uvYSlSDFUKgAK69z9z9xPdFgqlTPthlyya9pp/JrCiKpnBm85SmskxUdOHzG0aluQHPN7LTbPsdcvTdaPdgcxuXH9ckLgwtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cfej7ZKIjwfvoufybYuKLbX7aaSjp53cfGvCRdDtL5Q=;
 b=fHsJqKb2h/z3bOicBwr2bgR2DZ0TpA+nKlA5oGIzH2CcWsp7i04xgOZ9Z9uVBC89ct4wpKVFdI3pgAY5DWg1gfDLwMNlgvfde8ojSzJGHlUFwFcR8snZ6jZNG3ywqHd/02qk9Fe/BmDbUIMRE8vslXi3PHl/uGX/Ldh7F1E+WrIMe48vV+fcaw6tGhxGdiDwqYvr8aAjM/garceAKG2mQCbF6bBVl8GBE4u02NjIHpraWRFpJUEqAJLVIAmMNb/zVKDU7NMTMwkzqzFjpkDkfNggAEfbCd0GbvvPVU8nVx0W5c+AZvx/J0ASFEsUqcV6CjtjK2lmE/T5yNHzXqE57w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cfej7ZKIjwfvoufybYuKLbX7aaSjp53cfGvCRdDtL5Q=;
 b=AxIra26kqejgqaYxTOikNgcsT/76it14w4DP3AfHhUuCDcHihDZl4VWOiMm+4pRRuuSY4iHwWNJ14N+cNOxbAhkPf8kXe0vxuvQtGVGpsUjcepS8KdzcGlJpvfJolpGI5NNlw9VjwdVybKLfvy/pHY8S/akV0wa5zpt/TGPQ1dU=
Received: from CH2PR03CA0011.namprd03.prod.outlook.com (2603:10b6:610:59::21)
 by DM6PR03MB4410.namprd03.prod.outlook.com (2603:10b6:5:105::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Thu, 7 Nov
 2019 15:07:56 +0000
Received: from CY1NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by CH2PR03CA0011.outlook.office365.com
 (2603:10b6:610:59::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20 via Frontend
 Transport; Thu, 7 Nov 2019 15:07:56 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT021.mail.protection.outlook.com (10.152.75.187) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2430.20
 via Frontend Transport; Thu, 7 Nov 2019 15:07:55 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xA7F7s9F024255
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 7 Nov 2019 07:07:54 -0800
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.231) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 7 Nov 2019 10:07:54 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <paulmck@linux.ibm.com>, <mchehab+samsung@kernel.org>,
        <linus.walleij@linaro.org>, <nicolas.ferre@microchip.com>,
        <biabeniamin@outlook.com>, Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v3 3/4] dt-binding: iio: Add documentation for AD7091R5
Date:   Thu, 7 Nov 2019 17:07:58 +0200
Message-ID: <20191107150759.5937-3-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107150759.5937-1-beniamin.bia@analog.com>
References: <20191107150759.5937-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(136003)(189003)(199004)(316002)(486006)(446003)(126002)(11346002)(48376002)(16586007)(106002)(50226002)(5660300002)(966005)(8936002)(44832011)(336012)(54906003)(70586007)(76176011)(186003)(70206006)(476003)(7696005)(51416003)(2616005)(478600001)(426003)(50466002)(8676002)(246002)(26005)(2906002)(1076003)(305945005)(7636002)(6306002)(86362001)(36756003)(6916009)(4326008)(107886003)(7416002)(2351001)(356004)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4410;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38396bb0-ca22-4899-6a90-08d7639444e3
X-MS-TrafficTypeDiagnostic: DM6PR03MB4410:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <DM6PR03MB44109E8FA9FD1D550825D83FF0780@DM6PR03MB4410.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0214EB3F68
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9haWawTaV2XA5SCsyO4Imu4bUv5+Wfq7EE2qznt9yU+S2y3BlvSfJTODy+li5QqHA2GVH3MZi7GxXs5zQZ9DZa63lQQYcOVAwx3XyjpMolsY9ZWex+OLnTANhF2HaU2VCO+hqyQ5B+4beXWlaB++9KU9XShizGTfYpmTVyxUGz3mo6r9Pp8Ggt71hgpQDL9r9bnQLAykrxHzaxzkfMMyRnB+3EdVLrnDg2KecyEi+4nW9zxs1Rko8j8/iim8ull/D+C/HAcWc2OoAsvcE+MmBjfXOcdpP2q7rEClA+wPLQaWz47NcG4nWfXeFMM9U0jUl2ryewy64mXxZpLZXtJB9EzVAr6rSZ6ZLhQtX3AW/Qlg7oOArs1gMSiEAMQ4oNwB8ECRaGw9sJ9bbUT35e5assTL+zJrOaeLIID+6QLi8vojSVMX82LY3etXC72QNAxU7lPuP/kjTWiYLwCt8+HHq+SLadpjr2+1x4djoeIOgSc=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 15:07:55.6967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38396bb0-ca22-4899-6a90-08d7639444e3
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4410
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-07_05:2019-11-07,2019-11-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911070145
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Documentation for AD7091R5 ADC was added.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
Changes in v3:
-spdx identifier updated
-compatible property with lower case
-additionalProperties added
-hex value with lower case

 .../bindings/iio/adc/adi,ad7091r5.yaml        | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
new file mode 100644
index 000000000000..bef84fe6212d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7091r5.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7091R5 4-Channel 12-Bit ADC
+
+maintainers:
+  - Beniamin Bia <beniamin.bia@analog.com>
+
+description: |
+  Analog Devices AD7091R5 4-Channel 12-Bit ADC
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7091r-5.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7091r5
+
+  reg:
+    maxItems: 1
+
+  avcc-supply:
+    description:
+      Phandle to the Avcc power supply
+
+  interrupts:
+    maxItems: 1
+
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@2f {
+                compatible = "adi,ad7091r5";
+                reg = <0x2f>;
+
+                interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+                interrupt-parent = <&gpio>;
+        };
+    };
+...
-- 
2.17.1

