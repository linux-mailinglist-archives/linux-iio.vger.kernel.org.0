Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCBA13CB4C
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2020 18:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgAORqV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jan 2020 12:46:21 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47670 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgAORqV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jan 2020 12:46:21 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FHca1q045369;
        Wed, 15 Jan 2020 17:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=djjnlZwo7Sn8C6YtSHjBV+KDTuecXFJyPA3THNfjWEo=;
 b=YCkov1XJcrulZMhYtohcHFiNrIw6i/PY5GcWzChTUbSrnzP8bIRh5Bv1MC8MhvJNog3B
 d6uls2kLd+KPdOGnu1evKagFcQMYFCOzbNTI6A465lKty6BdrGYOXu5DxkzWLEytK9ER
 YdAhqu+XF5cQXVS/G+Uu32cjvqMhlgoxx4uUOgKCNzjxzX/7qaewBNYA2rczHdg5v5Lb
 tAFNKP22QBNVcUetaF7zxX6eUntdLhEQUgObZP8w9WdIhuJC9bO7Uvg1Y7Ue1faei8O0
 VmnAj2Cq0N9zsnCWlAkjdxVGvxN/Xxgrbb9DNd1F3qmCFBRROZ50swc3DcCyBKfMVhU2 Wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xf73twka8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 17:45:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FHd8UU148598;
        Wed, 15 Jan 2020 17:45:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2xj1aq3cup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 17:45:47 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00FHjfEt025908;
        Wed, 15 Jan 2020 17:45:41 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jan 2020 09:45:40 -0800
Date:   Wed, 15 Jan 2020 20:45:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: accel: bma400: integer underflow setting accel scale
Message-ID: <20200115174531.p623ukjibn6kg6zz@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=821
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001150135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=873 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001150135
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

We put an upper bound on "val2" but we also need to prevent negative
values.

Fixes: 465c811f1f20 ("iio: accel: Add driver for the BMA400")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/accel/bma400_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index ab4a158b35af..ffc7b146bbfc 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -752,7 +752,7 @@ static int bma400_write_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&data->mutex);
 		return ret;
 	case IIO_CHAN_INFO_SCALE:
-		if (val != 0 || val2 > BMA400_SCALE_MAX)
+		if (val != 0 || val2 < 0 || val2 > BMA400_SCALE_MAX)
 			return -EINVAL;
 
 		mutex_lock(&data->mutex);
-- 
2.11.0

