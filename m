Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CA03A655C
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 13:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbhFNLhe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 07:37:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235433AbhFNLf2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Jun 2021 07:35:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 136A561206;
        Mon, 14 Jun 2021 11:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623670406;
        bh=VgWxuagrhIzXlgSd+SF6Amipzgfu4PZ6XBtZ2frRAAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AAux309Xg0W0SrLmK0W7XnHDG9kR9GjT+2ELrubrWfj/fP03v05KPX28bdGeOpyXU
         bbbtPjKBX4HioPz+35JHjbK5XlEW14+wIylxL+68rhey6NwsVknoy1R56ItkEIy4nr
         g6/CxN0bpV0lpZwu/KLEo3nFg2pgIpZYTBLk6e8rEz8skZg1lMpHPW9IsejN8I/fpt
         sr/8yFHuFfjQSb4gVVh8UMr7W6LT8nH4T/nvvqdP7hTJaFdGtltGYLA1WEC21vs9OI
         EmNEqfhY+uDf1Pnt5pH98vl9Wzwq+cmVLWpUYuhV4cgEAhA16toi97L6pvO7LLafbb
         Q/TN4V1fXvRWg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Michael.Hennerich@analog.com, lars@metafoo.de,
        devicetree@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 03/17] staging:iio:adc:ad7280a: rename _read() to _read_reg()
Date:   Mon, 14 Jun 2021 12:34:53 +0100
Message-Id: <20210614113507.897732-4-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614113507.897732-1-jic23@kernel.org>
References: <20210614113507.897732-1-jic23@kernel.org>
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
2.32.0

