Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E58F39A9B5
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jun 2021 20:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhFCSHW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Jun 2021 14:07:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230412AbhFCSGz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 3 Jun 2021 14:06:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91CCE61168;
        Thu,  3 Jun 2021 18:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622743486;
        bh=hsvluWMjRK9V+JojbfAuZixzXGd2ri/U860X/FrZ+a0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IE7FqO7Fu72Bd9vN8PmJ1EKFBI/ypeC0tZLSFIIUKxRu4oXBFA48ZUVmFHxxPmVFR
         waO2yTJywSd8nGJfCdYHe04Qt8W446isgq40Oh7zdC3NDopfw7wMiA4Fn1rYyEdPDm
         6QZi7Z4Jy/fxwtr1RIOq/7C+hoQmkMIEn6pufj+wySHHDui9ufnQMprKsUN8Lc0i+L
         7j0rYBwurb+atjA37LFpwizhtVScYuedmwgbjpV87n1szI21f1a8F+MAKftU8MYqUU
         lMIdvMYh3Hr1jtoiPvbFsWeyvXWAXZiMk0feBOgVbyfDya/CPLCmT/nvGQ+7qtTErY
         ZC7HMfdx4NQ2w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Maxime=20Roussin-B=C3=A9langer?= 
        <maxime.roussinbelanger@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 2/4] iio: light: si1133: Drop remaining uses of %hhx format string.
Date:   Thu,  3 Jun 2021 19:06:10 +0100
Message-Id: <20210603180612.3635250-3-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603180612.3635250-1-jic23@kernel.org>
References: <20210603180612.3635250-1-jic23@kernel.org>
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

Use the 0x02x form as the length specifier when used with # includes
the 0x prefix and is very unlikely to be what was intended by the author.

As there are not that many in IIO, this is part of an effort to clear
them out so we don't have any instances that might get copied into
new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Maxime Roussin-Bélanger <maxime.roussinbelanger@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>
---
 drivers/iio/light/si1133.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index 0accea7090ee..f8c9b2cc322e 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -352,22 +352,22 @@ static int si1133_parse_response_err(struct device *dev, u32 resp, u8 cmd)
 
 	switch (resp) {
 	case SI1133_ERR_OUTPUT_BUFFER_OVERFLOW:
-		dev_warn(dev, "Output buffer overflow: %#02hhx\n", cmd);
+		dev_warn(dev, "Output buffer overflow: 0x%02x\n", cmd);
 		return -EOVERFLOW;
 	case SI1133_ERR_SATURATION_ADC_OR_OVERFLOW_ACCUMULATION:
-		dev_warn(dev, "Saturation of the ADC or overflow of accumulation: %#02hhx\n",
+		dev_warn(dev, "Saturation of the ADC or overflow of accumulation: 0x%02x\n",
 			 cmd);
 		return -EOVERFLOW;
 	case SI1133_ERR_INVALID_LOCATION_CMD:
 		dev_warn(dev,
-			 "Parameter access to an invalid location: %#02hhx\n",
+			 "Parameter access to an invalid location: 0x%02x\n",
 			 cmd);
 		return -EINVAL;
 	case SI1133_ERR_INVALID_CMD:
-		dev_warn(dev, "Invalid command %#02hhx\n", cmd);
+		dev_warn(dev, "Invalid command 0x%02x\n", cmd);
 		return -EINVAL;
 	default:
-		dev_warn(dev, "Unknown error %#02hhx\n", cmd);
+		dev_warn(dev, "Unknown error 0x%02x\n", cmd);
 		return -EINVAL;
 	}
 }
@@ -400,7 +400,7 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
 
 	err = regmap_write(data->regmap, SI1133_REG_COMMAND, cmd);
 	if (err) {
-		dev_warn(dev, "Failed to write command %#02hhx, ret=%d\n", cmd,
+		dev_warn(dev, "Failed to write command 0x%02x, ret=%d\n", cmd,
 			 err);
 		goto out;
 	}
@@ -425,7 +425,7 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
 					       SI1133_CMD_TIMEOUT_MS * 1000);
 		if (err) {
 			dev_warn(dev,
-				 "Failed to read command %#02hhx, ret=%d\n",
+				 "Failed to read command 0x%02x, ret=%d\n",
 				 cmd, err);
 			goto out;
 		}
-- 
2.31.1

