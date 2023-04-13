Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210D56E090B
	for <lists+linux-iio@lfdr.de>; Thu, 13 Apr 2023 10:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjDMIg5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Apr 2023 04:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjDMIgz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Apr 2023 04:36:55 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF4B8A49
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 01:36:40 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-187916b6543so1263849fac.7
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 01:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681374999; x=1683966999;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+VPypZbNf/Utk12NhniVwsu/FBDBW0lw5cAil4ugID0=;
        b=oduWMN+YeHD8UlReGK0+YcaDwbk1MWEQJKcJZhGiK8vJAmEMmWsr1S0RNit4sHuE0W
         Bg2+ul4kXpkxY+MtR9VKlfLmsVBztERv6mU0P9jnyRqWPz98Ya2ORxyU03J9kKYOQlev
         e1ct26n06lONYQ8PC0nEKL6SWO1pQppDsiywtwZT79LCx2JMDGUMFKiPH0HjfD0rcsYi
         JvQt3hNTzEFKFerwY8HfT7Rsi1udlJgabFkGe5fj1qYj4sNaeDw/B03BsK66VCbmQc+C
         8g1bjk6DKvErxmY3wd2s/91A2qccfQOg3C+zI0khSIbHrO57TnnIHLdBFA/Tm/YPQiW/
         4+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681374999; x=1683966999;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+VPypZbNf/Utk12NhniVwsu/FBDBW0lw5cAil4ugID0=;
        b=fETmQKQbYI4EIY0zG3ewCIR8JvkOdvSANSVm+HDdhMMltM3ajnBizD2v9qTqw1GWVH
         OrEUCHki52OsF+2sr6FI0OMt8naEEhMJ5tN9F8vdOGT1Yrz5h9a9GgNaNOe0eB1gA/4b
         a2088IanIJbuIz2mxZBXVKw3PpBP64ETsIZky+l/iGu933KDSrS/wfwuHNF/PWODjsjY
         ir/rQvF9xopWpb8GJ/oFY/C0y9Lx1yxs2mT2Q5IGLMtbM4n3fozNFqW+L3MYKksydRnp
         dXS5YbWo9mVhniIFCW3VyGzEV8Qu/CisiXBQvaMRX4GhGd8KOj1/ntEWzuYTOBVs3bL1
         dpLg==
X-Gm-Message-State: AAQBX9cJWactaoVtzmMUJqVbz+rLG0GeBrcyO7dJJenCm6OWn/47eNbF
        2t2EDvG5XQxjoIo0iWKL+v85va/PXTnPxSokJCCgQrXJLsM=
X-Google-Smtp-Source: AKy350Y3quS2UM1ecpArFVp/EsMHeWJcmnNUU3nF0ev+o/WaGwNXwslus0OkXkd52lOVsPfFzD9txsF7qu/S1N7lg3M=
X-Received: by 2002:a05:6870:40c1:b0:184:7e3c:e33e with SMTP id
 l1-20020a05687040c100b001847e3ce33emr705597oal.8.1681374999639; Thu, 13 Apr
 2023 01:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAPJMGm4PU0YgU0DhMvNZK58JzEhg_eszFaXfmyuY1ymjR617Xw@mail.gmail.com>
 <CAPJMGm4bv3PHiGa7B8uH+izmVOWVJnibmuZ-9GwnAGeGHmpN5w@mail.gmail.com> <CAPJMGm4YhDNOLku_vWUJA8cYbUinoVoP+NmP4Te+fpa-bjfHfQ@mail.gmail.com>
In-Reply-To: <CAPJMGm4YhDNOLku_vWUJA8cYbUinoVoP+NmP4Te+fpa-bjfHfQ@mail.gmail.com>
From:   Fabrizio Lamarque <fl.scratchpad@gmail.com>
Date:   Thu, 13 Apr 2023 10:36:28 +0200
Message-ID: <CAPJMGm7mgSi4-Td+8XMqBWLj_tiSVrbxVP7WYbhZnL+_8jJhng@mail.gmail.com>
Subject: [PATCH 3/3] iio: adc: ad7192: Clarify binding documentation
To:     linux-iio@vger.kernel.org
Cc:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Added undocumented properties:

