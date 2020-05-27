Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6247C1E4DAB
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 20:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387606AbgE0S6Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 May 2020 14:58:25 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:18300 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387497AbgE0S6I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 May 2020 14:58:08 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04RIw4r3009036;
        Wed, 27 May 2020 11:58:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=Qb6++CeCiZEAHleu78uwaQYHKr37D/TP5bFZ1fQqT0Q=;
 b=pqlhCWxBtIJgPMMT7bwog4MeBm/L40vUK1honGjSDUrzYZEE7abXI171O/VTf9azxKfD
 aYFTGDrVkDtJKKEIYhfgsD698z7Xk5L/ev580PGxSL3DbTCI1BRDGI4ybj5o8MWTRxHu
 4MLdt3VT2ypEiMP18r05FfnzruEIKbcTFof7THF5sIUvRrhwPcK+aX4+kRArsdZueklF
 5O82kBjgNs0bVZNROg2yqqMp78i//VFB04n1Xei08LziEsvLsReA+xwoiX7+AADJ84Cx
 xzFoiXguZD+X/VLVAWw5kB/NxwrAvvzAMPhoLJ/OPTyKAG7OkbfcxWWxZGOEGslcVJC9 +Q== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by mx0b-00328301.pphosted.com with ESMTP id 3185ap9ewx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 11:58:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhoxVsFAKUwhi13PO/BXeJ86iS8BnY5bXnmXcjnqlMXLhQ2p78N2W5cJqhAGE5TQvxDrTyoq5Z0H6lq08n14AE8JXZVXdcew42mvXXr80vIkU9VZ32ivBDn32JPPupLXsGjownuVdNPnXYvN0IrXyoorRDtLWMDtwZX9BxCArFnIz8uMzCznS7MqoHHXOlmbw0MARteg/U9cC1IS9vF9dahXeJmDUQXaBLET0wCaMgwZhdPY0rcsFucTU1tKgyv5r2RD+bFalj9NaNnN1OEA3ArQLUqASF8qDa8LJI+uj5/tJxcEvwmySfVc5jEa4wgbZxedsmZIl80dyhmy+zw0OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qb6++CeCiZEAHleu78uwaQYHKr37D/TP5bFZ1fQqT0Q=;
 b=XYmBNpEfyGtsMtXXL6OyJOfvzju4vPJNsrFKYxm64HWx/lyr2xMsUvDocretYXAaTRSEXf8uD078MrzYnDN3llIuGTRE90DLAMGhOREBJIyd5M0+pkQEP1scHpAem6gkMRmZB5rt/DSJGfJblNDMz3qO0AapWZRQMklMohGAz/Bx5u14tFhNXYWjpdRX7RKsNK/4/G2F7T28C4UX1+Lw/p8rj/uk37VpCm0Bm33U1/FD+yKa6WMN+93G8zy4N12rmbzEa6q37lBTICMPYbFTMIT3Uqj2UhtSYLM+iqJwdcZ46WPHKVGIKv65ZnswW9JWD6cPqAZV90bYOpoZyDdJhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qb6++CeCiZEAHleu78uwaQYHKr37D/TP5bFZ1fQqT0Q=;
 b=YQbJ+qQpuP8doqL2zr0tEfrNuLLmaq8PLQSHlwD1FTmza+LBU38JMKwOgcpEhdnYZm78Dz+P/71wJ3of5v8nmMsqbuwJb4aHayQR9r0IFdawH69zCX1XsjFe59xaJ0CTlLBzrnHySuG3S4mPGZGV4OloHRSXBD27Llp6aeqJqPY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3151.namprd12.prod.outlook.com (2603:10b6:208:d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 27 May
 2020 18:57:58 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 18:57:58 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 11/12] dt-bindings: iio: imu: Add inv_icm42600 documentation
