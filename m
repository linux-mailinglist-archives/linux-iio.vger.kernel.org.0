Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3F313934B
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 15:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgAMOPH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 09:15:07 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:56182 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726505AbgAMOPH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 09:15:07 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00DECEl8012077;
        Mon, 13 Jan 2020 09:14:33 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xfc59c2uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jan 2020 09:14:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuWIqbkokjW+nY8hwsw+jZ0pjE4xmwGfHVK29rWNRF50KUWPcOxrt+IAXgeeOdlG/VT1/jhkF2b2hz3tHawtN/szktW4IiZpMsFUZAfm7VcteQaboP2TQ3I6kuvesEqdlD4woDRDJct8XutwmD4V9YvQcPadVNDY6uAT+3R8H0vbgBpQKzYHhyfvLdX0S99LWIA1ly626pR1Rn9NGWe8r526IkFmk3y+azghiO8JDXK5EUfNBcFTRWQUgolW1VMXDxPfq5P5bWa/QvWJzIPIrwzAzVZW5h5W7w0Ig59W7F2VxAKPCVaXGFbdTWksdsgOcGrCU5qoIir+cdMsJBYKGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTw8pehxp7tR3nxLWiFLwGZx25XKeVRY8fh+7C3YwMM=;
 b=O1voGENXjCM46kiQtndUmLcwZ6NEKOL6i5akmB/rqUiCI4EoENHL3s3EDtNCbrIFWufptLYGeuwqCZu9RugDqK+5WiJCMPm21qSSMql7g1TBDrb9wHmKGQ+1YzISZEtJo9Civlnl2p2msn/cipne8tIKW6nnA5qYuYysk+PBCMTvjBWvBkh4iWUv/Yh1zX3l5eYSZnSmLZcK5wN/jfiCPAxsq9/lbNXC6BPbBUFnPaclKUmOf/qeGgH1MEwJ1WpeNDF6+oCXgNBDGuN27m/DKKULQp6BfaCn/P/IgIHGs5NoP4uom0JSvP0kfLr3nZEflHyslVzTJBCk/ltgmztPLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTw8pehxp7tR3nxLWiFLwGZx25XKeVRY8fh+7C3YwMM=;
 b=7FNNuTrOVsH7D3RVNw3ERkTW6G0nHI5NVO9U3ErG1RO3frZQMMqQzq7BpWBFpxx85UKdQpCfwHnkhk/wnIjCYcnaVzkBJG048ZTJPROG/YbVl6zGLyMD9ttKfJJKCrPYJwNWofDHziW+dv/72iDeIoKBrR4L/dSxynAYWwwVedQ=
