Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B271855C845
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 14:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242454AbiF0WO5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jun 2022 18:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240350AbiF0WOz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2022 18:14:55 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5382F60D5;
        Mon, 27 Jun 2022 15:14:54 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id p9so6688772ilj.7;
        Mon, 27 Jun 2022 15:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rBgmnHakaC+tpXhBVx7eO+LRh++iUPlaOFAggEamlRg=;
        b=M8XdxHVD2b2zy6crs/lhc41/ZS0LXfDXGN/HNyFyLESA+CyF+A/eKkD2JmefLOtMDq
         35HdpBauksTDdtSgdqJUGtgXcXLvs3xEGhcMwNrK7AZ/zVgIYsGb78jP0zdjS9/1+JB2
         v8moMM1RRKS8TOmoSqCz4sjbAfRZqJTfdxFYEbPy7dF7rw98SaNDbLC9It3wdv2n3oqo
         yc9/w8Jq15J1iE32r4SO9H9KHi/Mv1fBxxC52WxSY6jBAlVx98qyoy2FV5s0Uc0ZQZnf
         vODMFdF2D8Jfz94y2+tt70XNxVK5R8mI4V5B7aWYlUMBd/usIVzHNZZRybFNHMpQXyVt
         KEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rBgmnHakaC+tpXhBVx7eO+LRh++iUPlaOFAggEamlRg=;
        b=G6I8Oqlbz1AZmCinQVLAZSRBd6F8OMBZxeaUjHwm+WiwLFMm03qAAyglI/XbOIJEsm
         p0rmE+tcbfbp1pF0POM2GxSuif5V0LijZMG8IE1utRt7MUQGISWDn/F2YJ1ZHy1J3KvR
         7ldCVWG3burvHiZ0NVMyWP0tPZ7QZTme54Vh0cWsjJlcM+r29bhyGq4JPuB4ec54tH5i
         V/IFvOPg1Kk9uo43Ow51g1zNSgv+qyE/jchTsWU5nEDXJql2Wd1vjEDFStavq7NO2Hg/
         JavOFz+e1LH7W4B2GOL0PnZPO8bMbdqhJwJ9duXwQFVLaYMbt6TumaYx04ejl3yuxb1r
         Ievw==
X-Gm-Message-State: AJIora/5kD0NOFhUbqocLP/CS+YNjROQBaTJN4HzqTFJD6jTtTKNvBHW
        UHVFDQspAgBJRF0cJTJOocqxJazOcws=
X-Google-Smtp-Source: AGRyM1sI2TgRbi1D6kytBkGgr0M7MEaREQ4mPQPD/8I8jnLlaZtcL39f3cseQavtqPA52asF86cKdw==
X-Received: by 2002:a05:6e02:1b0d:b0:2da:8332:6aa2 with SMTP id i13-20020a056e021b0d00b002da83326aa2mr6241995ilv.83.1656368093516;
        Mon, 27 Jun 2022 15:14:53 -0700 (PDT)
Received: from Dixie.. ([2604:2d80:a188:fd00:7a85:cf35:f4b3:542f])
        by smtp.gmail.com with ESMTPSA id p7-20020a02b007000000b00339dd3976absm5255589jah.110.2022.06.27.15.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 15:14:53 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     devicetree@vger.kernel.org, contact@artur-rojek.eu,
        maccraft123mc@gmail.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, paul@crapouillou.net, jic23@kernel.org,
        linux-iio@vger.kernel.org, Chris Morgan <macroalpha82@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v4 1/3] dt-bindings: adc-joystick: add poll-interval
Date:   Mon, 27 Jun 2022 17:14:42 -0500
Message-Id: <20220627221444.3638-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220627221444.3638-1-macroalpha82@gmail.com>
References: <20220627221444.3638-1-macroalpha82@gmail.com>
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

Add poll-interval support for the adc-joystick documentation. This is
an optional value and if not provided the adc-joystick works as it
does today (with triggered buffers). If this value is provided, the
adc-joystick driver is polled at the specified interval.

Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 Documentation/devicetree/bindings/input/adc-joystick.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/adc-joystick.yaml b/Documentation/devicetree/bindings/input/adc-joystick.yaml
index 2ee04e03bc22..2d755091e46d 100644
--- a/Documentation/devicetree/bindings/input/adc-joystick.yaml
+++ b/Documentation/devicetree/bindings/input/adc-joystick.yaml
@@ -18,6 +18,12 @@ properties:
   compatible:
     const: adc-joystick
 
+  poll-interval:
+    description:
+      Poll interval time in milliseconds. If not specified, device will use
+      triggered buffer.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
   io-channels:
     minItems: 1
     maxItems: 1024
-- 
2.34.1

