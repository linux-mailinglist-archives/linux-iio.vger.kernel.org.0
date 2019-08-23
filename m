Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACB69AF11
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2019 14:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387740AbfHWMTS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Aug 2019 08:19:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60602 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729276AbfHWMTS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 23 Aug 2019 08:19:18 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8F36B7A8C45E8AFA8067;
        Fri, 23 Aug 2019 20:19:15 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Fri, 23 Aug 2019
 20:19:08 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <gregkh@linuxfoundation.org>,
        <yuehaibing@huawei.com>, <tglx@linutronix.de>,
        <denis.ciocca@st.com>, <Jonathan.Cameron@huawei.com>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] iio: st_sensors: Fix build error
Date:   Fri, 23 Aug 2019 20:18:52 +0800
Message-ID: <20190823121852.75108-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

IIO_ST_SENSORS_CORE select IIO_ST_SENSORS_I2C
unconditionally, if REGMAP_I2C is not set, build fails

drivers/iio/common/st_sensors/st_sensors_i2c.o: In function `st_sensors_i2c_configure':
st_sensors_i2c.c:(.text+0x58): undefined reference to `__devm_regmap_init_i2c'

This patch selects REGMAP_I2C to fix it.
IIO_ST_SENSORS_SPI is similar to SPI issue.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 062809ef7733 ("iio: make st_sensors drivers use regmap")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/iio/common/st_sensors/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/common/st_sensors/Kconfig b/drivers/iio/common/st_sensors/Kconfig
index 91b98e1..16d973f 100644
--- a/drivers/iio/common/st_sensors/Kconfig
+++ b/drivers/iio/common/st_sensors/Kconfig
@@ -5,8 +5,10 @@
 
 config IIO_ST_SENSORS_I2C
 	tristate
+	select REGMAP_I2C
 
 config IIO_ST_SENSORS_SPI
+	select REGMAP_SPI
 	tristate
 
 config IIO_ST_SENSORS_CORE
-- 
2.7.4


