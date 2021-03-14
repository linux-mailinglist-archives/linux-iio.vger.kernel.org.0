Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5604B33A777
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 19:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbhCNSSU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 14:18:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234015AbhCNSSC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 14:18:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04A2D64EC4;
        Sun, 14 Mar 2021 18:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615745882;
        bh=99z4MoK2Ks8VbYq0nWMzO2heDTN4y0i1IqoIFe+ejJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DpQmXLJWi/WFreSFzoM1iBoLcBPDdGjR8enBVFKZR8E4sXFe81dbrq0idL8DJ31Bt
         hWBKPbynAI3ax0eX8uIaUlXUGXQbr4ZdaQGWg8VH11UaF0T9YFJR/hYj2OD8Y+/tzp
         AYqZ+ATAI9/Ff+du0dZh9LRqoBwFzYpTNIMGHfnEVyQHvfyYGDfOYTu0CrxFLKwKd3
         xEuhVTMljeSe5uPwLsKVAIVzLhH0MJEx4y65OgPHVZirqwOiQJSW3AWSwfsAuIGtad
         GO4kUYWcJYtaM42INFS/OW77jH3+MfYXR/x7Lp/jsbxQYdTuRYfW52IxboYhtTgQvn
         6AliW+AmrGdlQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>, Robh+dt@kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 20/24] staging:iio:cdc:ad7150: Add of_match_table
Date:   Sun, 14 Mar 2021 18:15:07 +0000
Message-Id: <20210314181511.531414-21-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314181511.531414-1-jic23@kernel.org>
References: <20210314181511.531414-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Rather than using the fallback path in the i2c subsystem and hoping
for no clashes across vendors, lets put in an explicit table for
matching.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://lore.kernel.org/r/20210207154623.433442-21-jic23@kernel.org
---
 drivers/staging/iio/cdc/ad7150.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 30abfacda074..0afad49bcddc 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -12,6 +12,7 @@
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
@@ -655,9 +656,16 @@ static const struct i2c_device_id ad7150_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, ad7150_id);
 
+static const struct of_device_id ad7150_of_match[] = {
+	{ "adi,ad7150" },
+	{ "adi,ad7151" },
+	{ "adi,ad7156" },
+	{}
+};
 static struct i2c_driver ad7150_driver = {
 	.driver = {
 		.name = "ad7150",
+		.of_match_table = ad7150_of_match,
 	},
 	.probe = ad7150_probe,
 	.id_table = ad7150_id,
-- 
2.30.2

