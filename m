Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206F263F8F7
	for <lists+linux-iio@lfdr.de>; Thu,  1 Dec 2022 21:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiLAUVx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Dec 2022 15:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiLAUVt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Dec 2022 15:21:49 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430C0BF937
        for <linux-iio@vger.kernel.org>; Thu,  1 Dec 2022 12:21:48 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id p8so4232752lfu.11
        for <linux-iio@vger.kernel.org>; Thu, 01 Dec 2022 12:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKmE+hFlJHqtMdmJeHcqNG8xf2z5C60unLxtWG9reKY=;
        b=FIlJT4UOMxpVeTMNkDTF5t1/AcPzkI+FSl0RPjV6dxXpMaAj9fb2E7ZSNQgpPZBS6I
         B6mzXmsxSja4MRXmcDF3xqVTjTDyYKuVG/Wg9sCL/ep3Gr9/DSn7TZOzSzmMJSyJcT9Y
         iDIOwRYXuMiUno86NoRRL8sLZw+DRKgZ8lGkoNASu0DtGEyV8PHGbCSA85+F/emlKZux
         EWOKF5s33qgjRAaoFd/dZZ4QmjAuJxdOtSC0WKSLbjAES767RyZwwH3kSxzukqLkB7+w
         VlnjJByHFb77e5momqQ4YQcmnA2TCFrfhMZUTmXEp8QF6A+88GNWFg3MiwHNMeARNrIu
         GbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKmE+hFlJHqtMdmJeHcqNG8xf2z5C60unLxtWG9reKY=;
        b=NM9ryyrvAzFeTJ+LbtHUZN1HNg6E2i+EFWQn4pVRtOPZaooUymKKx7NJ3cp/s5ypFw
         hNBTKGTHPgs5cFk18HDxyvo3fL6hUs/0qRtI0Zh0rG8FGJlba9iNoAUzeCzUv4bgBaPc
         r377XwbOfgjpaNPSPv2K8rvAMZQu6wEjCMGnFL7+HFbaPiNoLWPJG2uLOI5gP2oQ13eH
         TTjZmjcu1j6JeWj8GMn6MKU+EMT3gYeh6Ej+jQQiD8rYE6vJKNz9o3HNj5FKjO5ge6m4
         cUQQz5MjVrE+sISf154iExFedvfFI3YM3g4m2T3vlSGobXjzDG1uFcjgoPH2DWY2/QER
         bY5w==
X-Gm-Message-State: ANoB5pkcVxWwhQCefX9wZyiVumPetm3sCo9EecXzZC2yEWvYVmm1ATf5
        tzCpCf1FaQZ44ifaq3Th8qV0Pis9Ym/PMA==
X-Google-Smtp-Source: AA0mqf6L9JV+4Ro/rEOmcVfPDkvXeOBOcRhjeHdJgMFhGMM9OGSAR3CK+yyYK5LzRL8Fi5f7cHblhw==
X-Received: by 2002:a05:6512:786:b0:4a2:44c7:ee58 with SMTP id x6-20020a056512078600b004a244c7ee58mr22190725lfr.127.1669926106648;
        Thu, 01 Dec 2022 12:21:46 -0800 (PST)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id l30-20020a19495e000000b004b514b27c86sm769679lfj.13.2022.12.01.12.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 12:21:46 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: input: qcom,pm8921-keypad: convert to YAML format
Date:   Thu,  1 Dec 2022 22:21:40 +0200
Message-Id: <20221201202144.448694-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221201202144.448694-1-dmitry.baryshkov@linaro.org>
References: <20221201202144.448694-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert the bindings for the keypad subdevices of Qualcomm PM8921 and
PM8058 PMICs from text to YAML format.

While doing the conversion also change linux,keypad-no-autorepeat
property to linux,input-no-autorepeat. The former property was never
used by DT and was never handled by the driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../bindings/input/qcom,pm8921-keypad.yaml    | 93 +++++++++++++++++++
 .../bindings/input/qcom,pm8xxx-keypad.txt     | 90 ------------------
 2 files changed, 93 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/qcom,pm8921-keypad.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt

