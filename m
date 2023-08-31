Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E179378F288
	for <lists+linux-iio@lfdr.de>; Thu, 31 Aug 2023 20:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345659AbjHaSZS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 31 Aug 2023 14:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjHaSZR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 31 Aug 2023 14:25:17 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4B6E64
        for <linux-iio@vger.kernel.org>; Thu, 31 Aug 2023 11:25:15 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id ABFA386519;
        Thu, 31 Aug 2023 20:25:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693506314;
        bh=7zQaZPQRX44ILenVnmbNt2Gw9dibs84cyDQM35s65dI=;
        h=From:To:Cc:Subject:Date:From;
        b=AZMJAF+p9zqXKEfjexOERu80ZaiDElLpFiF1Qb3ffgGy2iqI++KmCEhVd0IWE6/Xp
         XGgGBgC5nbxRw2b55OicZDf/x/qTeg0xV5ImVBxgeZmcvVUnIO2laVyRndgEKSQvb1
         US3BX13Rq5gbhMUGZ7234FKNN6jhEQeLFA6VSgtMHnFawYf/R1LXqN1HvlQ6JqPANK
         i5ByVxT0gVq/57WLiYcKCq9YSI7IhzBUZIdNSBn693GCH6uvtDkEeT8t3nFu4qxRLD
         WllAqvEFymHVwKXdpfVFtzr3EeHG0ikA+aUdt4KngDr6cP3RHqbCKjQC1m30hrJ4SG
         ZviA/6jVstOgw==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: adc: ti-ads1015: Add edge trigger support
Date:   Thu, 31 Aug 2023 20:25:02 +0200
Message-Id: <20230831182502.154899-1-marex@denx.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The comparator generates an edge on the IRQ like and stays in the
configured state until cleared. Support edge triggered IRQs as well
as not all controllers do support level triggered IRQ.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/adc/ti-ads1015.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 075c75a875449..addee45ed40ad 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -1047,11 +1047,13 @@ static int ads1015_probe(struct i2c_client *client)
 			1 << ADS1015_CFG_COMP_LAT_SHIFT;
 
 		switch (irq_trig) {
+		case IRQF_TRIGGER_FALLING:
 		case IRQF_TRIGGER_LOW:
 			cfg_comp |= ADS1015_CFG_COMP_POL_LOW <<
 					ADS1015_CFG_COMP_POL_SHIFT;
 			break;
 		case IRQF_TRIGGER_HIGH:
+		case IRQF_TRIGGER_RISING:
 			cfg_comp |= ADS1015_CFG_COMP_POL_HIGH <<
 					ADS1015_CFG_COMP_POL_SHIFT;
 			break;
-- 
2.40.1

