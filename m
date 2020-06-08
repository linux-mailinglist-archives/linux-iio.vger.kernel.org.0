Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E1C1F20F0
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 22:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgFHUpM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 16:45:12 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:12348 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726834AbgFHUoN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jun 2020 16:44:13 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058KhpKN027834;
        Mon, 8 Jun 2020 13:44:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=z4XX+knfiodO8hOSVV8DxC+eo2Lr5g39QXayM+Rj/MM=;
 b=Pr7WFbYjTsR4F7yWrb/N230Z5tBXwTLwMOsg99sfU995j0MnTrnTBpsl7RPduZbgljwI
 DpBq8sX0h5LLgZTWqW3q2ysr74D6FYaZOzdgi1cI6SK/Ul8ojNPmgTRkNEYZ11sUu9ya
 E04UsvQpeOptRqfCDjCggf9EVYgAvUyit6HMwsjZ4oskZgKZucdFCeHwhP5Gp2NA7U5B
 u9S4eXxr7QJPMmpepNe0yPax3vVOfjQP/OSm/itsR1nXr5JKaoOVSJL6DXWb1gPncl3t
 7JYeaOTcX3/i2SsKNkfemUwKhXFtuYhOVxnVNVJqJKjOUoFj2A7ufRt4VvRPb0K4HUy0 JQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0a-00328301.pphosted.com with ESMTP id 31g867h0f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 13:44:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQL3e+QKwKNiD2s/T+bTiB9TcAgh6k2CtVhrWe7q40uVpTF7bfwVrJ3QVDk2YOLJ0n0PWN7gNoMqmmz2tavQN3JdxFENIFyq/AqSwpYm2Y7vsILu+Q2P4ed1UVFBkjwYzk1ru6pClb/GO1wYAaw8SqQm4l14HGz81usZ8by2PpGQSuyhUYkY8CrZRPBpWJC6V5uxhg7tVU6565Uld1EygwK9ekdkoRs3ECVs4G8wt9GW95orvTphGlXAmwlQJPQwwlYU+JPb+ZT2zpV76QK34gsmcBQFaBZ+ICCgqhwrDumNCh53QZpTkte708WyOk6rMWCwS36yzmJmcpCMOuVB2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4XX+knfiodO8hOSVV8DxC+eo2Lr5g39QXayM+Rj/MM=;
 b=RV1Ah5WVpCKyYIU7374vPhDDps7/x9BEU5TE9O05uWV27qkEpwilmtYzsETunBS60TEMbqMdBla/qCScsElUKx35uU5YPUlV+8D9kuYS93jHLL4TdraeQndtFisd7T8stypSaRAWnq7OJvDtmgCDFvnzD0+3zsR85XNheTHz0PYQdrYJ71nEku64fx/R/K6tLf+7+6jJACHm1BSja50/OjGSftp1THhAeY+GQxtKIFiH2PnnS/ftRJcWmKsvXa87wZ4b7FO8RV3/YSwyjfpEnVmn3krB1XC6HkPXKN+2H5jB5VTj/I2J+uJi6ipBtSUPy0ofofABzdTilfAkWcPlwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4XX+knfiodO8hOSVV8DxC+eo2Lr5g39QXayM+Rj/MM=;
 b=hZBXk5tM3vvd9g4SKxoPRScDQxNWK/JTidSMtqrNqmlPpympEsIjh7Nt5TCSqNd7E9ceEddGTZ9fy+EayP4EPxNDCaJJhKyKdjhtyjbZjJYRiMJLtW3WxzY4c/TFJW2hPhagRJXO2nVja6sASBSrSa11ZPP850Y+6U4zOM1DHJ4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3951.namprd12.prod.outlook.com (2603:10b6:208:16b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 20:44:09 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 20:44:09 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v3 12/13] dt-bindings: iio: imu: Add inv_icm42600 documentation
Date:   Mon,  8 Jun 2020 22:42:49 +0200
Message-Id: <20200608204250.3291-13-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608204250.3291-1-jmaneyrol@invensense.com>
References: <20200608204250.3291-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::19) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:76::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 20:44:08 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15233218-47be-48f7-b79e-08d80becb19b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3951:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB395162322183FF93471265E6C4850@MN2PR12MB3951.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kEmIw+kXWdRVkCRlxE6qZOzEsUZM1gt9t/djd4BFRcktiKgOOkumsZw3CQTqz0GgaplO92A+rlKKdYOe6jHt7thgQK1P+XdJUhG9wzWn5aq0Xw8NSfsRa5fdELANNyIScaJa5BJkNswEiVUqQcwgWbYGZ6gOqWT65HkGcrNOPJL/OGrFntX0GH+qh1xjOE1/GISyo5fpH6Y2nedBGFv50s5NbWl8e8i0vBzimYvbJ5lDZp82hZdAZImlptx6kg2zDf+HR0trw4VOa/f2DxMt+4IzwO3oXqxVRwjo0lmKejLOki/llWn84oFcRy9NE45YantftY/D42cfb+Ysovji0tHxNrcNv8P3TmP5DO2ayQtrTzvE1gGYsRnqeQftLcIFmoS+z0xwtWEDbczL7IgYYN5ysicHDh5EJ8PlUABI806vWg5Q3x4NfYaXpRLNA6+7s71ye9csg7WFumBRYXWVTrRJQA5buzbv+me8yaPrGLc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(376002)(346002)(396003)(136003)(366004)(66556008)(66476007)(66946007)(6666004)(36756003)(86362001)(5660300002)(1076003)(6486002)(4326008)(956004)(2616005)(966005)(8936002)(2906002)(107886003)(8676002)(7696005)(16526019)(186003)(478600001)(52116002)(26005)(316002)(15398625002)(43620500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: tFGLWcexp51GfKGuESh8q+sum1FXI23/c7FUOd4lSVDcMjhLDVTOnanH13OTZhkZqvTZInsjNKgtcRzO3WRdKGX1kw48ybXgrdZDk0CHMh+B9Gg+walQEODpahbGC0LfCRy5HWknu3eQQEb/NmpAYRrcpPdnbupP0/kBMD20LOBD62mPmExe/NZsHUBU9fJU2PI1rCcGBQF8F5ipV+eKahmT5AGXZyI7VQjbZ5r+7w9qxPeO9nqbzPOwoqyqX33xQ/9F1Os3REyCk87ZYIfv0S1jyQ1R1QsMdXApn96+I7nv8XUiDFLyv77vxtaiG3GjhN0uNsV7i+bJVfYpJ8Wj/dm8vSoCSblqB4xQafn4QQooyLIMQR5j43/FPq3bi3OBY0xt3I/eygKBeXSPHmdABdcMHIxAfaYebquVCk+U4nutBT5ZV3x9yrb6eUDHaLLOgEoFKwlrl2xbNtOUiVNCAjS6kFrKJsoUrTx1QfenzKk=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15233218-47be-48f7-b79e-08d80becb19b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 20:44:09.6140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WlZMx9A8E3k9wsjban7eHwgHt3Ib+Sx+ANGh8pmgDxi+VB+dXXLjhq3Lt2h9vWu6mz2EwF3DixGXJf0X454QAex/P62ngf8+BIAx2yh2SI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3951
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_18:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 cotscore=-2147483648 adultscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080144
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

