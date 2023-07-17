Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3326756238
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jul 2023 14:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjGQMA6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Jul 2023 08:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjGQMA5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jul 2023 08:00:57 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88CC610CA;
        Mon, 17 Jul 2023 05:00:44 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,211,1684767600"; 
   d="scan'208";a="169496403"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 17 Jul 2023 21:00:43 +0900
Received: from localhost.localdomain (unknown [10.226.92.210])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id AF1AA41F0CF0;
        Mon, 17 Jul 2023 21:00:41 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-iio@vger.kernel.org,
        Pavel Machek <pavel@denx.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] Documentation: ABI: sysfs-bus-counter: Fix indentation
Date:   Mon, 17 Jul 2023 13:00:39 +0100
Message-Id: <20230717120039.164804-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix indentation of the KernelVersion in external_input_phase_clock_
select_available block.

Reported-by: Pavel Machek <pavel@denx.de>
Closes: https://patchwork.kernel.org/project/cip-dev/patch/20230606075235.183132-5-biju.das.jz@bp.renesas.com/
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/ABI/testing/sysfs-bus-counter | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index dc3b3a5c876b..7981dcbda624 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -22,7 +22,7 @@ Description:
 			phase clock.
 
 What:		/sys/bus/counter/devices/counterX/external_input_phase_clock_select_available
-KernelVersion:  6.4
+KernelVersion:	6.4
 Contact:        linux-iio@vger.kernel.org
 Description:
                 Discrete set of available values for the respective device
-- 
2.25.1

