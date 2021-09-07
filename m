Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A8B402229
	for <lists+linux-iio@lfdr.de>; Tue,  7 Sep 2021 04:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242215AbhIGB6z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Sep 2021 21:58:55 -0400
Received: from mx21.baidu.com ([220.181.3.85]:57068 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241950AbhIGB6z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 6 Sep 2021 21:58:55 -0400
Received: from BC-Mail-Ex24.internal.baidu.com (unknown [172.31.51.18])
        by Forcepoint Email with ESMTPS id E8B0BA6CB2062E1B6BEC;
        Tue,  7 Sep 2021 09:57:40 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex24.internal.baidu.com (172.31.51.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Tue, 7 Sep 2021 09:57:40 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 7 Sep 2021 09:57:40 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/3] dt-bindings: iio: adc: Add the binding documentation for NXP IMX8QXP ADC
Date:   Tue, 7 Sep 2021 09:57:22 +0800
Message-ID: <20210907015724.1377-3-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210907015724.1377-1-caihuoqing@baidu.com>
References: <20210907015724.1377-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex12.internal.baidu.com (172.31.51.52) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The NXP i.MX 8QuadXPlus SOC has a new ADC IP, so add the binding
documentation for NXP IMX8QXP ADC.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
v1->v2: *Fix some indentation issues.
        *Mark status as okay.
        *Change clock2 source.
v1 link:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210830172140.414-5-caihuoqing@baidu.com/

 .../bindings/iio/adc/nxp,imx8qxp-adc.yaml     | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
new file mode 100644
index 000000000000..77501898a563
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
@@ -0,0 +1,85 @@
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
+  assigned-clocks-rate:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  status:
+    const: disable
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupts-parent
+  - clocks
+  - clock-names
+  - assigned-clocks
+  - assigned-clock-rates
+  - power-domains
+  - state
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/firmware/imx/rsrc.h>
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        adc@5a880000 {
+            compatible = "nxp,imx8qxp-adc";
+            reg = <0x0 0x5a880000 0x0 0x10000>;
+            interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clk IMX_SC_R_ADC_0>,
+                     <&clk IMX_SC_R_ADC_0>;
+            clock-names = "per", "ipg";
+            assigned-clocks = <&clk IMX_SC_R_ADC_0>;
+            assigned-clock-rates = <24000000>;
+            power-domains = <&pd IMX_SC_R_ADC_0>;
+            status = "okay";
+            #io-channel-cells = <1>;
+        };
+    };
+...
-- 
2.25.1

