Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C9B4EA034
	for <lists+linux-iio@lfdr.de>; Mon, 28 Mar 2022 21:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344128AbiC1Tv2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Mar 2022 15:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345650AbiC1TuE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2022 15:50:04 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B437AB81
        for <linux-iio@vger.kernel.org>; Mon, 28 Mar 2022 12:47:45 -0700 (PDT)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 0662A83F80;
        Mon, 28 Mar 2022 21:47:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1648496863;
        bh=7tY0ha+1QWNAevFoHt4t0iGCtqJfuL+5IsRyro8fOA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LsrSBDELwMg3ZN0O4ZuXKum+ZeXEt4gDqmuBecNyNkegXpxhKZXh8Vc/e39YJdFAJ
         rLeYK5dyYWuj9dmglsb5A3rfETrdT0nBrehNXVE8YH1125d24F0RfFIPC4Je3MDBiT
         GOhV2gn47q8NUUraul0YGTOiIF7Cg7nVralo1azgeh8DTQs4NMWkP4PlbeIN9mwz0N
         12ILb16qbFQjeAcDte8uEyQ2gjXsK6pXHs6V1/WcpgnBMqMx5uVGKIv0GrHMk3xHvo
         q5AKO2B0uzLuxsTmQ7h60QqNV9S5W7RMrGsHwILTuZ/HC4X58GT01AmFieSmGvxoFi
         a3g8tqAftSDvQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Andy Shevchenko <andy@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 03/10] iio: adc: ti-ads1015: Switch to static const writeable ranges table
Date:   Mon, 28 Mar 2022 21:47:18 +0200
Message-Id: <20220328194725.149150-3-marex@denx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328194725.149150-1-marex@denx.de>
References: <20220328194725.149150-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Switch the driver from code implementing test whether a regmap register
is writeable to static const tables describing the test. No functional
change.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
V2: No change
V3: No change
V4: No change
V5: No change
---
 drivers/iio/adc/ti-ads1015.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 068efbce17103..85932b9dc166a 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -273,23 +273,20 @@ static void ads1015_event_channel_disable(struct ads1015_data *data, int chan)
 	data->event_channel = ADS1015_CHANNELS;
 }
 
-static bool ads1015_is_writeable_reg(struct device *dev, unsigned int reg)
-{
-	switch (reg) {
-	case ADS1015_CFG_REG:
-	case ADS1015_LO_THRESH_REG:
-	case ADS1015_HI_THRESH_REG:
-		return true;
-	default:
-		return false;
-	}
-}
+static const struct regmap_range ads1015_writeable_ranges[] = {
+	regmap_reg_range(ADS1015_CFG_REG, ADS1015_HI_THRESH_REG),
+};
+
+static const struct regmap_access_table ads1015_writeable_table = {
+	.yes_ranges = ads1015_writeable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ads1015_writeable_ranges),
+};
 
 static const struct regmap_config ads1015_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 16,
 	.max_register = ADS1015_HI_THRESH_REG,
-	.writeable_reg = ads1015_is_writeable_reg,
+	.wr_table = &ads1015_writeable_table,
 };
 
 static const struct iio_chan_spec ads1015_channels[] = {
-- 
2.35.1

