Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D6B39A9B8
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jun 2021 20:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhFCSHX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Jun 2021 14:07:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230414AbhFCSGz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 3 Jun 2021 14:06:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12D29613F3;
        Thu,  3 Jun 2021 18:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622743489;
        bh=5gkUpB1HmKpVb9n8exFBH8wL/MEoltrA/LPiGOV6pDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mtW81ksRtyTGC0+AgYyWLMxHH+G4cOItOLCNzmIm88gJ2bSB3OqpOa4lZAUP5hI91
         15nry/7Jwh1OtTVWrmZ2yuGCl6fsnWw4DU0cZnz3mjFTlXJnixRlkvPmxtyk7RG7JW
         zCfSiy5AdjTOAEEk+AG0P9gFP4zb8n8fWdNjwhMa2b9xDIRdlUHj2ypl6DXjgdL9vb
         s/4aOrlhSldnLHqDoo0vJFb/TxYUv3qt4A7tnD2Dy5upUg4fPOCdSY5q8YsSM+OBXg
         5vK2aOgKDjATgS6ClwdLSQ5P/7MEVXIwBv+4KyKEF1QC7lNovNexkWEeWaW8n4uDBg
         81t65S1AFsBeQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 3/4] iio: imu: inv_mpu6050: Drop use of %hhx format string.
Date:   Thu,  3 Jun 2021 19:06:11 +0100
Message-Id: <20210603180612.3635250-4-jic23@kernel.org>
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

Use the 0x02x form as the length specifier when used with # includes
the 0x prefix and is very unlikely to be what was intended by the author.

Part of a series removing all uses from IIO in the interestings of
avoiding providing bad examples for people to copy.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Nathan Chancellor <nathan@kernel.org>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 64704b55f6eb..b7254d9e0fe2 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1314,8 +1314,7 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
 		for (i = 0; i < INV_NUM_PARTS; ++i) {
 			if (regval == hw_info[i].whoami) {
 				dev_warn(regmap_get_device(st->map),
-					"whoami mismatch got %#02x (%s)"
-					"expected %#02hhx (%s)\n",
+					"whoami mismatch got 0x%02x (%s) expected 0x%02x (%s)\n",
 					regval, hw_info[i].name,
 					st->hw->whoami, st->hw->name);
 				break;
@@ -1323,7 +1322,7 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
 		}
 		if (i >= INV_NUM_PARTS) {
 			dev_err(regmap_get_device(st->map),
-				"invalid whoami %#02x expected %#02hhx (%s)\n",
+				"invalid whoami 0x%02x expected 0x%02x (%s)\n",
 				regval, st->hw->whoami, st->hw->name);
 			return -ENODEV;
 		}
-- 
2.31.1

