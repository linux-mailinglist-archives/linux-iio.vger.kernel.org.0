Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EC560FA75
	for <lists+linux-iio@lfdr.de>; Thu, 27 Oct 2022 16:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbiJ0Oeg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Oct 2022 10:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbiJ0Oee (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Oct 2022 10:34:34 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C95C60EA
        for <linux-iio@vger.kernel.org>; Thu, 27 Oct 2022 07:34:30 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id x13so1436234qvn.6
        for <linux-iio@vger.kernel.org>; Thu, 27 Oct 2022 07:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Elgx/yfm289sAtkCYegANchVqYKxAF2vr4d85UGafk=;
        b=qe2yzrEfB6gYDu97LZwQjj8l1w5YksJdkQuZJRNijntprQa6U6HSXv5tsDs7aCuFPo
         cmpqdfBvFiLWtJp/lBumeuvsP3Y8aRChyg5VnnZTA2R0FGCrBtseoY+x0WUTibasrIJC
         WHdWALtH0uPoTT9k70bzSaO50tkgUYWYQarzkzLvfFMnn6qVRfxQ3aqWoC3Of7KHCebc
         ZoqyOPXscRD+LiXlVBXvF1s2Xeipvv6lwopSUoqH3eld9CVDmZubKY1ZMtI73RoRf0yD
         iGv0QlCXLdXvmWSPBcsJ0WBDhnMCFUBru1/sPzd0oTdORVRMwSqR23HONbnHMsR/eVpY
         WoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Elgx/yfm289sAtkCYegANchVqYKxAF2vr4d85UGafk=;
        b=bVKmrHAw2VhLj9yIQhqqeqxGeCANJ6mkcGPk6i7ugMy0fsugFCo6X38JT2r73JZ2zz
         deRf6D/WC8WP+7oFnuqT6lfMpDrqeZUS1UfpRGLEV8NhR0VPplNEchfeGWGYs/fm5bKU
         ZtMDJ0sDh/Qgn8icncaKddMwyUlNAQ7AYkMRtmRkA4mJ61+KezIDei0Dv1mgUFHdodDg
         79BJLgBajYDIhZVN5eFa1s36pjtSwygai7YGe5olgjPaPTHhW5A2skdnE3RLQiSgwhn1
         190lls8i+XwjPHfkd7Vb4MiWHakFqEIhbMTRoBTuyLUnjkaw121/kqfxRoACYYHDCry4
         P6Ww==
X-Gm-Message-State: ACrzQf0SwPU4mib207Hv/PuB5pkfZKdQSOa+hq234IaJ2N9ZjNCGxrud
        1N2tfnoaFdDOyl9+6JJ0KLsaibjQEKapGA==
X-Google-Smtp-Source: AMsMyM46cXvgjnQPpBH112h9LLu7kzNk/O4CQ0zeyEfk4ob+MF+ZhGEsvn9O6xNqUxB/arblHia0CA==
X-Received: by 2002:ad4:4ea7:0:b0:4b9:365b:2a86 with SMTP id ed7-20020ad44ea7000000b004b9365b2a86mr31544620qvb.58.1666881269483;
        Thu, 27 Oct 2022 07:34:29 -0700 (PDT)
Received: from krzk-bin.. ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id w10-20020a05620a444a00b006f9e103260dsm1076749qkp.91.2022.10.27.07.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 07:34:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: iio: adc: qcom,spmi-vadc: simplify compatible enum
Date:   Thu, 27 Oct 2022 10:34:10 -0400
Message-Id: <20221027143411.277980-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The second compatible item in oneOf is just an enum, not a list.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml  | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index 8bac0c4120dd..a848df37db06 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -22,13 +22,11 @@ properties:
       - items:
           - const: qcom,pms405-adc
           - const: qcom,spmi-adc-rev2
-
-      - items:
-          - enum:
-              - qcom,spmi-vadc
-              - qcom,spmi-adc5
-              - qcom,spmi-adc-rev2
-              - qcom,spmi-adc7
+      - enum:
+          - qcom,spmi-vadc
+          - qcom,spmi-adc5
+          - qcom,spmi-adc-rev2
+          - qcom,spmi-adc7
 
   reg:
     description: VADC base address in the SPMI PMIC register map
-- 
2.34.1

