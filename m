Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A5722D092
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jul 2020 23:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgGXVde (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jul 2020 17:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgGXVdd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2020 17:33:33 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCAEC0619E4
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 14:33:33 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id il6so447368pjb.0
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 14:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EQu0tFDBs7nTU9QjLdEGcqiYQ7Nm3KNjVk5VDWWffio=;
        b=R9EEgjxJkvQAvTFL/5/62WC78D5X3A48nYJuzZfaIMBVaXj4VDTNJds252rbo64URO
         IMuDmkbiwwEOv8zduzP/ZCHSxL6/34C7OfAHaNig9uV9mULzn8AHqL5i+Pl7fO+TqrQV
         wdy7ry/PclzuMQHtuKAzlb9EeYBDCQDNifTGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EQu0tFDBs7nTU9QjLdEGcqiYQ7Nm3KNjVk5VDWWffio=;
        b=n0EwxvPagnI8qu1Eo8LXckABbO3IAE2FY/TTuPxcUARn+hRMRJX7C9kX+/lBy70oGH
         Q13fPqbaVERW3/d+Web1jHPvz68IM2GmahbPn1hiWaz83e+dsilMpJwWSBCOb24Iu2G8
         hj0Yfea1/5ACQuHYRzDt6NrphDzqP/aVBLhELHkxbZMK144sWnFJzt3IYynLRdjAx3lG
         BO2d4alPXVkaP5OcWhatPhhJGN4BenoHwZFwjP+gTSmXxWnCVVwbAv6El5oOVEDSIj/n
         SymegRSZG6a9/f8o2ZJdPKToxeXz4ZXf97ShWEiMuaIPVZS6gXK8p+MFrIRsh93E33zN
         DZVg==
X-Gm-Message-State: AOAM5321W2R6GEXmhXhJxBYCLjYMQN2KJLr5z6SykGcDsbZ5Xk6LnoGm
        q8oCd2FAmDG+sUDYf8EDiA+EUg==
X-Google-Smtp-Source: ABdhPJz4N+iywNFXMFem3YoR0WagfRPgtF5OXhDcB+SHTCmfzr4ZNEB2Zs9RrcFUAi+LNawn/+9Cbg==
X-Received: by 2002:a17:90a:14a5:: with SMTP id k34mr7624743pja.37.1595626412535;
        Fri, 24 Jul 2020 14:33:32 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id z6sm7312919pfn.173.2020.07.24.14.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 14:33:31 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Daniel Campello <campello@chromium.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 1/5] dt-bindings: iio: Add bindings for sx9310 sensor
Date:   Fri, 24 Jul 2020 14:33:25 -0700
Message-Id: <20200724213329.899216-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200724213329.899216-1-swboyd@chromium.org>
References: <20200724213329.899216-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Daniel Campello <campello@chromium.org>

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
 .../iio/proximity/semtech,sx9310.yaml         | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
new file mode 100644
index 000000000000..ba734ee868c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
@@ -0,0 +1,60 @@
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
+required:
+  - compatible
+  - reg
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
+      };
+    };
-- 
Sent by a computer, using git, on the internet

