Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BADA48198F
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 06:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhL3FPP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 00:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhL3FPN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 00:15:13 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE65C061574
        for <linux-iio@vger.kernel.org>; Wed, 29 Dec 2021 21:15:13 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id h1so14244677pls.11
        for <linux-iio@vger.kernel.org>; Wed, 29 Dec 2021 21:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oA+VDHSs9zUg3KVpJXPXCDc0dUfIsfvmiEVxR5Nl47U=;
        b=MWVSq2lcbg70kEiWtxH/DOefylJGYpibpFBF1jfecyhCjWJLKtejUVqfT13V0nCt5S
         9TiEKdL/MeuqVISkvXbeRCUDKuoMYkXbms0B7whgMfEcGGlYGFxWcILMiQTdld5osLqT
         tYhXZDAMKP3tuDAPFETHmACafu/vf13OeKChQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oA+VDHSs9zUg3KVpJXPXCDc0dUfIsfvmiEVxR5Nl47U=;
        b=sNyhsUaix7QsYlVjp5JiDXuTZ4+QcrO7SStCjFHeXjlc+hvvfKUNanK2Ls0NQWU8Ml
         urWck25zU0eNbaw5Fu0eKL6FlzeqmK2yRB7v+BRVCp47DoUuwjsgEpoqit9UELT1YU8K
         to5W0sUwOdy43Q3rlB9+Jts0IBNRJf3ulAhF+tx5BeP//z7RxbIw3uHV+s7OH+THVpaT
         bnwzKZZ25LCVKlr1NYtTApQnS2Q/VN3RrqUbm45HFmX1hF1/svT7+KOT0ZX0dWNSWGqf
         sjduYnC+zfWFDs7isqzD4PDyyK8wyKiVztdZNb3k40o4DN30Ii67CeA1x5qMOQgR43HQ
         QsfQ==
X-Gm-Message-State: AOAM531MBVAI9BLxX/o7z4xjH749V8rPIxk6EsNXK45dHn0jff/lLZee
        TfE8ShXegrlzVV/7M5PXm8czvA==
X-Google-Smtp-Source: ABdhPJxlDjd6dF3Ai+kuPiubBl/E2CK00uCL9Bi5eXGLvFOkYD/PiIlythlqw+Kt+HcACdUZUcXw1w==
X-Received: by 2002:a17:902:6a8b:b0:149:82bb:560a with SMTP id n11-20020a1709026a8b00b0014982bb560amr16239601plk.158.1640841312918;
        Wed, 29 Dec 2021 21:15:12 -0800 (PST)
Received: from localhost ([2620:15c:202:201:f2cb:bddc:361b:5398])
        by smtp.gmail.com with UTF8SMTPSA id s8sm2692179pfu.190.2021.12.29.21.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 21:15:12 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v5 2/3] dt-bindings: iio: Add sx9360 binding
Date:   Wed, 29 Dec 2021 21:15:06 -0800
Message-Id: <20211230051507.1053806-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20211230051507.1053806-1-gwendal@chromium.org>
References: <20211230051507.1053806-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add binding to configure Semtech sx9360 sensor.
It is a simpler version of sx9324.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
No Changes since v4.
No Changes since v3.
Changes since v2:
- Use const instead of single enum.
- Use proper syntax for maximum/minimum
- Fix spelling errors.

Changes since v1:
- Fix cut and paste error.
- Add . at end of sentence.

 .../iio/proximity/semtech,sx9360.yaml         | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
new file mode 100644
index 00000000000000..63e1a1fd00d4ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/semtech,sx9360.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Semtech's SX9360 capacitive proximity sensor
+
+maintainers:
+  - Gwendal Grignou <gwendal@chromium.org>
+  - Daniel Campello <campello@chromium.org>
+
+description: |
+  Semtech's SX9360 proximity sensor.
+
+properties:
+  compatible:
+    const: semtech,sx9360
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      Generated by device to announce preceding read request has finished
+      and data is available or that a close/far proximity event has happened.
+    maxItems: 1
+
+  vdd-supply:
+    description: Main power supply
+
+  svdd-supply:
+    description: Host interface power supply
+
+  "#io-channel-cells":
+    const: 1
+
+  semtech,resolution:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    enum: [8, 16, 32, 64, 128, 256, 512, 1024]
+    description:
+      Capacitance measurement resolution. For both phases, "reference" and
+      "measurement". Higher the number, higher the resolution.
+    default: 128
+
+  semtech,proxraw-strength:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 7
+    default: 1
+    description:
+      PROXRAW filter strength for both phases. A value of 0 represents off,
+      and other values represent 1-1/2^N.
+
+  semtech,avg-pos-strength:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 16, 64, 128, 256, 512, 1024, 4294967295]
+    default: 16
+    description: |
+      Average positive filter strength. A value of 0 represents off and
+      UINT_MAX (4294967295) represents infinite. Other values
+      represent 1-1/N.
+
+required:
+  - compatible
+  - reg
+  - "#io-channel-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      proximity@28 {
+        compatible = "semtech,sx9360";
+        reg = <0x28>;
+        interrupt-parent = <&pio>;
+        interrupts = <5 IRQ_TYPE_LEVEL_LOW 5>;
+        vdd-supply = <&pp3300_a>;
+        svdd-supply = <&pp1800_prox>;
+        #io-channel-cells = <1>;
+        semtech,resolution = <256>;
+        semtech,proxraw-strength = <2>;
+        semtech,avg-pos-strength = <64>;
+      };
+    };
-- 
2.34.1.448.ga2b2bfdf31-goog

