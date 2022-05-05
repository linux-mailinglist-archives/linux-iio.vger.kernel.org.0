Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE7851C847
	for <lists+linux-iio@lfdr.de>; Thu,  5 May 2022 20:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384127AbiEESs4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 May 2022 14:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384728AbiEESsZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 May 2022 14:48:25 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23D5160A9F;
        Thu,  5 May 2022 11:40:46 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,201,1647270000"; 
   d="scan'208";a="118801306"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 May 2022 03:40:45 +0900
Received: from localhost.localdomain (unknown [10.226.92.72])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8CF0540061B1;
        Fri,  6 May 2022 03:40:41 +0900 (JST)
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
Subject: [PATCH v2 0/2] Add RZ/G2UL support
Date:   Thu,  5 May 2022 19:40:35 +0100
Message-Id: <20220505184037.511295-1-biju.das.jz@bp.renesas.com>
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

v1->v2:
 * Started using generic compatible for RZ/G2UL and added SoC specific validation
   for number of supported channels.

Biju Das (2):
  dt-bindings: iio: adc: Document Renesas RZ/G2UL ADC
  iio: adc: rzg2l_adc: Remove unnecessary check from
    rzg2l_adc_read_label()

 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 45 ++++++++++++++++---
 drivers/iio/adc/rzg2l_adc.c                   |  3 --
 2 files changed, 38 insertions(+), 10 deletions(-)

-- 
2.25.1

