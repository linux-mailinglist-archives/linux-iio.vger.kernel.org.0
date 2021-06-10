Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BCB3A2B6F
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 14:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhFJM0U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 08:26:20 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([81.169.146.174]:31998 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhFJM0R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 08:26:17 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623327850; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Sw9SVVIz/Co98s2zQmNMR36y7vxUEAXsQG3Wyv9Z7uWG0h9xyKfCGjQv6cPtVTodWO
    FzhI4nYNiZp3dupWRKBUqhcp0ussOnRpsQ7iNUZK5M/qFqIxYQLHt2zugAKBBePM3eDG
    JWoR++TrFiA7Y+zw2Bn2757wFZela5cn+EMyLf2NjdREEK7iEfaaO/wGf8fwyav66KOe
    6J8sgiF+0KtMVaW/4eBj+DaNan1me7miWRnU1qsiiFYzotABU13UUFI8Cu3c4xiPHOI2
    MSzRriy/wF+LP8eg81KR9SI8P/TzSXbktpAHa5IbtcUemon4mN9TJyoorMR3tNorwhF4
    ZUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623327850;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0LZqEZalSY1FDC+j7IzIvkPWNykdyW/qSpAMgN5TeQI=;
    b=dfKhMSVpw8RtooqIICbFep4+fcyrVwtjDa4ZR/DxYjVQXahfluflGCurJhi1u15ldV
    0R4Ta/vBOod/DtFgHInmSK7pwiGchtlG4sFmcL3n2TKXpOmdOh3/ld5r4lxjVJVxKexb
    /hF9nHh41/xi93Q7+zP4TY1ITy3cAa9dBtjErMOAveC+AUp6U7Kw4f4gOcP8jiSUckQB
    OZKDPnspFHOiQu/bdFamCz+uDibG/22a3zxjvroJfdRnOM/8PktUJT6ldb0Ca7gpvBm+
    o7BcoBuFbyCnImbB88e89P/zHO5jAmZKoDsGTBF1mBQ2NQ6Zh+JaCRMgohFQH+s6vbyk
    pp1A==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623327850;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0LZqEZalSY1FDC+j7IzIvkPWNykdyW/qSpAMgN5TeQI=;
    b=tojkXfq+HtpvtoJpGAZPWIBW+vK+qx1xqfTlKNlajt2Vj08rF0K/GdbZAaC1tK58r1
    hIrRU580xVcKKErSIurH0qnHqAncBj8h9XiDkBOyLaioVR9d/K0KtI2RGIwbKr+Fq03g
    c/M3wbebDx473AgNof5DLCHJXtFpnlnQh00bvlg4WOxA4EUQoNp8B3GwsWVTEib65wVX
    6VvlVk/gkLXY6TviSGHyHIkzFW2uBagozpQoU2MGkevg5i0VTcQRxsLB4sYEGdd7ATZP
    2Ay0l8avpyYlikpz8027xwGVE42Ta+flX09DmER8/Ws5VDVMlQe450ZLsRWCNa/6Xlig
    p5Fw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA626NTAM6"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5ACOAu00
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 10 Jun 2021 14:24:10 +0200 (CEST)
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
Subject: [PATCH v2 8/9] dt-bindings: iio: accel: bma180/bma255: Move bma254 to bma255 schema
Date:   Thu, 10 Jun 2021 14:21:25 +0200
Message-Id: <20210610122126.50504-9-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210610122126.50504-1-stephan@gerhold.net>
References: <20210610122126.50504-1-stephan@gerhold.net>
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

