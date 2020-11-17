Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0551A2B5C15
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 10:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgKQJql (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 04:46:41 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:36884 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727454AbgKQJql (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 04:46:41 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AH9giYG000518;
        Tue, 17 Nov 2020 04:46:39 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 34td198mqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 04:46:39 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0AH9kbRE012548
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 17 Nov 2020 04:46:38 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 17 Nov 2020 01:46:36 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 17 Nov 2020 01:46:36 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AH9kYmE016296;
        Tue, 17 Nov 2020 04:46:34 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: core: return -EINVAL when no ioctl handler has been run
Date:   Tue, 17 Nov 2020 11:51:54 +0200
Message-ID: <20201117095154.7189-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_03:2020-11-13,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170071
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

It seems that when this was tested the happy case was more tested. A few of
the userspace apps rely on this returning negative error codes in case an
ioctl() is not available.

When running multiple ioctl() handlers or when calling an ioctl() that
doesn't exist, IIO_IOCTL_UNHANDLED is returned. In that case -EINVAL should
be returned.

Fixes: 8dedcc3eee3a ("iio: core: centralize ioctl() calls to the main chardev")
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Apologies for not noticing this earlier.
This came up when trying to write more IIO buffer code.

From my side either is fine: whether it be applied as a fix or whether
it's squashed into the original patch.

 drivers/iio/industrialio-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e53c771d66eb..419d6f8acc13 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1743,6 +1743,9 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			break;
 	}
 
+	if (ret == IIO_IOCTL_UNHANDLED)
+		ret = -EINVAL;
+
 out_unlock:
 	mutex_unlock(&indio_dev->info_exist_lock);
 
-- 
2.17.1

