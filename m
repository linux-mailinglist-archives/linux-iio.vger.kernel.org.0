Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3D781381F7
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2020 16:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgAKPTN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jan 2020 10:19:13 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:60562 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729865AbgAKPTN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Jan 2020 10:19:13 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47w3RM4LB6z39;
        Sat, 11 Jan 2020 16:19:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1578755951; bh=H4MNPqMjdZ3XHoDYSoFmpzhm8VeYoPDtCn+1F9av74Q=;
        h=Date:From:Subject:To:Cc:From;
        b=L4X8q5WFGJlwIn90/hX5DJ5KCMBwV++s635OdCB324Q1Fq+D/zU+b26Hjv2sZWi3X
         E3Tb4K/5ndQSCzhGHh8Il1iXwxia1paDLVY+z+X4IfvzdJzXD/QzNR/bFvbpwu7ARL
         hx4tU+Qe/kQRq/bz4ZMtRjuVps9UIFHkUxgI+rDoGXcSBq81gaH98aaIrCdsHdMEPn
         T9FQ4dEOL1G1AumbpyiiwouPslD7r0zFRAK1Bh7hg/rNRyVjDfy3j7zYnpgRm+jUA6
         k9Q2+v9oEVDP5DD+6Gaa6AJ+F4On2J/Zs4BIxI+tnenpTJp/5NeBvGLGSkmx4L43ML
         BhC0o2194RlsA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Sat, 11 Jan 2020 16:19:11 +0100
Message-Id: <8934b8d01f823f71b0fd66b16c832dbb47317cca.1578755864.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3] iio: imu/mpu6050: support dual-edge IRQ
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
One example of this kind of platform is AT91SAM9G45

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

---
v3: reword commit message
v2: just remove the dev_warn() message

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 2261c6c4ac65..4cfdd19ee4fc 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1118,7 +1118,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	irq_type = irqd_get_trigger_type(desc);
 	if (!irq_type)
 		irq_type = IRQF_TRIGGER_RISING;
-	if (irq_type == IRQF_TRIGGER_RISING)
+	if (irq_type & IRQF_TRIGGER_RISING)	// rising or both-edge
 		st->irq_mask = INV_MPU6050_ACTIVE_HIGH;
 	else if (irq_type == IRQF_TRIGGER_FALLING)
 		st->irq_mask = INV_MPU6050_ACTIVE_LOW;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 72d8c5790076..a8a833f8b99b 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -180,11 +180,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
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
 		st->chip_config.gyro_fifo_enable))
-- 
2.20.1

