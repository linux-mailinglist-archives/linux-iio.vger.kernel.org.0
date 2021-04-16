Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20806362159
	for <lists+linux-iio@lfdr.de>; Fri, 16 Apr 2021 15:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244187AbhDPNrC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Apr 2021 09:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244143AbhDPNrB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Apr 2021 09:47:01 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A131C06175F;
        Fri, 16 Apr 2021 06:46:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNCE5qukEWAYNsmuy5MEdc12APzp+4qgIhqPcLxGajdBTE4Mmbl6Q/lQ0+ZfiF12OV2sv3ivFzB4RY/ZUtfVSfcjfwDbuy0S4pdXH70suqV/7IYjQHFoHMsqgnGqj90bCKyq9oTbKAnX8wsgokrGPa2fU8uH//c7dPE8MvX8DpWZclom8rcRKROD5FCXGjOxiKk9rdxkA+RJlslb9R9OdP/UYm69g2dxANawvxvbN9S6vBILKP6htJct6GvnFsC/bIusRv2ZKMepL56S4dkrH/9RGiIlphdORJ1hqPI+m2heYmFlwAplgKksuu75gmbh02912N4pwTyQrb6wfCNFtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTqYet08AnsFLEClw/ZSUfqPzh3OzYDkXNOVm2HKYG0=;
 b=WjgY2CwP61dEtG/OeA9FrcfXSLkwa7Ccc4cFnp7qtgQYeiS5H+alzNdJM0WTmNORXyDk8kj0rEOOPDTqexpCcpdIV4Bg3rQfHe0dAayNc1U52Rf1Z4sKyhs6R3ZUxrxNYWX/IQ67rMW0BIe3pFDNJ74kxatUKqAeRAz46JmqplvenhVBZFMenuH/8XFn83akABJJi+mcq4Tocb2l0bSoX0QUK67SjpnWbpkq5j6idd76oL/v94OtgEnPyJAN3uzsC8yC8oZpeNPGHSZmJQbhPUEE1eqq3LcLKGgx5gB794Zz862NOHlXMkQlGa5nqe7i1iHMURyMQ9KRuSA3gp7lbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTqYet08AnsFLEClw/ZSUfqPzh3OzYDkXNOVm2HKYG0=;
 b=VTYaf9oBK7+sbjTyNeXjMcdInr7+0wMFQLzIawgAx6aeiWDRWvy9AQvS5ZkQsYSojum5hb9kHNS+H72qVE2z2iRu0zPH5UWr4NG21ae+WIYixe3Rd2KoWi4o0lxOv2zvo5XrpHDXdnEliXcZQpMJR2Z6rxeHwLp4uFBGxg12caB4h9b37Z0wkZ9Sd//KRA23t1xinU6Um2UnsQzc/3zPrpOAI0Qr8zcVJ3DssXrmu6nC0O3obXqx+AtNm5qZQXg2x7NrMX8JX84SZ9BNFCccBCzYSMb6jWAUO9fQlFKjWp8qb+zvGp9K92pMzkRu8vdUUUEUpbdycY2Me6CvsSAu3w==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VI1PR06MB5568.eurprd06.prod.outlook.com
 (2603:10a6:803:da::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Fri, 16 Apr
 2021 13:46:32 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4%7]) with mapi id 15.20.4042.016; Fri, 16 Apr 2021
 13:46:32 +0000
