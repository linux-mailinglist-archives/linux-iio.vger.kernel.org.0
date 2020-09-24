Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E62276FB6
	for <lists+linux-iio@lfdr.de>; Thu, 24 Sep 2020 13:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgIXLS0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Sep 2020 07:18:26 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:32292 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727421AbgIXLSW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Sep 2020 07:18:22 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08OB6kFd000471;
        Thu, 24 Sep 2020 07:18:10 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33r5p6bq6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 07:18:10 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 08OBI8fp063202
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 24 Sep 2020 07:18:09 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 24 Sep
 2020 04:18:06 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 24 Sep 2020 04:18:06 -0700
Received: from saturn.ad.analog.com ([10.48.65.107])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08OBI2VM007892;
        Thu, 24 Sep 2020 07:18:04 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/3] iio: dma-buffer: Kconfig: Provide titles for IIO DMA Kconfig symbols
Date:   Thu, 24 Sep 2020 14:17:56 +0300
Message-ID: <20200924111758.196367-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200924111758.196367-1-alexandru.ardelean@analog.com>
References: <20200924111758.196367-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_08:2020-09-24,2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240086
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

For some embedded systems, a workflow involving external kernel modules
that implement IIO devices is more practical than working with in-tree
sources.

Kconfig symbols without any titles do not show up in menuconfig, and as
such are more difficult to configure granularly, as they need to be
selected by potentially unused/un-needed drivers.

This change adds titles to the IIO DMA Kconfig symbols to address this.

This change also updates DMAengine -> DMAEngine, which is the
correct/nitpick-y name of the framework.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/buffer/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/buffer/Kconfig b/drivers/iio/buffer/Kconfig
index 63f265c8b466..747d21f84188 100644
--- a/drivers/iio/buffer/Kconfig
+++ b/drivers/iio/buffer/Kconfig
@@ -11,7 +11,7 @@ config IIO_BUFFER_CB
 	  usage.  That is, those where the data is pushed to the consumer.
 
 config IIO_BUFFER_DMA
-	tristate
+	tristate "Industrial I/O DMA buffer infrastructure"
 	help
 	  Provides the generic IIO DMA buffer infrastructure that can be used by
 	  drivers for devices with DMA support to implement the IIO buffer.
@@ -20,13 +20,13 @@ config IIO_BUFFER_DMA
 	  infrastructure.
 
 config IIO_BUFFER_DMAENGINE
-	tristate
+	tristate "Industrial I/O DMA buffer integration with DMAEngine"
 	select IIO_BUFFER_DMA
 	help
 	  Provides a bonding of the generic IIO DMA buffer infrastructure with the
-	  DMAengine framework. This can be used by converter drivers with a DMA port
+	  DMAEngine framework. This can be used by converter drivers with a DMA port
 	  connected to an external DMA controller which is supported by the
-	  DMAengine framework.
+	  DMAEngine framework.
 
 	  Should be selected by drivers that want to use this functionality.
 
-- 
2.25.1

