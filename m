Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2CCA462B7
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2019 17:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbfFNP3J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Jun 2019 11:29:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35278 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725780AbfFNP3J (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Jun 2019 11:29:09 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7F5E2D672D3B51780036;
        Fri, 14 Jun 2019 23:29:06 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 14 Jun 2019
 23:28:57 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <jic23@kernel.org>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>
CC:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-iio@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] staging: iio: adt7316: Add missing include files
Date:   Fri, 14 Jun 2019 23:28:46 +0800
Message-ID: <20190614152846.28108-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix build error:

drivers/staging/iio/addac/adt7316.c: In function adt7316_store_update_DAC:
drivers/staging/iio/addac/adt7316.c:949:3: error: implicit declaration of
 function gpiod_set_value; did you mean gpio_set_value? [-Werror=implicit-function-declaration]
   gpiod_set_value(chip->ldac_pin, 0);

drivers/staging/iio/addac/adt7316.c: In function adt7316_setup_irq:
drivers/staging/iio/addac/adt7316.c:1807:13: error: implicit declaration of
 function irqd_get_trigger_type; did you mean devm_iio_trigger_free? [-Werror=implicit-function-declaration]
  irq_type = irqd_get_trigger_type(irq_get_irq_data(chip->bus.irq));

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 7f6b6d553df7 ("Staging: iio: adt7316: Add all irq related code in adt7316_irq_setup()")
Fixes: c63460c4298f ("Staging: iio: adt7316: Use device tree data to set ldac_pin")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/iio/addac/adt7316.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 37ce563..9d3d159 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -16,6 +16,8 @@
 #include <linux/i2c.h>
 #include <linux/rtc.h>
 #include <linux/module.h>
+#include <linux/irq.h>
+#include <linux/gpio/consumer.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/events.h>
-- 
2.7.4


