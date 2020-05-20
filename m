Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78DD1DB99D
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 18:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgETQe7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 12:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETQe6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 12:34:58 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFC2C061A0E;
        Wed, 20 May 2020 09:34:58 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d7so3003315qtn.11;
        Wed, 20 May 2020 09:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4DcJwL2bU+Q1cyGNmrdNE1LFRPb0Wm0rIUdCoQbv6t8=;
        b=qf7BxExE0J9oLfvmPOqyphafL+TXfeyhAP1CgcgPqBwFVZx8cJjl+9GrNOOYTaccx9
         9zBEsCjMT94/7h+ofxek0485ak8taGeJApSxO9bWCD8aTjIkKZFloHpZyCFiXmCKlQon
         d09OGbmY1eOvi/Ho9ZCiLx1Rle11XJPO4Wua5ER1hCBt6GRfO2/RSiQ1bLyGRXjOyXfc
         3edCaAOT3R+arpPrKmGqKwzTDj8AAf13OFXt/FqntZBON819WsQxec622o4OifICNo51
         0JcTe38kzdrnmTVSKmk7EfcVyPiDfpVx06RVtC6leaEV86jADHkGnqcKipBNZbjXDoT+
         HmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4DcJwL2bU+Q1cyGNmrdNE1LFRPb0Wm0rIUdCoQbv6t8=;
        b=hpwZNud1zyw7hty6L8IJcYM0CfDdg8oSPHr8XQo83CAKX5Ovian9E1X7fzQhK3cB7a
         qe6BQ4jKkPYIrWR+qKqUXlvCDiZNzyCn4atyFKmcvDPDfwLSKbRYYbCj1kgLWw22Smww
         qF0BW4DlA0lYlcO+Sa6OikZ5SacXMjdoqLyOjYfOb0EfiaT7PDJ9zpW6JcRiRS3d4W7i
         QNxGHkQEhfnNzcNcAx6c46GkkGyEAhB/6ShAp+2OoawRfUu1Xw2bSIzrTXEYZFW1rlXv
         eELeERKTX9M/T6NSjZsioL0TnC+3v6o/3LuZ+YsjJfFCvFmQeAAA4PyFkz3rt/C2iRB6
         GzNQ==
X-Gm-Message-State: AOAM532xWQPv0KCgvyKs6mE9UKaPvrWPllR67eVqLAwdcvrQSd9cMhNS
        bUomwbwNIF35QSMiPcVwEhGAQlfgZ+g8tQ==
X-Google-Smtp-Source: ABdhPJwh18cjMohI6agOjoqojb3Df1BhgY/cyVXPTJDLct010vimClSnkMuQ8lFm7BD8IwPfBhy3Kg==
X-Received: by 2002:ac8:3693:: with SMTP id a19mr6233689qtc.226.1589992496704;
        Wed, 20 May 2020 09:34:56 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id q59sm2803261qtd.73.2020.05.20.09.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 09:34:55 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v5 1/4] dt-bindings: iio: magnetometer: ak8975: convert format to yaml, add maintainer
Date:   Wed, 20 May 2020 18:34:06 +0200
Message-Id: <20200520163417.27805-2-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520163417.27805-1-jonathan.albrieux@gmail.com>
References: <20200520163417.27805-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Converts documentation from txt format to yaml.

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
---
 .../bindings/iio/magnetometer/ak8975.txt      | 30 --------
 .../bindings/iio/magnetometer/ak8975.yaml     | 71 +++++++++++++++++++
 2 files changed, 71 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
deleted file mode 100644
index aa67ceb0d4e0..000000000000
--- a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-* AsahiKASEI AK8975 magnetometer sensor
-
-Required properties:
-
-  - compatible : should be "asahi-kasei,ak8975"
-  - reg : the I2C address of the magnetometer
-
-Optional properties:
-
-  - gpios : should be device tree identifier of the magnetometer DRDY pin
-  - vdd-supply: an optional regulator that needs to be on to provide VDD
-  - mount-matrix: an optional 3x3 mounting rotation matrix
-
-Example:
-
-ak8975@c {
-        compatible = "asahi-kasei,ak8975";
-        reg = <0x0c>;
-        gpios = <&gpj0 7 0>;
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
diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
new file mode 100644
index 000000000000..8bde423a2ffa
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/ak8975.yaml#
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
+      - const: asahi-kasei,ak8975
+      - const: asahi-kasei,ak8963
+      - const: asahi-kasei,ak09911
+      - const: asahi-kasei,ak09912
+      - const: ak8975
+        deprecated: true
+      - const: ak8963
+        deprecated: true
+      - const: ak09911
+        deprecated: true
+      - const: ak09912
+        deprecated: true
+
+  reg:
+    maxItems: 1
+    description: the I2C address of the magnetometer
+
+  gpios:
+    description: should be device tree identifier of the magnetometer DRDY pin
+
+  vdd-supply:
+    maxItems: 1
+    description: |
+      an optional regulator that needs to be on to provide VDD power to
+      the sensor.
+
+  mount-matrix:
+    description: an optional 3x3 mounting rotation matrix
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c@78b7000 {
+        reg = <0x78b6000 0x600>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        magnetometer@c {
+            compatible = "asahi-kasei,ak8975";
+            reg = <0x0c>;
+            gpios = <&gpj0 7 GPIO_ACTIVE_HIGH>;
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

