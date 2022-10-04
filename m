Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B945F4281
	for <lists+linux-iio@lfdr.de>; Tue,  4 Oct 2022 13:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiJDL5A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Oct 2022 07:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiJDL44 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Oct 2022 07:56:56 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0601F27145
        for <linux-iio@vger.kernel.org>; Tue,  4 Oct 2022 04:56:54 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id q16so911591ljh.4
        for <linux-iio@vger.kernel.org>; Tue, 04 Oct 2022 04:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=FdyEVIPJeiAfJdqp4U03o0jzRRrkJ/p0h+cO275MuNs=;
        b=IV1A51iwnwkACHlwdVnEHgmak5oRPhrYXOKjD29XRWl1mnOWHx/8MMswIE7lU7EwfA
         JmvWXZBTUQ/SpZCihwvpAxnrDnJvLFe1IZyThu3Remop4VoyutrAmZiZ3lbOJuyy1661
         Ne1Yw6B/bjAKY4JdJDao5JsURYjkjcXZ+UzthB5uhsURjE+Hiqm0sCBh7qlf9K7WnmPp
         3ZQ6hcemC7vCRnc20RPeGhcrM8K50+MJjrxqv02Tf0HjHH7AuXeC9D43VyUDKJWS+jNS
         Szu2u1SG38NMuZdsDoZv3Xtm58qUKBfGCSd8SzywCX2zY1DS7ymVgXQuDlGcpsUfXXuc
         al+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FdyEVIPJeiAfJdqp4U03o0jzRRrkJ/p0h+cO275MuNs=;
        b=oZRaoCPaYij/FyAryUs/DRkfABhWcw+nSsV38OFxeXODPkZFxJVlkXmpdLHo50Cs7d
         lxW7+bGbF5mWwr+SE9A59sHQ8PJiQzdD0QKZj+vU8T60MrtrgRA08+0sBlCkBEmTtswr
         /rgxsgohFVHnSUORDakEICV/nmg2P5LpRQKtiRPplACDcOyubBU7CX+Ip65ZrM0akyrS
         8EeLlofY9Tn+QQY/pDycDLuc/x/JnkM2H/SAyBqCpPD4Y5/FM6jwHdt10nVe5J724NED
         4nuEBEDyZhtA5fTetwcmKgf18FxtJbpfQGMaAUTzIsv9JaWonq/IUI7g6dIlx1yWisWR
         c9lw==
X-Gm-Message-State: ACrzQf3yc/Z36GCtspXrlTrgpA8U8c+aiYE5kwvYaxdthgsi1TsF1IqM
        Vydtw/0JCoGck76JT9+GeK5B/g==
X-Google-Smtp-Source: AMsMyM7zqGLppwXRatoi+n/B8NSWlFwlBda9n4lQBF9CxHCY1/Bew+a4xSek+KaDXhro4APt1Dxg5Q==
X-Received: by 2002:a05:651c:903:b0:26d:d930:e3cf with SMTP id e3-20020a05651c090300b0026dd930e3cfmr3734839ljq.232.1664884612416;
        Tue, 04 Oct 2022 04:56:52 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w8-20020a05651204c800b004a03fd4476esm1878971lfq.287.2022.10.04.04.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 04:56:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Cristian Pop <cristian.pop@analog.com>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 7/8] dt-bindings: iio: proximity: ams,as3935: use spi-peripheral-props.yaml
Date:   Tue,  4 Oct 2022 13:56:41 +0200
Message-Id: <20221004115642.63749-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221004115642.63749-1-krzysztof.kozlowski@linaro.org>
References: <20221004115642.63749-1-krzysztof.kozlowski@linaro.org>
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

For devices connectable by SPI bus (e.g. already using
"spi-max-frequency" property), reference the "spi-peripheral-props.yaml"
schema to allow using all SPI device properties, even these which device
bindings author did not tried yet.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/iio/proximity/ams,as3935.yaml        | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/proximity/ams,as3935.yaml b/Documentation/devicetree/bindings/iio/proximity/ams,as3935.yaml
index 7fcba5d6d508..710d3b9a86d9 100644
--- a/Documentation/devicetree/bindings/iio/proximity/ams,as3935.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/ams,as3935.yaml
@@ -49,7 +49,10 @@ required:
   - spi-cpha
   - interrupts
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

