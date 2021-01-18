Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C42E2FA3B1
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jan 2021 15:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405308AbhAROxq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jan 2021 09:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405294AbhAROxd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jan 2021 09:53:33 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE003C0613CF
        for <linux-iio@vger.kernel.org>; Mon, 18 Jan 2021 06:52:06 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id v67so24472070lfa.0
        for <linux-iio@vger.kernel.org>; Mon, 18 Jan 2021 06:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wSPG6layhSC30o3OnM7Qlvms5bw51mBSqqd8MBWO5aM=;
        b=BVK94L9RBhNjR/ndUTQd239fAM/3EB2t37FLedBe4VA+rqB0xEJV6xFoFL3RxKyn5l
         oMuc01Xmx/cnrB6aGEVV+RopzRTp3Cxz+w2d/C3aWZ2/bnkfq96/XUDG1uv6DtiH4DW+
         JC6GI+FtixLrZXwAIsH/dRxxL2L1gmIuC8mATdzvtCare65PRQCNwZeYLeC7cB34Jrsv
         QsCaGQ2VikPr3YrBI7RVsZwm1yCK3Id0CaKEo4ScMP+vDuEOoRUkKMuaM2iCsQPQfyru
         KL7sj55oSQixdt46XrzjxHSF8oLm6bx/heKocoRdG5LPbxzrffFl5IKMhOFX3rT25YI3
         m+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wSPG6layhSC30o3OnM7Qlvms5bw51mBSqqd8MBWO5aM=;
        b=QEv/FchgTi8k74GcYYcjzdY2iAb4lx4lnnI9RMt7mj+xtlmHbC3fsOdFN+1d93qUdM
         5aspsjZCaQ2O9jLM1GWAz70JHAWrtbP21Z7VRcwA+mgJGKQMPCesnyN1Icdb34B0DG5j
         hjREOUHP6h8lnBkMZpw+nmhLFP1Ff9jsJf/jb0K5lsATwaaUFLjJAPBAS828d5mru5Z8
         uBvXL4fti22H7cyPtA7pI3Xl0Ji1BVTQz1VhXMArFTf0F+3juy2OHcjTtHzyle3byLr8
         Oa21CvXl9v82ztuVS4efnN64SqzWRKb9FcplFLebAFnUJBuQMis0r6E4xAvVICTK7nH+
         1YvQ==
X-Gm-Message-State: AOAM530QkFf1Z8B2R9TMfnbv5WAmxiMbHDSru+MsHbJ8SDDX1qJJKBcK
        ZDAMUbppWkzhwbcqjt1MGbxFKA==
X-Google-Smtp-Source: ABdhPJwSfquSJ7jjgclmLk//cisgpwUC3Xamsd2ZGDo00xObtkFy6X9RTgEHpIBbWH2mN3ndW9LCXA==
X-Received: by 2002:a19:8053:: with SMTP id b80mr12468741lfd.74.1610981525354;
        Mon, 18 Jan 2021 06:52:05 -0800 (PST)
Received: from eriador.lumag.spb.ru ([188.162.64.4])
        by smtp.gmail.com with ESMTPSA id h13sm1969697lfj.110.2021.01.18.06.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 06:52:04 -0800 (PST)
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
        Jishnu Prakash <jprakash@qti.qualcomm.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v11 1/5] dt-bindings: thermal: qcom: add adc-thermal monitor bindings
Date:   Mon, 18 Jan 2021 17:51:56 +0300
Message-Id: <20210118145200.504951-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118145200.504951-1-dmitry.baryshkov@linaro.org>
References: <20210118145200.504951-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add bindings for thermal monitor, part of Qualcomm PMIC5 chips. It is a
close counterpart of VADC part of those PMICs.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml   | 154 ++++++++++++++++++
 1 file changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
new file mode 100644
index 000000000000..9da2b349030d
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
@@ -0,0 +1,154 @@
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
+  "^([-a-z0-9]*)@[0-7]$":
+    type: object
+    description:
+      Represent one thermal sensor.
+
+    properties:
+      reg:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Specify the sensor channel. There are 8 channels in PMIC5's ADC TM
+        minimum: 0
+        maximum: 7
+
+      io-channels:
+        description:
+          From common IIO binding. Used to pipe PMIC ADC channel to thermal monitor
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
+      qcom,hw-settle-time-us:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Time between AMUX getting configured and the ADC starting conversion.
+        enum: [15, 100, 200, 300, 400, 500, 600, 700, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000]
+
+      qcom,pre-scaling:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description: Used for scaling the channel input signal before the
+          signal is fed to VADC. The configuration for this node is to know the
+          pre-determined ratio and use it for post scaling. It is a pair of
+          integers, denoting the numerator and denominator of the fraction by
+          which input signal is multiplied. For example, <1 3> indicates the
+          signal is scaled down to 1/3 of its value before ADC measurement.  If
+          property is not found default value depending on chip will be used.
+        items:
+          - const: 1
+          - enum: [ 1, 3, 4, 6, 20, 8, 10 ]
+
+    required:
+      - reg
+      - io-channels
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
+                qcom,ratiometric;
+                qcom,hw-settle-time-us = <200>;
+            };
+        };
+    };
+...
-- 
2.29.2

