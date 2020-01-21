Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C06F1441F2
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jan 2020 17:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgAUQSD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jan 2020 11:18:03 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40797 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgAUQSC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jan 2020 11:18:02 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1itwE2-00080m-0h; Tue, 21 Jan 2020 16:17:58 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] iio: st_sensors: handle memory allocation failure to fix null pointer dereference
Date:   Tue, 21 Jan 2020 16:17:57 +0000
Message-Id: <20200121161757.1498082-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

A null pointer deference on pdata can occur if the allocation of
pdata fails.  Fix this by adding a null pointer check and handle
the -ENOMEM failure in the caller.

Addresses-Coverity: ("Dereference null return value")
Fixes: 3ce85cc4fbb7 ("iio: st_sensors: get platform data from device tree")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index e051edbc43c1..0e35ff06f9af 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -328,6 +328,8 @@ static struct st_sensors_platform_data *st_sensors_dev_probe(struct device *dev,
 		return NULL;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
 	if (!device_property_read_u32(dev, "st,drdy-int-pin", &val) && (val <= 2))
 		pdata->drdy_int_pin = (u8) val;
 	else
@@ -371,6 +373,8 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
 
 	/* If OF/DT pdata exists, it will take precedence of anything else */
 	of_pdata = st_sensors_dev_probe(indio_dev->dev.parent, pdata);
+	if (IS_ERR(of_pdata))
+		return PTR_ERR(of_pdata);
 	if (of_pdata)
 		pdata = of_pdata;
 
-- 
2.24.0

