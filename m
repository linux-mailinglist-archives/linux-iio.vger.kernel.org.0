Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167795275ED
	for <lists+linux-iio@lfdr.de>; Sun, 15 May 2022 08:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbiEOGDr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 May 2022 02:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiEOGDr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 May 2022 02:03:47 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47D59BE3C;
        Sat, 14 May 2022 23:03:45 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,227,1647270000"; 
   d="scan'208";a="119707854"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 May 2022 15:03:44 +0900
Received: from localhost.localdomain (unknown [10.226.92.18])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 7339240078C8;
        Sun, 15 May 2022 15:03:40 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH v5 0/2] Add RZ/G2UL ADC support
Date:   Sun, 15 May 2022 07:03:34 +0100
Message-Id: <20220515060337.16513-1-biju.das.jz@bp.renesas.com>
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

This patch series document ADC found on RZ/G2UL SoC and also removes
unnecessary channel check from rzg2l_adc_read_label().

v4->v5:
 * Removed redundant "type:object"
 * Added Rb tag from Krzysztof Kozlowski
v3->v4:
 * Removed unnecessary SoC specific reg description as it is
   equivalent to the logic used in reg.
 * Removed Items from reg.
v2->v3:
 * Added generic description for reg.
 * Improved schema validation by restricting both channel and reg to [0-1].
 * Added Rb tag from Geert.
v1->v2:
 * Started using generic compatible for RZ/G2UL and added SoC specific validation
   for number of supported channels.

Biju Das (2):
  dt-bindings: iio: adc: Document Renesas RZ/G2UL ADC
  iio: adc: rzg2l_adc: Remove unnecessary channel check from
    rzg2l_adc_read_label()

 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 28 ++++++++++++++++---
 drivers/iio/adc/rzg2l_adc.c                   |  3 --
 2 files changed, 24 insertions(+), 7 deletions(-)

-- 
2.25.1

