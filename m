Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD43A2315F0
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jul 2020 01:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbgG1XFk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 19:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729968AbgG1XFg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 19:05:36 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DD7C061794
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 16:05:35 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id c16so5930944ils.8
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 16:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6UbKcDbB3X6w5o9gkXHnELQCPot6Q2IbpzB0zM07yDY=;
        b=SKhBdJvG0UM5JOyrKAx8HZBZddJMCkqyDbP5rFWuOh/S43s58G1ri0hLOPtNCLqrPV
         ++fRe2aA/JWneMi/STUwOySZemSZJ/m6SeCn6z0a4MREJk0vRhFRrSETGbLu8KOyiD9y
         mPfqhINQ0zjdVVnLVqGgevsmqdctmBLXod9PY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6UbKcDbB3X6w5o9gkXHnELQCPot6Q2IbpzB0zM07yDY=;
        b=hhl77UpAE4aifJQEEjEF7+E3PMfK1Y7x45cokdWkVEGzaZQ02iiM7M033ta3JsMeZO
         4pYJwoHaSTbSqnXP/W8LUX6R6gBo5CHb0rKtcW8yXpQkvDtEJWaKrmAZKOBoWbC2qJlL
         EAo0bR+uM/eFRBzrU8Mh0IIysv8tRZww8KA0w4zLzg+Ol/yJ27+4HL9sS8yukKfl8VGf
         X1hQzxxOMHNuHjb7oD4Y8nUFDjpHZqmBcieD04B1pfD9E+fpGPSSazVKm7oqY4JhkBPQ
         B7lmmLJN/aIrgW0Y1pCspktECXYUIWwCZIAjGhn1XAC/R6Ed1EQQxWKwVTM61Kp0F63e
         VjAQ==
X-Gm-Message-State: AOAM533j4gpTgZQ0+egOUnKOUXq1AbaAWlzK01ArT8J5XAamrn8SAE/T
        k/uDWisi761A2rzRQD1kt6m3kg==
X-Google-Smtp-Source: ABdhPJwPkaQmsiSi1gMOYFk0cbAYpLJiiPPRoPE7gOs4375sXdrF8EQ0ahxJWqNrYcscMnA2ZXD+nQ==
X-Received: by 2002:a92:5f83:: with SMTP id i3mr22540021ill.251.1595977534814;
        Tue, 28 Jul 2020 16:05:34 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id w10sm148945ilo.10.2020.07.28.16.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 16:05:34 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org
Subject: [PATCH v2 01/14] dt-bindings: iio: Add bindings for sx9310 sensor
Date:   Tue, 28 Jul 2020 17:05:07 -0600
Message-Id: <20200728170317.v2.1.I0925046377211b8b6f06764857f03b4ab592bddb@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200728230520.2011240-1-campello@chromium.org>
References: <20200728151258.1222876-1-campello@chromium.org>
 <20200728230520.2011240-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adds device tree bandings for sx9310 sensor.

Signed-off-by: Daniel Campello <campello@chromium.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Rob Herring <robh+dt@kernel.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
[swboyd@chromium.org: Add both regulators and make them optional]
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v2:
 - Added #io-channel-cells as a required property

 .../iio/proximity/semtech,sx9310.yaml         | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
new file mode 100644
index 00000000000000..5739074d3592fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/semtech,sx9310.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Semtech's SX9310 capacitive proximity sensor
+
+maintainers:
+  - Daniel Campello <campello@chromium.org>
+
+description: |
+  Semtech's SX9310/SX9311 capacitive proximity/button solution.
+
+  Specifications about the devices can be found at:
+  https://www.semtech.com/products/smart-sensing/sar-sensors/sx9310
+
+properties:
+  compatible:
+    enum:
+      - semtech,sx9310
+      - semtech,sx9311
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      The sole interrupt generated by the device used to announce the
+      preceding reading request has finished and that data is
+      available or that a close/far proximity event has happened.
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
+        compatible = "semtech,sx9310";
+        reg = <0x28>;
+        interrupt-parent = <&pio>;
+        interrupts = <5 IRQ_TYPE_LEVEL_LOW 5>;
+        vdd-supply = <&pp3300_a>;
+        svdd-supply = <&pp1800_prox>;
+        #io-channel-cells = <1>;
+      };
+    };
-- 
2.28.0.163.g6104cc2f0b6-goog

