Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EA3755027
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jul 2023 19:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjGPRwZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jul 2023 13:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGPRwZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jul 2023 13:52:25 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B09A19F;
        Sun, 16 Jul 2023 10:52:23 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,210,1684767600"; 
   d="scan'208";a="169303045"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Jul 2023 02:52:23 +0900
Received: from localhost.localdomain (unknown [10.226.92.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3CD1E400941A;
        Mon, 17 Jul 2023 02:52:19 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 0/4] Use i2c_get_match_data()
Date:   Sun, 16 Jul 2023 18:52:14 +0100
Message-Id: <20230716175218.130557-1-biju.das.jz@bp.renesas.com>
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
DT-based matching.

This patch series is only compile tested.

Biju Das (4):
  iio: accel: adxl355: Simplify probe()
  iio: accel: adxl313: Use i2c_get_match_data
  iio: potentiometer: mcp4531: Use i2c_get_match_data
  iio: potentiometer: mcp4018: Use i2c_get_match_data

 drivers/iio/accel/adxl313_i2c.c     |  4 ++--
 drivers/iio/accel/adxl355_i2c.c     | 15 +++------------
 drivers/iio/potentiometer/mcp4018.c |  4 ++--
 drivers/iio/potentiometer/mcp4531.c |  4 ++--
 4 files changed, 9 insertions(+), 18 deletions(-)

-- 
2.25.1

