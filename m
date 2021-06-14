Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E976A3A6BEC
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 18:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbhFNQgo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 12:36:44 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:16074 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbhFNQgn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Jun 2021 12:36:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623688474; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=U9Tfp7qEvpwz9OiFVDCvuHYbuKZe0w84wiQyG8O7oZxlnNPGbkYK09oJivPz87UGKa
    pp3+RbElwjOPukcE7uL6o1VtI/YVKTmef2xjcz6Y9Xx3xO6e66tiYKDNwgNL1kYLHzHG
    qOvw+xcQYl1ZLtVh2nU5KpSfKCRu4KmZjSjvmLQn8oZvJM3hp4dRhOt1AFEof0A/QkiM
    HtnuFnkZJfKwYwlc7ZDyFeazMxGkHRH+G3bAhGR3wL8ABen53LjZxhrxFFSH2Fj6Mhih
    h6MiynY+zMuQgL1bYQ1MKmZIXzACuXwn75r/rOReH7nEPiS5ZSlVqmeoQ/WnzavLr4uK
    YRxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623688474;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=TkCkr66Py500kfFxk4uS9H7RnUOJ4ufKIbC+kvyfOQE=;
    b=nlnVXbFaSxYdcf91eHmEhMQqRFMBB9Fzt1gjkaPIVS98mbkOI7l0vFMC6binunMc2y
    4hPotagjmhe7P6LvXWRMWv42nRsHCfo3EtOM8VrVTySizQg9eYFmD6sHr+6pDzzMQEx6
    jIP50jsFgtinfh2u6US/lEk24iAUu6RAVj5L9RUPS81rDsR75EXuc+QCLDYiHG/yZ/bu
    L/x8M0jiWTPE28X0Gg/b4d7W8+nrj73EHjkGP2lUlh/iNnE5YLKD63iDsrS0mTkdX4E6
    fYC+F9+GnA9kTuExYokGpfZZxQ3RbCDE/fpZmpqoMFLKVVMjS3IzgWYHN83R4Itlrqc8
    rbmQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623688474;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=TkCkr66Py500kfFxk4uS9H7RnUOJ4ufKIbC+kvyfOQE=;
    b=VHWOjFmP52BzoECTjTMHjTrd/6Xxqj528/cO3LX53c9Pd6wY4OvmFmOCmeA0GvDm8+
    M+EVOAQWwQiSDdjDVP1Vgrd1AIY/dVoLdYmpJ1s3bVFQON1IkANERXnUxQ6rd6AiwvFT
    FNSH+wsrsvelR9ZqqjfPJZNjp4v5YUr4hDIKx8I4ApNPIxVyGnc42hPSCl62RGeFT83d
    w+IifsJr0AeKj6DzKZtrhF5e7LdqBm1nrwljsHYT4XSXdydRmc1IwvabQtIHCrxJY0Y1
    PDwouZnwOdZ+19ows16/oFiHH2rXn/ayKnfhGDZHTXfCabEfAhygClxH9Fgx3lN25TlW
    Yp3w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA6m6NvdbT"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5EGYXJ6v
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 14 Jun 2021 18:34:33 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 3/3] dt-bindings: iio: accel: bma255: Merge bosch,bma180 schema
Date:   Mon, 14 Jun 2021 18:31:50 +0200
Message-Id: <20210614163150.7774-4-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614163150.7774-1-stephan@gerhold.net>
References: <20210614163150.7774-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In Linux the bma180 and bmc150-accel driver cover fairly similar chips
from Bosch (just with minor register differences). For the DT schema,
this does not make any difference: They both represent I2C/SPI devices,
have one or two interrupts plus a vdd/vddio-supply.

This means there is no need to duplicate the schema, we can just
document the compatibles for both drivers in a single DT schema.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Some additional notes:
  - The datasheet links in bma180 sadly seem all broken for me so
    I just dropped them.
  - I separated the bma180/bmc150-accel compatibles using a comment.
    This is just for clarity, it has no influence on the schema.
  - I added myself as second maintainer for the bma255 binding since
    Jonathan seemed to be happy to get unlisted for bma180. :)

In the future we could consider combining even more schemas.
In particular bosch,bma400.yaml and bosch,bmi088.yaml are also
almost identical, although they currently specify different interrupt
types. I think in general the situation for those Bosch sensors is
exactly the same: The sensors can be configured to either active-high
or active-low level. However, at the moment neither bma400 or bmi088
actually implement interrupt support. For now I kept those schemas
as-is, I think this is better left up for follow-up patches.
---
 .../bindings/iio/accel/bosch,bma180.yaml      | 61 -------------------
 .../bindings/iio/accel/bosch,bma255.yaml      |  9 +++
 2 files changed, 9 insertions(+), 61 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bma180.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma180.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma180.yaml
deleted file mode 100644
index a7e84089cc3d..000000000000
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma180.yaml
+++ /dev/null
@@ -1,61 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/iio/accel/bosch,bma180.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Bosch BMA023 / BMA150/ BMA180 / BMA250 / SMB380 triaxial accelerometers
-
-maintainers:
-  - Jonathan Cameron <jic23@kernel.org>
-
-description: |
-  https://media.digikey.com/pdf/Data%20Sheets/Bosch/BMA150.pdf
-  http://omapworld.com/BMA180_111_1002839.pdf
-  http://ae-bst.resource.bosch.com/media/products/dokumente/bma250/bst-bma250-ds002-05.pdf
-
-properties:
-  compatible:
-    enum:
-      - bosch,bma023
-      - bosch,bma150
-      - bosch,bma180
-      - bosch,bma250
-      - bosch,smb380
-
-  reg:
-    maxItems: 1
-
-  vdd-supply: true
-
-  vddio-supply: true
-
-  interrupts:
-    minItems: 1
-    maxItems: 2
-    description: |
-      Type should be either IRQ_TYPE_LEVEL_HIGH or IRQ_TYPE_EDGE_RISING.
-      For the bma250 the first interrupt listed must be the one
-      connected to the INT1 pin, the second (optional) interrupt
-      listed must be the one connected to the INT2 pin.
-
-required:
-  - compatible
-  - reg
-
-additionalProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/interrupt-controller/irq.h>
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-        accel@40 {
-            compatible = "bosch,bma180";
-            reg = <0x40>;
-            interrupt-parent = <&gpio6>;
-            interrupts = <18 (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_EDGE_RISING)>;
-        };
-    };
-...
diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
index f35c57b8105f..5b35856b1942 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
@@ -8,6 +8,7 @@ title: Bosch BMA255 and Similar Accelerometers
 
 maintainers:
   - Linus Walleij <linus.walleij@linaro.org>
+  - Stephan Gerhold <stephan@gerhold.net>
 
 description:
   3 axis accelerometers with varying range and I2C or SPI
@@ -16,6 +17,7 @@ description:
 properties:
   compatible:
     enum:
+      # bmc150-accel driver in Linux
       - bosch,bma222
       - bosch,bma222e
       - bosch,bma250e
@@ -26,6 +28,13 @@ properties:
       - bosch,bmc150_accel
       - bosch,bmi055_accel
 
+      # bma180 driver in Linux
+      - bosch,bma023
+      - bosch,bma150
+      - bosch,bma180
+      - bosch,bma250
+      - bosch,smb380
+
   reg:
     maxItems: 1
 
-- 
2.32.0

