Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE641C9074
	for <lists+linux-iio@lfdr.de>; Thu,  7 May 2020 16:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgEGOng (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 May 2020 10:43:36 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:48780 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727841AbgEGOne (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 May 2020 10:43:34 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047Ebhbe006057;
        Thu, 7 May 2020 07:43:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=czBRGgwfM0sgMjtVxSdWQYBBKCe6Zr5q/E9kFStNDUM=;
 b=RBCAlL4umqFSTniGAWD9drkyz27W/ElM60aVfusL4uchw97Zs6iCp7+EH3PHKdqFeJYf
 8MAFTZNDSmgMeWI1T7KrzMfXuqHMSRKTuPiI80fT4qAZeCsLKZke0KAKMXvld2IgXQKZ
 gjlg7lFdI2xD5IMgSLCQMcVhfO31WeCcIYd+CwTieg05Qq/9e86cKlbMAUudf6kR0q7o
 YlFkORd90Cu+ojrmHEVeucUf2wwQZ8pIWvSGf0kCEk4SdKJyVnGYjCNqUwDAaMGyawUZ
 WnasOJ4ZNJj2yRlJ3KTSaR9vTjmOEZN3vpyTAbs0StSb6MolQC6u0R4JX9jJdr9E8Y0/ LA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx0b-00328301.pphosted.com with ESMTP id 30s4tnatww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 07:43:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hku0/KLc1ArRGQLLbzP6jmaI/Gg6zOD5kZa5BWTrONSuAY0CkcSysqAkoq813MgVneteeN+lLgGK0+M/N3dvAhbgyCp5JsvUTCvHbKL2/9IKGelBsr7gEQltH1VlIm5UyIQQgcfSCihbpgxXeC3je40VEFSJrBlwt87S5O2swV0DeeTv1s6TQltPecfYTG3rXi1vjWyhPw6JgXfkdJz8DZ7GmzbAI5Lexbjgvg+H8ebS9Yv3gLSa9SJC5FTZTGDX1g8cnlKZGHCM7epUbn38YGGkMaaYQ52JBA50DC7anZpIItpSn1EETOeOcSDv8Jwd7VvQdOyn6R/sx1yCxvyxsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czBRGgwfM0sgMjtVxSdWQYBBKCe6Zr5q/E9kFStNDUM=;
 b=UlrmMPgMV+BxNzgae4wjThhH7KS7XYVnssNEokSkglmGp6laQVz3Il/9RT+UiYTrgY9r9sSNWnpjd23yMf5ukQrpDPtzsP6MJ515ToxrmsdW9D9unQLgEhNh4e1fZMSEHbmfsi5bi63k3V7opF8uhswTfFhnuKyul1m0RDPEpMksNrbYzo/Kxx5EftHC7Y74B+UhczhEwfjtO+c2G1IzIqC8DESh48iGxq9FJLFqdR/8UrDwvWmKcubS5/CbNa5qDfvljCfKhmUVTW1Kgmc4pfyk97Y1Z5SREq8fJTV5+B6IYWGTLYhUzttHgZgGVlG0bCT0shtNWXEQRDOMIVszGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czBRGgwfM0sgMjtVxSdWQYBBKCe6Zr5q/E9kFStNDUM=;
 b=hbvivFj6n++zDHmlOi72ooTQhth3w3JHk3CsM1CaZSLLnzKKMR6jhuGv6H4RDtCdFyGnEiYvF7NfC8X5E7wQR+C75SIMRrnrYo6of+GRcDwllzKukkmcqvrtN8EnqO+Y9jiyBdamcoC9j0nUkzmWOllmGloivxocQZv+uPSn78U=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB4501.namprd12.prod.outlook.com (2603:10b6:208:269::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Thu, 7 May
 2020 14:43:27 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0%4]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 14:43:27 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 11/12] dt-bindings: iio: imu: Add inv_icm42600 documentation
Date:   Thu,  7 May 2020 16:42:21 +0200
Message-Id: <20200507144222.20989-12-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507144222.20989-1-jmaneyrol@invensense.com>
References: <20200507144222.20989-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0048.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::36) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LNXP265CA0048.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5c::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 14:43:25 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6b9fc75-b14d-4da3-3a2f-08d7f2950093
X-MS-TrafficTypeDiagnostic: MN2PR12MB4501:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4501C2FB60A3D99FE017878BC4A50@MN2PR12MB4501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RBf0vNz1wLxhW11xA4rFESmBYVLvmwawr95KfCLRprr0Xi+901K8hOUofQoq3ZCI5n/F2F0xzFulOxo2oNP0OIz0Fsdst7P9P8b39RRl5HyLPM4p+o7wPQ8EY9M9p1Kk6LyDMmg5QTzzfm+A5rI98e7SBXGTa8xyGWBZiUKZUBC99eXZpqME4NC/vuoafPtjiNbM2MohLt6iYn39pIT2E083E0gelKyP6U0YQ2/79Lg5NCFpp3jx1rWMu6a3BFg3t9LFXyjV5b4sW2orF7RF31OzWhRymZPmARhjFC4OxglYgI/dAQU3QcFBTrUMhLOCn//fnNDfVtdlnILcTlLs5qxUT9ohwV8h4E612xwGJql534DVBnCiweS7UbYh2XcB2f87tHruI//NYOxr8mLiz6V99ExfVwhFVX0G6MkkEsokTInIcv0oQguZSM9C68e5cjlekO5hhJvHRojTNKtdG/O1PgRNW2MJ6FrC7aqzIhtdW90bjT8Tvl2XBZvoWaVYYX7OGDXBRYdJLYUThPZGJ6210QKpSh8CI2syy9vouLGj+zdNS5SDcWZOKcukDLqNw3tKAK+b9YAJOGV/HIUsc2gq1czZ3zf9u8ML6d6C4edPvLI6xV8ex4R03pkym4T0Msir2NARTt+rawORrfDGT3f3a8mP78AoDqJcsg7H/3w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(136003)(396003)(39850400004)(366004)(33430700001)(966005)(107886003)(4326008)(8676002)(6486002)(2906002)(316002)(5660300002)(8936002)(1076003)(26005)(7696005)(33440700001)(66946007)(956004)(66476007)(52116002)(2616005)(86362001)(186003)(83320400001)(83280400001)(83310400001)(83290400001)(16526019)(478600001)(6666004)(36756003)(66556008)(83300400001)(15398625002)(43620500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: RVAeKi5ESVfuU6LCNEJFx29kuf+H7n9XGoU/oDhK+ZhpUVoA7MbU42tNVW59ProeulOps18DfsAy8YmfZZJQ3LDayOTquV7RT/T+P3v+ChAbcJKBI/DemjuNri5aYs2r1QUdNmNZoj/TUm/CDNxNacvFjIdU4joKa16w9DQ/tzmZ007QPzBjTS++y30B8pzaIsjxwccBQZ5V5uprtnKDCmMralQ0CPnIOPbfFlYfap4h+rO88rdTv5wOM5BTz/FAn+Y1FHMVJUtU2xCnxCnZbhn3SXtLF+W9jcPtfzD4c8xbFObxP/6V8xyvQRpSPdrZMXhqx7g5JMJ/6pg7YnlJ5sCULlg/+86Q4t6QTfUvmIurfUM9lOrf4c+er8ohC6OwyvgoBp1kKWm3hUYHBB348UYdUPkjCUnmmqu+h/7hU1ZYG+N0cKOvEOBemo+3Q7ETpecOTDeLLDJr1exsQAorFL/GVTptZ13B481E78bEZmCu8ftdJ/3jtgGNfv5p0eWrrL8yJQQ2nJtWXu3Oj12aXKsAFovrxqsp1uFyh7QxXpEaPI6D0u2/X2F5hgUQf0c2unCeDpsQAUepM4QeMoSVxf1R1dqMKoHZhaq90JxOpTivr/O9mfpjs7UEyvG0gpFs4h3fh4N1gBwaOOX4RKS7AD9FTI9lrSf8nMXnayMiakWTFhbUoOhqriBd8AOMwRFkAAH7nNj2SMwifAnsfOYWtxMlomo/JlkqvIjKjbIX28ddGMta/RKoyycbYVUZvmGTyMkFqN8f0fi4qYdf78ZvLfUFYRa3jKxP8DFhUm5K3hE=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b9fc75-b14d-4da3-3a2f-08d7f2950093
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 14:43:27.1544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cMqCCkKadvayxF6OKORErY90Yj2GOyP8QhzdzBgAC+omU77/sOHgZ7VluXRpzAAhyNBJ+89ueHc+SKgI4Ufn+CEYMZ9II5iN9vb/7WKjfK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4501
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_09:2020-05-07,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070118
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
index 000000000000..a7175f6543fa
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
+  spi-cpha: true
+
+  spi-cpol: true
+
+  spi-max-frequency:
+    maxItems: 1
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

