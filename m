Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFFF3CD3E9
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 13:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbhGSKtL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 06:49:11 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:30232 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbhGSKtI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 06:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1626694004;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=yqWNHaFT07H7dBsOX6TPZJo2FDypJbWmEZmGGz2Je2c=;
    b=AVv2KyLphBJqig8oAt/QI+SG8cygY8sgsaLFduc1bhhZam5XyNJObBZAk1dM9GGxoc
    qeqzUVMRaOH4IV/QiqYDAAaPkV4C+br+G/m0cPT5qkCn++wlpyZqDuQIl4/KWcsCCK6s
    0H2l7wQffBNztdvebf+rRs20FWzDIK39iR3JZISyGSUSSo1om50q2GFMtGo00zdbS1H4
    dDPCvYmHAhzIJc1ocetOL2DiwAYSiTip0K96nu3DAPm2naZCaCp64N8LdLE5JS3yY1sJ
    TlJB1bgzaxZ8dBvPA6Xru6mS2mXbnUBCJuht50sJEBGoaHJbKHIITmcKPOLZjKM7czGn
    QgAA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4m6O43/v"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.28.1 DYNA|AUTH)
    with ESMTPSA id g02a44x6JBQi27d
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 19 Jul 2021 13:26:44 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 2/4] dt-bindings: iio: accel: bma255: Add bosch,bmc156_accel
Date:   Mon, 19 Jul 2021 13:21:54 +0200
Message-Id: <20210719112156.27087-3-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210719112156.27087-1-stephan@gerhold.net>
References: <20210719112156.27087-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

BMC156 is very smilar to BMC150, but it has only one accelerometer
interrupt pin. It would make sense if only INT1 was exposed but someone
at Bosch was crazy and decided to only have an INT2 pin.

In this case, it does not make sense if the first interrupt pin is
treated as INT1 (since that pin does not exist). Add a note to the
bindings that the first interrupt pin is treated as INT2 for BMC156.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../bindings/iio/accel/bosch,bma255.yaml       | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
index 897a1d808ef5..f7848e4a7b29 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
@@ -26,6 +26,7 @@ properties:
       - bosch,bma255
       - bosch,bma280
       - bosch,bmc150_accel
+      - bosch,bmc156_accel
       - bosch,bmi055_accel
 
       # bma180 driver in Linux
@@ -49,6 +50,9 @@ properties:
       the second (optional) interrupt listed must be the one connected to the
       INT2 pin (if available). The type should be IRQ_TYPE_EDGE_RISING.
 
+      BMC156 does not have an INT1 pin, therefore the first interrupt pin is
+      always treated as INT2.
+
   interrupt-names:
     minItems: 1
     maxItems: 2
@@ -84,6 +88,20 @@ examples:
             interrupt-names = "INT1";
         };
     };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        accelerometer@10 {
+            compatible = "bosch,bmc156_accel";
+            reg = <0x10>;
+            vddio-supply = <&vddio>;
+            vdd-supply = <&vdd>;
+            interrupts = <116 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "INT2";
+        };
+    };
   - |
     # include <dt-bindings/interrupt-controller/irq.h>
     spi {
-- 
2.32.0

