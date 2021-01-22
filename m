Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9621730088A
	for <lists+linux-iio@lfdr.de>; Fri, 22 Jan 2021 17:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbhAVQXi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Jan 2021 11:23:38 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:41708 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729621AbhAVQXY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jan 2021 11:23:24 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10MGMCCp006363;
        Fri, 22 Jan 2021 11:22:33 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3668rcjmkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 11:22:33 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 10MGMVaG058177
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jan 2021 11:22:32 -0500
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Fri, 22 Jan 2021 08:22:30 -0800
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Fri, 22 Jan 2021 08:22:30 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Fri, 22 Jan 2021 08:22:30 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 10MGMOCo016711;
        Fri, 22 Jan 2021 11:22:27 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 02/12][RESEND] iio: buffer: add back-ref from iio_buffer to iio_dev
Date:   Fri, 22 Jan 2021 18:25:19 +0200
Message-ID: <20210122162529.84978-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210122162529.84978-1-alexandru.ardelean@analog.com>
References: <20210122162529.84978-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-22_11:2021-01-22,2021-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101220088
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

An IIO device will have multiple buffers, but it shouldn't be allowed that
an IIO buffer should belong to more than 1 IIO device.

Once things get moved more from IIO device to the IIO buffer, and an IIO
device will be able to have more than 1 buffer attached, there will be a
need for a back-ref to the IIO device [from the IIO buffer].

This change adds that.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 2 ++
 include/linux/iio/buffer_impl.h   | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 2f7426a2f47c..0412c4fda4c1 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1505,5 +1505,7 @@ void iio_device_attach_buffer(struct iio_dev *indio_dev,
 			      struct iio_buffer *buffer)
 {
 	indio_dev->buffer = iio_buffer_get(buffer);
+
+	indio_dev->buffer->indio_dev = indio_dev;
 }
 EXPORT_SYMBOL_GPL(iio_device_attach_buffer);
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index a63dc07b7350..67d73d465e02 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -69,6 +69,9 @@ struct iio_buffer_access_funcs {
  * those writing new buffer implementations.
  */
 struct iio_buffer {
+	/** @indio_dev: IIO device to which this buffer belongs to. */
+	struct iio_dev *indio_dev;
+
 	/** @length: Number of datums in buffer. */
 	unsigned int length;
 
-- 
2.17.1

