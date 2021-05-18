Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59563875D6
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 11:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348046AbhERJ5r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 May 2021 05:57:47 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:36511 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240585AbhERJ5q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 May 2021 05:57:46 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee760a38f23f8f-8cff1; Tue, 18 May 2021 17:55:49 +0800 (CST)
X-RM-TRANSID: 2ee760a38f23f8f-8cff1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee760a38f213bf-b6a34;
        Tue, 18 May 2021 17:55:49 +0800 (CST)
X-RM-TRANSID: 2ee760a38f213bf-b6a34
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] staging: iio: cdc: ad7746: Remove unnecessary assignment in ad7746_probe()
Date:   Tue, 18 May 2021 17:56:47 +0800
Message-Id: <20210518095647.3008-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In the function ad7746_probe(), the initialized value of 'ret' is unused,
because it will be assigned by the function i2c_smbus_write_byte_data(),
thus remove it.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/staging/iio/cdc/ad7746.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index dfd71e99e..be4ef454d 100644
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
-- 
2.20.1.windows.1



