Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE4B55B1D4
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jun 2022 14:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbiFZMUe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 08:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbiFZMUd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 08:20:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9025E02C
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 05:20:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5884D61219
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 12:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE32C341CB;
        Sun, 26 Jun 2022 12:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656246031;
        bh=96TXCzyiYKTwF4m0QpBlvJhe2WaGCKcB+8yfNYp8d5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XAa9LS4LnQJlLoi9lInGd5xUcIQm94MvTAABH4oA0Sz4Z95vk7vUXe6AtNjInnv8a
         XoibfGY2GGcFll61tYzKa3iNOAAPQ/d901pGCp/2i+8tdbA66MaoGTZAJ7Qwo7jLFC
         VuFW8l/bBQr5UjqIp0Youc3GROAoirqiJZ7rmU3HwKIHrd2tsvtS+DCrvZPShjGaco
         hpYf8mPWKcTq3juhh6XHmjM/ToG1n2p6uXw4NqqRmmG+pmIYmE69i+kQkjnBvRIt5e
         kFMtVy3zHnf9lJKZPasSbHvRVlziWs5idFg/ivlqf1wlujxHojtEUtSqvfzG81LLP3
         oxuwTj80r0vLA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 05/17] staging: iio: cdc: ad7746: Use local buffer for multi byte reads.
Date:   Sun, 26 Jun 2022 13:29:26 +0100
Message-Id: <20220626122938.582107-6-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220626122938.582107-1-jic23@kernel.org>
References: <20220626122938.582107-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I2C does not require DMA safe buffers so there is no need to ensure
the buffers are in their own cacheline. Hence simplify things by
using a local variable instead of embedding the buffer in the chip
info structure.

Includes a trivial whitespace cleanup to drop a line between function
and error handling.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7746.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 0b5cb788abee..496e90f559c7 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -96,8 +96,6 @@ struct ad7746_chip_info {
 	u8	vt_setup;
 	u8	capdac[2][2];
 	s8	capdac_set;
-
-	u8 data[3] ____cacheline_aligned;
 };
 
 enum ad7746_chan {
@@ -522,6 +520,7 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 	struct ad7746_chip_info *chip = iio_priv(indio_dev);
 	int ret, delay, idx;
 	u8 regval, reg;
+	u8 data[3];
 
 	mutex_lock(&chip->lock);
 
@@ -544,13 +543,11 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 
 		ret = i2c_smbus_read_i2c_block_data(chip->client,
 						    chan->address >> 8,
-						    sizeof(chip->data),
-						    chip->data);
-
+						    sizeof(data), data);
 		if (ret < 0)
 			goto out;
 
-		*val = get_unaligned_be24(chip->data) - 0x800000;
+		*val = get_unaligned_be24(data) - 0x800000;
 
 		switch (chan->type) {
 		case IIO_TEMP:
-- 
2.36.1

