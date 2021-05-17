Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97943833D5
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 17:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241634AbhEQPCp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 11:02:45 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:36510 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241379AbhEQPAl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 May 2021 11:00:41 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee760a284bd938-7a86d; Mon, 17 May 2021 22:59:09 +0800 (CST)
X-RM-TRANSID: 2ee760a284bd938-7a86d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.22.251.112])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee360a284b91a9-6be9a;
        Mon, 17 May 2021 22:59:09 +0800 (CST)
X-RM-TRANSID: 2ee360a284b91a9-6be9a
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] staging: iio: cdc: ad7746: Fix unnecessary check and assignment in ad7746_probe()
Date:   Mon, 17 May 2021 23:00:06 +0800
Message-Id: <20210517150006.8436-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In the function ad7746_probe(), the return value of
devm_iio_device_register() can be zero or ret, thus it is
unnecessary to repeated check here. And delete unused
initialized value of 'ret', because it will be assigned by
the function i2c_smbus_write_byte_data().

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/staging/iio/cdc/ad7746.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index dfd71e99e..d3b6e68df 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -680,7 +680,7 @@ static int ad7746_probe(struct i2c_client *client,
 	struct ad7746_chip_info *chip;
 	struct iio_dev *indio_dev;
 	unsigned char regval = 0;
-	int ret = 0;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
 	if (!indio_dev)
@@ -730,11 +730,7 @@ static int ad7746_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
-	if (ret)
-		return ret;
-
-	return 0;
+	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
 }
 
 static const struct i2c_device_id ad7746_id[] = {
-- 
2.20.1.windows.1



