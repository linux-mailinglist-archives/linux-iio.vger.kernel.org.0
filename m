Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 099516BBE7
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2019 13:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732571AbfGQLvt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Jul 2019 07:51:49 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:42866 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732069AbfGQLvs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jul 2019 07:51:48 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6HBmSrN024429;
        Wed, 17 Jul 2019 07:51:43 -0400
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2053.outbound.protection.outlook.com [104.47.48.53])
        by mx0b-00128a01.pphosted.com with ESMTP id 2ts491myvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Jul 2019 07:51:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xy0VOJCYAFoPHsIt83NSjgutx0FFy3LhdjDEmA6k+NQnVBkA0Fy/VfydlgNeiCii55JiLGCUpKaunqO7Gha2OXdUs458ESqP9F7G7OmxaYX4Lb4/e2FkB+jIRXopgYVXsIrDhjw4QqmqtavdCy8+GnM072B8Kf3+AYcWJA63HFOjXyAV8I3v2qW9sXHVKXfRfGZuifT6jILDi0FiMN8ujPU7kYCbm1XXKFEIw1pbcKwMaH0C6EPh2ewjMp1k8XrOp055T1WCS3Qi0lP1C05BKfc0GjYWwO4a5VR8B+ccsymuC8cUqid2KrdU2MUp4mNiT5ivqM2x7qnypAdJ35Unqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbVEdqT7vCnY5ogGVUu4BAWVGt4Dcsgei+RokeZjvCk=;
 b=CmpZ1G7zekAniBXaND95G7asw7CxC7wz5c4PIv8rsLzjAbkqf8L7aMTPvzyrT5VXNRcOamgXnoTKOmc7lE58dopns19ikPKmEg2HA2kTUbyfHGZiyYInv38Ye6hyX9SBqhleGzTPvpDw/bcQLFPAZM0zX+IJzpfneeD5TjDuJyqJfcdOAPRzszhBWdS6Rb2zvJF4TdX64d+bEZ/RCin/ufmyHwM+myz224bBTaFe2i21VZGc7xAPy5SuM7iji4xeu8cWjK9gmjrO9fdvWEL7+Lxe05I1N8TZjG8HaQUI2yXDXgMwuBzYnM5WXAiOJ53BzsJXaS2lEZDhR3TiA39glg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbVEdqT7vCnY5ogGVUu4BAWVGt4Dcsgei+RokeZjvCk=;
 b=LBHiMndEMxYA5WqGHP1jvHg0364tPGGPIPHiWkIgj+eEsd7T0n3Ytic3egc9tc4eLcryk4U1ClJ2tpP8wCShN/SZKdp9VPI2XX4Ofx9krrglobocKTRm22dCrCSJ0SpWDkB+Ta+7ITTKwikjQTgs13zE7Bu2It7ZFADIvjJVHsk=
Received: from DM3PR03CA0007.namprd03.prod.outlook.com (2603:10b6:0:50::17) by
 DM6PR03MB4715.namprd03.prod.outlook.com (2603:10b6:5:181::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Wed, 17 Jul 2019 11:51:41 +0000
Received: from CY1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by DM3PR03CA0007.outlook.office365.com
 (2603:10b6:0:50::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2073.14 via Frontend
 Transport; Wed, 17 Jul 2019 11:51:40 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT019.mail.protection.outlook.com (10.152.75.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2052.25
 via Frontend Transport; Wed, 17 Jul 2019 11:51:40 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x6HBpdj0003310
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 17 Jul 2019 04:51:39 -0700
Received: from saturn.ad.analog.com (10.48.65.145) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 17 Jul 2019 07:51:38 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 4/4][V2] dt-bindings: iio: imu: add bindings for ADIS16460
Date:   Wed, 17 Jul 2019 14:51:09 +0300
Message-ID: <20190717115109.15168-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717115109.15168-1-alexandru.ardelean@analog.com>
References: <20190717115109.15168-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(2980300002)(199004)(189003)(48376002)(26005)(6666004)(356004)(54906003)(8676002)(2616005)(478600001)(86362001)(44832011)(486006)(11346002)(50226002)(7696005)(110136005)(8936002)(51416003)(446003)(47776003)(106002)(70586007)(2870700001)(336012)(2906002)(966005)(36756003)(1076003)(107886003)(305945005)(7636002)(4326008)(246002)(5660300002)(53376002)(186003)(126002)(426003)(6306002)(476003)(50466002)(316002)(70206006)(2201001)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4715;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0076831-df31-4ba0-bfe6-08d70aad21b0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:DM6PR03MB4715;
X-MS-TrafficTypeDiagnostic: DM6PR03MB4715:
X-MS-Exchange-PUrlCount: 4
X-Microsoft-Antispam-PRVS: <DM6PR03MB471595C1BC675C45CD01F8E7F9C90@DM6PR03MB4715.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 01018CB5B3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: mCajjOsM28zkg0Aku1AMf6ySDJSiS/kxkdzxrUzgigWCxx+UQay67awxgrIjvNOh5ZUWA311SAV7iDztqtSjbAoB1LRT1xE6l5gIyQM4tUTUvOBkO0D+MKv62QhnHw8haDBLOE2h0B8CFjCLkL3czUcWAE77mPhURZ/1rzNv+fxZH0kPnfIY0kmfaVh4ELgY0DvvEJ8c+4nakCgHMa3WrRMohSPIia4VL2dYQVFSk8BMs+5jvQpTyvEmOSzUTwS/j36bj1ZVvLncuDak119meCVgN0ws6EEaAdS2NEqOrbGlWzsdhzsBj2VuLRkwIjihT8jTYMKb8I+b86VMT6A51QwPG2Uf5lOccDQO6RBO3RSHqj/R8kv5yzfmyMIFe8Sdb/5KsiF4vZVa2RQUQBV1KN6HNJor4xXVfpl/FGTgK2s=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2019 11:51:40.0751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0076831-df31-4ba0-bfe6-08d70aad21b0
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4715
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907170145
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change adds device-tree bindings for the ADIS16460.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../bindings/iio/imu/adi,adis16460.yaml       | 53 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
new file mode 100644
index 000000000000..0c53009ba7d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/adi,adis16460.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADIS16460 and similar IMUs
+
+maintainers:
+  - Dragos Bogdan <dragos.bogdan@analog.com>
+
+description: |
+  Analog Devices ADIS16460 and similar IMUs
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ADIS16460.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,adis16460
+
+  reg:
+    maxItems: 1
+
+  spi-cpha: true
+
+  spi-cpol: true
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        imu@0 {
+            compatible = "adi,adis16460";
+            reg = <0>;
+            spi-max-frequency = <5000000>;
+            spi-cpol;
+            spi-cpha;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 8e679504c087..c44fbe8e91e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -943,6 +943,7 @@ S:	Supported
 L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	drivers/iio/imu/adis16460.c
+F:	Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
 
 ANALOG DEVICES INC ADP5061 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
-- 
2.20.1

