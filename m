Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D821A8A26
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 20:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504400AbgDNStu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 14:49:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504396AbgDNSts (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Apr 2020 14:49:48 -0400
Received: from localhost.localdomain (unknown [157.50.36.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C6132076B;
        Tue, 14 Apr 2020 18:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586890187;
        bh=8NmgVLUUS5Ln4TZqfeKplY2vLy6j085/h6+xraogB48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CK4zjV0iA7nQN2lOvbGoepnHCPMGd9RKIt95yNpaJzS5Q1rTcW/C8EMxOioHeVtQ9
         PWH3NOteDtcRXiI6zWoAqqRtv7ZSuNcrmUHGTRjdWJknuxR5eysX/rLfqkeU3YZWrr
         SEHvmLryz6JgwUYp/WqAOW/bP/3cNYKB+rj0eNB0=
From:   mani@kernel.org
To:     jic23@kernel.org, robh+dt@kernel.org, narcisaanamaria12@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [RESEND PATCH v3 1/3] dt-bindings: iio: chemical: Add binding for CCS811 VOC sensor
Date:   Wed, 15 Apr 2020 00:19:28 +0530
Message-Id: <20200414184930.5576-2-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200414184930.5576-1-mani@kernel.org>
References: <20200414184930.5576-1-mani@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

This commit adds devicetree binding for AMS CCS811 VOC sensor.

Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 .../bindings/iio/chemical/ams,ccs811.yaml     | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml b/Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml
new file mode 100644
index 000000000000..5cb068666a3e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/chemical/ams,ccs811.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMS CCS811 VOC Sensor
+
+maintainers:
+  - Narcisa Vasile <narcisaanamaria12@gmail.com>
+
+description: |
+  Ultra-Low Power Digital Gas Sensor for Monitoring Indoor Air Quality.
+
+properties:
+  compatible:
+    enum:
+      - ams,ccs811
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    description: GPIO connected to the nRESET line. This is an active low
+                 input to CCS811.
+    maxItems: 1
+
+  wakeup-gpios:
+    description: GPIO connected to the nWAKE line. This is an active low
+                 input to CCS811.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      voc@5b {
+        compatible = "ams,ccs811";
+        reg = <0x5b>;
+        reset-gpios = <&gpioa 11 GPIO_ACTIVE_LOW>;
+        wakeup-gpios = <&gpioa 12 GPIO_ACTIVE_LOW>;
+      };
+    };
+
+...
-- 
2.17.1

