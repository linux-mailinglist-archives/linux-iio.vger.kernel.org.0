Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF6C2C97C9
	for <lists+linux-iio@lfdr.de>; Tue,  1 Dec 2020 08:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgLAHEr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Dec 2020 02:04:47 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36402 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgLAHEq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Dec 2020 02:04:46 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B16xZ1c121762;
        Tue, 1 Dec 2020 07:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=+e+k1IhIlV7iD6NEvgAuIRoLa1eJN8esdqAZ+E40pKQ=;
 b=JEZRMhC9NaygGZLHQokgmZo7goGGsfZ1/OwiHOaiE5j6uNoctybKRYLFhPYNv8Uxdnzy
 muwTpzYWnwFzGECspTeOO3By/Ld1teklny7CdMee0Ge25seDG/zNgm+t/+cPcd+pXw0K
 4Dhg1S9ReoSrKujT60GJXdZ8vjht1fY6sJ/c9XSZENZxjdu9u2FZpu6HMD7llOrinkDo
 yd1HVgcCC+dogGOkwdtZY+t/Z77VNnC7H9DExb/JXsH4MOVLe7AIIL/ADpz3HONDz2dD
 ohYwcWUug934Q97XcmkeKWF0GmlD9Ev6nBFcxtwNZEgPoaQs1g5+JlSjk73BjCW6FNLE KQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 353egkgxhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Dec 2020 07:03:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B170IEG080922;
        Tue, 1 Dec 2020 07:03:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 3540artgdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Dec 2020 07:03:47 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B173fKv006567;
        Tue, 1 Dec 2020 07:03:41 GMT
Received: from mwanda (/41.210.145.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Nov 2020 23:03:40 -0800
Date:   Tue, 1 Dec 2020 10:03:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: sx9310: Off by one in sx9310_read_thresh()
Message-ID: <X8XqwK0z//8sSWJR@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010045
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012010045
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This > should be >= to prevent reading one element beyond the end of
the sx9310_pthresh_codes[] array.

Fixes: ad2b473e2ba3 ("iio: sx9310: Support setting proximity thresholds")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/proximity/sx9310.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index a2f820997afc..62eacb22e9bc 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -601,7 +601,7 @@ static int sx9310_read_thresh(struct sx9310_data *data,
 		return ret;
 
 	regval = FIELD_GET(SX9310_REG_PROX_CTRL8_9_PTHRESH_MASK, regval);
-	if (regval > ARRAY_SIZE(sx9310_pthresh_codes))
+	if (regval >= ARRAY_SIZE(sx9310_pthresh_codes))
 		return -EINVAL;
 
 	*val = sx9310_pthresh_codes[regval];
-- 
2.29.2

