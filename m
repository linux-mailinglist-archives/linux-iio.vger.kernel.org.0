Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB88560C4A
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jun 2022 00:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiF2W3t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jun 2022 18:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiF2W3s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jun 2022 18:29:48 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA9211445;
        Wed, 29 Jun 2022 15:29:48 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id d3so926020ioi.9;
        Wed, 29 Jun 2022 15:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wX0odF7wthixWZk8JyeUhLRGFHhQJVbnFoKyCcuBnOA=;
        b=RbGa9a5kRYa8NliKqHBm8bd8VaBfAQe38vjltzGe4dF3ufbZPRpEHiy1VhAcKeueRt
         K+B5n1gh7zLr842aKeS+RtMv6Hhok0pX+9JKTqaotMWlSFUgbBRJ/YOiBa1KqYIaqiO8
         lXCeDavRo/CZzDzlHEcWGVODM+V1Zha1e00ivzIZ4Qs4hjTRAaEibBi2mmWjtWaOWbFA
         PCsVg6iQSSXPcy1hP9BPgQAZaDCMrA5qKUG7HAUHUSiU46yWSFLKq3UsKbPwnYJSeSJp
         cxE1xGIVIxpNftqa8uoRWxeMNUWzIby1RjvWBzZz/9ZQJmt4kqcSLCgEv4urT6ujOPy8
         mEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wX0odF7wthixWZk8JyeUhLRGFHhQJVbnFoKyCcuBnOA=;
        b=HaVnHGZphpK0M37zIYaXZ+Kgh3l9WzQ0gLgdPr3geVlyvk+mlGNzFjijqH0jYaVNhB
         +k8BiMpFq7OijZXKCiv0U+GT1S5rFcHcYQkHfB7oOoWW620nUs8AT7TVxcqd0vO4TFEW
         xVIHrXBAL6El1EFqvQZFBWbWAbAd9Xm9AYWokjNY0hc5mEm7K0FCTVWwpQrYVKpR3JED
         Cp527/9HaE2X1fmywsNgHAkOunRvnnfRTQ2GiB+H3XrsLlLjQsaqZ+WdDnmCopBnoWJa
         MriN7dcJNwgZYU3cNzyRWnU9VxgzHddyR+BMr9B5cR4zJByOT2o+pYkMjy8gyQDBWLMB
         GTNw==
X-Gm-Message-State: AJIora/wG2YlmVG/8ddxP21DkAHUFMwCCIaiKEYq2Xvp3ZmciOQm4SRa
        Xlov6BSMfGQuXNu6laVVwtUmQpqGMPo=
X-Google-Smtp-Source: AGRyM1tgIDgtzB7HsYoFjw1ihODd9IB82ev6OqJ465C0TcFx1ulqBMy6ZF4yFHBe+aUDMfVkFxpvcQ==
X-Received: by 2002:a5d:8053:0:b0:675:56b8:8355 with SMTP id b19-20020a5d8053000000b0067556b88355mr2696032ior.83.1656541787428;
        Wed, 29 Jun 2022 15:29:47 -0700 (PDT)
Received: from Dixie.. ([2604:2d80:a188:fd00:2d4b:b7b2:944:3519])
        by smtp.gmail.com with ESMTPSA id ca19-20020a0566381c1300b0033158c4a312sm7845597jab.55.2022.06.29.15.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 15:29:47 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     devicetree@vger.kernel.org, contact@artur-rojek.eu,
        maccraft123mc@gmail.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, paul@crapouillou.net, jic23@kernel.org,
        linux-iio@vger.kernel.org, Chris Morgan <macroalpha82@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v6 1/3] dt-bindings: adc-joystick: add poll-interval-ms
Date:   Wed, 29 Jun 2022 17:29:28 -0500
Message-Id: <20220629222931.30599-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220629222931.30599-1-macroalpha82@gmail.com>
References: <20220629222931.30599-1-macroalpha82@gmail.com>
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
 Documentation/devicetree/bindings/input/adc-joystick.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/adc-joystick.yaml b/Documentation/devicetree/bindings/input/adc-joystick.yaml
index 2ee04e03bc22..9a34b928b15b 100644
--- a/Documentation/devicetree/bindings/input/adc-joystick.yaml
+++ b/Documentation/devicetree/bindings/input/adc-joystick.yaml
@@ -18,6 +18,11 @@ properties:
   compatible:
     const: adc-joystick
 
+  poll-interval-ms:
+    description:
+      Poll interval time in milliseconds. If not specified, device will use
+      iio buffer.
+
   io-channels:
     minItems: 1
     maxItems: 1024
-- 
2.34.1

