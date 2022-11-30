Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FEF63DD5A
	for <lists+linux-iio@lfdr.de>; Wed, 30 Nov 2022 19:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiK3S0l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Nov 2022 13:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiK3S0j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Nov 2022 13:26:39 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0C31AF21;
        Wed, 30 Nov 2022 10:26:38 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1432a5f6468so22017549fac.12;
        Wed, 30 Nov 2022 10:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SWx0R0ogEqD2NvSzMhQm7EDv0VkYaoaO8e5x2Y51N/Y=;
        b=Q7363XeANv4JltXcUpQKqXZkb7TKRhyadCkPlMQda1dioPKCQte9UDP1vVoZx/HLcO
         27FnjGis4UqoHE32rmo2X9JD4ZutUS6PExxuL64I7jhRXylD3Gpla/7K+kCsB+29lfCM
         4hfInWFNduB/s0bY96Fmhzbfo8yj2ctzO3L1yfLj8YA/NN0Z9plivJk3Okmn1bfg26Zg
         7FMaD1iCiUIoaAHmbS/Q1vss/JxtaIcs8lHa977Bx/+IhG6//UAgFd73M/nsP00ejj89
         nI/QbpS3XA7UBMAHgPFBqoEk02iDXeeX5jqfGBW8RmZypMoG+vZrOQsDw+djSiHlxjl6
         OqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SWx0R0ogEqD2NvSzMhQm7EDv0VkYaoaO8e5x2Y51N/Y=;
        b=JzSRFrZJPsK2ZcExInkMJWtFr2irwtQ7CO6+iqOqs/MH/xjXRAWMPQzLxzTm1jKm/8
         /2CwD/OmrQJ1MX3sEo95qTb3Yi3Pgdg+MWGO5WWRts4/J34Uxcx3tysPUXeNCtPfH0xb
         n8VOS8jcfImQebsnVxEFWvJ9c+J+4mEWIrQuiRA8bkJrC2+mTG+T5lBvFID1LmnzvscM
         8EbLqotMHfycupaIJ7ns/wYgyenvy+K3s+kD4DeGwArscnmGbXA6PmszFh4qkjcnb10p
         93/KKc0zBTMTRQFgdhIOjYDfzXEjXXocrVX/NAzhI+S/qlWAuRB81P6Q/fzFoCAa5T61
         OgBQ==
X-Gm-Message-State: ANoB5plwgqWQQzl3U3tGKgbZD5ZOMkUkQtdjhy/xJ8fMZxTbe+ib2gAE
        6EdQ5OVsywS0n8JdYLGAU7FFK65uv/I=
X-Google-Smtp-Source: AA0mqf6bt9cRY4yr7kZk+kFGWJ9U55vPUoCPrdVOD3GrugU2ZQlCnrAlMEBZjfLAvzMYZ4X3f7TiRw==
X-Received: by 2002:a05:6870:c352:b0:13b:66b0:3ef3 with SMTP id e18-20020a056870c35200b0013b66b03ef3mr26501510oak.210.1669832797652;
        Wed, 30 Nov 2022 10:26:37 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:485:4b69:e48f:7d21:8a92:6dc])
        by smtp.gmail.com with ESMTPSA id m24-20020a0568301e7800b006690f65a830sm1209972otr.14.2022.11.30.10.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 10:26:37 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] dt-bindings: iio: dac: ad5686: Add an entry for AD5337
Date:   Wed, 30 Nov 2022 15:26:31 -0300
Message-Id: <20221130182632.3856675-1-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

AD5337 belongs to the same family as the AD5338.

The difference is that the AD5337 has 8-bit resolution instead of 10-bit.

Add a compatible entry for AD5337.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
index 13f214234b8e..b4400c52bec3 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
@@ -33,6 +33,7 @@ properties:
       - description: I2C devices
         enum:
           - adi,ad5311r
+          - adi,ad5337r
           - adi,ad5338r
           - adi,ad5671r
           - adi,ad5675r
-- 
2.25.1

