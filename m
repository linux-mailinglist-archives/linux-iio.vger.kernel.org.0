Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF1C54CBDD
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jun 2022 16:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344363AbiFOOyN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jun 2022 10:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245706AbiFOOyG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jun 2022 10:54:06 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D595275D3;
        Wed, 15 Jun 2022 07:54:06 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z7so16509457edm.13;
        Wed, 15 Jun 2022 07:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KoSeXLhcP+pQzpYRIDKz9CUHwdCRufZ+841Vxxkba/M=;
        b=GzDZj1fjWq0OLuENvSgtzsTaifLuvkSqjzIB9ZBcWYGWbho0DmgNmf0VACWSe8+BgT
         D3TM/izkgeHIqlCJZzQceWtd85S8lb5fNWLU0DwdvOQDh25gMgRVBUGcXfD1j1wBN9S7
         /rHD5J3LD9U8k99yZG1Ppfd1aedMplFwVidupRXLZRG1bkLvt9NrCUhSBQyPIht2Jo5A
         fLW7X2KXXBhPH0ABQypKgnU19/PKsT3JZcY36gCUMvjFxbfwF8wMH79qxT2F5dgGCj5f
         ATv+SwX9s4vE3qh37JvwW01uxU2AfPwPpkKJ2okl5kmu7tFGm/9UYbqDXRc4ZLO1By7m
         fd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KoSeXLhcP+pQzpYRIDKz9CUHwdCRufZ+841Vxxkba/M=;
        b=wvuASUifGk1NGh4y/8OcC8mDyo/iarjyhjxHqrCqyIoF0Rs6W4kalH11wBWWtWeiBf
         JXT6kn80IN0tpPPmlaxBqxwIVv2Wz2sWRVw49y4g+MzmvPU1WSwoGnrgvzRFEHinm3jp
         Oy8aqPEJKxoUCyCPGhpDhXrowEUnmxzh0biWTdHotYKhNVqB+hhnkrjJzUEdTp9bEan5
         zHLxSTSe35g/QvwU/eEPBUSpNEcfr/a9GpMLp/B0cUktUx6/W2+iFNdeKnqxytumsaRT
         Bk5ctcvsqAoIZ3DouSa07AQ0Ki2lASvy4+dcfRxlQdEeBw8L5p4eI4wkg2PLV25/dv9r
         /GWQ==
X-Gm-Message-State: AJIora98KgVtf2NJFUordP4oilYbBd+Aeq9EH6kasKfwrhuFPSF2bDms
        CEFxHKH1483EUXj1tTYJa6I=
X-Google-Smtp-Source: AGRyM1va6jB6n4XAuuoyy8sIIpV6rsqYUswhXfj7EMAscfhmV0+WxPk7jMWdXJcynUhRbRgi1882Tg==
X-Received: by 2002:aa7:c744:0:b0:42d:f68f:13de with SMTP id c4-20020aa7c744000000b0042df68f13demr149823eds.294.1655304844546;
        Wed, 15 Jun 2022 07:54:04 -0700 (PDT)
Received: from localhost.localdomain (p5dcfe5fe.dip0.t-ipconnect.de. [93.207.229.254])
        by smtp.gmail.com with ESMTPSA id y2-20020a1709063a8200b00706287ba061sm6341665ejd.180.2022.06.15.07.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 07:54:03 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v3 2/6] dt-bindings: mfd: Add mp2733 compatible
Date:   Wed, 15 Jun 2022 16:53:53 +0200
Message-Id: <20220615145357.2370044-3-sravanhome@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615145357.2370044-1-sravanhome@gmail.com>
References: <20220615145357.2370044-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add new compatible for mp2733 mfd driver.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
index f91acc42d652..5ba849d78d8a 100644
--- a/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
+++ b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
@@ -18,7 +18,9 @@ description: |
 
 properties:
   compatible:
-    const: mps,mp2629
+    enum:
+      - mps,mp2629
+      - mps,mp2733
 
   reg:
     maxItems: 1
-- 
2.25.1

