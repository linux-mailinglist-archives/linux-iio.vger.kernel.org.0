Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB88587ABB
	for <lists+linux-iio@lfdr.de>; Tue,  2 Aug 2022 12:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236530AbiHBKbN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Aug 2022 06:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236474AbiHBKbG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Aug 2022 06:31:06 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FF564D0
        for <linux-iio@vger.kernel.org>; Tue,  2 Aug 2022 03:31:05 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id s11so5616512edd.13
        for <linux-iio@vger.kernel.org>; Tue, 02 Aug 2022 03:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+PCHhH5RY3YpATXYSctNUUiV4iFFV7Fmg95HJ0DFe0=;
        b=io3HzhFIfyn/dkiAahjBcd22WsDIXtuEdAhJGEifDqwHsa/C4rSvDZGltXe0xhn3Z6
         zdecvxTUv2BXT6i0zjd20+9wihS680plrHDDBpgrVj7UNX/iAT92N+cRfhh3jcBrfJXt
         uK8qMDUBZDr70gMr3t01mPY66vECw29acCkNH471Guccofl131ekIgX7E+Ax2tW+AXbU
         Hvqt5le99fvJzXxKCwmRHRiXCBy0KKLa7kXpED+H+WyooE1MSh4qCad5dBcqT05WfGXX
         AOVYOLCQgf+7SrbE2KhMy+VJpNw2KYmj89TpGYSKENv0TmUhUDQkahiFLDWOXr2K9WCQ
         xpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+PCHhH5RY3YpATXYSctNUUiV4iFFV7Fmg95HJ0DFe0=;
        b=TfgqeCp3Em+bX6DA7+nP3dlsv53hGNKRre9sdrzhyABwyuI4KN2glTmr6zvF4LC5u7
         POGYTfcYVqm8QVa11vGej3qTOxk/3QjszKbootjVekI0V3VgZ7jU9DTo8WTnBUGXJwJv
         6Oa4bK+GpYEhfVZi29I4Jjv67yqZtv03Ac+hHPPSg2eVGN18yxhEGDGEyUYr265ApICl
         xhYi1ELB3SgyAjKgM1cbOBS6g/im1lwfANgiq4DkDFo/7P7UQp8wYsn+/Y3FYoC+uupn
         oZZzUry2ud6ZVZh5V9fRkbsZE5y+zhhDBKSN2FKPwOZobpNtmlPHRd1GNfT6CsICmAuJ
         z1WQ==
X-Gm-Message-State: AJIora8vCrUNogK8A828J9SCawHECfnunGXRbk7sOCBTv0PMcs0lW0Xx
        VSdIyM4HXmUOyeS+B00RVDwnlQ==
X-Google-Smtp-Source: AGRyM1s/Knjx88HG6B+GNu/lY+h+uZegZ9mmb8afXy7xIniy9hVOBoT8GVTyeAQi3BYzrrvdRpX2LA==
X-Received: by 2002:aa7:d8d1:0:b0:43c:ce93:ff67 with SMTP id k17-20020aa7d8d1000000b0043cce93ff67mr19896923eds.295.1659436264183;
        Tue, 02 Aug 2022 03:31:04 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xh0y3uhn87zojrdbwi.18120a2.ip6.access.telenet.be. [2a02:1810:a44c:8f00:733c:5cdf:8a1a:e482])
        by smtp.gmail.com with ESMTPSA id k10-20020aa7d8ca000000b0043cb1a83c9fsm8057794eds.71.2022.08.02.03.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 03:31:03 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Crt Mori <cmo@melexis.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: iio: mlx90632 Add supply regulator documentation
Date:   Tue,  2 Aug 2022 12:30:54 +0200
Message-Id: <20220802103054.423372-1-cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document the newly added vdd supply option.

Signed-off-by: Crt Mori <cmo@melexis.com>
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

