Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E776F771E
	for <lists+linux-iio@lfdr.de>; Thu,  4 May 2023 22:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjEDUgZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 May 2023 16:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbjEDUfx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 May 2023 16:35:53 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3448F1D95D;
        Thu,  4 May 2023 13:28:08 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 501C480F53;
        Thu,  4 May 2023 21:48:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683229697;
        bh=eRTXbMEAwKe/MiEvnmGHBR2KDtEcT1SNa1Itkb037dU=;
        h=From:To:Cc:Subject:Date:From;
        b=A9SVcQIsEy/fApkE/awqFrWs+d/BfqmRkEFY2Yc/7RbUkAXKaoROLvp4BRARM8OQc
         9gNfcXfwqO167sHMr71LmWyQ+XuNQfU/n/wfXBx9dQeRi7UUgmUvEQFmTK3CrCwMG9
         qS1KD1rVMkvq60YhEwwSOiA017C3SKLxM/VFmIjxIk2xFVqw2slkoDem+9BcEXmjZU
         w3JUoM/+BIfRco6vUQbP79zW3HyZkEdHdUjvUygFfRFiRHMPHKnjl5nTQVA+Sfzf2q
         n6WEp0HXkpQW90lQ9uRYhxpdGmGP0snjQvMsP1jouK0/BkZ+TPZ0KjIt8/TSF/4Y0M
         e6yKMp3f1POyQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings:iio:temperature:melexis,mlx90614: Document MLX90615 support
Date:   Thu,  4 May 2023 21:47:49 +0200
Message-Id: <20230504194750.4489-1-marex@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document support for MLX90615 Infra Red Thermometer, which seems to
be the predecesor of MLX90614 . There are significant differences in
the register layout compared to MLX90614, but the functionality of
the device is virtually identical.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Crt Mori <cmo@melexis.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-iio@vger.kernel.org
---
 .../bindings/iio/temperature/melexis,mlx90614.yaml          | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml
index d6965a0c1cf30..654d31f65d360 100644
--- a/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/temperature/melexis,mlx90614.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Melexis MLX90614 contactless IR temperature sensor
+title: Melexis MLX90614/MLX90615 contactless IR temperature sensor
 
 maintainers:
   - Peter Meerwald <pmeerw@pmeerw.net>
@@ -15,7 +15,9 @@ description: |
 
 properties:
   compatible:
-    const: melexis,mlx90614
+    enum:
+      - melexis,mlx90614
+      - melexis,mlx90615
 
   reg:
     maxItems: 1
-- 
2.39.2

