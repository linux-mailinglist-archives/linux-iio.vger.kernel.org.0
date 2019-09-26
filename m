Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4525BED23
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 10:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbfIZIMy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 04:12:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56624 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729394AbfIZIMy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 04:12:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8Q8938N143494;
        Thu, 26 Sep 2019 08:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=nHvD6qHssEaWW5ffwT7IOeDd0XSJWsWGV8kA52kIHrk=;
 b=X+6L0T5yKArXU+XgMIh6S/Ef5GWy0+GxT9A+BIZF0CWZgR9PVFxu4ahv1rSVai5ikMRt
 pC5WYg6XkvW3+LnayJUdDtlVt6nfmKmSNoUypBMT8G0eeGkGMWFBSnIkYzM0Q8JeedKd
 FyCv2+GQ4zM6TLAVzORNllrpSiErDoOwp4e5tev0pcCd3jj9YNH0GQoMfH5B1dBzYEOt
 DzQr7bjHr7S/svIjg+wBJGg+FIl8FT05FEFw6Z/BREF78worz1oO7COlwZJWhOo1xKaR
 CANjezhPQqAVhBhxImZOYQnd2N0M2biUIFZWlv1XKVys8KcLOLTWpIKbezYYTUybmMBD Gg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2v5b9u20m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Sep 2019 08:12:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8Q88pAd052677;
        Thu, 26 Sep 2019 08:10:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2v7vp0rcaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Sep 2019 08:10:33 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8Q8AQhI020500;
        Thu, 26 Sep 2019 08:10:26 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Sep 2019 01:10:25 -0700
Date:   Thu, 26 Sep 2019 11:10:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: imu: adis16480: clean up a condition
Message-ID: <20190926081016.GA2332@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9391 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909260080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9391 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909260080
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The "t" variable is unsigned so it can't be less than zero.  We really
are just trying to prevent divide by zero bugs so just checking against
zero is sufficient.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/imu/adis16480.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index b99d73887c9f..e144e567675d 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -318,7 +318,7 @@ static int adis16480_set_freq(struct iio_dev *indio_dev, int val, int val2)
 	unsigned int t, reg;
 
 	t =  val * 1000 + val2 / 1000;
-	if (t <= 0)
+	if (t == 0)
 		return -EINVAL;
 
 	/*
-- 
2.20.1

