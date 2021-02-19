Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9EE31F983
	for <lists+linux-iio@lfdr.de>; Fri, 19 Feb 2021 13:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhBSMlZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Feb 2021 07:41:25 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:61646 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230308AbhBSMlX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Feb 2021 07:41:23 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11JCOn5a000385;
        Fri, 19 Feb 2021 07:40:31 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 36p9gbadc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 07:40:31 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 11JCeUAr052017
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Feb 2021 07:40:30 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Fri, 19 Feb 2021 07:40:29 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Fri, 19 Feb 2021 07:40:29 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Fri, 19 Feb 2021 07:40:29 -0500
Received: from saturn.ad.analog.com ([10.48.65.120])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11JCeH4v008911;
        Fri, 19 Feb 2021 07:40:26 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 6/6] iio: buffer-dma: add support for cyclic DMA transfers
Date:   Fri, 19 Feb 2021 14:40:12 +0200
Message-ID: <20210219124012.92897-7-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210219124012.92897-1-alexandru.ardelean@analog.com>
References: <20210219124012.92897-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_05:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190101
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

This change adds support for cyclic DMA transfers using the IIO buffer DMA
infrastructure.
To do this, userspace must set the IIO_BUFFER_BLOCK_FLAG_CYCLIC flag on the
block when enqueueing them via the ENQUEUE_BLOCK ioctl().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../buffer/industrialio-buffer-dmaengine.c    | 24 ++++++++++++-------
 include/uapi/linux/iio/buffer.h               |  1 +
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 65458a6cc81a..39cc230c7991 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -82,14 +82,22 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 
 	direction = dmaengine_buffer->is_tx ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
 
-	desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,
-		block->phys_addr, block->block.bytes_used, direction,
-		DMA_PREP_INTERRUPT);
-	if (!desc)
-		return -ENOMEM;
-
-	desc->callback_result = iio_dmaengine_buffer_block_done;
-	desc->callback_param = block;
+	if (block->block.flags & IIO_BUFFER_BLOCK_FLAG_CYCLIC) {
+		desc = dmaengine_prep_dma_cyclic(dmaengine_buffer->chan,
+			block->phys_addr, block->block.bytes_used,
+			block->block.bytes_used, direction, 0);
+		if (!desc)
+			return -ENOMEM;
+	} else {
+		desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,
+			block->phys_addr, block->block.bytes_used, direction,
+			DMA_PREP_INTERRUPT);
+		if (!desc)
+			return -ENOMEM;
+
+		desc->callback_result = iio_dmaengine_buffer_block_done;
+		desc->callback_param = block;
+	}
 
 	cookie = dmaengine_submit(desc);
 	if (dma_submit_error(cookie))
diff --git a/include/uapi/linux/iio/buffer.h b/include/uapi/linux/iio/buffer.h
index 4e4ee9befea1..1bde508fe1b9 100644
--- a/include/uapi/linux/iio/buffer.h
+++ b/include/uapi/linux/iio/buffer.h
@@ -33,6 +33,7 @@ struct iio_buffer_block_alloc_req {
 
 /* A function will be assigned later for BIT(0) */
 #define IIO_BUFFER_BLOCK_FLAG_RESERVED		(1 << 0)
+#define IIO_BUFFER_BLOCK_FLAG_CYCLIC		(1 << 1)
 
 /**
  * struct iio_buffer_block - Descriptor for a single IIO block
-- 
2.27.0

