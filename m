Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C16975CB22
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jul 2023 17:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjGUPNU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Jul 2023 11:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjGUPNT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Jul 2023 11:13:19 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1D644202;
        Fri, 21 Jul 2023 08:12:48 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,220,1684767600"; 
   d="scan'208";a="174036284"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 22 Jul 2023 00:12:47 +0900
Received: from localhost.localdomain (unknown [10.226.92.55])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9CC21425EFAF;
        Sat, 22 Jul 2023 00:12:45 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@denx.de>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2] Documentation: ABI: sysfs-bus-counter: Fix indentation
Date:   Fri, 21 Jul 2023 16:12:43 +0100
Message-Id: <20230721151243.282435-1-biju.das.jz@bp.renesas.com>
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

Fix the indentation of the KernelVersion, Contact, and Description in
external_input_phase_clock_select_available block by replacing
spaces with tabs similar to other blocks.

Reported-by: Pavel Machek <pavel@denx.de>
Closes: https://patchwork.kernel.org/project/cip-dev/patch/20230606075235.183132-5-biju.das.jz@bp.renesas.com/
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Updated commit description
 * Replaced spaces->tab for Contact and Description lines.
---
 Documentation/ABI/testing/sysfs-bus-counter | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index dc3b3a5c876b..73ac84c0bca7 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -22,11 +22,11 @@ Description:
 			phase clock.
 
 What:		/sys/bus/counter/devices/counterX/external_input_phase_clock_select_available
-KernelVersion:  6.4
-Contact:        linux-iio@vger.kernel.org
+KernelVersion:	6.4
+Contact:	linux-iio@vger.kernel.org
 Description:
-                Discrete set of available values for the respective device
-                configuration are listed in this file.
+		Discrete set of available values for the respective device
+		configuration are listed in this file.
 
 What:		/sys/bus/counter/devices/counterX/countY/count
 KernelVersion:	5.2
-- 
2.25.1

