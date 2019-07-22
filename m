Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C66470014
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2019 14:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbfGVMsV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jul 2019 08:48:21 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:49432 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729793AbfGVMsQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jul 2019 08:48:16 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6MCSQNw007812;
        Mon, 22 Jul 2019 08:48:11 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2057.outbound.protection.outlook.com [104.47.37.57])
        by mx0b-00128a01.pphosted.com with ESMTP id 2tuyk45x3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jul 2019 08:48:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlOMM1CtMNVBBk3+q3t9x96GDGHo56nXlAk2hC0MSEieu8PcSIyn6Q4SegKiE+bEVChCteLwekXLXzLWK11aYrtmuGm/hspYazqKzQYrnTxy/x2RN/AQw+ggSl8q069R48DX3oC6Ig1nhDg9n+S5BCwneQaMtOBvmHuqR7IzpYqGSJIQYuhAcO5x2hz+7QwuE2Lwo2UG3uMBgPRTY0b3Xn2rM/Kn+2denEBJrycPhWsV9w4r0aWSAdB2+5N6BlGL/4S+9slnJy0g8t+YVGyyuXh4NYMTkYTAxl/VziRdRZb/DGBgwENTTyBfSJaSRczTKHs281L8pfSgWN9q0lmMCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1Cy+XqSTzYxLZasC0xbwdhc3iPRPLhhzTRXBxWFSsA=;
 b=WZs9IAf/4MdWGKI1bEL69FqHm48l3AcHFaslN6VdnJcO1UNQ9+HtVQkSmvftztrUuYqU33MujuSfa1RsoSj1ZsrOYgSg8EJDwkcUDH3ZrGpS8JcIujKT0l4DOjncc2MAfVyPhnAu0djJIAfxPKQgocWl2hNEUet+UN9REmCxUg7jqsKSIh6wmZgc2AtxwEvX250/ztHXQHknUkXE2dAneMiilOuSrQi9jaNIC1LR+9nvDIEWZ/yT4vBDTLMgav1DfGkCIhlRfU3nXrYlmFVA2Grv8ctoOQquFo6KzSUj2umPqwlbzxMMsOW34vjkB7/OG+JGEW+Rrpe3+nivVoFuTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1Cy+XqSTzYxLZasC0xbwdhc3iPRPLhhzTRXBxWFSsA=;
 b=9iZ/pK5MtNsAY2entfSa1lusVpEnmwQ+y1QVG2DcH4wocI1EGhM9Yt0ugMufGWycL+pwWuvbISnHcNoAP9o+ddT05C/mt5zFVrsBRBDwqSJb8yt/efIaluvhD+/xJoYvj4ADenSwcZ/96BbO2glZ1dHOURv+QDXxMYpQjryhzCA=
Received: from BYAPR03CA0018.namprd03.prod.outlook.com (2603:10b6:a02:a8::31)
 by DM6PR03MB3833.namprd03.prod.outlook.com (2603:10b6:5:4f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.17; Mon, 22 Jul
 2019 12:48:09 +0000
Received: from SN1NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by BYAPR03CA0018.outlook.office365.com
 (2603:10b6:a02:a8::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.11 via Frontend
 Transport; Mon, 22 Jul 2019 12:48:09 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT051.mail.protection.outlook.com (10.152.73.103) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2052.25
 via Frontend Transport; Mon, 22 Jul 2019 12:48:05 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x6MCm146019654
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 22 Jul 2019 05:48:01 -0700
Received: from saturn.ad.analog.com (10.48.65.145) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 22 Jul 2019 08:48:03 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 4/4][V3] dt-bindings: iio: imu: add bindings for ADIS16460
Date:   Mon, 22 Jul 2019 15:47:47 +0300
Message-ID: <20190722124747.4792-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722124747.4792-1-alexandru.ardelean@analog.com>
References: <20190722124747.4792-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(39860400002)(2980300002)(189003)(199004)(54906003)(106002)(44832011)(110136005)(50466002)(486006)(6666004)(8676002)(50226002)(356004)(47776003)(426003)(6306002)(316002)(246002)(2616005)(48376002)(7636002)(305945005)(446003)(11346002)(1076003)(86362001)(476003)(126002)(336012)(4326008)(478600001)(966005)(186003)(53376002)(2201001)(36756003)(70206006)(2870700001)(70586007)(8936002)(51416003)(7696005)(2906002)(76176011)(26005)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3833;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8acc9dd4-0bd2-423a-e040-08d70ea2d844
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:DM6PR03MB3833;
X-MS-TrafficTypeDiagnostic: DM6PR03MB3833:
X-MS-Exchange-PUrlCount: 4
X-Microsoft-Antispam-PRVS: <DM6PR03MB38330DD0A8E8DB3A4F4D72D7F9C40@DM6PR03MB3833.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 01068D0A20
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: J8NuKCtqFFFQxBhL3Po+rObmra/wMoNC+olmJ283cGQ0cDa2Q4rFMgLOkCuheIZtlEGXiyDJl8Dkb5E64lKznN3+8DaT/4Qg4ZPd77QbG6U2qLp+WnwWzloSsmkh/x6UnOIyRHl7lmSZ78olnZPgrW3jGGHuK9nlaAugVhL5BtTB57j4YJ0pLuBjJBDbFegWR/+4BaF5WRn4LtddNEur8+mEwUesqE9kA0FmBH6t5SSHWAd57tGqNbW10DjF628vb/ljuh/ZwSjANGDAIzmy9VO6s9UFvS1pPpgA50FH2RfCuuNSjejWarkemCH8K4pJ+u+qdww2PWMf8d0l7/G7+aXxXjLkWspx7uNOFj5F3Tu7ePSmCREd8B/4HX876WcTr/lMSmlcFzus20oLuB8FcDldrcYykq6qizu+t2g3p50=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2019 12:48:05.3652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acc9dd4-0bd2-423a-e040-08d70ea2d844
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3833
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-22_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907220147
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

