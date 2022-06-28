Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF01D55EDBE
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 21:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbiF1TP2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jun 2022 15:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238225AbiF1TPG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2022 15:15:06 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E993FB5B;
        Tue, 28 Jun 2022 12:15:05 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id a7so3727518ilj.2;
        Tue, 28 Jun 2022 12:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/n4ZGb/068nKpvUj2aEVlkDxH0ZLUUwUoAPZOtzHeaw=;
        b=FreFHvJED6l8YeDZnVOHuHLKagfq/efvYJ1oMCwGE+Z5d5eIv7A6xSeRuEstULrwbr
         L+ViFaEi2OPPO7EXllvmzn2X2btIjj6YXbxksYmpq1MyvNk4JGvtM9UjdnzhQ8TYd0x2
         SXGZROUDIH36+o47065wJrb6qZGn4Q+x4cRCI3p3WEaDs9nRyAlEC5vERW2FLKsfDyIA
         ake1Jo/bc6iifmrUblRLJirP2CjjN6u7yvRi407Wlv5VKihURklf1HpkgnVJO+37Iggw
         8hVP2Yqa+feaDtHkopbRBC7O5jTM+pW37140Pvhwjve00QrzqrHj7SG46+26PHP4+eBk
         0ZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/n4ZGb/068nKpvUj2aEVlkDxH0ZLUUwUoAPZOtzHeaw=;
        b=NalsJ8l68/wzIDnAnWb7uhi+4u94wwlPe701kN8Dffl/WjQLzB53EYwkNnjQ9/kgb0
         CP9+0MrpuQERoY998y+seFm4iCWkUIUe7N0s1wJocu2gvUKPtAVW4D99tEaZS/vL/Atq
         i/q7h3IMr8JAeKx3mkxaQqk95h/6RHt8/UQtGN1zgF4IqDjY2YwXKrvtWXwAg9JlVL/r
         UOdTXpM34ECfa2phXwu1nWyjv5GeTNdW1izXKSTZ5+G0n05RFRbZghyQh58uHuZa/ddf
         fYHY9SS1EZWmHNv9jz8ttnwUux49FK00Da/MQJ3IoKM0WJ3ZppwaODp+9xVl9rluR61K
         svVw==
X-Gm-Message-State: AJIora+jHE1Gi9btDJ1hnmc0x/GMVHzdq3HPb0QXxLWHO2EveMhkgPZi
        3iVA8bu2c8NYaBo4vms8cmptJFpzPGI=
X-Google-Smtp-Source: AGRyM1txgww6e5MmaT16qH4j1VatQDpetfmdZN/OVKb1BVkQJvXq01cSMk5Wi6nRTCX2f/cWgiLb5w==
X-Received: by 2002:a92:b00e:0:b0:2d6:538b:b866 with SMTP id x14-20020a92b00e000000b002d6538bb866mr11059856ilh.199.1656443705116;
        Tue, 28 Jun 2022 12:15:05 -0700 (PDT)
Received: from Dixie.. ([2604:2d80:a188:fd00:5448:c223:9fa4:5f87])
        by smtp.gmail.com with ESMTPSA id c97-20020a02966a000000b0032b74686763sm6396009jai.76.2022.06.28.12.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 12:15:04 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     devicetree@vger.kernel.org, contact@artur-rojek.eu,
        maccraft123mc@gmail.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, paul@crapouillou.net, jic23@kernel.org,
        linux-iio@vger.kernel.org, Chris Morgan <macroalpha82@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v5 1/3] dt-bindings: adc-joystick: add poll-interval-ms
Date:   Tue, 28 Jun 2022 14:14:58 -0500
Message-Id: <20220628191500.69831-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220628191500.69831-1-macroalpha82@gmail.com>
References: <20220628191500.69831-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

New devicetree attribute of "poll-interval-ms".

Add poll-interval support for the adc-joystick documentation. This is
an optional value and if not provided the adc-joystick works as it
does today (with triggered buffers). If this value is provided, the
adc-joystick driver is polled at the specified interval. A new
attribute was added instead of using the existing attribute of
"poll-interval" to comply with rules detailed in property-units.yaml.

Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 Documentation/devicetree/bindings/input/adc-joystick.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/adc-joystick.yaml b/Documentation/devicetree/bindings/input/adc-joystick.yaml
index 2ee04e03bc22..cfd8d1af5d2c 100644
--- a/Documentation/devicetree/bindings/input/adc-joystick.yaml
+++ b/Documentation/devicetree/bindings/input/adc-joystick.yaml
@@ -18,6 +18,12 @@ properties:
   compatible:
     const: adc-joystick
 
+  poll-interval-ms:
+    description:
+      Poll interval time in milliseconds. If not specified, device will use
+      iio buffer.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
   io-channels:
     minItems: 1
     maxItems: 1024
-- 
2.34.1

