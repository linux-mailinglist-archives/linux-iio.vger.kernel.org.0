Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A151A6F7F
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 00:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389706AbgDMWud (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 18:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389708AbgDMWpD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 18:45:03 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE0EC0A3BDC
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2020 15:46:04 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id e4so7846124ils.4
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2020 15:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U8ft0PCgLSj/XwqRjt7ffOyiW+03oOAbUaTH5eakoi0=;
        b=XE71KRyoOEYXWFFUMs/e8yyucF/BAH/GMwKTaOE4AW8F/zm9XRBNsw6uv9RuFo1U3Z
         B6srSYc5YWNndnbMO3zsH1ymmUYicBtjGpZUBA3d6Cj7m7QJBYEq3srfiUipnX3Lz7o6
         eek235OoOnkwAZ/4nQM5M8KMMH0zbG+7M+bnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U8ft0PCgLSj/XwqRjt7ffOyiW+03oOAbUaTH5eakoi0=;
        b=j0UbxAhZnlaK+snsHPVwjV1isN+53EZFNzqsfLmSkQ1SoVNIFSGIrlvGO8m99V3R7C
         zkEMod9ldFGztTLLh3jjcEIKHaahcHGrTP3bUuaBmoS2sOR1C2fG9T8E+I7015poHRna
         iQCpSRL6PAcERsp+tYx6LlHHPSS8MrS1HZWfcxZsfNFptYg7mWDp8l7SF30N76W5Lp7t
         NxX42fpkqdnjEVTi8Vgipw1ikRmPmXtEsjfKkw4auR6m7i8cgmwMKeDtlX4qIn6hTRyG
         A5AKuyjb9i9tcGhSz3vaYqnv8ZK4tCnaGZPEcoCEJkrojijjAoRM/Ji/VeRuYY/cxISY
         f+ug==
X-Gm-Message-State: AGi0PuaVC2L6rzW0NsC6bmFwy8SqVgDQOhQ4PPDDQHmNQWY54F+SxwF1
        23mPtqx1/OclUmqd7sBduqIUUg==
X-Google-Smtp-Source: APiQypLa8UGkmbY+/1rokMnQj7w4oKrLZHxV8DH3f60LVUeO8OB9t3navmDJlMIY7ZD30i4y9jeLFA==
X-Received: by 2002:a92:48cb:: with SMTP id j72mr19323869ilg.162.1586817963694;
        Mon, 13 Apr 2020 15:46:03 -0700 (PDT)
Received: from derch.Home (75-166-136-192.hlrn.qwest.net. [75.166.136.192])
        by smtp.gmail.com with ESMTPSA id n5sm3837293iop.23.2020.04.13.15.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 15:46:03 -0700 (PDT)
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
Subject: [PATCH v9 1/2] dt-bindings: iio: Add bindings for sx9310 sensor
Date:   Mon, 13 Apr 2020 16:45:56 -0600
Message-Id: <20200413164402.v9.1.I6ed779cd21abf3e70f21c1562bbda81f590976ab@changeid>
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

