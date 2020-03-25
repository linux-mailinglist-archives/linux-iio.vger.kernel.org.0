Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF6611924E8
	for <lists+linux-iio@lfdr.de>; Wed, 25 Mar 2020 11:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgCYKBw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Mar 2020 06:01:52 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:37752 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727494AbgCYKBw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Mar 2020 06:01:52 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02P9tOP2028336;
        Wed, 25 Mar 2020 06:01:42 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ywcs6556j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Mar 2020 06:01:42 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 02PA1fAg008627
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 25 Mar 2020 06:01:41 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 25 Mar 2020 06:01:40 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 25 Mar 2020 06:01:40 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 25 Mar 2020 06:01:40 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 02PA1anO023841;
        Wed, 25 Mar 2020 06:01:36 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.ne>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2] iio: buffer: Don't allow buffers without any channels enabled to be activated
Date:   Wed, 25 Mar 2020 12:01:12 +0200
Message-ID: <20200325100112.85107-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320104031.31701-1-alexandru.ardelean@analog.com>
References: <20200320104031.31701-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_04:2020-03-23,2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1011 suspectscore=0 spamscore=0 mlxlogscore=961
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250085
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

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v1 -> v2:
* moved check in iio_verify_update()
* added dev_dbg() message; should help some folks understand the message
* documented steps to reproduce
* added Fixes tag; hopefully the tag is the good one; if needed, it can be
  dropped; this has been around for ~8 years; no idea if it's worth
  backporting

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

