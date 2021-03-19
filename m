Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930DC341E6A
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 14:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhCSNeZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 09:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhCSNeB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 09:34:01 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5482AC06174A
        for <linux-iio@vger.kernel.org>; Fri, 19 Mar 2021 06:34:01 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id u20so11951262lja.13
        for <linux-iio@vger.kernel.org>; Fri, 19 Mar 2021 06:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f0IZHZ3RCROL0eolqJ5o76UXuWo1nZ9ixgurELXD9AE=;
        b=XvfcxTGJ/8VSIrYC8aUUI0JPaOFFCMKTySpsOQMGbPxmRWGGgM7c67hZblewXwVsl4
         R4UKkxzCwxIYxoNdbGQ3RrcOOYGdn6YnvDq/c0YZIa0owWrjKoHJwN20Oko0FDfnmkQQ
         B1DbEGib6XuJl6i7m8ZQCk8Wqk/Aqb+VmL4SzNFgTWnT8tymT+v4CVTd9GiaIxe0O4rv
         ChFDY+X5QFo06KHs75t5e3UXhAPSgnPmtMD97lcXpcoC4KKvVA/3OkQWBHlxfPZgOEJV
         Vfa1Q7VfzRWakHCJm59syopVbbwlZ/eAXtl23QvqxZDgexodP7SB7BOOqRMDWEKk2+mD
         m4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f0IZHZ3RCROL0eolqJ5o76UXuWo1nZ9ixgurELXD9AE=;
        b=pFnWx3Q0oArliGZR6yQHDWIOrSLSmAgd86xACdbA3UNVLVvF9GVf5mMbyXsuR5LoVT
         yFQQXDxgzYcCzhTnxzXVnZnQeqGNWERNjrCXOJMVULt0Fj5WBrss+BvVBhT5scxiw2gu
         gu0+T6TvX3AXEDko70WpabSFzoADhgwu6R8HQDZ7AlYfbodwFyLDQTahqyw1F3NoPbiL
         G8xeplff1XMVSkZ9LqdD+JRg8WBxGjk37nDpoQUmxtUm/mZlaZLRsF6l1SUkP0rSSPCo
         md5LKbnxwExOP61ADu9jEZrdv1UeBC1L8gkKgIPV2znys0B19+kiQUtsPjJu0sQJmTcY
         7n7g==
X-Gm-Message-State: AOAM53268lTweyAFJu7xQoerxm/zHGhAia2faT4kauy8r+VbGFvaon4O
        9VZklEBxEDt7qVOpfn2e79q8Nw==
X-Google-Smtp-Source: ABdhPJwTD46E1cXyv2e11Zf1E4r8jUTZAiHaqWMLncDhxmzo/yWeh3s90oBvQNUnonp/BQsWNi8LYg==
X-Received: by 2002:a2e:a494:: with SMTP id h20mr993093lji.292.1616160839835;
        Fri, 19 Mar 2021 06:33:59 -0700 (PDT)
Received: from localhost.localdomain (c-d7cb225c.014-348-6c756e10.bbcust.telenor.se. [92.34.203.215])
        by smtp.gmail.com with ESMTPSA id r1sm767185ljn.71.2021.03.19.06.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 06:33:59 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH] iio: imu: inv_mpu6050: Use as standalone trigger
Date:   Fri, 19 Mar 2021 14:33:57 +0100
Message-Id: <20210319133357.541183-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

It may happen that the MPU6050 is the only hardware
trigger available on your system such as this:

> lsiio
Device 003: hscdtd008a
Device 001: mpu6050
Device 002: gp2ap002
Device 000: ab8500-gpadc
Trigger 000: mpu6050-dev1

And when you want to use it to read periodically from
your magnetometer like this:

> iio_generic_buffer -a -c 100 -n hscdtd008a -t mpu6050-dev1

Then the following happens:

[  209.951334] Internal error: Oops: 5 [#1] SMP ARM
(...)
[  209.981969] Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Support)
[  209.988925] PC is at inv_scan_query_mpu6050+0x8/0xb8
[  209.993914] LR is at inv_mpu6050_set_enable+0x40/0x194

This is because since we are not using any channels from the
same device, the indio_dev->active_scan_mask is NULL.

Just checking for that and bailing out is however not enough:
we have to enable some kind of FIFO for the readout to work.
So enable the temperature as a dummy FIFO and all works
fine.

Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index f7b5a70be30f..6946d50b874a 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -11,6 +11,17 @@ static unsigned int inv_scan_query_mpu6050(struct iio_dev *indio_dev)
 	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
 	unsigned int mask;
 
+	/*
+	 * If the MPU6050 is just used as a trigger, then the scan mask
+	 * is not allocated so we simply enable the temperature channel
+	 * as a dummy and bail out.
+	 */
+	if (!indio_dev->active_scan_mask) {
+		st->chip_config.temp_fifo_enable = true;
+		mask = INV_MPU6050_SENSOR_TEMP;
+		return mask;
+	}
+
 	st->chip_config.gyro_fifo_enable =
 		test_bit(INV_MPU6050_SCAN_GYRO_X,
 			 indio_dev->active_scan_mask) ||
-- 
2.29.2

