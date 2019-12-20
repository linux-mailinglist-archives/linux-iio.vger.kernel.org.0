Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4642128070
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2019 17:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfLTQRF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 20 Dec 2019 11:17:05 -0500
Received: from sender4-op-o11.zoho.com ([136.143.188.11]:17123 "EHLO
        sender4-op-o11.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfLTQRE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Dec 2019 11:17:04 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1576858594; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=eq/PtXIpmw8mnC3IWs3ti6rwVt+8SKQesioHqGCPfXU8Gvon3nTKKZ617L5z8gRyElOrP3Lc0S03iuwZWo7Enmy3oNdsj3MsUG2iDzAB6YOF3d8XD7lYGjhwhn6m3m3oN3hNFod6Rxdm0wjiTWKGVEoEiHBoIU/2juudX2b168I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1576858594; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=pLwgZ0YyOJqDcJRvT8Lzm1i6k9X19Sta8/0yJwxoJ7A=; 
        b=P9qM5KGlCvWBU0Qna9BgDKViikETbUeJkPAc8EfDc1fjYEakKj4HMMKXXVBvcmn4IYCvQj7NQXkbKKAyLxcYafWvsPEOChb7VGUYNeUPB1DJwUU4Uby2O/XkvxEKlUp9SlJ/y3rDH1OE9XvXz///JVZVxDJ7yc1d6qiluPVwoTM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie.verizon.net (pool-173-73-58-202.washdc.fios.verizon.net [173.73.58.202]) by mx.zohomail.com
        with SMTPS id 1576858592422244.36209695534615; Fri, 20 Dec 2019 08:16:32 -0800 (PST)
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dan Robertson <dan@dlrobertson.com>
Message-ID: <20191220160051.26321-2-dan@dlrobertson.com>
Subject: [PATCH v8 1/3] dt-bindings: iio: accel: bma400: add bindings
Date:   Fri, 20 Dec 2019 16:00:49 +0000
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191220160051.26321-1-dan@dlrobertson.com>
References: <20191220160051.26321-1-dan@dlrobertson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add devicetree binding for the Bosch BMA400 3-axes ultra-low power
accelerometer sensor.

Signed-off-by: Dan Robertson <dan@dlrobertson.com>
---
 .../bindings/iio/accel/bosch,bma400.yaml      | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
new file mode 100644
index 000000000000..e87cb636b3e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/bosch,bma400.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch BMA400 triaxial acceleration sensor
+
+maintainers:
+  - Dan Robertson <dan@dlrobertson.com>
+
+description: |
+  Acceleration and temerature iio sensors with an i2c interface
+
+  Specifications about the sensor can be found at:
+    https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMA400-DS000.pdf
+
+properties:
+  compatible:
+    enum:
+      - bosch,bma400
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: phandle to the regulator that provides power to the accelerometer
+
+  vddio-supply:
+    description: phandle to the regulator that provides power to the sensor's IO
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      accelerometer@14 {
+        compatible = "bosch,bma400";
+        reg = <0x14>;
+        vdd-supply = <&vdd>;
+        vddio-supply = <&vddio>;
+        interrupt-parent = <&gpio0>;
+        interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+      };
+    };


