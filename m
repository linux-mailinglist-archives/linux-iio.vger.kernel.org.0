Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D076C31D6A1
	for <lists+linux-iio@lfdr.de>; Wed, 17 Feb 2021 09:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhBQIeC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Feb 2021 03:34:02 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:52376 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231871AbhBQIdq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Feb 2021 03:33:46 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11H8ULvX026114;
        Wed, 17 Feb 2021 03:32:54 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 36p9gb2huk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Feb 2021 03:32:54 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 11H8WqGp055869
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Feb 2021 03:32:53 -0500
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Wed, 17 Feb 2021 00:32:51 -0800
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Wed, 17 Feb 2021 00:32:50 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Wed, 17 Feb 2021 00:32:50 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11H8WWlH007757;
        Wed, 17 Feb 2021 03:32:47 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 3/5] iio: kfifo-buffer: Add output buffer support
Date:   Wed, 17 Feb 2021 10:34:36 +0200
Message-ID: <20210217083438.37865-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210217083438.37865-1-alexandru.ardelean@analog.com>
References: <20210217083438.37865-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-17_06:2021-02-16,2021-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102170064
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Add output buffer support to the kfifo buffer implementation.

The implementation is straight forward and mostly just wraps the kfifo
API to provide the required operations.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/buffer/kfifo_buf.c | 50 ++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
index 34289ce12f20..e8a434f84778 100644
--- a/drivers/iio/buffer/kfifo_buf.c
+++ b/drivers/iio/buffer/kfifo_buf.c
@@ -138,10 +138,60 @@ static void iio_kfifo_buffer_release(struct iio_buffer *buffer)
 	kfree(kf);
 }
 
+static size_t iio_kfifo_buf_space_available(struct iio_buffer *r)
+{
+	struct iio_kfifo *kf = iio_to_kfifo(r);
+	size_t avail;
+
+	mutex_lock(&kf->user_lock);
+	avail = kfifo_avail(&kf->kf);
+	mutex_unlock(&kf->user_lock);
+
+	return avail;
+}
+
+static int iio_kfifo_remove_from(struct iio_buffer *r, void *data)
+{
+	int ret;
+	struct iio_kfifo *kf = iio_to_kfifo(r);
+
+	if (kfifo_size(&kf->kf) < r->bytes_per_datum)
+		return -EBUSY;
+
+	ret = kfifo_out(&kf->kf, data, r->bytes_per_datum);
+	if (ret != r->bytes_per_datum)
+		return -EBUSY;
+
+	wake_up_interruptible_poll(&r->pollq, POLLOUT | POLLWRNORM);
+
+	return 0;
+}
+
+static int iio_kfifo_write(struct iio_buffer *r, size_t n,
+	const char __user *buf)
+{
+	struct iio_kfifo *kf = iio_to_kfifo(r);
+	int ret, copied;
+
+	mutex_lock(&kf->user_lock);
+	if (!kfifo_initialized(&kf->kf) || n < kfifo_esize(&kf->kf))
+		ret = -EINVAL;
+	else
+		ret = kfifo_from_user(&kf->kf, buf, n, &copied);
+	mutex_unlock(&kf->user_lock);
+	if (ret)
+		return ret;
+
+	return copied;
+}
+
 static const struct iio_buffer_access_funcs kfifo_access_funcs = {
 	.store_to = &iio_store_to_kfifo,
 	.read = &iio_read_kfifo,
 	.data_available = iio_kfifo_buf_data_available,
+	.remove_from = &iio_kfifo_remove_from,
+	.write = &iio_kfifo_write,
+	.space_available = &iio_kfifo_buf_space_available,
 	.request_update = &iio_request_update_kfifo,
 	.set_bytes_per_datum = &iio_set_bytes_per_datum_kfifo,
 	.set_length = &iio_set_length_kfifo,
-- 
2.17.1

