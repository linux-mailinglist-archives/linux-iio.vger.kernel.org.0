Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E3C761D96
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jul 2023 17:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjGYPqT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Jul 2023 11:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjGYPqS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Jul 2023 11:46:18 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40BAD1FFF;
        Tue, 25 Jul 2023 08:46:17 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,230,1684767600"; 
   d="scan'208";a="170782035"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 26 Jul 2023 00:46:16 +0900
Received: from localhost.localdomain (unknown [10.226.92.3])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 35D9A4010AB3;
        Wed, 26 Jul 2023 00:46:13 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-iio@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@denx.de>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3] counter: rz-mtu3-cnt: Reorder locking sequence for consistency
Date:   Tue, 25 Jul 2023 16:46:11 +0100
Message-Id: <20230725154611.227556-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

All functions except rz_mtu3_count_enable_write(), call
pm_runtime_{get,put} inside the lock. For consistency do the same here.

Reported-by: Pavel Machek <pavel@denx.de>
Closes: https://lore.kernel.org/r/ZH8Fmom8vZ4DwxqA@duo.ucw.cz
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2->v3:
 * Updated commit description by replacing 'calls'->'call'.
 * Added Rb tag from Geert.
v1->v2:
 * Updated commit header to make it clear this is not addressing a bug,
   rather it's just cleanup.
---
 drivers/counter/rz-mtu3-cnt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 48c83933aa2f..ee821493b166 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -500,8 +500,8 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
 	int ret = 0;
 
 	if (enable) {
-		pm_runtime_get_sync(ch->dev);
 		mutex_lock(&priv->lock);
+		pm_runtime_get_sync(ch->dev);
 		ret = rz_mtu3_initialize_counter(counter, count->id);
 		if (ret == 0)
 			priv->count_is_enabled[count->id] = true;
@@ -510,8 +510,8 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
 		mutex_lock(&priv->lock);
 		rz_mtu3_terminate_counter(counter, count->id);
 		priv->count_is_enabled[count->id] = false;
-		mutex_unlock(&priv->lock);
 		pm_runtime_put(ch->dev);
+		mutex_unlock(&priv->lock);
 	}
 
 	return ret;
-- 
2.25.1

