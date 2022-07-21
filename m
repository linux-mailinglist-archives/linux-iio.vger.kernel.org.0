Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6E757D1DD
	for <lists+linux-iio@lfdr.de>; Thu, 21 Jul 2022 18:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiGUQqR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Jul 2022 12:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiGUQqM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jul 2022 12:46:12 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F41D88101;
        Thu, 21 Jul 2022 09:46:12 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-10d6ddda695so3207423fac.0;
        Thu, 21 Jul 2022 09:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FmXpKV8L1ROy4Dh0Qt2TT7rzbx5rKU4HTkrXEsPEgGo=;
        b=SiFGahuH5PdKcRpgSbKIXKVarUDcfraqAzK34hwJqu2u5LSEqNYvmTi8a89CD9kZQc
         TtKs7+v6pNsSPw4fbFVJ2V+XDQOSwVUmDrf1sk96V9Gy92j5vuat7tyvnj5iKk625CAJ
         4H7A7wo++73OfxVcw8E25q/rcgPX6L4XnvraOthMYNylQ5Js3PRx8zTmReaB1EyfDmPJ
         s6SAYkheSACrvMtQNjYrDwtM+U6xOq0xK2aCvtYC9V+q6yZibFfD+QpTZFJrR/IySLoI
         Q/MoI7vkrNxWUiy+R62uarFrNyZBXSXgh2KVxOXg8YnWI7BXiLncHptkrhBeDE2vzndj
         XsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FmXpKV8L1ROy4Dh0Qt2TT7rzbx5rKU4HTkrXEsPEgGo=;
        b=u3+m4EJB99+IJ3BUetFb/GHz5dxQldzLMug2jP3HwW3d6lZNQJa7vPdrZZZnI5d4f7
         pGV5odQsuyzimZcpRVPplHiAfLrPxgS4neSWVdouIDwK+P9hLQazdDEvtNYKcvMhVah0
         53xTxuCJ/C2l4egvJb4SIxaCAbGJWnAbWs6c3MX7wunh7jVQiVs8eV4fSYPNTDbJvHH6
         eXzyEYYwTCp6pmDb+fUk9bsZguFG4dqAFi0pVgUDiLvB8queWTr+h6BXPeOp2g4ARFcc
         rPVWcUQG+gkUY9Udw1QIdOEgH3WrJSdRjeX+WQwUQyZ3HE0iYTlmaqgeeV0HyYMHc3sC
         XT7Q==
X-Gm-Message-State: AJIora9ZHBqwJoycaDLyQxlzJThkQ1e/C6Cj7sUL4nUYXK00kVX/IchA
        dNh8krXzjC0abM3GlQ1S7QyrU3xoaIQ=
X-Google-Smtp-Source: AGRyM1ucs7lTKF+U+AYUFgLdecTXONK3OQu+4kv91tPDZ8cv7M1e7yq5yVrvUzclv0qf6IwesAqpBQ==
X-Received: by 2002:a05:6870:829e:b0:10c:240b:cbb9 with SMTP id q30-20020a056870829e00b0010c240bcbb9mr5464805oae.115.1658421971030;
        Thu, 21 Jul 2022 09:46:11 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id f189-20020aca38c6000000b0033a45705cb2sm831512oia.8.2022.07.21.09.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 09:46:10 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        contact@artur-rojek.eu, jic23@kernel.org, paul@crapouillou.net,
        linux-iio@vger.kernel.org, Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v8 1/3] dt-bindings: adc-joystick: add poll-interval
Date:   Thu, 21 Jul 2022 11:46:01 -0500
Message-Id: <20220721164603.13534-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721164603.13534-1-macroalpha82@gmail.com>
References: <20220721164603.13534-1-macroalpha82@gmail.com>
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

