Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5446F8B1B1
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2019 09:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfHMH40 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Aug 2019 03:56:26 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:42532 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728148AbfHMH40 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Aug 2019 03:56:26 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7D7rA3D002716;
        Tue, 13 Aug 2019 03:56:04 -0400
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2055.outbound.protection.outlook.com [104.47.34.55])
        by mx0b-00128a01.pphosted.com with ESMTP id 2u9tj5yf1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Aug 2019 03:56:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6vSKblX1EBwDjRCT7zpS+yEoc99vnRxmBMnnM/jcixrINjvvLIHJsCj8OgU/L6529dfuvZL1ztn+meKNHMapy1bJtYTXrCwUle1T+oZaDcOPVjiG/5xgOQUphgCCstxfQkje/WYf3HeHm4laZn+gBbYoKoGMRR/VycGVqGcR+gwIF9hxLjKgup+YhTraNDgsnFjRWpSSiszkzuPun0qXTgXR9cH2ZaP11ePp8Flq/zjqxZMUcj+iddUurOJ5xUZizNWoFpxfzMjlJp21c8YBsJkoQ3n4M69FKs/W3zs6UpjIwGPnvplhBIvc273hrO7KPb7cfNP3NsaeHektT9uCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdUcbEctnGRNnbXHAEvNVl2dAN2sBryjoNT7rxEyHP4=;
 b=gLIuGnQXCoNtc1EIzTCo1YLV9+FecrIuewDqE7qzoGGyQMjFRC98/uIOCZ6Xbtms/o5Si4LWDQBlgFtxjcxYiLomdJ2KJWq6AOSyt8rHKc2jrv5LhsS3zh2EHkt+mZ/ehxx/+SPjAYvxidTKxmGQ6+5g0wLQC2B583iDgJKk8hqRKYcYnccQYNSMHTsKVGCdSHlwc5CgY+69jle6JuIVQzdNdE0Z2tS2RNxNIVIa1EBWHb94G+y5ev7BMp3aK75nbq0GtIGXr/5/Q8hUbUiLbevZKJeROZbq5+yqRuPx1GOoegFkbsUCNRP53/6moykSq34wSd63idTPLvf5ZCDnzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdUcbEctnGRNnbXHAEvNVl2dAN2sBryjoNT7rxEyHP4=;
 b=KgW7Nl8E8YIQiJilxrKvfzANz3DKML7JztAr/zRevNZI0s4CydVfgXNjYSxfgP9D2vrRZueBE6b0zsC38CcwSUt2yYl5+81rpvH+o+58A7eDiSad7Leza+krVHRjUFg/pzePuIssdGWJjZWT8GkoPLGFVdfw3vpeZwHPRB+OeNY=
