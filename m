Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B91336443C
	for <lists+linux-iio@lfdr.de>; Mon, 19 Apr 2021 15:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241227AbhDSNZ5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Apr 2021 09:25:57 -0400
Received: from mail-eopbgr10055.outbound.protection.outlook.com ([40.107.1.55]:26603
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240166AbhDSNXt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 19 Apr 2021 09:23:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdIAOpkDH06C7jsbiZbOj1KNKRSqZTbjXcjIQw0wG19h1/1EioxkkKfEWS8yFxR0E85N5a5rgatPDAT8++AvQseroddi5DbNWyZ9/44MiLQC1/i1N4Zxo+H+EfIXlVbTL7dAVW/+mo6L7Fw/h6NvruwRxPWG5G38x8em5sXggR3fhaVQbidPSl2xTgw9+azUjOO5UZBv+DbT5dQ7s+rqo5lKUKIXjjovrs6pDWQSb4qwc9T8KYCW4AASbk7qftcU/oO+xANgWnMJNPkCyJj+ah4/u7LWtKWzeCePcstPJ93/VgaGEANqUeVrGni1RYzSevn5vVBqXfO2JlCwfdNWTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3GWXW0zCnyft8zBkB0j79N4qoghPeC0Arp1zz7GUNk=;
 b=je3hoFtE6kHv8ChLbIbY5v/zsu0u5MeDT7YsEDI1xt4TeF+QeYFkAwpqToYf2EcNdNrF9+VF6AS6uHKTPFxvn2kPTPFkW2QZInl8jUanWOO7ZuCBXTXPB9zZLNqH/FMiisDNGfi2pPcN8XOKPYzEIKkF0NpainndRGEI+lfnPfGMyGtbNL2dL/dRaiMI8ppVAPkIo/ewjnVXBcOihqSJfcuxH47Ekb1yfldjy0JNOQAXCUdZrlfPKVUaDseoWm3mQ5IbPu854wTU/Hk1+LHdKMGdxOwOO2ZqFykLlqiCQ+jKnfbn0KSsZH2VYmXMpHhqN73gNZaHlBU9q8zp0VlpjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3GWXW0zCnyft8zBkB0j79N4qoghPeC0Arp1zz7GUNk=;
 b=x0K/aS+ZX5x1vc2W8BslWD6Q+Wgrm1atIphw2U475HGNORFUhjcCZjppLCKvQfUCVPyAMKCdVZvNUrDbnJZO+PtfCrb9izJPpl/AmhsloPHFjsDFmYXh98UQ1CNcTOC1H4bSQDxv4RjTEh22HbPo/Qj4cwyJQV8ZHpatWazKrzlJ3aQegwq0m51HD/GhCf2+vPkDesUpz5XPownuJYUiSFWpYfkRt6FKi6t8CuUcUerDIAY5ojvlZ4ENufOnGP8RWQHxg18kfiAOAtMASnC06jp6J/FC0OyYtoI9lgpdi9lZPVJBB1/xE1a1lXhq05pLaYCbS4yYQGLCyjbcQfyBxw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VI1PR0601MB2109.eurprd06.prod.outlook.com
 (2603:10a6:800:27::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 13:22:46 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4%7]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 13:22:46 +0000
From:   Tomas Melin <tomas.melin@vaisala.com>
To:     jic23@kernel.org, devicetree@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: accel: Add SCA3300 documentation
Date:   Mon, 19 Apr 2021 16:21:58 +0300
Message-Id: <20210419132159.4450-2-tomas.melin@vaisala.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20210419132159.4450-1-tomas.melin@vaisala.com>
References: <20210419132159.4450-1-tomas.melin@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [85.156.166.106]
X-ClientProxiedBy: HE1P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::33)
 To VI1PR0602MB3568.eurprd06.prod.outlook.com (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora-vm.localdomain (85.156.166.106) by HE1P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 13:22:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce7b3aaf-b387-416d-459e-08d903363869
X-MS-TrafficTypeDiagnostic: VI1PR0601MB2109:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0601MB210926F9DA5D2E15A4F9AD7CFD499@VI1PR0601MB2109.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbdQvJNXTBWNZzKrkb2mIkqOVOxfPBOVP74rNanckdPpkSkovrkL4L89QQvv+wXrlszJtQzIX6md+crpBB7TmSDcFloM9HR9rp8vQ3YCDsu3mMPhDm7fvKdkmvM7msAyiG4SKEC9qw12L8Ppi3/ODD1cLfwyoFzXRh0t0rqM92LA7dzVITrWsfPf0wU3juIr6xnMs4pR60zXDMhWecD9G62V9rVC8O52nOLUH7xcTOQtLSaiwX7aeuavVaDX9EYGwJ+F6CJVdmGu/t5eyobLA4N7+7uLudGMyI58AXug65ebTK45fAwdYFbCVvesFEFhIIBUVbHMKpNKEWFXHXmkPP/JlmUxWxB6uuPzh+Q4EfuqNmZEQmtSrFcytq7llwEhgnUDmYvwkveZLrsokWnBNtvAm2l9N990aQnSDp/dsQsrqZDShmeJrHLPYiFP1IbEiIkizjadI7xD/ktrg2n2/fNwv9xHuRl7cfEaV9FqihiC4Hi6ZaNAkuvgtMWPwcbAnRaI80PouhzOSbUDNfildeDduOUBDsvIdihxbilKVQNxQS2savemL94TLMK2WdhQn4J7HDZyUXmTT88ItsNEv7cyjSirMxMggzkeXfCv8KOLpCOKxMf1de2YvP97LFNpbYam1GWHqWbhCHwc78GRoiz6bb4xhQ5IZVle+Qnz4xCmuO5VQR6nVMAoV7Dfc6KcPzMhoUFootAXMRrAYC8YA0A0RRJQHujWzZTwPbvapQ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39850400004)(956004)(2616005)(26005)(1076003)(86362001)(6506007)(44832011)(107886003)(966005)(6486002)(478600001)(36756003)(16526019)(5660300002)(186003)(52116002)(6666004)(66946007)(66556008)(8676002)(2906002)(6512007)(4326008)(38350700002)(66476007)(38100700002)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xhtK6/xjDrqk7oRMUFKs7u42MAb8R0yIJUxUQLqVlGdT0wdHB4+K8LummMmf?=
 =?us-ascii?Q?a+JGE72ufzFVc3lpl9yLiTds8Je+cKz9ITT5SMv8GBqr2tp4aSFz+jSYpVqq?=
 =?us-ascii?Q?qSacPl5DTMHpILIjX5OY4q+2a/8G9CebfLBFu7rIkVK7mQheMPLWBdn2fwP6?=
 =?us-ascii?Q?uR0Ml0HxPQaJM1vx88OD2s9fjiG+5r1JI0/hiGP70Fe4EU6WbekEDKCgKcuC?=
 =?us-ascii?Q?p6axu+WMqmYA9bGbCqw/1Vefn6PuSuyLlOG4G+c1Rig4NcE4Au7L0oVecTlX?=
 =?us-ascii?Q?CVmA3OcofkjQAC8l0lTgrry9Tc9DWLsr8TqxTs49mE2Q+3K6gRxh3V0FszUb?=
 =?us-ascii?Q?imQBpKosPS8+ftwMhemxERZblncOJLmWGdsQW8MkQxfbhetk6V35VFhTxpS1?=
 =?us-ascii?Q?V3WIUgTOUK5h50sQHarrb/kB28XUx9aLh1vBZqAiv6/g/hAmkhR43pKSR3xI?=
 =?us-ascii?Q?FLT/grjEbK42ghbMRAjuRYccNBuCCKx5wXHBA3FMmUZVfVMcj5ljaPXc2OYm?=
 =?us-ascii?Q?FT/djUrZ/MxMO3TnNWxcCaoLpkDWd07x+Lrun81wrIyRLAY8SgnL3rk1jguQ?=
 =?us-ascii?Q?xw5m9rDmZDwd4TkK+wErq5IO+pOmPoETsAhVPLS6QRmfrpHerP1gH12LYFlW?=
 =?us-ascii?Q?ys0YNQ7/t5L/sLE0AyeZwT/Vj8r46KcMHTLkspEURnyKXRNVe9ZIxVrN9yYX?=
 =?us-ascii?Q?Vk6WLWld8KlBN0eg2s8DLGzeGidJwxz16XGTPJDPZc4tquUqjwF9uC4xXwiv?=
 =?us-ascii?Q?T7/ZX//QD0IDiVHfC5ne8SPkDP1TjyqfYXDlBbnccZlaZ/bu6ZnqzGhWJ1Zj?=
 =?us-ascii?Q?k46qX8a0yfX1/X2ubEofjxgzK/M+yqrNlPD84uuHsfmG7Ko8DpIetEpZYVoK?=
 =?us-ascii?Q?21qRnz+px72asqHP+Ontr+gnVIuwTlmH6RldXM8JNuX+0l33vus2CNRQEFGF?=
 =?us-ascii?Q?H2fox13ZxepSxf/7O5eE7xJjJmOBt8DA0UqR3IWG7t/jRdW4xg7ZAaSkgm2e?=
 =?us-ascii?Q?WvuraW9MbeErIEi4xEEPfEphkoads9S51e7AUh8bxA0oqvRO9y3Xn2MCQ9EF?=
 =?us-ascii?Q?hdckU/SwB0P6Y1kBPdqW9rWu4qr7k0XCh6Grev2rWeppoQyVB8eI/ronfhhm?=
 =?us-ascii?Q?aqwJvCPz7vISP53x0AypV8R7BuKC7U2Aq6JZxiDnIGtHFnuJc3S8DMuxI6gm?=
 =?us-ascii?Q?M13+4bGnvctEjJNth0qAWlH+QsSpmr+VDG/vWJobh5UFwREUo2VnUAW2Rthp?=
 =?us-ascii?Q?l4/3LgBZSaBpw/cOOA3DzSi/11pq92RwGjQki3x+7xG5v+8/gktgjDyv1do2?=
 =?us-ascii?Q?+p4BAVW8UogzR5LR2uJMYmnn?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7b3aaf-b387-416d-459e-08d903363869
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 13:22:46.0975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9uw9O0Gxog3ipEnX//9JAxrPdv/7uUKpcocnCF7YcxRe7vXY0PgLUU+V1kXwkD3uCPFZB8G9a60o0fs94TZNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0601MB2109
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

