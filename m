Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F444505E70
	for <lists+linux-iio@lfdr.de>; Mon, 18 Apr 2022 21:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347666AbiDRTXz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Apr 2022 15:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347668AbiDRTXy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2022 15:23:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4784E32EFB
        for <linux-iio@vger.kernel.org>; Mon, 18 Apr 2022 12:21:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D72C860E0A
        for <linux-iio@vger.kernel.org>; Mon, 18 Apr 2022 19:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91ED5C385A1;
        Mon, 18 Apr 2022 19:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650309674;
        bh=M1tByr7zU6onOJijIzxftHivBdnr0cCoL/rMK4QFvnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dToA6+rKT2OAMN8FQpPHggE+pZVbAINWdqWjI8kUunBF1VjYRm5+25jz+XF2ZV+GE
         doN1SsrO2NHc2FdKLWRg0WSgBzajWiRPVsvvuGr1ZNLvXjYu7QjyBwbAFI4QPW8wy8
         h1w92u5ruhQXD7lthvcxocLCHAKsGmkKdY6Om94tSHDCeXbcEA+zK0DQ1Fzq7wR5Rl
         MXXlba6eTx9Xus4M+52MdqynhMFpVBYKF+BVPZ/0daCqG8KOHnMbK8B/Rv9fDrv+mq
         VR3DWjn5rLBZyl84RM09Py2cWeffr6wQsNDOcZ5q5wSo7DXG1wRx3VW0uL4ZQJNtrs
         C/mXCsqMgSgQA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 03/17] staging: iio: cdc: ad7746: Use explicit be24 handling.
Date:   Mon, 18 Apr 2022 20:28:53 +0100
Message-Id: <20220418192907.763933-4-jic23@kernel.org>
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

Change from fiddly local implementation of be24 to cpu endian conversion
by reading into a 3 byte buffer and using get_unaligned_be24()

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7746.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 71c709771676..1f510610ed32 100644
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
@@ -547,12 +544,12 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 
 		ret = i2c_smbus_read_i2c_block_data(chip->client,
 						    chan->address >> 8, 3,
-						    &chip->data.d8[1]);
+						    chip->data);
 
 		if (ret < 0)
 			goto out;
 
-		*val = (be32_to_cpu(chip->data.d32) & 0xFFFFFF) - 0x800000;
+		*val = get_unaligned_be24(chip->data) - 0x800000;
 
 		switch (chan->type) {
 		case IIO_TEMP:
-- 
2.35.3

