Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0B654BABA
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jun 2022 21:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243571AbiFNTmf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jun 2022 15:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239084AbiFNTme (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jun 2022 15:42:34 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1162C1AF11;
        Tue, 14 Jun 2022 12:42:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id m20so19112942ejj.10;
        Tue, 14 Jun 2022 12:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hZ1It0Vji/uE1zL1NVsuKRSwGtzM25+5b2pW/UiacoM=;
        b=bG2s7f9s4KR5wI0lk+iLuurCztbJKiT/HvGkbacOb38P0PQQdKOnIo3PAn8W3Yt/3I
         Sx9VnUrA+xqOorczn34EbUQ6GV4b6ET1kNFhoyRUTBxQHbEt5Go/5OmnQAGD5h09eStw
         BcsKraHMBEv7ya/xq8HsnERloZytbq3s9e8lDDypOUlUEQIh5qFC0Gtp8ZHtxFmaMF0a
         xlQ0OiKTakNfNbXjPUHdn1+qV0S6bYfy39IsOpMGpyd4hoR9wMpRbR3PoiVUWQ+JiwW0
         QJkyP05/eloF+vMOWOM2B9ehj9L/NpaTtLMvnTRO5mXBvbBOlGyfkzekSdJ5ukuSmmMI
         /Ukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZ1It0Vji/uE1zL1NVsuKRSwGtzM25+5b2pW/UiacoM=;
        b=DNK6IUk0Kf5sdmSpvhCmHTKocHJk5C1+siVKTqfmPbNc0q1fXbLJj9/P0x5qRmPIWD
         FGORfhdypx7sko88s0QYj8jd0C5e/OkB+VX/QU7MLm7bxXbr+QX3hknifRj5tnKtANZC
         VnA4R9y0tK16q2E2d/aWIU1Ka3uQUAcSmZgwfxaaPdxhOoBdAWo6DHyzf+YEQBxhSeGe
         qUJCtg6c1H7F3XaZ2nTKdwnrIAdGbkzUamQDarm6q1BduX41NlAcNI20jn1o2rdsFlFc
         hQ8GK89lUN8dQEHFs86EtG+sL+Yg/vUZY58FITsumyALlUfEXNiU151YVvrkgLSnk9Xi
         TZtg==
X-Gm-Message-State: AOAM531bj750O0sKgwzyhHRYv+VO49hGkSXPKaTl6OtGQEY5ihKLbuvj
        tqNFWjU4JflzDt0gRdclgG4=
X-Google-Smtp-Source: ABdhPJwGLThmOY/gqw8ITxsfPAEBmH65HGNKJE2v/7+lMQIbf6utq9eUYuJEwi9ainPLwysM/wptog==
X-Received: by 2002:a17:906:3e8e:b0:70f:9a81:8218 with SMTP id a14-20020a1709063e8e00b0070f9a818218mr5689405ejj.525.1655235752571;
        Tue, 14 Jun 2022 12:42:32 -0700 (PDT)
Received: from localhost.localdomain (p5b3f7f9c.dip0.t-ipconnect.de. [91.63.127.156])
        by smtp.gmail.com with ESMTPSA id vw5-20020a170907058500b00712057b037fsm5306699ejb.167.2022.06.14.12.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:42:31 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v2 2/6] dt-bindings: mfd: Add mp2733 compatible
Date:   Tue, 14 Jun 2022 21:42:21 +0200
Message-Id: <20220614194225.2226447-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220614194225.2226447-1-sravanhome@gmail.com>
References: <20220614194225.2226447-1-sravanhome@gmail.com>
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
 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
index f91acc42d652..fe13869e2c58 100644
--- a/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
+++ b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
@@ -19,6 +19,7 @@ description: |
 properties:
   compatible:
     const: mps,mp2629
+    const: mps,mp2733
 
   reg:
     maxItems: 1
-- 
2.25.1

