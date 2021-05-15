Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2736E381766
	for <lists+linux-iio@lfdr.de>; Sat, 15 May 2021 11:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhEOJ6V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 May 2021 05:58:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23662 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229524AbhEOJ6U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 May 2021 05:58:20 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14F9up9g012351;
        Sat, 15 May 2021 09:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=GqrNa5uNBgqVsaPsHUsO5abZ7tUwUaybjdRdc66DJAU=;
 b=cHPsKS7JYItkB31pDQKRLR66QHnGL3IK62AaOBBDqRlBOoM1pwjyQK6IzjUkViLDm06m
 v81TMy1+l+Rrx+tTS4tljszJl+jORxquO4ZgayNCUK78aDdXJUlF87cKSrrLbQZ0H4uq
 dOi+wT9h+aMIC2E6B5ekp+nk+Bo2evMXp1ZPssbamp4j4zW5U+dXuHxsS+YPTZYp7Wqv
 IUlEOnG3X7r/V4JxR1z7NDFdiJJ7FVyYP2QYazZvt0ShAK1OIBOPpUZNaBeGQbL6trho
 x2VDDhA158L/49SkkNJfMQ/TUsfJKJR0jJ9Bd9tDAB/ZprtWeBzoeXXvIh80ovmJ9XmE ow== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 38j4w1035q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 May 2021 09:56:50 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14F9unXc094873;
        Sat, 15 May 2021 09:56:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38j3drhkv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 May 2021 09:56:49 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14F9unoD094866;
        Sat, 15 May 2021 09:56:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 38j3drhkv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 May 2021 09:56:49 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14F9ukZw021608;
        Sat, 15 May 2021 09:56:46 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 15 May 2021 09:56:45 +0000
Date:   Sat, 15 May 2021 12:56:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: core: Fix an error pointer vs NULL bug in
 devm_iio_device_alloc()
Message-ID: <YJ+a1yaMu2QNATgt@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-GUID: v70MGB_Y5MgZqI8F2_0QIkIfDeX9M7lw
X-Proofpoint-ORIG-GUID: v70MGB_Y5MgZqI8F2_0QIkIfDeX9M7lw
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The devm_iio_device_alloc() function is supposed to return NULL and not
error pointers.  Returning an error pointer will lead to a crash in the
callers.

Fixes: d240dc25e3b8 ("iio: core: simplify some devm functions")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/industrialio-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index bfa20a346f71..75e92bac78f3 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1711,7 +1711,7 @@ struct iio_dev *devm_iio_device_alloc(struct device *parent, int sizeof_priv)
 	ret = devm_add_action_or_reset(parent, devm_iio_device_release,
 				       iio_dev);
 	if (ret)
-		return ERR_PTR(ret);
+		return NULL;
 
 	return iio_dev;
 }
-- 
2.30.2

