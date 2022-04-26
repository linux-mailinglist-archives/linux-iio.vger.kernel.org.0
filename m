Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD0250FE74
	for <lists+linux-iio@lfdr.de>; Tue, 26 Apr 2022 15:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350766AbiDZNOl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Apr 2022 09:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350730AbiDZNOc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Apr 2022 09:14:32 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA77160A94;
        Tue, 26 Apr 2022 06:11:20 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d5so10209215wrb.6;
        Tue, 26 Apr 2022 06:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TMOavQxWrrTel8vmNQCb3OLZWpjveuECwxNG5yTcW58=;
        b=E6Z3LJv2VyjxdKTtKGXl4tiP6Af2EbpVcUeLbiJsRW8rn+HlQ1ReWnA4PhVPqvihAJ
         NiMqXl3J61vRXp+k2erjoh2kux7sQwjoLsiWu1WWh97lHcpAsdN8jRKV2x8d1+8Pv/7i
         dRkoQZWA2udk6Bj96S0J+yHZUalSr+oJQoawL+8GUwIgmnUDsFqruCa0+iMLxn8xjBmn
         4/UThDQFtB2xH+Al7lIqcooJaMDzSx4t+SIObgqVvtbABrCGG3Vxjav74QYCV8Z7g4sR
         aQ/pcb3onPG051d5Tgr0k8mSkL/TUvQJJl0LObdki9pI7S6N0EJ3bRPPGRe+TRGy6HHW
         xO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TMOavQxWrrTel8vmNQCb3OLZWpjveuECwxNG5yTcW58=;
        b=WDBzTrPr9sVQcuMQBV57IpZO37gPOaHhpWu4FNEVV9tdpfSUfr358A/GY6gvMCiydt
         mr5A/j83xbAItR65AJUKRomT6PanHZ74BnjI2D+IU52ilhaV2rdL/tdRlq+q/NMkA6Nv
         YaIhnaQ5px8ZaLAXZ3aHcahsmkuG7jkJCE9JWCYa03MrVnGUtQRbR6t2FF1U1vrCtmyb
         G4i0R2IfIM55oaqIcsP4vpK9lL56S0lq6wDY+06Z0yyTDfVgbcXe43GDARMLDmMLOXt+
         SNjUJvoIBws2dEg+BPU8M7gK5Z5sOWnPZhlCRs1SE2HboUgEQ+f2ofzX9mbi9tZTHsyk
         Vh5w==
X-Gm-Message-State: AOAM531hRhsZ0RWF3KaFhiFfgVYhtgKMt60g8+SMNv8emjoaGJM0Z2gf
        9Fr1yMyj+Qra8XyvKaw4qPk=
X-Google-Smtp-Source: ABdhPJxkVnbdd83GE8OVu/tBulbJEeOGKDh7W+GdUNOQbQBcIEpQJ8WZRy8ESQLTb8kX7jbT7DbFhg==
X-Received: by 2002:a5d:6d0b:0:b0:20a:d43f:4002 with SMTP id e11-20020a5d6d0b000000b0020ad43f4002mr12661967wrq.230.1650978679178;
        Tue, 26 Apr 2022 06:11:19 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b00393f01c8f00sm3262910wmq.47.2022.04.26.06.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:11:18 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>,
        Rob Herring <robh@kernel.org>
Subject: [v5 11/14] dt-bindings: iio/imu: Add Bosch BNO055
Date:   Tue, 26 Apr 2022 15:10:59 +0200
Message-Id: <20220426131102.23966-12-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426131102.23966-1-andrea.merello@gmail.com>
References: <20220426131102.23966-1-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Andrea Merello <andrea.merello@iit.it>

Introduce new documentation file for the Bosch BNO055 IMU.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/imu/bosch,bno055.yaml        | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml
new file mode 100644
index 000000000000..e0d06db161a9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/bosch,bno055.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch BNO055
+
+maintainers:
+  - Andrea Merello <andrea.merello@iit.it>
+
+description: |
+  Inertial Measurement Unit with Accelerometer, Gyroscope, Magnetometer and
+  internal MCU for sensor fusion
+  https://www.bosch-sensortec.com/products/smart-sensors/bno055/
+
+properties:
+  compatible:
+    enum:
+      - bosch,bno055
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    serial {
+      imu {
+        compatible = "bosch,bno055";
+        reset-gpios = <&gpio0 54 GPIO_ACTIVE_LOW>;
+        clocks = <&imu_clk>;
+      };
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      imu@28 {
+        compatible = "bosch,bno055";
+        reg = <0x28>;
+        reset-gpios = <&gpio0 54 GPIO_ACTIVE_LOW>;
+        clocks = <&imu_clk>;
+      };
+    };
-- 
2.17.1

