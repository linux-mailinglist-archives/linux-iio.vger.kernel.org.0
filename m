Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB6F595C01
	for <lists+linux-iio@lfdr.de>; Tue, 16 Aug 2022 14:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbiHPMoC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Aug 2022 08:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbiHPMnz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2022 08:43:55 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC70DF96
        for <linux-iio@vger.kernel.org>; Tue, 16 Aug 2022 05:43:40 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id z20so10410940ljq.3
        for <linux-iio@vger.kernel.org>; Tue, 16 Aug 2022 05:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=25kGp1R6sNVNV9rfY1t5fR7dCTF0m8KzqyUsA0pv9iI=;
        b=SAZXhE6pYMGTWuPsCBHwqD6iFSpsR9Q3c9lwiB0V7zyL0V+LM9+ddw9CJHfSs94q3h
         a4RrIuutZ0oOldk8ABOPO7eon2if33U7YxT+VwZsZRnXsNx51Fi3oN1rapMx/yAhfY5d
         6Dp0mI5O32CBEuZx4/W4Xx5q7Q4PESKgDWlraU4GgWShYpuUvblcyU+kKpxy3I/2JCD8
         18bsiP5gD9vwQhbr4Kc79x01cNkOj/TvG1F9IxNzgV0fhpeWAblmGkB8TOOtwYDxCf7J
         8DMVyDR8P9/6S9ALHv/gntLBOn4XOnqC0e+C7K0LwJ7d6GAAzG0NJ2UOZhd57muv5ukF
         554w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=25kGp1R6sNVNV9rfY1t5fR7dCTF0m8KzqyUsA0pv9iI=;
        b=N2uaFMNKIpIhS1mo+5PdLUUsuhnXd9Tfm8FPX0Ot0S5cpOGPeqmz9YSIwx2MOwoyxB
         kn2juOQBJn9GSFAaqE68SXMv3J+S8g/fN+BoOpU9hQilfRdjUjr3J0TvsG7qQoFHcUzP
         RjmIiQNJFfFgA1jou2ncjl4hqNCdST7OyOi63spfmaBj9YalFjEOKDCgH+ULKYmuDkfJ
         nL6TrSWPSJp2s5CKW+Xw6hombRcnuqsL+jG1J2WHtn3GqE4fUputO1ORhbh1taElrKWh
         YnrvZ46mJiUrRhZdH8I8iBMZdYlgN/wjDvpF0EqRHWjPWNJyccV5xo61tvRqPmEZf1je
         M60g==
X-Gm-Message-State: ACgBeo0679WEYyA0nlSYd7QM8dkGvzaE0HSmS9EvpgrApMPCRlIQZfBy
        cfEcT4yAyqzLDWy1SeC6otJIsQ==
X-Google-Smtp-Source: AA6agR54VexO0jqdOpzKC8eTsuehjyF4oJsx2eWwjTxiq2eXj9Qn9oQyh7jIFIXBdKT0o3Nc4S682A==
X-Received: by 2002:a05:651c:2d0:b0:25e:6c94:59d5 with SMTP id f16-20020a05651c02d000b0025e6c9459d5mr6707805ljo.488.1660653817871;
        Tue, 16 Aug 2022 05:43:37 -0700 (PDT)
Received: from krzk-bin.. (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id k14-20020ac257ce000000b0048ae4cf8a2csm1374331lfo.258.2022.08.16.05.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 05:43:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Oleksij Rempel <linux@rempel-privat.de>, kernel@pengutronix.de,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Patrick Vasseur <patrick.vasseur@c-s.fr>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexandru Lazar <alazar@startmail.com>,
        Oskar Andero <oskar.andero@gmail.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <martenli@axis.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Andrew Davis <afd@ti.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Phil Reid <preid@electromag.com.au>,
        Michael Welling <mwelling@ieee.org>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Coffey <cmc@babblebit.net>,
        Slawomir Stepien <sst@poczta.fm>,
        Sankar Velliangiri <navin@linumiz.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 02/10] dt-bindings: iio: accel: use spi-peripheral-props.yaml
Date:   Tue, 16 Aug 2022 15:43:13 +0300
Message-Id: <20220816124321.67817-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220816124321.67817-1-krzysztof.kozlowski@linaro.org>
References: <20220816124321.67817-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Instead of listing directly properties typical for SPI peripherals,
reference the spi-peripheral-props.yaml schema.  This allows using all
properties typical for SPI-connected devices, even these which device
bindings author did not tried yet.

Remove the spi-* properties which now come via spi-peripheral-props.yaml
schema, except for the cases when device schema adds some constraints
like maximum frequency.

