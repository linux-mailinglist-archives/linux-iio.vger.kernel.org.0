Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4A14AB17C
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 19:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiBFS5k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 13:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242266AbiBFS5j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 13:57:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57553C043184
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 10:57:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCE81611DF
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 18:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A4CC340F0;
        Sun,  6 Feb 2022 18:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644173858;
        bh=ucd1A9f7bU/wcYNlB8pv/IHlzmDDFO7I3YH4onpMHpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hFoob4ENH1De2gbPv4cZZboxTr8IMsn7ZhMnq1VYqtaHBbMFaFCRbY/fppn+UW9X2
         NHnhnm0uS6AGQWctHr1PmRGAHg5B6bVUsxLOZoa76oPbZ940VEvLHCPmGixBgGn61M
         0lYAeNMAUyPqkwpIYREIxVgwsGyj48fy+ut7XUgkm2UZb3dW9+SXQckyVz7Q7nHQ4X
         3IZFayIfDkAHFFU44KxiT1A/WVIfpaVURW1D4l4m4NlIQG6A+ViB7mO7P04gpEMeaK
         UfvV4LkaAsvzJjn43FeP70vR/DG9C5/50aaTs6OcKasF299WkoTQXb8ktXPhvmL7f9
         yA2+lRoau+V+w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Hennerich@vger.kernel.org, Michael <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 09/20] staging:iio:adc:ad7280a: Trivial comment formatting cleanup
Date:   Sun,  6 Feb 2022 19:03:17 +0000
Message-Id: <20220206190328.333093-10-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220206190328.333093-1-jic23@kernel.org>
References: <20220206190328.333093-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

IIO uses the
/*
 * stuff
 * more stuff
 */

multi-line style, so use that here as well.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index c1ac46a8112e..e32526fbed5a 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -139,9 +139,10 @@ static unsigned int ad7280a_devaddr(unsigned int addr)
 	       ((addr & 0x10) >> 4);
 }
 
-/* During a read a valid write is mandatory.
- * So writing to the highest available address (Address 0x1F)
- * and setting the address all parts bit to 0 is recommended
+/*
+ * During a read a valid write is mandatory.
+ * So writing to the highest available address (Address 0x1F) and setting the
+ * address all parts bit to 0 is recommended.
  * So the TXVAL is AD7280A_DEVADDR_ALL + CRC
  */
 #define AD7280A_READ_TXVAL	0xF800030A
@@ -180,7 +181,7 @@ static unsigned char ad7280_calc_crc8(unsigned char *crc_tab, unsigned int val)
 	crc = crc_tab[val >> 16 & 0xFF];
 	crc = crc_tab[crc ^ (val >> 8 & 0xFF)];
 
-	return  crc ^ (val & 0xFF);
+	return crc ^ (val & 0xFF);
 }
 
 static int ad7280_check_crc(struct ad7280_state *st, unsigned int val)
@@ -193,12 +194,12 @@ static int ad7280_check_crc(struct ad7280_state *st, unsigned int val)
 	return 0;
 }
 
-/* After initiating a conversion sequence we need to wait until the
- * conversion is done. The delay is typically in the range of 15..30 us
- * however depending an the number of devices in the daisy chain and the
- * number of averages taken, conversion delays and acquisition time options
- * it may take up to 250us, in this case we better sleep instead of busy
- * wait.
+/*
+ * After initiating a conversion sequence we need to wait until the conversion
+ * is done. The delay is typically in the range of 15..30us however depending on
+ * the number of devices in the daisy chain, the number of averages taken,
+ * conversion delays and acquisition time options it may take up to 250us, in
+ * this case we better sleep instead of busy wait.
  */
 
 static void ad7280_delay(struct ad7280_state *st)
-- 
2.35.1

