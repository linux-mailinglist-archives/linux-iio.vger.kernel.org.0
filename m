Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F885891AA
	for <lists+linux-iio@lfdr.de>; Wed,  3 Aug 2022 19:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbiHCRpS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Aug 2022 13:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbiHCRpS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Aug 2022 13:45:18 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3082DF0;
        Wed,  3 Aug 2022 10:45:17 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id k25-20020a056830169900b0061c6f68f451so12648979otr.9;
        Wed, 03 Aug 2022 10:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FmXpKV8L1ROy4Dh0Qt2TT7rzbx5rKU4HTkrXEsPEgGo=;
        b=SCtGjXpQVoKIpxtAyZk++KjKMr9rCo21niMsPRrUvenRuBlxTbSseU28pFkuHqh8FX
         Xykwfzh4Sml8eslvIY9bmg25WlopXFA2UureEZHzYiAx3CHe/nq3nmw56XmCv2FYBy0t
         hAMhUPqAVtLa41OyZbUEp69LDm5sOkd7VcSVreYxDqsGXu8q1uP1l6T4XuLLxvZdbVSZ
         YP1zagr+RoGupJ5gk4zHhLm50BUuHeSFWzDVIpus2Ga7JmyI+K0CLWwjLI0ucF3jBQSH
         m9p14GGB2b2Mbye44d1fl4sfXcHjMOQ7y4hH8tcNYy3HTrfi5tqI6LhesMkkT0UE9GUK
         NqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FmXpKV8L1ROy4Dh0Qt2TT7rzbx5rKU4HTkrXEsPEgGo=;
        b=i4l+tpEnphpLr7xGoYhNCS0FOA4ttfLhSq7luaisPkWQ1ieNBtGgHcNkCo92kTslPU
         01dhQaHqSpqqn4vEgrGTzvPsrUmWze/Cq1art9bRkOR3lpjUjV1rv7h7vRZGPOXP8fwJ
         h/hOu/mwAnMHL48hT5tB/ApNx9Md6BORShIAVZb28M1linH8xqZW59LNfjcGtpHofO0P
         TdrC6aOayszYX2PfgkKF71W7G+r44NLNfu5WpwgTzZB5PfG3sAS7Mh5EfFBQKrDW6+yF
         ppt/Nq3RTfNeWcxhEOIRCY/XmRFedhLlPICRfItAvle7XO/SqaynBKinCxILP+eCZOha
         +EoQ==
X-Gm-Message-State: ACgBeo3zrB/uQZ587QpK0xxh2pESrFPKt84Hk7yMOmQGy5m9MCRc8mE5
        F+jIGPf5ak2Am6j63R2M+wJtCkFeFcU=
X-Google-Smtp-Source: AA6agR6jI3Xbzz+VFMZY+Y5gnDosB44jxMB1eE17H8nXvRUzy6UDOYkbcwJA8mu+Ep9HwrwT0qlC9A==
X-Received: by 2002:a05:6830:18f0:b0:628:b0f5:a003 with SMTP id d16-20020a05683018f000b00628b0f5a003mr6101530otf.107.1659548716528;
        Wed, 03 Aug 2022 10:45:16 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id bx6-20020a0568081b0600b0033a6bfdc5adsm3551893oib.36.2022.08.03.10.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 10:45:15 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, dmitry.torokhov@gmail.com,
        contact@artur-rojek.eu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        jic23@kernel.org, paul@crapouillou.net,
        Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v10 1/3] dt-bindings: adc-joystick: add poll-interval
Date:   Wed,  3 Aug 2022 12:45:03 -0500
Message-Id: <20220803174505.21420-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803174505.21420-1-macroalpha82@gmail.com>
References: <20220803174505.21420-1-macroalpha82@gmail.com>
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

