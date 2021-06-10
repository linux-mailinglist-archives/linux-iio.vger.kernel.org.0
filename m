Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92C53A2B73
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 14:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhFJM0V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 08:26:21 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.102]:23376 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhFJM0S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 08:26:18 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623327850; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ep9susx+/PpJdbTJletPsvOG/30zUTQRJm3E0Z2ziCjPsUml6oCsi0aw70+ZUEmKL/
    BL1eKCzGDiPvMmlajOie5uM9jgwUwOW1sK5FmHkvLroPbt6oo8tCdi74EuXp8q2iGtcR
    90YSVVo9a4yw4/RgTBlPFSVQ/x5jQn3n5Q4qUOZizYdjTNfGdYXUKeUpLL/8GjHcybtg
    WL+4PtVrky1ZJhSUBrnrrYp7XwnKWy5ocBX2792MqYzFxWFHCijCw5osFm8MXUUczMIU
    g09sJTpzBFaIbOTXqEHRcKmbFJav9FIWiKyfx4YunNcFgfcqXk+o0gvLEog+TaXNkGXB
    8Iog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623327850;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Ua2/BS4Dn+Hn65dlmLRU/qcJr/7vqrYz9hLAbDHqQ9U=;
    b=jWPneeDwhtB0NG9SolRtjbY0xuq2c42L/3mKcFyhgO74UMuvkPYvEICWxb2+DmA8Sd
    2B25XoUoaOVFXl/EMyOOprtFIdZiwUpCAL0hu5P+WrIFic2JT9cX6ktA+DlCnDQuGjmF
    DQInoIGdpVImb74bSXY7XwLIMiBn+Dq2xydQ5ARhEOTqYxuJzJA+p+v0uIiJqmC60hoZ
    i7nmZ96Rb+7d7awpbgOP6zuuLPwxUFlUJvm95AYFjCxCqEy98RtmCOXEyruKMKA4zE6w
    DXJ/i15OEQTQeHZKu5islUwhPiHmoWP8n0/bECf2/mXZhT3+yKwpAUPqZY8mRkWBpye8
    43Xw==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623327850;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Ua2/BS4Dn+Hn65dlmLRU/qcJr/7vqrYz9hLAbDHqQ9U=;
    b=OssLrVehlriEUQM3RfTRPbHJJjCN02URqCz+lc7FnjS1IoZH5PwuQOXb1/4oQWBTj9
    AZRUGnu8m1VlBOnq7uN+9vDZu8hWeMwd2Fy4m8Vt4idlY5tEyVc09JWdoW5sFFiiPg+K
    suE/PkiDuEBCvNuzKgU2kIxhRTCw83PBDy7JEPhpF86yehexbqMkG/5S2V9PdBsmiJo5
    k4XzfPa6XzLW6dCGbBV/F4LEgTw7qk+uosrE1k8K6rtjdWmyxurkknivGd9n6X/j1PCZ
    RLFVDGdbtaVnAX2YFQqvGD8QokNtQreFHRFH2OLQWzwYGL2VM508FjJak55sWXMPrUWX
    l/iQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA626NTAM6"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5ACO9tzz
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 10 Jun 2021 14:24:09 +0200 (CEST)
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
Subject: [PATCH v2 7/9] dt-bindings: iio: bma255: Allow multiple interrupts
Date:   Thu, 10 Jun 2021 14:21:24 +0200
Message-Id: <20210610122126.50504-8-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210610122126.50504-1-stephan@gerhold.net>
References: <20210610122126.50504-1-stephan@gerhold.net>
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

