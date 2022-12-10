Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF96648E22
	for <lists+linux-iio@lfdr.de>; Sat, 10 Dec 2022 11:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiLJKV3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Dec 2022 05:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiLJKV2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Dec 2022 05:21:28 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F21A422BC4;
        Sat, 10 Dec 2022 02:21:27 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,232,1665414000"; 
   d="scan'208";a="142891653"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 10 Dec 2022 19:21:27 +0900
Received: from localhost.localdomain (unknown [10.226.92.39])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 926424007207;
        Sat, 10 Dec 2022 19:21:25 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v8 3/5] Documentation: ABI: sysfs-bus-counter: add cascade_counts_enable and external_input_phase_clock_select
Date:   Sat, 10 Dec 2022 10:21:08 +0000
Message-Id: <20221210102110.443043-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221210102110.443043-1-biju.das.jz@bp.renesas.com>
References: <20221210102110.443043-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This commit adds cascade_counts_enable and external_input_phase_
clock_select items to counter ABI file.
(e.g. for Renesas MTU3 hardware used for phase counting).

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
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
 Documentation/ABI/testing/sysfs-bus-counter | 25 +++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index ff83320b4255..2e7a25010c84 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -60,6 +60,20 @@ Description:
 			counter does not freeze at the boundary points, but
 			counts continuously throughout.
 
+What:		/sys/bus/counter/devices/counterX/external_input_phase_clock_select
+KernelVersion:	6.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute selects the external clock pin for phase
+		counting mode of counter X.
+
+		MTCLKA-MTCLKB:
+			MTCLKA and MTCLKB pins are selected for the external phase clock.
+
+		MTCLKC-MTCLKD:
+			MTCLKC and MTCLKD pins are selected for the external phase clock.
+
+What:		/sys/bus/counter/devices/counterX/external_input_phase_clock_select_available
 What:		/sys/bus/counter/devices/counterX/countY/count_mode_available
 What:		/sys/bus/counter/devices/counterX/countY/error_noise_available
 What:		/sys/bus/counter/devices/counterX/countY/function_available
@@ -215,6 +229,17 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		This attribute indicates the number of overflows of count Y.
 
+What:		/sys/bus/counter/devices/counterX/cascade_counts_enable
+KernelVersion:	6.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute indicates the cascading of counts on
+		counter X.
+
+		Valid attribute values are boolean.
+
+What:		/sys/bus/counter/devices/counterX/cascade_counts_enable_component_id
+What:		/sys/bus/counter/devices/counterX/external_input_phase_clock_select_component_id
 What:		/sys/bus/counter/devices/counterX/countY/capture_component_id
 What:		/sys/bus/counter/devices/counterX/countY/ceiling_component_id
 What:		/sys/bus/counter/devices/counterX/countY/floor_component_id
-- 
2.25.1