diff --git a/Documentation/devicetree/bindings/input/qcom,pm8921-keypad.yaml b/Documentation/devicetree/bindings/input/qcom,pm8921-keypad.yaml
new file mode 100644
index 000000000000..e3c53a8234c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/qcom,pm8921-keypad.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/qcom,pm8921-keypad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm PM8921 PMIC KeyPad
+
+maintainers:
+  - Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
+
+allOf:
+  - $ref: input.yaml#
+  - $ref: matrix-keymap.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,pm8058-keypad
+      - qcom,pm8921-keypad
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: key sense
+      - description: key stuck
+
+  linux,input-no-autorepeat:
+    type: boolean
+    description: don't enable autorepeat feature.
+
+  wakeup-source:
+    type: boolean
+    description: use any event on keypad as wakeup event
+
+  linux,keypad-wakeup:
+    type: boolean
+    deprecated: true
+    description: legacy version of the wakeup-source property
+
+  debounce:
+    description:
+      Time in microseconds that key must be pressed or
+      released for state change interrupt to trigger.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  scan-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: time in microseconds to pause between successive scans of the
+      matrix array
+
+  row-hold:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: time in nanoseconds to pause between scans of each row in the
+      matrix array.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - linux,keymap
+
+unevaluatedProperties: false
+
+examples:
+  - |
+   #include <dt-bindings/input/input.h>
+   #include <dt-bindings/interrupt-controller/irq.h>
+   pmic {
+       #address-cells = <1>;
+       #size-cells = <0>;
+
+       keypad@148 {
+           compatible = "qcom,pm8921-keypad";
+           reg = <0x148>;
+           interrupt-parent = <&pmicintc>;
+           interrupts = <74 IRQ_TYPE_EDGE_RISING>, <75 IRQ_TYPE_EDGE_RISING>;
+           linux,keymap = <
+               MATRIX_KEY(0, 0, KEY_VOLUMEUP)
+               MATRIX_KEY(0, 1, KEY_VOLUMEDOWN)
+               MATRIX_KEY(0, 2, KEY_CAMERA_FOCUS)
+               MATRIX_KEY(0, 3, KEY_CAMERA)
+           >;
+           keypad,num-rows = <1>;
+           keypad,num-columns = <5>;
+           debounce = <15>;
+           scan-delay = <32>;
+           row-hold = <91500>;
+       };
+   };
+...
diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt b/Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
deleted file mode 100644
index 4a9dc6ba96b1..000000000000
--- a/Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
+++ /dev/null
@@ -1,90 +0,0 @@
-Qualcomm PM8xxx PMIC Keypad
-
-PROPERTIES
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be one of:
-		    "qcom,pm8058-keypad"
-		    "qcom,pm8921-keypad"
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: address of keypad control register
-
-- interrupts:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: the first interrupt specifies the key sense interrupt
-		    and the second interrupt specifies the key stuck interrupt.
-		    The format of the specifier is defined by the binding
-		    document describing the node's interrupt parent.
-
-- linux,keymap:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: the linux keymap. More information can be found in
-		    input/matrix-keymap.txt.
-
-- linux,keypad-no-autorepeat:
-	Usage: optional
-	Value type: <bool>
-	Definition: don't enable autorepeat feature.
-
-- wakeup-source:
-	Usage: optional
-	Value type: <bool>
-	Definition: use any event on keypad as wakeup event.
-		    (Legacy property supported: "linux,keypad-wakeup")
-
-- keypad,num-rows:
-	Usage: required
-	Value type: <u32>
-	Definition: number of rows in the keymap. More information can be found
-		    in input/matrix-keymap.txt.
-
-- keypad,num-columns:
-	Usage: required
-	Value type: <u32>
-	Definition: number of columns in the keymap. More information can be
-		    found in input/matrix-keymap.txt.
-
-- debounce:
-	Usage: optional
-	Value type: <u32>
-	Definition: time in microseconds that key must be pressed or release
-		    for key sense interrupt to trigger.
-
-- scan-delay:
-	Usage: optional
-	Value type: <u32>
-	Definition: time in microseconds to pause between successive scans
-		    of the matrix array.
-
-- row-hold:
-	Usage: optional
-	Value type: <u32>
-	Definition: time in nanoseconds to pause between scans of each row in
-		    the matrix array.
-
-EXAMPLE
-
-	keypad@148 {
-		compatible = "qcom,pm8921-keypad";
-		reg = <0x148>;
-		interrupt-parent = <&pmicintc>;
-		interrupts = <74 1>, <75 1>;
-		linux,keymap = <
-			MATRIX_KEY(0, 0, KEY_VOLUMEUP)
-			MATRIX_KEY(0, 1, KEY_VOLUMEDOWN)
-			MATRIX_KEY(0, 2, KEY_CAMERA_FOCUS)
-			MATRIX_KEY(0, 3, KEY_CAMERA)
-			>;
-		keypad,num-rows = <1>;
-		keypad,num-columns = <5>;
-		debounce = <15>;
-		scan-delay = <32>;
-		row-hold = <91500>;
-	};
-- 
2.35.1

