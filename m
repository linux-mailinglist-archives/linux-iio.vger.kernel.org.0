Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071ED4797CF
	for <lists+linux-iio@lfdr.de>; Sat, 18 Dec 2021 01:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhLRA1M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Dec 2021 19:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhLRA1L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Dec 2021 19:27:11 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC4BC061574
        for <linux-iio@vger.kernel.org>; Fri, 17 Dec 2021 16:27:11 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u17so3190645plg.9
        for <linux-iio@vger.kernel.org>; Fri, 17 Dec 2021 16:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=isQQGTvLXGVawQ/6LHvnhH11lpUJkDdWpQSGYk/3EVM=;
        b=aA+p5IL9jhS+L/258KCXms0mcEKNYJ14JzdLTNmg0lJZhVskdoiDnVMLD2mWFNuMBG
         mB0oPL7/PpmEngLFZNcYI6fmhfVYRJvdcuOqvOD5nKl9SidbEpgUtrRbyo4cZTAoNQWX
         mEgcxhAZV1hEu4N91pcthfwEb8sTQhIQwDNKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=isQQGTvLXGVawQ/6LHvnhH11lpUJkDdWpQSGYk/3EVM=;
        b=598Z6vqp6Rhkd53d9q34ELlc38ROqKkVTL5Cz/B9c+R7on4m/najSihPt2WzRe9yjn
         1ujtjrJXKXI9zz9CjrphGQVDmBmfQX8l6aHnW56eGAQxL7mZwydfS5qdaT1pcnPZhkrC
         CjmfOm/eYpyGPcI7XWfX1fb7E16n6/9n9DeZXF///Ry38yxxFbUSCSK4ZDUKknokRDCx
         DmOCajpHCOevKigSTq54ivAsfx6iyAwKKZncR0qVprv5dYVoBwgwE8p9s87S/d59OTHf
         lItN3k4siovBk7qmn1cuHssG1erQlwwHpCCp9ZrZ4jE/WtGKiLcc69/pZdDpznDmZhcD
         nnCQ==
X-Gm-Message-State: AOAM5310kAD8oSn1OhkzL4WF+U9dLaJmD0hVg+jNKeHts2pxlq40pwA3
        CfcbENffZSFr/vpTZ2SsP+h7gd4jEzvhmg==
X-Google-Smtp-Source: ABdhPJwMeB8qrVd8e/xKNjNSrWQkUw6ghwJ66IkFi2loslzrGVWoBvebXDzlV5SVttGa/rOTY4WkCg==
X-Received: by 2002:a17:90a:7e89:: with SMTP id j9mr6551911pjl.162.1639787231172;
        Fri, 17 Dec 2021 16:27:11 -0800 (PST)
Received: from localhost ([2620:15c:202:201:2bc8:cefc:f407:829])
        by smtp.gmail.com with UTF8SMTPSA id m2sm4028177pjh.36.2021.12.17.16.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 16:27:10 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 2/3] dt-bindings: iio: Add sx9360 binding
Date:   Fri, 17 Dec 2021 16:27:04 -0800
Message-Id: <20211218002705.3099096-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
In-Reply-To: <20211218002705.3099096-1-gwendal@chromium.org>
References: <20211218002705.3099096-1-gwendal@chromium.org>
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
2.34.1.173.g76aa8bc2d0-goog

