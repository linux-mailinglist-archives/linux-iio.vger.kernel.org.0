Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F082E263462
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 19:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbgIIRTv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 13:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729953AbgIIP0i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Sep 2020 11:26:38 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0025C0612A8
        for <linux-iio@vger.kernel.org>; Wed,  9 Sep 2020 07:43:08 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u4so3851948ljd.10
        for <linux-iio@vger.kernel.org>; Wed, 09 Sep 2020 07:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yMvVXpSpVGDfdX14bLkO7U8LOBlYVmYuUOGPXx5qIqI=;
        b=QQ9REk01gK8HMw9gq+R0GrwFAdnxdqqge4xTp6/7MQehjUS9y+wbanI6/644+8Jnoj
         x0nJwH1JzaP99Y4Hk5xD20aNtEKBUGH0vq49poqM4naz0TVy8S/HlIIcdrZP2oqOeOH3
         zNdU0CdhhsfgfqUeeFUekq/yFA4pUaabVp4C+U6M876Z7NXB9goGBQ3vVPEoweS3CBYC
         aOvRW9r2zP4QTK8f3VY3ESF1+nLxm7MK5IODm0FOMDFG6p7h0/3cDGbRhTaYZrxxZpNL
         A1NwBLGGTbORcve/wW4AtG16KNmL0sZ60qAoC2gqAPDu7L0zJJcEUQJ74JYoO0hjCH6j
         IORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yMvVXpSpVGDfdX14bLkO7U8LOBlYVmYuUOGPXx5qIqI=;
        b=R0BDy9ZDqaY1LS9+U7qnS+vDERTpxFVeLFpbjCkOR5MOa1chPenBl4rgouorLCgqon
         VBG6Ms3ii+d2uU2sQnKABIKPOrYlrvHnLbeVoLqr4xrl09KvA0E/sP3ljbSWVbAGLm6h
         bcS/9tiR58NP3KZyT25Mau4Vp5TiidOQ0KU6UcFhXVlyAACXGz71JDZzHptb4WEmje7o
         7d4A8t4xAdsWYu8YyXnRHwYHkGKT9ZMREyysofn/jyQMKTs44VS6hHXIMLAHYs7fYOi8
         BcEicv0Du+0tRbVRU9bS7U9lRsxErKond0syqAGZ8MgmO07lrSBO9sjCnk3yQfQqfg2W
         mkkg==
X-Gm-Message-State: AOAM531qzMASJHVCBsIyfViUo9UJ+KGtRJtob7lK0+DBDSvZ4zSZL4SO
        MB6YMWBGfGhKKLB2Zwx5AY8wFQ==
X-Google-Smtp-Source: ABdhPJxXHYgt5utpdo1iDhw6xcrA0sfYrG3fGr8zUuYpZCCfG44ZvKKajKg2fIEZzIw61sghcU/i2A==
X-Received: by 2002:a2e:b4f5:: with SMTP id s21mr2161986ljm.270.1599662580464;
        Wed, 09 Sep 2020 07:43:00 -0700 (PDT)
Received: from eriador.lan ([188.162.64.155])
        by smtp.gmail.com with ESMTPSA id t12sm621665lfk.26.2020.09.09.07.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 07:42:59 -0700 (PDT)
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
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 02/10] dt-bindings: thermal: qcom: add adc-thermal monitor bindings
Date:   Wed,  9 Sep 2020 17:42:40 +0300
Message-Id: <20200909144248.54327-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200909144248.54327-1-dmitry.baryshkov@linaro.org>
References: <20200909144248.54327-1-dmitry.baryshkov@linaro.org>
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
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml   | 141 ++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
new file mode 100644
index 000000000000..b3818357808b
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
@@ -0,0 +1,141 @@
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
+        #include <dt-bindings/iio/qcom,spmi-vadc.h>
+        #include <dt-bindings/interrupt-controller/irq.h>
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
+
+            conn-therm@0 {
+                reg = <0>;
+                io-channels = <&pm8150b_adc ADC5_AMUX_THM3_100K_PU>;
+                qcom,adc-channel = <ADC5_AMUX_THM3_100K_PU>;
+                qcom,ratiometric;
+                qcom,hw-settle-time = <200>;
+            };
+        };
+...
-- 
2.28.0

