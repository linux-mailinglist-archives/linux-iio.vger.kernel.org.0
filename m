Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE2D382CA2
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 14:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhEQM6I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 08:58:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhEQM6I (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 May 2021 08:58:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26F9F61166;
        Mon, 17 May 2021 12:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621256211;
        bh=vGIT9QSwC44jhqUJ144/B52brXDnOnPCFWNwmbGm8ew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hlpjdU9j+rCIHio1PrtGSsliONMezOE3Qm+8Tc9DRUIKihfYYsXQ21BSzDrrCsJhV
         aRKQBLCmda+PU0rsGSic7qidymR8vTJ8dcfFCZ1E8D4PExDx4kARO3bH4fJW0F8f7q
         gMBKdJZT3Gcd6aKEtlIX7itf2F3KxzyS6IieSC90Pjk6w7coc8jGhsEjRgEZbbUcio
         7GCwun2KqYq4Xih/YBmItfVrYiGxj/rPIx8Zj4VAw/p13y3zAkSJK2++kR1Z9BXC9M
         hmElzZGHYexEWWjWx+H0nwfXx0TGrCLQEdipfeGtTn2iPG635GddSSf8T6/qI4RCAK
         G2WFO+Z8XjuXg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Maxime=20Roussin-B=C3=A9langer?= 
        <maxime.roussinbelanger@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 2/4] iio: light: si1133: Drop remaining uses of %hhx format string.
Date:   Mon, 17 May 2021 13:55:52 +0100
Message-Id: <20210517125554.1463156-3-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517125554.1463156-1-jic23@kernel.org>
References: <20210517125554.1463156-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Since:
commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
unnecessary %h[xudi] and %hh[xudi]")
use of these format strings has been discouraged.

As there are not that many in IIO, this is part of an effort to clear
them out so we don't have any instances that might get coppied into
new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Maxime Roussin-Bélanger <maxime.roussinbelanger@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>
---
 drivers/iio/light/si1133.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index fd302480262b..0af36176907d 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -352,22 +352,22 @@ static int si1133_parse_response_err(struct device *dev, u32 resp, u8 cmd)
 
 	switch (resp) {
 	case SI1133_ERR_OUTPUT_BUFFER_OVERFLOW:
-		dev_warn(dev, "Output buffer overflow: %#02hhx\n", cmd);
+		dev_warn(dev, "Output buffer overflow: %#02x\n", cmd);
 		return -EOVERFLOW;
 	case SI1133_ERR_SATURATION_ADC_OR_OVERFLOW_ACCUMULATION:
-		dev_warn(dev, "Saturation of the ADC or overflow of accumulation: %#02hhx\n",
+		dev_warn(dev, "Saturation of the ADC or overflow of accumulation: %#02x\n",
 			 cmd);
 		return -EOVERFLOW;
 	case SI1133_ERR_INVALID_LOCATION_CMD:
 		dev_warn(dev,
-			 "Parameter access to an invalid location: %#02hhx\n",
+			 "Parameter access to an invalid location: %#02x\n",
 			 cmd);
 		return -EINVAL;
 	case SI1133_ERR_INVALID_CMD:
-		dev_warn(dev, "Invalid command %#02hhx\n", cmd);
+		dev_warn(dev, "Invalid command %#02x\n", cmd);
 		return -EINVAL;
 	default:
-		dev_warn(dev, "Unknown error %#02hhx\n", cmd);
+		dev_warn(dev, "Unknown error %#02x\n", cmd);
 		return -EINVAL;
 	}
 }
@@ -400,7 +400,7 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
 
 	err = regmap_write(data->regmap, SI1133_REG_COMMAND, cmd);
 	if (err) {
-		dev_warn(dev, "Failed to write command %#02hhx, ret=%d\n", cmd,
+		dev_warn(dev, "Failed to write command %#02x, ret=%d\n", cmd,
 			 err);
 		goto out;
 	}
@@ -425,7 +425,7 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
 					       SI1133_CMD_TIMEOUT_MS * 1000);
 		if (err) {
 			dev_warn(dev,
-				 "Failed to read command %#02hhx, ret=%d\n",
+				 "Failed to read command %#02x, ret=%d\n",
 				 cmd, err);
 			goto out;
 		}
-- 
2.31.1

