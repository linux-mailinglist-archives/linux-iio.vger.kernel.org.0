Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F283582F9F
	for <lists+linux-iio@lfdr.de>; Wed, 27 Jul 2022 19:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242164AbiG0R2c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Jul 2022 13:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiG0R1g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Jul 2022 13:27:36 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7847F50E
        for <linux-iio@vger.kernel.org>; Wed, 27 Jul 2022 09:47:16 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id r14so20446971ljp.2
        for <linux-iio@vger.kernel.org>; Wed, 27 Jul 2022 09:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mXw/gx1TvWDFNgjG1qr/pqI36Mmqb6KSC/b/lR/QsLU=;
        b=layrHSzuuv7WZaKIMxqMlq4RK1ZL55arpJ65jtX7RdCUtFejuIaL8Knr9jz9MPtQKa
         igjYvSZ7O12G4rPWOkL6+xA/t65NoZGrKQFnnZ8lsn6tYFWQFIaBT+PRnfSXjl4vmNPA
         zRpZP3PKnU0ia3VaEVGFu4o/i1c1z8g6RjQz8SM1A4n329tpp8JeQNmbqX3HpN8bbNc9
         DzW/KCI3QSS+5TMzXtB9XuXEfHWaomVMtzZSZRnmtlRaKVWIyb+/4Yf5rFrsES3ShMUx
         Y67Fvc9DW12vdPuz0tv6k2Q43OjsUTwYy6HsU1dMrrFrwwUcgFcGPTZ/U1Eb35abgpDX
         +P4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mXw/gx1TvWDFNgjG1qr/pqI36Mmqb6KSC/b/lR/QsLU=;
        b=y17pvkGo5jD7xC/2LM9dDD/aO0QrmV3j1RlYJrZnfwkThkAHdIrMP5ppqg64M940Go
         z7N4Fvq6+O7lvSNfIKkxXcoljX4UKBDmf7Tdp4NW7ICEVct6kJyixSoH4f2msk9+RjoB
         r7a0qnb0wKW0SiqdfwLIrhPlqmkknKC8FnugTENubdD7wrXpvx+G6lkn7ZTEjstsjgB7
         nkUB3kIGHpQWtlf0LL0UCswgxA2RJlW3rdZHT8YWdINTHt/bP1KKG9UVWiVDNWbZq2Vp
         97x79uDzntRv4rkmCt6+aIU/JqLze/LMe4oPVG8IpIY3LeSYggsXpwjRlSemKguJdSRT
         h1ig==
X-Gm-Message-State: AJIora9jDiIHewuYNxDX2sil9TQVNq/dC6UmHP9nYIsogt6C/7OkWu2G
        o7wL+NeZ2KI9jiOqsDd0mGENUQ==
X-Google-Smtp-Source: AGRyM1uCkfI3WTlZUr7WEZGfvAesB7wgSz0zkg+J9RomegxGE4tsQI4qHhyYZ9pnFuMvhJCs3YaR9Q==
X-Received: by 2002:a2e:844a:0:b0:255:46b9:5e86 with SMTP id u10-20020a2e844a000000b0025546b95e86mr7505870ljh.388.1658940430765;
        Wed, 27 Jul 2022 09:47:10 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id 18-20020ac25f52000000b0048910301774sm3375149lfz.307.2022.07.27.09.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:47:10 -0700 (PDT)
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
Subject: [PATCH v2 03/10] dt-bindings: iio: amplifiers: adi,ada4250: use spi-peripheral-props.yaml
Date:   Wed, 27 Jul 2022 18:46:39 +0200
Message-Id: <20220727164646.387541-4-krzysztof.kozlowski@linaro.org>
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
 .../devicetree/bindings/iio/amplifiers/adi,ada4250.yaml    | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
index 5277479be382..c15da155d300 100644
--- a/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
@@ -27,14 +27,15 @@ properties:
       Enable internal buffer to drive the reference pin.
     type: boolean
 
-  spi-max-frequency: true
-
 required:
   - compatible
   - reg
   - avdd-supply
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

