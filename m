Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C911E651E
	for <lists+linux-iio@lfdr.de>; Thu, 28 May 2020 17:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403997AbgE1O7s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 May 2020 10:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403995AbgE1O7q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 May 2020 10:59:46 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1DFC08C5C6;
        Thu, 28 May 2020 07:59:46 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 205so3358935qkg.3;
        Thu, 28 May 2020 07:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HxV5jGRMaMIhiTrb1qlZZSiFIGJApXlv14Z1mpGykac=;
        b=ukDcKmAF8Eyk89FEX8P/Naj1CvbDi/pwjCwLnyQdYLPGcLAYmY/crsCFPmGMAgQu19
         r7i8BtTpX7PJwYx95PeGDnMupBxwUQfylDoC9Dv/D9ow7lHpgUMy5pBd4ltnagq2Yfny
         gcEcX2cIzCb6HJBXftVJm0O/sQB8HeiznxS5upkNfOmgZ8KQLwPRs1rzDXwm1d73kJNN
         MXjg9HJwVDD1c333wF0arqRg8G8Zzcgp0STjXR/4ENKDDb/zv4G45xtw7+XIO0nGyp1G
         vc9p7hHcx7JJviqgUq0Mo6zEEVNov8fyFoFe70MNgvpOPfK66+/ojpqR4H4K2zuuRfnz
         KwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HxV5jGRMaMIhiTrb1qlZZSiFIGJApXlv14Z1mpGykac=;
        b=ONBK/zPXswAHA+2eVjxSJ2vvCqGA88/D7kNFFRzn8aASGNsuP0ZcpRy2TVNq+jg0gs
         I7eiOX+0Mb5+QXsg0GBKx6EBcVdWJbX/ySbFEGaoNNU6oSGRPJO/1FQZcIvhSLP5T5Zx
         CEWipBs5mLJCID7uWsO0qZwb/OfxTZ7lGJppQ5lqAWjAvyogg+Vp0fGolceJxGGOsanj
         eUoo7qjRmWwhQ1nqueqOmrGfIaoZh75XhdlClxQAEXqbyYH3Rx900aLs2lMqVY9hIbXG
         uJ6UPFwXO+m1yEJpnSE6F4tADzkupiLoIbv00CSy53ldev5OCClkZqcwOYz+y/FNbO/H
         Z00w==
X-Gm-Message-State: AOAM531hgKFYoiwgxwSioc2/GskvokG5b+GldCzcMaWalamd+xc6RGz3
        2VDSFduYEzBaXjgrjH138XrQWUGbK8M=
X-Google-Smtp-Source: ABdhPJx722RPlPsKanxgT6Dbrrw9LtVN7k6Vyepei3i08dN+GSgh62YqgZGjo/9eKYdXMMdUpk467Q==
X-Received: by 2002:a37:a9d7:: with SMTP id s206mr3144096qke.6.1590677985028;
        Thu, 28 May 2020 07:59:45 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id p11sm1136947qtb.4.2020.05.28.07.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:59:44 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v7 3/5] dt-bindings: iio: magnetometer: ak8975: add gpio reset support
Date:   Thu, 28 May 2020 16:59:28 +0200
Message-Id: <20200528145930.11860-1-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add reset-gpio support.

Without reset's deassertion during ak8975_power_on(), driver's probe fails
on ak8975_who_i_am() while checking for device identity for AK09911 chip.

AK09911 has an active low reset gpio to handle register's reset.
AK09911 datasheet says that, if not used, reset pin should be connected
to VID. This patch emulates this situation.

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/magnetometer/asahi-kasei,ak8975.yaml      | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
index 55b18784e503..e8af53d60759 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
+++ b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
@@ -47,6 +47,11 @@ properties:
   mount-matrix:
     description: an optional 3x3 mounting rotation matrix.
 
+  reset-gpios:
+    description: |
+      an optional pin needed for AK09911 to set the reset state. This should
+      be usually active low
+
 required:
   - compatible
   - reg
@@ -54,6 +59,7 @@ required:
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -64,6 +70,7 @@ examples:
             interrupt-parent = <&gpio6>;
             interrupts = <15 IRQ_TYPE_EDGE_RISING>;
             vdd-supply = <&ldo_3v3_gnss>;
+            reset-gpios = <&msmgpio 111 GPIO_ACTIVE_LOW>;
             mount-matrix = "-0.984807753012208",  /* x0 */
                            "0",                   /* y0 */
                            "-0.173648177666930",  /* z0 */
-- 
2.17.1

