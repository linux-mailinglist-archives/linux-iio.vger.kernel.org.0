Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805796F97F8
	for <lists+linux-iio@lfdr.de>; Sun,  7 May 2023 11:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjEGJSO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 May 2023 05:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjEGJSN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2023 05:18:13 -0400
X-Greylist: delayed 437 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 07 May 2023 02:18:11 PDT
Received: from frolo.macqel.be (smtp2.macqel.be [109.135.2.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12F3D100E8
        for <linux-iio@vger.kernel.org>; Sun,  7 May 2023 02:18:11 -0700 (PDT)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id 17673DF00B2; Sun,  7 May 2023 11:10:51 +0200 (CEST)
From:   Philippe De Muyter <Philippe.DeMuyter@macq.eu>
To:     linux-iio@vger.kernel.org
Cc:     Philippe De Muyter <phdm@macqel.be>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio: dac: ad5446: Add ID of compatible Texas Instruments i2c dac121c*
Date:   Sun,  7 May 2023 11:10:25 +0200
Message-Id: <1683450625-28789-1-git-send-email-Philippe.DeMuyter@macq.eu>
X-Mailer: git-send-email 1.7.10.4
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Philippe De Muyter <phdm@macqel.be>

The Texas Instruments DAC121C* chips are the I2C counterparts of
the DAC121S* SPI chips which are already supported by this ad5446 driver.

Add them to the compatible list.

Signed-off-by: Philippe De Muyter <phdm@macqel.be>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/dac/ad5446.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index aa3130b33456..b95c0ccbb796 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -587,6 +587,7 @@ static const struct i2c_device_id ad5446_i2c_ids[] = {
 	{"ad5602", ID_AD5602},
 	{"ad5612", ID_AD5612},
 	{"ad5622", ID_AD5622},
+	{"dac121", ID_AD5622}, /* 'ti,' is dropped by 'of_modalias_node' */
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ad5446_i2c_ids);
-- 
2.31.1

