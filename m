Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F24319C88
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 11:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhBLKTI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 05:19:08 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:5908 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230470AbhBLKS7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 05:18:59 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11CAFN02001703;
        Fri, 12 Feb 2021 05:18:08 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36hrw93cae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Feb 2021 05:18:07 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11CAI6QI023461
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 12 Feb 2021 05:18:06 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 12 Feb
 2021 05:18:05 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 12 Feb 2021 05:18:05 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11CAHu5o029319;
        Fri, 12 Feb 2021 05:18:04 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 5/5] iio: buffer-dma: add support for cyclic DMA transfers
Date:   Fri, 12 Feb 2021 12:20:21 +0200
Message-ID: <20210212102021.47276-6-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210212102021.47276-1-alexandru.ardelean@analog.com>
References: <20210212102021.47276-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-12_03:2021-02-12,2021-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120077
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
index 013cc7c1ecf4..94c93a636ad4 100644
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
index 70ad3aea01ea..0e0c95f1c38b 100644
--- a/include/uapi/linux/iio/buffer.h
+++ b/include/uapi/linux/iio/buffer.h
@@ -13,6 +13,7 @@ struct iio_buffer_block_alloc_req {
 };
 
 #define IIO_BUFFER_BLOCK_FLAG_TIMESTAMP_VALID	(1 << 0)
+#define IIO_BUFFER_BLOCK_FLAG_CYCLIC		(1 << 1)
 
 struct iio_buffer_block {
 	__u32 id;
-- 
2.17.1

