Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB453DDCEF
	for <lists+linux-iio@lfdr.de>; Mon,  2 Aug 2021 17:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbhHBP5b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Aug 2021 11:57:31 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:36610 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbhHBP5b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Aug 2021 11:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1627919825;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mLmbG7FaZcS5dOyweoPjyoCfYgTIacG4CENTQ8e5dZQ=;
    b=T3L+d5Uq1lWjooRP/q/DGuIDrQ+n8GMb4c1ZDzVeSQX1OLpF/J0lIPoD+DUbDvW6s1
    5bOH70ahywSTgde6PqmY1d5kPlLKHpAtfI/9a9YkYjA3NA9QAQXFD297y7e/i4otuA8h
    Ou8DZLIHQNxf7U40dwHWKvTvhpO2iYkYjMZZxE77rPcL47gOOUbWN84A0fCtqMnBxXGM
    5xD0ExcSzHHN285aFyaKF7/AR1D82D+7Nzazgorbo81z95FWCcV4UzAmsJAVm4GqBvKh
    n2Em1F0+jeUuzbzs53I0RfcyI/DPC1fW6kZs3aA5HU5Baiz6nrRtBE6oq2uAQGWR1Cqg
    lXCA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXTbAOHjRHIhr0eF6M4Q=="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.30.0 DYNA|AUTH)
    with ESMTPSA id e095f1x72Fv52RD
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
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 1/4] dt-bindings: iio: accel: bma255: Add interrupt-names
Date:   Mon,  2 Aug 2021 17:56:54 +0200
Message-Id: <20210802155657.102766-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802155657.102766-1-stephan@gerhold.net>
References: <20210802155657.102766-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The binding already allows specifying both interrupt pins, but there
is currently no way to describe a board where (for whatever reason)
only INT2 is connected. Make it possible to use "interrupt-names"
to make it explicit which interrupt pin is meant in the interrupts.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v2:
  - Add "Without interrupt-names, ..." to "interrupts" description
    to clarify that ordering of interrupts can be relaxed if
    interrupt-names is used.
---
 .../bindings/iio/accel/bosch,bma255.yaml         | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
index 5b35856b1942..253b2051d0b1 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
@@ -45,9 +45,18 @@ properties:
     minItems: 1
     maxItems: 2
     description: |
-      The first interrupt listed must be the one connected to the INT1 pin,
-      the second (optional) interrupt listed must be the one connected to the
-      INT2 pin (if available). The type should be IRQ_TYPE_EDGE_RISING.
+      Without interrupt-names, the first interrupt listed must be the one
+      connected to the INT1 pin, the second (optional) interrupt listed must be
+      the one connected to the INT2 pin (if available). The type should be
+      IRQ_TYPE_EDGE_RISING.
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - INT1
+        - INT2
 
   mount-matrix:
     description: an optional 3x3 mounting rotation matrix.
@@ -73,6 +82,7 @@ examples:
             vddio-supply = <&vddio>;
             vdd-supply = <&vdd>;
             interrupts = <57 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "INT1";
         };
     };
   - |
-- 
2.32.0

