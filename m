Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778677806C5
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 09:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358396AbjHRH4w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 03:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358483AbjHRH4p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 03:56:45 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB1BD4208;
        Fri, 18 Aug 2023 00:56:20 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,182,1684767600"; 
   d="scan'208";a="173263220"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 18 Aug 2023 16:56:17 +0900
Received: from localhost.localdomain (unknown [10.226.93.81])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2660E41BBD56;
        Fri, 18 Aug 2023 16:56:13 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 3/5] dt-bindings: iio: magnetometer: asahi-kasei,ak8975: Drop deprecated enums
Date:   Fri, 18 Aug 2023 08:55:58 +0100
Message-Id: <20230818075600.24277-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Drop deprecated enums from bindings as it is been here for a long time.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2:
 * New patch
---
 .../bindings/iio/magnetometer/asahi-kasei,ak8975.yaml      | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
index 9790f75fc669..ee77558e9800 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
+++ b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
@@ -18,13 +18,6 @@ properties:
           - asahi-kasei,ak09911
           - asahi-kasei,ak09912
           - asahi-kasei,ak09916
-      - enum:
-          - ak8975
-          - ak8963
-          - ak09911
-          - ak09912
-          - ak09916
-        deprecated: true
 
   reg:
     maxItems: 1
-- 
2.25.1

