Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F5C7806BC
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 09:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358381AbjHRH4v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 03:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358470AbjHRH4n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 03:56:43 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B8DD4202;
        Fri, 18 Aug 2023 00:56:16 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,182,1684767600"; 
   d="scan'208";a="176955307"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 18 Aug 2023 16:56:06 +0900
Received: from localhost.localdomain (unknown [10.226.93.81])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 197A241BBD56;
        Fri, 18 Aug 2023 16:56:02 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 0/5] OF/ACPI/ID Match table improvements for ak8975 driver
Date:   Fri, 18 Aug 2023 08:55:55 +0100
Message-Id: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch series aims to improve OF/ACPI/ID Match table improvements for
ak8975 driver.
 * Converting enum->pointer for data in the match tables saves code
   meory in probe()
 * Sort OF, ID and ACPI tables for easy maintanance
 * Dropping deprecated enums from bindings and driver for saving memory.

This patch series is only compile tested.

Biju Das (5):
  iio: magnetometer: ak8975: Convert enum->pointer for data in the match
    tables
  iio: magnetometer: ak8975: Sort ID and ACPI tables
  dt-bindings: iio: magnetometer: asahi-kasei,ak8975: Drop deprecated
    enums
  iio: magnetometer: ak8975: Drop deprecated enums from OF table
  iio: magnetometer: ak8975: Sort OF table

 .../iio/magnetometer/asahi-kasei,ak8975.yaml  |  7 --
 drivers/iio/magnetometer/ak8975.c             | 81 +++++++------------
 2 files changed, 30 insertions(+), 58 deletions(-)

-- 
2.25.1

