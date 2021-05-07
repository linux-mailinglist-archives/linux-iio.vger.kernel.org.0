Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153633763D5
	for <lists+linux-iio@lfdr.de>; Fri,  7 May 2021 12:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbhEGKdc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 May 2021 06:33:32 -0400
Received: from first.geanix.com ([116.203.34.67]:38914 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229829AbhEGKdb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 7 May 2021 06:33:31 -0400
Received: from zen.. (109.57.11.253.mobile.3.dk [109.57.11.253])
        by first.geanix.com (Postfix) with ESMTPSA id 3F53B4680DE;
        Fri,  7 May 2021 10:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1620383549; bh=EBEQBVVRYIv6ts4IVXXwZBwGfnpoLdBwayvg0Z203gI=;
        h=From:To:Cc:Subject:Date;
        b=DpHeZuB4CA6sgz+JUrTGhWKs7W8uYl9iKV9iH65PH7Hw50J9fgkKPMJntsrUv+wa6
         AOQQfPY/8q2B/u00LDsqXHcY9oZE7SlR/t/PbR6mOucq4c5i6oZ8f/X7nyyPvWUa+L
         NrkgQRxxMj7i0I4gxljTOMpKzyhliKzQpc59ekhTCP0FxJR8W6hHKj3J3453GdD7IF
         UfxacsZUwmvTxUy91YDYBRoTurERkYAyAUHwfZJ5/cqy2rEGQLirQPpZ63WrhuFmW3
         5VuNKUAK2VkV77dLGXevx0cCklluGsig6CFWXOb+bJ783Vx51ec5sfsGZhN4Y5fCBN
         mw6Bt0jX4NcOg==
From:   Sean Nyekjaer <sean@geanix.com>
To:     lorenzo.bianconi83@gmail.com, jic23@kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org
Subject: [PATCH] iio: imu: st_lsm6dsx: do not roundup set samplerate
Date:   Fri,  7 May 2021 12:32:20 +0200
Message-Id: <20210507103220.2194009-1-sean@geanix.com>
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

The correct way to set the sampling rate to 12.5 Hz before
commit f8710f0357bc ("iio: imu: st_lsm6dsx: express odr in mHZ")
was to write 13 Hz to sampling_frequency.
Before this patch writing 13 to samplerate results in sample rate set
to 26 Hz.
Now we return EINVAL if the sampling rate is not in table.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index a3ab16615729..a14a1df8537b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1427,7 +1427,7 @@ int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u32 odr, u8 *val)
 		 * ext devices can run at different odr respect to
 		 * accel sensor
 		 */
-		if (odr_table->odr_avl[i].milli_hz >= odr)
+		if (odr_table->odr_avl[i].milli_hz == odr)
 			break;
 	}
 
-- 
2.31.0

