Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1750E3DDCF1
	for <lists+linux-iio@lfdr.de>; Mon,  2 Aug 2021 17:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbhHBP5d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Aug 2021 11:57:33 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:34595 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbhHBP5d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Aug 2021 11:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1627919826;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=PBDUzAA2uZL8rx4T0qqlTZQwhvXnyhX6ulO6O6mtELA=;
    b=DYI9hI9jUINOLNxFQnukJwn5zLmQEUfZTOVhSlTUDUMiOBkGUf6a+db2b7HgYX/XbQ
    ybVLFqFQZZoJvzNZlZz06Wvx9Y2PyFH5tFr7xyBcGNAvRRulNH+yqlF44jyrGtf7cGUo
    v40ZZoQFp4W1dFfgwkhzc9KxyJPPFNWsPun3ScZg7oSz2MVfirnEVcugpklfEFlk+/LP
    YMZyhWe9XqydQQxQLsrRcpe3xIe+2pQMKVull2WdihHyIBFctlXR1bNmhlwdZ0iNL9QN
    3dTE46V7J5N5RNTsvDHP8UzNws8kfotWLsTj+jhA4DVSmX8uJzctMRwj64MU+wIVDwlZ
    Jjxg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXTbAOHjRHIhr0eF6M4Q=="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.30.0 DYNA|AUTH)
    with ESMTPSA id e095f1x72Fv52RE
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 2 Aug 2021 17:57:05 +0200 (CEST)
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
        Stephan Gerhold <stephan@gerhold.net>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/4] dt-bindings: iio: accel: bma255: Add bosch,bmc156_accel
Date:   Mon,  2 Aug 2021 17:56:55 +0200
Message-Id: <20210802155657.102766-3-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802155657.102766-1-stephan@gerhold.net>
References: <20210802155657.102766-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

BMC156 is very smilar to BMC150, but it has only one accelerometer
interrupt pin. It would make sense if only INT1 was exposed but someone
at Bosch decided to only have an INT2 pin.

In this case, it does not make sense if the first interrupt pin is
treated as INT1 (since that pin does not exist). Add a note to the
bindings that the first interrupt pin is treated as INT2 for BMC156.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../bindings/iio/accel/bosch,bma255.yaml       | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
index 253b2051d0b1..478e75ae0885 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
@@ -26,6 +26,7 @@ properties:
       - bosch,bma255
       - bosch,bma280
       - bosch,bmc150_accel
+      - bosch,bmc156_accel
       - bosch,bmi055_accel
 
       # bma180 driver in Linux
@@ -50,6 +51,9 @@ properties:
       the one connected to the INT2 pin (if available). The type should be
       IRQ_TYPE_EDGE_RISING.
 
+      BMC156 does not have an INT1 pin, therefore the first interrupt pin is
+      always treated as INT2.
+
   interrupt-names:
     minItems: 1
     maxItems: 2
@@ -85,6 +89,20 @@ examples:
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

