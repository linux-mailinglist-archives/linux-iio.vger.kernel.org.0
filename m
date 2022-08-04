Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3770358A0BC
	for <lists+linux-iio@lfdr.de>; Thu,  4 Aug 2022 20:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbiHDSq7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Aug 2022 14:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237266AbiHDSq4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Aug 2022 14:46:56 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2746D55F;
        Thu,  4 Aug 2022 11:46:53 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id s204so375377oif.5;
        Thu, 04 Aug 2022 11:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FmXpKV8L1ROy4Dh0Qt2TT7rzbx5rKU4HTkrXEsPEgGo=;
        b=gu0lwnTLaZR0SB/xx8VrbkOfRzdVruFSaSEgi9k6XPiTtEfHlhV9rpMR3WLGlEq1pt
         I0eMeP0keV+n0OJ71fg7C4j9bYzywWTpH9pyRJTxHYxGIvTVGIXj4T80XE/aegW1b8c9
         Xpd8uS4qRMHwP0KCxjxqbLb+QVGn/P0GN0MAHsb/7KjQuCRm1Qy3vRegsmGMPd8jQqHT
         /s2Tno6iZ/c0d9Eulk5dcF/EW3g2lszOaFAmtSOiG1MP9SKNhdpg70dl7zaGJzNdKuOM
         nNg/H2lu5fYxx6uJPzuobk6HvQUBD5dRSHVz1sTBjkUUTFMgC9Ef61IbuCp9BMS3Mcxc
         jfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FmXpKV8L1ROy4Dh0Qt2TT7rzbx5rKU4HTkrXEsPEgGo=;
        b=L5qHBQfYG7TPoUCKA/rxzjVVVXtCpoTrAjR7+aM0ZZfdawHFJZNFDZ4uEYexc4SdVB
         1vKyg3BWvsu7oZ4Nr9ygyJYKTUD4VI7kCpu1H//wRC6yg1HbSaiMJSQwNqRhfQrHrBWB
         VZPDKvnNHOzVONWNfd49f+ksEBJhTH6qdzTjljz0lf7LsGCE2WJH/EiocqGvO0PkYN1z
         KPudpgXyfgakz87+LzuekTk76b11S0IWtmCDLXuKaxQ7lGBQzG0Ro7fi5iUrchrZdaco
         E6CCE1+rURRikYwjITFfAkgwHNXTxAtFZOnBFAYj6BVudC2R7ku6qlXOi0a9D+f8tMGU
         DGcQ==
X-Gm-Message-State: ACgBeo3QpI7d6FQl91Sy28v0IZbTIFu01zXU9dY88m9ceJbs9BnydOQu
        G3NHc6xpCEfjQyHO40e3JoTNCL6Grv4=
X-Google-Smtp-Source: AA6agR4omTSKKaM3a/8G45yQ2MgleXqYT+VPZwIyu5qymdesExa2dXUnAkRJRa9FY8b791mIDJaYEg==
X-Received: by 2002:a05:6808:21a3:b0:33e:b0ea:7ce3 with SMTP id be35-20020a05680821a300b0033eb0ea7ce3mr4782116oib.46.1659638812428;
        Thu, 04 Aug 2022 11:46:52 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id p17-20020a9d76d1000000b00636a8dafdc9sm87945otl.2.2022.08.04.11.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 11:46:52 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, dmitry.torokhov@gmail.com,
        contact@artur-rojek.eu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        jic23@kernel.org, paul@crapouillou.net,
        Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v11 1/3] dt-bindings: adc-joystick: add poll-interval
Date:   Thu,  4 Aug 2022 13:46:42 -0500
Message-Id: <20220804184644.20710-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804184644.20710-1-macroalpha82@gmail.com>
References: <20220804184644.20710-1-macroalpha82@gmail.com>
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

