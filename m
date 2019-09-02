Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46D9EA5755
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2019 15:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbfIBNJ1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Sep 2019 09:09:27 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:10062 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729840AbfIBNJ1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Sep 2019 09:09:27 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x82D95BX014151;
        Mon, 2 Sep 2019 09:09:05 -0400
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2056.outbound.protection.outlook.com [104.47.32.56])
        by mx0b-00128a01.pphosted.com with ESMTP id 2uqjna3e9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Sep 2019 09:09:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlOeYkGw8qGGzxE+m+cxDE6MIZ6bxoB4u2iLioRui7D5hs7eWgqIhpZ0y8HnKPu394og7AcSQUPfJyIvEgF2wxOwFFeBO7/rzJS+Hrp+BdAuQlrDsvZgyjzgQAlvPye3k7MwqKyZb6mlUTK8BVBNEYBTKpEunPyNj5AtCUBbl6T2xf4M5JQH1FBdJsmZiZ7qzdjobe9Ij6tfI0W/3MRYl3y11qgzl7AXsx7nHIBkmxHs5lElIENYFbI+E1I7o+a1wnLc4AmLLkiT7k3ZVlxMqWJIQXBwEg+8Pi12YCeU+dgDd9rMpqYRsDx7Ad2m3aLLomfh6H88jclxjezPlvK1Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pssop/eUyJ4/GGFH8lTOLGrZ1Ix9kuq0rKb3TIW/nrA=;
 b=jNu2zmLKgCfoqk+IH4TTDsxSzAgfL7oSNSwXwfFn0iUZM6CixPJF2I1xyObh0F3nU8PQR2L5186zYJEW3srfS1n7Pn09iPnSarIMIBxFiAoEQ2vsLRRFgo5K2fFtl8IJPD36FOMgGQ0B81nTyHEyUuZkF4A8G+SvxUglGGIK5v47+XskxxaTyV+BkD19pueAjIxnG83FbnJ98008tO6exz6GSPmowNtlsR1/ixciM2SKb7vJe7GClZ3xHuS8BnhNSMw5PT19TEisPAFvk8DJQycMZf7AUOMmNEazIGYGM81ienz0fGFp9RizuIqFkVFKdeAKu1fKYBEs/wudw1wlAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pssop/eUyJ4/GGFH8lTOLGrZ1Ix9kuq0rKb3TIW/nrA=;
 b=wQFrBEcWwM1I25DBylsp2lG5LfkrVyXXvX7dHsFb6R1VYHMMYqcW1ic7PY0kaC0RVH6ZW34XPJoQjUdQYBy3DRCbKiMFBeqqLgranYRmWlBbxbwbC5SliAdwyofTv5KuHs91cqC9KYx81fBN3Jhoex8MaBS0haFn+EyS+XdzJWs=
Received: from BN6PR03CA0115.namprd03.prod.outlook.com (2603:10b6:404:10::29)
 by BN8PR03MB5044.namprd03.prod.outlook.com (2603:10b6:408:d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.20; Mon, 2 Sep
 2019 13:08:46 +0000
Received: from BL2NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by BN6PR03CA0115.outlook.office365.com
 (2603:10b6:404:10::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2220.19 via Frontend
 Transport; Mon, 2 Sep 2019 13:08:45 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT059.mail.protection.outlook.com (10.152.76.247) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2220.16
 via Frontend Transport; Mon, 2 Sep 2019 13:08:45 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x82D8j1j027178
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 2 Sep 2019 06:08:45 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.107) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 2 Sep 2019 09:08:44 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V4 4/4] dt-bindings: iio: adc: ad7192: Add binding documentation for AD7192
Date:   Mon, 2 Sep 2019 16:08:31 +0300
Message-ID: <20190902130831.23057-4-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190902130831.23057-1-mircea.caprioru@analog.com>
References: <20190902130831.23057-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="yes"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(136003)(396003)(346002)(376002)(39860400002)(2980300002)(54534003)(189003)(199004)(50466002)(6666004)(356004)(486006)(126002)(44832011)(476003)(446003)(2616005)(11346002)(5660300002)(86362001)(70206006)(7636002)(70586007)(426003)(54906003)(50226002)(106002)(316002)(47776003)(14444005)(2351001)(8676002)(1076003)(4326008)(8936002)(246002)(2870700001)(36756003)(478600001)(2906002)(6916009)(53376002)(107886003)(26005)(76176011)(7696005)(186003)(336012)(305945005)(966005)(6306002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR03MB5044;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59aaadfc-dc46-4c4a-8ca7-08d72fa6afcc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:BN8PR03MB5044;
X-MS-TrafficTypeDiagnostic: BN8PR03MB5044:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <BN8PR03MB50447DFE3220C870958D1BCB81BE0@BN8PR03MB5044.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 01480965DA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: wbHXN7VHo+uLFWNAIapWoZpQz9ozpaqpmX3hHF0wrWBDR+IZsDX5JKnggIqVER357/KZ4JntZUzmDgTQJ/zBwPu+Hql+zAg7E5gkaE9cHiJoNxGkcdpsbz5NN2vvzcivBqsHG+c+iYrs2PIjI7FEg3iZ8YhcCLtGdLNQlUosMFtS2sgcn+H1Tf63aDOjJGzDJb+x1/seAxZ7WnkF204VvTOVE7m3/YNYtJjAdoRQSm8gUkaVaMNpt4FWAUH2rp3XIqg6VQbsx+Z7g8vefKgUDdeHW+iAv6NQyzC5X2cHAZn1wObMCQxS5jp62lT0DEsUgt1EQkLSibxBqo2a+fIVns4pgSMfGhhVXBbeC1XbtfbgP5OPWijBcjlJromu6G60cuELZuXjR8DOyw2drGwVaAmyJkmXgjuB2z5ekXyvUwA=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2019 13:08:45.5718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59aaadfc-dc46-4c4a-8ca7-08d72fa6afcc
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5044
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-02_05:2019-08-29,2019-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 suspectscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909020148
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch add device tree binding documentation for AD7192 adc in YAML
format.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
Changelog V2:
- no changes here

Changelog V3:
- no changes here

Changelog V4:
- remove the const value from avdd and dvdd supply

 .../bindings/iio/adc/adi,ad7192.yaml          | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
new file mode 100644
index 000000000000..040af0bcc92e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -0,0 +1,119 @@
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
+    maxItems: 1
+
+  avdd-supply:
+    description: AVdd voltage supply
+    maxItems: 1
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

