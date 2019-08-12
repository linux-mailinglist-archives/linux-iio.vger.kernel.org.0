Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59E698994D
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2019 11:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfHLJEU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Aug 2019 05:04:20 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:17530 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727434AbfHLJEU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Aug 2019 05:04:20 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7C92vhP010561;
        Mon, 12 Aug 2019 05:03:58 -0400
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2059.outbound.protection.outlook.com [104.47.40.59])
        by mx0a-00128a01.pphosted.com with ESMTP id 2u9qs7vuy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 05:03:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZ3jBF/SeH+ooSWsepvxbCNhOR3wgCIu2/Mg0ca/GqEJsb2xTUleKN0creI3WHATCuWCqwthaluQVl5MD0/zd20mZADcsSYTPN0l8wTrFwBK6WHPoqD0gvKzMsG+ce0Ar1w4m/gDxPBeJedjCfGHYR98hIHuFa4pL7/g/TnC36JQwz9iHoy+H/LO15Bmc58cGsIwGqZpVZAC1S+xRM0X1XNZdxBW6pxVVpPoXjHAGkGjCe8OPih1o8wNJUM8hT6s3z57BbJ5jn9plB4XfVhtaypYIutkv29+viJLbmQRetbp1NIepgSk/8gfYd7PpkMEcGc8gcwji8YdaVz6Y+r98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epHtDMWOJzGG65aGZ+LxWcP6wIzMkYggPWlv2yljkvY=;
 b=CJu0EGo8e2yvtYjMsNHlcHXXYeArVaVi36W5f46f6Oh5yBdyNfMwWLQV+6VIUlDMdDPzUMfdd0u9WKkAETYjyi5TBsFW1j0NqYJ8xHTKPkICuUJqVjJ1na4MtVT5IBJYO1Osc8GRwyGarGgK0ywZLT2ICUXRPS3RsbS9bp0MQxd0fD5y11QUgBuWKZga1p1FudQsR89LT4jouQeDDk2+ykc2nkbuIbwI3m0dwFhPl6SrKDAydeFoNirszpTdYZkKKHlUhYGJkOUpAsX4CygFJExK2gIujn1clvAZMZYIaoMItTqRWYam2nPD7lcsxL7xp2QXPmxJTCGo6tiJVIPJEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epHtDMWOJzGG65aGZ+LxWcP6wIzMkYggPWlv2yljkvY=;
 b=Bt6/evatCVDSToLbjpzTbLwgdbSn35q96b+c0n16GC4be9ebQEamhKcsrQ6WH6jSaX4qMAxsfZGeatLx1iH4qbQRG5yoOg++4E6RMOM0o1xCBVj5E9eiBj3C9ze2JARRY543zNXApgKHZ3thYIm6934SBbAuUljcmEXeSStfqHk=
Received: from BN6PR03CA0075.namprd03.prod.outlook.com (2603:10b6:405:6f::13)
 by CY4PR03MB3224.namprd03.prod.outlook.com (2603:10b6:910:51::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.16; Mon, 12 Aug
 2019 09:03:56 +0000
Received: from CY1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by BN6PR03CA0075.outlook.office365.com
 (2603:10b6:405:6f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.18 via Frontend
 Transport; Mon, 12 Aug 2019 09:03:55 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT063.mail.protection.outlook.com (10.152.75.161) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2157.15
 via Frontend Transport; Mon, 12 Aug 2019 09:03:53 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x7C93rHb009066
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 12 Aug 2019 02:03:53 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 12 Aug 2019 05:03:52 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH 4/4] dt-bindings: iio: adc: ad7192: Add binding documentation for AD7192
Date:   Mon, 12 Aug 2019 12:03:41 +0300
Message-ID: <20190812090341.27183-4-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190812090341.27183-1-mircea.caprioru@analog.com>
References: <20190812090341.27183-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(39860400002)(2970300002)(189003)(199004)(316002)(336012)(11346002)(54906003)(446003)(2616005)(476003)(126002)(486006)(47776003)(426003)(44832011)(76176011)(26005)(2870700001)(2906002)(7696005)(14444005)(2351001)(6916009)(6666004)(186003)(106002)(356004)(5660300002)(70206006)(1076003)(86362001)(70586007)(50466002)(36756003)(305945005)(50226002)(966005)(8936002)(8676002)(6306002)(478600001)(7636002)(246002)(107886003)(53376002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3224;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:3;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d48206e3-57a1-4441-6da4-08d71f04006b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:CY4PR03MB3224;
X-MS-TrafficTypeDiagnostic: CY4PR03MB3224:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <CY4PR03MB3224FF5A104178FF69CDE68581D30@CY4PR03MB3224.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 012792EC17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: +JnEVWgfKOO0zsdHn11+dchXHOoV73CV0l5x3fArvdsRXXjq9d/zVaHb3th+b7+JJr7T8oJia3YYceB2F6SGpiuAz62eS+jB7v3yDJSoimSXgYG0tv7QpIFk0e2kN2oICSTiBpSafqF2maMI4FbJzftrvylAHDvgKf9GGuq9Zh1deLfLhZHjExR/btpvKmhwaAi+tc6/3wh0hk1d0O6MNnIRzzGbumju997cS/PvZJ1p7ES2W5JyXJCzOGK4nqBaXOUi+aAfSSHurI4uBEaTXb69NPWa+5wavzCBlQPglxORt9SIGAaahWKkvZFoysmB9y7RZ/0nImVC4p1iPFuxQxNXkRe5Y3A59EHidbSNd/oYMx4r9ivY1jIN88F3cmxMUIdsrauUo9dxAP/iSyMIYJeimh1uR559fjwZYGFFj5w=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2019 09:03:53.8881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d48206e3-57a1-4441-6da4-08d71f04006b
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3224
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120102
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch add device tree binding documentation for AD7192 adc in YAML
format.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 .../bindings/iio/adc/adi,ad7192.yaml          | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
new file mode 100644
index 000000000000..a56ee391f6a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -0,0 +1,123 @@
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
+    description: SPI chip select number for the device
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
+    description: IRQ line for the ADC
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
+      ad7192@0 {
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

