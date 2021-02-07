Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99D5312593
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 16:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhBGPub (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 10:50:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229684AbhBGPu0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Feb 2021 10:50:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C280D64E62;
        Sun,  7 Feb 2021 15:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612712951;
        bh=Ky8I7DTWX1mCUv4cS7FiIiJSFZ8MtNwWTdIInWwTju8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WaBoxJtzAGKbpVQIAAhR2qB20ZQfZumqxBzazRd9bcfT5/4+RXfnycNZHr1Kkkjif
         0Q1G2i0JGZg/4M5P0IqC9BcpXqK1PsBEd2XVfOYzFb2eR25oiilnEbrD6580moP7Nc
         rq4OKuH2Is640UP8ILEjQKT1kBd7hr6ryVG9DuOui6v8Kk/fkeIhVToGWzoiUEqygO
         3ltakfm4G+S7e5TYY+z65fbljS9oiymnHziiRt2TSzdtxhLXzurcEKDNw81Cs5s8Iu
         3L1MGiMsSraaNTdQh263YREZZCLHa0B6K12sjXtj6B6iedUgdOLJpsdVWBHp9tpIbF
         SvnKu0ltRciCQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        song.bao.hua@hisilicon.com, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 19/24] staging:iio:cdc:ad7150: Really basic regulator support.
Date:   Sun,  7 Feb 2021 15:46:18 +0000
Message-Id: <20210207154623.433442-20-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210207154623.433442-1-jic23@kernel.org>
References: <20210207154623.433442-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Given DT docs will include regulators, lets just turn them on and
off with driver probe() and remove().

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7150.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index a2aae370c231..0bc8c7a99883 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -12,6 +12,7 @@
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
 #include <linux/iio/iio.h>
@@ -538,11 +539,19 @@ static const struct iio_info ad7150_info_no_irq = {
 	.read_raw = &ad7150_read_raw,
 };
 
+static void ad7150_reg_disable(void *data)
+{
+	struct regulator *reg = data;
+
+	regulator_disable(reg);
+}
+
 static int ad7150_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct ad7150_chip_info *chip;
 	struct iio_dev *indio_dev;
+	struct regulator *reg;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
@@ -557,6 +566,18 @@ static int ad7150_probe(struct i2c_client *client,
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	reg = devm_regulator_get(&client->dev, "vdd");
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	ret = regulator_enable(reg);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&client->dev, ad7150_reg_disable, reg);
+	if (ret)
+		return ret;
+
 	chip->interrupts[0] = fwnode_irq_get(dev_fwnode(&client->dev), 0);
 	if (chip->interrupts[0] < 0)
 		return chip->interrupts[0];
-- 
2.30.0

