Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31F8CFDD63
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2019 13:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfKOMXf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Nov 2019 07:23:35 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:20650 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727196AbfKOMXf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Nov 2019 07:23:35 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFCDD9f031841;
        Fri, 15 Nov 2019 07:23:10 -0500
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2053.outbound.protection.outlook.com [104.47.36.53])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w7pr6svfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Nov 2019 07:23:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9Bs4M2Pdr1jWLXo2/GC6v2dAk6u+iCfeK3K0dWSZgemtvhUgow/+l23nIQQ1Q0Up3CLW5pop+Ze0kblbQGQ3oXKteTR86FaSN9RLHTdPpggu3fT/t9bKpG5f0kZhcc2yn13FbPe0kfdVjkCncI1cqMhF7T6cr09LYfQwutMIVDBG1tDQviJgGLzLM++TybslfayMLmpkfZ3fJEQhgZoNWrco5gPpaputnTFITe6zNNvOQ6rI/ecgQxOTuWooWL8cr5T/3XOAvhtZKTQvua5wdZDBhZheuwsOFSKf5Pbju2nzrDqKN3uJBwK9/Kg1eTAUdrOlrzCSj1Sd0eJxCQBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXY3GGaNR8j3xRC6oNAPWqGidib/1qqSX3shP0R+D/I=;
 b=XQxgkU9Bc3HvQMxAfBSEHy5rUj65Yx+u7q+XaNOssK03VhGoOPBVqzzmXM7rFYxHrNr2WQazsGuDDvzu/a/7pvA7nfY92JkOe6Onxt+ZLbEK2OMJBaOEZnjBG4A2IijEGW0EJdUQ25LfGeVl1e/psWe255xkqZv7vcod0E4zqvZif9qfGIoSMD8W8zFL0irH0WyQkvhzxvTzrqF7romKaH6WRva5lFk3bfXwQD1YAL5/XTblk4WQtj/bIp173fpzOX1mBNZjwTSdKTQqVrByHCTeIKkYeo9gRC3s0xUyllnEcMXk4l30TbOMXC/jPUgW4D5BoEzFObhyN7Q6EOjoKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXY3GGaNR8j3xRC6oNAPWqGidib/1qqSX3shP0R+D/I=;
 b=NwEm9krluzIwBtPLZBQvb3owGQWQqNfePPXlHQb7gThtVWJht5PgljN6FJPkkSBxcMDLshlfu6Vo+EcK7H4EhukKQzgJKTXOkuhZM2KgQXZo+o7FStyd8ysn+4uU9v84OGgPlWlYPHlGM9tK8N11nJF8C1AEgUi5mrbQgyGg33A=
Received: from CH2PR03CA0026.namprd03.prod.outlook.com (2603:10b6:610:59::36)
 by SN6PR03MB4477.namprd03.prod.outlook.com (2603:10b6:805:fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22; Fri, 15 Nov
 2019 12:23:07 +0000
Received: from BL2NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by CH2PR03CA0026.outlook.office365.com
 (2603:10b6:610:59::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.22 via Frontend
 Transport; Fri, 15 Nov 2019 12:23:07 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT051.mail.protection.outlook.com (10.152.76.181) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2451.23
 via Frontend Transport; Fri, 15 Nov 2019 12:23:07 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xAFCN7mZ031794
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 15 Nov 2019 04:23:07 -0800
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.231) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 15 Nov 2019 07:23:06 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>, <robh+dt@kernel.org>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v4 3/4] dt-binding: iio: Add documentation for AD7091R5
Date:   Fri, 15 Nov 2019 14:23:15 +0200
Message-ID: <20191115122316.20893-3-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115122316.20893-1-beniamin.bia@analog.com>
References: <20191115122316.20893-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(36756003)(5660300002)(76176011)(426003)(51416003)(7696005)(6916009)(8936002)(8676002)(966005)(246002)(2351001)(11346002)(54906003)(2616005)(50226002)(50466002)(16586007)(106002)(336012)(478600001)(7416002)(126002)(86362001)(107886003)(48376002)(2906002)(476003)(316002)(446003)(305945005)(6306002)(7636002)(47776003)(356004)(26005)(6666004)(486006)(4326008)(70586007)(70206006)(44832011)(1076003)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB4477;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 324391c9-5d43-4d8c-7e9f-08d769c6925d
X-MS-TrafficTypeDiagnostic: SN6PR03MB4477:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <SN6PR03MB44777A03C1149E76C46982E4F0700@SN6PR03MB4477.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 02229A4115
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D2T923HZj1JYxsgdn0Pmd4sgeCrpMRAZ4Y1Vk1SPvVJ/kbqcXe7I8mZRR5qIiQsrEY26wBxcVJRBtmYZjUVpj3nLF1mBkjnHiQ+kQAccrceJmffNknUv+084/AAHJYXNrMmF89aWyMFoKBZBMQZIIaKiHJ1jR+Jt3OZea5AAQ95iHIYreq4B2wrzxbgTUv9Q8g7izZqgDAXLkES9OBNACVYMq6JBFk1KECev1iIyOZPFkyT/9KwEHrmk6LkQ6PnJqCmF2OaMm9dYF5xrc4MMv0Tusw47B5hh/VQv1rs+R1tqfBecVq9+etjoXDCVk6Q4CwnKPDRQc8qxXbcyDpyYwvsKxtdfnDlPsAkvc1Sjm7iGdCk/yDaYGsUwqFZUeU7MJKbL5xVez2iFIFMV180B3qpOE2c2QXUh0SKYnQCHnuy86u4uqR0R7GpHqjHUrkwl/Xw3t55MZVVrvdfupoGNNvrDdqcsBFotZVLf24Ri5tI=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 12:23:07.5685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 324391c9-5d43-4d8c-7e9f-08d769c6925d
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4477
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_03:2019-11-15,2019-11-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911150116
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Documentation for AD7091R5 ADC was added.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v4:
-nothing changed

 .../bindings/iio/adc/adi,ad7091r5.yaml        | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
new file mode 100644
index 000000000000..31ffa275f5fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7091r5.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7091R5 4-Channel 12-Bit ADC
+
+maintainers:
+  - Beniamin Bia <beniamin.bia@analog.com>
+
+description: |
+  Analog Devices AD7091R5 4-Channel 12-Bit ADC
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7091r-5.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7091r5
+
+  reg:
+    maxItems: 1
+
+  vref-supply:
+    description:
+      Phandle to the vref power supply
+
+  interrupts:
+    maxItems: 1
+
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@2f {
+                compatible = "adi,ad7091r5";
+                reg = <0x2f>;
+
+                interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+                interrupt-parent = <&gpio>;
+        };
+    };
+...
-- 
2.17.1

