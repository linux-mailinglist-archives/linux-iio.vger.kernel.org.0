Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65751468D2D
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 21:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbhLEUZm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 15:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbhLEUZl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 15:25:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B2FC061714
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 12:22:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01F966114F
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 20:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98CAC341C5;
        Sun,  5 Dec 2021 20:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638735733;
        bh=H6IgZIr/LrwS59h40zOjRvDfUWGymVjw/cheZiYjNA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JLP8HPNPo30JY7C1zXN0zhCRMc0nONjSRyM5YoHVbMXWAWBtrKcT2gOc1OfA2U7hN
         NU7VB2t/jXj9/EHhIHVBUswr6jjz8FrRceVQd79NYLncD6xtpp/koBMVPOcNW7MPs+
         3sqGmvMaB8B9WZ+A2IODkpF8KWMCDRlqSEUWom1cdpdSgWa6BgaTtgeINsOumffppL
         1R5PQ0UwTdnmTn5ooLjbXHLodJ2LjkVEy3j9JMku4EZ4NPu3jXAHFNgSqHFHhR9ihh
         iagWFRzfst1It62ye6tgfI7LGUpwM20zPVDD6g2Lzp8w9UgS4oysqMc0l1AowPuhYo
         xx7HESRMGY5KQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 03/17] staging:iio:adc:ad7280a: rename _read() to _read_reg()
Date:   Sun,  5 Dec 2021 20:26:56 +0000
Message-Id: <20211205202710.2847005-4-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205202710.2847005-1-jic23@kernel.org>
References: <20211205202710.2847005-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This avoids possible confusion with read back of the channel conversions.
These two types of reads are of difference sizes with resulting differences
in the data layout of the response from the hardware.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/adc/ad7280a.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index d169c8a7b5f1..4d866e5fe43c 100644
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
2.34.1

