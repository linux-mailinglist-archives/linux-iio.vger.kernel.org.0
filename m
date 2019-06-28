Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 965B75A2E1
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2019 19:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfF1R5Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Jun 2019 13:57:24 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57592 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfF1R5Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Jun 2019 13:57:24 -0400
Received: from hades.home (unknown [IPv6:2a00:23c5:58d:db00:36ee:cfb1:e0d:7749])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: martyn)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8FD1A260D87;
        Fri, 28 Jun 2019 18:57:22 +0100 (BST)
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@lists.collabora.co.uk, devicetree@vger.kernel.org,
        Martyn Welch <martyn.welch@collabora.com>
Subject: [PATCH v2 1/2] dt-bindings: Add binding document for NOA1305
Date:   Fri, 28 Jun 2019 18:57:12 +0100
Message-Id: <20190628175713.14831-1-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document the ON Semiconductor NOA1305 ambient light sensor devicetree
bindings.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---

Changes:
v2: Same as v1.

 .../bindings/iio/light/noa1305.yaml           | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/noa1305.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/noa1305.yaml b/Documentation/devicetree/bindings/iio/light/noa1305.yaml
new file mode 100644
index 000000000000..17e7f140b69b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/noa1305.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/noa1305.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ON Semiconductor NOA1305 Ambient Light Sensor
+
+maintainers:
+  - Martyn Welch <martyn.welch@collabora.com>
+
+description: |
+  Ambient sensing with an i2c interface.
+
+  https://www.onsemi.com/pub/Collateral/NOA1305-D.PDF
+
+properties:
+  compatible:
+    enum:
+      - onnn,noa1305
+
+  reg:
+    maxItems: 1
+
+  vin-supply:
+    description: Regulator that provides power to the sensor
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light@39 {
+                compatible = "onnn,noa1305";
+                reg = <0x39>;
+        };
+    };
+...
-- 
2.20.1

