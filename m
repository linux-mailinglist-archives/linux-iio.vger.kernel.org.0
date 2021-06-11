Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7703A3DD6
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 10:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhFKIOA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 04:14:00 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.102]:20905 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhFKIN6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jun 2021 04:13:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623399114; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pssHL5/7rPs9WxOAcMlggjM6fUybN51NsvIyWU8Hkx3sXhETzjRYf8y2Y6XlN1Yyde
    2t4QQu1UKrc9V2ODeUZ1Z3FzF8s7PLgZuufrgr9H/pzyKkGi9iQzniCJsVP3jVWLUUUJ
    50efmx2cYpUdRB3lRoMGGpIxwf22DL5dOKL/LK4ymm7kJl1tOAd5mssFTXkZfkQVkPaO
    nc72wNAyhr17aViAXaA30rQyJNTJ1skSW4lRSpil26ZUvurLaE9HFhi4hG+QJT5oGS5a
    nB9hVZDyrdU5tzSZYb26dw8+9lI7crHUGR2ryMfaBR7IGresCtZc9xEC9z2LZ0uPkTf8
    prcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623399114;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0LZqEZalSY1FDC+j7IzIvkPWNykdyW/qSpAMgN5TeQI=;
    b=c0vVwAj2N5XC7LhN4UiLD4Zz9FgdFKX6g6BNsIwTYojd2vFA+PHUhmLLNYW3wGZBJZ
    acay6K4YPNYXfGqGtnU+kw7y0EhXeVwuJslKmix14S/hRE5XS+TOxm7jGzy7PXPdNuKV
    ANG81x7+2rfEsWEp9uUdxoEcnaakulFWMZvOGQgkCRuEf+gnOrdex+u6yNt9AEB82GP3
    Wn9FJaAc/ZKA2Ul/GCAF0+ttmtSVkaBhVGJj+T6DdjkKwQWWEQWuaBbB4OvOWxca1eVD
    ACy1hZhn+Obfyi4EVjoa7WGcQ7SkuxxTXnZlM8nH1G2CScn9ZLuoIrOivi2Ht9k81Ytl
    FXsA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623399114;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0LZqEZalSY1FDC+j7IzIvkPWNykdyW/qSpAMgN5TeQI=;
    b=QO+9p5Ft6gUrSJaIwz83mBl5tGkI2Fc4idx1nLDdsH+w4xx0OpMtEL1hXCHaAfw2lm
    mqXaa5G4iW1mkLTDYOPQNE3flo/3SRvhi37OYfZASI979tqLbkZeuNj6SK+v1u1hPcZy
    Aok4XM4WySHodkANWf6yCjdmi4Oax27ieHMP8DgH592I0zzgd50AXgIWsHcozCRFZB/0
    eQZJ58tVqSSDCjtGCMFJlIPCoEPl8VUpoAMibL13/9v6s7Fohn7mFCSYlb+gu4xAJ7UK
    J+Ye+BeYoOfu1ZSoNvZq/4t6SSapoNaYuMlzZsL6brQk0VMoRWxtG18AqazfS3q7qREW
    cPSQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA6m6PrPw="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5B8Br02p
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
Subject: [PATCH v3 09/10] dt-bindings: iio: accel: bma180/bma255: Move bma254 to bma255 schema
Date:   Fri, 11 Jun 2021 10:09:02 +0200
Message-Id: <20210611080903.14384-10-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210611080903.14384-1-stephan@gerhold.net>
References: <20210611080903.14384-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

BMA254 is very similar to BMA253/BMA255 which are both supported by
the bmc150-accel driver. In general, there is quite some overlap between
the bma180 and bmc150-accel driver, but the bmc150-accel driver has a few
more features (e.g. motion trigger/interrupt).

Let's move bma254 over to the bma255 schema (bmc150-accel driver).

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 Documentation/devicetree/bindings/iio/accel/bosch,bma180.yaml | 3 +--
 Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma180.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma180.yaml
index 45b3abde298f..a7e84089cc3d 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma180.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma180.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/accel/bosch,bma180.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Bosch BMA023 / BMA150/ BMA180 / BMA25x / SMB380 triaxial accelerometers
+title: Bosch BMA023 / BMA150/ BMA180 / BMA250 / SMB380 triaxial accelerometers
 
 maintainers:
   - Jonathan Cameron <jic23@kernel.org>
@@ -21,7 +21,6 @@ properties:
       - bosch,bma150
       - bosch,bma180
       - bosch,bma250
-      - bosch,bma254
       - bosch,smb380
 
   reg:
diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
index 65b299a5619b..e830d5295b92 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
@@ -19,6 +19,7 @@ properties:
       - bosch,bmc150_accel
       - bosch,bmi055_accel
       - bosch,bma253
+      - bosch,bma254
       - bosch,bma255
       - bosch,bma250e
       - bosch,bma222
-- 
2.32.0

