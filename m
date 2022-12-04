Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F848641B1A
	for <lists+linux-iio@lfdr.de>; Sun,  4 Dec 2022 07:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiLDGQB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Dec 2022 01:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiLDGQA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Dec 2022 01:16:00 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCB81ADB7
        for <linux-iio@vger.kernel.org>; Sat,  3 Dec 2022 22:15:58 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id h10so9970051ljk.11
        for <linux-iio@vger.kernel.org>; Sat, 03 Dec 2022 22:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKmE+hFlJHqtMdmJeHcqNG8xf2z5C60unLxtWG9reKY=;
        b=MGOVrxfOD8BF4FwUjHn7YWjRN4P7dbKZxtu8bDTJRpI9qiAVPEfxDOQu7MXactS+oJ
         xEDJhkXS8Lcig70yNUQjUIzbeKwXAkNtv/QgADNqMxLTBJnaZX6WLq0Lb0al0LYwK00y
         U/rt/A4oMcb0ycEShNEDSt1lK7Nxg/zFb5LBIp1JSGXKq6+5AeekzTCg078zQRL0D7Gd
         V3WRpos346S3l56b8H/Nc2GLfd1kuIGyNscHkH0tkldLsPGn9run5GsFe6DLcZYzkYl9
         E4Fi0/uK5Fp3qlRonmucgTpt1XJ530p48lLMz5pOtupoR6P0jyGQg7sKiy/BtoR2JHQQ
         czXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKmE+hFlJHqtMdmJeHcqNG8xf2z5C60unLxtWG9reKY=;
        b=7YS1l+DwGebckcKHnSA3ttXK8iQhU0vsDVq6djhueY9mzHmYLu7KQG6b6ZxjuMNCaB
         EmtJ4VhfmdYzHQi2JHcvtFHHx3pi19juaxSwhP76oscVGLQSwma9xCwfMezQqF7X7Dbo
         t9Hr7XBtc7sXoq4sGBfRkaOJS8PFxh71ChsW5Mi3+BGG8hE3nid+4IE1k3xSOoc+8pIC
         DSc/ne7j+O0qeleBR7F2h15jRB/azESMwQm7/Cex32rsU2ioXTplPqPmsT/Hhcr1miBK
         5iaphZ1Ih16653/zagr6CcTCbG1eWCFWpVtZ9LFFE0VtfzmVmbr+OQKMwHFl4OybhIkl
         CXNg==
X-Gm-Message-State: ANoB5pkPZdZtF3ksCaLwD7l8YJ7yP8kBOYJ3TSa6hbGXUG8grKFdITG/
        KIjtBBm8QVULP1RgymROrXOCDrqgetRDixCP
X-Google-Smtp-Source: AA0mqf7SyhRkMi3aiViU5jyNWW7s3Ms/PUnL7UdUfm0Oy7psHR+ZoK7WyxOPPjQOlDhe/DsxvYZIRA==
X-Received: by 2002:a2e:a0c2:0:b0:279:95c2:c154 with SMTP id f2-20020a2ea0c2000000b0027995c2c154mr13350452ljm.44.1670134557327;
        Sat, 03 Dec 2022 22:15:57 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id l12-20020a056512110c00b0047f7722b73csm1650725lfg.142.2022.12.03.22.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 22:15:57 -0800 (PST)
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
Subject: [PATCH v2 1/4] dt-bindings: input: qcom,pm8921-keypad: convert to YAML format
Date:   Sun,  4 Dec 2022 08:15:52 +0200
Message-Id: <20221204061555.1355453-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221204061555.1355453-1-dmitry.baryshkov@linaro.org>
References: <20221204061555.1355453-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

