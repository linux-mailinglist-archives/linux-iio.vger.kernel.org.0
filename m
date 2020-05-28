Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E1D1E67DF
	for <lists+linux-iio@lfdr.de>; Thu, 28 May 2020 18:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405231AbgE1Qzc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 May 2020 12:55:32 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:26957 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405242AbgE1Qzc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 May 2020 12:55:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590684930; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=8GOA/5BmC3vORT2ziXzTX02X+aOMqRbNdgBUgtNnD/8=; b=LgkXFobwmMFJtt/oU+QvHKmU+ZjarPBkV2VWSrG5TaVUBwDULD/viyXcbXjzg3afeNfM64KN
 nwDTQfQe9mIMSL3gaZHT5xYeIcyCXEtDExAGjGZniqk5jc+XKmC+C68TtOGeH5FqmS1JJz+t
 XD2m6yahL3WjzCku2xBXSjEcIx0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5ecfecebea0dfa490ee8a3d9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 May 2020 16:55:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 484D4C433B7; Thu, 28 May 2020 16:55:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jprakash-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D1C2EC43395;
        Thu, 28 May 2020 16:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1C2EC43395
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jprakash@codeaurora.org
From:   Jishnu Prakash <jprakash@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, linus.walleij@linaro.org,
        Jonathan.Cameron@huawei.com, andy.shevchenko@gmail.com,
        amit.kucheria@verdurent.com, smohanad@codeaurora.org,
        kgunda@codeaurora.org, aghayal@codeaurora.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Jishnu Prakash <jprakash@codeaurora.org>,
        linux-iio@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: [PATCH V6 1/7] iio: adc: Convert the QCOM SPMI ADC bindings to .yaml format
Date:   Thu, 28 May 2020 22:24:23 +0530
Message-Id: <1590684869-15400-2-git-send-email-jprakash@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590684869-15400-1-git-send-email-jprakash@codeaurora.org>
References: <1590684869-15400-1-git-send-email-jprakash@codeaurora.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert the adc bindings from .txt to .yaml format.

Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 173 --------------
 .../bindings/iio/adc/qcom,spmi-vadc.yaml           | 252 +++++++++++++++++++++
 2 files changed, 252 insertions(+), 173 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
