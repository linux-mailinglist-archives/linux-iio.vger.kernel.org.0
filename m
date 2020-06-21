Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5FD202C5F
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jun 2020 21:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbgFUTf5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Jun 2020 15:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730170AbgFUTf4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2020 15:35:56 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655E9C061795
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2020 12:35:56 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d21so6297388lfb.6
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2020 12:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bhDR7iz+qpdl87dIvXubN6N0cNZInUDHwBfKjnhBFLY=;
        b=SOiXwgq6yf5bThJbs3KJRVphtiP73bWB2weIwmkw/kAINeQwFsQEUa1/LkY5uP2NlV
         /m1zUHCjlmj7D8WbnBFDfLuQRmrXAOmw/JUqHwn1iQCQPnT75QxkODPxz1ZCo+PCmggV
         M0RY+fKxPS1Y4qWANRBlloxjyU36/owRzQ6c9jKAP+GDPuYWUYww1+IT/+vG1wuuPSZx
         C3r0hXSAdONYEs7YkElz1Fw1BQk+n3c43n7YSKSEcEEVddFjIjw0Lv7sI9bevwDRhzIU
         3lbfprmqTakUNPqsU6TiDgJG+XK11w+W+eeZVdaDKbCEk0eIWMpoJO2V0oCvult6vpPo
         3MOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bhDR7iz+qpdl87dIvXubN6N0cNZInUDHwBfKjnhBFLY=;
        b=r1Z6G9BCTzlOmNoSMirnTrRMHfTigYrvqh4/f6PKF0k4omewdo43+haJ0uYiMfbZk7
         e5OZDVV9a5s468xd1ui30xaw7fogy+BaRR473umT7xLVdAeiNUg9HB0n+uHzsWMhhk3n
         vpeGtk3jkZATRHKGtr8U6paSVMZhgOESBu7Hg+hR/QwNnkKmXT+RtSLwndbqjstHWPCj
         Pm28qcYFyG6MO5YfvgvGsHqUmteBDHgbdysQgaSE6EOmNQuOGHU/L1C/swD/eISFkWu9
         dsIEGvFybQgBBPs1992Ru/bgJK0yPylmWLxAwA4cFqFjHVYGRaCrTmdMxwikC/wdHliN
         hJIQ==
X-Gm-Message-State: AOAM532TL1tzaNvRh/Je1S2Vm6Pgc5rQDqrEiI/G1f+T7h+Ub0FX7K+M
        4FyyQFtPS4qYbN0gXHSP47mDQA==
X-Google-Smtp-Source: ABdhPJysODQl3dWPkSOs0wySqS9WeY7DuLLZazK6EcK7p9DsUuVMD0RQFdZkxDHJkQBnxdAGGcopXw==
X-Received: by 2002:ac2:5e71:: with SMTP id a17mr3303817lfr.150.1592768154827;
        Sun, 21 Jun 2020 12:35:54 -0700 (PDT)
Received: from eriador.lan ([188.162.65.109])
        by smtp.gmail.com with ESMTPSA id r13sm2917854lfp.80.2020.06.21.12.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 12:35:54 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: thermal: qcom: add adc-thermal monitor bindings
Date:   Sun, 21 Jun 2020 22:35:45 +0300
Message-Id: <20200621193549.2070434-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200621193549.2070434-1-dmitry.baryshkov@linaro.org>
References: <20200621193549.2070434-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add bindings for thermal monitor, part of Qualcomm PMIC5 chips. It is a
close counterpart of VADC part of those PMICs.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml   | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
new file mode 100644
index 000000000000..16d3f61d692a
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
@@ -0,0 +1,143 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/qcom-spmi-adc-tm5.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm's SPMI PMIC ADC-TM
+maintainers:
+  - Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
+
+properties:
+  compatible:
+    const: qcom,spmi-adc-tm5
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 1
+    description:
+      Number of cells required to uniquely identify the thermal sensors. Since
+      we have multiple sensors this is set to 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  io-channels:
+    description:
+      From common IIO binding. Used to pipe PMIC ADC channel to thermal monitor
+
+  io-channel-names:
+    description:
+      From common IIO binding. Names each of IIO channels. The name should
+      be equal to the sensor's subnode name.
+
+  qcom,avg-samples:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Number of samples to be used for measurement.
+    enum:
+      - 1
+      - 2
+      - 4
+      - 8
+      - 16
+    default: 1
+
+  qcom,decimation:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: This parameter is used to decrease ADC sampling rate.
+    enum:
+      - 250
+      - 420
+      - 840
+    default: 840
+
+patternProperties:
+  "^([-a-z0-9]*)@[0-9]+$":
+    type: object
+    description:
+      Represent one thermal sensor.
+
+    properties:
+      reg:
+        description: Specify the sensor channel.
+        maxItems: 1
+
+      qcom,adc-channel:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Corresponding ADC channel ID.
+
+      qcom,ratiometric:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          Channel calibration type.
+          If this property is specified VADC will use the VDD reference
+          (1.875V) and GND for channel calibration. If property is not found,
+          channel will be calibrated with 0V and 1.25V reference channels,
+          also known as absolute calibration.
+
+      qcom,hw-settle-time:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Time between AMUX getting configured and the ADC starting conversion.
+
+      qcom,pre-scaling:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description: Used for scaling the channel input signal before the signal is fed to VADC. See qcom,spi-vadc specification for the list of possible values.
+        minItems: 2
+        maxItems: 2
+
+    required:
+      - reg
+      - qcom,adc-channel
+
+    additionalProperties:
+      false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#address-cells"
+  - "#size-cells"
+  - "#thermal-sensor-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+		pm8150b_adc: adc@3100 {
+			compatible = "qcom,spmi-adc5";
+			/* Other propreties are omitted */
+			conn-therm@4f {
+				reg = <ADC5_AMUX_THM3_100K_PU>;
+				qcom,ratiometric;
+				qcom,hw-settle-time = <200>;
+			};
+		};
+		pm8150b_adc_tm: adc-tm@3500 {
+			compatible = "qcom,spmi-adc-tm5";
+			reg = <0x3500>;
+			interrupts = <0x2 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			io-channels = <&pm8150b_adc ADC5_AMUX_THM3_100K_PU>;
+			io-channel-names = "conn-therm";
+
+			conn-therm@0 {
+				reg = <0>;
+				qcom,adc-channel = <ADC5_AMUX_THM3_100K_PU>;
+				qcom,ratiometric;
+				qcom,hw-settle-time = <200>;
+			};
+		};
+
+
+...
-- 
2.27.0

