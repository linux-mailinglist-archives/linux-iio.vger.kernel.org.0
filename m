Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01DB637DE7
	for <lists+linux-iio@lfdr.de>; Thu, 24 Nov 2022 18:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKXRAh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Nov 2022 12:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiKXRAg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Nov 2022 12:00:36 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C68E9E6372;
        Thu, 24 Nov 2022 09:00:35 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,190,1665414000"; 
   d="scan'208";a="141114782"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 Nov 2022 02:00:34 +0900
Received: from localhost.localdomain (unknown [10.226.92.56])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id B5498409781B;
        Fri, 25 Nov 2022 02:00:32 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v7 3/5] Documentation: ABI: sysfs-bus-counter: add cascade_enable and external_input_phase_clock_select
Date:   Thu, 24 Nov 2022 17:00:16 +0000
Message-Id: <20221124170018.3150687-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124170018.3150687-1-biju.das.jz@bp.renesas.com>
References: <20221124170018.3150687-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This commit adds cascade_enable and external_input_phase_clock_
select items to counter ABI file.
(e.g. for Renesas MTU3 hardware used for phase counting).

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v6->v7:
 * Replaced long_word_access_ctrl_mode->cascade_enable
 * Updated Kernel version
v5->v6:
 * No change
v5:
 * New patch
---
 Documentation/ABI/testing/sysfs-bus-counter | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index ff83320b4255..abc691b13b0f 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -215,6 +215,22 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		This attribute indicates the number of overflows of count Y.
 
+What:		/sys/bus/counter/devices/counterX/cascade_enable
+KernelVersion:	6.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute indicates the cascading of counts on
+		counter X.
+
+What:		/sys/bus/counter/devices/counterX/external_input_phase_clock_select
+KernelVersion:	6.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute selects the external clock pin for phase
+		counting mode of counter X.
+
+What:		/sys/bus/counter/devices/counterX/cascade_enable
+What:		/sys/bus/counter/devices/counterX/external_input_phase_clock_select
 What:		/sys/bus/counter/devices/counterX/countY/capture_component_id
 What:		/sys/bus/counter/devices/counterX/countY/ceiling_component_id
 What:		/sys/bus/counter/devices/counterX/countY/floor_component_id
-- 
2.25.1

