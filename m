Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E5D2DFD48
	for <lists+linux-iio@lfdr.de>; Mon, 21 Dec 2020 16:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgLUPMh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Dec 2020 10:12:37 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:49024 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725857AbgLUPMh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Dec 2020 10:12:37 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BLF0Qj8026470;
        Mon, 21 Dec 2020 10:11:43 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 35hc8bdpxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Dec 2020 10:11:43 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0BLFBfhL051814
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 21 Dec 2020 10:11:41 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 21 Dec 2020 07:11:40 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 21 Dec 2020 07:11:40 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0BLFBbKm001107;
        Mon, 21 Dec 2020 10:11:38 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4] iio: Handle enumerated properties with gaps
Date:   Mon, 21 Dec 2020 17:15:51 +0200
Message-ID: <20201221151551.52511-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-21_08:2020-12-21,2020-12-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=860 spamscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 clxscore=1015 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012210107
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Some enums might have gaps or reserved values in the middle of their value
range. E.g. consider a 2-bit enum where the values 0, 1 and 3 have a
meaning, but 2 is a reserved value and can not be used.

Add support for such enums to the IIO enum helper functions. A reserved
values is marked by setting its entry in the items array to NULL rather
than the normal descriptive string value.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Nearly 1 year and a half since I last touched this:
https://lore.kernel.org/linux-iio/20190508111913.7276-3-alexandru.ardelean@analog.com/

I tried a few shots at working with 'lib/string.c', and that went
slow. The __sysfs_match_string_with_gaps() approach has stalled.
https://lore.kernel.org/linux-iio/20190422140251.8960-1-alexandru.ardelean@analog.com/

I also tried to update the __sysfs_match_string() implementation based
on what the docstring said,
https://lore.kernel.org/lkml/20200212144723.21884-1-alexandru.ardelean@analog.com/

but then I just fixed the docstring to match
what the behavior does:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git/commit/lib/string.c?id=c11d3fa0116a6bc832a9e387427caa16f8de5ef2

In the end, for this patch, it means expanding the
__sysfs_match_string() helper.

 drivers/iio/industrialio-core.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e9ee9363fed0..a88494066811 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -470,8 +470,11 @@ ssize_t iio_enum_available_read(struct iio_dev *indio_dev,
 	if (!e->num_items)
 		return 0;
 
-	for (i = 0; i < e->num_items; ++i)
+	for (i = 0; i < e->num_items; ++i) {
+		if (!e->items[i])
+			continue;
 		len += scnprintf(buf + len, PAGE_SIZE - len, "%s ", e->items[i]);
+	}
 
 	/* replace last space with a newline */
 	buf[len - 1] = '\n';
@@ -492,7 +495,7 @@ ssize_t iio_enum_read(struct iio_dev *indio_dev,
 	i = e->get(indio_dev, chan);
 	if (i < 0)
 		return i;
-	else if (i >= e->num_items)
+	else if (i >= e->num_items || !e->items[i])
 		return -EINVAL;
 
 	return snprintf(buf, PAGE_SIZE, "%s\n", e->items[i]);
@@ -504,16 +507,21 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
 	size_t len)
 {
 	const struct iio_enum *e = (const struct iio_enum *)priv;
+	unsigned int i;
 	int ret;
 
 	if (!e->set)
 		return -EINVAL;
 
-	ret = __sysfs_match_string(e->items, e->num_items, buf);
-	if (ret < 0)
-		return ret;
+	for (i = 0; i < e->num_items; i++) {
+		if (e->items[i] && sysfs_streq(buf, e->items[i]))
+			break;
+	}
+
+	if (i == e->num_items)
+		return -EINVAL;
 
-	ret = e->set(indio_dev, chan, ret);
+	ret = e->set(indio_dev, chan, i);
 	return ret ? ret : len;
 }
 EXPORT_SYMBOL_GPL(iio_enum_write);
-- 
2.17.1

