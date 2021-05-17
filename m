Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A44382CA1
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 14:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhEQM6G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 08:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhEQM6F (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 May 2021 08:58:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3677161073;
        Mon, 17 May 2021 12:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621256209;
        bh=12u/f7DcSJhFqzlq6STtwznafBpD8dd6X1qU4vyjFZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TOE1TiDKX2aW+T7SzGL5bAT5IGiTuIi/HSc+o+wUG5spR+qxR7/P8IEpzCtKOsbxD
         cpsxIY6QHnszu6+ljaYbbfTzQGE3t5y5USZnpXBLsVRBTWKdeU3oSafF7xHd1JZysz
         SYfWFMPEz2fdWfdXXFJYQX/1DvbQXzolhNvZp67qSz2bSMuU1O6Eb4FKX+kms+aRCI
         Vdx37e2r2hBvPzvme3U7DlxS/d+xcg2MsC5Edapz+G4y+eeT0i6M2G/TWHjN1fNQ6d
         jwOucpZzu59KmH4GSiHFPCETD0+emt2nXcZzNfWdV4Zq4OgWYjwM+COPZgOzPLeGd7
         mapDZcAk1KHPw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 1/4] iio: imu: inv_mpu6050: Drop use of %hhx format string.
Date:   Mon, 17 May 2021 13:55:51 +0100
Message-Id: <20210517125554.1463156-2-jic23@kernel.org>
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
use of these format strings has been discouraged.

Part of a series removing all uses from IIO in the interestings of
avoiding providing bad examples for people to copy.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Nathan Chancellor <nathan@kernel.org>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 6244a07048df..3169d3153b83 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1314,8 +1314,7 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
 		for (i = 0; i < INV_NUM_PARTS; ++i) {
 			if (regval == hw_info[i].whoami) {
 				dev_warn(regmap_get_device(st->map),
-					"whoami mismatch got %#02x (%s)"
-					"expected %#02hhx (%s)\n",
+					"whoami mismatch got %#02x (%s) expected %#02x (%s)\n",
 					regval, hw_info[i].name,
 					st->hw->whoami, st->hw->name);
 				break;
@@ -1323,7 +1322,7 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
 		}
 		if (i >= INV_NUM_PARTS) {
 			dev_err(regmap_get_device(st->map),
-				"invalid whoami %#02x expected %#02hhx (%s)\n",
+				"invalid whoami %#02x expected %#02x (%s)\n",
 				regval, st->hw->whoami, st->hw->name);
 			return -ENODEV;
 		}
-- 
2.31.1

