Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71F53A6BE9
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 18:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbhFNQgn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 12:36:43 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:19073 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbhFNQgm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Jun 2021 12:36:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623688473; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Hw/m070q22hWBaW5wVC5bfa4eppwIB8mF7AwZ+CkcHZ+ZrO8B3gbF70+rUweRCXXEE
    fhTKQgUjwvMX8TYMwIxBqgSVO0FKuqVBPK9yDlCxl0us/tvGvoJ7lzrHwy0dd5uxR+gP
    q4rv2vvS/Iho6qG39uU06CSSu1Ph9MJaKMi9B28R0F5Wa2OhXgQzNWfZcNShsTzTASll
    y1pzomztILl6WF5kDkYXVBd4j3DCsIXLvDmttTD91NQ+CNMH/q9EAfh7lv1gvz4TOrUx
    q5rj+prSN+4gWBxM40uu35scTNONvBfk66csyuvMo5+hP8pJ3wOghVwAFrBfr5HF9smd
    EfOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623688473;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=x9LjPKNlTn6jZYMI0UPbWnrrqak27uh1gtfqY+NFcGY=;
    b=AmVjniVxpdkOEBFVE28Suonn5r3fV1/wmEEr50iX5hJ84XvNnm9f9IJH3RyUfqmXnm
    LyF6ObEJtPlvNbJEeMneM7x25mrCcpxqvSf758RViOQ+NjyepXXMTcrtoYKFsPGn3fE2
    GQ2BRAoHz5+tijxQEtWBMFtHV2MyhQ2n7WPbZVU3w9bKwdiQ6JEJhXnkMnnzzaRhysYJ
    ZMKYe/sDj9HP0LeDbewdghXTa0o/oT2xHBZO//GO3gOXV+II/Ye4OM9ol/OrgHEtk6Gl
    m8K86zCTZ5bBWPPjm4XrvQl6WZBPi+OC3XSfjZcnfOGtWmEqvMsieVXI2eWiS35SUOYU
    +tEQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623688473;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=x9LjPKNlTn6jZYMI0UPbWnrrqak27uh1gtfqY+NFcGY=;
    b=qo5yXaBmU9Aj3AIUNQUdWqVhCHzYwr+p08EbuadvwZr5BN/rGu5hBEAug66VPK6MLS
    38M7ai8Ol0UAVXLgvZwJyZ3t4mHwkJgAPiH6aPd/4vlsYHZhTdNkkT/FZErZKz0S7f5k
    ooxuEufxzWI4pSlDaIgRDHnixCGmjd0Xn2BIEoOemb3k+b3tI8bSB+MEJuutMsEEmWhC
    LxZHxO9cXTfL+RkvAnIqwxWwHaPQYbkIATcBFkKFhrq4MRP1WZTtjm/zgtKedNGPJLqK
    RMCIZHpKz1hpgZt/shpz4qtwGuqK8IWoPoRs/MPuuBvPxHRLZ+bvh9/WJcAk9C09T5fm
    wisw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA6m6NvdbT"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5EGYWJ6t
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 14 Jun 2021 18:34:32 +0200 (CEST)
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
Subject: [PATCH 1/3] dt-bindings: iio: accel: bma255: Fix interrupt type
Date:   Mon, 14 Jun 2021 18:31:48 +0200
Message-Id: <20210614163150.7774-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614163150.7774-1-stephan@gerhold.net>
References: <20210614163150.7774-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Bosch accelerometers similar to BMA255 are initially configured to
emit an active-high interrupt signal. This is currently not re-configured
in the bmc150-accel driver so the interrupt should most certainly be
IRQ_TYPE_EDGE_RISING (or potentially IRQ_TYPE_LEVEL_HIGH).
(Unless there is some kind of inverter installed on the board...)

At the moment the bmc150-accel driver forcefully requests the IRQ
using IRQF_TRIGGER_RISING, which means that the IRQ type is currently
ignored in all existing device trees.

Fixes: 6259551 ("iio: accel: bmc150-accel: Add DT bindings")
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
It's probably better to let the bmc150-accel driver rely on the IRQ
type provided by the device tree in case of inverters or something.

However:
  1. We need to fix up several broken device trees first (I found
     IRQ_TYPE_LEVEL_LOW in some device trees).
  2. Similarly, I'm not sure if this might break some ACPI devices
     in case they have the wrong IRQ type listed?

As a first step this patch just fixes the documentation.
---
 Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
index e830d5295b92..b37ba902e4a2 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
@@ -38,7 +38,7 @@ properties:
     description: |
       The first interrupt listed must be the one connected to the INT1 pin,
       the second (optional) interrupt listed must be the one connected to the
-      INT2 pin (if available).
+      INT2 pin (if available). The type should be IRQ_TYPE_EDGE_RISING.
 
   mount-matrix:
     description: an optional 3x3 mounting rotation matrix.
@@ -63,7 +63,7 @@ examples:
             reg = <0x08>;
             vddio-supply = <&vddio>;
             vdd-supply = <&vdd>;
-            interrupts = <57 IRQ_TYPE_EDGE_FALLING>;
+            interrupts = <57 IRQ_TYPE_EDGE_RISING>;
         };
     };
   - |
-- 
2.32.0

