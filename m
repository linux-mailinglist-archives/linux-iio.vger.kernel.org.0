Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079D055B1D8
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jun 2022 14:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbiFZMUa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 08:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbiFZMU2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 08:20:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11579E029
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 05:20:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0BCB6120E
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 12:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D81FC34114;
        Sun, 26 Jun 2022 12:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656246027;
        bh=TCPDHk7sO2AWTGtftRHe5Y5e04Cdwl+XsrtaDMY0a5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MawP/Jzo3PHSWFEOpVCuCSvpOA81VZVvyccm61So3p4MEQJmnnaRwhoRSZALL381s
         d9zjNsCyVp45SD0qOKfVffEpbOMwwXB607YPkNUepa13FvVxhz8o+wYvrvjOAzQrlv
         XVdvEx70aBxEGbCJkvpBMt1Nm19qYbNmIQwAm15TETWtWGgJqfBkIgSYxbfgPGCVRm
         zmX5aEKB0AVRgdKKZreUstnw6Bj2lGnzbz1XmMUQ27tZN1VJvkJmmpsnSefxiVAiXr
         T8JT2+wOOwn4Gx79JZF835eeIzDPT2IBkOubYfBj/iKzZhnU/kmcSf6cBXjEN+Kr6z
         Kx/uVCYZ6jZ7A==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 03/17] staging: iio: cdc: ad7746: Use explicit be24 handling.
Date:   Sun, 26 Jun 2022 13:29:24 +0100
Message-Id: <20220626122938.582107-4-jic23@kernel.org>
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

Chance from fiddly local implementation of be24 to cpu endian conversion
by reading into a 3 byte buffer and using get_unaligned_be24()

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7746.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 52b8957c19c9..08f73be5797a 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -15,6 +15,8 @@
 #include <linux/stat.h>
 #include <linux/sysfs.h>
 
+#include <asm/unaligned.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
@@ -95,10 +97,7 @@ struct ad7746_chip_info {
 	u8	capdac[2][2];
 	s8	capdac_set;
 
-	union {
-		__be32 d32;
-		u8 d8[4];
-	} data ____cacheline_aligned;
+	u8 data[3] ____cacheline_aligned;
 };
 
 enum ad7746_chan {
@@ -546,13 +545,14 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
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

