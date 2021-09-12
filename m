Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5E3407C25
	for <lists+linux-iio@lfdr.de>; Sun, 12 Sep 2021 09:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhILHP3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Sep 2021 03:15:29 -0400
Received: from mx21.baidu.com ([220.181.3.85]:51464 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231996AbhILHP3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Sep 2021 03:15:29 -0400
Received: from BC-Mail-Ex30.internal.baidu.com (unknown [172.31.51.24])
        by Forcepoint Email with ESMTPS id D2FDB75AD39FE0707267;
        Sun, 12 Sep 2021 15:13:50 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex30.internal.baidu.com (172.31.51.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Sun, 12 Sep 2021 15:13:50 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.62.12) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Sun, 12 Sep 2021 15:13:49 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <aardelean@deviqon.com>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Cai Huoqing" <caihuoqing@baidu.com>
Subject: [PATCH v4 2/3] dt-bindings: iio: adc: Add binding documentation for NXP IMX8QXP ADC
Date:   Sun, 12 Sep 2021 15:13:33 +0800
Message-ID: <20210912071334.1745-3-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.32.0.windows.2
In-Reply-To: <20210912071334.1745-1-caihuoqing@baidu.com>
References: <20210912071334.1745-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.31.62.12]
X-ClientProxiedBy: BC-Mail-Ex29.internal.baidu.com (172.31.51.23) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The NXP i.MX 8QuadXPlus SOC a new ADC IP, so add
binding documentation for NXP IMX8QXP ADC

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
v1->v2: *Fix some indentation issues.
        *Mark status as okay.
        *Change clock2 source.
v3->v4: *Remove 'status' from examples.
        *Remove unused 'state'.
        *Remove interrupts-parent.
        *Change num of address/size-cells from 1 to 2.
v1 link:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210830172140.414-5-caihuoqing@baidu.com/
v3 link:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210907015724.1377-3-caihuoqing@baidu.com/

 .../bindings/iio/adc/nxp,imx8qxp-adc.yaml     | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
new file mode 100644
index 000000000000..8e16adf9a28a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/nxp,imx8qxp-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP IMX8QXP ADC bindings
+
+maintainers:
+  - Cai Huoqing <caihuoqing@baidu.com>
+
+description:
+  Supports the ADC found on the IMX8QXP SoC.
+
+properties:
+  compatible:
+    const: nxp,imx8qxp-adc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: per
+      - const: ipg
+
+  assigned-clocks:
+    maxItems: 1
+
+  assigned-clock-rates:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  '#address-cells':
+    const: 2
+
+  '#size-cells':
+    const: 2
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - assigned-clocks
+  - assigned-clock-rates
+  - power-domains
+  - '#address-cells'
+  - '#size-cells'
+  - "#io-channel-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/firmware/imx/rsrc.h>
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        adc@5a880000 {
+            #address-cells = <2>;
+            #size-cells = <2>;
+            compatible = "nxp,imx8qxp-adc";
+            reg = <0x0 0x5a880000 0x0 0x10000>;
+            interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clk IMX_SC_R_ADC_0>,
+                     <&clk IMX_SC_R_ADC_0>;
+            clock-names = "per", "ipg";
+            assigned-clocks = <&clk IMX_SC_R_ADC_0>;
+            assigned-clock-rates = <24000000>;
+            power-domains = <&pd IMX_SC_R_ADC_0>;
+            #io-channel-cells = <1>;
+        };
+    };
+...
-- 
2.25.1

