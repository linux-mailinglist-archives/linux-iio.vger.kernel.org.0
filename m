Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891AD1B6D13
	for <lists+linux-iio@lfdr.de>; Fri, 24 Apr 2020 07:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgDXFSK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Apr 2020 01:18:10 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:32638 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726072AbgDXFSK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Apr 2020 01:18:10 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03O548Ev004974;
        Fri, 24 Apr 2020 01:17:58 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fxf6cua4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 01:17:57 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 03O5HuXu049540
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 24 Apr 2020 01:17:56 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 24 Apr 2020 01:17:55 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 24 Apr 2020 01:17:55 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 24 Apr 2020 01:17:55 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03O5HnSU025747;
        Fri, 24 Apr 2020 01:17:53 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 3/4] iio: Allow channels to share storage elements
Date:   Fri, 24 Apr 2020 08:18:17 +0300
Message-ID: <20200424051818.6408-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424051818.6408-1-alexandru.ardelean@analog.com>
References: <20200424051818.6408-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_01:2020-04-23,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240037
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Currently each IIO channel has it's own storage element in the data stream
each with its own unique scan index. This works for a lot of use-cases,
but in some is not good enough to represent the hardware accurately. On
those devices multiple separate pieces of information are stored within the
same storage element and the storage element can't be further broken down
into multiple storage elements (e.g. because the data is not aligned).

This can for example be status bits stored in unused data bits. E.g. a
14-bit ADC that stores its data in a 16-bit word and uses the two
additional bits to convey status information like for example whether a
overrange condition has happened. Currently this kind of extra status
information is usually ignored and can only be used by applications that
have special knowledge about the connected device and its data layout.

In addition to that some might also have data channels with less than 8
bits that get packed into the same storage element.

Allow two or more channels to use the same scan index, if they their
storage element does have the same size.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-core.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f4daf19f2a3b..cdf59a51c917 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1651,6 +1651,16 @@ static const struct file_operations iio_buffer_fileops = {
 	.compat_ioctl = compat_ptr_ioctl,
 };
 
+static bool iio_chan_same_size(const struct iio_chan_spec *a,
+	const struct iio_chan_spec *b)
+{
+	if (a->scan_type.storagebits != b->scan_type.storagebits)
+		return false;
+	if (a->scan_type.repeat != b->scan_type.repeat)
+		return false;
+	return true;
+}
+
 static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
 {
 	int i, j;
@@ -1662,13 +1672,16 @@ static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
 	for (i = 0; i < indio_dev->num_channels - 1; i++) {
 		if (channels[i].scan_index < 0)
 			continue;
-		for (j = i + 1; j < indio_dev->num_channels; j++)
-			if (channels[i].scan_index == channels[j].scan_index) {
-				dev_err(&indio_dev->dev,
-					"Duplicate scan index %d\n",
-					channels[i].scan_index);
-				return -EINVAL;
-			}
+		for (j = i + 1; j < indio_dev->num_channels; j++) {
+			if (channels[i].scan_index != channels[j].scan_index)
+				continue;
+			if (iio_chan_same_size(&channels[i], &channels[j]))
+				continue;
+			dev_err(&indio_dev->dev,
+				"Duplicate scan index %d\n",
+				channels[i].scan_index);
+			return -EINVAL;
+		}
 	}
 
 	return 0;
-- 
2.17.1