Received: from DM6PR03CA0024.namprd03.prod.outlook.com (2603:10b6:5:40::37) by
 BYAPR03MB3509.namprd03.prod.outlook.com (2603:10b6:a02:aa::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8; Mon, 13 Jan 2020 14:14:31 +0000
Received: from CY1NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by DM6PR03CA0024.outlook.office365.com
 (2603:10b6:5:40::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13 via Frontend
 Transport; Mon, 13 Jan 2020 14:14:31 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT047.mail.protection.outlook.com (10.152.74.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2623.9
 via Frontend Transport; Mon, 13 Jan 2020 14:14:31 +0000
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id 00DEEIKC011481
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 13 Jan 2020 06:14:18 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 13 Jan
 2020 09:14:29 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 13 Jan 2020 06:14:28 -0800
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00DEECCV005491;
        Mon, 13 Jan 2020 09:14:20 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 2/3] dt-bindings: iio: amplifiers: Add docs for HMC425A Step Attenuator
Date:   Mon, 13 Jan 2020 16:15:54 +0200
Message-ID: <20200113141555.16117-2-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200113141555.16117-1-beniamin.bia@analog.com>
References: <20200113141555.16117-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(346002)(189003)(199004)(86362001)(26005)(2616005)(7696005)(6916009)(426003)(8936002)(316002)(2906002)(336012)(186003)(246002)(36756003)(54906003)(8676002)(356004)(6666004)(44832011)(478600001)(966005)(70206006)(107886003)(5660300002)(7636002)(7416002)(1076003)(4326008)(70586007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3509;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5b4ec9d-3cb9-4513-99a1-08d79832e870
X-MS-TrafficTypeDiagnostic: BYAPR03MB3509:
X-Microsoft-Antispam-PRVS: <BYAPR03MB3509D4C275984B1A3D1D1B45F0350@BYAPR03MB3509.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 028166BF91
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8WdaNba9C5bT5dQ7CYdJbiFVSw3TIZV0sUlOVTIkox8j399M62WxwJc0vXosdjy3xlWMUQu7Hlg8JITV2H8OF9Xv5mZDWkW+jvmJYRk8i5XqznFGH4ny5a/gEM+A9K6F1AJHQ3v2C+lzlogoNsKO9hN64Q6Rx6hIL2Qj9G6VZPxvP7xL0OwkHQZd/ik1o3OMyvRYb240p/92IiENj4mSp4rXM0WVcOILXs42MIdBmLBtbhhUl5RopjYAzfScEkLtfLREgjJY6aEhTuViNmVFHiJ0eSNN1oHvLxXweAfQ38Og8wkwLvR2rWpSIshCj3O9XjipfFPlTdW1RNYwTJr4Mkrwx1bNudo4w7wfsVtrIRHh+eJ80jiJjFdXYvpPGXLoNQXG6JDoZwN1Bmidg34OD9z0q8fyZL6ZHG19g73enwmK7nqSGwZ46+q90fIO7M/zRUlJ4C4NyomhFKpm1FntSf4TpNfZcL6n4jggRlN2EA8=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 14:14:31.0273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b4ec9d-3cb9-4513-99a1-08d79832e870
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3509
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_04:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001130117
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Document support for Analog Devices MC425A Step Attenuator.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 .../bindings/iio/amplifiers/adi,hmc425a.yaml  | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
new file mode 100644
index 000000000000..6f4a292395e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/amplifiers/adi,hmc425a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HMC425A 6-bit Digital Step Attenuator
+
+maintainers:
+- Michael Hennerich <michael.hennerich@analog.com>
+
+description: |
+  Digital Step Attenuator IIO device with gpio interface.
+  HMC425A 0.5 dB LSB GaAs MMIC 6-BIT DIGITAL POSITIVE CONTROL ATTENUATOR, 2.2 - 8.0 GHz
+  https://www.analog.com/media/en/technical-documentation/data-sheets/hmc425A.pdf
+
+properties:
+compatible:
+    enum:
+    - adi,hmc425a
+
+vcc-supply:
+    description:
+    digital voltage regulator (see regulator/regulator.txt)
+    maxItems: 1
+
+ctrl-gpios:
+    description:
+    Must contain an array of 6 GPIO specifiers, referring to the GPIO pins
+    connected to the control pins V1-V6.
+    maxItems: 6
+
+required:
+- compatible
+- ctrl-gpios
+
+examples:
+- |
+    #include <dt-bindings/gpio/gpio.h>
+
+    &gpio {
+    #address-cells = <1>;
+    #size-cells = <0>;
+      gpio_hmc425a: hmc425a {
+        compatible = "adi,hmc425a";
+        ctrl-gpios = <&gpio 40 GPIO_ACTIVE_HIGH>,
+          <&gpio 39 GPIO_ACTIVE_HIGH>,
+          <&gpio 38 GPIO_ACTIVE_HIGH>,
+          <&gpio 37 GPIO_ACTIVE_HIGH>,
+          <&gpio 36 GPIO_ACTIVE_HIGH>,
+          <&gpio 35 GPIO_ACTIVE_HIGH>;
+
+        vcc-supply = <&foo>;
+      };
+    }
-- 
2.17.1

