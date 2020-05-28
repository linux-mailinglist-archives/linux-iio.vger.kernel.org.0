Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CA51E651B
	for <lists+linux-iio@lfdr.de>; Thu, 28 May 2020 17:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403873AbgE1O7R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 May 2020 10:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403770AbgE1O7Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 May 2020 10:59:16 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B56C08C5C6;
        Thu, 28 May 2020 07:59:16 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id f89so13052080qva.3;
        Thu, 28 May 2020 07:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sSqgkSNWDchYX02JVpVT7h410DZp94lYcg1ZkOOZGG8=;
        b=dxqJKHjbf3vz2c+HsLxNVXRgyUpKB9D/by0n4SDRC7uj3LcyC28/W7GG6SjSE3QxhY
         OR6/KtJDY8EiqOp6Wid+ewb4u0Iw8Lu+JgX/pGimHsTDJtXiUS6C85SPFHwhgQlVDC4d
         enSEhUQloqxKHFcEGIgtNur7SWZc/0+anhhEdClRCiDJP+NAtzEsX1ocNjh7I5NgX992
         yFv1OjCk+ZhP7/AfedurA9eQYuADAxBK7nBu5QxWC87di41ouI4U0dUko2pMwXOxknfx
         lgPE7BljfoWLBr6SMrZFKEpmF6vl8lYTvh5vTvz3DkzhF4aJg1PpglQXNLNJO5x0dEWx
         +z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sSqgkSNWDchYX02JVpVT7h410DZp94lYcg1ZkOOZGG8=;
        b=G1AwKnQJs1uBOjvvhbUiaCGFnxx/RIfSI216REP5vr/lxzLL2kx4C3D+zf7xDf4INR
         6xVBfwpz1rnD5elbEbKI5iYjeVgXqctUJubsm5UDrv1ewAJ15F2GU3sNxinqDYpusFzi
         fCP63mlcuxas1DhdcjSrDPit1fyQkb0d5WIK9ZI1zq3PyioB3CD3nrHiXI4GEiWUPd5h
         9zIbceOu96y7ZSnrLrUFXb85mAq0WcFW8sox4UAAf08NuSRlfBHqyF8+rO+LpN80EcMn
         Lxcte9xknPFxRDZTkKEbaM/voe9M5qioZMeOgYIM1RUi7MHecWvHWtpBgmkwNegZCdfk
         2sfQ==
X-Gm-Message-State: AOAM532inSJvTQm6Qo9seMsUl2pjhATdqVGD9ktbirouAY+/BP3WXTXA
        McH8UbgAjNDep63Q3/+6VFCGtVaIU5A=
X-Google-Smtp-Source: ABdhPJyh5ype8e2Rhru9HLZygxSVaTRGvDlXVteUVArcbFUMVzuofGOdlOErf/E1it5Viebfdx12nA==
X-Received: by 2002:a0c:8c4a:: with SMTP id o10mr3542223qvb.123.1590677954685;
        Thu, 28 May 2020 07:59:14 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id a38sm5925179qtb.37.2020.05.28.07.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:59:13 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v7 2/5] dt-bindings: iio: magnetometer: ak8975: convert format to yaml, add maintainer
Date:   Thu, 28 May 2020 16:58:47 +0200
Message-Id: <20200528145851.11791-1-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Converts documentation from txt format to yaml.

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
---
 .../bindings/iio/magnetometer/ak8975.txt      | 37 ---------
 .../iio/magnetometer/asahi-kasei,ak8975.yaml  | 77 +++++++++++++++++++
 2 files changed, 77 insertions(+), 37 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
deleted file mode 100644
index 0576b9df0bf2..000000000000
--- a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-* AsahiKASEI AK8975 magnetometer sensor
-
-Required properties:
-
-  - compatible : should be "asahi-kasei,ak8975".
-  - reg : the I2C address of the magnetometer.
-
-Optional properties:
-
-  - gpios : AK8975 has a "Data ready" pin (DRDY) which informs that data
-      is ready to be read and is possible to listen on it. If used,
-      this should be active high. Prefer interrupt over this.
-
-  - interrupts : interrupt for DRDY pin. Triggered on rising edge.
-
-  - vdd-supply: an optional regulator that needs to be on to provide VDD.
-
-  - mount-matrix: an optional 3x3 mounting rotation matrix.
-
-Example:
-
-ak8975@c {
-        compatible = "asahi-kasei,ak8975";
-        reg = <0x0c>;
-        interrupt-parent = <&gpio6>;
-        interrupts = <15 IRQ_TYPE_EDGE_RISING>;
-        vdd-supply = <&ldo_3v3_gnss>;
-        mount-matrix = "-0.984807753012208",  /* x0 */
-                       "0",                   /* y0 */
-                       "-0.173648177666930",  /* z0 */
-                       "0",                   /* x1 */
-                       "-1",                  /* y1 */
-                       "0",                   /* z1 */
-                       "-0.173648177666930",  /* x2 */
-                       "0",                   /* y2 */
-                       "0.984807753012208";   /* z2 */
-};
diff --git a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
new file mode 100644
index 000000000000..55b18784e503
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/asahi-kasei,ak8975.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AsahiKASEI AK8975 magnetometer sensor
+
+maintainers:
+  - Jonathan Albrieux <jonathan.albrieux@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+        - asahi-kasei,ak8975
+        - asahi-kasei,ak8963
+        - asahi-kasei,ak09911
+        - asahi-kasei,ak09912
+      - enum:
+        - ak8975
+        - ak8963
+        - ak09911
+        - ak09912
+        deprecated: true
+
+  reg:
+    maxItems: 1
+
+  gpios:
+    maxItems: 1
+    description: |
+      AK8975 has a "Data ready" pin (DRDY) which informs that data
+      is ready to be read and is possible to listen on it. If used,
+      this should be active high. Prefer interrupt over this.
+
+  interrupts:
+    maxItems: 1
+    description: interrupt for DRDY pin. Triggered on rising edge.
+
+  vdd-supply:
+    maxItems: 1
+    description: |
+      an optional regulator that needs to be on to provide VDD power to
+      the sensor.
+
+  mount-matrix:
+    description: an optional 3x3 mounting rotation matrix.
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        magnetometer@c {
+            compatible = "asahi-kasei,ak8975";
+            reg = <0x0c>;
+            interrupt-parent = <&gpio6>;
+            interrupts = <15 IRQ_TYPE_EDGE_RISING>;
+            vdd-supply = <&ldo_3v3_gnss>;
+            mount-matrix = "-0.984807753012208",  /* x0 */
+                           "0",                   /* y0 */
+                           "-0.173648177666930",  /* z0 */
+                           "0",                   /* x1 */
+                           "-1",                  /* y1 */
+                           "0",                   /* z1 */
+                           "-0.173648177666930",  /* x2 */
+                           "0",                   /* y2 */
+                           "0.984807753012208";   /* z2 */
+        };
+    };
-- 
2.17.1

