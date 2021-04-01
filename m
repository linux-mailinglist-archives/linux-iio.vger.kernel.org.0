Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3CF3518ED
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 19:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbhDARsN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 13:48:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236463AbhDARpC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Apr 2021 13:45:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E0CB6112E;
        Thu,  1 Apr 2021 17:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617298988;
        bh=UkBJ3TPaqOhgNhsmcELZeSyEXojAw6LG7Ou09rNFPzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MCM1K8/GkUbQaIYihixSAtruO6JJFOouJR5LzzUEcVPW0/cLhttU+v3x+V/9EgX96
         uU5fQdhW7NPhjRbgT/iN7N/OAPvwlumQuE6CNo/4ypnbW9IYeRIjwWwR4e13CDwmEv
         52H9Dno+dsHxSKuP12ZCpHBgbsSua7vQw2q8w4e/p0VQonKzFsuNaRQhBBjVzAIuXa
         MWfig6gSOg8NkQ0VZdqTdShjbW+kROLPqONHe4jkG3QnvIg+0QEU2W6idVJP/xdivq
         6Lq08UdHgUyz5CP/8BmkjPbgY4V9n+g8gObvnnqaVqNqB0+Niqrxt8AoLBqg+ZWU/W
         W4oeWiRXIH8zw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/6] dt-bindings:iio:accel:adis16201 and adis16209 bindings
Date:   Thu,  1 Apr 2021 18:41:07 +0100
Message-Id: <20210401174112.320497-2-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210401174112.320497-1-jic23@kernel.org>
References: <20210401174112.320497-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These two devices have different internal characterstics, but their
external connectivity and as a result device tree descriptions are
identical.

Note that neither driver in Linux currently has an of_match_table
but instead rely on matching via name alone.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../bindings/iio/accel/adi,adis16201.yaml     | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
new file mode 100644
index 000000000000..6f8f8a6258fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/adi,adis16201.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADIS16201 Dual Axis Inclinometer and similar
+
+maintainers:
+  - Jonathan Cameron <Jonathan.Cameron@huawei.com>
+
+description: |
+  Two similar parts from external interface point of view.
+  SPI interface.
+    https://www.analog.com/en/products/adis16201.html
+    https://www.analog.com/en/products/adis16209.html
+
+properties:
+  compatible:
+    enum:
+      - adi,adis16201
+      - adi,adis16209
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  vdd-supply: true
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
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        accelerometer@0 {
+            compatible = "adi,adis16201";
+            reg = <0>;
+            spi-max-frequency = <2500000>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+...
-- 
2.31.1

