Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1562800DC
	for <lists+linux-iio@lfdr.de>; Thu,  1 Oct 2020 16:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732018AbgJAOFk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Oct 2020 10:05:40 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:61770 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726412AbgJAOFj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Oct 2020 10:05:39 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 091DvjX1009749;
        Thu, 1 Oct 2020 10:05:38 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33t2j4u32m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Oct 2020 10:05:38 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 091E5bgb047106
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 1 Oct 2020 10:05:37 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 1 Oct 2020
 10:05:27 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 1 Oct 2020 10:05:27 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 091E5YpL029022;
        Thu, 1 Oct 2020 10:05:34 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: dac: ad7303: remove platform data header
Date:   Thu, 1 Oct 2020 17:10:04 +0300
Message-ID: <20201001141004.53846-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_04:2020-10-01,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 mlxlogscore=948 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010010120
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The information in the ad7303 platform_data header is unused, so it's dead
code.
This change removes it and it's inclusion from the driver.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/dac/ad7303.c             |  2 --
 include/linux/platform_data/ad7303.h | 20 --------------------
 2 files changed, 22 deletions(-)
 delete mode 100644 include/linux/platform_data/ad7303.h

diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
index 2e46def9d8ee..dbb4645ab6b1 100644
--- a/drivers/iio/dac/ad7303.c
+++ b/drivers/iio/dac/ad7303.c
@@ -17,8 +17,6 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#include <linux/platform_data/ad7303.h>
-
 #define AD7303_CFG_EXTERNAL_VREF BIT(15)
 #define AD7303_CFG_POWER_DOWN(ch) BIT(11 + (ch))
 #define AD7303_CFG_ADDR_OFFSET	10
diff --git a/include/linux/platform_data/ad7303.h b/include/linux/platform_data/ad7303.h
deleted file mode 100644
index c2bd0a13bea1..000000000000
--- a/include/linux/platform_data/ad7303.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Analog Devices AD7303 DAC driver
- *
- * Copyright 2013 Analog Devices Inc.
- */
-
-#ifndef __IIO_ADC_AD7303_H__
-#define __IIO_ADC_AD7303_H__
-
-/**
- * struct ad7303_platform_data - AD7303 platform data
- * @use_external_ref: If set to true use an external voltage reference connected
- * to the REF pin, otherwise use the internal reference derived from Vdd.
- */
-struct ad7303_platform_data {
-	bool use_external_ref;
-};
-
-#endif
-- 
2.17.1

