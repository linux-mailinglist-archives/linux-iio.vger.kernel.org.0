Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6F636AF81
	for <lists+linux-iio@lfdr.de>; Mon, 26 Apr 2021 10:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhDZILo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Apr 2021 04:11:44 -0400
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:10563
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232418AbhDZILn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Apr 2021 04:11:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oh282rX8gjTk8LhV84EIGkY9BocC22wM2rKSPuYZpuF5YgUHN0w7yg2TwQiK3YNajnyiI7ExSV/t/OZIvmJBS/eV4GQ/Qz4ST1Osj9gTrSDgXnom+FYNoV2I2Q4GO+JlS2HeYSFvTDOS4vWKCcoDSuofHswfEO+rm83uxp5uv2s8qmNTrD+zAP1TmAW5tP5WGvBNFXcILsjbrjvaNeNJ+PvYek5GxZxrlfQuNeAbjymkFaLXHIwG8BM5FgyjQbkRsvAGwH8Q+LaQTgBJywue68NEilnFCOfFchwq7hOFfjkOmhbsfM4Xvzm+CS80kSih3XxB5RYcspaR2DQsPqBK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AiCfi31AT7+NZfwy9B+6zkyI6MqGR9j8g88aw5JH1A=;
 b=W5ZlqHny71oSvUrmeRBsxE740V8cFI/jhMVWfBUOBXJxlo3gjRADlRsEQPeF0w7CRN8BdwZSVb1LtCpHdCPZpLe8P+j+O6j/keQ0GBXaiVX+6Hdq/LJ9UFDcj4qpqLHsq9N0EcuHPHq1XGo6FiPlNcUERJC5K7+vyuGd/7Yb+IiXPPOn1R9wt7LpZgMkiB8TMHCXEBozrYDWuMrp9RUOqma99m1VPV9j70WAQURFkcEtYQ0E1tEp+dm6TVEGuzphCJk8Bl0n34qOEsrB6NmQuxZ1oeAHw129XW/Dux4te3FgbGJxA9F/7krXYmKEbPYLZo+aRC1PoI976OMs2nrd5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AiCfi31AT7+NZfwy9B+6zkyI6MqGR9j8g88aw5JH1A=;
 b=H6hBwzp28wORFZQv6L1Dq1i1cWx6gMo+rMrp0zGQ+orZ9PnuBjpV0aRczF8fHjvqIB6s6ArhyQcDuwMgrKeNkfMmUukx3L7b9CjOFXr0Vzkm3BJhngMEzB0ZrMnX1a5IImAVRF5jdoxGyGXQSE50KbTrIwLwGWCv+4JGxle5l0BP4FAricGfCs3JQX5CK7AYDipfBWOjx1t69uNVxIyPsbCQBj/S6Av0VYSmXA4zHkdX3Zpt4YBlmzmEsujHFog4m7/26ey0v3eJHjXTFd/bc1P8HTu7HvdzAA6f0rDhd/tSkXpoUh7yJpJly3gCdZNE0NEZIBksk0vMDm0V9cZDAw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VI1PR06MB5888.eurprd06.prod.outlook.com
 (2603:10a6:803:d8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Mon, 26 Apr
 2021 08:10:58 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::4ca5:d9e1:61cc:8113]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::4ca5:d9e1:61cc:8113%5]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 08:10:58 +0000
