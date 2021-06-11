Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0523A3DD2
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 10:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhFKIN7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 04:13:59 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([81.169.146.174]:22908 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhFKIN6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jun 2021 04:13:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623399113; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=floXQWUM4W6xttGdwZF6fwXLAbrliRQpkHQxvhNKHFDhcylw6cFUCib772QWhs/O6g
    tOv70j/J4e5UuTv68Im6bhnzbxE6WeZBrr027U61/h1WonqGvIdUvzUBE1wTGLsD6oRt
    y7wxpA5EGkcoc/p94d8YPnhwUvY4g3Z0GrZIeBWBlcJYG1eBW67p2f7EAchOZVnjiMxC
    TLTeaqho5Cm8UqWB6kM/mfK1QGEqJTxEA3rvAJuP+Nit4GnU240zu//uM2kQiIImjy+A
    pG/jcrzmp43fJ9BjfPGTEKnJ6QH+5GT7Kf8QILRedxWHKmO3t1jBEXkKi0tnPtvaIZ94
    vnkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623399113;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Ua2/BS4Dn+Hn65dlmLRU/qcJr/7vqrYz9hLAbDHqQ9U=;
    b=dxABeggRN5fRDOX3Ew7I49I0k+VYou9lthUqAss5BZP46UaM5ogdmSykh/zQZuRjo3
    I9Kf2hLsI9/l095VqBPs3GWOOKWab9rmMhb9wtbqQMNcITgoTchJegtpPnJeN+qvUMxT
    27d0oMsRt+eiM9G5lZdDRMaGuHWl+uVJWGCL9Ii6JzLMIm7auD/RSu3ku5yeY9JmKTve
    2kXOXGbggwL4hlIG3rIdLdIFTqSSh8oJUIGQLsEKfaz3DyxyCPLgYC5sNbl1+GVNALfe
    Ed0W+4tkCsGz7JfEkpZb+lNgdkJNp4rMTSvbR6u+9czzLFtiCOupjrirwEXOetIuM66b
    Nocw==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623399113;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Ua2/BS4Dn+Hn65dlmLRU/qcJr/7vqrYz9hLAbDHqQ9U=;
    b=M5td5je8lpenBPsbXQb0DQBKfSj9fX+dIiFheZ6jfJIP/ACwBSzQDLdvfya5I3F36Q
    ej5PkcPoZOxY0KBh5NGBmCkfqEJaWw8l4LWQRhuxbbuhm8DeEL5s7JpQQ5mYrSg/CKEc
    b//BnM5F6HnxKrsGvwFoZ8YlB1TsllPk+q3EzjgknUrGulbjZt7rfPmlCBZagYQbUTuv
    a6oLhhCKx0BPdpsu/26AcAcuBs1u+GK6jTszjcmidycxJWgbnNwzWyQx8HLe1og+5gzD
    YqmLjyDfYc0LBtUdp7s7jXKA4fqKq+go//Qy/bYAgvWY/lKIWa5WvshF/Uk6iwCK6cDl
    bUiA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA6m6PrPw="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5B8Br02o
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 11 Jun 2021 10:11:53 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v3 08/10] dt-bindings: iio: bma255: Allow multiple interrupts
Date:   Fri, 11 Jun 2021 10:09:01 +0200
Message-Id: <20210611080903.14384-9-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210611080903.14384-1-stephan@gerhold.net>
References: <20210611080903.14384-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

BMA253 has two interrupt pins (INT1 and INT2) that can be configured
independently. At the moment the bmc150-accel driver does not make use
of them but it might be able to in the future, so it's useful to already
specify all available interrupts in the device tree.

Set maxItems: 2 for interrupts to allow specifying a second one.
This is necessary as preparation to move the bosch,bma254 compatible
from bosch,bma180.yaml to bosch,bma255.yaml since bma180 allows two
interrupts, but BMA254 is better supported by the bmc150-accel driver.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../devicetree/bindings/iio/accel/bosch,bma255.yaml        | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
index 8afb0fe8ef5c..65b299a5619b 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
@@ -32,7 +32,12 @@ properties:
   vddio-supply: true
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+    description: |
+      The first interrupt listed must be the one connected to the INT1 pin,
+      the second (optional) interrupt listed must be the one connected to the
+      INT2 pin (if available).
 
   mount-matrix:
     description: an optional 3x3 mounting rotation matrix.
-- 
2.32.0

