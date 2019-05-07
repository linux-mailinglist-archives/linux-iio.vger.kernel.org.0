Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09E6D15EDE
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2019 10:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfEGIMI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 May 2019 04:12:08 -0400
Received: from first.geanix.com ([116.203.34.67]:42354 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfEGIMI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 7 May 2019 04:12:08 -0400
X-Greylist: delayed 558 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 May 2019 04:12:07 EDT
Received: from zen.localdomain (unknown [85.184.147.232])
        by first.geanix.com (Postfix) with ESMTPSA id 7ECF29E9;
        Tue,  7 May 2019 08:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1557216130; bh=RnULC4LvVGsoENyisFyH/grjsHMX6Q6eNHH1MIF+aB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GYiqvVziIR9pNCof58l4MKz1UxJmzW+yul9a6fyKsolNWa0iW4Ywb5O3awE73dRWL
         dbDSDL0uBNUxpG70q/jFyxeVJYW8e/XIOkBMd21Nexem4cWZ5Q4ZgT4zwHy1eyKrtx
         VyrKJHTuSPbJsWPpZBec/yQIOVWXLfiWD6HSmpEfxlAWxCmNs78zaVDYYKgBheMNZe
         lHq/fhxlCAJ1kq+H3TaBNHRwRfHJquq4v7xBPSH4cBF7KT8+AAy3AaQHJOWpuGRItV
         R/Sr89aM0R+V7KYiQK8fKzsOuxKMtDOvd53uVcrkuclN1t5O0RsBrDEpjxlU5+uGSZ
         NVoQgfyl8zZ3Q==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, martin@geanix.com
Subject: [PATCH 2/2] iio: imu: st_lsm6dsx: add iio trigger and buffer support
Date:   Tue,  7 May 2019 10:02:25 +0200
Message-Id: <20190507080225.108000-2-sean@geanix.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190507080225.108000-1-sean@geanix.com>
References: <20190507080225.108000-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 9cf0eadf640b
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds support for using iio triggers, this is needed because
our hardware guys forgot to connect the irq pins from imu device
to the SoC.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 37 ++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 1ca69598678f..65ab853202de 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -40,8 +40,11 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/bitfield.h>
@@ -945,6 +948,30 @@ static int st_lsm6dsx_init_hw_timer(struct st_lsm6dsx_hw *hw)
 	return 0;
 }
 
+static irqreturn_t st_lsm6dsx_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct st_lsm6dsx_sensor *sensor = iio_priv(indio_dev);
+	u16 buffer[4 * sizeof(s64)/sizeof(u16)];
+	int tmp, bit;
+
+	memset(buffer, 0, sizeof(buffer));
+
+	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength) {
+		st_lsm6dsx_read_oneshot(sensor,
+					indio_dev->channels[bit].address, &tmp);
+		buffer[bit] = tmp;
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
+					   iio_get_time_ns(indio_dev));
+
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
 {
 	u8 drdy_int_reg;
@@ -1093,6 +1120,16 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
 		err = st_lsm6dsx_fifo_setup(hw);
 		if (err < 0)
 			return err;
+	} else {
+		for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
+			err = devm_iio_triggered_buffer_setup(hw->dev,
+					hw->iio_devs[i], NULL,
+					st_lsm6dsx_trigger_handler, NULL);
+			if (err < 0) {
+				dev_err(hw->dev, "iio triggered buffer setup failed\n");
+				return err;
+			}
+		}
 	}
 
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
-- 
2.21.0