From:   Tomas Melin <tomas.melin@vaisala.com>
To:     jic23@kernel.org, devicetree@vger.kernel.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tomas Melin <tomas.melin@vaisala.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/2] dt-bindings: iio: accel: Add SCA3300 documentation
Date:   Mon, 26 Apr 2021 11:10:40 +0300
Message-Id: <20210426081041.59807-2-tomas.melin@vaisala.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20210426081041.59807-1-tomas.melin@vaisala.com>
References: <20210426081041.59807-1-tomas.melin@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [85.156.166.106]
X-ClientProxiedBy: HE1PR07CA0025.eurprd07.prod.outlook.com
 (2603:10a6:7:66::11) To VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora-vm.vaisala.com (85.156.166.106) by HE1PR07CA0025.eurprd07.prod.outlook.com (2603:10a6:7:66::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.15 via Frontend Transport; Mon, 26 Apr 2021 08:10:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51f7b79f-d367-4664-467f-08d9088ad2d8
X-MS-TrafficTypeDiagnostic: VI1PR06MB5888:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR06MB5888004C0E0D91BC29EB3649FD429@VI1PR06MB5888.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zTF2zo7Gh7Bdo8IDH5zFoufltUvKTMSvJk3zhbDEXcQPj/owqT40aMV3pitGOlBAN+J4kjYvQyLFZ/2gS40rmdy6kQRNQ+Hf+q/MGPfMua/8MWo8qQBvBqjR16UEwPk0R8ALEhAVGZKt9BZnivqsRvj4Pisfu7MtvuP5Aq+CODsXVC5aj9pHXIforJgRb9+Fb8e6kIsvziah41vAjp++Q1ZX0YNf0AzJO+jpa/lhAm+eaQnTdVJjL4jvU105WOHxMp7Wx/AopTQcyQSOHPiJIX9QYLGbbXaVnSQHtb8CtRSqkwqS2xKKGuvc0xSDT7bw21X5bewoxAVeFT91V1yiQrXfYULtAbERZu5/K3rkdieCspvaxM1ehzIE+3y/hP7Fjwhg4EuyGmjGjMbxDUgNVXFfEUQTkfwm0bgnlYmUOCxQ1HZGHz1xwekBL/OaPnMFU/lMmk8vgdAiaXfyRMOsAQmmjpbQygZb8RW+2PpJQSDHftCrPdwDvodCgGp599I6rNDmQ8NL+kRyQQFMB27akX94RkVfBDlNWUBQNKm9xL7rUSdWCgiAJS8rkOV55vdzdfBRIZwSg6IUBpJQF1aSqwrA4+MzHTMbtlJXjpkzkKi7u/pR+qVZmtOuEKIVDDbL7ziavo7/P1WhQr6L+IRW+jxjFq0OF2FAv5jJegKAlRQZVcXx9XiP8DsYSsX5Y+YZsgOQrtvxRUbYAdDdtZh6+hAv7gF0P+MGPkAWk4rv6OI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(376002)(346002)(366004)(396003)(1076003)(966005)(6666004)(956004)(2616005)(86362001)(2906002)(16526019)(26005)(186003)(66476007)(4326008)(8676002)(478600001)(66556008)(66946007)(6486002)(8936002)(44832011)(5660300002)(38100700002)(38350700002)(54906003)(52116002)(7696005)(36756003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4w1uH1eby8mIvoY0OB3rQ2mLJhcUslug99OqWrKq8OZc6ZFnMHwoh1tvpnmU?=
 =?us-ascii?Q?Mt2H/U0FkM8ocdAHMeT5KopZrIhTgHJ7pdqceskTtSvOpz9BDDVIqDFdbV0j?=
 =?us-ascii?Q?owvS8ISwi5PFuslCfxpVN98PjGAaGro62juKNUuadYdGtsrJm04ik5PAcVyS?=
 =?us-ascii?Q?mZqZkVwORXxXZMOJauVC/Q+CIDsXQ7fx/yc2YI9KcxWSFTrZezxG840zFU8/?=
 =?us-ascii?Q?7ItdHY2AIp2cSDbY1jfteVrHFj6+OJZ7r4e1VDP7jcBZLIKk/mynpH8Dqojf?=
 =?us-ascii?Q?NosHcHZCrYBv0a/X7FpOnQJL24eTvUHr3/KMxIB3ravRB9LuME48H0aYqbSi?=
 =?us-ascii?Q?unXRiCMZsaHl9bbl2qMKBGryLRIHN2y389OSROZ4yxj0nQgBbQqocY9DUYe0?=
 =?us-ascii?Q?xlulOtU10hDIoLgpRsSZhvYZH5OxDZT9QwewvtuMe6w78gNE7KJE7LiJjDAc?=
 =?us-ascii?Q?lOpMdS733ASXe4iVkzC8jARKnvfJ4uWuq/UJ25eR+c1aFatoPLQqic9Qzibl?=
 =?us-ascii?Q?QrV8YDqB3kG7rK4cuWDozaK95pDz83dT0gdINp8sbUBRPYBJ/0kR+nTY28JW?=
 =?us-ascii?Q?v1xu5gMbCR8dbyh4ya5TQTHwcek62uUaF0fbvTUjITpUPFH9d4AlKjzF2UNb?=
 =?us-ascii?Q?dr4a097CRxzMXojeONFzFeFnlj8seO1I8C/gWd5p4zchoL6tEj52T9YOQHLa?=
 =?us-ascii?Q?T+ydbK8nkY1Fzd78hkjJDVgGg1v8g2kCQSqRoKmDELkcfWQ5psOgKRGdfiH3?=
 =?us-ascii?Q?C49WbvZMAeOeURBVd5oAGt36bGsqo8PWkde9c/y/KsEZ0UJBWT1U+uDhmbtz?=
 =?us-ascii?Q?YhAT1puJo7yIs4bjfBdUvJQPbhzdI8eAln1wvxThBBBAoDgiSvDKF/1Qz1lx?=
 =?us-ascii?Q?tIZEsYdS+Bywy0K+umKauHtOtoQmPKJc4Bu67TgrtH0igDVE2xTCKF2x7637?=
 =?us-ascii?Q?TGVDoGE2z8z90heRA0PysIrbJ+qrc5p3Upnrv+8n9D3o8uVHOVjCjuqplGXs?=
 =?us-ascii?Q?OMKnGXvloz0y7jA+pJLsPFhdcmPY+NVLhwnsi2RKpznVDyOKfQmHzrzMxH5c?=
 =?us-ascii?Q?GjS4k4M1tee3oGhE9VLdn0Y3oaXjf1t4H57yVxYMfz1WM5zDSLM3ULHLBOYd?=
 =?us-ascii?Q?B4EBYdGNAQDNug6uBCfOjsXHY8YGHmA0FvZTozoYUKKzjRm/SRZzwlfUCOAh?=
 =?us-ascii?Q?SChisPSjsLhDqZpokVYRBvb0PPvpQNteZl4O7pwh+6MAd58rbqfRVb/fiMSW?=
 =?us-ascii?Q?TKI4PS2A+eFZduwFSmkVX+XbPRx24SVNlYdLrUKM+mauc+VSOkkMQECPbCgr?=
 =?us-ascii?Q?ANuLbd1fy5NdTu2CBch3gZac?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f7b79f-d367-4664-467f-08d9088ad2d8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 08:10:58.8162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2Yjzy4NN3RGIDC9IbBO9MokhsDyBEi/K3ORZwjxO2tuacGIxE2yDBsZYTxq2HVCwu3Co7mHisk2G4Im4mmX+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB5888
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

initial DT bindings for Murata SCA3300 Accelerometer.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/accel/murata,sca3300.yaml    | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml b/Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml
new file mode 100644
index 000000000000..55fd3548e3b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/murata,sca3300.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Murata SCA3300 Accelerometer
+
+description: |
+  3-axis industrial accelerometer with digital SPI interface
+  https://www.murata.com/en-global/products/sensor/accel/sca3300
+
+maintainers:
+  - Tomas Melin <tomas.melin@vaisala.com>
+
+properties:
+  compatible:
+    enum:
+      - murata,sca3300
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 8000000
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        accelerometer@0 {
+            compatible = "murata,sca3300";
+            reg = <0x0>;
+            spi-max-frequency = <4000000>;
+        };
+    };
+...
-- 
2.21.3

