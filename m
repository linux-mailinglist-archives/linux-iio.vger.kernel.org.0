Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF3160FACC
	for <lists+linux-iio@lfdr.de>; Thu, 27 Oct 2022 16:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbiJ0OtR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Oct 2022 10:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235862AbiJ0OtC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Oct 2022 10:49:02 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FDC7B87A8;
        Thu, 27 Oct 2022 07:49:01 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.95,217,1661785200"; 
   d="scan'208";a="140606123"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 27 Oct 2022 23:49:01 +0900
Received: from localhost.localdomain (unknown [10.226.93.45])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1B8E5430E052;
        Thu, 27 Oct 2022 23:48:58 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v5 3/5] Documentation: ABI: sysfs-bus-counter: add external_input_phase_clock_select & long_word_access_ctrl_mode items
Date:   Thu, 27 Oct 2022 15:48:42 +0100
Message-Id: <20221027144844.85149-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221027144844.85149-1-biju.das.jz@bp.renesas.com>
References: <20221027144844.85149-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This commit adds external_input_phase_clock_select and long_word_
access_ctrl_mode items to counter ABI file.
(e.g. for Renesas MTU3 hardware used for phase counting).

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v5:
 * New patch
---
 Documentation/ABI/testing/sysfs-bus-counter | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index ff83320b4255..2880f3b346e2 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -215,6 +215,22 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		This attribute indicates the number of overflows of count Y.
 
+What:		/sys/bus/counter/devices/counterX/external_input_phase_clock_select
+KernelVersion:	6.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute selects the external clock pin for phase
+		counting mode of counter X.
+
+What:		/sys/bus/counter/devices/counterX/long_word_access_ctrl_mode
+KernelVersion:	6.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute indicates the 16-bit or 32 bit-access of
+		counter X.
+
+What:		/sys/bus/counter/devices/counterX/external_input_phase_clock_select
+What:		/sys/bus/counter/devices/counterX/long_word_access_ctrl_mode
 What:		/sys/bus/counter/devices/counterX/countY/capture_component_id
 What:		/sys/bus/counter/devices/counterX/countY/ceiling_component_id
 What:		/sys/bus/counter/devices/counterX/countY/floor_component_id
-- 
2.25.1

