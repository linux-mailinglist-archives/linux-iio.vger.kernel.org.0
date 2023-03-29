Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B4B6CD38A
	for <lists+linux-iio@lfdr.de>; Wed, 29 Mar 2023 09:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjC2Hq3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Mar 2023 03:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjC2Hq2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2023 03:46:28 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551BE40E6
        for <linux-iio@vger.kernel.org>; Wed, 29 Mar 2023 00:46:21 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id br6so18956501lfb.11
        for <linux-iio@vger.kernel.org>; Wed, 29 Mar 2023 00:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680075979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+9X5TqxqvzHj77DLqMsTMoyZMkz7ylJgPTRzw+1zgDY=;
        b=EaaoWWSospBQxvZvGT9DHMUA9GPfOaNOfI2lZylUglpyJs3D3tyHzuBqCO5JgZdGjU
         Z44APqw8UlCOl/Tiqj36MdaKT1k4CQGZWoPh6w22RbFP/VkdQbUa3zMGaNv91fa7JU7p
         s7N8FDupoAsjirL/WabNE3A8IRAYfwaxaJaDbq/wZ/dxNSyftEoEcthpXznwRQdR3dbf
         uNh12ptQ+J/IUu293ZiQVSvSTMjGRA8lC9NyGfZI6ziiSN/ygqZ+4hFranMeR5SvOhWG
         +u1o6nyHLrenxAdrNGkpCWwmrnKR6J6F5qhIhJ7nG/5WSZAE8sM5fTT0HOLedjWXhWk1
         swzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680075979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9X5TqxqvzHj77DLqMsTMoyZMkz7ylJgPTRzw+1zgDY=;
        b=XpjBM6mXxGsrboXqMSSzpn4D1eYaBtClMWbEgDjRi/0RMrXd9kpK59QU9tF5C05+6a
         HKsfkLuoFkU5ZKUgXGcXnVhUmkFvf+c72wSNLVCRnzfWTguaP34B0uDkl+kpYv9YpgyT
         im4kDNNxGxRfoRUQpjTXb71G8wtvso/wC3QwlaFFlexjIhEDhbzMH74oVIyaUbUyAnDk
         c1hkSw+OUPRkQTNRwla3TLd/eREKvP/ojNEc53fSBrZXQX0pzR4JXh6jfS/fcwUGbP1P
         h2sq1NIHvygS9yS85KnAcNlb0fV/5ZJ7Z3rTMgeFZ6ZD32AIAeDFNndI64Bt6IWCXJnV
         1kWg==
X-Gm-Message-State: AAQBX9eGKUnUsMw+dP/XH31PsNkZtWMDxrEvf1jdOr83fq6Qj93ydhQa
        juvyroy3+qHuU8GJlkJDZ4bcvw==
X-Google-Smtp-Source: AKy350Z2yDiACAJ8ogkoO/PyrxwnbV+DbcEfLmqS3XiN4wD4vSNJ5xhTwtzwrldDYA8OHEMTBCBLmw==
X-Received: by 2002:a19:ae0e:0:b0:4e9:cfd2:e2d with SMTP id f14-20020a19ae0e000000b004e9cfd20e2dmr3954091lfc.65.1680075979508;
        Wed, 29 Mar 2023 00:46:19 -0700 (PDT)
Received: from Fecusia.lan (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id f9-20020ac25089000000b004e9d2af99c0sm4150972lfm.71.2023.03.29.00.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 00:46:19 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>, devicetree@vger.kernel.org,
        Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH] dt-bindings: iio: st-sensors: Fix repeated text
Date:   Wed, 29 Mar 2023 09:46:14 +0200
Message-Id: <20230329074614.1037625-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The description oddly contains a copy of the initial paragraph.
Let's not repeat ourselves.

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Denis Ciocca <denis.ciocca@st.com>
Cc: devicetree@vger.kernel.org
Reported-by: Diederik de Haas <didi.debian@cknow.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
index c6201976378f..558ae650f218 100644
--- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
+++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
@@ -11,9 +11,6 @@ description: The STMicroelectronics sensor devices are pretty straight-forward
   what type of sensor it is.
   Note that whilst this covers many STMicro MEMs sensors, some more complex
   IMUs need their own bindings.
-  The STMicroelectronics sensor devices are pretty straight-forward I2C or
-  SPI devices, all sharing the same device tree descriptions no matter what
-  type of sensor it is.
 
 maintainers:
   - Denis Ciocca <denis.ciocca@st.com>
-- 
2.39.2

