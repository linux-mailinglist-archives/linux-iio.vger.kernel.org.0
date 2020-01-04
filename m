Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3088C1303A4
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2020 17:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgADQom (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jan 2020 11:44:42 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:61985 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgADQom (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jan 2020 11:44:42 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47qngC2Jt5zGW;
        Sat,  4 Jan 2020 17:44:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1578156279; bh=oTvnASVeLN6WdH2UHyaweC1pw6TM7iWDLweJ8XiHgAc=;
        h=Date:From:Subject:To:Cc:From;
        b=Xw3cGGjvfEgmGqZp3vDZNApHr0TbrZigZU6Gly10uo78nzTE8oSDp6+EHSoDzd5nS
         NQeVgQe4JxUl+7afm9jBNMGZDclIULb0oxZTAzNbRRzqiQFFXvdc7vpxj3NiB6nOqj
         z8mUb2vZaAAHYMK7bCsMPtdeYoUJBwPJ7+/51/sPCAcPEKJ93FK7Kojvlg5U58W98E
         3dyLGoBzpFMf4kWibRNLLHWMvg3htwg+c5GkwhtsTZJD6dxRO4D+Ho3dzEa+kfl8cC
         TShoNCwI5hK0vQITrP8fXOhwWGBpJzucnKI8mudM0SFmI1hg9eHDqdkmM23xJBEiM8
         XDBkKWexha27A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Sat, 04 Jan 2020 17:44:39 +0100
Message-Id: <e03daea84ce5fe5e79311a07fee4636c2a884a8e.1578156240.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] iio: imu/mpu6050: support dual-edge IRQ
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Make mpu6050 usable on platforms which provide only any-edge interrupts.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 3 ++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 6 ++++--
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 0686e41bb8a1..36b6a3922d15 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1239,9 +1239,10 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	}
 
 	irq_type = irqd_get_trigger_type(desc);
+	st->irq_ignore_spurious = irq_type == (IRQF_TRIGGER_RISING|IRQF_TRIGGER_FALLING);
 	if (!irq_type)
 		irq_type = IRQF_TRIGGER_RISING;
-	if (irq_type == IRQF_TRIGGER_RISING)
+	if (irq_type == IRQF_TRIGGER_RISING || st->irq_ignore_spurious)
 		st->irq_mask = INV_MPU6050_ACTIVE_HIGH;
 	else if (irq_type == IRQF_TRIGGER_FALLING)
 		st->irq_mask = INV_MPU6050_ACTIVE_LOW;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index b096e010d4ee..94ee7b18b198 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -158,6 +158,7 @@ struct inv_mpu6050_state {
 	struct regmap *map;
 	int irq;
 	u8 irq_mask;
+	u8 irq_ignore_spurious;
 	unsigned skip_samples;
 	s64 chip_period;
 	s64 it_timestamp;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 10d16ec5104b..52f02de3d9b0 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -184,8 +184,10 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 		goto flush_fifo;
 	}
 	if (!(int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT)) {
-		dev_warn(regmap_get_device(st->map),
-			"spurious interrupt with status 0x%x\n", int_status);
+		if (!st->irq_ignore_spurious)
+			dev_warn(regmap_get_device(st->map),
+				 "spurious interrupt with status 0x%x\n",
+				 int_status);
 		goto end_session;
 	}
 
-- 
2.20.1

