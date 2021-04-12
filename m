Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B40B35BB4C
	for <lists+linux-iio@lfdr.de>; Mon, 12 Apr 2021 09:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbhDLHv4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Apr 2021 03:51:56 -0400
Received: from mail-eopbgr60047.outbound.protection.outlook.com ([40.107.6.47]:63973
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237016AbhDLHvz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Apr 2021 03:51:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsxSWJQo+3VzTugBRa3xUXEOBGTArmJlAfCEdJnoGjZGxa7M9/bU+n2/VZAjyZflsjxnxfpIDo01dklD6ulttcYmsTORMucWlKT46M+1qHEEFgTfyedYFD/io4KqYdzzT6/4Ne6zm2+mdDI7WZn51lXKVHyQFFva4AuFd9hODNHoVbWE8vCnTDAuDzwW8Ck0qF8MaJdFP7BrDz0p1qilVmNq3+IFJDysfkuKTfRwG+D5MZo5yBpu6U0NaPeHPOWEyjDL23kKR2FJxVkE68Oh2Cn1riSD2XdX6991eAOa9iNEz4w8KCjIYi6YHPSj1p3T8z8NMpgODULv0TGuohZCqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SX9oh5gy3LfXzyQ6fhEyCO3uH65nga9j2krrrrmUHwY=;
 b=Z7odictYiz1cApY8ku+Bb3rowE+C7LEmj4r1W2nsUpsmN7b6YsOUyyi/qIvwuSrVIx8tudwBzXBo6D/YB+epyw8nad7mwN1GWEXneRkc4a+XEuCAS2eqwOmWPA7kCyRVZQf1QY6SC/2gT8HPhTwLaVHIobobmWJDyMLRxA02FGY1F5WiRn4NKaAvC1yGOrHjd1HHuwW4GnXsyo4YWUvVfc2iae48KGWQLKr0raVWwv7J388znSPF3BCsqgT/F6huZiVhSkT4pI/ZWrLKc6oMIxo8Mz43qsj68ih3q568gtJib0PwGhQnSOXGGv8juU9S3itjmsXZZDPv9SJJLSI7ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SX9oh5gy3LfXzyQ6fhEyCO3uH65nga9j2krrrrmUHwY=;
 b=3EVp2NUVly4IP5YhFUPSymUiK7iMzk/1/8n7g+UWbQIAsR8pcKwUumySvgtqwrjRtv5GyRrmTrQD/vkSsNJ0HlkkJS7dxQkFAuP4ZTG8CJ1Ez2IvWahfuURQnAWlH6QlwQdT/tCjDrCV8C4OC8BD8EyarYW/UZmtx1I1KgjKKfAQbQEiKY5Ws11bUmh4YdtfyhrEdM0kR9LKgT+Yjf/5yJJaGJFvfdIaWxKVAY9HoRrknGjUbcBcmUwq6QFmSrmf2Jijq03qPYIUlpnuog5QwBC7MWFZNBu7EHNCyuYIp2sKesvSTzOEZ6Is+beF/YFjdlTBQMNi373JvJ+huAKX0g==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VI1PR06MB6800.eurprd06.prod.outlook.com
 (2603:10a6:800:18c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Mon, 12 Apr
 2021 07:51:35 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4%7]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 07:51:35 +0000
From:   Tomas Melin <tomas.melin@vaisala.com>
To:     jic23@kernel.org, devicetree@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH 1/2] dt-bindings: iio: accel: Add SCA3300 documentation
Date:   Mon, 12 Apr 2021 10:50:55 +0300
Message-Id: <20210412075056.56301-2-tomas.melin@vaisala.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20210412075056.56301-1-tomas.melin@vaisala.com>
References: <20210412075056.56301-1-tomas.melin@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [85.156.166.106]
X-ClientProxiedBy: HE1PR0901CA0054.eurprd09.prod.outlook.com
 (2603:10a6:3:45::22) To VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora-vm.vaisala.com (85.156.166.106) by HE1PR0901CA0054.eurprd09.prod.outlook.com (2603:10a6:3:45::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Mon, 12 Apr 2021 07:51:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f69566b-6080-4de5-8bb4-08d8fd87cb97
X-MS-TrafficTypeDiagnostic: VI1PR06MB6800:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR06MB68007C1FF6976E89154DFB8FFD709@VI1PR06MB6800.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VGvoBFUOFbO8nwcy5k0lkCTD8gErGrWNbuwNOTJyMVLLIdfc3711Shw2Z9ma1HjBJ2Fh9IAzSUrMh6NXV/Cl5+0CYCD6boXAKLV3lNRM65ciVGfRrioJ+m2tJTXYtSIiEuDyCIFPP1l04COF7jNeOoHCPNm3ojrWZQfpca+oevZ9XasLO2YsO7Akjk10Q7ScHk1GiOqIcwwuVLklSqgm9ZPsl3itsC7BR5vdRoK2jsntPSj+kxUQsXgtxdU9zwTPiPyRcxIhTZGFWHzHfrpcjV01+vR9utajydmtlnPjO9CAiYQXGV1dG8tbb+P6NjHXuGtdkoJZjNcEWypD99gA+p8HZJNCEH+oDCDlUcflW/iPeQRN2CfWiQ9Tfhb2WoXeMVBEGHIJrLUQv+UhX/9AeRPAygEgbPTayOn3uQIV1B7/8aP+bxcWBNT0sgeVqMZ8WCQoplSN8flpTcLjvgk41Lj2vr5Qv1wKHgQ22wf8ygD2/P01FypYBXsKA4dYyPho0b5qj06kweVxhNpH9VhGd7e9HoN9NkbKddE25DH0RDZidDOHEwX7Ehch27fezE08UvnjT4ZcBVXVutiVLm/saEeW1y4eLOIwR2qOdz1L+76XJIWTBydhbdhprNPnnx5otw8Nlv0f8tlXufpx26UVh1hoaYtdf8UbMqE/UjE5uxzImppnz4z/hg/86b3+MNerFrMkpWpvrj5XgZSRes3qxoxSx4UOfTV0UzLl5IqRksI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39850400004)(36756003)(8676002)(478600001)(8936002)(6666004)(5660300002)(1076003)(38100700002)(26005)(38350700002)(86362001)(6486002)(966005)(316002)(4326008)(66946007)(66556008)(2906002)(956004)(2616005)(186003)(7696005)(44832011)(16526019)(52116002)(66476007)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ky8ezVgsRgYsgopbRftdVs2F9i/5NXNURU8WKmOEvVbwuZEljGTM5tHoPNAs?=
 =?us-ascii?Q?xF8Gmg35y2WO8HX4/9a1mOJITEwkxRLeWZn3XGQVxHkfkGKStR0nMFZwbDD4?=
 =?us-ascii?Q?Z9qJih1ZBZ/bq7vniddzIw3R3swYqUnWNbGGxNrqaSRbeRA5t8fAxGYLl8ja?=
 =?us-ascii?Q?ZxTGwOYJcxj4IjSppwrEzRd2i+aAnVOnhb1mCENoRwrWYX2jTJA77Oq9MtMO?=
 =?us-ascii?Q?LLgkDqX2kqShIsbv9F0lBsOAtr/gKugVRI9ce2jyPBSenHV8pDE0dCrbVr6Q?=
 =?us-ascii?Q?bVa1wVIatrI5kEZNnc+e8AfD+LZJ1RQ9S/A0N67IL8k8Y4E86zvmej7yvhIU?=
 =?us-ascii?Q?YdFnR6r5756qfOlqwi/io9PAmdKNBONryENg2YLmsm+2xNzyKQA2lsDC+gzG?=
 =?us-ascii?Q?qOgrFxZDlzh4YG5/p44kvVKVgmTejgKpYSXW/m3huovU8U9gBUw+JSzD8BqK?=
 =?us-ascii?Q?O3YWCt3K3FfN5x4nsA7GrGkVBsjMMedZiBHKktwLzEoDsXjnrnTElGphs9zx?=
 =?us-ascii?Q?01Ns7d/PP/VZ7MTmXFLrFgsLe+Yi+JHR//UAhPUwSxs9ceBDnsDZinstZatM?=
 =?us-ascii?Q?UkigIqKecsfD0A608focRipnncpfRTVpQgTUac2ebS04mVXvdJbmoQ27TxBS?=
 =?us-ascii?Q?fUTXH8MS7yVXOCD7WwwTMtkiHGol5c1REP/axCFKVsC6y+cvWj+0bent14oX?=
 =?us-ascii?Q?tB50E8mCxlfC0KQQzaAomdbr4YaRJY/zhs9nEH7fNSTiCvGf0TYpJO3NpVjr?=
 =?us-ascii?Q?R5OUOAndUjtWuWTsrKd4TxaD9ivbpPkNVMicub4emgLdjVPO48YxTRu1KVtW?=
 =?us-ascii?Q?y/qzLlOooXkPw8Cmgc7ua4JvENKVOfU1bXv2O9Qw3DUP7nbczHFm7bl9sjO/?=
 =?us-ascii?Q?fJKoKx4tm39HqpSR/xUBrorrufUhuCwNH1IoD+BSRX1EG6AkfFW2nvRbONir?=
 =?us-ascii?Q?tBBMJ5ictfxVACaFNaR+jTDT3mY7Yjeuzc86dRAlBCtD4FBpMo6BzIgQgt8z?=
 =?us-ascii?Q?TBZ3dtp1WxIdBXkhYA9Xx9NYtnFle8KfucACn6cAGWoO7WwUGmd+/bsDhFiE?=
 =?us-ascii?Q?v5YKf5A5cen1bIO5jSlzN6bs+NwoampSjM1g/t7jGSI4j7Mqcgz/B2Dx0Abr?=
 =?us-ascii?Q?dt8F+Y+K7CheskHOfWmpdThYjtOGxBMj/At0j3WDxlKPrse8lfcj830QPrxV?=
 =?us-ascii?Q?zGVf93vki+OFrQKJpMX0zOeCh4tcHa5U3ACdyOHiIpBjgced9iYO6XeVF2rd?=
 =?us-ascii?Q?Y8nNAC2BhFawYtvLwS5hsBijIofJeTaBn2FYVHySMutlTq7nSFypC3zdYR3g?=
 =?us-ascii?Q?ibXU1lxa4fehZQ81DXFK4TRh?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f69566b-6080-4de5-8bb4-08d8fd87cb97
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 07:51:35.2793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJ5JyjmWo4wetT9CXVhD8OH14Gs03C1luTLwRKxhgeIL6nBOVSZ930C8tnNi1IFsNnTBJj3qXXDOAl3tcBxC1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6800
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

initial DT bindings for Murata SCA3300 Accelerometer.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 .../bindings/iio/accel/sca3300.yaml           | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/sca3300.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/sca3300.yaml b/Documentation/devicetree/bindings/iio/accel/sca3300.yaml
new file mode 100644
index 000000000000..32fe4b647cd0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/sca3300.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/sca3300.yaml#
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
+    description: SPI chip select number according to the general SPI bindings
+
+  spi-max-frequency:
+    maximum: 8000000
+
+  murata,opmode:
+    description: Accelerometer operation mode as described in datasheet (MODE)
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - murata,opmode
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        sca3300@0 {
+            compatible = "murata,sca3300";
+            reg = <0x0>;
+            spi-max-frequency = <4000000>;
+            murata,opmode = <4>;
+        };
+    };
+...
-- 
2.21.3

