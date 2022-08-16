Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B1F596421
	for <lists+linux-iio@lfdr.de>; Tue, 16 Aug 2022 23:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbiHPVEx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Aug 2022 17:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237403AbiHPVEw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2022 17:04:52 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D0778239;
        Tue, 16 Aug 2022 14:04:49 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-10ee900cce0so13046936fac.5;
        Tue, 16 Aug 2022 14:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=A21nFlKuD8+ICRFIAaIi0RgG/Bv0AQvdG67qKve6GHc=;
        b=asbq5+lzGyuzDs4ltATFsGZ63cw3fDP6DpV6cDSQTI7M3tAdyonDkDi5Dc1gQltphH
         G7RB9GpT8AnAmItSFVJxmPA2jZkze4RupEzKOKSjyJgQm0u55GKWt2F+R8Tt2jA+9W8F
         YChNWtdmEbwjkHyeDKSKQEVkWME8na8yMRjlZhBlQqg86DxMR9+FbhaPprjpOPOqMeGm
         eRHdwRzGJ9tMRnrLtMDGcnXnOUG9xQQysEj1psnNT/F73SOe2UVv13C1INutTJPxPMtG
         eJoq88IgI3+gznuamSOvGulkv7G6xdlZhBzClw2LhbaOcRLsagUrU7Vv0akO+gCTyElH
         Rpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=A21nFlKuD8+ICRFIAaIi0RgG/Bv0AQvdG67qKve6GHc=;
        b=NZsmzcNw2dKVyc4TgT0CdsAuim+f1wW8V/scc0P+2EBBm5ypazQ3gVAkRNyPh8044R
         Faly7tWsd7jy4j0I62uEjKvCU5FqzWaFfEOGe+/GZEcy99vVBMd/B0jvqiKHjZXdSN3q
         1ogB4v++mEJkTpPSBnZPBA3l/E/zAWySa6WXBecQeQ+dsqkng+F9T/5G/B/K5tjmiTwk
         brUEz79s/QBSc37C3WFJW7oKvDd+R+u8jQCtPPzi5j9XMKK0kwM9lDOE/Fm5NtBbXQs+
         mLNZWJZuG5U40Dsgsxo+GOx6Ds2yfzLi2cvvsWBoyvz0OmKY1PB0NawXNxRC0WweHg6y
         UwZw==
X-Gm-Message-State: ACgBeo3VkXFbiCXIN1O4TNSH/jO1yfRfdcFPICLTW/NiEdzR3eXTCD25
        aUXl67bWQVgzjnqIuL+Pb3SJO9hlZ00=
X-Google-Smtp-Source: AA6agR66TfoMLTDTKbVuZ1JG9JplT03yAp3lBdJMPf5shFkgBbeyM6yvzIAfFt20Bbum1a/SpfF8+Q==
X-Received: by 2002:a05:6870:458d:b0:118:8649:aae1 with SMTP id y13-20020a056870458d00b001188649aae1mr199709oao.226.1660683888849;
        Tue, 16 Aug 2022 14:04:48 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id m24-20020a4ae3d8000000b00425678b9c4bsm2599653oov.0.2022.08.16.14.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:04:48 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, dmitry.torokhov@gmail.com,
        contact@artur-rojek.eu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        jic23@kernel.org, paul@crapouillou.net,
        Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v13 1/3] dt-bindings: adc-joystick: add poll-interval
Date:   Tue, 16 Aug 2022 16:04:38 -0500
Message-Id: <20220816210440.14260-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220816210440.14260-1-macroalpha82@gmail.com>
References: <20220816210440.14260-1-macroalpha82@gmail.com>
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
index 64d961458ac7..da0f8dfca8bf 100644
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

