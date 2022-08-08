Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B8E58C81D
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 14:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbiHHMGJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 08:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242542AbiHHMGH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 08:06:07 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F3F5F64
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 05:05:55 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id ay36-20020a05600c1e2400b003a4e30d7995so7308908wmb.5
        for <linux-iio@vger.kernel.org>; Mon, 08 Aug 2022 05:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yv7/Ul3NtrsgwZNY2tz3vPTVziFu5q3/IA4UlHUJklg=;
        b=dpXdQWxuBRSCqpfom0NwcrxvY0fURdxtGYuWn0dDyqb/eueUQAGz0+a/jmpILk8Wv6
         p5CLIGaNGPaXx4US9/Mrp/sQqq4xH9Gqylc0FxO9NmSbnjqerwbPHgs7f3bEFsUgaEYP
         cS9ZoFeyH+YfGRj6QZMRLNw2aauv/Txu7WxfgVCoLwywZxGLx2M5FJE0x8CGLqHfdmdJ
         swNWUuceoBsNCj+p6ukU/si7CcmL0QQGAclsWuvYTk+sK0USnxN+nYcZ9CdFC6chGAu2
         nsDiy0hSalEN84gtIAMNmHny/CQaStNZVqXP+7nFksTR3/E7oI/R59EabeEhddYo+tde
         IW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yv7/Ul3NtrsgwZNY2tz3vPTVziFu5q3/IA4UlHUJklg=;
        b=Axth/j6laMymeul0ct/PuDuCBCG2x1WQt2WaF4gQFvd7BLYL76cYfZX9D2DJVzFUOf
         EvN9t0Ajm/Jog+4QiMNEcjF53Yc+6nj5Ml38D64kdnvDDEUu+0JzRiQzsBl9FB8Rbb4Z
         MoQ6pMrso4vNCzMv+9G7NsoptcQPewR1J411icLN7YMveUtJ/50Gjw/lC1zLhhAFOSAZ
         REDWIqejS0WMRG/ZyRZ7NNmDocl67HUe/CpPT9asfRAzxzV0Ugv5Xh/FTJmO+Ksn8YUx
         /E9ilutHb14plhB2Ij1Pyx1ckHOrQJomHJOcMOtoIr4/na6KzfHaQtQ3QE9iJMsd5/yj
         rtwg==
X-Gm-Message-State: ACgBeo3xN9nlMYjPB7fQapTJgarKX0QTxhTSiLAyv0PwZyTwXU5yTaHy
        /K/guF8aOZLh7ihAFcmagIDsnw==
X-Google-Smtp-Source: AA6agR5McIiXqc3Z1dpu34Hdqbz9S9Td7lasSrfwR0gSLIBEoMFiIuqtX0Fk/2RcmdewAPxkE2rXHg==
X-Received: by 2002:a05:600c:5123:b0:3a3:2543:be80 with SMTP id o35-20020a05600c512300b003a32543be80mr17215693wms.155.1659960353944;
        Mon, 08 Aug 2022 05:05:53 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xh0y3vuv1059rd6h4r.18120a2.ip6.access.telenet.be. [2a02:1810:a44c:8f00:cd22:c517:e143:e53b])
        by smtp.gmail.com with ESMTPSA id n66-20020a1ca445000000b003a513ee7830sm15884560wme.27.2022.08.08.05.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 05:05:53 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Crt Mori <cmo@melexis.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/2] dt-bindings: iio: mlx90632 Add supply regulator documentation
Date:   Mon,  8 Aug 2022 14:05:49 +0200
Message-Id: <20220808120549.1543338-1-cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document the newly added vdd supply option.

Signed-off-by: Crt Mori <cmo@melexis.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/iio/temperature/melexis,mlx90632.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml
index b547ddcd544a..4a55e7f25ae7 100644
--- a/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml
@@ -35,6 +35,9 @@ properties:
     maxItems: 1
     description: Default is 0x3a, but can be reprogrammed.
 
+  vdd-supply:
+    description: provide VDD power to the sensor.
+
 required:
   - compatible
   - reg
@@ -50,6 +53,7 @@ examples:
         temp-sensor@3a {
             compatible = "melexis,mlx90632";
             reg = <0x3a>;
+            vdd-supply = <&ldo4_reg>;
         };
     };
 ...
-- 
2.34.1

