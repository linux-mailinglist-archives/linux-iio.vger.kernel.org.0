Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87E53A28ED
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 12:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhFJKE1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 06:04:27 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:18624 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhFJKE1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 06:04:27 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623318987; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fxgXaoic9waSnvARpFd+Os3vVaEyzZ0wc1nVBXtaRvquoezsGFFIXauCRxRZeGtuy4
    gfS4sfD6UjjvOP3KSoeUFJfBQb/94lkLrNimZ4nmTSaxxYcEsafsscx32Z33aOzBcG95
    Oyija0NHOcfdlTMp5IBlA/Y2fVh39OOIT6fKMchWDfR9c6xTvdrQ7hQQs+tdWB+pKqhQ
    Lvl8TQDJl9UBGsxU8iuQEnO8eBRFZyJQmD1aKGbFDAakxYFDM6tnGW4oJ8SoN3JBkaVz
    8K8ImBlg0iUBTC5Mou74C1Se82+8RvsYnBZT0MaKC3GsE936hIRgCWT6je9w7sKQXLh6
    //aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623318987;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=AH2P9XfKb0PEYAd9xaBbRcSiO7z56XjX7li+ixOW9Ww=;
    b=pLuGvtHZkxoeE93rlX6PxRKULbl7OZm8so5SIGTZghbHdMzCYz4DP7/gNTkqeL72Kn
    YJOFYyb7f1BC/rVf9j0GXnohucGVdt2pjvePMdhiYq7QKqLoTE9TE1AJEgPSDdYwhJNi
    xTpCAoi+YYY9fRPHWBjmsu2POb6rQYj2vyvpROvzldkJFl0rV+vo/0mwhEfK6fmFoyKt
    gYHE1QSFR+H7AunCYhPCOVPgvf3phwFnDFXCd2yOVSZr0j0weEokvDU4xo8Ti7vtt24u
    Lk5NXvE5jezdJ2E1SzktUDwvqDxZ5d11h+yFkMpage9lFc0H7zoEJRyciRDjb1g6wEru
    b8+A==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623318987;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=AH2P9XfKb0PEYAd9xaBbRcSiO7z56XjX7li+ixOW9Ww=;
    b=bo4Lhqu2H7jnLd4cbaxhp0liYvO0DlJGA3YVlT6qj+ALwOGrche7LmnSpRhTq3AJOO
    k7CZ1UzpsDirNlCs3cgo950X4h+DrtSCjgs5nRHTDu/VUOvRDdGqR6PqSWpkyO3o8O51
    RpCe+//i8r911cDHSs6aa1qJnrzY4FyC32Lrambtk9LeqKBpNa3Am5WTo6RHdzkncjy8
    J+PjoWzqfXrCmDWYA8W5XvBe6aHF9UdJ5x7hEk+dKa2tG9kLhgHYO57Rm0SSNa8csLDG
    k9AVnkX7jy0CILPlbq64ltXwlRd5eJq/IpWIIbxRROk9pcAVy59KdQwb79+t3K08bfnd
    NmHg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA626NTAM6"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5A9uQso3
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 10 Jun 2021 11:56:26 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Laurentiu Palcu <laurentiu.palcu@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 5/6] dt-bindings: iio: accel: bma180/bma255: Move bma254 to bma255 schema
Date:   Thu, 10 Jun 2021 11:52:59 +0200
Message-Id: <20210610095300.3613-6-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210610095300.3613-1-stephan@gerhold.net>
References: <20210610095300.3613-1-stephan@gerhold.net>
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
2.31.1

