Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09B3F18BEAC
	for <lists+linux-iio@lfdr.de>; Thu, 19 Mar 2020 18:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgCSRrQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Mar 2020 13:47:16 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:37700 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728114AbgCSRrQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Mar 2020 13:47:16 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02JHd8Pr016532;
        Thu, 19 Mar 2020 18:46:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=oXNrCInOKbWks9uJELVsod6DJLx4EuXuc92666BUHsg=;
 b=joiRPfWQ3YTPizPjgewsnfWMlRMJgf9xM2g+O10bOzXQkut+CiKD/ghpy0SX4W/0hFNs
 6SPcYpUfV6hTd1HC1Jh585SCZafcNzTqjGqgAvHy0K4ZcxWsGgwPK06ScXR0WZiLkgWh
 P8asSmh/YZ+6RVlKkE9DSTW2XVUEw48aLNeO/Mmxtvqd3mAHaN1/ssSpjgBu/LhfbIW2
 a+vlC5d/y9jeXCp5AuwaCIR7DTRsxbzDNz1MsDeWaiNixgkicUIssL4HcL+l6SYDW52G
 PndouZu3/uGfmA4ROdoSrP7D23gbdWeI1VodeKkKxrkVYyzr/hXwtFMAYLiwXNnI+q6f bA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yu95uu1ay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Mar 2020 18:46:46 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0D2E010002A;
        Thu, 19 Mar 2020 18:46:40 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C88F42B4D56;
        Thu, 19 Mar 2020 18:46:40 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 19 Mar 2020 18:46:40
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <robh+dt@kernel.org>, <jic23@kernel.org>
CC:     <alexandre.torgue@st.com>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <fabrice.gasnier@st.com>,
        <olivier.moysan@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] dt-bindings: iio: dac: stm32-dac: convert bindings to json-schema
Date:   Thu, 19 Mar 2020 18:46:23 +0100
Message-ID: <1584639983-31098-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-19_06:2020-03-19,2020-03-19 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert the STM32 DAC binding to DT schema format using json-schema

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- Fix id relative path/filename as detected by Rob's bot
---
 .../devicetree/bindings/iio/dac/st,stm32-dac.txt   |  63 ------------
 .../devicetree/bindings/iio/dac/st,stm32-dac.yaml  | 110 +++++++++++++++++++++
 2 files changed, 110 insertions(+), 63 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/st,stm32-dac.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt b/Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt
deleted file mode 100644
index bf2925c..00000000
--- a/Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt
+++ /dev/null
@@ -1,63 +0,0 @@
-STMicroelectronics STM32 DAC
-
-The STM32 DAC is a 12-bit voltage output digital-to-analog converter. The DAC
-may be configured in 8 or 12-bit mode. It has two output channels, each with
-its own converter.
-It has built-in noise and triangle waveform generator and supports external
-triggers for conversions. The DAC's output buffer allows a high drive output
-current.
-
-Contents of a stm32 dac root node:
------------------------------------
-Required properties:
-- compatible: Should be one of:
-  "st,stm32f4-dac-core"
-  "st,stm32h7-dac-core"
-- reg: Offset and length of the device's register set.
-- clocks: Must contain an entry for pclk (which feeds the peripheral bus
-  interface)
-- clock-names: Must be "pclk".
-- vref-supply: Phandle to the vref+ input analog reference supply.
-- #address-cells = <1>;
-- #size-cells = <0>;
-
-Optional properties:
-- resets: Must contain the phandle to the reset controller.
-- A pinctrl state named "default" for each DAC channel may be defined to set
-  DAC_OUTx pin in mode of operation for analog output on external pin.
-
-Contents of a stm32 dac child node:
------------------------------------
-DAC core node should contain at least one subnode, representing a
-DAC instance/channel available on the machine.
-
-Required properties:
-- compatible: Must be "st,stm32-dac".
-- reg: Must be either 1 or 2, to define (single) channel in use
-- #io-channel-cells = <1>: See the IIO bindings section "IIO consumers" in
-  Documentation/devicetree/bindings/iio/iio-bindings.txt
-
-Example:
-	dac: dac@40007400 {
-		compatible = "st,stm32h7-dac-core";
-		reg = <0x40007400 0x400>;
-		clocks = <&clk>;
-		clock-names = "pclk";
-		vref-supply = <&reg_vref>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&dac_out1 &dac_out2>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		dac1: dac@1 {
-			compatible = "st,stm32-dac";
-			#io-channels-cells = <1>;
-			reg = <1>;
-		};
-
-		dac2: dac@2 {
-			compatible = "st,stm32-dac";
-			#io-channels-cells = <1>;
-			reg = <2>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/iio/dac/st,stm32-dac.yaml b/Documentation/devicetree/bindings/iio/dac/st,stm32-dac.yaml
new file mode 100644
index 00000000..393f700
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/st,stm32-dac.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/iio/dac/st,stm32-dac.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: STMicroelectronics STM32 DAC bindings
+
+description: |
+  The STM32 DAC is a 12-bit voltage output digital-to-analog converter. The DAC
+  may be configured in 8 or 12-bit mode. It has two output channels, each with
+  its own converter.
+  It has built-in noise and triangle waveform generator and supports external
+  triggers for conversions. The DAC's output buffer allows a high drive output
+  current.
+
+maintainers:
+  - Fabrice Gasnier <fabrice.gasnier@st.com>
+
+properties:
+  compatible:
+    enum:
+      - st,stm32f4-dac-core
+      - st,stm32h7-dac-core
+
+  reg:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: pclk
+
+  vref-supply:
+    description: Phandle to the vref input analog reference voltage.
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - vref-supply
+  - '#address-cells'
+  - '#size-cells'
+
+patternProperties:
+  "^dac@[1-2]+$":
+    type: object
+    description:
+      A DAC block node should contain at least one subnode, representing an
+      DAC instance/channel available on the machine.
+
+    properties:
+      compatible:
+        const: st,stm32-dac
+
+      reg:
+        description: Must be either 1 or 2, to define (single) channel in use
+        enum: [1, 2]
+
+      '#io-channel-cells':
+        const: 1
+
+    additionalProperties: false
+
+    required:
+      - compatible
+      - reg
+      - '#io-channel-cells'
+
+examples:
+  - |
+    // Example on stm32mp157c
+    #include <dt-bindings/clock/stm32mp1-clks.h>
+    dac: dac@40017000 {
+      compatible = "st,stm32h7-dac-core";
+      reg = <0x40017000 0x400>;
+      clocks = <&rcc DAC12>;
+      clock-names = "pclk";
+      vref-supply = <&vref>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      dac@1 {
+        compatible = "st,stm32-dac";
+        #io-channel-cells = <1>;
+        reg = <1>;
+      };
+
+      dac@2 {
+        compatible = "st,stm32-dac";
+        #io-channel-cells = <1>;
+        reg = <2>;
+      };
+    };
+
+...
-- 
2.7.4