While changing additionalProperties->unevaluatedProperties, put it in
typical place, just before example DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/iio/accel/adi,adis16201.yaml       | 7 ++++---
 .../devicetree/bindings/iio/accel/adi,adis16240.yaml       | 7 ++++---
 .../devicetree/bindings/iio/accel/adi,adxl313.yaml         | 7 ++++---
 .../devicetree/bindings/iio/accel/adi,adxl345.yaml         | 7 ++++---
 .../devicetree/bindings/iio/accel/adi,adxl355.yaml         | 7 ++++---
 .../devicetree/bindings/iio/accel/adi,adxl367.yaml         | 7 ++++---
 .../devicetree/bindings/iio/accel/adi,adxl372.yaml         | 7 ++++---
 .../devicetree/bindings/iio/accel/bosch,bma220.yaml        | 7 ++++---
 .../devicetree/bindings/iio/accel/bosch,bma255.yaml        | 5 ++++-
 .../devicetree/bindings/iio/accel/bosch,bmi088.yaml        | 7 ++++---
 .../devicetree/bindings/iio/accel/fsl,mma7455.yaml         | 7 ++++---
 .../devicetree/bindings/iio/accel/kionix,kxsd9.yaml        | 7 ++++---
 .../devicetree/bindings/iio/accel/murata,sca3300.yaml      | 5 ++++-
 .../devicetree/bindings/iio/accel/nxp,fxls8962af.yaml      | 7 ++++---
 14 files changed, 56 insertions(+), 38 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
index 6f8f8a6258fe..7332442e5661 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
@@ -27,15 +27,16 @@ properties:
   interrupts:
     maxItems: 1
 
-  spi-max-frequency: true
-
   vdd-supply: true
 
 required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
index 8d829ef878bc..f6f97164c2ca 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
@@ -25,14 +25,15 @@ properties:
   interrupts:
     maxItems: 1
 
-  spi-max-frequency: true
-
 required:
   - compatible
   - reg
   - interrupts
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
index d6afc1b8c272..05fa7af409cc 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
@@ -24,8 +24,6 @@ properties:
 
   spi-3wire: true
 
-  spi-max-frequency: true
-
   vs-supply:
     description: Regulator that supplies power to the accelerometer
 
@@ -48,7 +46,10 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
index 9bb039e2f533..346abfb13a3a 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
@@ -32,8 +32,6 @@ properties:
 
   spi-cpol: true
 
-  spi-max-frequency: true
-
   interrupts:
     maxItems: 1
 
@@ -42,7 +40,10 @@ required:
   - reg
   - interrupts
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
index ba54d6998f2e..14b487088ab4 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
@@ -45,13 +45,14 @@ properties:
   vddio-supply:
     description: Regulator that provides power to the bus
 
-  spi-max-frequency: true
-
 required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
index d259e796c1d6..f10d98d34cb8 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
@@ -35,8 +35,6 @@ properties:
   interrupts:
     maxItems: 1
 
-  spi-max-frequency: true
-
   vdd-supply: true
   vddio-supply: true
 
@@ -45,7 +43,10 @@ required:
   - reg
   - interrupts
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
index 38b59b6454ce..73a5c8f814cc 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
@@ -25,14 +25,15 @@ properties:
   interrupts:
     maxItems: 1
 
-  spi-max-frequency: true
-
 required:
   - compatible
   - reg
   - interrupts
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
index 942b23ad0712..5dd06f5905b4 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
@@ -20,8 +20,6 @@ properties:
   interrupts:
     maxItems: 1
 
-  spi-max-frequency: true
-
   vdda-supply: true
   vddd-supply: true
   vddio-supply: true
@@ -30,7 +28,10 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
index 478e75ae0885..457a709b583c 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
@@ -72,7 +72,10 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
index 272eb48eef5a..3cb82576d758 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
@@ -24,8 +24,6 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-
   vdd-supply: true
 
   vddio-supply: true
@@ -50,7 +48,10 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/accel/fsl,mma7455.yaml b/Documentation/devicetree/bindings/iio/accel/fsl,mma7455.yaml
index 9c7c66feeffc..c8659c5eba2a 100644
--- a/Documentation/devicetree/bindings/iio/accel/fsl,mma7455.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/fsl,mma7455.yaml
@@ -39,13 +39,14 @@ properties:
         - "INT1"
         - "INT2"
 
-  spi-max-frequency: true
-
 required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml b/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml
index 390b87242fcb..f64d99b35492 100644
--- a/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml
@@ -29,13 +29,14 @@ properties:
   mount-matrix:
     description: an optional 3x3 mounting rotation matrix.
 
-  spi-max-frequency: true
-
 required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml b/Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml
index f6e2a16a710b..00c990caa1e4 100644
--- a/Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml
@@ -29,7 +29,10 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
index ad529ab2c6e2..65ce8ea14b52 100644
--- a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
@@ -27,8 +27,6 @@ properties:
   vdd-supply:
     description: phandle to the regulator that provides power to the accelerometer
 
-  spi-max-frequency: true
-
   interrupts:
     maxItems: 1
 
@@ -44,7 +42,10 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

