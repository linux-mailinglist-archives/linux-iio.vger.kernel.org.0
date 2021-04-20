Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C742A3659E5
	for <lists+linux-iio@lfdr.de>; Tue, 20 Apr 2021 15:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhDTNYi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Apr 2021 09:24:38 -0400
Received: from mail-vi1eur05on2079.outbound.protection.outlook.com ([40.107.21.79]:25344
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232034AbhDTNYi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 20 Apr 2021 09:24:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyTH3xtnMH6UHjHnbNqi3ZAjnbpn8Cpe+XJoxx+ZnggNEDfKhrFdxfO18aKFNLG8TQByGSSPtOuGU+Biwg7tz9PNMNL93+1dE6fWbnuJRHBzk7clMepATGCMIH1lFX2b7kUg9KuWyORGoBekY5M2hyxuAto6DwHpcFwP4hkckcIs+1a51qKJz/JKcwKcJ4e7JIjx6JoT/V9kUXSKpKOA5rzlJHlqaU8tOva7jhNHlyIMY3nuE9jPIwZhiGDfhTNeCm2P1Erv1aWhGz/2rMoKIvG6MyM2jom3M6+XmZJSUpLDkAvtC+xRrppuWtN3F6OMeROENYlwKB6ow1jReBdniQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3GWXW0zCnyft8zBkB0j79N4qoghPeC0Arp1zz7GUNk=;
 b=X8TywYZ5Gga2HYtknCqyU5te49RjDPD+ZGPJitvw/hAHXVnzzVneTQpngSrxF9/cURUYO6BqCTOUzXQppAwHQrd2PzaDBQh/0FQCSUcB0p6OqNPh8JYjgAOoxbFpLTgf2vLsw3kQgvS0b41MtMalLLqThfRqqLkOWMD5kvYdFJhw06jAb216z72RHGh5BSOG32WcI01wuaJzg8rqeHmgS+tD7bHBXb6W6jXUBwHmgCwwJaOkC5YhoIQmJ2JcblemdIW5M/LSTWIm1gSD56RZI72tvwud8AYvo+/NzQsLrWjrwsB1w5a//MaznPrvycArN/yYLcoXViWqd7o/KDgnFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3GWXW0zCnyft8zBkB0j79N4qoghPeC0Arp1zz7GUNk=;
 b=xbPBr+zD6KOdcyMXD7cEAeirJzDUVyZ32dnZhu0CWtfZf264FZ4wEwiXsxCgOkb0SAAId7IxunlZRj3SC2Vyp6UMK3XtaDT+y2ZGE0/29GV0Jz+GYbJNk7C1HCg4tHwEQW+ZRE2GVMyTEmYsLJEOODVOuOqpl8Za+3IKsHGaY8IFVjL9Ip3NWT8UBxTzEBKNPfp5o0M/FqWhIA6N+3gkb5B3zh5AicwRmXBcV+E7nBIPyzikuKrb7oIEjtwS/1BB1/gSgal7ojHRYHPHSxgsA67QHPLkWGWOIzA6GRpShZ0zzUhDyWZ9okBm1dmEQhBurhAe8No3kyZzfXZnA5XL3w==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VE1PR06MB7088.eurprd06.prod.outlook.com
 (2603:10a6:800:1a8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 13:24:04 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4%7]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 13:24:04 +0000
From:   Tomas Melin <tomas.melin@vaisala.com>
To:     jic23@kernel.org, devicetree@vger.kernel.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH v4 1/2] dt-bindings: iio: accel: Add SCA3300 documentation
Date:   Tue, 20 Apr 2021 16:23:32 +0300
Message-Id: <20210420132333.99886-2-tomas.melin@vaisala.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20210420132333.99886-1-tomas.melin@vaisala.com>
References: <20210420132333.99886-1-tomas.melin@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [85.156.166.106]
X-ClientProxiedBy: HE1P190CA0005.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::15)
 To VI1PR0602MB3568.eurprd06.prod.outlook.com (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora-vm.vaisala.com (85.156.166.106) by HE1P190CA0005.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Tue, 20 Apr 2021 13:24:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33ccb593-b778-4178-1181-08d903ff9199
X-MS-TrafficTypeDiagnostic: VE1PR06MB7088:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR06MB70889A933980AD96BB2783B9FD489@VE1PR06MB7088.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rF4KfuzFiCDpyCgiXo3hy+3t2R0nnM7u8MxT6P2Sqla4iqmQPiZ6q6eeGh7PBt3XJbvXxHBeIKgLuoo76xXLG2pwAnbLS0vQ1wsjAKALbVXYfX2pb5i49ar/1t8DcahVRa66j/u61NBwCrM0wtl5JMpO+tts7V2Fc1RhbES4+h4xPEcQZPhf0v7xev1KM6rMjhuyksdsNkRZTVtZMIK0Y1g5zyYiW1fU65cv9xxDUwTLnzLH4TJB76h0JuIvHTwIJ6MOt0OvWi5QSRqLIEJWb3CPgUlGbz6T4DRGVSp4KJYKcZweXCDk4YYWNJSQKZyEVikqfTqHHf86teT1Zz5VG8m6GrDBBXUUV1HS6B3Y3dDbYF/+OICLMMP4vBo9YmB0XIVgQe28Rnf3TDxXgnCggTMqM9virlHK44qzmQTPei67EBEGyU7r70zh21jF+IEMGdBhYLgfD3KyrwJGIJKV9ebaOx+CYL3QpVNO91XHcHXgWn+ffG/BBSJVm4ihYFJAvqhzrKYgL/VImfhxKGtrdhtxezg48swb6xsOQRPWYC1KqGJ8ISCOQipi2bAm7ORaxrU/9IONvXe4xFKKgNh3helKh1zzGP90gVs+Xu/sDRrJnwwYJdpDOh/uwwIkmcRT43CBu9Z7sV1cR8NY83DH20FB7VZBVmLnjwqFH72p+118ntEzVAe2W7tiyulu65epJMjsB7nljZo8iN9LE/cN74y1zW+QzlB6mnpztn0ZaA0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(8936002)(66476007)(26005)(86362001)(66946007)(66556008)(4326008)(498600001)(38100700002)(956004)(186003)(38350700002)(8676002)(966005)(7696005)(52116002)(2906002)(5660300002)(44832011)(6486002)(36756003)(6666004)(16526019)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8s675m03c7Gq7+GwfAMAI7wr0G/GHpgxJU2aAw/wkIYIkymkUdT6JB02WnpI?=
 =?us-ascii?Q?gjoUqQSspf7AbGZRQEGLg1wMVSZML3XM2CcZQo157q+Ru0xLxEt+oLSOcoRr?=
 =?us-ascii?Q?cZvx19vxENm2JO6DXAVJIrwYhGLoW7KFZt5hQwbl7BMiN/BjnTGthWpGdt32?=
 =?us-ascii?Q?LA/QVp/947f3c8fQW3RPcmlXPXiKw4jnNLj5dC4aw7QjJ+5i7cafHPr1x9ol?=
 =?us-ascii?Q?CXHFJY5tKrmsAfUDuTFUVzQnWN9UWgGslYdsB+jtMMh9CcDBW/hXceu18G5K?=
 =?us-ascii?Q?A+SjPsvNdggdOQSX61C5Zc3jPFQwGwaU0y0ohOTFM7Tht31Jj4MkeSi5P7aX?=
 =?us-ascii?Q?SBvXT9XIsktylrILYE/0X/HhCqSGL1qdzKeu+T6+4qxGOlBVZ9N5ctVEYY/2?=
 =?us-ascii?Q?xZpiyN8qyBqBS0iWc3jeftQj53vyOZ8YNnvc1T8YNdSQHpj9e0vv1vBxbBlA?=
 =?us-ascii?Q?1s+eO4LxHBJN5iJL33lkeK0a+ye19uBAIzBOkm7pekSxVXIdfefh7QY/1mta?=
 =?us-ascii?Q?4wCnJss5n713GYJ2qX8LEpUyJJMBBi1wTGEwZEWJnrt29+ssnviyHiYK9r//?=
 =?us-ascii?Q?h8DvrIRoFe8Yg2kFdblHaKYdKM/W1tABGMBZCtw9+r0ojATGfvmLh6KaOcNs?=
 =?us-ascii?Q?wyrktjOIeqmHHfx3d77ew4lwrt6Z+m/G9D9Re9kjyff2vCcgrrc+op/b3FCM?=
 =?us-ascii?Q?NSgNqMXVTSaQRu52OB0V5e33C1VVDekPQrGKlFXOWLSmCv9yDcrom9aB/gTd?=
 =?us-ascii?Q?0oNST6QxJatvJZHXfBsC3uUGcCWOU2oBCekS/uc6SeEPikFZ7lQeODYL/8Zb?=
 =?us-ascii?Q?hdnT447n9SAMt28YxZsyzafBnvDfVcaJuJHhj1tmxfX2XNNVbF18kT64C6Cu?=
 =?us-ascii?Q?hFOaFHDmwzFeVrtTkDL8ISqfNwn6hX6JOuLiMOBFsvPYJfTd65Ob29mRBopo?=
 =?us-ascii?Q?b4g7oKqa3u7Q9lVhsbXS13VFhnqvVpMYl5Z1huQHjUqQv/HTG78YcDsvBqon?=
 =?us-ascii?Q?dP1Qn5U2I2y1sh8jWQtZMp/22vHflgzbBdPUcXwJP8ecTe/2nR9LNPm+NLhB?=
 =?us-ascii?Q?GhMwf5uhvTtSvAo3AgLeGraIOOij27NTRt+YlS1gyG+Ki/xNLglmjf9Mt4wP?=
 =?us-ascii?Q?akz/tr4X7LyaN+A1caVZkPbioFhUpuCcUkNE/jd3xvjzRBOLrCuRzO6JR5Z2?=
 =?us-ascii?Q?P+j3EIA6Wxxmoas19RmedmY/ulyTtyqknYq8g23KIY8qEaOyiOYzwqrn5pn7?=
 =?us-ascii?Q?scbu8T2a/6fq9iv/BN9b7aTGU1HWfW9H/7wR/ZO0RjTbkkv5LBmicx1nL6P4?=
 =?us-ascii?Q?Emdj3H+Oc33RWXR4yWdpCqvm?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ccb593-b778-4178-1181-08d903ff9199
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 13:24:04.5656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VO0m060+KWx4X4s5wNtsSRvPNTn7hoXU1dCszjPeOzCmHb2cdyHZM3Of6TucAeGYh44+/KkTa/5h36VhyrtJHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB7088
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

initial DT bindings for Murata SCA3300 Accelerometer.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
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

