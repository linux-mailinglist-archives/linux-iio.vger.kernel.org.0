Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323426FDB8C
	for <lists+linux-iio@lfdr.de>; Wed, 10 May 2023 12:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbjEJKX3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 May 2023 06:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236573AbjEJKX2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 May 2023 06:23:28 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F9D30CA;
        Wed, 10 May 2023 03:23:25 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 8B4D9846B6;
        Wed, 10 May 2023 12:23:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683714204;
        bh=l3nzFfntxHF9pjhdFKzLn4pB7Uc09xfOJyBZjOmwiPM=;
        h=From:To:Cc:Subject:Date:From;
        b=GrsJ99EH8/USS/x16SPqIqcI2+8C4svPqGRy/nujr0dStlN5oPB6ugU4QyWZR/9+s
         UHO8th+l4kn/ggQN8xeHEI93bQ18s2L49EmX18TnrwDLAbkMY2lX2114swfo5Rpvck
         Y4yCTGB93g2dvFeV/5x2/1T58Nefq9S7AgSZgwqoHT78qqNHLqfNVkogVe4eHjNac/
         8OZPDVujhO9ssRCXN6CBGUwMNj2XN9j8giMjKl+Z0pjVVTaKYZLaPdiOkfoJ6CEi2Y
         7nbTQkTzgjN6UqXVz4AYHeZW7SeVSxPsBOGC9mTW1OWzyHc1UYMH9yIXJnE1ZQi/io
         1dI1gLWauD/QQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Crt Mori <cmo@melexis.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 1/6] dt-bindings: iio: temperature: melexis,mlx90614: Document MLX90615 support
Date:   Wed, 10 May 2023 12:22:46 +0200
Message-Id: <20230510102251.10118-1-marex@denx.de>
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

Acked-by: Crt Mori <cmo@melexis.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
V2: - Add spaces to subject tags
    - Add AB from Krzysztof
V3: Add AB from Crt
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

