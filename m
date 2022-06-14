Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA5D54B473
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jun 2022 17:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356390AbiFNPRm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jun 2022 11:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356622AbiFNPRi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jun 2022 11:17:38 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE2FB1FD;
        Tue, 14 Jun 2022 08:17:34 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gl15so17852974ejb.4;
        Tue, 14 Jun 2022 08:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hZ1It0Vji/uE1zL1NVsuKRSwGtzM25+5b2pW/UiacoM=;
        b=i8KDJKFWADV276MwZTB+vSolB+mqy0JCjcSVoGMWjrNvUMgFjYLJZozYf2ZuHc0m0P
         nJvhm6aA58Kd9S7ed4wOJWqcL/Hf8x90EDEJvcjsuNvABJiJ9pAH9SHqZChuXT8f34iU
         ByWGJa3Ah60jPSF5M/jLh+txjSN8yB8fSWUo563UNW3pNTkj8Q6xlq17M5n5cx5kWqr+
         nI2zXUKJUX8nylocNvEmWrONTx/f1ILhJx6sZrisAvgO0vxzqqObEtYLuMcMK1fXBvdf
         FiUEbQo7glZ2PrYfI1ZLYYfmOq3oPely2Sirs2WKpdQy+QncFlUPTQuYJ9ehdwSOOBjx
         HNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZ1It0Vji/uE1zL1NVsuKRSwGtzM25+5b2pW/UiacoM=;
        b=lHjI/dOQa4lowx6wV/VzehQLtnNUGhAs/OWjtChRHdt1r7n/8fmiWXjRrOffPwJeR1
         BNQJ6hQT8S5TFnXKVFO6eCBLcvdoTwymzdN1waUpSe6GWRFX2ByhY3+uOajl4aBHw+iO
         PshTPaUbHojeY+YmG3pZSAue/PUGtd/H2wEsSlGMay33nb+YmcbXBx49jBXB7OeXMY5e
         rr7QBjeWBgwOmhr81tdEUVx4P0Rc7bnNEPOwnX7u4dRYCRBj+WigWo8kNtrRbvcmBv90
         rF2I2beOc820hd8hpLbHsf6A2I2uNQURop9BRnbOV1eQE5koMzJYrPIGJrnrd/YWpWt3
         KHXQ==
X-Gm-Message-State: AJIora/+2Nz4G7Quldszuowo6+xjvU6nuTp2q3pTqTf81Wuo9RmRg5WT
        yF49bAkdqgj+54NxzeMA0Tz8USobi08mXQ==
X-Google-Smtp-Source: AGRyM1vXh266UHC3NnoZdb+TgfGbXSZEOsshPfjzAT9pyHGDK3xuydFO8pMjRPjdqKUPd+EuulyHMw==
X-Received: by 2002:a17:907:ea9:b0:710:9003:9b33 with SMTP id ho41-20020a1709070ea900b0071090039b33mr4623225ejc.175.1655219853178;
        Tue, 14 Jun 2022 08:17:33 -0700 (PDT)
Received: from localhost.localdomain (p5b3f7f9c.dip0.t-ipconnect.de. [91.63.127.156])
        by smtp.gmail.com with ESMTPSA id f1-20020a50d541000000b0042dd7e13391sm7198180edj.45.2022.06.14.08.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 08:17:31 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH 2/6] dt-bindings: mfd: Add mp2733 compatible
Date:   Tue, 14 Jun 2022 17:17:18 +0200
Message-Id: <20220614151722.2194936-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220614151722.2194936-1-sravanhome@gmail.com>
References: <20220614151722.2194936-1-sravanhome@gmail.com>
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

