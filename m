Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C1139A9BD
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jun 2021 20:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhFCSH2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Jun 2021 14:07:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231277AbhFCSHW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 3 Jun 2021 14:07:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2461C613F8;
        Thu,  3 Jun 2021 18:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622743492;
        bh=sCgkhFJT5hJ+XQpNk+ukwvirPMhO36VsOe5Orh2RRPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q9vP4ybV5PasGdmjiX+0gqENpg3r8bpDB9ggYrmJoKpnTp97eRWQI8XUJC64jxOwq
         DpbHofkuFoxpWLc/0qNzP07Rlr4Z5jQh4xIJQCewdO8wUbpKb6QbrvgSvZPT8ytzvF
         hd5X3Yz6C3R8eBPN8SBtzx6mA1O2OV8g66/9lHAt1Pu5jFgDJcLoXidEcFRgwBMHIQ
         +U6DMYS2K+ul0t/B9ukyEpwToI4fcHB2MtEVANAtydheSo06uWH8IYq+Zbnr1FabjI
         +52W3yQLknwUIprYt2PlC0lsiZlxOIYrJrxhK14bx/cHfGbj2Rz8Lv8K2uJdbWhcz5
         j7tEak1jw/84w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 4/4] iio: light: si1145: Drop use of %hhx format specifier.
Date:   Thu,  3 Jun 2021 19:06:12 +0100
Message-Id: <20210603180612.3635250-5-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603180612.3635250-1-jic23@kernel.org>
References: <20210603180612.3635250-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Since:
commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
unnecessary %h[xudi] and %hh[xudi]")
use of these format strings has been discouraged.

As there are only a few such instances in IIO, this is part of a
series clearing them out so they don't get copied into new drivers.

Use the 0x02x form as the length specifier when used with # includes
the 0x prefix and is very unlikely to be what was intended by the author.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Nathan Chancellor <nathan@kernel.org>
---
 drivers/iio/light/si1145.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index 3fb52402fcc3..e2abad48b9f4 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -271,7 +271,7 @@ static int si1145_command(struct si1145_data *data, u8 cmd)
 		if ((ret & ~SI1145_RSP_COUNTER_MASK) == 0) {
 			if (ret == data->rsp_seq) {
 				if (time_after(jiffies, stop_jiffies)) {
-					dev_warn(dev, "timeout on command %#02hhx\n",
+					dev_warn(dev, "timeout on command 0x%02x\n",
 						 cmd);
 					ret = -ETIMEDOUT;
 					break;
@@ -291,12 +291,12 @@ static int si1145_command(struct si1145_data *data, u8 cmd)
 			ret = -EIO;
 		} else {
 			if (ret == SI1145_RSP_INVALID_SETTING) {
-				dev_warn(dev, "INVALID_SETTING error on command %#02hhx\n",
+				dev_warn(dev, "INVALID_SETTING error on command 0x%02x\n",
 					 cmd);
 				ret = -EINVAL;
 			} else {
 				/* All overflows are treated identically */
-				dev_dbg(dev, "overflow, ret=%d, cmd=%#02hhx\n",
+				dev_dbg(dev, "overflow, ret=%d, cmd=0x%02x\n",
 					ret, cmd);
 				ret = -EOVERFLOW;
 			}
@@ -1299,10 +1299,10 @@ static int si1145_probe(struct i2c_client *client,
 						SI1145_REG_SEQ_ID);
 	if (ret < 0)
 		return ret;
-	dev_info(&client->dev, "device ID part %#02hhx rev %#02hhx seq %#02hhx\n",
+	dev_info(&client->dev, "device ID part 0x%02x rev 0x%02x seq 0x%02x\n",
 			part_id, rev_id, seq_id);
 	if (part_id != data->part_info->part) {
-		dev_err(&client->dev, "part ID mismatch got %#02hhx, expected %#02x\n",
+		dev_err(&client->dev, "part ID mismatch got 0x%02x, expected 0x%02x\n",
 				part_id, data->part_info->part);
 		return -ENODEV;
 	}
-- 
2.31.1

