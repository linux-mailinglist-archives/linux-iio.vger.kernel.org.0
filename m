Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8D258DBF1
	for <lists+linux-iio@lfdr.de>; Tue,  9 Aug 2022 18:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245005AbiHIQ2J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Aug 2022 12:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244986AbiHIQ2E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Aug 2022 12:28:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090151FCFC
        for <linux-iio@vger.kernel.org>; Tue,  9 Aug 2022 09:28:02 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id u1so17726309lfq.4
        for <linux-iio@vger.kernel.org>; Tue, 09 Aug 2022 09:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VQqWBeEw3qmpRlqqPzE7ts9pNLZupNqxFvrZxuptWIw=;
        b=j79cXYWF8zWqA57u666uDxDQhQSxVG4iHrBRVvIitGuWL3K37eFf18TlAp2CYAcAvf
         k/cvVQQag/Jn2M+i8GJ41Ar4NcO7nre1mhTl3A36V6Xpsz5Bni6NO6pWjwavxsWPrVKH
         tI2kusCmuH3F6Uj10cVQ7EftmfmtzZqnopM958bWnpYTWKObaSzu8zXuyOITi5j/onEB
         Z5plD+zVaKsjLLhb1QmZOqK/3L6VJq4eVxpgqk2QwugxZCTU4evWptwT62bEmnhwWHa3
         npd0xSDsOVJhgvboIJTo/8h8iegXTYZgZPwn74VBjOtej/oGhF6hMzRQwVs/4J0epcPt
         5XAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VQqWBeEw3qmpRlqqPzE7ts9pNLZupNqxFvrZxuptWIw=;
        b=LtYOEMd3LpUmskkeJsvkJs5MriyHLwfoUQ6jWU/5VU+h5ACzfPfuWWr4boj/F5rd7g
         uqzE9vHi9JJQDGDln1Jwp0wuAtYa2YuzoERka9j6G06nF2DW2L94o6eS/B89uDZv1rv9
         C6lgtTEabE6P9C8vGuE+/KH7tOMnQWVILc4w8138FlpUOVaPOHhyxZugILz/31uQC9tl
         3FgClSuwERW/CVaAuulz8Q3XdUEOh+q7fogbD8KLYxXBEwLoHFuOQvwu21Wn1uhTMVnw
         npmefsG1sO7xZZ2aDK04Joo3+f1IobkfQ1+mmSW/nSsCa+6XPaVZF+SO4fsPrvQsXE+B
         vWhQ==
X-Gm-Message-State: ACgBeo3kwvfmBLoFW3Qjtxyba7Iy5Fs4/AxiMUNB6yoVNe129xxCGke6
        Sf4fYLuEiiXPRWei8qXyuFx/Vw==
X-Google-Smtp-Source: AA6agR7eDE6idEdhMhZWlMx2pyUpEsLs29Q4eIc0ackncepXx/MXNZjkccFDQoE9WCyEbZAey+9A4A==
X-Received: by 2002:a05:6512:3b06:b0:48b:239e:be with SMTP id f6-20020a0565123b0600b0048b239e00bemr8058254lfv.586.1660062480249;
        Tue, 09 Aug 2022 09:28:00 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id h7-20020ac24d27000000b0048a8c907fe9sm20999lfk.167.2022.08.09.09.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 09:27:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Pavel Machek <pavel@ucw.cz>,
        Tim Harvey <tharvey@gateworks.com>, Lee Jones <lee@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Andrew Davis <afd@ti.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-leds@vger.kernel.org,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 2/5] dt-bindings: iio: Drop Bogdan Pricop
Date:   Tue,  9 Aug 2022 19:27:49 +0300
Message-Id: <20220809162752.10186-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220809162752.10186-1-krzysztof.kozlowski@linaro.org>
References: <20220809162752.10186-1-krzysztof.kozlowski@linaro.org>
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

Emails to Bogdan Pricop bounce ("550 5.4.1 Recipient address rejected:
Access denied. AS(201806281)").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/devicetree/bindings/iio/adc/ti,adc108s102.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,adc108s102.yaml b/Documentation/devicetree/bindings/iio/adc/ti,adc108s102.yaml
index 54955f03df93..ae5ce60987fe 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,adc108s102.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,adc108s102.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Texas Instruments ADC108S102 and ADC128S102
 
 maintainers:
-  - Bogdan Pricop <bogdan.pricop@emutex.com>
+  - Jonathan Cameron <jic23@kernel.org>
 
 description: |
   Family of 8 channel, 10/12 bit, SPI, single ended ADCs.
-- 
2.34.1

