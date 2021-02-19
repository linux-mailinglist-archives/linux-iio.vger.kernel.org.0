Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E956231F623
	for <lists+linux-iio@lfdr.de>; Fri, 19 Feb 2021 10:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhBSJAE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Feb 2021 04:00:04 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:22060 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229625AbhBSJAB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Feb 2021 04:00:01 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11J8soAt028727;
        Fri, 19 Feb 2021 03:59:08 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36p9gb9was-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 03:59:08 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11J8x6ts010908
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Feb 2021 03:59:07 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Fri, 19 Feb 2021
 00:59:05 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Fri, 19 Feb 2021 00:59:05 -0800
Received: from saturn.ad.analog.com ([10.48.65.120])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11J8wx4A029584;
        Fri, 19 Feb 2021 03:59:02 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] iio: buffer-dma: fix type of 'i' in iio_dma_buffer_alloc_blocks()
Date:   Fri, 19 Feb 2021 10:58:26 +0200
Message-ID: <20210219085826.46622-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210219085826.46622-1-alexandru.ardelean@analog.com>
References: <20210219085826.46622-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_02:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190070
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When unwinding the cleanup of the blocks, the type of 'i' is important to
be signed, so that the 'i >= 0' condition doesn't underflow and infinitely
loop (or just cause an access violation).

Fixes: ab925b044cfb ("iio: buffer-dma: Add mmap support")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index d04479194cb4..83074d060535 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -707,8 +707,7 @@ int iio_dma_buffer_alloc_blocks(struct iio_buffer *buffer,
 	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
 	struct iio_dma_buffer_block **blocks;
 	unsigned int num_blocks;
-	unsigned int i;
-	int ret = 0;
+	int i, ret = 0;
 
 	mutex_lock(&queue->lock);
 
-- 
2.27.0

