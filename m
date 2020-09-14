Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920152690E1
	for <lists+linux-iio@lfdr.de>; Mon, 14 Sep 2020 17:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgINP6M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Sep 2020 11:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgINPsY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Sep 2020 11:48:24 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0336CC061352
        for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2020 08:48:21 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b19so61929lji.11
        for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2020 08:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=paLqFLcsx0fUOLnJOcRz6bMeBzGi+tTtO3JWy1A0IIs=;
        b=VcT8v9jIZiDawP/g/zX4s4gw1bpIazhAtE5+9dzKzIks+U1ep96wEDg+g/brwuQE5g
         /md7zQr9ygLunuSSDqGVRAQgz5G8wiNVRJYAZq6nVs2C0RX3qihR/vaYaTHsQ6q8YHTj
         0sgaQZo5X2okmkS+gZGYBfmsI8bqBGzuX+ypKlA6dXWh38xzv+lACbYlREldrvvfrER8
         p2QLrTCAtz+AoXvwYkjMUOi+Kq0TSSV26N26tMKrJZ9kCJkTK7sfgdXj6DHLX9pzhCL2
         Ny46D18mvMV9uy0rtKOzdqTeZZgeK31aETdyCSSzrdxk8yQaG4qbGX8v1YBsyhz4ZlMo
         MLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=paLqFLcsx0fUOLnJOcRz6bMeBzGi+tTtO3JWy1A0IIs=;
        b=shriKH2xCrlb/Equv9suE6X4dXftwedt27k78S3sjxgzmsTFtSce2nfeIk9OSuh7+l
         2GLvepa4mjsWpxsxlRSEWg8TvkbUKTSH9bYPOXI2FBKo/5ElLZa030Sp6hsQLi3woLMg
         nB/OgDqNjJrm/yZqoVO36IrndIsmy9IjvCN+BB7y0gIQvlslUwy7QNDeS53jJfJy4qD8
         r3bQyfZz2Ovp6h+wEvjxgUgJWWVQHsGRfFIfS1IzKzduhisjN56+NSeaSS5Fx6k2+iD5
         CK/jmWVz+tK4VmfIRpr7qYJs01/dKm6ouwccgt4t26bEk3u19dDiVNGDmnnYryWstKFj
         oASQ==
X-Gm-Message-State: AOAM530bXWgbu7pUwJNRi72xpDmeI541MV2N9JMqnNxm3aX+qZCoBpsz
        5E9aoyneAO1YpQyAZY4XTbaj1g==
X-Google-Smtp-Source: ABdhPJyGyNYo2TRHsL5N90da0DMHD7jSXa1aML0vVbwOaXWmZLNwUR1S4PvdAMgtAAheA65Wr34mzw==
X-Received: by 2002:a2e:a28b:: with SMTP id k11mr5517555lja.405.1600098499376;
        Mon, 14 Sep 2020 08:48:19 -0700 (PDT)
Received: from eriador.lan ([188.162.64.187])
        by smtp.gmail.com with ESMTPSA id f19sm3834650lfs.85.2020.09.14.08.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 08:48:18 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 1/9] dt-bindings: thermal: qcom: add adc-thermal monitor bindings
Date:   Mon, 14 Sep 2020 18:48:01 +0300
Message-Id: <20200914154809.192174-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200914154809.192174-1-dmitry.baryshkov@linaro.org>
References: <20200914154809.192174-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add bindings for thermal monitor, part of Qualcomm PMIC5 chips. It is a
close counterpart of VADC part of those PMICs.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml   | 151 ++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
new file mode 100644
index 000000000000..432a65839b89
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
@@ -0,0 +1,151 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/qcom-spmi-adc-tm5.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm's SPMI PMIC ADC Thermal Monitoring
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
+            Quicker measurements can be made by reducing decimation ratio.
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
+      io-channels:
+        description:
+          From common IIO binding. Used to pipe PMIC ADC channel to thermal monitor
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
+        description: Used for scaling the channel input signal before the
+          signal is fed to VADC. See qcom,spi-vadc specification for the list
+          of possible values.
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
+    #include <dt-bindings/iio/qcom,spmi-vadc.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spmi_bus {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pm8150b_adc: adc@3100 {
+            reg = <0x3100>;
+            compatible = "qcom,spmi-adc5";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            #io-channel-cells = <1>;
+            io-channel-ranges;
+
+            /* Other propreties are omitted */
+            conn-therm@4f {
+                reg = <ADC5_AMUX_THM3_100K_PU>;
+                qcom,ratiometric;
+                qcom,hw-settle-time = <200>;
+            };
+        };
+
+        pm8150b_adc_tm: adc-tm@3500 {
+            compatible = "qcom,spmi-adc-tm5";
+            reg = <0x3500>;
+            interrupts = <0x2 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
+            #thermal-sensor-cells = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            conn-therm@0 {
+                reg = <0>;
+                io-channels = <&pm8150b_adc ADC5_AMUX_THM3_100K_PU>;
+                qcom,adc-channel = <ADC5_AMUX_THM3_100K_PU>;
+                qcom,ratiometric;
+                qcom,hw-settle-time = <200>;
+            };
+        };
+    };
+...
-- 
2.28.0

