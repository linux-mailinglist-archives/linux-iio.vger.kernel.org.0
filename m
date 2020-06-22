Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC0A203B22
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jun 2020 17:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgFVPie (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jun 2020 11:38:34 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:6264 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729765AbgFVPiS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jun 2020 11:38:18 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MFa4CA021446;
        Mon, 22 Jun 2020 08:38:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=z4XX+knfiodO8hOSVV8DxC+eo2Lr5g39QXayM+Rj/MM=;
 b=PUcmN6TIP7Ul03HuXo0TDvLuasVHV+z8Sf8y/0T0c6NFqvea3j9JOuuWizKLrUgg7VQS
 EFaIuU8j2l8XpklJVHLLt2e3D1WPp4aLL/eoBcxxVweMNaU/G7sWNh/oq0QU0ITNYF+t
 AzCkOB/08VbJe4GJa4ZmJlhtekkNKXKeLbK/tnvg6xo2jFR810RBTImVk7swOwRdALI6
 wSmqJAZzqgL3GwQeC8mPqyem4INq8221czkrlny1AVof5orbGof/eEVjn9/8uC0RiRVi
 cI2swRZz6vhl/6dLJu6TXNadx9CH5W41kqQEJzDNIow5uY4m6XTFBJfMlR6FMqGkTroc 9A== 
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2055.outbound.protection.outlook.com [104.47.45.55])
        by mx0a-00328301.pphosted.com with ESMTP id 31sdxnrty5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 08:38:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fu4C8vZkkI6r4+fqyFUdXPDj60IUAYiREoj6rxlyuHIo0vC2DyfyWSAzRGXMatlwmwwlCTmQpdGd4Y3Qx24YJXiqS2aYb5WHJiSYRs0T5/39Bu3eacvLsxl//rJRSqIFgJd+l799NMJWVUXhBnm6LAqE/fF3vwID39KqlKslqaUVZXwdueY05czx/Xi21VOi/Df94QMuc5Ci7o29/JnAL6TeDr/ndhYlbnmjy+DWvbrODKO4GhRzRA21aBLtsC/qCVPCfnODHlKSBYRUxKYZZBV32IQk5VM4Fl8n6Hw4DsIwz5o0btAraz3Hmh46MDTi0GRpFzuvbCoLkcz/18WdEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4XX+knfiodO8hOSVV8DxC+eo2Lr5g39QXayM+Rj/MM=;
 b=MVQrJYuzagC8yRz1FoebgD8k3ETSImE0HkBBBySG1fC5ve+WvqQX8Am6uXBDH3YtMfN6gLJ/HB+atKCOZzjnmqdpHggYlv0+ArOvHvKpokkhMvorM1iTVNkr0fNar/EEO9NnPv/+Nn+ftslV+hBP7ehsx7i+xAgAwSnfFs5i7osoBkunaYQ0qg79b9jBLzE4M8UF2841G6pJtiiT4uep/L0SWprhh03+2fs7dW9lKEx1HHj30BjLlHMG1rOvF9ijUtjlzXMkpmcUd+C3K7X2MVmm0YQGQf1mLFO6vAvMWf5jtZbz2GOoE7AEFLZWoFRTCEMW/kH2jrvh+651K+sWyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4XX+knfiodO8hOSVV8DxC+eo2Lr5g39QXayM+Rj/MM=;
 b=fs9I+t9+QR8cw6MN+2psEK4UJst6OpH2twys/J5MaAuRn28SwyG1ti0PlZxBV1QxPGfh7uhvHakAyIScaUCtrmmLwg4KBdYRwVoQ5eg2kiWMfXwbVdMUgNSEcyBsCxtOPdRrkuQBfdgPltY4AMc1l0Eh9EahivliQM7uwpYWoiU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by BL0PR12MB2338.namprd12.prod.outlook.com (2603:10b6:207:4c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 15:38:14 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 15:38:14 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v4 12/13] dt-bindings: iio: imu: Add inv_icm42600 documentation
