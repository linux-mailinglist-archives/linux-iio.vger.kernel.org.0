Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E73C550CA3
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jun 2022 20:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbiFSS7a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jun 2022 14:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237104AbiFSS7E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2022 14:59:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12449BC8E
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 11:59:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C48A9B80D6F
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 18:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548F9C3411D;
        Sun, 19 Jun 2022 18:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655665141;
        bh=9zB6ZNUuzguZMwP9ez3k87AjVwZYrR5ASmpyMQH2Mfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B03xBpNkJfOQ+cAGVfW7qKScfWx2Lht+5sUiVfZCYQNhyP+Y6R6Ut2VNG4h2aAARt
         KuTcvk6QIDOsSkFw1sUMVWaro4KO4wEUDAD3UnQm94c/prUlguBBXAzFEuHAy9gcrt
         S9GF1RS3x2nzfFlEi2926qZflDKQgWTIx4abpDb9mUBFM+ZwWHYm7KjTMEfzW9qZ8x
         iaH6RqQcOcbw8QTIMSW3GTZJAPXVC7+XlK3ASm33O/wX4cbaqMnTCkXp4ZbJUPX3W+
         5sbsqsxUxzdlf9VMt7x/u2eaWvODttXeKvQ183aT3+hmcl8elWbxMgbgCs+Y5SWp8y
         5SK7Shbq+dAXg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 03/17] staging: iio: cdc: ad7746: Use explicit be24 handling.
Date:   Sun, 19 Jun 2022 19:58:25 +0100
Message-Id: <20220619185839.1363503-4-jic23@kernel.org>
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

Chance from fiddly local implementation of be24 to cpu endian conversion
by reading into a 3 byte buffer and using get_unaligned_be24()

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7746.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 52b8957c19c9..9208fb179240 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -95,10 +95,7 @@ struct ad7746_chip_info {
 	u8	capdac[2][2];
 	s8	capdac_set;
 
-	union {
-		__be32 d32;
-		u8 d8[4];
-	} data ____cacheline_aligned;
+	u8 data[3] ____cacheline_aligned;
 };
 
 enum ad7746_chan {
@@ -546,13 +543,14 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 		/* Now read the actual register */
 
 		ret = i2c_smbus_read_i2c_block_data(chip->client,
-						    chan->address >> 8, 3,
-						    &chip->data.d8[1]);
+						    chan->address >> 8,
+						    sizeof(chip->data),
+						    chip->data);
 
 		if (ret < 0)
 			goto out;
 
-		*val = (be32_to_cpu(chip->data.d32) & 0xFFFFFF) - 0x800000;
+		*val = get_unaligned_be24(chip->data) - 0x800000;
 
 		switch (chan->type) {
 		case IIO_TEMP:
-- 
2.36.1

