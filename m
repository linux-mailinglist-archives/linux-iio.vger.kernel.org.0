Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB34DEED8
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 16:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfJUOIl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 10:08:41 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:25426 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727322AbfJUOIk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2019 10:08:40 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9LE3192013899;
        Mon, 21 Oct 2019 10:06:23 -0400
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2053.outbound.protection.outlook.com [104.47.42.53])
        by mx0a-00128a01.pphosted.com with ESMTP id 2vqyd6ubup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Oct 2019 10:06:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcXr1YM7DMQkP+lW4K9TBb8uBSIazTUirOdKjQt4OnHMfTEgbaKpbNkRTSnMLEgRCajc6sl2CxSnLtKkakMKLtBzeSioCtKIpszjdC3L9qr9xTpDtHA03irEol1+EdYfJ6SDA18U9xmUBLZ/M/TBlA3TmEjgzBLz6buxnb2t9uji63q4qKRX3tNyI7BchgIM0+FjQFnOi7XA1hRtLM8xac0HUhrELZVm8jGAs9xzlPTR1tTEAxhg9cj7dzv1mwScx0JSRauBWeR47PEQu391AruYPbH7YeY9sIUf5Iaa69/4qD0+a3GU0afXcIPIGVuYNyesyyUXTfY4VJpYpIHBbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cosLumCQObGjPwYhk++HWshLh6bROs/p50RbsBNFK1s=;
 b=X7OzIhYOw8wPvpvdQSmLeF1lmFMjYiH/MOEcryhBJXVE6dPLoELf9NLxrNlBSG6PahEpL49I6cfLjQZwJHUNtPg9TNyLBEYqQjYqe/h5hyeKs1uLCa0+vu2O9/V5D3vZNawsGASXKzrHqDwvq199fbbYz9QgqWe/S2SC3jsW47NYwKvArzCCzgQMfXBy/UOmq9AROAuzi1DAKJJ3DzwFcAHTJ3rElFUuySQq4Himw3XgU206oyAATCFeRJZXkPbVtgoVDYyXyclju5+9fVkyowaIPs8XNiG1tPLSnSxcan/nlWKO3pD6K/dWq3MiS6edm6AHVXc8ZudNph6zP7ieFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cosLumCQObGjPwYhk++HWshLh6bROs/p50RbsBNFK1s=;
 b=KMg3a8xR4EYFfowZDqqL8SG6l/0g+FAIV6zZt9KrgL1y/5ZpynDPn27kEXpFQmhdVhGgUdOAZlHbGziEP0OWEc/hUXZerVQcyU0tHlNbmqQilzSolPV1MTEAwoxyYDmgUy472za5pIEgLq3M4V13vI9BNx2B1KmEzJEdoDwrBSE=
Received: from BN6PR03CA0022.namprd03.prod.outlook.com (2603:10b6:404:23::32)
 by DM5PR03MB3067.namprd03.prod.outlook.com (2603:10b6:4:47::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.24; Mon, 21 Oct
 2019 14:06:21 +0000
Received: from SN1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by BN6PR03CA0022.outlook.office365.com
 (2603:10b6:404:23::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20 via Frontend
 Transport; Mon, 21 Oct 2019 14:06:21 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT033.mail.protection.outlook.com (10.152.72.133) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Mon, 21 Oct 2019 14:06:21 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x9LE6DRR013280
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 21 Oct 2019 07:06:13 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 21 Oct 2019 10:06:20 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <paulmck@linux.ibm.com>,
        <mchehab+samsung@kernel.org>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 3/4] dt-binding: iio: Add documentation for AD7091R5
Date:   Mon, 21 Oct 2019 20:06:07 +0300
Message-ID: <20191021170608.26412-3-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021170608.26412-1-beniamin.bia@analog.com>
References: <20191021170608.26412-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(396003)(376002)(199004)(189003)(7636002)(305945005)(107886003)(4326008)(7696005)(51416003)(47776003)(76176011)(48376002)(16586007)(7416002)(54906003)(316002)(6306002)(36756003)(106002)(2906002)(50466002)(50226002)(478600001)(6916009)(8676002)(8936002)(246002)(86362001)(446003)(966005)(1076003)(6666004)(356004)(5660300002)(26005)(336012)(2616005)(486006)(126002)(426003)(70206006)(70586007)(44832011)(2351001)(11346002)(476003)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3067;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f660cded-0e82-4aef-10f9-08d7562fd9c2
X-MS-TrafficTypeDiagnostic: DM5PR03MB3067:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <DM5PR03MB306725EB3F23CA5671F5FF62F0690@DM5PR03MB3067.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0197AFBD92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpjuIYFhaFKIXYN9bssaSzta2Nz7eadO5MWfxJKGCvYxP02F6BTIAFsgJ23tOd106w/ujhaQCrNMZ3knaFTFoTYh9mAxAXnaSczWSS8DoCbH7UBJ46jPilxvQLjvYZwoDOfln3jeVqvwS2IZKu1nZa30vuxI26G08WlGjNhHdsYWXSTwaPxW0GsyQtI2HJegk4jqTb24nyo+D6obo7OWWaYh3BnLyQxO3gEib7GSLlKHrRPyjE+X4dq4cLuADRODNpitGn1hpQ9G1X7q61JDYzvH/ksKSlb0MQVby4I4c/Qi4qP05nsw2Oaqff10AeZz6ThM5AIH/WTud4enaXF4oe0gdvEamomoGG9Xa/dVIMQ9fzmRkMaroDcSIT3dh0i3YaIj3PixG8huA8hM+LpN9oQNGdH9FpbADYqEFgfHSY1Qib5k0gZTMgV58OJ3+E62AlZwfja5WU+gnG7Ekt6L9QCCcXe2Y02bzWrD0upZ4c8=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2019 14:06:21.1739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f660cded-0e82-4aef-10f9-08d7562fd9c2
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3067
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-21_04:2019-10-21,2019-10-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910210133
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Documentation for AD7091R5 ADC was added.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 .../bindings/iio/adc/adi,ad7091r5.yaml        | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
new file mode 100644
index 000000000000..d041cd76804e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0
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
+      - adi,ad7091R5
+
+  reg:
+    maxItems: 1
+
+  avcc-supply:
+    description:
+      Phandle to the Avcc power supply
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+                compatible = "adi,ad7091r5";
+                reg = <0x2F>;
+
+                interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+                interrupt-parent = <&gpio>;
+        };
+    };
+...
-- 
2.17.1

