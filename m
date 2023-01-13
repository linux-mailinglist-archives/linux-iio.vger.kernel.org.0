Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4297669DD2
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jan 2023 17:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjAMQZe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Jan 2023 11:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjAMQYb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Jan 2023 11:24:31 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0F4E8D5E2;
        Fri, 13 Jan 2023 08:18:16 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.97,214,1669042800"; 
   d="scan'208";a="146246491"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jan 2023 01:18:16 +0900
Received: from localhost.localdomain (unknown [10.226.92.190])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6EE1640189C1;
        Sat, 14 Jan 2023 01:18:14 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v11 5/6] MAINTAINERS: Add entries for Renesas RZ/G2L MTU3a counter driver
Date:   Fri, 13 Jan 2023 16:17:52 +0000
Message-Id: <20230113161753.1073706-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230113161753.1073706-1-biju.das.jz@bp.renesas.com>
References: <20230113161753.1073706-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the MAINTAINERS entries for the Renesas RZ/G2L MTU3a counter
driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v11:
 * New patch
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 02654d2a7e68..c0343f877487 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17876,6 +17876,14 @@ S:	Supported
 F:	Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
 F:	drivers/iio/adc/rzg2l_adc.c
 
+RENESAS RZ/G2L MTU3a COUNTER DRIVER
+M:	Biju Das <biju.das.jz@bp.renesas.com>
+L:	linux-iio@vger.kernel.org
+L:	linux-renesas-soc@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
+F:	drivers/counter/rz-mtu3-cnt.c
+
 RENESAS RZ/N1 A5PSW SWITCH DRIVER
 M:	Clément Léger <clement.leger@bootlin.com>
 L:	linux-renesas-soc@vger.kernel.org
-- 
2.25.1

