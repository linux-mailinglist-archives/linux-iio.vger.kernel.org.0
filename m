Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853811D9690
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 14:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgESMod (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 08:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbgESMo3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 08:44:29 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72266C08C5C0;
        Tue, 19 May 2020 05:44:29 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f134so2928753wmf.1;
        Tue, 19 May 2020 05:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jfvT9uA0eu5W3Ndyf2EIIWVhSCqK5/sx7OIEpRxugJ8=;
        b=sETFH7pxB/VLh576Yx/jY1DlUpiI7RGGUZRgYEzCYCj0VvawGm+v2MgkgtI8jJTudC
         eG/yvelXn+SCptYFg4vWFRw5WkhRmSIPMy4Z/pfR4k30ll9k9Lk2rkw0e/Zt/Sjy9UB8
         JO+1t5AHuShC8siXyFxmN6QoWJcPgczLIAQMIxVRehHbPf1XOa4ki9PNz9HtMc65GMR9
         2qbFXyEuqbtxkIgER1Eo7zwmeipeZky1TycC/XcQCNryuH1izp5rLBv+mNHUsG9OGYJI
         PkVM4ye4rr+vSWPCdzUES4vHzdu2xmD+Qfhb3NfjV4RTvwkw/KX1E8AB/JMg02b4B9f3
         XKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jfvT9uA0eu5W3Ndyf2EIIWVhSCqK5/sx7OIEpRxugJ8=;
        b=Lx37EJWGCEv3J9RnakfOy3iE4e/iKbsFUlyPP7Cszgnm1MOeNktVeA9Xc5W42klwAD
         BOoNa0zCkZPfNYgaorJ0JNsMITODWBZBwyj3h5C5S+O8IavCTnz+OwD6QbE03ZbN2JAr
         8444q7bfi4zo6zV2kas4zbcxj5bL5NZIG/lbF/TgIpxUd75eWsR3PriCafjysmEkkPrK
         VpJWy8KZSaIhtXfuqfQ/1vTVYy5j82NzB2TI/DaFTWU+4dtNupzlr+X6mFb3Oao0KL7n
         colqwezxuCWF+fnc+d7o6GbvtIfU5NoNFvKCHjhA1Q8zGjbD8+3gkVBTUkxWeDpen3xQ
         4Y2Q==
X-Gm-Message-State: AOAM532Ti2aEaqdrNKK6PcpeV3MmEjMOPW+evwGXM1VAtMUjkTokbY0r
        OzUDRuzvGkQNlbEQ8zBDuawyj+Mg0lsZTw==
X-Google-Smtp-Source: ABdhPJwPQdgQNqbxNA8WlDoBXfKplt1SdvrG2YJD+XWvLpfyBcQDcjMXKFRcYkvUlROAE2/S1NynKw==
X-Received: by 2002:a1c:f211:: with SMTP id s17mr5757742wmc.168.1589892267534;
        Tue, 19 May 2020 05:44:27 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id b12sm3953870wmj.0.2020.05.19.05.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 05:44:26 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 2/4] dt-bindings: iio: magnetometer: ak8975: add gpio reset support
Date:   Tue, 19 May 2020 14:43:52 +0200
Message-Id: <20200519124402.26076-3-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519124402.26076-1-jonathan.albrieux@gmail.com>
References: <20200519124402.26076-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add reset-gpio support.

Without reset's deassertion during ak8975_power_on(), driver's probe fails
on ak8975_who_i_am() while checking for device identity for AK09911 chip.

AK09911 has an active low reset gpio to handle register's reset.
AK09911 datasheed says that, if not used, reset pin should be connected
to VID. This patch emulates this situation.

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
---
 .../devicetree/bindings/iio/magnetometer/ak8975.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
index 86e3efa693a8..a82c0ff5d098 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
+++ b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
@@ -37,6 +37,9 @@ properties:
   mount-matrix:
     description: an optional 3x3 mounting rotation matrix
 
+  reset-gpio:
+    description: an optional pin needed for AK09911 to set the reset state
+
 required:
   - compatible
   - reg
@@ -53,6 +56,7 @@ examples:
             reg = <0x0c>;
             gpios = <&gpj0 7 0>;
             vdd-supply = <&ldo_3v3_gnss>;
+            reset-gpio = <&msmgpio 111 1>;
             mount-matrix = "-0.984807753012208",  /* x0 */
                            "0",                   /* y0 */
                            "-0.173648177666930",  /* z0 */
-- 
2.17.1

