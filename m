Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F072B1E1166
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 17:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391109AbgEYPNw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 11:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390911AbgEYPNv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 May 2020 11:13:51 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D15C061A0E;
        Mon, 25 May 2020 08:13:51 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id d1so8146651qvl.6;
        Mon, 25 May 2020 08:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6S/8PdeZHtD6Dk+IxLUBEW23iujsINDZr8pVo+NGkYA=;
        b=PjOUR4I5BTBh72jpIl7SBkdAlsUMREWv3tslU3NzCeIQ0n2RFH9G6ha3BCVVZbZxwZ
         CkmoIZwXdRo8Cp1VcBdu1dcySa9gbkXLzvfnCzHtZAMmbWmAnruCpEa0wM0rGV5pBT+b
         MIEa2Oj/XJIgFRAbaU8yE2jNAFyHab9WnzXXRE48Zaj5y1rQLW8PZKguGkyIwWVmQfX+
         9ITvYiOWUb961IOYh4u+d0TYiiKmjQhM2ErTxjz22GG2JNk8cXVJDUC3wnH29uOzj720
         sQD1TaM8ELkTDfI+VRZKPuWCw+HMFticdu/2uwaE5O64bmnX3uFQnNG5882yqqYtHhsH
         kNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6S/8PdeZHtD6Dk+IxLUBEW23iujsINDZr8pVo+NGkYA=;
        b=kuP3yQJEOh+AdWbHD7n93pvg84wesSTFB5pgjLW+0WFbcLnjhMSH+kAME9Pn8ovGK5
         zEJEXR8aN6e9kgFAmBAqBgE4NCjtRkYlJWj6wVBQlfdfLVFfty784riyygsu0Z4Me96P
         fI6jPGqZJv/hnW62SwAfV05p6OtNM8AxOWuriycr9QkWb4sYqPrgkWv8/XDFN3w5z1U/
         sgAhf7YF14iwTTp3UzXJulR6VHK7MEupb6pt0/xS5z64MfdgkgkSMF3RPvPHhBlzEApS
         g4lPYyNTLvPX59bqDxv/U3zFLOaToJm/KKFsp/ZVRFnz0MrGhCUMB4xuJEhAVJNXA5mY
         /Svw==
X-Gm-Message-State: AOAM5332UIdsJO1HuNpxjGlDWu+vXVzylSfq/gpTDwrGQzsvtb9W+W2K
        fQFGUHe6WOfcjjsaRMDTMmzbyJc2fzY=
X-Google-Smtp-Source: ABdhPJz6M0H6Vpxr8rBl7mvSWDkpkhIuhZmj3p8Lwc08wHJY1UNVd2P3TkUtUzJ5sz/KBHfKT4+Y4w==
X-Received: by 2002:ad4:48c5:: with SMTP id v5mr16329844qvx.203.1590419630217;
        Mon, 25 May 2020 08:13:50 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id m59sm15161709qtd.46.2020.05.25.08.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 08:13:49 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v6 3/5] dt-bindings: iio: magnetometer: ak8975: add gpio reset support
Date:   Mon, 25 May 2020 17:10:37 +0200
Message-Id: <20200525151117.32540-4-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525151117.32540-1-jonathan.albrieux@gmail.com>
References: <20200525151117.32540-1-jonathan.albrieux@gmail.com>
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
---
 .../bindings/iio/magnetometer/asahi-kasei,ak8975.yaml      | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
index a603659d5fa5..04b895c7143c 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
+++ b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
@@ -48,6 +48,11 @@ properties:
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
@@ -55,6 +60,7 @@ required:
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -65,6 +71,7 @@ examples:
             interrupt-parent = <&gpio6>;
             interrupts = <15 IRQ_TYPE_EDGE_RISING>;
             vdd-supply = <&ldo_3v3_gnss>;
+            reset-gpios = <&msmgpio 111 GPIO_ACTIVE_LOW>;
             mount-matrix = "-0.984807753012208",  /* x0 */
                            "0",                   /* y0 */
                            "-0.173648177666930",  /* z0 */
-- 
2.17.1

