Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1773758A78A
	for <lists+linux-iio@lfdr.de>; Fri,  5 Aug 2022 09:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240196AbiHEHzY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Aug 2022 03:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240391AbiHEHzN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Aug 2022 03:55:13 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8593174DEE
        for <linux-iio@vger.kernel.org>; Fri,  5 Aug 2022 00:55:09 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id v7so2243611ljj.4
        for <linux-iio@vger.kernel.org>; Fri, 05 Aug 2022 00:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fp5QsMZSik6FokJnE0Ar1IWeqs2yo1QrPVgBHPxM4Yg=;
        b=FWo0U9XpmnM/c3x5b05yMxNxNWw3LqzARt7sBEAGzgZMDf6xyBYCMNld6VBXAitefS
         u+QeoCCX2Aak5H7CfdOClGQ62oSWKYXvvAaSb2RkPsFTIyPluopN4CRsP6RvrXKPaDmj
         bQ5LaKtH1SV4fX+zFVYPRjRwCzKO78JJTj7NsiUN9S+niyPOMruQeISr/VKhF+buLMsy
         2uBaKYodk8MLo3B5ymvTZJYNjtuAOBdTEMLJOfGkeQzBpsLV3vObNMxzZ6cr3RAmOAyd
         gkkB6KA7LBb8yoBjWDTcuodXN1zNAj8Om5HEfjAjplSnHNUj9w+SUeIPllKfwpxvl1lw
         LF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fp5QsMZSik6FokJnE0Ar1IWeqs2yo1QrPVgBHPxM4Yg=;
        b=JxE/wZAssnkmaHRHaldv990m+a74fPwMf6EgkFsV658F5AL8c/fKl34OJLuVjJeXWU
         +UworJZk0/GOx0HZ0cBzwckIPxWpNfPmF6xUnUKVRzU1D77HsjyYSkHQbqopOL5qqIMu
         FZ/wC4kt9lIZI07ytApOHpKnyNx8Jrqhy2ZTfhI9CIB+YWaMr77BY17Tb/DyszCf3/i0
         3nRwP6h9CXpkD/cU7z0vfm4fg1HmzowPBdnqN5I6UDJTudbausCUx50IW0LHV73THT0S
         b1CgYvEvsz2iApPUOTcg4wtAlsjQ9798UsURhBPLdHzg/RQmlijEetJFfZoWIrJG53Z/
         Z5Vw==
X-Gm-Message-State: ACgBeo2Jje4I6WQ5UAq0QdSklX2q9ny/+67wXeO/2EcDCh+PPCXNQgDh
        EJodzge8RUS7zCJX2PPZeAWdjA==
X-Google-Smtp-Source: AA6agR5g8P6iwFH2TCVcFcTTf1165g9vkFTe2815uoS6iADkSdjrLz3zVOLOOsZFpj756akHhVpFng==
X-Received: by 2002:a2e:b010:0:b0:25e:65b3:b24d with SMTP id y16-20020a2eb010000000b0025e65b3b24dmr1803174ljk.292.1659686107839;
        Fri, 05 Aug 2022 00:55:07 -0700 (PDT)
Received: from krzk-bin.. ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id cf40-20020a056512282800b0048a8f119e7esm378566lfb.233.2022.08.05.00.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 00:55:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] dt-bindings: iio: gyroscope: bosch,bmg160: correct number of pins
Date:   Fri,  5 Aug 2022 09:55:03 +0200
Message-Id: <20220805075503.16983-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

BMG160 has two interrupt pins to which interrupts can be freely mapped.
Correct the schema to express such case and fix warnings like:

  qcom/msm8916-alcatel-idol347.dtb: gyroscope@68: interrupts: [[97, 1], [98, 1]] is too long

However the basic issue still persists - the interrupts should come in a
defined order.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Accept also INT2 as one interrupt (Jonathan).
---
 .../devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
index b6bbc312a7cf..1414ba9977c1 100644
--- a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
+++ b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
@@ -24,8 +24,10 @@ properties:
 
   interrupts:
     minItems: 1
+    maxItems: 2
     description:
       Should be configured with type IRQ_TYPE_EDGE_RISING.
+      If two interrupts are provided, expected order is INT1 and INT2.
 
 required:
   - compatible
-- 
2.34.1

