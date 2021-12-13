Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB91471F60
	for <lists+linux-iio@lfdr.de>; Mon, 13 Dec 2021 03:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhLMClG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Dec 2021 21:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbhLMClF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Dec 2021 21:41:05 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979AEC06173F
        for <linux-iio@vger.kernel.org>; Sun, 12 Dec 2021 18:41:05 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso13649819pji.0
        for <linux-iio@vger.kernel.org>; Sun, 12 Dec 2021 18:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pMjmil2vb2/9WMbUMnfOFNaejsmjUXTrl9ueXnvU83w=;
        b=VdLczCimePFfUOe7jjWGhcJYgvb3ym3WLfuaG8Iu7yrMkWiRaqwR7WWMrp/bOgKgiu
         TJQttb8wwMty0C4TWrfET1036wqxeUcw8lwlay/UPYMniVGy9r7ypPMXtQLVXfMAiith
         IRn6gvTnz/BWRy9CfRSN6w2BJXQAwjGNBM8dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pMjmil2vb2/9WMbUMnfOFNaejsmjUXTrl9ueXnvU83w=;
        b=j+0wV+SmDhyqqcoqyw0d2HQB8kvrLw3PY4Oal4PxGw8OXF35yjCylRbcZeajMEcvgM
         STG0j4EBVBBhXIPT/qnephtSoEgT73FWlO1dmLPw9Y7Gsy8v9tFos3vZsl5ccOphRcur
         4eD/XNP/Ms9ffy+aG65FG5a/h7eUY2Xa4OQB7rUr6wN8/srl7jfa9kw/bdvZ7z7IzF3m
         4Gdx3oZxaGfJDId11JuX/WXZEvj30WQW4WhNZQmigDOIjInn2Hj55bezUTkqRhhNkUvO
         A0wOyBARhbbc/h5sdLonE/HJ7ZLCj6KW33IE+JfCRtNliCWmZGj/w8zBuIsxHwKZWDdf
         EUAA==
X-Gm-Message-State: AOAM533NN1IUa4Tl8+yigetz4KVzchE0jr7QIDClasTbgSPEdhzkKwcl
        sm/XF3eMxZmvSbqs6wfIr4ZIZg==
X-Google-Smtp-Source: ABdhPJxfxFBc59WVtBw9MEG/IyOHoBJeoqZpJmc4fqMmRY5SVMIXj0vsDZZxwbhCw/Gr+hI4Wj5rxw==
X-Received: by 2002:a17:90b:4f4c:: with SMTP id pj12mr40765582pjb.217.1639363265093;
        Sun, 12 Dec 2021 18:41:05 -0800 (PST)
Received: from localhost ([2620:15c:202:201:9cf8:7f4:ed82:2d07])
        by smtp.gmail.com with UTF8SMTPSA id g19sm8495898pgi.10.2021.12.12.18.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 18:41:04 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     robh+dt@kernel.org, jic23@kernel.org, lars@metafoo.de,
        swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 3/4] dt-bindings: iio: Add sx9360 binding
Date:   Sun, 12 Dec 2021 18:40:56 -0800
Message-Id: <20211213024057.3824985-4-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
In-Reply-To: <20211213024057.3824985-1-gwendal@chromium.org>
References: <20211213024057.3824985-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add binding to configure Semtech sx9360 sensor.
It is a simpler version of sx9324.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
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
+    $ref: /schemas/types.yaml#/definitions/uint32
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
2.34.1.173.g76aa8bc2d0-goog

