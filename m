Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A013371302
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2019 09:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388444AbfGWHhG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Jul 2019 03:37:06 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:17012 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388423AbfGWHhG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Jul 2019 03:37:06 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6N7X1Tr013740;
        Tue, 23 Jul 2019 03:37:00 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2051.outbound.protection.outlook.com [104.47.37.51])
        by mx0b-00128a01.pphosted.com with ESMTP id 2tws1sgh3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jul 2019 03:37:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXy9v2+SYPGL09pwRNKGyHWoyYtnM6m5S9Ox2jk6mDUPHCcmczsOw8M18BII4UR3U5oSZNRkN8w0tqK6PQW91TIT8cfNlEoiMKw9dEKudJz1vhkTjttdn5YBEllNnu4LQX2Lg8KHSh5phzSTKBJKIHvO1syKAc1/0odr24dujbOUe+HNgERENWq1aPR02xqTwmEFGTUdE5Xl4oBd8gpBT2ACnL2lIxCHKXyyb43aVdRyJDJ9VrgBj9pT/uj9xmTE/V0SeIx4wdAVFq5xka2dBa+xxrE1xC5GZQZh4/Bf5SJQRn4Ofnp8k2DKiqPImLzUmvDKaTOkztMYcIYuBt+FGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QvzUQRnJyyj9xwyQNM6BeX3bb2nPk6FINSugzUh/oc=;
 b=bdRUKEI4Mr+bS1U9tcnskSu+zMJYf2/zm7CV3qnnAbb9D8bMBT92LPsRqV0POBz8vjq8xXkGE2R7RPp71VgIxTf7OF/UGhHlorS5wUqwYQ5CAUaW5NOjS8HxbceYwiMgcnKhPAU670K8qAW234hewEg3Bv5JOzWIZs1z8MhP72ohhZzwKcwDN0qpmH2KZ78K9Qnz6kuXgO8znUa+9gyccIfv92ICSjIcb0+eqPeftE2gIuS/Q/FgzfcoP++ptU2gBDFoeAqh/bv+WhQQiasyy4oOmgjvRldebvI6fBHhEpGwGnUsyZc4NOFKV83trb23wjlkGmD/aiOa09Dfgmqc7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QvzUQRnJyyj9xwyQNM6BeX3bb2nPk6FINSugzUh/oc=;
 b=BJ0xlUipP4det7c0of8MTw+udYgOtRlumn9eI62BA1J2koxUnoxgMOiXoO40RhDn7cxc7/D0+R2BGp3r3/RfpQJgJKng+kGJefvgaB8+PqkpMgdqrvzMXHELJLIWrpMq3Fpqz5j1Xe8/lGIDA1U768nX0jALF1ckuhrHT0W+UgE=
Received: from BN3PR03CA0067.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::27) by BN6PR03MB3266.namprd03.prod.outlook.com
 (2603:10b6:405:41::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.10; Tue, 23 Jul
 2019 07:36:58 +0000
Received: from CY1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by BN3PR03CA0067.outlook.office365.com
 (2a01:111:e400:7a4d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2094.14 via Frontend
 Transport; Tue, 23 Jul 2019 07:36:58 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT009.mail.protection.outlook.com (10.152.75.12) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2052.25
 via Frontend Transport; Tue, 23 Jul 2019 07:36:57 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x6N7asWE001502
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 23 Jul 2019 00:36:54 -0700
Received: from saturn.ad.analog.com (10.48.65.145) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 23 Jul 2019 03:36:56 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 3/3][V4] dt-bindings: iio: imu: add bindings for ADIS16460
Date:   Tue, 23 Jul 2019 10:36:40 +0300
Message-ID: <20190723073641.27801-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723073641.27801-1-alexandru.ardelean@analog.com>
References: <20190723073641.27801-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(396003)(346002)(2980300002)(189003)(199004)(50226002)(8936002)(186003)(8676002)(5660300002)(36756003)(48376002)(426003)(486006)(476003)(2616005)(126002)(2906002)(2870700001)(44832011)(11346002)(4326008)(446003)(76176011)(51416003)(7696005)(1076003)(47776003)(106002)(50466002)(2201001)(53376002)(26005)(336012)(316002)(54906003)(6666004)(356004)(110136005)(6306002)(966005)(70586007)(246002)(86362001)(305945005)(478600001)(7636002)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3266;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 853b8a91-3b40-4948-528f-08d70f408b24
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BN6PR03MB3266;
X-MS-TrafficTypeDiagnostic: BN6PR03MB3266:
X-MS-Exchange-PUrlCount: 4
X-Microsoft-Antispam-PRVS: <BN6PR03MB3266D412A6104DF49504F963F9C70@BN6PR03MB3266.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 0107098B6C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: MH9gtSbQRFPnwfHkzDOi1IKjvvOjaj0nKTkRw+DdR9DCNScNF7Qc89fzkN8FIfepQu2CK5T52mp+u6suVWWVWV5VWez/Edfqh0PZAmdqU+9zrOigYkl6/UeLSWSqu64xstKguMPwEAh6WzjAaI/y5R1Yrtv2kQ/9G7GHKVFyYTaFQTigTNvVv+EDg3LTHbG7WFKb83cKnlD6NpOWY5adhUlcmMPukAdTlJfjpg8GNyiuSwTc09M1v5UbIX7/vCUwb/+G4kEileUx+Qqewo9QhbqGdLjd+hDOZdnPd36DDbcLxIHbuxPLzhgig3mDyQkYj0xPeXqTI1VCI6eOgx7VGxAH4c1tCMa3u/7Ffhur4TshEkBobTlzTnJ+JmGPBUudKkg4ff2Jt7KQTr+96hIO4al2wOH38MQRSQ9hnZiIx5I=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2019 07:36:57.6175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 853b8a91-3b40-4948-528f-08d70f408b24
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3266
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907230071
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change adds device-tree bindings for the ADIS16460.

Reviewed-by: Rob Herring <robh@kernel.org>
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
index f7de89e82e35..07105e43ea1e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -951,6 +951,7 @@ S:	Supported
 L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	drivers/iio/imu/adis16460.c
+F:	Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
 
 ANALOG DEVICES INC ADP5061 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
-- 
2.20.1

