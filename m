Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C5050CA80
	for <lists+linux-iio@lfdr.de>; Sat, 23 Apr 2022 15:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbiDWNT7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Apr 2022 09:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbiDWNT6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 23 Apr 2022 09:19:58 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E9781FF541;
        Sat, 23 Apr 2022 06:17:01 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.90,284,1643641200"; 
   d="scan'208";a="118906153"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 23 Apr 2022 22:17:01 +0900
Received: from localhost.localdomain (unknown [10.226.92.16])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4CA7140065C0;
        Sat, 23 Apr 2022 22:16:57 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH] dt-bindings: iio: adc: Document Renesas RZ/V2L ADC
Date:   Sat, 23 Apr 2022 14:16:54 +0100
Message-Id: <20220423131654.131390-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document renesas RZ/V2L ADC bindings. RZ/V2L ADC is identical to RZ/G2L
with same number of channels.

While at it remove RZ/G2LC SoC from binding documentation as it does not
support ADC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml         | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
index c80201d6a716..d66c24cae1e1 100644
--- a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
@@ -19,7 +19,8 @@ properties:
   compatible:
     items:
       - enum:
-          - renesas,r9a07g044-adc   # RZ/G2{L,LC}
+          - renesas,r9a07g044-adc   # RZ/G2L
+          - renesas,r9a07g054-adc   # RZ/V2L
       - const: renesas,rzg2l-adc
 
   reg:
-- 
2.25.1

