Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01707582FB8
	for <lists+linux-iio@lfdr.de>; Wed, 27 Jul 2022 19:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiG0RaL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Jul 2022 13:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242132AbiG0R1t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Jul 2022 13:27:49 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A227E82D
        for <linux-iio@vger.kernel.org>; Wed, 27 Jul 2022 09:47:24 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t22so21550669lfg.1
        for <linux-iio@vger.kernel.org>; Wed, 27 Jul 2022 09:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G58v43xma03waMnam16LPp6PjErsC4YB3W0kFW2yXEw=;
        b=bkweZ8DUw8CXRKbjPLdIjIMR9jSuhPlbY/WgGBuPuZjvISu/X5g5hsJldTx/S+tux5
         H1O6H4yiGvwQuw1wPyBDRmR+MHE/HKQu4JZEe78b2PiTONvXPu+p7gBmrVsgbfQx0OLH
         O0ebEpNNCLP2YOE3Q/zCZzt7+T0hlOie7x9iPFMjO58tEoMfwIBRoFxRzD0Tp0BsoA8b
         wDINxw4SiKwKwavER2Nl5vmkU5yVOBavA3s63FgBX7zfE0gBoV6tA1qNVfywm6nkWmJg
         P9EvVQodM6kgg1iGz1M3SEzo8hjH1ZxzrxKM2yn7qczRHbEy6cdzNrnmptoI5dit7JGU
         DpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G58v43xma03waMnam16LPp6PjErsC4YB3W0kFW2yXEw=;
        b=g8Gw0vIXTW3vgoDDPQifJ8tLvFpy7O5r30A3Z0YtGF9RkZC+vGK4e2fnTR6leCHxIW
         emMv6CizQg5/D+U3l7jqYer5ENmZIj7WWSgWdtqZaVLC0INckGXEw4K3EtOjWlFlDD8d
         cTONFYd/KIpc8B1vIstqnh5AZz+2hCAmK2W0udlHWfjcYJBTYzdbOkz76C9lg+bNeg9L
         86VtT0omu+NgM9dN7YBTFjW3x+63Lmwf8v3w7MJKqiTyIlrkbqrPZvgSOWhMsVUk2uve
         1q0MKfajkdQowlkuNl/T+iuhCwvsvCqOlnbWiKKrpKEXadzGERGg13ukVpFoJaETiP3A
         9+ew==
X-Gm-Message-State: AJIora/uigWaL5fM1xCQ/MK4YDy4OMB36hpOyZlF6lima2zkKhsPAwY5
        eYkDcpcHL5W7vmWFqvjfZpih8w==
X-Google-Smtp-Source: AGRyM1vH0CUVOEcBUq1/Yiy2wWxdiPJq8QJMm8MMUeir/jyTAwdNpR1ErRGBl6KcNmi7ge05zM/W9Q==
X-Received: by 2002:a05:6512:1393:b0:489:dd15:f04b with SMTP id p19-20020a056512139300b00489dd15f04bmr8180807lfa.284.1658940440119;
        Wed, 27 Jul 2022 09:47:20 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id 18-20020ac25f52000000b0048910301774sm3375149lfz.307.2022.07.27.09.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:47:19 -0700 (PDT)
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
Subject: [PATCH v2 06/10] dt-bindings: iio: health: ti,afe4403: use spi-peripheral-props.yaml
Date:   Wed, 27 Jul 2022 18:46:42 +0200
Message-Id: <20220727164646.387541-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220727164646.387541-1-krzysztof.kozlowski@linaro.org>
References: <20220727164646.387541-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 .../devicetree/bindings/iio/health/ti,afe4403.yaml       | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml b/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
index d861526c5c42..6c5ad426a016 100644
--- a/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
+++ b/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
@@ -25,14 +25,15 @@ properties:
 
   reset-gpios: true
 
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
     #include <dt-bindings/gpio/gpio.h>
-- 
2.34.1

