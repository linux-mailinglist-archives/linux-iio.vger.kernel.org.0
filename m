Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65199276FB5
	for <lists+linux-iio@lfdr.de>; Thu, 24 Sep 2020 13:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgIXLS0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Sep 2020 07:18:26 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:32290 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727468AbgIXLSW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Sep 2020 07:18:22 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08OB70jS000560;
        Thu, 24 Sep 2020 07:18:10 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33r5p6bq6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 07:18:09 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 08OBI85j063203
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 24 Sep 2020 07:18:08 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 24 Sep
 2020 07:18:07 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 24 Sep 2020 07:18:07 -0400
Received: from saturn.ad.analog.com ([10.48.65.107])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08OBI2VN007892;
        Thu, 24 Sep 2020 07:18:05 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/3] iio: Kconfig: Provide title for IIO_TRIGGERED_EVENT symbol
Date:   Thu, 24 Sep 2020 14:17:57 +0300
Message-ID: <20200924111758.196367-3-alexandru.ardelean@analog.com>
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

Albeit, the IIO_TRIGGERED_EVENT is used by a single mainline driver, this
could allow for some out-of-tree drivers to use this kmod.

This change adds a title to the IIO_TRIGGERED_EVENT Kconfig symbol.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index d5c073a8aa3e..267553386c71 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -63,7 +63,7 @@ config IIO_SW_TRIGGER
 	  using the API provided.
 
 config IIO_TRIGGERED_EVENT
-	tristate
+	tristate "Enable triggered events support"
 	select IIO_TRIGGER
 	help
 	  Provides helper functions for setting up triggered events.
-- 
2.25.1

