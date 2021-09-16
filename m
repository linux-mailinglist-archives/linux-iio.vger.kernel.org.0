Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B4240E9D8
	for <lists+linux-iio@lfdr.de>; Thu, 16 Sep 2021 20:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245633AbhIPSbP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Sep 2021 14:31:15 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:25600 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245486AbhIPSbG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Sep 2021 14:31:06 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GG0EwP009357;
        Thu, 16 Sep 2021 14:29:34 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3b40gctb79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 14:29:34 -0400
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 18GITWRi038903
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Sep 2021 14:29:33 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Thu, 16 Sep 2021 11:29:31 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Thu, 16 Sep 2021 11:29:31 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Thu, 16 Sep 2021 11:29:31 -0700
Received: from ubuntuservermchindri.ad.analog.com ([10.32.224.24])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 18GITO8o025646;
        Thu, 16 Sep 2021 14:29:28 -0400
From:   Mihail Chindris <mihail.chindris@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <alexandru.ardelean@analog.com>,
        Mihail Chindris <mihail.chindris@analog.com>
Subject: [PATCH v5 2/6] iio: kfifo-buffer: Add output buffer support
Date:   Thu, 16 Sep 2021 18:29:10 +0000
Message-ID: <20210916182914.1810-3-mihail.chindris@analog.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210916182914.1810-1-mihail.chindris@analog.com>
References: <20210916182914.1810-1-mihail.chindris@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Yhgxvxw92O5QBDIV_Z1E0Idb7lNSffWp
X-Proofpoint-GUID: Yhgxvxw92O5QBDIV_Z1E0Idb7lNSffWp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-16_05,2021-09-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160106
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Add output buffer support to the kfifo buffer implementation.

The implementation is straight forward and mostly just wraps the kfifo
API to provide the required operations.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
---
 drivers/iio/buffer/kfifo_buf.c | 50 ++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
index 516eb3465de1..7368db2d5c32 100644
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
+	if (kfifo_size(&kf->kf) < 1)
+		return -EBUSY;
+
+	ret = kfifo_out(&kf->kf, data, 1);
+	if (ret != 1)
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
2.27.0

