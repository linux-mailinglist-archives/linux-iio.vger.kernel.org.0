Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197721A8C92
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 22:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633229AbgDNUgO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 16:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731593AbgDNUgM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 16:36:12 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E146C061A0C
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2020 13:36:12 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id i75so1053651ild.13
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2020 13:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/yoLZC4PI65ZGQO7pW9Hb3YwwOms2B6BK6ifzFp64c0=;
        b=LtG3c6OTD3OQNgT820KWIN5mGjhNfSrU75MGoulp68wDO+KMpCSQYj0MxjpS181n9I
         FccXjTZlGDkTZJUz/NTjjWQWZoAPLwV7asCXoDKKeE3jxesWOReZxdEuTgknxsc5s/iM
         2diVR0JnTfAKvWlrzgFsFC+QjRDcvygpO+aRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/yoLZC4PI65ZGQO7pW9Hb3YwwOms2B6BK6ifzFp64c0=;
        b=gjtikz6Iv80IWb3HY3/Z8XnfBYeZ9VJOpWabuPsOOYWVQhH/kSS7xZYKrDMAdvN63c
         yLPLnEw34tu9yntMGSSX2CLUW70nKAIBVXmDmFh8EwCQR4tmPw/ZxBZWfyAyn1Y3RF9Q
         Ep1pHRHiBAIDBIND2DIKDbBKFWETfzjesa7Xcvy7QqsdDUaa7Z15/6+j1zDuRp7+zQrY
         HibY5fqAwelDmD7fnXHZxEXbWZEIKhdOnROV8JTxi6A8eFrrP4zpnn635asmBo+kCX5B
         Bilf/ChAZnpyBawzoLrwiRE4Qyv3o94sP7Lrk5bhBIOJTIjAWiLXQE4QrK1vFnguVPy+
         aMXg==
X-Gm-Message-State: AGi0PuYUjpcNGIogGsfzWb22Tx9dxbrNFikUDQaDpjDssvAHK9xZzmiw
        QxAxIpR3vNSDzXHp9GogU+RJVg==
X-Google-Smtp-Source: APiQypKtKt93EXLNjXJXIvv6HGtk6C4GYtQ9sbKVz4bTqmtFJsbm0dKIGaQ9U2kvDDiJpoD/Qz6qwA==
X-Received: by 2002:a92:760f:: with SMTP id r15mr2189093ilc.202.1586896571990;
        Tue, 14 Apr 2020 13:36:11 -0700 (PDT)
Received: from derch.Home (97-122-91-129.hlrn.qwest.net. [97.122.91.129])
        by smtp.gmail.com with ESMTPSA id x10sm5396027ili.88.2020.04.14.13.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:36:11 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH v10 1/2] dt-bindings: iio: Add bindings for sx9310 sensor
Date:   Tue, 14 Apr 2020 14:36:07 -0600
Message-Id: <20200414143536.v10.1.I30e2a8ff8cc4ad1ffb65df09ad933e5b4d9f16f8@changeid>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adds device tree bandings for sx9310 sensor.

Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v10: None
Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2:
 - Added power-supply
 - Changed to dual license

 .../iio/proximity/semtech,sx9310.yaml         | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
new file mode 100644
index 00000000000000..b52ffdac678b54
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
@@ -0,0 +1,56 @@
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
+  power-supply: true
+
+required:
+  - compatible
+  - reg
+  - power-supply
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
+        power-supply = <...>;
+      };
+    };
-- 
2.26.0.110.g2183baf09c-goog

