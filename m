Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B2958C6D0
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 12:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242657AbiHHKsG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 06:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242742AbiHHKrz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 06:47:55 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0731913D57
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 03:47:53 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x19so3799428lfq.7
        for <linux-iio@vger.kernel.org>; Mon, 08 Aug 2022 03:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2me5XEAf0ofFirE+9ir/dwTvKRWjjaESV5ln3eJw2Hw=;
        b=CuVZZAuRK7wnpkN4SgjBYiCNJctDMSXGAa5tukH+acTFa5KoHplR3S6yO3Zg8IsTiK
         FXfKau4gB1IULpTxjrFJGwFlVnDp2FSRo0mLHy6Rr4Y0fJuivOjbk1wTypPV2+Y8TtNh
         qXkp3tkgVqzVAbaoGMkBF0u+nLxe4qLWkA1wAjIVCz5MhKCOr4RmSxPKVFcHxPBfzSrI
         Xy5SMIO5qZja0iBGcYJvDkQuCUEQHuqcneGCV+jiN6MTbhzmsrWKUjlOS1BD+qYyfRxX
         NOmyfe5nGk1MU7HPF9NGkLXVnPK1QScHtKSpOeih02tYIzIsjds2LJgApgk7bpfbgt0B
         Vg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2me5XEAf0ofFirE+9ir/dwTvKRWjjaESV5ln3eJw2Hw=;
        b=Bze86kMNFSj0VPb/1z+d3ah5fLXovaDsAnw1YJJolxf/OltESrVSMdgBj3ZfIp3Jkt
         N+fknPgOeBJeEeOCCQEpyn9nx5ZPndzBFmorQTWMHkEAfc6arKK/z72r1g4vLJO3pJqO
         UluDyhBKGYbGolXvVKHI+1Xbl5RXw8dLR65K8/lK4NXm2MR0Mw9EA7ncWnDv6JPyWtsl
         NYsw7XS2h954/L3KDKXYYp/65MHifFA2zW6DsZdw2DZC7lzp8Sv/141SGbCl9NlshbXy
         XhRDZuxoLQ8Az+kCF9loynwCe94wczmLtxencCLhaJ2r7TB6/6xZkug8dRSha1cKnp8p
         6AGg==
X-Gm-Message-State: ACgBeo1e9BjC0+ggdyWKVOV+pxSiAC14UANDT/vugAfHRwQ7MLrsGX4N
        RdBK5tOThvJejNVkGFzAc2zQmA==
X-Google-Smtp-Source: AA6agR7SHBGl5VdYjMKVL5UzdrTUUcHRsum2qdgVfy4yK3qFurC9b/riPzx+QLdQbigJ4aBmocHf2Q==
X-Received: by 2002:a05:6512:3d0e:b0:48b:3976:b319 with SMTP id d14-20020a0565123d0e00b0048b3976b319mr5532909lfv.362.1659955673039;
        Mon, 08 Aug 2022 03:47:53 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id l18-20020a2ea312000000b0025e040510e7sm1314321lje.74.2022.08.08.03.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 03:47:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Pavel Machek <pavel@ucw.cz>,
        Tim Harvey <tharvey@gateworks.com>,
        Robert Jones <rjones@gateworks.com>,
        Lee Jones <lee@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-leds@vger.kernel.org,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/5] dt-bindings: Drop Robert Jones
Date:   Mon,  8 Aug 2022 13:47:11 +0300
Message-Id: <20220808104712.54315-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220808104712.54315-1-krzysztof.kozlowski@linaro.org>
References: <20220808104712.54315-1-krzysztof.kozlowski@linaro.org>
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

Emails to Robert Jones bounce ("550 5.2.1 The email account that you
tried to reach is disabled").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml | 2 +-
 Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml    | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml b/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
index 479e7065d4eb..0203b83b8587 100644
--- a/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Freescale FXOS8700 Inertial Measurement Unit
 
 maintainers:
-  - Robert Jones <rjones@gateworks.com>
+  - Jonathan Cameron <jic23@kernel.org>
 
 description: |
   Accelerometer and magnetometer combo device with an i2c and SPI interface.
diff --git a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
index 5a1e8d21f7a0..5e0fe3ebe1d2 100644
--- a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
+++ b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
@@ -19,7 +19,6 @@ description: |
 
 maintainers:
   - Tim Harvey <tharvey@gateworks.com>
-  - Robert Jones <rjones@gateworks.com>
 
 properties:
   $nodename:
-- 
2.34.1

