Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E985A4AB176
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 19:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbiBFS5X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 13:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbiBFS5W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 13:57:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7F3C043185
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 10:57:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71A4C611DF
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 18:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE879C340F0;
        Sun,  6 Feb 2022 18:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644173840;
        bh=ejcLV4jVVw5WMCYWTUfSLqUdo0SqfOfBY2MMf+PHf3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DkeqaueqrGlX1Tm79gWb/co9Jy6dUygVVUqH//lcIvtPEBZhvQTjOrSYzetrIbNfU
         oZE/hwi3Lc0W7xI76BFXE/p1AYJApFiX2YJt0QkwtgBiEgznF0Um1D5YGslmpBLV6h
         It9YGR5D6egYP65GM0EsNfdcy2KIKn7nf2oD7s3qGi47a+Fc+0u3ARDThAqSS6X0fZ
         KarygGLu59Um0EQgUBPV2KKOEbrjF5f/Z6IqbcguQXXNeNNHcOrbl6gZe8nHWH+2pa
         INxVyt9d82w+78dwVJeeC42A8b1Yc0MZ/HClj0uedFxRMsXtyp8xOvOrQfE5N5S1kB
         W095xddZx1bcA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Hennerich@vger.kernel.org, Michael <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 03/20] staging:iio:adc:ad7280a: rename _read() to _read_reg()
Date:   Sun,  6 Feb 2022 19:03:11 +0000
Message-Id: <20220206190328.333093-4-jic23@kernel.org>
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

This avoids possible confusion with read back of the channel conversions.
These two types of reads are of difference sizes with resulting differences
in the data layout of the response from the hardware.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 0f64b2fbfa7a..f1382666d2aa 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -224,8 +224,8 @@ static int ad7280_write(struct ad7280_state *st, unsigned int devaddr,
 	return spi_write(st->spi, &st->buf[0], 4);
 }
 
-static int ad7280_read(struct ad7280_state *st, unsigned int devaddr,
-		       unsigned int addr)
+static int ad7280_read_reg(struct ad7280_state *st, unsigned int devaddr,
+			   unsigned int addr)
 {
 	int ret;
 	unsigned int tmp;
@@ -476,8 +476,8 @@ static ssize_t ad7280_show_balance_timer(struct device *dev,
 	unsigned int msecs;
 
 	mutex_lock(&st->lock);
-	ret = ad7280_read(st, this_attr->address >> 8,
-			  this_attr->address & 0xFF);
+	ret = ad7280_read_reg(st, this_attr->address >> 8,
+			      this_attr->address & 0xFF);
 	mutex_unlock(&st->lock);
 
 	if (ret < 0)
-- 
2.35.1

