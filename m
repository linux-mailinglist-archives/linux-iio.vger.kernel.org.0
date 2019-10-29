Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB4CE8992
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2019 14:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388604AbfJ2Nbf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Oct 2019 09:31:35 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:9166 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388603AbfJ2Nbc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2019 09:31:32 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9TDRO96025702;
        Tue, 29 Oct 2019 09:31:01 -0400
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2051.outbound.protection.outlook.com [104.47.32.51])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vvjs67pdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 09:31:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNvVRDgwJNHBtge2OVZcyMlNoKer78we13KduDlc45me0IIznSBMVTnXX58csXQEduNl2a054x9+SioNo+FjzzK/GLdgRSU8Nx3Hl2koNaztPgDfTy2XzWYlPu4GfomjmOvbn+e6XX9D8gd2A269DrzjNXkEAfndtm3NBSbkdH6G1iqgomfs8gX42gnHg2EC5BX7AJ9tEa+NqJSascxQWklQovNHIrXJqIw8pn201scPh//cnoX8lNr78yYdYcH+r7RPYETJbIyxUz25e6rPj0Fl0SRVCztR6y4rpSn9RnZ6MANrAWGiIfAUgDM7BZQfMoMudmDfClUdwsnj8SduAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/amaYrqGuhjPwFNLJc33pq/tFhm1TJOvSZ5h4xAJZU=;
 b=EmOO9/S1RRTMoZGFP7ek+Gf//GDajgt6N7OXZm/f1F+NC6vOj9YncY+9Y0bF0f4w7iqrD8DbfQCd3X+6WBdz/eERcLPCJR8FjP0XqxAh+mBGft2J2BjImk67dIgzwQB1M23Bh3VwTff5qzfb6QKwxNCjwlD+vFC8fx+RApczolxMOKbaHOsHHfdhHVWDU6ZYfci+0yZsttb7VJYTXWWJ5oxTtMPyjSmZmvqlDfgVlbLoujlbauEdkuykKBSvk582jIUlKFgl8PR+kK+KwAdwZnU81oyZcT9elYCnhSOk0K3vSy0IsFoA7M213Glz4sdKSuhzdEBZWbmjTiVy3eLPvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/amaYrqGuhjPwFNLJc33pq/tFhm1TJOvSZ5h4xAJZU=;
 b=CzNLNWmI/6hcSQBo3poC/INHPuwygFEmxsuqzv1iukz6joVxT1svauAoN4tQyLZNTe53Kk5QBPBsUNhKKYYRFMFc2PAzulHNangWrjcZ8Gy4mkZKGOyde2KC2GeE4IDW9VZZur7ctm7fTyEMy7K2BYjgkhgtt6fkzAMLFJaCBXs=
Received: from BN3PR03CA0097.namprd03.prod.outlook.com (2603:10b6:400:4::15)
 by MN2PR03MB4910.namprd03.prod.outlook.com (2603:10b6:208:108::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.22; Tue, 29 Oct
 2019 13:30:59 +0000
Received: from CY1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by BN3PR03CA0097.outlook.office365.com
 (2603:10b6:400:4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.22 via Frontend
 Transport; Tue, 29 Oct 2019 13:30:58 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT053.mail.protection.outlook.com (10.152.74.165) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Tue, 29 Oct 2019 13:30:58 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x9TDUvj9018981
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 29 Oct 2019 06:30:57 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 29 Oct 2019 09:30:57 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <paulmck@linux.ibm.com>,
        <mchehab+samsung@kernel.org>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v2 3/4] dt-binding: iio: Add documentation for AD7091R5
Date:   Tue, 29 Oct 2019 18:29:27 +0200
Message-ID: <20191029162928.9720-3-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029162928.9720-1-beniamin.bia@analog.com>
References: <20191029162928.9720-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(2351001)(86362001)(966005)(305945005)(7636002)(8936002)(6306002)(4326008)(50226002)(7416002)(106002)(54906003)(8676002)(70206006)(26005)(47776003)(51416003)(7696005)(76176011)(478600001)(186003)(246002)(70586007)(336012)(426003)(36756003)(486006)(11346002)(126002)(446003)(6916009)(476003)(2616005)(44832011)(16586007)(50466002)(48376002)(5660300002)(6666004)(356004)(107886003)(2906002)(316002)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB4910;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 375c44b4-88b3-469f-8966-08d75c743bdd
X-MS-TrafficTypeDiagnostic: MN2PR03MB4910:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <MN2PR03MB49107E9E845D9899D9EB9B9EF0610@MN2PR03MB4910.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0205EDCD76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nqen8xVFmnScHnHPf1ssVsmM7WrZBpXK/t/uXssx1DJkI8QQfcPaVOQpiwnhSWwE/I7kSGJ/MwEn44Me4W2BtjsHrKMUlj+HArskxhIOCFV0vcmviGLZ+GmoPP/bDiAZwRtxTzPTJVMk6RTGltiZ4waxAiNUO7NY38gDDdV0Av9bj11qUAO5xgaaV7NrYZMSWM2oHwRZA7CBoCY+8F1CbQcvvL1hggW6dlrMOPoKTXyj2ea70MVIVMwehq/1Zki/7KZ/O1LE204RFhfZmEGptLbGM7agSAVawcGUNTm1nncVrSTFJrWoUHn7Z95oiwcMirsRrgGOWk+KF6XXNYojdFuiGkJn9Ia30ONfzVcrj7imvvVVVEAMx4ICn8jOsTe0HrJ8r3hrGIT5jzIKdJjlpym8sH6MRZtReaZes9rGyKfFTXamAdR7km1uBl+nWgzi9QPzXKt3YmLW3im1sInW4sjcw8qPbTscn+01WaphC/0=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2019 13:30:58.5169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 375c44b4-88b3-469f-8966-08d75c743bdd
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4910
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-29_04:2019-10-28,2019-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910290132
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Documentation for AD7091R5 ADC was added.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
Changes in v2:
-nothing changed
 .../bindings/iio/adc/adi,ad7091r5.yaml        | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
new file mode 100644
index 000000000000..d041cd76804e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0
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
+      - adi,ad7091R5
+
+  reg:
+    maxItems: 1
+
+  avcc-supply:
+    description:
+      Phandle to the Avcc power supply
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+                compatible = "adi,ad7091r5";
+                reg = <0x2F>;
+
+                interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+                interrupt-parent = <&gpio>;
+        };
+    };
+...
-- 
2.17.1