- adi,clock-xtal
- adi,int-clock-output-enable

Removed clocks from required properties.
Renamed avdd-supply to vreg-supply, while keeping backward compatibility
(deprecated avdd-supply).

Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
---
 .../bindings/iio/adc/adi,ad7192.yaml          | 28 +++++++++++++++----
 drivers/iio/adc/ad7192.c                      | 18 ++++++------
 2 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index d521d516088b..5dc7a7eea5f9 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -32,7 +32,9 @@ properties:

   clocks:
     maxItems: 1
-    description: phandle to the master clock (mclk)
+    description: |
+      phandle to the external master clock (mclk). If not defined, internal
+      clock is selected.

   clock-names:
     items:
@@ -45,7 +47,23 @@ properties:
     description: DVdd voltage supply

   avdd-supply:
-    description: AVdd voltage supply
+    description: Phandle to reference voltage regulator. Use
vref-supply instead.
+    deprecated: true
+
+  vref-supply:
+    description: Phandle to reference voltage regulator
+
+  adi,clock-xtal:
+    description: |
+      This bit selects whether an external crystal oscillator or an external
+      clock is applied as master (mclk) clock. It is ignored when clocks
+      property is not set.
+    type: boolean
+
+  adi,int-clock-output-enable:
+    description: |
+      When internal clock is selected, this bit enables clock out pin.
+    type: boolean

   adi,rejection-60-Hz-enable:
     description: |
@@ -84,11 +102,9 @@ properties:
 required:
   - compatible
   - reg
-  - clocks
-  - clock-names
   - interrupts
   - dvdd-supply
-  - avdd-supply
+  - vref-supply
   - spi-cpol
   - spi-cpha

@@ -114,7 +130,7 @@ examples:
             interrupts = <25 0x2>;
             interrupt-parent = <&gpio>;
             dvdd-supply = <&dvdd>;
-            avdd-supply = <&avdd>;
+            vref-supply = <&vref>;

             adi,refin2-pins-enable;
             adi,rejection-60-Hz-enable;
diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 5a9c8898f8af..a0cac9b60ea8 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -176,7 +176,7 @@ struct ad7192_chip_info {

 struct ad7192_state {
     const struct ad7192_chip_info    *chip_info;
-    struct regulator        *avdd;
+    struct regulator        *vref;
     struct clk            *mclk;
     u16                int_vref_mv;
     u32                fclk;
@@ -1000,17 +1000,19 @@ static int ad7192_probe(struct spi_device *spi)

     mutex_init(&st->lock);

-    st->avdd = devm_regulator_get(&spi->dev, "avdd");
-    if (IS_ERR(st->avdd))
-        return PTR_ERR(st->avdd);
+    st->vref = devm_regulator_get(&spi->dev, "vref");
+    if (IS_ERR(st->vref))
+        st->vref = devm_regulator_get(&spi->dev, "avdd");
+    if (IS_ERR(st->vref))
+        return PTR_ERR(st->vref);

-    ret = regulator_enable(st->avdd);
+    ret = regulator_enable(st->vref);
     if (ret) {
-        dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
+        dev_err(&spi->dev, "Failed to enable specified VRef supply\n");
         return ret;
     }

-    ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, st->avdd);
+    ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, st->vref);
     if (ret)
         return ret;

@@ -1018,7 +1020,7 @@ static int ad7192_probe(struct spi_device *spi)
     if (ret)
         return dev_err_probe(&spi->dev, ret, "Failed to enable
specified DVdd supply\n");

-    ret = regulator_get_voltage(st->avdd);
+    ret = regulator_get_voltage(st->vref);
     if (ret < 0) {
         dev_err(&spi->dev, "Device tree error, reference voltage undefined\n");
         return ret;
-- 
2.34.1
