Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C125275F4
	for <lists+linux-iio@lfdr.de>; Sun, 15 May 2022 08:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbiEOGDy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 May 2022 02:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiEOGDy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 May 2022 02:03:54 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73E20BE3C;
        Sat, 14 May 2022 23:03:53 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,227,1647270000"; 
   d="scan'208";a="119707858"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 May 2022 15:03:52 +0900
Received: from localhost.localdomain (unknown [10.226.92.18])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id DA9A140065CE;
        Sun, 15 May 2022 15:03:49 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH v5 2/2] iio: adc: rzg2l_adc: Remove unnecessary channel check from rzg2l_adc_read_label()
Date:   Sun, 15 May 2022 07:03:36 +0100
Message-Id: <20220515060337.16513-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220515060337.16513-1-biju.das.jz@bp.renesas.com>
References: <20220515060337.16513-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Remove unnecessary channel check from rzg2l_adc_read_label(), as the
channel error handling is already done in probe(). Therefore no need to
validate at runtime.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4->v5:
 * No Change.
v3->v4:
 * No Change.
v2->v3:
 * Added Rb tag from Geert.
v2:
 * New patch
---
 drivers/iio/adc/rzg2l_adc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 7585144b9715..bee5f9861acb 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -260,9 +260,6 @@ static int rzg2l_adc_read_label(struct iio_dev *iio_dev,
 				const struct iio_chan_spec *chan,
 				char *label)
 {
-	if (chan->channel >= RZG2L_ADC_MAX_CHANNELS)
-		return -EINVAL;
-
 	return sysfs_emit(label, "%s\n", rzg2l_adc_channel_name[chan->channel]);
 }
 
-- 
2.25.1

