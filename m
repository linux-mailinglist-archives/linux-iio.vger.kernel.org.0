Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB16E595C68
	for <lists+linux-iio@lfdr.de>; Tue, 16 Aug 2022 14:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbiHPMyZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Aug 2022 08:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbiHPMyN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2022 08:54:13 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FA36BD4F
        for <linux-iio@vger.kernel.org>; Tue, 16 Aug 2022 05:54:07 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id o2so14815316lfb.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Aug 2022 05:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=mholAPGkgLZz7hdw+yCXk7yFg3xwhXBLA4zX2Xmro8A=;
        b=BqcX4oTv+LeOXCzPTlru4rR0UsHY4mmhf8mXzYtw1DM7hxvfaRffXEhVxkfcPxV5na
         X6Jmb5zhjOO6b3i1wMShEK6pTTK8gSxmweoRQbpc8Li0RnkVBRHufhzigOllRGOTwWdZ
         XKlHEM/zaL0cEZADihLPHQqmd6Dpmg1IVYNsiIEZn+mpRHPskrkoYy2UNN0/6+3O4EFt
         QRoLx9p7b9ODmk9jfYUe5rFDcvRBe3BC7tSClQbSGC05aeHU9NBGyEPIF+i35ZflByf5
         iSHwJW8oKKPuKcWsCBxoZXzIZ57ww6s7paAf5ojLVHiTDWSl6uzmW5zHugDDEYf8HgQI
         k+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=mholAPGkgLZz7hdw+yCXk7yFg3xwhXBLA4zX2Xmro8A=;
        b=I7K0MzTyKR3wZRkTO8wK6vLXA2DEs0UtbECRaQpkwNolsxgMWrR8ykRQbHz+uvks01
         GP1sbK1dkUrFFz8sMHuOTIrd31yFNSUnFYe/Hjmbo6Sb8fKr0xYh/CrZpZ1FfJ0sWx4L
         08rSRj/YiGiatuOit0xras4xJne0i/XIhFTNtEc2ndhDzULL48nHP6ghjAS5pFQgV+9q
         yrg177CGmZMtLMmJ6cGlZAedM31j2sJoDbMDmkcgAXvR5DqeZ7dorSp+r8MJrcLtdRX+
         OOoJI4LE2JK2sVzdffmVoHdOx4vFoCDRmEfpmKw/dN+BxTfUo7LPp99hbabekM/FIcQq
         PkjQ==
X-Gm-Message-State: ACgBeo3QWiBs8qZihu/IPzHKG5qest3H8q/dfgQw0GF7faL6cyWxfpX8
        oyIYBGWcq3DOIjvUxY+jXiHQlw==
X-Google-Smtp-Source: AA6agR4Q/g7zk6lRpIVguh3EGoZHTCdpk8fwPvxY2SKB2nfFnokG6lKxj7pPue9icKdzPubI9v62eQ==
X-Received: by 2002:a05:6512:2288:b0:48a:e6a9:dc99 with SMTP id f8-20020a056512228800b0048ae6a9dc99mr6808709lfu.339.1660654445908;
        Tue, 16 Aug 2022 05:54:05 -0700 (PDT)
Received: from krzk-bin.. (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id q11-20020a056512210b00b0048a7d33e0f0sm1379144lfr.261.2022.08.16.05.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 05:54:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] dt-bindings: iio: Drop Tomislav Denis
Date:   Tue, 16 Aug 2022 15:53:59 +0300
Message-Id: <20220816125401.70317-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Emails to Tomislav Denis bounce ("550 5.1.1 User Unknown").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml     | 2 +-
 Documentation/devicetree/bindings/iio/pressure/asc,dlhl60d.yaml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
index e0670e3fbb72..2876397fc668 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Texas Instruments ADS131E0x 4-, 6- and 8-Channel ADCs
 
 maintainers:
-  - Tomislav Denis <tomislav.denis@avl.com>
+  - Jonathan Cameron <jic23@kernel.org>
 
 description: |
   The ADS131E0x are a family of multichannel, simultaneous sampling,
diff --git a/Documentation/devicetree/bindings/iio/pressure/asc,dlhl60d.yaml b/Documentation/devicetree/bindings/iio/pressure/asc,dlhl60d.yaml
index be2be4b556db..1f9fe15b4b3c 100644
--- a/Documentation/devicetree/bindings/iio/pressure/asc,dlhl60d.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/asc,dlhl60d.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: All Sensors DLH series low voltage digital pressure sensors
 
 maintainers:
-  - Tomislav Denis <tomislav.denis@avl.com>
+  - Jonathan Cameron <jic23@kernel.org>
 
 description: |
   Bindings for the All Sensors DLH series pressure sensors.
-- 
2.34.1

