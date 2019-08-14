Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8C6C8CCE3
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2019 09:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfHNHco (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Aug 2019 03:32:44 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:21192 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726880AbfHNHck (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Aug 2019 03:32:40 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7E7S3vO002516;
        Wed, 14 Aug 2019 03:32:17 -0400
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2054.outbound.protection.outlook.com [104.47.34.54])
        by mx0a-00128a01.pphosted.com with ESMTP id 2uc0whhuyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 14 Aug 2019 03:32:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pwy/Vq8/7N/uVTDKAoHKEOBNQcyTfBoeXwGFf7agRNAwoKWBnC+In9wdbMT4i08AgJ/gRvsgWxCEKdjtENGNvuhFPR8yZTZyvG3JaNu2NTgPvevFvcO5+0Vd/VujVQsfLY8saIKA9ixVisD7ayzIIFNYT0hgpHlU6V0zOwzbYoOcMbgcVwtly5s1M06T4efkoPMI8+MK/5IGg+on1+DKtFLnufucAfNPDvkRIW1hc/E4PfLukYczKxmECU9E9OyYC7loqWqRyIN3wXFmrcmzkJbvXwNDzSmPWklkCNuJTUqFuYa18lGLuvFq+aQK6Qgzt732sUbHsRPfJ7SEk9OZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjJRsyTLVcWD1ysn5uSWFQ4C4iknXPZ5EFfS4PtX2xA=;
 b=lJOp7LRvPckfAfL9LA7lNSy66GaC6OPiOymvTMENsMd3iyISMnS4pglZpB64/qDCCPzAo+0Yt9D9y/ZXX8/4SjLWeKl4GzdkN298kTbETJXwSt5FodZ0CjkHOrtbvDkwiLG44WwYgPA9X7ovmdVVjqyboaTjdnX5n9G/SLiGd574sKK6exSxf1zPQalsn9AxtuOH0GLD/KZlYmOJS4Le83FxYwS1IsHPQVIRFXaZlHFqVq1j5ndrpBTar7T1w/xavCbjf6V0bDO2+3qYc1Yl4HlJESV/sZ5har3LaUu1LdDJLrOEsKJ9i4SduohJmc1Llo7oJ8C9DtGYNsbULLKrDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjJRsyTLVcWD1ysn5uSWFQ4C4iknXPZ5EFfS4PtX2xA=;
 b=RvdSP4HIiQmCpLUvqp7kfClrLTBpllizOw3efFVsnBmPDGp32esYqwPPnNL/tmUqfZDGH1whvbHbS6zsujy+50wdq9vwCcOhJ5H4AT2Kxbe0b501uk9BB/W96AWjF6aTXpRreZiLnsqel4N0ND97B6HbLS6X5UZ7cD7KVFcCAXo=
Received: from DM6PR03CA0039.namprd03.prod.outlook.com (2603:10b6:5:100::16)
 by CY4PR03MB2422.namprd03.prod.outlook.com (2603:10b6:903:42::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.13; Wed, 14 Aug
 2019 07:32:15 +0000
Received: from SN1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by DM6PR03CA0039.outlook.office365.com
 (2603:10b6:5:100::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.14 via Frontend
 Transport; Wed, 14 Aug 2019 07:32:15 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT019.mail.protection.outlook.com (10.152.72.130) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2178.16
 via Frontend Transport; Wed, 14 Aug 2019 07:32:14 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x7E7WEaQ020983
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 14 Aug 2019 00:32:14 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 14 Aug 2019 03:32:13 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V3 4/4] dt-bindings: iio: adc: ad7192: Add binding documentation for AD7192
Date:   Wed, 14 Aug 2019 10:31:50 +0300
Message-ID: <20190814073150.4602-4-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814073150.4602-1-mircea.caprioru@analog.com>
References: <20190814073150.4602-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(39860400002)(376002)(2980300002)(199004)(189003)(54534003)(107886003)(44832011)(246002)(426003)(316002)(54906003)(6666004)(305945005)(4326008)(106002)(6916009)(2351001)(1076003)(5660300002)(53376002)(86362001)(7636002)(356004)(2616005)(186003)(7696005)(446003)(76176011)(8676002)(14444005)(47776003)(336012)(70586007)(26005)(6306002)(50466002)(11346002)(476003)(126002)(966005)(486006)(2906002)(8936002)(478600001)(36756003)(50226002)(70206006)(2870700001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2422;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c5ff6b8-673f-43a1-af3f-08d72089877b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:CY4PR03MB2422;
X-MS-TrafficTypeDiagnostic: CY4PR03MB2422:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <CY4PR03MB2422532B14B9A0E10393EB9981AD0@CY4PR03MB2422.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 01294F875B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: MxtR19j4530kbFzhPbSaD8yEg7pYifvjNs9Ck17Nns346AhyF8a9sV7MZfwMMm6E1cyOgRgAqwWGZh1U0AnBrFRoZLewFnU5J7MHR7kzfCkwK48pnJm3u87qI76lW2YuDRPY83apWn/X5ihvIZBczcV750wJXdgX4MBKN6TQt3hG+mz3OmS3Szb5gDsL6VnN+zxuCA7wXCzriNeOmZav3snJwpb6e6gF7REX+OPcOa7qnS74Pyp3qESC/7CEQH4xHBIGaKthpmRz2gSFPjm/Y3ziBLJD54X3bJo6MajMKXSaOVe7C0IFZDpd67rmG9p07bcdoCCMfF2r7onlcapmRlgQlLCr1WDu/skKKXYPdmQlQskQqx2HTEIxWSJls4/hKtGldOnVaU2qlDdDVEpmKn6Rcfm4dOZMIp7MyfYAhWk=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2019 07:32:14.8119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5ff6b8-673f-43a1-af3f-08d72089877b
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2422
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-14_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908140072
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

Changelog V3:
- added semicolon at the end of the dt example

 .../bindings/iio/adc/adi,ad7192.yaml          | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
new file mode 100644
index 000000000000..676ec42e1438
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
+    };
-- 
2.17.1

