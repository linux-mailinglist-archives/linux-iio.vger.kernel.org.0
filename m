Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4785890E8
	for <lists+linux-iio@lfdr.de>; Wed,  3 Aug 2022 19:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbiHCRB6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Aug 2022 13:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbiHCRB5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Aug 2022 13:01:57 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACE75070E;
        Wed,  3 Aug 2022 10:01:55 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u9so20502363oiv.12;
        Wed, 03 Aug 2022 10:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FmXpKV8L1ROy4Dh0Qt2TT7rzbx5rKU4HTkrXEsPEgGo=;
        b=XLv9GzLaso1z0kUpccYFo7qXgLFVwOwXORFMlFM/tMwCTXHHDy5IUMJyIhd+U311bX
         Xu3T0n7FNbhArU+b9IUDQvT3zg1kw1Tf8s58ZIef7Ycx014Z2cLID6VTSKVA3yXBJ689
         PoSXxHKgTjHNHvTj4xcxZ8XTrenqKdHOqOR9t7en6e8UJQSQBamQN41otiSC4mN2Pirg
         SlR/aoMBvxHaqJnic3Nvj9uTo3JRCJpoTZrT8XxDGyLmk3kp1LNNyt0LohiCh2bnnpey
         8cKaEfRwp63pMJtYvhHtRqSNwZSWIwk/LA6R31HOD/iTpLz1pZNTRcaKmY3Vbrome3uw
         UaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FmXpKV8L1ROy4Dh0Qt2TT7rzbx5rKU4HTkrXEsPEgGo=;
        b=Cfm861w6vscLUfHY8PrlWVMhjFEAwH1RrJ9jqdRNWS59iQxAfiSy7c2r6GXwpm4hk1
         WGTroG/B5x2jC9+B9qokgYNcp+SyzOw/VgBbr0tTXRvDMcUBpKVfM2NrMExcLYEw3TBw
         vdbKso1dtFk4jVIe8agOOBHuUXEJDfXXRIQog31vW1dzOY9gEWVxQdMteBL8joyZEUIF
         04XDkKWWslkPcrMWiZ0M0njLdt9yWL89nziOx13RouXIMTX2edF/lBiu0Xa/exWh3y/w
         jMyuo4nlQmWX4sADhJg9yazA4sLMF18Ca98iS3DauSYZNegnelr5aPSj0giPVeIJeIs2
         ygvw==
X-Gm-Message-State: ACgBeo3X12zNzwHQtc6ysO+3fAxtKeH6ls8UpV2cHcQ8bdDGcJWuDX4/
        frMeEgbk/GQ1IGYLtYy4hIg5puf6S6k=
X-Google-Smtp-Source: AA6agR6LzO51AVlHmiFmSB5U9pLWazAoyDWwcV6PcvhhhibQSKjkOsUSvjPRC6l0CRKIhXLF4DeHTQ==
X-Received: by 2002:a05:6808:1708:b0:335:1b16:fb09 with SMTP id bc8-20020a056808170800b003351b16fb09mr2117431oib.7.1659546114135;
        Wed, 03 Aug 2022 10:01:54 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id q16-20020a05683033d000b0061c29a38b3bsm4088453ott.33.2022.08.03.10.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 10:01:53 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, dmitry.torokhov@gmail.com,
        contact@artur-rojek.eu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        jic23@kernel.org, paul@crapouillou.net,
        Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v9 1/3] dt-bindings: adc-joystick: add poll-interval
Date:   Wed,  3 Aug 2022 12:01:43 -0500
Message-Id: <20220803170145.16186-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803170145.16186-1-macroalpha82@gmail.com>
References: <20220803170145.16186-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Add poll-interval support for the adc-joystick documentation. This is
an optional value and if not provided the adc-joystick works as it
does today (with buffers). If this value is provided, the adc-joystick
driver is polled at the specified interval. The existing attribute of
"poll-interval" was used instead of complying with property-units.yaml
after discussion of the issue on the mailing list.

Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Artur Rojek <contact@artur-rojek.eu>
---
 Documentation/devicetree/bindings/input/adc-joystick.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/adc-joystick.yaml b/Documentation/devicetree/bindings/input/adc-joystick.yaml
index 2ee04e03bc22..ab5caad055ea 100644
--- a/Documentation/devicetree/bindings/input/adc-joystick.yaml
+++ b/Documentation/devicetree/bindings/input/adc-joystick.yaml
@@ -14,6 +14,9 @@ description: >
   Bindings for joystick devices connected to ADC controllers supporting
   the Industrial I/O subsystem.
 
+allOf:
+  - $ref: input.yaml#
+
 properties:
   compatible:
     const: adc-joystick
@@ -28,6 +31,8 @@ properties:
       https://github.com/devicetree-org/dt-schema/blob/master/schemas/iio/iio-consumer.yaml
       for details.
 
+  poll-interval: true
+
   '#address-cells':
     const: 1
 
-- 
2.25.1

