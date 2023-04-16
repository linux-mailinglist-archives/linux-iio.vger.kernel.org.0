Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30C56E37FD
	for <lists+linux-iio@lfdr.de>; Sun, 16 Apr 2023 14:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjDPMbs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Apr 2023 08:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjDPMbr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Apr 2023 08:31:47 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B57E2D72
        for <linux-iio@vger.kernel.org>; Sun, 16 Apr 2023 05:31:46 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-94e6caa223cso255801966b.3
        for <linux-iio@vger.kernel.org>; Sun, 16 Apr 2023 05:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681648304; x=1684240304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iYjMTz0lC2QfPX12S8GW0HkDAV4l3XKgRbDxNQnkDxI=;
        b=Qs9PCGp8ZxcUyfvlwkoNXtnQpGJlobg/b1wBMQab48ehsJR2ZL9YxZSR0uB9e6OqPL
         tc2B+Mfsc+0nnbniNC/rc7OYIuo1b8mUjQjIx3LAlkQrqJIwOI2aItXsHQo4SlciYqeX
         yzl24uzJSpuGEZSkrFRP9KfawH6XtXK4Z20DZBiW3cuGBItxMh3n1ABcJ/vgQKRn4H8z
         iVEzj+Db1Ch0vJgG3ib99hEwrwDcT9BpnEDSxEIMmK/+bQR8jSIiEiSUW8Oq+z3+Yenv
         q6KmX3L9OkWuedYHkPBhvqhAhEntrDSAIyd9h9up3QbSX2+3M5hxCfWwcY/o/H5nLT+j
         e6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681648304; x=1684240304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYjMTz0lC2QfPX12S8GW0HkDAV4l3XKgRbDxNQnkDxI=;
        b=ZnPQxRMgNP6Zc5pAaPWQ4QUGXr+obHTeF/DqnqzSafPx3hLAryxGrKYu0IwmTD3N/H
         r0d7bXiewgGaipfCINXYCFdZB+kgBMZP5WLtRoySbrG5amSXHkAZdp4fpd2Bszwva7yG
         j2VuGW8NblbrBFX52F8jaWYZu7scnLKxC98eT6VtyUJawDLMR4gUIuCL/i0COIIDGHyv
         TCrzOZnLLMj+7tb6EBrLnM52axcn1d8450XrxUVNnR2bCshGWcerYRJVvBaSsKdhA9v5
         6i5gJjNRA/0I9x0H5b5LVOZBgUL1w30/rmhGKGtmsjGDTtXR33An8fUgWBj0JoyRRHhy
         bUqA==
X-Gm-Message-State: AAQBX9e+eZIXqFwFBp7Io8sSvtFT3mqk9JMvAizSSBr+yp4CxKyOzHj5
        prxhJx3DCPidZlkB2Yyvm0+G8w==
X-Google-Smtp-Source: AKy350Zoc7DPifrKeFuu7B88mUHGZsp9viVO2J1XYR0wdN55B2bQQ3mTOpOP6c0/HyBNXTFhwVS3Tg==
X-Received: by 2002:aa7:da8f:0:b0:504:7fdc:2682 with SMTP id q15-20020aa7da8f000000b005047fdc2682mr9985914eds.35.1681648304498;
        Sun, 16 Apr 2023 05:31:44 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id u17-20020aa7db91000000b005068eefc59dsm2173536edt.42.2023.04.16.05.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 05:31:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: iio: adc: qcom,spmi-vadc: add 16 ratio of pre-scaling
Date:   Sun, 16 Apr 2023 14:31:42 +0200
Message-Id: <20230416123142.299533-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document value of 16 for pre-scaling, already used in DTS and supported
by the Linux driver since long time:

  sm7225-fairphone-fp4.dtb: adc@3100: channel@8:qcom,pre-scaling: 'oneOf' conditional failed, one must be fixed:
    10 was expected
    16 is not one of [1, 3, 4, 6, 20, 8, 10]
    81 was expected

Fixes: e13d757279bb ("iio: adc: Add QCOM SPMI PMIC5 ADC driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index f30114424b92..42077ca65747 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -101,7 +101,7 @@ patternProperties:
         oneOf:
           - items:
               - const: 1
-              - enum: [ 1, 3, 4, 6, 20, 8, 10 ]
+              - enum: [ 1, 3, 4, 6, 8, 10, 16, 20 ]
           - items:
               - const: 10
               - const: 81
-- 
2.34.1

