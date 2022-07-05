Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB56567731
	for <lists+linux-iio@lfdr.de>; Tue,  5 Jul 2022 21:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbiGETEI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Jul 2022 15:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiGETEH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Jul 2022 15:04:07 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EE81FCD9;
        Tue,  5 Jul 2022 12:04:03 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id m13so12081985ioj.0;
        Tue, 05 Jul 2022 12:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VOU+KnItVhf/B0aHx7CqIES1feV9qodTdW7HnBjAhyA=;
        b=Ikn1jwPxdb71CgjahsFcC/VLGtmxh7JDywjYFz9Kg1yWn8Fe7Z6ysZV2p4YwwacPLR
         Oy+gWA7wHVsyr9Cfi/+FZJ4PAbytY4aRFg+6/hlk7fCiV1A85B8ewQnj0yyx0u+SQWtq
         kOaJkjLBmoUx0BKE4dYngogxDlxjir+nui0zl+fu39gzweXOG8uRqWadwz3fl36CZP3U
         RTd8uJCPtoJvoGTdqczgq6w4vAqn0okWnlzBaGYDrYQIqVH6BmqPDuSoUwdN3tUSLOZk
         Xx3z9VXSY2jBPcYTdbxo39U4xty3PhdmhoEVEtrIfjyhmObnzZT+cL2JgFd/bIzRmzT4
         +/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VOU+KnItVhf/B0aHx7CqIES1feV9qodTdW7HnBjAhyA=;
        b=lWakXYaApgDO7U38uFVYi52d7grmJfkWLpo4e5THYMibwBcdoLBTmEpJGPTcZLYJoM
         I63sQ2zQOm87wHh8rKWVfaVXqkn7K+mwvXzizCGukNO7l63kwZ+fVCkxCkE31x399r3V
         cQl4Di3NyHVir6p96eOr3WaQEBxGPfw5TH94o/lC9OAxj1poFOHgLk9BKWE0T0rm8kBM
         WedqTMpen/Ik8HwRdtfD59yTQwDQ5/SshSAgI4Q/M2H4mWi2ovjXzwVJRNQVlcnQBMCU
         HppBzufIW28nlgnrkK/nN+MC4jkusIgOKrjnKw5iSuGA7r/8UnD65QpBNdv6q4C0Ec3k
         kL9Q==
X-Gm-Message-State: AJIora+ewz7NohIZZC8bX2tTrdm35IGgaqN4VGrc/sxdvrto5p7VaqvG
        XKOLV1NWonlOubHy9A1f6+avA6wwK64=
X-Google-Smtp-Source: AGRyM1tUwNRE+1mxsYpsdSPIaTqNtqn7yE/Xp0n83SaMmuxIEfS+YhEaVW/SuytU5IAt15NQs35Gsg==
X-Received: by 2002:a05:6638:260a:b0:339:e6de:2116 with SMTP id m10-20020a056638260a00b00339e6de2116mr22376259jat.302.1657047842691;
        Tue, 05 Jul 2022 12:04:02 -0700 (PDT)
Received: from Dixie.. ([2604:2d80:a188:fd00:a8dc:16da:96d1:2d19])
        by smtp.gmail.com with ESMTPSA id d93-20020a0285e6000000b0033efe01c20esm397762jai.42.2022.07.05.12.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 12:04:02 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
X-Google-Original-From: Chris Morgan <macromorgan@hotmail.com>
To:     linux-input@vger.kernel.org
Cc:     devicetree@vger.kernel.org, contact@artur-rojek.eu,
        maccraft123mc@gmail.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, paul@crapouillou.net, jic23@kernel.org,
        linux-iio@vger.kernel.org, Chris Morgan <macroalpha82@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v7 1/3] dt-bindings: adc-joystick: add poll-interval
Date:   Tue,  5 Jul 2022 14:03:52 -0500
Message-Id: <20220705190354.69263-2-macromorgan@hotmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220705190354.69263-1-macromorgan@hotmail.com>
References: <20220705190354.69263-1-macromorgan@hotmail.com>
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

From: Chris Morgan <macroalpha82@gmail.com>

Add poll-interval support for the adc-joystick documentation. This is
an optional value and if not provided the adc-joystick works as it
does today (with buffers). If this value is provided, the adc-joystick
driver is polled at the specified interval. The existing attribute of
"poll-interval" was used instead of complying with property-units.yaml
after discussion of the issue on the mailing list.

Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
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
2.34.1

