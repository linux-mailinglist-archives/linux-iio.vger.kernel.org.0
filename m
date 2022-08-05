Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D69F58AEA9
	for <lists+linux-iio@lfdr.de>; Fri,  5 Aug 2022 19:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240912AbiHERK2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Aug 2022 13:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238324AbiHERK1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Aug 2022 13:10:27 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C95EE3C;
        Fri,  5 Aug 2022 10:10:26 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id a14-20020a0568300b8e00b0061c4e3eb52aso2314489otv.3;
        Fri, 05 Aug 2022 10:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FmXpKV8L1ROy4Dh0Qt2TT7rzbx5rKU4HTkrXEsPEgGo=;
        b=fGtFjqjUZTaE+1OJmQbScVxWkhWw9cvHaiQtdBl8c8HnSzeu/0x5UwQ3IctHW0AmeN
         02La85NrT2JBh+V2FV1ki7Z8Q4497+xsl0XBdhbUODzzYOlCS+pHKqVY1EJvhtcnDMZK
         oCuMpGKmFA79GqgnbyXvMgKetOld3XXUhEJi/zjSK+SvZwl5WYLPdFstGsLkNeF6gKop
         1mqXwCPLEOzYe+Zp08FOxcbmmO8pNwP+LwqctLd8PL83olZz2DoDoRz71lHkYgf4rp/f
         61wvySHKOati7bs7YN+9C+kI+rGyplIm4Y5ZCF4OyV/PPq2YuaTidL31c25rAp26XSy0
         VV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FmXpKV8L1ROy4Dh0Qt2TT7rzbx5rKU4HTkrXEsPEgGo=;
        b=2c9BXikMfuZRLOvzkRHtx25boFilqDTCzC2vcnHSM/OqU+YiKWW/1A70J4CifiwgeN
         7LYIhcaJTnt+t26AW3EKAGJT4WqgIQ1G63nsf2RV3NNitvsiV/qwiUl/PMGArQzaxcXH
         j9D5KeWItMOZlH/9PnOWYWzbpb44tYbNW3t5ECvYd6/u8VfSxmp7LjlsEhH8X0x8FsWd
         4StzEoozOiVLdoW4ptSswb4GUmw5JRlb9AjAqv3yaZkBYiKar6ejQ9x1o03TGU1B/osY
         LxlywvtrfTkbI5W9YXdh+UDeMqnQENOAMY8/xCx3tcYAJ0WLwxscTNh4Zz107h4mpaes
         CnQA==
X-Gm-Message-State: ACgBeo1SUQXP+eeQmZHi3t+SEpcFXhaEVfrupUk1oturbG5q+69M/vRi
        8xwf6rOFjdXABk4wRCb82ouabIqWFaY=
X-Google-Smtp-Source: AA6agR6LkOM+saSc5rblBs8RK/FEZBpOZxpuQChaHMMcgkCFLIKJsxa+FQuIUqvAFzwl5WkSFD+O3Q==
X-Received: by 2002:a9d:14b:0:b0:61c:9129:c974 with SMTP id 69-20020a9d014b000000b0061c9129c974mr2923892otu.231.1659719425169;
        Fri, 05 Aug 2022 10:10:25 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id r32-20020a056870e9a000b0010e046491f8sm794126oao.57.2022.08.05.10.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:10:24 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, dmitry.torokhov@gmail.com,
        contact@artur-rojek.eu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        jic23@kernel.org, paul@crapouillou.net,
        Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v12 1/3] dt-bindings: adc-joystick: add poll-interval
Date:   Fri,  5 Aug 2022 12:10:14 -0500
Message-Id: <20220805171016.21217-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805171016.21217-1-macroalpha82@gmail.com>
References: <20220805171016.21217-1-macroalpha82@gmail.com>
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

