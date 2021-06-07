Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B798439DB7C
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jun 2021 13:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhFGLj3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Jun 2021 07:39:29 -0400
Received: from m12-11.163.com ([220.181.12.11]:57458 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231244AbhFGLj3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Jun 2021 07:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=dak/eSA86goDpgVlmC
        zyhAZoraLrzyUEdjhUTJoIxjM=; b=gLqML5au6sUqJF8t/eqEJrt39n9JPFajRX
        4WDfr+8R2avpGMdrAo3QqIkCsFgJjqKYO3fSqqQ+u++TqEPh1gB709MEgd7Ufj2/
        uJbKigUIzshqV0OIcagsC7FlNSBMENgn0bpc0R9vThuqYvYEKXiUevTPz6hU3tQa
        /zmlcMEhg=
Received: from localhost.localdomain (unknown [218.94.48.178])
        by smtp7 (Coremail) with SMTP id C8CowACnkYnzBL5gqFjSgg--.5542S2;
        Mon, 07 Jun 2021 19:37:24 +0800 (CST)
From:   Guoqing Chi <chi962464zy@163.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, chiguoqing@yulong.com,
        rdunlap@infradead.org, chi962464zy@163.com
Subject: [PATCH] iio: imu: inv_mpu6050:Adding judgment dev which is maybe a void pointer
Date:   Mon,  7 Jun 2021 11:37:15 +0000
Message-Id: <20210607113715.110292-1-chi962464zy@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: C8CowACnkYnzBL5gqFjSgg--.5542S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr1fAF4UurWkCF4rXF17GFg_yoW5Ww1UpF
        4UZrW5Crs5X3yDXFW7JF1UCryrtFy8AF1UJr1xJrnxZF4DCw1UZr18GrW2y343Xr4Fq3s7
        tw1DA34UtF1kJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRrwIDUUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: pfklmlasuwk6r16rljoofrz/xtbBiBSqRFaD-NZ6NwAAsA
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Guoqing Chi <chiguoqing@yulong.com>

ff40: 00000000 95fffa74 00000000 e07b2198 00000000 00000007 81391000 e07b2198
ff60: 00000007 81391000 81267834 81391000 0000015a 81200f00 00000006 00000006
ff80: 00000000 81200514 00000000 80bfbd88 00000000 00000000 00000000 00000000
ffa0: 00000000 80bfbd90 00000000 801010e8 00000000 00000000 00000000 00000000
ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
ffe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[<808f3228>] (inv_mpu_i2c_aux_setup) from [<808f1c18>] (inv_mpu_core_probe+0x638/0x878)
[<808f1c18>] (inv_mpu_core_probe) from [<808f3100>] (inv_mpu_probe+0xe4/0x1f0)
[<808f3100>] (inv_mpu_probe) from [<80801c88>] (i2c_device_probe+0x238/0x26c)
[<80801c88>] (i2c_device_probe) from [<8063520c>] (really_probe+0x218/0x348)
[<8063520c>] (really_probe) from [<806354b4>] (driver_probe_device+0x60/0x164)
[<806354b4>] (driver_probe_device) from [<80635760>] (device_driver_attach+0x58/0x60)
[<80635760>] (device_driver_attach) from [<806357e8>] (__driver_attach+0x80/0xbc)
[<806357e8>] (__driver_attach) from [<80633560>] (bus_for_each_dev+0x74/0xb4)
[<80633560>] (bus_for_each_dev) from [<80634548>] (bus_add_driver+0x160/0x1e4)
[<80634548>] (bus_add_driver) from [<80636018>] (driver_register+0x7c/0x114)
[<80636018>] (driver_register) from [<80801644>] (i2c_register_driver+0x3c/0x80)
[<80801644>] (i2c_register_driver) from [<8010277c>] (do_one_initcall+0x54/0x1b8)
[<8010277c>] (do_one_initcall) from [<81200f00>] (kernel_init_freeable+0x144/0x1e0)
[<81200f00>] (kernel_init_freeable) from [<80bfbd90>] (kernel_init+0x8/0x10c)
[<80bfbd90>] (kernel_init) from [<801010e8>] (ret_from_fork+0x14/0x2c)

If we do not use aux or forget config child node at dts,it will be in dump.

Signed-off-by: Guoqing Chi <chiguoqing@yulong.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 95f16951c8f4..b0f45042a25f 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -77,11 +77,14 @@ static int inv_mpu_i2c_aux_setup(struct iio_dev *indio_dev)
 	}
 
 	/* enable i2c bypass when using i2c auxiliary bus */
-	if (inv_mpu_i2c_aux_bus(dev)) {
+	if (dev != NULL && inv_mpu_i2c_aux_bus(dev)) {
 		ret = regmap_write(st->map, st->reg->int_pin_cfg,
 				   st->irq_mask | INV_MPU6050_BIT_BYPASS_EN);
 		if (ret)
 			return ret;
+	} else {
+		dev_err(&indio_dev->dev, "Failed to enable i2c bypass.\n");
+		return -EFAULT;
 	}
 
 	return 0;
-- 
2.17.1

