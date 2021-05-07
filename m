Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB693763D1
	for <lists+linux-iio@lfdr.de>; Fri,  7 May 2021 12:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbhEGKdA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 May 2021 06:33:00 -0400
Received: from first.geanix.com ([116.203.34.67]:38870 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229829AbhEGKdA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 7 May 2021 06:33:00 -0400
Received: from zen.. (109.57.11.253.mobile.3.dk [109.57.11.253])
        by first.geanix.com (Postfix) with ESMTPSA id 99B404680DE;
        Fri,  7 May 2021 10:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1620383518; bh=S2q2tzdDm6E95jCOCbV5DhbJxg2LzcGDOE4mBgDMDoI=;
        h=From:To:Cc:Subject:Date;
        b=M2kMxJxyARHo8vp3CGMpTysRbGfkELEWB7Y1zo0HOxG6mSofysRdVyRpUR8Sb8fxW
         /4zT8fmChXeZZlwKKQKphC8PhRS1wFk7M0Xz9SQbWNtlYGjXHBP4FCKz891pPkF16t
         5NyjvxWuG8yg4UMXnfGW8oyqUFFcFua8dceTJnJEIow4hfry2zRtYpQZQ0RJ1O8H3D
         J9p0ELcXeLTeYkzl4v+bcbuepV1edMyu9dHJRvKQNBwLHx7DnEZO/YDIbpNFxac9aG
         pUZQPq1B2Y4sFDuHLFCWdc1TXQWzq1hfr/5kujqqNBBhZU6zD1MDNY/pMGZ47we1Sr
         2TVGO9QalPSEA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     lorenzo.bianconi83@gmail.com, jic23@kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org
Subject: [PATCH] iio: imu: st_lsm6dsx: correct ODR in header
Date:   Fri,  7 May 2021 12:31:49 +0200
Message-Id: <20210507103149.2193932-1-sean@geanix.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix wrongly stated 13 Hz ODR for accelerometers, the correct ODR is 12.5 Hz

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 2ab1ac5a2412..a3ab16615729 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -15,19 +15,19 @@
  *
  * Supported sensors:
  * - LSM6DS3:
- *   - Accelerometer/Gyroscope supported ODR [Hz]: 13, 26, 52, 104, 208, 416
+ *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, 208, 416
  *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
  *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
  *   - FIFO size: 8KB
  *
  * - LSM6DS3H/LSM6DSL/LSM6DSM/ISM330DLC/LSM6DS3TR-C:
- *   - Accelerometer/Gyroscope supported ODR [Hz]: 13, 26, 52, 104, 208, 416
+ *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, 208, 416
  *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
  *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
  *   - FIFO size: 4KB
  *
  * - LSM6DSO/LSM6DSOX/ASM330LHH/LSM6DSR/ISM330DHCX:
- *   - Accelerometer/Gyroscope supported ODR [Hz]: 13, 26, 52, 104, 208, 416,
+ *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, 208, 416,
  *     833
  *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
  *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
-- 
2.31.0

