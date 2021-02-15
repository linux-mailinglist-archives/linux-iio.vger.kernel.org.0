Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4722D31B761
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 11:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhBOKjk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 05:39:40 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:41512 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230038AbhBOKjg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 05:39:36 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11FAa3wU029101;
        Mon, 15 Feb 2021 05:38:43 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36pcjamaj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 05:38:43 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11FAcfoD023099
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Feb 2021 05:38:41 -0500
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Mon, 15 Feb 2021 02:38:40 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Mon, 15 Feb 2021 02:38:40 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 15 Feb 2021 02:38:40 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11FAcQUX017530;
        Mon, 15 Feb 2021 05:38:36 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v6 04/24] iio: accel: sca3000: use devm_iio_kfifo_buffer_setup() helper
Date:   Mon, 15 Feb 2021 12:40:23 +0200
Message-ID: <20210215104043.91251-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210215104043.91251-1-alexandru.ardelean@analog.com>
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-15_03:2021-02-12,2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102150087
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change makes use of the devm_iio_kfifo_buffer_setup() helper, however
the unwind order is changed.
The life-time of the kfifo object is attached to the parent device object.
This is to make the driver a bit more consistent with the other IIO
drivers, even though (as it is now before this change) it shouldn't be a
problem.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/accel/sca3000.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 194738660523..467b5fcb81db 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1272,20 +1272,6 @@ static int sca3000_write_event_config(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int sca3000_configure_ring(struct iio_dev *indio_dev)
-{
-	struct iio_buffer *buffer;
-
-	buffer = devm_iio_kfifo_allocate(&indio_dev->dev);
-	if (!buffer)
-		return -ENOMEM;
-
-	iio_device_attach_buffer(indio_dev, buffer);
-	indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
-
-	return 0;
-}
-
 static inline
 int __sca3000_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
 {
@@ -1479,7 +1465,9 @@ static int sca3000_probe(struct spi_device *spi)
 	}
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = sca3000_configure_ring(indio_dev);
+	ret = devm_iio_kfifo_buffer_setup(&spi->dev, indio_dev,
+					  INDIO_BUFFER_SOFTWARE,
+					  &sca3000_ring_setup_ops);
 	if (ret)
 		return ret;
 
@@ -1493,7 +1481,6 @@ static int sca3000_probe(struct spi_device *spi)
 		if (ret)
 			return ret;
 	}
-	indio_dev->setup_ops = &sca3000_ring_setup_ops;
 	ret = sca3000_clean_setup(st);
 	if (ret)
 		goto error_free_irq;
-- 
2.17.1

