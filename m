Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C938D312597
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 16:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhBGPuw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 10:50:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:34078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229715AbhBGPuv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Feb 2021 10:50:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 528CE64E63;
        Sun,  7 Feb 2021 15:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612712953;
        bh=M5ZQhHXDEgSCXSYU6eECpPK9SlfIUauk4xahlr/bo5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qbpqzf5aSsVP60VNJYdAl/wewARGbpthqTSzUATUBTzhhj+asUtLv0WltsvWrDD5s
         RYD3MWcHEyvxPeTfLzZt1TF/JfFcAvq2h9hnkpSxuCaRbp/SvN6jOlwF4C1+bWumRJ
         W2ZOM80qTXWODIMHMvcmGoK7UVU5IPmi+VWzgWzVf8lqy/RvlbBiA5s8wqXmyqpn/q
         SWN34KwgIO8od8+ePO+L1qaTyBgAqcU5ECqBe0eQ95t9FqoWr7Ahb9xKKu9g/gDYOo
         KFZb9CoaPtnT2Oogp6Htm4qmvlHiXkfY4060PasLo4meNqc++AoIhkqzo5RZcnxw6A
         AWw0edNjzuE5w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        song.bao.hua@hisilicon.com, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 20/24] staging:iio:cdc:ad7150: Add of_match_table
Date:   Sun,  7 Feb 2021 15:46:19 +0000
Message-Id: <20210207154623.433442-21-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210207154623.433442-1-jic23@kernel.org>
References: <20210207154623.433442-1-jic23@kernel.org>
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
---
 drivers/staging/iio/cdc/ad7150.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 0bc8c7a99883..33c8a78c076f 100644
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
2.30.0

