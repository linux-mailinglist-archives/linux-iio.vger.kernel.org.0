Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E036193BFA
	for <lists+linux-iio@lfdr.de>; Thu, 26 Mar 2020 10:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgCZJf6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Mar 2020 05:35:58 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:9324 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727911AbgCZJf6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Mar 2020 05:35:58 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02Q9PJJ9002741;
        Thu, 26 Mar 2020 05:30:46 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ywcs68gnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Mar 2020 05:30:45 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 02Q9UiYU013848
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 26 Mar 2020 05:30:44 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 26 Mar
 2020 02:30:42 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 26 Mar 2020 02:30:42 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 02Q9Uchj022178;
        Thu, 26 Mar 2020 05:30:39 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3] iio: buffer: Don't allow buffers without any channels enabled to be activated
Date:   Thu, 26 Mar 2020 11:30:12 +0200
Message-ID: <20200326093012.10758-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320104031.31701-1-alexandru.ardelean@analog.com>
References: <20200320104031.31701-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_15:2020-03-24,2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260070
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Before activating a buffer make sure that at least one channel is enabled.
Activating a buffer with 0 channels enabled doesn't make too much sense and
disallowing this case makes sure that individual driver don't have to add
special case code to handle it.

Currently, without this patch enabling a buffer is possible and no error is
produced. With this patch -EINVAL is returned.

An example of execution with this patch and some instrumented print-code:
   root@analog:~# cd /sys/bus/iio/devices/iio\:device3/buffer
   root@analog:/sys/bus/iio/devices/iio:device3/buffer# echo 1 > enable
   0: iio_verify_update 748 indio_dev->masklength 2 *insert_buffer->scan_mask 00000000
   1: iio_verify_update 753
   2:__iio_update_buffers 1115 ret -22
   3: iio_buffer_store_enable 1241 ret -22
   -bash: echo: write error: Invalid argument
1, 2 & 3 are exit-error paths. 0 the first print in iio_verify_update()
rergardless of error path.

Without this patch (and same instrumented print-code):
   root@analog:~# cd /sys/bus/iio/devices/iio\:device3/buffer
   root@analog:/sys/bus/iio/devices/iio:device3/buffer# echo 1 > enable
   0: iio_verify_update 748 indio_dev->masklength 2 *insert_buffer->scan_mask 00000000
   root@analog:/sys/bus/iio/devices/iio:device3/buffer#
Buffer is enabled with no error.

Fixes: 84b36ce5f79c0 ("staging:iio: Add support for multiple buffers")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v2 -> v3:
* actually added Fixes tag; seems I forgot it in v2
  hopefully the tag is the good one; if needed, it can be
  dropped; this has been around for ~8 years; no idea if it's worth
  backporting

Changelog v1 -> v2:
* moved check in iio_verify_update()
* added dev_dbg() message; should help some folks understand the message
* documented steps to reproduce

 drivers/iio/industrialio-buffer.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 5ff34ce8b6a2..e6fa1a4e135d 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -686,6 +686,13 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 	bool scan_timestamp;
 	unsigned int modes;
 
+	if (insert_buffer &&
+	    bitmap_empty(insert_buffer->scan_mask, indio_dev->masklength)) {
+		dev_dbg(&indio_dev->dev,
+			"At least one scan element must be enabled first\n");
+		return -EINVAL;
+	}
+
 	memset(config, 0, sizeof(*config));
 	config->watermark = ~0;
 
-- 
2.17.1