From:   Tomas Melin <tomas.melin@vaisala.com>
To:     jic23@kernel.org, devicetree@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: accel: Add SCA3300 documentation
Date:   Fri, 16 Apr 2021 16:45:45 +0300
Message-Id: <20210416134546.38475-2-tomas.melin@vaisala.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20210416134546.38475-1-tomas.melin@vaisala.com>
References: <20210416134546.38475-1-tomas.melin@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [85.156.166.106]
X-ClientProxiedBy: HE1PR05CA0269.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::21) To VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora-vm.localdomain (85.156.166.106) by HE1PR05CA0269.eurprd05.prod.outlook.com (2603:10a6:3:fc::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Fri, 16 Apr 2021 13:46:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8492fce6-db45-41cc-04a1-08d900de0b88
X-MS-TrafficTypeDiagnostic: VI1PR06MB5568:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR06MB556829975F588292F17ED775FD4C9@VI1PR06MB5568.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UAjvt84YEhX24CWnrCPItbbcIlhah1ajXYYCNucag3oD2atBS/o0C/8UftrCDV22Ms5pQCZKSd/IAXl/JKTP2zuSjBvN4DCnqCQVqaRva2YgNO8+ZJHruYOw56YlMnYLuN/UEjLTRVUhK0O2b0uT1x37nOfzY7R/dePErK5d1r6n1ZD9bOEOey/ddV277e1AUSro9pgBCo8VYiNPq3L/C0qzWbEswzhZGARzxPOWTYcygpwq46Q81zLSolIqt5wwAtg9+FrjsZ/5dMpP2ncYzXLgjTvngUiJyFZ/YIkKS6qatVTcZ7iZibavChE8vbjOUIh93AGp6a0Y+AcUAreANUto8ZpVXta/PRmKYKTMvlOvzrOmY7ywpfWLmlcDtU96+VhB+au6k1FZYuNlmUGTkvCrBcOnVHSDCjVWa9Zf0bPN0Zd2P7J8rMcfLfhNKeX3JqeA0CbMUXJVu4gPGQths2qds7jFgn6/9dScY8CCQJtMj3C3IWsHg4Jdl96RX9r19l537cI4xOy9xoQj7CwmqIMf2s4hVTp38sEzC17QI92PY7HFfaDvnTyiF1Vt7ld1e71SirWAmyDxNGU5GX+/bZo1NhTuMgni8TYBq3U66mSX74sUtna0KO88x1OKWCiXdPi+xanJrkOs+guWcBqyIAmK2FdPjUI/oWULwB4fhSI/mqGnw5rL8jNFrT8feqLotJe/EcKNs7IJ73x04aemFaU4bN0EaowP7/FxhMApi8Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39850400004)(376002)(366004)(5660300002)(6486002)(66946007)(186003)(66476007)(956004)(66556008)(316002)(86362001)(6506007)(36756003)(6666004)(107886003)(1076003)(38100700002)(38350700002)(16526019)(478600001)(52116002)(8936002)(2906002)(966005)(26005)(44832011)(8676002)(2616005)(6512007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WNaEviIdCp1MI1WQ3EZGtWVSiCXY744kKdTOprid98Z2K9Ed1eORnpI6ZpkI?=
 =?us-ascii?Q?sSiSHZO4T/oNW30iUgB5+jhSPaYvm9eHxoFG2SUxLWP0ofpYlPE/wNJBBjxU?=
 =?us-ascii?Q?8V6KAVYVoMZMYxJvsCRHBoHM9Gccc6N+Cskhz607gzo9dz9Kig1ErLsxbwno?=
 =?us-ascii?Q?+PY34diK/lJ+YCBWKCE/XElIzrAPwzHOYj650idsYJlZ8X8SltUcyixotgX9?=
 =?us-ascii?Q?9FUqtzifQzVla38gXMqsS3I90h9qjFqKHkOrUju0+p59cKrT5Kn1FbnbZXnx?=
 =?us-ascii?Q?Kn3jKKxFfNPFGBDmVlmnnTS0H5hw3ScHdaw99Xq10lvrMjBeRicpdJLtmzSO?=
 =?us-ascii?Q?/cprxJukj+/9PqKaIehPSD9QGHWShZXXcW/O0dJg2DI2fZluqzi53xLrttwo?=
 =?us-ascii?Q?E4ryICFkksc4rOPzPUVEHsda1ceA8gLR5L1ZhDAhwGUGdfIngygXyyTQGNMW?=
 =?us-ascii?Q?z2BjVtrwkL62eWHNm39V3lZ5h23+VrhpQy92WD5jGAuLL2VNwYkzpBBNHAB4?=
 =?us-ascii?Q?m/YL/MmXWhLXBfk7+t1NVIH5qR/kad96I3Xco3bWudnhAn4RNb9bdzSZn2O1?=
 =?us-ascii?Q?r5j6V+ysR83WYFom1bnd4Gul4PYJzf8Xy7i4gPCiIQPwhqnszRqXNPA52usJ?=
 =?us-ascii?Q?TAxS3yVqDT12aQKfaM69/hSJSLDsQn6AbEz/I91eZd4QRCMG2woaYxp+u/TG?=
 =?us-ascii?Q?QAmTpxN4PpSObaAfyUKrDUN2+8S7rD/EQNagyF2RTdjrLS8yaU1AxB9N+q/d?=
 =?us-ascii?Q?tDM5VarpTKoncA5tyitOsBUPEC0CULUzsv9fsf0VqWQ/n2r6cD2KLim+Vipu?=
 =?us-ascii?Q?VYA55xy0mCbjQAr+96bjEe3CBkYotQVqw/0TgHy0Gdtse9kRnDEc/GcpiMN1?=
 =?us-ascii?Q?xs+If/MxAdtqvzZrfW+so383d5eey6ErDIC8LGYStclHEsD/ZbFq4rr/NqyA?=
 =?us-ascii?Q?kolFD91a3hzZs/PzJUbA8hn0JoyBJ5r7+jZtZzqSa4cKIX7llVUePq8++N+Y?=
 =?us-ascii?Q?bWoCHYaclWGIDFCKruxckC6iegL+uZe/m+D8W3g8uj1fy2If2L2EuhtBIt/0?=
 =?us-ascii?Q?iJvzN4EBQtPbuLEQ24I8SJLHs8Cgl2kUys0eQ8tYxIrcxyISfobhneeEXx0k?=
 =?us-ascii?Q?6qAHkZgarCw4ElBNfZ689Ij/Z3ambYctYhy4vlYljR2Lsi2piEI9BGj1NFX7?=
 =?us-ascii?Q?G2UbAq6nlAe+HLBFxruUIyLGcKdsdVGqOpCSwCVmwovA7zqjOCJNGkB4x8Xv?=
 =?us-ascii?Q?cJzHNIWH+vR+32df2CwwX9fwmV4Pgj9Hd5zMFr/kyFVU/w+Qg2hgq3hJT4GO?=
 =?us-ascii?Q?S8NKspdEUTniYned4pZtYw8y?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8492fce6-db45-41cc-04a1-08d900de0b88
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 13:46:32.7228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CgxbnrUTQCfrl0jAHflyUaqrqJaXDjMyvIEXZXTgYovv+fYKmbRLemFkVWVYXAlmM8y51iesHG6/z2xOZyQDFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB5568
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Initial DT bindings for Murata SCA3300 Accelerometer.

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

