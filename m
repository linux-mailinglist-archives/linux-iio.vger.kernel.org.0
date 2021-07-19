Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674F73CD3D5
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 13:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbhGSKqR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 06:46:17 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:9212 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbhGSKqQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 06:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1626694004;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LVm6WgdyvhCXK+JELu0sKh9VaQqtj3Jm5KMQSw4rLoQ=;
    b=ZAGMQOR7+SrENkHFeSuunAi/ZmoHKI3T3baIcOivaO2DJnW+iRKzLmY6f3g1tYL5Jg
    tziCjC0P4GQwVRL3+8aMCu/rlIjF47nqSvJzpNqnzmu6wHBf0Qsmrn236OIq1zgzA+Oz
    eltL/pEWRdAdxNg6yhL8ZhHY1K8JB+O2dp7ruHK8vrF+H3qNvj8mOnB+4opLB2R/v5MB
    V/8I2oAbqmRrsdYPDMrpUmI+xEG8XTqYb8/P++5FN+FlgTOZqH82glA2TLX6B64PNjfG
    GQjUvpmoeB/uWymrB7q4mY8gXSCCQgobbPnNE2h03BY1UnWKJr89r16+3UBRw2TZzBrp
    QRBQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4m6O43/v"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.28.1 DYNA|AUTH)
    with ESMTPSA id g02a44x6JBQh27c
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 19 Jul 2021 13:26:43 +0200 (CEST)
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
Subject: [PATCH 1/4] dt-bindings: iio: accel: bma255: Add interrupt-names
Date:   Mon, 19 Jul 2021 13:21:53 +0200
Message-Id: <20210719112156.27087-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210719112156.27087-1-stephan@gerhold.net>
References: <20210719112156.27087-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The binding already allows specifying both interrupt pins, but there
is currently no way to describe a board where (for whatever reason)
only INT2 is connected. Make it possible to use "interrupt-names"
to make it explicit which interrupt pin is meant in the interrupts.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../devicetree/bindings/iio/accel/bosch,bma255.yaml      | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
index 5b35856b1942..897a1d808ef5 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
@@ -49,6 +49,14 @@ properties:
       the second (optional) interrupt listed must be the one connected to the
       INT2 pin (if available). The type should be IRQ_TYPE_EDGE_RISING.
 
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - INT1
+        - INT2
+
   mount-matrix:
     description: an optional 3x3 mounting rotation matrix.
 
@@ -73,6 +81,7 @@ examples:
             vddio-supply = <&vddio>;
             vdd-supply = <&vdd>;
             interrupts = <57 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "INT1";
         };
     };
   - |
-- 
2.32.0