Date:   Mon, 22 Jun 2020 17:37:28 +0200
Message-Id: <20200622153729.12702-13-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200622153729.12702-1-jmaneyrol@invensense.com>
References: <20200622153729.12702-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0054.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::18) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LO2P265CA0054.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:60::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Mon, 22 Jun 2020 15:38:12 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb0a923f-8fd5-44aa-5a7f-08d816c246ca
X-MS-TrafficTypeDiagnostic: BL0PR12MB2338:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB23381AEC096354B0E527485DC4970@BL0PR12MB2338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oDCybIjZ9OhrBOYCFyQK15klgpjMEogPR0HQp/BbPifaeFre/oShVg9bJjq53mLmAwlbaQ1LZ56UuyB5lMsVRfkKtTurCzC/V7ggtiPEtKi2WdSODBQ1XJiQiOIHWrhX3iGUknxhKzBL3YpSSiqO8raeIjXr+jxgkJEUeXvkXqbYqBxEkouICH3Uzjd8DPnCdGhdALXO6XcVCTSf01exZzR+HH8Ldany3/FtZJt4XkqNzAecSByO1CcZCNxzoaCmVMxWaK9G5J08i8sXGdrAEJ8nB28T1Ix4v3o0wOL/W4oLsP/ObYNNCM0haLenD7ityX3IukHL43DDix21qRwccIfMuoCh3kg3AiQHYLifekW5MACQr8au6fwCxcpHd6gbY4+JckhXEGRa4B4tGHVNjtLGbpQKWz5LU2nJ+QHF2xVkVQq9/2K+km5xqv3y32yIIiQjIFPasXGA1iGKTjVmostNyCGJ/V3Sd4VTTRTatpQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(366004)(136003)(376002)(39850400004)(6486002)(36756003)(2906002)(107886003)(16526019)(186003)(8936002)(956004)(2616005)(26005)(8676002)(6666004)(478600001)(86362001)(1076003)(66556008)(966005)(52116002)(7696005)(66476007)(5660300002)(4326008)(316002)(66946007)(15398625002)(43620500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: TX1erQstpWKnJkYof/kF3n+7cYfzp7WyKSfnARuDVhFNG29eSC5VJRqShmB8QoqKeUIf2N6WJYiNoO0DvRiNtVfD1XeddEoZ3+jltBkuo/HfHorU1xn3dgo9iJ7wnJFbjItwJQDqMweVzSvxtGSxqwiaocrJ2+eEF6l9MRj3PjZvMvt5F1xnSRKjex/K6nGOiOOkoGWVcJSAkWgPDvPEgpnt5+2ot4vm6AU538oKV0viGreIkM4BNgRgH2aZ4383C/qz0zUdeR0rG4LSS9vBW29xHT6qQk609Ytp2Er+a3KtKV+sNvq74hwsPJ0YZX0KXcdUk6LclCwPHryID4GUkXDS/gN3aQ8RLjFYi8cI8GgLqy2tn6DCst7XPCiQMcSdVJajTpM1ehS1fF0QipOwm7sVvIDcdn9Tl90FzwA12JyjNng0CTekN14zRg76GLRXJEgR5cJZrQaNFr/RtuZ97xDKCqfnxBY8mSZy3pZT2OA=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0a923f-8fd5-44aa-5a7f-08d816c246ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 15:38:14.1661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZjFpXBDztCd5FQZ3i+ToKFySG23gR5ynDDUx8EA29dX6DNHk2P94/CPvY6dN3zg/5FUC8MUinPgqX1Zdprzvp4fhSMoq2Y0T1VouObvVmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2338
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_09:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 clxscore=1015 bulkscore=0 cotscore=-2147483648 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006220116
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document the ICM-426xxx devices devicetree bindings.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 .../bindings/iio/imu/invensense,icm42600.yaml | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
new file mode 100644
index 000000000000..abd8d25e1136
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/invensense,icm42600.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: InvenSense ICM-426xx Inertial Measurement Unit
+
+maintainers:
+  - Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
+
+description: |
+  6-axis MotionTracking device that combines a 3-axis gyroscope and a 3-axis
+  accelerometer.
+
+  It has a configurable host interface that supports I3C, I2C and SPI serial
+  communication, features a 2kB FIFO and 2 programmable interrupts with
+  ultra-low-power wake-on-motion support to minimize system power consumption.
+
+  Other industry-leading features include InvenSense on-chip APEX Motion
+  Processing engine for gesture recognition, activity classification, and
+  pedometer, along with programmable digital filters, and an embedded
+  temperature sensor.
+
+  https://invensense.tdk.com/wp-content/uploads/2020/03/DS-000292-ICM-42605-v1.4.pdf
+
+properties:
+  compatible:
+    enum:
+      - invensense,icm42600
+      - invensense,icm42602
+      - invensense,icm42605
+      - invensense,icm42622
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  drive-open-drain:
+    type: boolean
+
+  vdd-supply:
+    description: Regulator that provides power to the sensor
+
+  vddio-supply:
+    description: Regulator that provides power to the bus
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
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        icm42605@68 {
+          compatible = "invensense,icm42605";
+          reg = <0x68>;
+          interrupt-parent = <&gpio2>;
+          interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+          vdd-supply = <&vdd>;
+          vddio-supply = <&vddio>;
+        };
+    };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        icm42602@0 {
+          compatible = "invensense,icm42602";
+          reg = <0>;
+          spi-max-frequency = <24000000>;
+          spi-cpha;
+          spi-cpol;
+          interrupt-parent = <&gpio1>;
+          interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+          vdd-supply = <&vdd>;
+          vddio-supply = <&vddio>;
+        };
+    };
-- 
2.17.1

