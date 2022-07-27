Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02C6582FEC
	for <lists+linux-iio@lfdr.de>; Wed, 27 Jul 2022 19:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242130AbiG0RbK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Jul 2022 13:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242263AbiG0R3L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Jul 2022 13:29:11 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE0080485
        for <linux-iio@vger.kernel.org>; Wed, 27 Jul 2022 09:47:35 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id p22so10648798lji.10
        for <linux-iio@vger.kernel.org>; Wed, 27 Jul 2022 09:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7axPEVk6MWtPTP7h5E9Ae0SR4WCvVBdWSVGZwXrfCJc=;
        b=OXVXmyiSwBKGxExCjMfAYqoW/5KcBGPFCllunr4xkxrHjAZAfzmM6C5GvVNZ9WEQ5n
         Vd/L2eEK7/Jjeh65uCxfhFzTpwW/nfY41WJO2GEJ5FxJPrUbsJunJnUDZnHRyd13jXNV
         el6qv/PaSM+iuGypevpNuTYXrfdWlfqJ4+hT3YN3sngePZTynARw5jANlBUTqDrgrZuI
         lGTcnP7reAfuXpo7kE6zlfzjXf/fsCeGhInXq0FMW8slnZbx8Fip//DVdVpO9N5r9Ss6
         ePb/gSBH8koPezr5mIrtzyAJSj95Ya4ZuV2zggUxbyOc9scukgioz7s73ng1wpBub0FS
         pIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7axPEVk6MWtPTP7h5E9Ae0SR4WCvVBdWSVGZwXrfCJc=;
        b=praXT1PcdU9TTl2cMg0pU5bdpIMZ6we7xpLnKahT8f0J3/ZEQGvqjceYCX+DHj3o3C
         Qqme5oMRvIyeEVyEiHpawjc56n7lkgw57SQ2T4jQP1kwUC4FxdkU5nTzhXB2DgvbpOoT
         uhWFWFrPhoK7eRiCg4A8TYjtqY4PFdYqjMPk/t5if0r9RUp2XYv/V3DIhl6BDRRsprCO
         KM0XB+5aUwnwJPuzKlKUdMRwAclxnjAC9PMNEpc3R+uYS2bE1xgY6GQQJrj+8hBKfYd6
         Yo7ORlBuEn3lT0+sN7wqPFsn5p63t4JdFJJ3zU5EwCuXrXOHXjdfzjiDtwZs1NAJ5rvH
         xihw==
X-Gm-Message-State: AJIora+llSWqCeeHkswehyp46c2Srky6WXHig8QVZiWSM/OS2lFkn2iV
        70PaxFXexQ8b1JqSV3E//VJHjw==
X-Google-Smtp-Source: AGRyM1sKYUvvHKjGHjubByE9l1jd6M1xEA+oiFn/KZJEYN6GKSHQtVPNl1ZvwRL1PD+wISXUf38VUw==
X-Received: by 2002:a2e:a99e:0:b0:25e:a54:8328 with SMTP id x30-20020a2ea99e000000b0025e0a548328mr4685386ljq.141.1658940447509;
        Wed, 27 Jul 2022 09:47:27 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id 18-20020ac25f52000000b0048910301774sm3375149lfz.307.2022.07.27.09.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:47:25 -0700 (PDT)
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
        Joachim Eastwood <manabian@gmail.com>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
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
        Bogdan Pricop <bogdan.pricop@emutex.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Dan Murphy <dmurphy@ti.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Phil Reid <preid@electromag.com.au>,
        Michael Welling <mwelling@ieee.org>,
        Lukas Wunner <lukas@wunner.de>,
        Robert Jones <rjones@gateworks.com>,
        Chris Coffey <cmc@babblebit.net>,
        Slawomir Stepien <sst@poczta.fm>,
        Sankar Velliangiri <navin@linumiz.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 08/10] dt-bindings: iio: potentiometer: use spi-peripheral-props.yaml
Date:   Wed, 27 Jul 2022 18:46:44 +0200
Message-Id: <20220727164646.387541-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220727164646.387541-1-krzysztof.kozlowski@linaro.org>
References: <20220727164646.387541-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 .../bindings/iio/potentiometer/microchip,mcp41010.yaml   | 9 +++++----
 .../bindings/iio/potentiometer/microchip,mcp4131.yaml    | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp41010.yaml b/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp41010.yaml
index 567697d996ec..87e88f2a9908 100644
--- a/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp41010.yaml
+++ b/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp41010.yaml
@@ -25,14 +25,15 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-
-additionalProperties: false
-
 required:
   - compatible
   - reg
 
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
 examples:
   - |
     spi {
diff --git a/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4131.yaml b/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4131.yaml
index 32e92bced81f..896fe0b5edcc 100644
--- a/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4131.yaml
+++ b/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4131.yaml
@@ -80,14 +80,15 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-
-additionalProperties: false
-
 required:
   - compatible
   - reg
 
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
 examples:
   - |
     spi {
-- 
2.34.1

