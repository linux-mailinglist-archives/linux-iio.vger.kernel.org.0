Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9501D3111
	for <lists+linux-iio@lfdr.de>; Thu, 14 May 2020 15:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgENNSN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 May 2020 09:18:13 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:31250 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728030AbgENNSN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 May 2020 09:18:13 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EDHqtY030453;
        Thu, 14 May 2020 09:17:52 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3100y97ag2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 09:17:52 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 04EDHpcL034668
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 14 May 2020 09:17:51 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 14 May
 2020 09:17:50 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 14 May 2020 09:17:50 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04EDHUaq017033;
        Thu, 14 May 2020 09:17:46 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
CC:     <ludovic.desroches@microchip.com>, <eugen.hristev@microchip.com>,
        <jic23@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <ak@it-klinger.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 7/8] iio: core: simplify alloc alignment code
Date:   Thu, 14 May 2020 16:17:09 +0300
Message-ID: <20200514131710.84201-8-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200514131710.84201-1-alexandru.ardelean@analog.com>
References: <20200514131710.84201-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_03:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 cotscore=-2147483648
 phishscore=0 priorityscore=1501 adultscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140118
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There was a recent discussion about this code:
  https://lore.kernel.org/linux-iio/20200322165317.0b1f0674@archlinux/

This looks like a good time to rework this, since any issues about it
should pop-up under testing, because the iio_dev is having a bit of an
overhaul and stuff being moved to iio_dev_priv.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index a1b29e0f8fd6..7671d36efae7 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1514,13 +1514,9 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
 	struct iio_dev *dev;
 	size_t alloc_size;
 
-	alloc_size = sizeof(struct iio_dev_opaque);
-	if (sizeof_priv) {
-		alloc_size = ALIGN(alloc_size, IIO_ALIGN);
-		alloc_size += sizeof_priv;
-	}
-	/* ensure 32-byte alignment of whole construct ? */
-	alloc_size += IIO_ALIGN - 1;
+	alloc_size = ALIGN(sizeof(struct iio_dev_opaque), IIO_ALIGN);
+	if (sizeof_priv)
+		alloc_size += ALIGN(sizeof_priv, IIO_ALIGN);
 
 	iio_dev_opaque = kzalloc(alloc_size, GFP_KERNEL);
 	if (!iio_dev_opaque)
-- 
2.17.1

