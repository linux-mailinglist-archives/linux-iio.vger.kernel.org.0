Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E0B6D02E6
	for <lists+linux-iio@lfdr.de>; Thu, 30 Mar 2023 13:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjC3LS1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Mar 2023 07:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjC3LRe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Mar 2023 07:17:34 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47282A5C5;
        Thu, 30 Mar 2023 04:16:54 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.98,303,1673881200"; 
   d="scan'208";a="154322499"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 30 Mar 2023 20:16:53 +0900
Received: from localhost.localdomain (unknown [10.226.93.62])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 931F14001B66;
        Thu, 30 Mar 2023 20:16:50 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-iio@vger.kernel.org,
        Lee Jones <lee@kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v15 3/6] Documentation: ABI: sysfs-bus-counter: add cascade_counts_enable and external_input_phase_clock_select
Date:   Thu, 30 Mar 2023 12:16:29 +0100
Message-Id: <20230330111632.169434-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230330111632.169434-1-biju.das.jz@bp.renesas.com>
References: <20230330111632.169434-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This commit adds cascade_counts_enable and external_input_phase_
clock_select items to counter ABI file.
(e.g. for Renesas MTU3 hardware used for phase counting).

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: William Breathitt Gray <william.gray@linaro.org>
---
v14->v15:
 * No change.
v13->v14:
 * No change.
v12->v13:
 * Updated kernel version from 6.3->6.4 as it is too late.
v11->v12:
 * No change
v10->v11:
 * No change.
v9->v10:
 * Added Rb tag from William Breathitt Gray
v8->v9:
 * Added available blocks for external_input_phase_clock_select_available
 * Removed the "This attribute" from the external_input_phase_clock_select
   description, and capitalize the word "counter" from description.
 * Removed the "This attribute" from the cascade_counts_enable description,
   and capitalize "counts" and "counter"
 * Moved these device-level configuration blocks to top of the file.
v7->v8:
 * Replaced cascade_enable->cascade_counts_enable
 * Updated commit header and description
 * Added external_input_phase_clock_select_available entry for driver-
   specific enum attribute and created a new entry block for it.
 * Add a line stating cascade_counts_enable is a boolean attribute.
 * Added missing 'component_id' suffix.
v6->v7:
 * Replaced long_word_access_ctrl_mode->cascade_enable
 * Updated Kernel version
v5->v6:
 * No change
v5:
 * New patch
---
 Documentation/ABI/testing/sysfs-bus-counter | 32 +++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index ff83320b4255..1417c4272c6c 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -1,3 +1,33 @@
+What:		/sys/bus/counter/devices/counterX/cascade_counts_enable
+KernelVersion:	6.4
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Indicates the cascading of Counts on Counter X.
+
+		Valid attribute values are boolean.
+
+What:		/sys/bus/counter/devices/counterX/external_input_phase_clock_select
+KernelVersion:	6.4
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Selects the external clock pin for phase counting mode of
+		Counter X.
+
+		MTCLKA-MTCLKB:
+			MTCLKA and MTCLKB pins are selected for the external
+			phase clock.
+
+		MTCLKC-MTCLKD:
+			MTCLKC and MTCLKD pins are selected for the external
+			phase clock.
+
+What:		/sys/bus/counter/devices/counterX/external_input_phase_clock_select_available
+KernelVersion:  6.4
+Contact:        linux-iio@vger.kernel.org
+Description:
+                Discrete set of available values for the respective device
+                configuration are listed in this file.
+
 What:		/sys/bus/counter/devices/counterX/countY/count
 KernelVersion:	5.2
 Contact:	linux-iio@vger.kernel.org
@@ -215,6 +245,8 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		This attribute indicates the number of overflows of count Y.
 
+What:		/sys/bus/counter/devices/counterX/cascade_counts_enable_component_id
+What:		/sys/bus/counter/devices/counterX/external_input_phase_clock_select_component_id
 What:		/sys/bus/counter/devices/counterX/countY/capture_component_id
 What:		/sys/bus/counter/devices/counterX/countY/ceiling_component_id
 What:		/sys/bus/counter/devices/counterX/countY/floor_component_id
-- 
2.25.1

