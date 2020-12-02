Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DDC2CB7C2
	for <lists+linux-iio@lfdr.de>; Wed,  2 Dec 2020 09:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387938AbgLBIve (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Dec 2020 03:51:34 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:9732 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387805AbgLBIve (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2020 03:51:34 -0500
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Dec 2020 03:51:33 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606898920;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=rlZ8EHtgtjvZMOs/Nb/hP9MYuQ6DqgqFNhAhh8IbIyI=;
        b=I92jYtB3ckTvL2zq/jHd5mkmVewE/c9/oILlfVPlmQ0in4hhs616YjoHaKB9iF/GqQ
        JFhNIzswyhkYWZz8cxxIY37IBN/uIuEWmVs1Z6nJ8zCoWoiSMr4Ku8lgoxXIs+h6u35F
        dfExy2h8lNAwBaCTmTKQlNwTni1mvECOJOIJa7woWc9L3Cxy4w790Ps50yR5lZQNIKYS
        g4rad0nRNoejc8hHXaX8boRlm3dZjNZsJtviSlWc1Cs6RQ+SOkoxh4W31jz4lsK1yPrw
        ycqEsCnCe6ff3+t2gr23w8xJn5lJHDJnw4kfCVpLbsq+5FCdr4kCbHPzI/EVhbh5wJkR
        NH8Q==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB626NJkxR"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 47.3.4 SBL|AUTH)
        with ESMTPSA id Z061efwB28aXV2k
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 2 Dec 2020 09:36:33 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] dt-bindings: iio: accel: bma255: Fix bmc150/bmi055 compatible
Date:   Wed,  2 Dec 2020 09:35:51 +0100
Message-Id: <20201202083551.7753-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The bmc150-accel-i2c.c driver has an "_accel" suffix for the
compatibles of BMC150 and BMI055. This is necessary because BMC150
contains both accelerometer (bosch,bmc150_accel) and magnetometer
(bosch,bmc150_magn) and therefore "bosch,bmc150" would be ambiguous.

However, the binding documentation suggests using "bosch,bmc150".
Add the "_accel" suffix for BMC150 and BMI055 so the binding docs
match what is expected by the driver.

Cc: Linus Walleij <linus.walleij@linaro.org>
Fixes: 496a39526fce8 ("iio: accel: bmc150-accel: Add DT bindings")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
index 6eef3480ea8f..c2efbb813ca2 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
@@ -16,8 +16,8 @@ description:
 properties:
   compatible:
     enum:
-      - bosch,bmc150
-      - bosch,bmi055
+      - bosch,bmc150_accel
+      - bosch,bmi055_accel
       - bosch,bma255
       - bosch,bma250e
       - bosch,bma222
-- 
2.29.2

