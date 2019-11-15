Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F14EFDF82
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2019 14:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfKON5x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Nov 2019 08:57:53 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:54426 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727412AbfKON5x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Nov 2019 08:57:53 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFDlo4a005536;
        Fri, 15 Nov 2019 08:57:33 -0500
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2058.outbound.protection.outlook.com [104.47.49.58])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w7pr6t499-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Nov 2019 08:57:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDjZRCdUmpcJWJrSHFVNgNjGwLJ34fnO6ApGM3zunWSqgzkXAV7Lj3cSoPykZHFtj+OpRry5kv/OeDAMxo2WJInE0q+1JIT/JZjESqdphY8j4HwedYAztc/BHxVC+egTm/leh/YYYVUlQrDOPflONAiEqVrb2jbodp3VgoSTQr9NWi1PKxJ7Y+ftvQ7sgbEhz259e+qXu+1jeeU1ZSZPOnMF8+jT/r26pZOTUYJIWTjPPAy6uyz0sXICiJ1iHlf6jG3s4UEohgKZPhJlUJvLGq9i5hts1cFI8CxnU4wfVpSdxizeu2WCDNJjs8DVYmwPkUgblb9bl43M8jVxbAvvjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M04F2C9o4js6J6QnEpHb0CRH9AxEa5A/7C0KTQZ2v94=;
 b=nb3RCq6OwEjeCDPnow1BDfuBFWsgLsjPRn5Qx6HZ+RPnGTJ+z6rq2+PsRDh40SDgvE0V65q/bd5iXFTscf9CPmjnJOPQ3xXGJLRW2NZjI3zt7U6f4GoKUGfb7d1uDEOkvyXC88AvzbcYLSJJ1Az20G78vn0exyvj/zxGqhUQtgTsj0c9dMdZ903sARZKQWpK8Nn4FV84W5BbEIAUG63mElKMFfbSlPs/XJtaPgFY6f9Oxk9GJWUBMCyLQpw5aAFAynV8QRExalv2CvuNdrQbrkDWqprqF4TTuyfqmxzwcl8+pJhZyGdH5q7JMkMvaeu/c08smrOIxgKiNFisdpYMlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M04F2C9o4js6J6QnEpHb0CRH9AxEa5A/7C0KTQZ2v94=;
 b=TUyAIH7FkktI+TMETVOVnLsuSDYoLvX9TNUEcmoRokN5MWMJTRJC/MkVT3ADWPNemOqztakyp0VGkJ7tlNJpsfdhGNKyot4yw8WfjRlNkFe2fwQ444pe5a187A/uUQnm/2A6oEyHk9HhRfiNMz5iTj0XjSdMPypkYYsW0FHA//U=
Received: from BY5PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:1e0::33)
 by BN7PR03MB3601.namprd03.prod.outlook.com (2603:10b6:406:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.22; Fri, 15 Nov
 2019 13:57:00 +0000
Received: from SN1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by BY5PR03CA0023.outlook.office365.com
 (2603:10b6:a03:1e0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2451.23 via Frontend
 Transport; Fri, 15 Nov 2019 13:57:00 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT050.mail.protection.outlook.com (10.152.72.128) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2451.23
 via Frontend Transport; Fri, 15 Nov 2019 13:56:59 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xAFDuoAP003082
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 15 Nov 2019 05:56:50 -0800
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.231) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 15 Nov 2019 08:56:58 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>, <robh+dt@kernel.org>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v5 3/4] dt-binding: iio: Add documentation for AD7091R5
Date:   Fri, 15 Nov 2019 15:57:22 +0200
Message-ID: <20191115135723.12219-3-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115135723.12219-1-beniamin.bia@analog.com>
References: <20191115135723.12219-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(6306002)(48376002)(478600001)(7696005)(44832011)(76176011)(1076003)(50466002)(11346002)(446003)(2616005)(186003)(5660300002)(356004)(126002)(426003)(51416003)(7636002)(26005)(336012)(2906002)(86362001)(6666004)(36756003)(106002)(486006)(476003)(7416002)(54906003)(305945005)(4326008)(2351001)(16586007)(316002)(966005)(70206006)(6916009)(47776003)(107886003)(70586007)(50226002)(246002)(8676002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB3601;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8d290b1-4547-466e-1991-08d769d3af62
X-MS-TrafficTypeDiagnostic: BN7PR03MB3601:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <BN7PR03MB36018701F78C668869F09D68F0700@BN7PR03MB3601.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 02229A4115
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Oxlytygu9aBVhKRW52HW2CVzJXiRPXttU+EMJxYzi9enEv5g2xhedjLbtYZP+F9eaC6mEQgf1gk6tTPOlK7/0mbzvQNRgkQberrLirbIXCR5A9okXlVGtJwTtkKw0d99wpqBzliPY4yAQC0fEMR0rNfjstvohFlQmp8yKVIfgNuyidlF6FYH44MZbr5NAn8E/zSViOf/WCB6iaH3HxgqR4688R+Ncc2aMyUruqQXdxfXSiSmgQqHjJP+McnyV+nPm+zcSFcoczbJSMkeHyTvDGU7V66DuIQBAIDB3t/MPht68JH5wozUBjk7QEsT9ItOjhYds2Uqcqdw5qAlbbScGT/uPZTHmG6538mL4eeAVijuEnVHxuCJU8KSvbG6r/QLyRIZKPtSbYsGsXp9QmDcSgXxwNzyIqnsbekVUEGnfsRM6Ls07BRHE9k8D6qDTDgkozBE7ECFu1XY4WuaOhTqCV/48YGTGX9+8vGUO2SZco=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 13:56:59.6451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d290b1-4547-466e-1991-08d769d3af62
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3601
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_04:2019-11-15,2019-11-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911150126
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Documentation for AD7091R5 ADC was added.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v5:
-nothing changed

 .../bindings/iio/adc/adi,ad7091r5.yaml        | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
new file mode 100644
index 000000000000..31ffa275f5fa
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
+  vref-supply:
+    description:
+      Phandle to the vref power supply
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

