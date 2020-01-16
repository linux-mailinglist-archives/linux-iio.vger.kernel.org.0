Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79B0B13D78A
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2020 11:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgAPKJR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jan 2020 05:09:17 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51722 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgAPKJR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jan 2020 05:09:17 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00GA8GHr015380;
        Thu, 16 Jan 2020 10:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2019-08-05; bh=KInu5peAt1tlPwKg/nlSGqRBGWGQeH2eHgOPlsDWzwU=;
 b=b7ma62VgvXZ4p178qAlwn/1g8GAhzkKdVcSCs+wl8rD1f0rmKhJyOHbGFPBe7oLkmfMU
 EGtn1J0kEInCjv6V7XYa0/wDPxdbesG3XgFx1WGK9XRv4yxLjmarbwuzJ3vaFC6RnQF/
 elKmEQRjdw+UJL4Giw+ZmnUG56QDLJ9wMEjQMkIZHxRxSTaQovgCmDwT3IPkUfMl67Sc
 jCzDQ7ZuwKn6ya0hpaTRxbGigm3ooeeJJWD9C6rIQ23KD19m9SyNBXlVUSvc8K2leZ+7
 LLT16iSGwfiaaLLz1DTKCsyNAz/DmKO9+MQmgLAmDXuG2VKsr9GrKM+SgVQ18OCQmU7v Sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xf73ysjpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 10:08:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00GA49YX012902;
        Thu, 16 Jan 2020 10:08:44 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2xhy231vvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 10:08:44 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00GA8c1n025707;
        Thu, 16 Jan 2020 10:08:38 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Jan 2020 02:08:38 -0800
Date:   Thu, 16 Jan 2020 13:08:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] iio: accel: bma400: prevent setting accel scale too low
Message-ID: <20200116100829.thq77nvyqtasdu4j@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115181717.GA22797@nessie>
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=917
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001160085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=976 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001160086
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This puts an upper bound on "val2" but it also needs to have a lower
bound (BMA400_SCALE_MIN).

Fixes: 465c811f1f20 ("iio: accel: Add driver for the BMA400")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: the first version just capped it at zero but it should be
    BMA400_SCALE_MIN (38357).

 drivers/iio/accel/bma400_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index ab4a158b35af..cc77f89c048b 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -752,7 +752,8 @@ static int bma400_write_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&data->mutex);
 		return ret;
 	case IIO_CHAN_INFO_SCALE:
-		if (val != 0 || val2 > BMA400_SCALE_MAX)
+		if (val != 0 ||
+		    val2 < BMA400_SCALE_MIN || val2 > BMA400_SCALE_MAX)
 			return -EINVAL;
 
 		mutex_lock(&data->mutex);
-- 
2.11.0

