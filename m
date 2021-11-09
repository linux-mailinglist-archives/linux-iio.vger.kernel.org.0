Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB2844AD91
	for <lists+linux-iio@lfdr.de>; Tue,  9 Nov 2021 13:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242593AbhKIMer (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Nov 2021 07:34:47 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:34224 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242554AbhKIMeq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Nov 2021 07:34:46 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A9BbN3s019942;
        Tue, 9 Nov 2021 07:32:00 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3c711fxsc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Nov 2021 07:32:00 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 1A9CVw9k052997
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Nov 2021 07:31:58 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Tue, 9 Nov 2021
 07:31:58 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Tue, 9 Nov 2021 07:31:58 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.128])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1A9CVsSv007733;
        Tue, 9 Nov 2021 07:31:56 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 1/4] iio: add filter subfolder
Date:   Tue, 9 Nov 2021 14:31:24 +0200
Message-ID: <20211109123127.96399-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211109123127.96399-1-antoniu.miclaus@analog.com>
References: <20211109123127.96399-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: wjpHxkxK3Zb-O8pUK-zsITbGT8f2GrHo
X-Proofpoint-GUID: wjpHxkxK3Zb-O8pUK-zsITbGT8f2GrHo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-09_03,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=942
 phishscore=0 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090076
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add filter subfolder for IIO devices that handle filter functionality.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
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
2.33.1

