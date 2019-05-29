Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0C952D740
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2019 10:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfE2IGK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 May 2019 04:06:10 -0400
Received: from mail-eopbgr730060.outbound.protection.outlook.com ([40.107.73.60]:23616
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726099AbfE2IGK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 29 May 2019 04:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42/K7dw3JIVGV/DGSsFqh5tSSJX4aCbdtdxNrjz1qnw=;
 b=bL3G31AfZXMGJ9UfQVokMAQEUIL5vROj+EhwmTLlcH1WRgSQciCHBTRx5tt1gaSz4O+RUN3m1xZ/5ZCyFgeEhq/8BJaqmXeV2PcneWnJCVRu4S36aqOL8X4fwJyvF03Xht6wRW40sYN5/0iEuyFHI2TmhgAre2s4gio2rYxZMP4=
Received: from DM5PR03CA0028.namprd03.prod.outlook.com (2603:10b6:4:3b::17) by
 DM2PR03MB559.namprd03.prod.outlook.com (2a01:111:e400:241d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.18; Wed, 29 May
 2019 08:06:07 +0000
Received: from SN1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by DM5PR03CA0028.outlook.office365.com
 (2603:10b6:4:3b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1943.17 via Frontend
 Transport; Wed, 29 May 2019 08:06:07 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT024.mail.protection.outlook.com (10.152.72.127) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Wed, 29 May 2019 08:06:06 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x4T866i1032140
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 29 May 2019 01:06:06 -0700
Received: from linux.ad.analog.com (10.32.224.122) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 29 May 2019 04:06:05 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <Michael.Hennerich@analog.com>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v4 2/2] dt-bindings: iio: frequency: Add docs for ADF4371 PLL
Date:   Wed, 29 May 2019 11:06:01 +0300
Message-ID: <1559117161-9281-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(346002)(136003)(39860400002)(396003)(376002)(2980300002)(189003)(199004)(316002)(486006)(26005)(966005)(16586007)(8676002)(36756003)(336012)(186003)(72206003)(77096007)(305945005)(70206006)(426003)(70586007)(476003)(246002)(2616005)(126002)(478600001)(8936002)(48376002)(7636002)(50466002)(7416002)(50226002)(2906002)(6306002)(44832011)(53376002)(4326008)(107886003)(106002)(47776003)(7696005)(6666004)(356004)(5660300002)(54906003)(51416003)(110136005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB559;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 087c8afc-033c-42fe-7ac4-08d6e40c80d2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709054)(1401327)(2017052603328);SRVR:DM2PR03MB559;
X-MS-TrafficTypeDiagnostic: DM2PR03MB559:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <DM2PR03MB559A9095984B06741D47E189D1F0@DM2PR03MB559.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0052308DC6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: IYXk9OqFuRyi4oSwalGA+/RWbxTtytphb3qmh0JDIirDoaRGLCnF84TvPKchriqDz2uR/8/ovFQuZaTUh+Jn71GEpjG7cb/DKA4yIjNRAjOs3pnkcqsg43R5wqIHXQe3TvoAcrPHqilwwZYqz5Yo8pwjF4TX2RwsSvSIWDfgkLm1vRW0G0JSK7Aqtqepo0Sl77esoUQ5VQxLUjYVvY6+mmU15SfO3zpa8hLkPmuNZodWnK8zBH/NYHPYmcujakvUbZAWQjrJQDgLci7Z5LWn8IbskFsOPPYl+Ap2GBOzP5GKOlR0yUO4y5y8e9m4C01MC7iZ07nKo/DBBh15WZbJkkJ7snVqNY4FfsK7aG6fqlLXttsJaAt2bCzyBuZB7MOsURdgpPEi3RubNNmGvKXrEqozzU2Ct2jdNfH3UjyfwCM=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2019 08:06:06.7308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 087c8afc-033c-42fe-7ac4-08d6e40c80d2
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB559
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document support for Analog Devices ADF4371 SPI Wideband Synthesizer.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
	- Nothing changed.
Changes in v3:
	- Nothing changed.
Changes in v4:
	- Nothing changed.

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

