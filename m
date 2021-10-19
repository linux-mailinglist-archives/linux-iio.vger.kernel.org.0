Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CD543333C
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 12:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbhJSKMY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 06:12:24 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:10102 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbhJSKMY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Oct 2021 06:12:24 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec616e9736f35-fb483; Tue, 19 Oct 2021 18:00:23 +0800 (CST)
X-RM-TRANSID: 2eec616e9736f35-fb483
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee3616e97244be-dc621;
        Tue, 19 Oct 2021 18:00:23 +0800 (CST)
X-RM-TRANSID: 2ee3616e97244be-dc621
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     jic23@kernel.org, lars@metafoo.de, heiko@sntech.de
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH 2/3] iio: adc: max9611: Use of_device_get_match_data to simplify code
Date:   Tue, 19 Oct 2021 18:00:12 +0800
Message-Id: <20211019100013.27312-3-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20211019100013.27312-1-tangbin@cmss.chinamobile.com>
References: <20211019100013.27312-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Retrieve OF match data, it's better and cleaner to use
'of_device_get_match_data' over 'of_match_device'.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/iio/adc/max9611.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
index 052ab23f1..4e754c072 100644
--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -514,8 +514,6 @@ static int max9611_probe(struct i2c_client *client,
 {
 	const char * const shunt_res_prop = "shunt-resistor-micro-ohms";
 	const struct device_node *of_node = client->dev.of_node;
-	const struct of_device_id *of_id =
-		of_match_device(max9611_of_table, &client->dev);
 	struct max9611_dev *max9611;
 	struct iio_dev *indio_dev;
 	unsigned int of_shunt;
@@ -545,7 +543,7 @@ static int max9611_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
-	indio_dev->name		= of_id->data;
+	indio_dev->name		= of_device_get_match_data(&client->dev);
 	indio_dev->modes	= INDIO_DIRECT_MODE;
 	indio_dev->info		= &indio_info;
 	indio_dev->channels	= max9611_channels;
-- 
2.20.1.windows.1



