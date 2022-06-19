Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D711F550CA2
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jun 2022 20:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbiFSS7a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jun 2022 14:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbiFSS7J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2022 14:59:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21F5BC8E
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 11:59:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B26C4B80D8A
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 18:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B09CC341C5;
        Sun, 19 Jun 2022 18:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655665146;
        bh=3bwFemkWq2haeU1AshbnuknRT3BiXvwc87U0N/EdPpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=khB/6J7ueL3eLqwYe4xIYKQzuV4bqiduHY2KC2Z1IRutbTqpoSLlCWKt5/1TxVIwO
         37SuThRY2MUyIySjTdZz4UptXbdmZ2BniT2OyRq7xhwbSWojVyJIm88tqGGucWIdRt
         s9vFKcmqBdmwHdNv0Tq2hdwOyIh+4FjkaYleED6k40PdT6dU2g7bqyB4c70Bn0Glit
         D/wpqgGM2hgMGB9MYITW+KHQW/N1/p1FmtMiWxRQD65xsZJsP0KvD8VW74T0K7iDHc
         wzQIj+s2vCSP7vGAryAafzAU/mTw+oJbQzvAsRtP2iq7/hOyUTtV2byPRmZRBobxpn
         aVtrJXeGvUBcw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 05/17] staging: iio: cdc: ad7746: Use local buffer for multi byte reads.
Date:   Sun, 19 Jun 2022 19:58:27 +0100
Message-Id: <20220619185839.1363503-6-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220619185839.1363503-1-jic23@kernel.org>
References: <20220619185839.1363503-1-jic23@kernel.org>
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
 drivers/staging/iio/cdc/ad7746.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index df12fdb20662..f909b841c4d6 100644
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
 
@@ -544,11 +543,10 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 						    chan->address >> 8,
 						    sizeof(chip->data),
 						    chip->data);
-
 		if (ret < 0)
 			goto out;
 
-		*val = get_unaligned_be24(chip->data) - 0x800000;
+		*val = get_unaligned_be24(data) - 0x800000;
 
 		switch (chan->type) {
 		case IIO_TEMP:
-- 
2.36.1

