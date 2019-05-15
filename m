Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A36621F40C
	for <lists+linux-iio@lfdr.de>; Wed, 15 May 2019 14:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfEOMS6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 May 2019 08:18:58 -0400
Received: from mail-eopbgr820055.outbound.protection.outlook.com ([40.107.82.55]:23472
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727561AbfEOLA6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 15 May 2019 07:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tFl3U+VPCLjhy3mqEjsrRLfgkn9WmSgkmkQvgrNZS4=;
 b=tN//8xvmLhOFFGLuPqxVBOvijT5C/T0lxkjkgRabqbcaIrIF4GOlhM0smbGnzaB9YUEYjWebheNmNw0pEJ5QXrtOARxLefq/dgJnW71nJvxeWk0FUwuIrHWTMDlrgup8gOmaTzc9NLr5ebtjmZAA6WGCNm4ICzZayOGCyWwzfv0=
Received: from DM5PR03CA0038.namprd03.prod.outlook.com (2603:10b6:4:3b::27) by
 CY1PR03MB2268.namprd03.prod.outlook.com (2a01:111:e400:c614::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1900.16; Wed, 15 May
 2019 11:00:54 +0000
Received: from CY1NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by DM5PR03CA0038.outlook.office365.com
 (2603:10b6:4:3b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.16 via Frontend
 Transport; Wed, 15 May 2019 11:00:54 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT030.mail.protection.outlook.com (10.152.75.163) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1856.11
 via Frontend Transport; Wed, 15 May 2019 11:00:53 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x4FB0qYX019576
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 15 May 2019 04:00:52 -0700
Received: from linux.ad.analog.com (10.32.224.122) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 15 May 2019 07:00:52 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <Michael.Hennerich@analog.com>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 2/2] dt-bindings: iio: frequency: Add docs for ADF4371 PLL
Date:   Wed, 15 May 2019 14:00:43 +0300
Message-ID: <1557918043-25733-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(136003)(2980300002)(199004)(189003)(316002)(53376002)(70206006)(4326008)(70586007)(110136005)(44832011)(107886003)(7416002)(7636002)(2906002)(47776003)(478600001)(16586007)(186003)(26005)(305945005)(77096007)(48376002)(426003)(966005)(336012)(476003)(2616005)(36756003)(126002)(5660300002)(486006)(106002)(6666004)(7696005)(356004)(50466002)(6306002)(50226002)(54906003)(72206003)(51416003)(8936002)(8676002)(246002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR03MB2268;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19fb89fd-5de2-4487-9461-08d6d92499a2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:CY1PR03MB2268;
X-MS-TrafficTypeDiagnostic: CY1PR03MB2268:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <CY1PR03MB2268E65149BCCBE2D6CD18B49D090@CY1PR03MB2268.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0038DE95A2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Ej4uRLsvDIM7cAFPY5yG2YKg4Ar4N+w5qNKA7eZ8guLsn+N2Vgt5QM5TcRS/YVe4kfrmL4Y9CDIM8y3Z2Nxea9ZEvTNYe8wO4H6oG6WZPyW0rfmWw+enJ45y9HwWAj90rO619aD0m97VqCJKQ5dEaSdGEpdc3OKStlpv6DxASDB6Llj/xt/atasfuD0QiwCP/RP9Zq1O9yjQRGZH1216lAc8DuXxzGdI19NPaBDVj4EblDnyo3jI/6cy32zjaaxkqgWX8UHRPok4rfpelAjt1XyPqcthGX15vDymehrN4cF8aSYKnUz39Ma45Tl+Qv8mjOnBf74Y3EoPG1o3IDqPdB2RLBLo1fgen0D8LOhllaHSaEH7qztow3FVyNGIlfUpI4B30P4PF1MSit3UKnPRn1vc66dJccGMJDOky9Nas3M=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2019 11:00:53.2667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fb89fd-5de2-4487-9461-08d6d92499a2
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2268
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document support for Analog Devices ADF4371 SPI Wideband Synthesizer.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 .../devicetree/bindings/iio/frequency/adf4371.yaml | 54 ++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adf4371.yaml

diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
new file mode 100644
index 0000000..d7adf074
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/frequency/adf4371.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADF4371 Wideband Synthesizer
+
+maintainers:
+  - Popa Stefan <stefan.popa@analog.com>
+
+description: |
+  Analog Devices ADF4371 SPI Wideband Synthesizer
+  https://www.analog.com/media/en/technical-documentation/data-sheets/adf4371.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,adf4371
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description:
+      Definition of the external clock (see clock/clock-bindings.txt)
+    maxItems: 1
+
+  clock-names:
+    description:
+      Must be "clkin"
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        frequency@0 {
+                compatible = "adi,adf4371";
+                reg = <0>;
+                spi-max-frequency = <1000000>;
+                clocks = <&adf4371_clkin>;
+                clock-names = "clkin";
+        };
+    };
+...
-- 
2.7.4

