Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1DA382CA3
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 14:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbhEQM6K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 08:58:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233441AbhEQM6J (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 May 2021 08:58:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C3A961042;
        Mon, 17 May 2021 12:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621256213;
        bh=UThLCu3C9EOwdnbQ7xLvrqDQRdrYVrm7U2E9OR9cssQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eEIEZA6LONTjVAH8HEEIUvnUDrAnefc5HfBzpm7Rzk8vhmWuHPZfjspo3QJe/AT19
         OVILCqGNzaeQ/KdO3E1oOVRA1tgdfvX18u7qejZFsqxF2GFMyhoyuC3lJahcKSPApj
         9jfZOcKfLxgjo3xpF8gD6XUr8/okFSWCCCv5UVU8KBoR7/FJoLEQ2xENBefJYalhnl
         wJNdkw38bABVT13K2o32fDz0qGCqLiKvLSJWBY+AaoduWjLF4FFYALQwSx5O9rxVQV
         u+DQyktZJJZ8m5LtEoLjQUE+RlXJLTld25KB8LuvRhLwZzN2ix/7mf15d4R3oKI7Nq
         OBIDSOXEyjBig==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 3/4] iio: light: si1145: Drop use of %hhx format specifier.
Date:   Mon, 17 May 2021 13:55:53 +0100
Message-Id: <20210517125554.1463156-4-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517125554.1463156-1-jic23@kernel.org>
References: <20210517125554.1463156-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Since:
commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
unnecessary %h[xudi] and %hh[xudi]")
use of these format strings has been discouraged.  As there are only
a few such instances in IIO, this is part of a series clearing them
out so they don't get copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Nathan Chancellor <nathan@kernel.org>
---
 drivers/iio/light/si1145.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index 3fb52402fcc3..a3c41ce9c156 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -271,7 +271,7 @@ static int si1145_command(struct si1145_data *data, u8 cmd)
 		if ((ret & ~SI1145_RSP_COUNTER_MASK) == 0) {
 			if (ret == data->rsp_seq) {
 				if (time_after(jiffies, stop_jiffies)) {
-					dev_warn(dev, "timeout on command %#02hhx\n",
+					dev_warn(dev, "timeout on command %#02x\n",
 						 cmd);
 					ret = -ETIMEDOUT;
 					break;
@@ -291,12 +291,12 @@ static int si1145_command(struct si1145_data *data, u8 cmd)
 			ret = -EIO;
 		} else {
 			if (ret == SI1145_RSP_INVALID_SETTING) {
-				dev_warn(dev, "INVALID_SETTING error on command %#02hhx\n",
+				dev_warn(dev, "INVALID_SETTING error on command %#02x\n",
 					 cmd);
 				ret = -EINVAL;
 			} else {
 				/* All overflows are treated identically */
-				dev_dbg(dev, "overflow, ret=%d, cmd=%#02hhx\n",
+				dev_dbg(dev, "overflow, ret=%d, cmd=%#02x\n",
 					ret, cmd);
 				ret = -EOVERFLOW;
 			}
@@ -1299,10 +1299,10 @@ static int si1145_probe(struct i2c_client *client,
 						SI1145_REG_SEQ_ID);
 	if (ret < 0)
 		return ret;
-	dev_info(&client->dev, "device ID part %#02hhx rev %#02hhx seq %#02hhx\n",
+	dev_info(&client->dev, "device ID part %#02x rev %#02x seq %#02x\n",
 			part_id, rev_id, seq_id);
 	if (part_id != data->part_info->part) {
-		dev_err(&client->dev, "part ID mismatch got %#02hhx, expected %#02x\n",
+		dev_err(&client->dev, "part ID mismatch got %#02x, expected %#02x\n",
 				part_id, data->part_info->part);
 		return -ENODEV;
 	}
-- 
2.31.1

