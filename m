Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62E81B3B91
	for <lists+linux-iio@lfdr.de>; Wed, 22 Apr 2020 11:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgDVJin (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 05:38:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36960 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgDVJin (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Apr 2020 05:38:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03M9Wfw0003602;
        Wed, 22 Apr 2020 09:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=IC+0pG/Aso4gbz60Thi7u+NMmxwUC7iGIz6CNHJpJTA=;
 b=FA/mUWMc/r7dc+4ycPnu5hgia89DHFnIWKW87LdH7oatVWbBzvyY7Ge6Brec12QcqdOu
 K403bXFpmkDw68GSR+2U+AWyKWvdw5rIskv5WFJ4exb+tp0e+FYYKDTGdbR4z8Y0T8ua
 MxmgnlYtrcuiZl2WEHwFPRCM7/bNEmbDNMnKe8ehJWr/Cg2q0ExISnVnlJO/hv+W9mcM
 CqIL8JYzKgLWXazhscHUvp8PXsAbfJVLd9F2z2lOQiJBEVZGl5ouuHtKuC688RptNkCP
 dfK04cIUnVxwRuRXJkWhzB2wrXlcTmMAa8LuU/jeDVRFOWx8flfong/Tri4n4WIGVTb4 Pg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 30jhyc0jb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Apr 2020 09:38:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03M9bmUU102774;
        Wed, 22 Apr 2020 09:38:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30gb3tmu3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Apr 2020 09:38:22 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03M9cIL8029014;
        Wed, 22 Apr 2020 09:38:18 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Apr 2020 02:38:17 -0700
Date:   Wed, 22 Apr 2020 12:38:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: imu: st_lsm6dsx: unlock on error in
 st_lsm6dsx_shub_write_raw()
Message-ID: <20200422093811.GA196034@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004220076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 clxscore=1011 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004220076
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

We need to release a lock if st_lsm6dsx_check_odr() fails, we can't
return directly.

Fixes: 76551a3c3df1 ("iio: imu: st_lsm6dsx: specify slave odr in slv_odr")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index 64ef07a30726..1cf98195f84d 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -544,8 +544,10 @@ st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
 
 			ref_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
 			odr = st_lsm6dsx_check_odr(ref_sensor, val, &odr_val);
-			if (odr < 0)
-				return odr;
+			if (odr < 0) {
+				err = odr;
+				goto release;
+			}
 
 			sensor->ext_info.slv_odr = val;
 			sensor->odr = odr;
@@ -557,6 +559,7 @@ st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
 		break;
 	}
 
+release:
 	iio_device_release_direct_mode(iio_dev);
 
 	return err;
-- 
2.26.1

