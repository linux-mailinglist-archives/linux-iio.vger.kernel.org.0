Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC2DD131148
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2020 12:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgAFLR5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Jan 2020 06:17:57 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:38503 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgAFLR5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 6 Jan 2020 06:17:57 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47rtKG4HMwz81;
        Mon,  6 Jan 2020 12:17:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1578309475; bh=CCLxX53RZtZFK1gL18DyCLhrUoZctB9AHHRdjY+vBfA=;
        h=Date:From:Subject:In-Reply-To:To:Cc:From;
        b=Yt1hd/P1LEG9U6ev3oKFIA553MlvGDLb9N3rar36dJeyTGq9REJFgJunUMOMg4tbu
         vXRMz56q2lB7PE/jY8T0qa5Tjfnq7F/RbNqh0bJ35+8knC/vlbZkc+ZdvarD8l4trp
         k2CwTZgxVCSa8ESdZvIgYbUmCyvB5LTfpgyS8rqHn9Nc1qJTMFOjsyZ7IANmkNa648
         1oykxDDx4pw25S6qQ2uIy97VDe7QuppMvAbWr7idiW4qLuoMaEXufCj+LZBKSa65Wx
         HXbITfpzmyGrZFSIJtlES2HXUHpHGTCJudcojX0TC0p1N1c+vZc+baH9c/H6VdjbpZ
         ZortkXZJwCTjA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Mon, 06 Jan 2020 12:17:54 +0100
Message-Id: <e5b39c16dc6dcb25324f6e8389cc0d0f895c1cbd.1578309319.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2] iio: imu/mpu6050: support dual-edge IRQ
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR12MB33737F067F25B2F7477C4FE5C43C0@MN2PR12MB3373.namprd12.prod.outlook.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Make mpu6050 usable on platforms which provide only any-edge interrupts.
This also covers shared interrupt case.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

---
v2:
   just remove the dev_warn() message

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 0686e41bb8a1..b3d138091f89 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1241,7 +1241,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	irq_type = irqd_get_trigger_type(desc);
 	if (!irq_type)
 		irq_type = IRQF_TRIGGER_RISING;
-	if (irq_type == IRQF_TRIGGER_RISING)
+	if (irq_type & IRQF_TRIGGER_RISING)	// rising or both-edge
 		st->irq_mask = INV_MPU6050_ACTIVE_HIGH;
 	else if (irq_type == IRQF_TRIGGER_FALLING)
 		st->irq_mask = INV_MPU6050_ACTIVE_LOW;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 10d16ec5104b..a4dc2c4a3ca5 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -183,11 +183,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 			"failed to ack interrupt\n");
 		goto flush_fifo;
 	}
-	if (!(int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT)) {
-		dev_warn(regmap_get_device(st->map),
-			"spurious interrupt with status 0x%x\n", int_status);
+	if (!(int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT))
 		goto end_session;
-	}
 
 	if (!(st->chip_config.accl_fifo_enable |
 		st->chip_config.gyro_fifo_enable |
-- 
2.20.1