Date:   Wed, 27 May 2020 20:57:10 +0200
Message-Id: <20200527185711.21331-12-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200527185711.21331-1-jmaneyrol@invensense.com>
References: <20200527185711.21331-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0168.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::36) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LO2P265CA0168.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.26 via Frontend Transport; Wed, 27 May 2020 18:57:56 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2081040-6098-405d-e51b-08d8026fdf0a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3151:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB31510BE4AD778513C3350A1CC4B10@MN2PR12MB3151.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e9IMacADo0dGsqa8x7Fg2+XCdvisT15+7gWYrDYGPtQHyQMbdXV6UsL3/+wd5KvcIedJqDkCBwZ/IM0c8drWxVk4gMnr7zM4KS5fmBfssFLkA/5LGFeQLNV8o4gZbPwV7XeUfWuZfbOswqCoOtmeX0lP/R378a5YbZNOBY4vCtlnpaGjUhsn1+Qz29IEMihg7a2upmh25d7EiQJJsv1KneibDgB9WJKDXuAZa8YWV94wwQuL7BmOO8LpV52bUvJTs/dH8ton0oJHasrJGsTqB15Zc7rPRXaG7nfvQozKTtrmUuQ0TpaSxSiSRhti7CycLT34AtIC6SxoNobPtFRDGg2ni6Ss7tJZAKhcWpV3gEwljVAKiIb5MtYdTpSlt0dvce7uNuBH7jSXVVprqbfUS5FpQo/p4SRucyAs1HK/fv5oDvzVsj2YAELTzvF+WHNMq5i9t+ROwP+PjbzG7eJtge+7OtWFNFZmWZilnh7G8Lo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39850400004)(346002)(366004)(396003)(376002)(966005)(16526019)(478600001)(107886003)(8676002)(5660300002)(186003)(8936002)(316002)(6666004)(6486002)(1076003)(7696005)(66946007)(26005)(2616005)(956004)(2906002)(86362001)(36756003)(52116002)(4326008)(66556008)(66476007)(15398625002)(43620500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5VrDd2q03c3ff6EldJMJUnU87dC0XsYerTdw0rHwUEghQVvxNG+OqJChTe8gsCCzshNzGJFHz7z5D1FASqe0hCVs8F7PoeN4B3fJstAtko2vPLMeqnii7fDF1EpQoML2iKzvvvLYbKbWrOs/FKhufqRccWoTgczoEzPmzHoUmh5BevT8qPjJ+jlu6h2Fs0gGiOShYVb9AF0XyswOwjp3YfIimrM/lPRo7DalLCjGsK5vy2AIlMpWF0nUyVjyu8NT+wBw3YNuhTMkSpmOKPjTkfJQ3gJA2XmQyy64g5MMHa2sdH5d//4iKjJMDP0bFYw3ulRdsBjeKidp6hFQ71ZSyImSJ8t9Tdhbc7aJhZBwleepKLSJQPFuYxDBGyS4NTPp44GtqdJZjjrmaqH0RDyR0vEgLWz5ySsMYD4BcMU+74DwdX2eLBCstw+HWqalxA+rPazEYwBTeuNcMw3Ygb6c8K/ui/pdgX/vKvXYJ48eQp8=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2081040-6098-405d-e51b-08d8026fdf0a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 18:57:58.1893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PE+Uso9fwVcdBUIkoK4cZi2Jxf7slWQDudsUJx2/5sRfNvnOJI4kS6PFWcWYk+6QIj/5g4U44bS8v2uEtq2KQ0M01WHaLv9BF6DJ2apdLyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3151
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270145
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document the ICM-426xxx devices devicetree bindings.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 .../bindings/iio/imu/invensense,icm42600.yaml | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
new file mode 100644
index 000000000000..c5b046e0ce36
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -0,0 +1,86 @@
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
+  6-axis MotionTracking device that combines a 3-axis gyroscope and a 3-axis accelerometer.
+
+  It has a configurable host interface that supports I3C, I2C and SPI serial communication, features a 2kB FIFO and
+  2 programmable interrupts with ultra-low-power wake-on-motion support to minimize system power consumption.
+
+  Other industry-leading features include InvenSense on-chip APEX Motion Processing engine for gesture recognition,
+  activity classification, and pedometer, along with programmable digital filters, and an embedded temperature sensor.
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

