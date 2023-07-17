Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3446D75627F
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jul 2023 14:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjGQMIb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Jul 2023 08:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjGQMIa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jul 2023 08:08:30 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B4C51705;
        Mon, 17 Jul 2023 05:08:07 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,211,1684767600"; 
   d="scan'208";a="173141825"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 17 Jul 2023 21:07:42 +0900
Received: from localhost.localdomain (unknown [10.226.92.210])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id AC3DD41F2F9F;
        Mon, 17 Jul 2023 21:07:40 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-iio@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@denx.de>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] counter: rz-mtu3-cnt: Fix locking order
Date:   Mon, 17 Jul 2023 13:07:38 +0100
Message-Id: <20230717120738.165765-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

All functions except rz_mtu3_count_enable_write(), calls
pm_runtime_{get,put} inside the lock. For consistency do the same here.

Reported-by: Pavel Machek <pavel@denx.de>
Closes: https://patchwork.kernel.org/project/cip-dev/patch/20230606075235.183132-6-biju.das.jz@bp.renesas.com/
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
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

