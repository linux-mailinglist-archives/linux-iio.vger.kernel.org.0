Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC9F4E358
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2019 11:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfFUJVT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Jun 2019 05:21:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56184 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfFUJVT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Jun 2019 05:21:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5L9JHUd194099;
        Fri, 21 Jun 2019 09:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=zT2CBFR2VSrK59MbhHs/hGKzXGFLl4/Syz7m1oPdgwc=;
 b=SrMdcNUkRaEymSD6Cx01YJYn2dw8HgdlW5Uzcg7rnNg3kUDiuNg1ztwr7rqhzC53n/Qp
 TKApWtEQ0P9gv285PX7Rcki3PnNvkZTyRgfwhX7QnhU+9fJnwaj9/HLVzgOP+k5mdh6z
 akgBpJDZQTD5i+jqOvLzK6JC+O1dyCYB5drCjeVmXDZQqm5Ljqm2G57QTOFcrceEidd/
 zdnv1RaZFrc75XBzQn9S7wQ3iC8S+EW3PgbeiPVxnbkTjySW9APv5VNM1lT1IhJrXajW
 cQOGZVXQzLmQwBUsGHJtFuAXJv04tMglzVYJtM+AUp/GV1pqhi3UMrTyjIu6DsALJY/H RA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2t7809nge0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jun 2019 09:20:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5L9IY24037988;
        Fri, 21 Jun 2019 09:18:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2t77ypunkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jun 2019 09:18:42 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5L9IbnC019020;
        Fri, 21 Jun 2019 09:18:37 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Jun 2019 02:18:37 -0700
Date:   Fri, 21 Jun 2019 12:18:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: sca3000: Potential endian bug in
 sca3000_read_event_value()
Message-ID: <20190621091828.GA1878@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906210077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906210078
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The problem is that "ret" is an int but we're casting it as
"(unsigned long *)&ret" when we do the for_each_set_bit() loop.  This
will not work on big endian 64 bit systems.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/accel/sca3000.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 4964561595f5..9e9f4347a325 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -872,8 +872,9 @@ static int sca3000_read_event_value(struct iio_dev *indio_dev,
 				    enum iio_event_info info,
 				    int *val, int *val2)
 {
-	int ret, i;
 	struct sca3000_state *st = iio_priv(indio_dev);
+	long ret;
+	int i;
 
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
@@ -885,11 +886,11 @@ static int sca3000_read_event_value(struct iio_dev *indio_dev,
 			return ret;
 		*val = 0;
 		if (chan->channel2 == IIO_MOD_Y)
-			for_each_set_bit(i, (unsigned long *)&ret,
+			for_each_set_bit(i, &ret,
 					 ARRAY_SIZE(st->info->mot_det_mult_y))
 				*val += st->info->mot_det_mult_y[i];
 		else
-			for_each_set_bit(i, (unsigned long *)&ret,
+			for_each_set_bit(i, &ret,
 					 ARRAY_SIZE(st->info->mot_det_mult_xz))
 				*val += st->info->mot_det_mult_xz[i];
 
-- 
2.20.1

