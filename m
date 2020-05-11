Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956441CDA81
	for <lists+linux-iio@lfdr.de>; Mon, 11 May 2020 14:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgEKMx5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 May 2020 08:53:57 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:37794 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726021AbgEKMx5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 May 2020 08:53:57 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04BCjEKM003361;
        Mon, 11 May 2020 08:53:56 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 30wpc7wesp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 08:53:55 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 04BCrsEo038053
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 11 May 2020 08:53:54 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 11 May 2020 05:53:53 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 11 May 2020 05:53:52 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04BCro45017213;
        Mon, 11 May 2020 08:53:51 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: buffer: remove attrcount_orig var from sysfs creation
Date:   Mon, 11 May 2020 15:53:22 +0300
Message-ID: <20200511125322.17147-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-11_05:2020-05-11,2020-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=2 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005110105
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The variable no longer does anything.
It should have been removed with commit 2e036804d773e ("iio: buffer: remove
'scan_el_attrs' attribute group from buffer struct").
That was about the last time this was needed.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

If desired (and still possible) this can be squashed in
commit 2e036804d773e ("iio: buffer: remove 'scan_el_attrs' attribute group
from buffer struct").

 drivers/iio/industrialio-buffer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index eae39eaf49af..386c9231c2ee 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1244,7 +1244,7 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	struct iio_dev_attr *p;
 	struct attribute **attr;
 	struct iio_buffer *buffer = indio_dev->buffer;
-	int ret, i, attrn, attrcount, attrcount_orig = 0;
+	int ret, i, attrn, attrcount;
 	const struct iio_chan_spec *channels;
 
 	channels = indio_dev->channels;
@@ -1288,7 +1288,7 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 
 	indio_dev->groups[indio_dev->groupcounter++] = &buffer->buffer_group;
 
-	attrcount = attrcount_orig;
+	attrcount = 0;
 	INIT_LIST_HEAD(&buffer->scan_el_dev_attr_list);
 	channels = indio_dev->channels;
 	if (channels) {
@@ -1325,7 +1325,7 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 		ret = -ENOMEM;
 		goto error_free_scan_mask;
 	}
-	attrn = attrcount_orig;
+	attrn = 0;
 
 	list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l)
 		buffer->scan_el_group.attrs[attrn++] = &p->dev_attr.attr;
-- 
2.17.1

