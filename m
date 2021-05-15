Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F6538175C
	for <lists+linux-iio@lfdr.de>; Sat, 15 May 2021 11:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhEOJxl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 May 2021 05:53:41 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25920 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230050AbhEOJxh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 May 2021 05:53:37 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14F9geDb020591;
        Sat, 15 May 2021 09:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=i3jQaG3KuiG1p0f05eiUOh7Ps5KUA+gcVhttWIXzEyI=;
 b=CnUwE0e+CjCTTClIsKCBNfDlj1c1/El27rMJa6R0VSv0OFOOp6Ulk16HVCVaU3L3m/oy
 SCSS1yiNQtnehNncLusZ8nqlndEH1Qh/bBzHUzPbCZ5217kfOX4NHNpFwFLnALk69yry
 d1pxl+lmMs+mVp/KHuarGozlN0uW2BNKdkJM0th766hJlyQw/Wx5CZ62IHvTTWBJIlhk
 cq2XxWmhZbr+pOSe3wDYdoLY32gWlaNAGlzhkR+R9Wg8xnBVJrGYLtmXtCnrs30kD/gP
 tOWLlEwjGp2eeTQkXdfl3WFBLGmVqR1r88ictYvkXIjhE2OK6SaiY3qF3tS/i+1Kzrj5 Lg== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38j5ws02m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 May 2021 09:52:06 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14F9l4NI176321;
        Sat, 15 May 2021 09:52:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38j5mj909q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 May 2021 09:52:05 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14F9q5Vf182994;
        Sat, 15 May 2021 09:52:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 38j5mj909a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 May 2021 09:52:05 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14F9pxSE019238;
        Sat, 15 May 2021 09:51:59 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 15 May 2021 02:51:59 -0700
Date:   Sat, 15 May 2021 12:51:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Oleksij Rempel <linux@rempel-privat.de>
Cc:     kernel@pengutronix.de, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: adc: tsc2046: fix a warning message in
 tsc2046_adc_update_scan_mode()
Message-ID: <YJ+ZuO43TnguY5vq@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-ORIG-GUID: GJQAi4AauFsY6iJ2zPUcEGB5JWDyaQHT
X-Proofpoint-GUID: GJQAi4AauFsY6iJ2zPUcEGB5JWDyaQHT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These variables are unsigned so the condition can't be less than zero
and the warning message will never be printed.

Fixes: 5fec3541aa88 ("iio: adc: add ADC driver for the TI TSC2046 controller")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/adc/ti-tsc2046.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index 89a818b653b4..cf5373d5cdd7 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -398,7 +398,7 @@ static int tsc2046_adc_update_scan_mode(struct iio_dev *indio_dev,
 	priv->xfer.len = size;
 	priv->time_per_scan_us = size * 8 * priv->time_per_bit_ns / NSEC_PER_USEC;
 
-	if ((priv->scan_interval_us - priv->time_per_scan_us) < 0)
+	if (priv->scan_interval_us > priv->time_per_scan_us)
 		dev_warn(&priv->spi->dev, "The scan interval (%d) is less then calculated scan time (%d)\n",
 			 priv->scan_interval_us, priv->time_per_scan_us);
 
-- 
2.30.2

