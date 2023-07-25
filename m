Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BB2761FEF
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jul 2023 19:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjGYRQe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Jul 2023 13:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjGYRQd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Jul 2023 13:16:33 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9060B1BE;
        Tue, 25 Jul 2023 10:16:32 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,230,1684767600"; 
   d="scan'208";a="174450727"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 26 Jul 2023 02:16:30 +0900
Received: from localhost.localdomain (unknown [10.226.92.3])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 54EB240565E3;
        Wed, 26 Jul 2023 02:16:27 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        George Mois <george.mois@analog.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 0/2] Use i2c_get_match_data() instead of device_get_match_data()
Date:   Tue, 25 Jul 2023 18:16:22 +0100
Message-Id: <20230725171624.331283-1-biju.das.jz@bp.renesas.com>
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

Use i2c_get_match_data() to get match data for I2C, ACPI and
DT-based matching instead of device_get_match_data() the one for
ACPI/DT-based matching.

This patch series is only compile tested.

v2->v3:
 * Added Rb tag from Geert for patch#1.
 * Added link to lore for Closes tag.
v1->v2:
 * Added patch#1 for fixing adxl313_i2c_id[] table.
 * Added Rb tag from Geert
 * Removed error check as all tables have data pointers.
 * retained Rb tag as the change is trivial.

Biju Das (2):
  iio: accel: adxl313: Fix adxl313_i2c_id[] table
  iio: accel: adxl313: Use i2c_get_match_data

 drivers/iio/accel/adxl313_i2c.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

-- 
2.25.1

