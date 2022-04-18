Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B83505E71
	for <lists+linux-iio@lfdr.de>; Mon, 18 Apr 2022 21:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347669AbiDRTYC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Apr 2022 15:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347670AbiDRTYB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2022 15:24:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4AE35862
        for <linux-iio@vger.kernel.org>; Mon, 18 Apr 2022 12:21:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CAECB8105F
        for <linux-iio@vger.kernel.org>; Mon, 18 Apr 2022 19:21:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187EFC385A1;
        Mon, 18 Apr 2022 19:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650309678;
        bh=UlYg/e/6eH/JDXpxBmVlPSaAqcvK/301oJ5fVBiYHFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V7sH1l/Djh6c34eseRRWqiKRU1N1uX0ZQvGYBygaeA0ZKtBW+KfsN9Htsi4IXp/u1
         pJOgaKFzI69O4sy+DdH3KUliO79oQIeBoMemdwEJ0B+Mw9RxKf9QJSNocxWGA9McoM
         1ll8E6jDfAkmWQU5mos9NtL5b7YBoYmBBw1Vd04vP0p1wYBPCXnQTdIeHO4qV9O2kl
         qBx7Jd8duUEl9Pg12IWz1OnxKNYi6m6HdGsRLUu0mMQZollcFVUBC/xl8rgXsE6/Kz
         Wfy6QMh4Zuud5aU4Hsg1y8zrOu7HcG6tGHPF9TyZYNlHyzEZQwCpSOFOq5lvW+Ngaq
         m9hdj6/68rhLA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 05/17] staging: iio: cdc: ad7746: Use local buffer for multi byte reads.
Date:   Mon, 18 Apr 2022 20:28:55 +0100
Message-Id: <20220418192907.763933-6-jic23@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220418192907.763933-1-jic23@kernel.org>
References: <20220418192907.763933-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7746.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 1379caf88b83..e4b882586891 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -94,8 +94,6 @@ struct ad7746_chip_info {
 	u8	vt_setup;
 	u8	capdac[2][2];
 	s8	capdac_set;
-
-	u8 data[3] ____cacheline_aligned;
 };
 
 enum ad7746_chan {
@@ -520,6 +518,7 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 	struct ad7746_chip_info *chip = iio_priv(indio_dev);
 	int ret, delay, idx;
 	u8 regval, reg;
+	u8 data[3];
 
 	mutex_lock(&chip->lock);
 
@@ -542,12 +541,12 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 
 		ret = i2c_smbus_read_i2c_block_data(chip->client,
 						    chan->address >> 8, 3,
-						    chip->data);
+						    data);
 
 		if (ret < 0)
 			goto out;
 
-		*val = get_unaligned_be24(chip->data) - 0x800000;
+		*val = get_unaligned_be24(data) - 0x800000;
 
 		switch (chan->type) {
 		case IIO_TEMP:
-- 
2.35.3

