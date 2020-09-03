Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF6925C2C2
	for <lists+linux-iio@lfdr.de>; Thu,  3 Sep 2020 16:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgICOen (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Sep 2020 10:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729202AbgICO1d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Sep 2020 10:27:33 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70651C061263
        for <linux-iio@vger.kernel.org>; Thu,  3 Sep 2020 06:21:20 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id w11so1902654lfn.2
        for <linux-iio@vger.kernel.org>; Thu, 03 Sep 2020 06:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x8TcLLpTMK/7uUIKDqPfjBp8nQFpQtMgJOajM5MyUVQ=;
        b=iKF0sB/PkVkOpriRtZPA6ZaTXtQR9Xy+C94WfQx2HefwEjzpp5TFVDARTyYs3jDElM
         DrLvkjqSjtpLhOp5SA9WEtFXpehUTxpATMx543udaHwwHxfw3n3dPwTG2zJVe5oQqziF
         LBEnOAlpyhkMZBLwiHt1w6Tg06nv50Tl5Z3rFVtz8evCLEj6fFRt8nNxYe7qq6+7zXYm
         7UuEAw2d86l1KoAfYolEqO8CwhsaF2weEa5hWPQ08zGFsQ3k99fuQo5RNXDaMjjfVCqh
         IgmdyobfnWeRFFmpDczahkiC8LpMHm7szXnTowgmBxT1wcslBj0f6sry11y2U/hBpvPd
         G3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x8TcLLpTMK/7uUIKDqPfjBp8nQFpQtMgJOajM5MyUVQ=;
        b=aA/3mDaR1EWj0SBVd5kgAlW2qhC0qGGXj5RvWyS7ZCuUm/32v7amTU9egW3e1+c6wb
         hA6FB+C5eJZ7/Yf/RR0bQ1hAeQYoakv+6/3tdCm3hMQyb6UfhUAOMtxFaM505G5f+PXt
         VqS5oQRYKAUoG76gURRPcCkyKOfse7UQ5VlK9enkBz6nQWLQgKVol7/PhQZN1mqmi7kg
         8MZr5mY1iDtps9XJJNvk/A7Jw4HNNO0XYKcAzhasO6LUxLt/EK8vbqTwbsMTTmTP4x9m
         /+u7xHwDWqqtPTgJ+K2KrkB6Q4X5hhBXh3MFKejax9CdcPGHLg/UvIoLZ9PT4tc5jsbI
         UTiA==
X-Gm-Message-State: AOAM533SHv1rmSPA+K4kmEQnrcbMdiEtqylddpwYSkonjYG7lsWlyi68
        pAUkrkyfpfZqbyat3s9u0Z8gzQ==
X-Google-Smtp-Source: ABdhPJzB7ZiRNfU7Oms45iJVJfA/vqzPh3W4c9GPdqfnnilznvz6AX/vO5ju49GYdvYM9p6OSgbyOQ==
X-Received: by 2002:a19:418e:: with SMTP id o136mr1257809lfa.145.1599139278593;
        Thu, 03 Sep 2020 06:21:18 -0700 (PDT)
Received: from eriador.lan ([188.162.64.138])
        by smtp.gmail.com with ESMTPSA id e23sm584220lfj.80.2020.09.03.06.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 06:21:18 -0700 (PDT)
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
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v2 1/9] dt-bindings: thermal: qcom: add adc-thermal monitor bindings
Date:   Thu,  3 Sep 2020 16:21:01 +0300
Message-Id: <20200903132109.1914011-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903132109.1914011-1-dmitry.baryshkov@linaro.org>
References: <20200903132109.1914011-1-dmitry.baryshkov@linaro.org>
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
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml   | 142 ++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
new file mode 100644
index 000000000000..94aaf3720b9f
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
@@ -0,0 +1,142 @@
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
+        pm8150b_adc: adc@3100 {
+            compatible = "qcom,spmi-adc5";
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
+            io-channels = <&pm8150b_adc ADC5_AMUX_THM3_100K_PU>;
+            io-channel-names = "conn-therm";
+
+            conn-therm@0 {
+                reg = <0>;
+                qcom,adc-channel = <ADC5_AMUX_THM3_100K_PU>;
+                qcom,ratiometric;
+                qcom,hw-settle-time = <200>;
+            };
+        };
+...
-- 
2.28.0

