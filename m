Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0652764D8D
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jul 2023 10:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbjG0IgS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Jul 2023 04:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbjG0IgA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Jul 2023 04:36:00 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBFB52D63;
        Thu, 27 Jul 2023 01:19:23 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,234,1684767600"; 
   d="scan'208";a="171020961"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 27 Jul 2023 17:19:10 +0900
Received: from localhost.localdomain (unknown [10.226.93.33])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 19FC441CA1EF;
        Thu, 27 Jul 2023 17:19:05 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 3/5] dt-bindings: timer: renesas,rz-mtu3: Document RZ/{G2UL,Five} SoCs
Date:   Thu, 27 Jul 2023 09:18:46 +0100
Message-Id: <20230727081848.100834-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230727081848.100834-1-biju.das.jz@bp.renesas.com>
References: <20230727081848.100834-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add MTU3a binding documentation for Renesas RZ/{G2UL,Five} SoCs.

MTU3a block is identical to one found on RZ/G2L, so no driver changes are
required. The fallback compatible string "renesas,rz-mtu3" will be used
on RZ/{G2UL,Five}.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2->v3:
 * Added Rb tag from Geert.
 * Documented RZ/Five SoC as the same IP used in RZ/G2UL SoC.
 * Updated commit header and description.
 * Retained tags as it is trivial change.
v1->v2:
 * Added ack from Conor Dooley.
---
 Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
index 670a2ebaacdb..3931054b42fb 100644
--- a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
@@ -109,6 +109,7 @@ properties:
   compatible:
     items:
       - enum:
+          - renesas,r9a07g043-mtu3  # RZ/{G2UL,Five}
           - renesas,r9a07g044-mtu3  # RZ/G2{L,LC}
           - renesas,r9a07g054-mtu3  # RZ/V2L
       - const: renesas,rz-mtu3
-- 
2.25.1