Received: from MWHPR03CA0036.namprd03.prod.outlook.com (2603:10b6:301:3b::25)
 by MN2PR03MB4991.namprd03.prod.outlook.com (2603:10b6:208:1a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.16; Tue, 13 Aug
 2019 07:55:57 +0000
Received: from BL2NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by MWHPR03CA0036.outlook.office365.com
 (2603:10b6:301:3b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.14 via Frontend
 Transport; Tue, 13 Aug 2019 07:55:57 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT056.mail.protection.outlook.com (10.152.77.221) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2157.15
 via Frontend Transport; Tue, 13 Aug 2019 07:55:56 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x7D7trfB016034
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 13 Aug 2019 00:55:53 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 13 Aug 2019 03:55:55 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V2 4/4] dt-bindings: iio: adc: ad7192: Add binding documentation for AD7192
Date:   Tue, 13 Aug 2019 10:55:44 +0300
Message-ID: <20190813075544.9122-4-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813075544.9122-1-mircea.caprioru@analog.com>
References: <20190813075544.9122-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39860400002)(346002)(2980300002)(199004)(189003)(54534003)(426003)(356004)(5660300002)(14444005)(446003)(2870700001)(966005)(4326008)(336012)(6666004)(6916009)(126002)(44832011)(70206006)(50226002)(2351001)(11346002)(50466002)(476003)(486006)(70586007)(7636002)(106002)(316002)(2616005)(36756003)(305945005)(76176011)(1076003)(186003)(7696005)(54906003)(478600001)(8676002)(6306002)(246002)(47776003)(53376002)(26005)(8936002)(107886003)(2906002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB4991;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0523457-746d-431c-c7fd-08d71fc3ac73
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:MN2PR03MB4991;
X-MS-TrafficTypeDiagnostic: MN2PR03MB4991:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <MN2PR03MB49910F7CE2114AD31BF7506E81D20@MN2PR03MB4991.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 01283822F8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: WSP8mz1nClVfKRToZ7FAyr2ozhN4QWqDbv6EV3J/SHRs08I5fYv/WmcZ00Q/79sY42EdVJOisvGOObZOSdNyGgaEDhwf2H/xRaAMDp5kuqMmCMtH8OEh0lcTwoRNV+kaq/bPn5yDHm9LeLzd8Iq/psnCJ/7vp2j2LQAKVHV1Yg0M2jUkF8zLHhAvjLF80W6RYbs7Zsg9Peogn8m+0ClC4Bx2BH8mXKJtwvGeqRKHepVjP7S0l8l+KzrE3xeXSQeUYLYENvH6ZdDlXfKBDYRezfMjJd1Plc1Y1bMO0N0Inz/Y/SyX6V+QUyPIQPyRdcgU916LDZnvsCZureMh8BnlSMhKZZuVAwy1K5WNXCulxdbeTrT7VCrTyDXz31tJvQMH/Xx5OfMdddZhZSiqXHUmilkBNVQnu7sGvhiaSm91+aA=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2019 07:55:56.7546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0523457-746d-431c-c7fd-08d71fc3ac73
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4991
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-13_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908130087
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch add device tree binding documentation for AD7192 adc in YAML
format.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
Changelog V2:
- remove description from spi and interrupt properties
- changed the name of the device from ad7192 to adc in the example

 .../bindings/iio/adc/adi,ad7192.yaml          | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
new file mode 100644
index 000000000000..2d83724cb4d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/iio/adc/adi,ad7192.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7192 ADC device driver
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+
+description: |
+  Bindings for the Analog Devices AD7192 ADC device. Datasheet can be
+  found here:
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7192.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7190
+      - adi,ad7192
+      - adi,ad7193
+      - adi,ad7195
+
+  reg:
+    maxItems: 1
+
+  spi-cpol: true
+
+  spi-cpha: true
+
+  clocks:
+    maxItems: 1
+    description: phandle to the master clock (mclk)
+
+  clock-names:
+    items:
+      - const: mclk
+
+  interrupts:
+    maxItems: 1
+
+  dvdd-supply:
+    description: DVdd voltage supply
+    items:
+      - const: dvdd
+
+  avdd-supply:
+    description: AVdd voltage supply
+    items:
+      - const: avdd
+
+  adi,rejection-60-Hz-enable:
+    description: |
+      This bit enables a notch at 60 Hz when the first notch of the sinc
+      filter is at 50 Hz. When REJ60 is set, a filter notch is placed at
+      60 Hz when the sinc filter first notch is at 50 Hz. This allows
+      simultaneous 50 Hz/ 60 Hz rejection.
+    type: boolean
+
+  adi,refin2-pins-enable:
+    description: |
+      External reference applied between the P1/REFIN2(+) and P0/REFIN2(−) pins.
+    type: boolean
+
+  adi,buffer-enable:
+    description: |
+      Enables the buffer on the analog inputs. If cleared, the analog inputs
+      are unbuffered, lowering the power consumption of the device. If this
+      bit is set, the analog inputs are buffered, allowing the user to place
+      source impedances on the front end without contributing gain errors to
+      the system.
+    type: boolean
+
+  adi,burnout-currents-enable:
+    description: |
+      When this bit is set to 1, the 500 nA current sources in the signal
+      path are enabled. When BURN = 0, the burnout currents are disabled.
+      The burnout currents can be enabled only when the buffer is active
+      and when chop is disabled.
+    type: boolean
+
+  bipolar:
+    description: see Documentation/devicetree/bindings/iio/adc/adc.txt
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - dvdd-supply
+  - avdd-supply
+  - spi-cpol
+  - spi-cpha
+
+examples:
+  - |
+    spi0 {
+      adc@0 {
+        compatible = "adi,ad7192";
+        reg = <0>;
+        spi-max-frequency = <1000000>;
+        spi-cpol;
+        spi-cpha;
+        clocks = <&ad7192_mclk>;
+        clock-names = "mclk";
+        #interrupt-cells = <2>;
+        interrupts = <25 0x2>;
+        interrupt-parent = <&gpio>;
+        dvdd-supply = <&dvdd>;
+        avdd-supply = <&avdd>;
+
+        adi,refin2-pins-enable;
+        adi,rejection-60-Hz-enable;
+        adi,buffer-enable;
+        adi,burnout-currents-enable;
+        };
+    }
-- 
2.17.1

