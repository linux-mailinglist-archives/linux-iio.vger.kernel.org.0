Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA3545A3ED
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 14:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbhKWNm2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 08:42:28 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:50344 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233796AbhKWNm2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Nov 2021 08:42:28 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1ANAjbRf009182;
        Tue, 23 Nov 2021 08:39:19 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3cg6mm0kwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Nov 2021 08:39:19 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 1ANDdIZl007023
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Nov 2021 08:39:18 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Tue, 23 Nov 2021
 08:39:17 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Tue, 23 Nov 2021 08:39:17 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.181])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1ANDdET7000435;
        Tue, 23 Nov 2021 08:39:14 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 1/4] iio: add filter subfolder
Date:   Tue, 23 Nov 2021 15:38:57 +0200
Message-ID: <20211123133900.133027-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ETHSlD90x-qhZHV0iqh6uNx0sNp9SByp
X-Proofpoint-ORIG-GUID: ETHSlD90x-qhZHV0iqh6uNx0sNp9SByp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_04,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=936 impostorscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111230076
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add filter subfolder for IIO devices that handle filter functionality.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v2.
 drivers/iio/Kconfig         | 1 +
 drivers/iio/Makefile        | 1 +
 drivers/iio/filter/Kconfig  | 8 ++++++++
 drivers/iio/filter/Makefile | 6 ++++++
 4 files changed, 16 insertions(+)
 create mode 100644 drivers/iio/filter/Kconfig
 create mode 100644 drivers/iio/filter/Makefile

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 2334ad249b46..3a496a28bad4 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -77,6 +77,7 @@ source "drivers/iio/chemical/Kconfig"
 source "drivers/iio/common/Kconfig"
 source "drivers/iio/dac/Kconfig"
 source "drivers/iio/dummy/Kconfig"
+source "drivers/iio/filter/Kconfig"
 source "drivers/iio/frequency/Kconfig"
 source "drivers/iio/gyro/Kconfig"
 source "drivers/iio/health/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 65e39bd4f934..97d2fbcf0950 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -24,6 +24,7 @@ obj-y += common/
 obj-y += dac/
 obj-y += dummy/
 obj-y += gyro/
+obj-y += filter/
 obj-y += frequency/
 obj-y += health/
 obj-y += humidity/
diff --git a/drivers/iio/filter/Kconfig b/drivers/iio/filter/Kconfig
new file mode 100644
index 000000000000..e268bba43852
--- /dev/null
+++ b/drivers/iio/filter/Kconfig
@@ -0,0 +1,8 @@
+#
+# Filter drivers
+#
+# When adding new entries keep the list in alphabetical order
+
+menu "Filters"
+
+endmenu
diff --git a/drivers/iio/filter/Makefile b/drivers/iio/filter/Makefile
new file mode 100644
index 000000000000..cc0892c01142
--- /dev/null
+++ b/drivers/iio/filter/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for industrial I/O Filter drivers
+#
+
+# When adding new entries keep the list in alphabetical order
-- 
2.34.0

