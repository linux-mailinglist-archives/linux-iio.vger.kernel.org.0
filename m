Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB2558CAC0
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 16:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbiHHOt4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 10:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242796AbiHHOtp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 10:49:45 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B74513CF8
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 07:49:44 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b96so11731166edf.0
        for <linux-iio@vger.kernel.org>; Mon, 08 Aug 2022 07:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yv7/Ul3NtrsgwZNY2tz3vPTVziFu5q3/IA4UlHUJklg=;
        b=S2IGJCwZMVPowoihlFkTDxVmPB6bfb6v8CYSoKyiiDobysypIl1hXJ9bnCssCL7z6R
         hnCLVOMqoH3AAs1oNY9l7RCa47YrxS3zAqqiE++NncryABegZsFqN1iUrFpCQsfphRNi
         lv6LOVXsh8rVqG9+wcm//7YhGKCWSktdVPiLOAbxre9yKwYKWOTcy/Wbhkgp66T1rTSm
         kjepb6B9q8m4XlmzDvfET9FOpqjYeuW+vjjXGsswHD4W7j8UwMo/TXiFWzZ34bT0f0bL
         8hZiXh5WDUZwJeniF0zGkjE1VyWAUXc59d5QxnpmBmHXFCrbuud3ke/fBFwgXQDLDzVw
         7njQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yv7/Ul3NtrsgwZNY2tz3vPTVziFu5q3/IA4UlHUJklg=;
        b=xONh2fhX3KNNA3uIwIo4gtchbTYbNISnhfOw/dC2fLMj5zwqq6Y0Kv4RuntlOhX8U3
         Pz1g0M/ctAGiXmBm1FNOZU9lXq0ApvIiZs9wzak4AJEy04OeiO0UmmWGxddMxkhzDhFX
         gdHqKmlNmGzbeemTYMPG0RFIdfk2aCcZVsqDaMUOGlWxl8ozpxo8qb/iOkOTmViL9Vz0
         v+kMFfi+B4KupsDOpsraf/nUafV5wqgvL/8QhZ8H+0BnCJtuIMGcH75oAh60MtgJRTCI
         GzOd0nFudvQZpO6xNDFnanLGRRyOBUBiwK5nbE2osiaYW4iX3VUJ0nUYmgxN40l3V9O3
         +ZKw==
X-Gm-Message-State: ACgBeo1JTtQyoHb9LBhWJAT2PGaKHzpCg7jtnVNUlhqLyNVDmHhr0D5O
        19PSO7D7lgyXcq0iModlthJGyCSZptd3/Q==
X-Google-Smtp-Source: AA6agR4PPC/LIGsLNQk3+R+crCvb6P9SQUPULlkbuwDaegHTPO7e9Yd9cgP5Gw8qaQpkuiuHyVWarw==
X-Received: by 2002:a05:6402:24a4:b0:440:8c0c:8d2b with SMTP id q36-20020a05640224a400b004408c0c8d2bmr6479287eda.311.1659970183080;
        Mon, 08 Aug 2022 07:49:43 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xh0y3vuv1059rd6h4r.18120a2.ip6.access.telenet.be. [2a02:1810:a44c:8f00:cd22:c517:e143:e53b])
        by smtp.gmail.com with ESMTPSA id q4-20020a17090676c400b00722fc0779e3sm5056276ejn.85.2022.08.08.07.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 07:49:42 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Crt Mori <cmo@melexis.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/2] dt-bindings: iio: mlx90632 Add supply regulator documentation
Date:   Mon,  8 Aug 2022 16:49:36 +0200
Message-Id: <20220808144936.1559158-1-cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document the newly added vdd supply option.

Signed-off-by: Crt Mori <cmo@melexis.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/iio/temperature/melexis,mlx90632.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml
index b547ddcd544a..4a55e7f25ae7 100644
--- a/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml
@@ -35,6 +35,9 @@ properties:
     maxItems: 1
     description: Default is 0x3a, but can be reprogrammed.
 
+  vdd-supply:
+    description: provide VDD power to the sensor.
+
 required:
   - compatible
   - reg
@@ -50,6 +53,7 @@ examples:
         temp-sensor@3a {
             compatible = "melexis,mlx90632";
             reg = <0x3a>;
+            vdd-supply = <&ldo4_reg>;
         };
     };
 ...
-- 
2.34.1

