Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082D6433305
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 12:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbhJSKDA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 06:03:00 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:44690 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbhJSKC7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Oct 2021 06:02:59 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee1616e9737608-fa8e3; Tue, 19 Oct 2021 18:00:25 +0800 (CST)
X-RM-TRANSID: 2ee1616e9737608-fa8e3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee3616e97244be-dc62a;
        Tue, 19 Oct 2021 18:00:25 +0800 (CST)
X-RM-TRANSID: 2ee3616e97244be-dc62a
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     jic23@kernel.org, lars@metafoo.de, heiko@sntech.de
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH 3/3] iio: adc: twl6030-gpadc: Use of_device_get_match_data to simplify code
Date:   Tue, 19 Oct 2021 18:00:13 +0800
Message-Id: <20211019100013.27312-4-tangbin@cmss.chinamobile.com>
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
 drivers/iio/adc/twl6030-gpadc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index c6416ad79..0859f3f7d 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -867,17 +867,14 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct twl6030_gpadc_data *gpadc;
 	const struct twl6030_gpadc_platform_data *pdata;
-	const struct of_device_id *match;
 	struct iio_dev *indio_dev;
 	int irq;
 	int ret;
 
-	match = of_match_device(of_twl6030_match_tbl, dev);
-	if (!match)
+	pdata = of_device_get_match_data(dev);
+	if (!pdata)
 		return -EINVAL;
 
-	pdata = match->data;
-
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*gpadc));
 	if (!indio_dev)
 		return -ENOMEM;
-- 
2.20.1.windows.1



