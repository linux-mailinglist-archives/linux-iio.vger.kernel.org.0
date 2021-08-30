Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9C33FBAD8
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 19:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbhH3RXD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 13:23:03 -0400
Received: from mx21.baidu.com ([220.181.3.85]:33948 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238201AbhH3RXB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 13:23:01 -0400
Received: from BC-Mail-Ex30.internal.baidu.com (unknown [172.31.51.24])
        by Forcepoint Email with ESMTPS id 5E32773A4AAB5DD9560E;
        Tue, 31 Aug 2021 01:21:54 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex30.internal.baidu.com (172.31.51.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Tue, 31 Aug 2021 01:21:54 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 31 Aug 2021 01:21:53 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <alex.dewar90@gmail.com>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Cai Huoqing" <caihuoqing@baidu.com>
Subject: [PATCH 4/6] dt-bindings: iio: adc: Add the binding documentation for NXP IMX8QXP ADC
Date:   Tue, 31 Aug 2021 01:21:38 +0800
Message-ID: <20210830172140.414-5-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210830172140.414-1-caihuoqing@baidu.com>
References: <20210830172140.414-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex15.internal.baidu.com (172.31.51.55) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The NXP i.MX 8QuadXPlus SOC has a new ADC IP, so add the binding
documentation for NXP IMX8QXP ADC

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 .../bindings/iio/adc/nxp,imx8qxp-adc.yaml     | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
new file mode 100644
index 000000000000..542329e6a785
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
+	 adc@5a880000 {
+            compatible = "nxp,imx8qxp-adc";
+            reg = <0x0 0x5a880000 0x0 0x10000>;
+            interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clk IMX_SC_R_ADC_0>,
+                     <&clk IMX_ADMA_LPCG_ADC_0_IPG_CLK>;
+            clock-names = "per", "ipg";
+            assigned-clocks = <&clk IMX_SC_R_ADC_0>;
+            assigned-clock-rates = <24000000>;
+            power-domains = <&pm, IMX_SC_R_ADC_0>;
+            status = "disabled";
+            #io-channel-cells = <1>
+	 };
+    };
+...
-- 
2.25.1