deleted file mode 100644
index c878768..0000000
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
+++ /dev/null
@@ -1,173 +0,0 @@
-Qualcomm's SPMI PMIC ADC
-
-- SPMI PMIC voltage ADC (VADC) provides interface to clients to read
-  voltage. The VADC is a 15-bit sigma-delta ADC.
-- SPMI PMIC5 voltage ADC (ADC) provides interface to clients to read
-  voltage. The VADC is a 16-bit sigma-delta ADC.
-
-VADC node:
-
-- compatible:
-    Usage: required
-    Value type: <string>
-    Definition: Should contain "qcom,spmi-vadc".
-                Should contain "qcom,spmi-adc5" for PMIC5 ADC driver.
-                Should contain "qcom,spmi-adc-rev2" for PMIC rev2 ADC driver.
-                Should contain "qcom,pms405-adc" for PMS405 PMIC
-
-- reg:
-    Usage: required
-    Value type: <prop-encoded-array>
-    Definition: VADC base address in the SPMI PMIC register map.
-
-- #address-cells:
-    Usage: required
-    Value type: <u32>
-    Definition: Must be one. Child node 'reg' property should define ADC
-            channel number.
-
-- #size-cells:
-    Usage: required
-    Value type: <u32>
-    Definition: Must be zero.
-
-- #io-channel-cells:
-    Usage: required
-    Value type: <u32>
-    Definition: Must be one. For details about IIO bindings see:
-            Documentation/devicetree/bindings/iio/iio-bindings.txt
-
-- interrupts:
-    Usage: optional
-    Value type: <prop-encoded-array>
-    Definition: End of conversion interrupt.
-
-Channel node properties:
-
-- reg:
-    Usage: required
-    Value type: <u32>
-    Definition: ADC channel number.
-            See include/dt-bindings/iio/qcom,spmi-vadc.h
-
-- label:
-    Usage: required for "qcom,spmi-adc5" and "qcom,spmi-adc-rev2"
-    Value type: <empty>
-    Definition: ADC input of the platform as seen in the schematics.
-            For thermistor inputs connected to generic AMUX or GPIO inputs
-            these can vary across platform for the same pins. Hence select
-            the platform schematics name for this channel.
-
-- qcom,decimation:
-    Usage: optional
-    Value type: <u32>
-    Definition: This parameter is used to decrease ADC sampling rate.
-            Quicker measurements can be made by reducing decimation ratio.
-            - For compatible property "qcom,spmi-vadc", valid values are
-              512, 1024, 2048, 4096. If property is not found, default value
-              of 512 will be used.
-            - For compatible property "qcom,spmi-adc5", valid values are 250, 420
-              and 840. If property is not found, default value of 840 is used.
-            - For compatible property "qcom,spmi-adc-rev2", valid values are 256,
-              512 and 1024. If property is not present, default value is 1024.
-
-- qcom,pre-scaling:
-    Usage: optional
-    Value type: <u32 array>
-    Definition: Used for scaling the channel input signal before the signal is
-            fed to VADC. The configuration for this node is to know the
-            pre-determined ratio and use it for post scaling. Select one from
-            the following options.
-            <1 1>, <1 3>, <1 4>, <1 6>, <1 20>, <1 8>, <10 81>, <1 10>
-            If property is not found default value depending on chip will be used.
-
-- qcom,ratiometric:
-    Usage: optional
-    Value type: <empty>
-    Definition: Channel calibration type.
-            - For compatible property "qcom,spmi-vadc", if this property is
-              specified VADC will use the VDD reference (1.8V) and GND for
-              channel calibration. If property is not found, channel will be
-              calibrated with 0.625V and 1.25V reference channels, also
-              known as absolute calibration.
-            - For compatible property "qcom,spmi-adc5" and "qcom,spmi-adc-rev2",
-              if this property is specified VADC will use the VDD reference
-              (1.875V) and GND for channel calibration. If property is not found,
-              channel will be calibrated with 0V and 1.25V reference channels,
-              also known as absolute calibration.
-
-- qcom,hw-settle-time:
-    Usage: optional
-    Value type: <u32>
-    Definition: Time between AMUX getting configured and the ADC starting
-            conversion. The 'hw_settle_time' is an index used from valid values
-            and programmed in hardware to achieve the hardware settling delay.
-            - For compatible property "qcom,spmi-vadc" and "qcom,spmi-adc-rev2",
-              Delay = 100us * (hw_settle_time) for hw_settle_time < 11,
-              and 2ms * (hw_settle_time - 10) otherwise.
-              Valid values are: 0, 100, 200, 300, 400, 500, 600, 700, 800,
-              900 us and 1, 2, 4, 6, 8, 10 ms.
-              If property is not found, channel will use 0us.
-            - For compatible property "qcom,spmi-adc5", delay = 15us for
-              value 0, 100us * (value) for values < 11,
-              and 2ms * (value - 10) otherwise.
-              Valid values are: 15, 100, 200, 300, 400, 500, 600, 700, 800,
-              900 us and 1, 2, 4, 6, 8, 10 ms
-              Certain controller digital versions have valid values of
-              15, 100, 200, 300, 400, 500, 600, 700, 1, 2, 4, 8, 16, 32, 64, 128 ms
-              If property is not found, channel will use 15us.
-
-- qcom,avg-samples:
-    Usage: optional
-    Value type: <u32>
-    Definition: Number of samples to be used for measurement.
-            Averaging provides the option to obtain a single measurement
-            from the ADC that is an average of multiple samples. The value
-            selected is 2^(value).
-            - For compatible property "qcom,spmi-vadc", valid values
-              are: 1, 2, 4, 8, 16, 32, 64, 128, 256, 512
-              If property is not found, 1 sample will be used.
-            - For compatible property "qcom,spmi-adc5" and "qcom,spmi-adc-rev2",
-              valid values are: 1, 2, 4, 8, 16
-              If property is not found, 1 sample will be used.
-
-NOTE:
-
-For compatible property "qcom,spmi-vadc" following channels, also known as
-reference point channels, are used for result calibration and their channel
-configuration nodes should be defined:
-VADC_REF_625MV and/or VADC_SPARE1(based on PMIC version) VADC_REF_1250MV,
-VADC_GND_REF and VADC_VDD_VADC.
-
-Example:
-
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
-#include <linux/irq.h>
-/* ... */
-
-	/* VADC node */
-	pmic_vadc: vadc@3100 {
-		compatible = "qcom,spmi-vadc";
-		reg = <0x3100>;
-		interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		#io-channel-cells = <1>;
-		io-channel-ranges;
-
-		/* Channel node */
-		adc-chan@VADC_LR_MUX10_USB_ID {
-			reg = <VADC_LR_MUX10_USB_ID>;
-			qcom,decimation = <512>;
-			qcom,ratiometric;
-			qcom,hw-settle-time = <200>;
-			qcom,avg-samples = <1>;
-			qcom,pre-scaling = <1 3>;
-		};
-	};
-
-	/* IIO client node */
-	usb {
-		io-channels = <&pmic_vadc VADC_LR_MUX10_USB_ID>;
-		io-channel-names = "vadc";
-	};
diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
new file mode 100644
index 0000000..de8d243
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -0,0 +1,252 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/qcom,spmi-vadc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm's SPMI PMIC ADC
+
+maintainers:
+  - Andy Gross <agross@kernel.org>
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description: |
+  SPMI PMIC voltage ADC (VADC) provides interface to clients to read
+  voltage. The VADC is a 15-bit sigma-delta ADC.
+  SPMI PMIC5 voltage ADC (ADC) provides interface to clients to read
+  voltage. The VADC is a 16-bit sigma-delta ADC.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: qcom,pms405-adc
+          - const: qcom,spmi-adc-rev2
+
+      - items:
+        - enum:
+          - qcom,spmi-vadc
+          - qcom,spmi-adc5
+          - qcom,spmi-adc-rev2
+
+  reg:
+    description: VADC base address in the SPMI PMIC register map
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  '#io-channel-cells':
+    const: 1
+
+  interrupts:
+    maxItems: 1
+    description:
+      End of conversion interrupt.
+
+required:
+  - compatible
+  - reg
+  - '#address-cells'
+  - '#size-cells'
+  - '#io-channel-cells'
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    type: object
+    description: |
+      Represents the external channels which are connected to the ADC.
+      For compatible property "qcom,spmi-vadc" following channels, also known as
+      reference point channels, are used for result calibration and their channel
+      configuration nodes should be defined:
+      VADC_REF_625MV and/or VADC_SPARE1(based on PMIC version) VADC_REF_1250MV,
+      VADC_GND_REF and VADC_VDD_VADC.
+
+    properties:
+      reg:
+        description: |
+          ADC channel number.
+          See include/dt-bindings/iio/qcom,spmi-vadc.h
+
+      label:
+        $ref: /schemas/types.yaml#/definitions/string
+        description: |
+            ADC input of the platform as seen in the schematics.
+            For thermistor inputs connected to generic AMUX or GPIO inputs
+            these can vary across platform for the same pins. Hence select
+            the platform schematics name for this channel.
+
+      qcom,decimation:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+            This parameter is used to decrease ADC sampling rate.
+            Quicker measurements can be made by reducing decimation ratio.
+
+      qcom,pre-scaling:
+        description: |
+            Used for scaling the channel input signal before the signal is
+            fed to VADC. The configuration for this node is to know the
+            pre-determined ratio and use it for post scaling. It is a pair of
+            integers, denoting the numerator and denominator of the fraction by which
+            input signal is multiplied. For example, <1 3> indicates the signal is scaled
+            down to 1/3 of its value before ADC measurement.
+            If property is not found default value depending on chip will be used.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32-array
+        oneOf:
+          - items:
+            - const: 1
+            - enum: [ 1, 3, 4, 6, 20, 8, 10 ]
+
+          - items:
+            - const: 10
+            - const: 81
+
+      qcom,ratiometric:
+        description: |
+            Channel calibration type.
+            - For compatible property "qcom,spmi-vadc", if this property is
+              specified VADC will use the VDD reference (1.8V) and GND for
+              channel calibration. If property is not found, channel will be
+              calibrated with 0.625V and 1.25V reference channels, also
+              known as absolute calibration.
+            - For compatible property "qcom,spmi-adc5" and "qcom,spmi-adc-rev2",
+              if this property is specified VADC will use the VDD reference (1.875V)
+              and GND for channel calibration. If property is not found, channel
+              will be calibrated with 0V and 1.25V reference channels, also known
+              as absolute calibration.
+        type: boolean
+
+      qcom,hw-settle-time:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+            Time between AMUX getting configured and the ADC starting
+            conversion. The 'hw_settle_time' is an index used from valid values
+            and programmed in hardware to achieve the hardware settling delay.
+
+      qcom,avg-samples:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+            Number of samples to be used for measurement.
+            Averaging provides the option to obtain a single measurement
+            from the ADC that is an average of multiple samples. The value
+            selected is 2^(value).
+
+    required:
+      - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,spmi-vadc
+
+    then:
+      patternProperties:
+        "^.*@[0-9a-f]+$":
+          properties:
+            qcom,decimation:
+              enum: [ 512, 1024, 2048, 4096 ]
+              default: 512
+
+            qcom,hw-settle-time:
+              enum: [ 0, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1, 2,
+                      4, 6, 8, 10 ]
+              default: 0
+
+            qcom,avg-samples:
+              enum: [ 1, 2, 4, 8, 16, 32, 64, 128, 256, 512 ]
+              default: 1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,spmi-adc-rev2
+
+    then:
+      patternProperties:
+        "^.*@[0-9a-f]+$":
+          properties:
+            qcom,decimation:
+              enum: [ 256, 512, 1024 ]
+              default: 1024
+
+            qcom,hw-settle-time:
+              enum: [ 0, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1, 2,
+                      4, 6, 8, 10 ]
+              default: 0
+
+            qcom,avg-samples:
+              enum: [ 1, 2, 4, 8, 16 ]
+              default: 1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,spmi-adc5
+
+    then:
+      patternProperties:
+        "^.*@[0-9a-f]+$":
+          properties:
+            qcom,decimation:
+              enum: [ 250, 420, 840 ]
+              default: 840
+
+            qcom,hw-settle-time:
+              enum: [ 15, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1, 2,
+                      4, 6, 8, 10, 16, 32, 64, 128 ]
+              default: 15
+
+            qcom,avg-samples:
+              enum: [ 1, 2, 4, 8, 16 ]
+              default: 1
+
+examples:
+  - |
+    spmi_bus {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      /* VADC node */
+      pmic_vadc: adc@3100 {
+        compatible = "qcom,spmi-vadc";
+        reg = <0x3100>;
+        interrupts = <0x0 0x31 0x0 0x1>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        #io-channel-cells = <1>;
+        io-channel-ranges;
+
+        /* Channel node */
+        adc-chan@39 {
+          reg = <0x39>;
+          qcom,decimation = <512>;
+          qcom,ratiometric;
+          qcom,hw-settle-time = <200>;
+          qcom,avg-samples = <1>;
+          qcom,pre-scaling = <1 3>;
+        };
+
+        adc-chan@9 {
+          reg = <0x9>;
+        };
+
+        adc-chan@a {
+          reg = <0xa>;
+        };
+
+        adc-chan@e {
+          reg = <0xe>;
+        };
+
+        adc-chan@f {
+          reg = <0xf>;
+        };
+      };
+    };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

