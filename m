Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD42773E0E
	for <lists+linux-iio@lfdr.de>; Tue,  8 Aug 2023 18:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjHHQZq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Aug 2023 12:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbjHHQYe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Aug 2023 12:24:34 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA91AD15
        for <linux-iio@vger.kernel.org>; Tue,  8 Aug 2023 08:50:05 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso7755180a12.3
        for <linux-iio@vger.kernel.org>; Tue, 08 Aug 2023 08:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691509798; x=1692114598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OSNGkojbT+FsqpoKjJ9301dnAVYJ8YQV267IqvAEoPU=;
        b=xFeUvMqyQ32p/4ipR3PJ4Bp8kQw0JegHzXmTg0rrNdYZPppFvSP5IiWaU1k8OtKmFP
         hlOywil/QZMGL0f9BR7jYKxWBsHLG+fkJ8/h1zO9iIjipnFc2NgI08bqsIwdlbZb/QsP
         QDPNNFqVlAA9gk+ovh3XF4Rkduxo2F5o2VTAgp5I/bqLqCIHd02G6JtSdnSFlF92Epf9
         igkvJmFCWRBe66btKdFY8SZ1QXSLcJ1wql9bqbR8Y2lm6EEYLzPcoLmYNRyLqjrdScAT
         yfYHYh3wuy7imAAEr/k4eONKizDnnM8KZhWE4rZkG7LWilD8B5qLOylQDNsXUdToHqq6
         59rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509798; x=1692114598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OSNGkojbT+FsqpoKjJ9301dnAVYJ8YQV267IqvAEoPU=;
        b=KLtMIlegoOGX5DIx0Gp9WN83YT+59HUYQda+5XDZ2zSPumZr8Sym7Py1rjJDbg2TOD
         UnlaM+7PuwWgwOHNrPosZoWhFR3pU3D958F2c5PgVFn82vigXMfmQSpRdQXBuf6UFUX9
         8J4I6aRqs1BT8TQzf+qkEd5S6ijkCp87sfhhhEg6S5SIA7BD3LSpMMcbmkFFTxLlkxqa
         HNk8Frg5E8/+XrCxCv8+n5Lzs0GcRsmHVa6uOkhPRlI3P0uT25mRlxq7b01+9tWX1fkA
         iFhMc8hwknsBZElVLLwSMbG1lQLfL9W2h6l9GFDmoiOundbau7kgIXfPdsRUcYUv5J1Q
         oEWA==
X-Gm-Message-State: AOJu0Ywef/aBjCS1HXRAF4iSMApdRK2KwpdudrlFM3gzznvozYmkmIZ0
        SjiQ5NqLxmk3unDB+7XvcbfG0Y4YYRiKFHcIcDQ=
X-Google-Smtp-Source: AGHT+IGBUM9Eb5+0TWgDLF8LmOhVhKOR18zw7z8Wucg5zDszfG4kbd1nLl37Ej26nZOXcXHoLMXtdA==
X-Received: by 2002:a1c:4b0b:0:b0:3fe:2b8c:9f00 with SMTP id y11-20020a1c4b0b000000b003fe2b8c9f00mr8459725wma.24.1691476346737;
        Mon, 07 Aug 2023 23:32:26 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id z22-20020a1c4c16000000b003fbb25da65bsm12705726wmf.30.2023.08.07.23.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 23:32:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: iio: rohm,bu27010: add missing vdd-supply to example
Date:   Tue,  8 Aug 2023 08:32:23 +0200
Message-Id: <20230808063223.80431-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Bindings require vdd-supply but the example DTS was missing one.  This
fixes dt_binding_check error:

  Documentation/devicetree/bindings/iio/light/rohm,bu27010.example.dtb: light-sensor@38: 'vdd-supply' is a required property

Fixes: ae8c47c51e5c ("dt-bindings: iio: ROHM BU27010 RGBC + flickering sensor")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml b/Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml
index 8376d64a641a..bed42d5d0d94 100644
--- a/Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml
+++ b/Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml
@@ -45,5 +45,6 @@ examples:
       light-sensor@38 {
         compatible = "rohm,bu27010";
         reg = <0x38>;
+        vdd-supply = <&vdd>;
       };
     };
-- 
2.34.1

