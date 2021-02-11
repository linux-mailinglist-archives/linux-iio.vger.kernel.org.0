Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBFD318A71
	for <lists+linux-iio@lfdr.de>; Thu, 11 Feb 2021 13:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhBKM0R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Feb 2021 07:26:17 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:27522 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230419AbhBKMXy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Feb 2021 07:23:54 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11BCMnni016281;
        Thu, 11 Feb 2021 07:22:56 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36hr7qg8vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 07:22:56 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11BCMsPb004270
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Feb 2021 07:22:55 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Thu, 11 Feb 2021 04:22:53 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 11 Feb 2021 04:22:53 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11BCMYWh011557;
        Thu, 11 Feb 2021 07:22:50 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <rafael@kernel.org>,
        <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v5 09/17] iio: buffer: dmaengine: obtain buffer object from attribute
Date:   Thu, 11 Feb 2021 14:24:44 +0200
Message-ID: <20210211122452.78106-10-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210211122452.78106-1-alexandru.ardelean@analog.com>
References: <20210211122452.78106-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_05:2021-02-10,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110110
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The reference to the IIO buffer object is stored on the attribute object.
So we need to unwind it to obtain it.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index b0cb9a35f5cd..8ecdbae83414 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -132,9 +132,9 @@ static const struct iio_dma_buffer_ops iio_dmaengine_default_ops = {
 static ssize_t iio_dmaengine_buffer_get_length_align(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 	struct dmaengine_buffer *dmaengine_buffer =
-		iio_buffer_to_dmaengine_buffer(indio_dev->buffer);
+		iio_buffer_to_dmaengine_buffer(buffer);
 
 	return sprintf(buf, "%zu\n", dmaengine_buffer->align);
 }
-- 
2.17.1

