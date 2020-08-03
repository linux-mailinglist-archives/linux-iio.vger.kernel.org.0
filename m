Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7052323AB91
	for <lists+linux-iio@lfdr.de>; Mon,  3 Aug 2020 19:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgHCRUz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 13:20:55 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:12448 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728345AbgHCRUz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 13:20:55 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 073H4pvh023185;
        Mon, 3 Aug 2020 13:20:54 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 32n69efbam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 13:20:54 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 073HKqNF047749
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 3 Aug 2020 13:20:53 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 3 Aug 2020 13:20:52 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 3 Aug 2020 13:20:51 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 3 Aug 2020 13:20:51 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 073HKlaj008684;
        Mon, 3 Aug 2020 13:20:51 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>
Subject: [PATCH v4 3/3] docs: iio: Add adxl372 documentation
Date:   Mon, 3 Aug 2020 20:22:19 +0300
Message-ID: <20200803172219.33911-4-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200803172219.33911-1-alexandru.tachici@analog.com>
References: <20200803172219.33911-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_15:2020-08-03,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030123
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Add documentation for adxl372 3-axis accelerometer.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 Documentation/iio/adxl372.rst | 46 +++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst   |  1 +
 2 files changed, 47 insertions(+)
 create mode 100644 Documentation/iio/adxl372.rst

diff --git a/Documentation/iio/adxl372.rst b/Documentation/iio/adxl372.rst
new file mode 100644
index 000000000000..f8fe5f438400
--- /dev/null
+++ b/Documentation/iio/adxl372.rst
@@ -0,0 +1,46 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver adxl372
+=====================
+
+Supported chips:
+  * Analog Devices ADXL372
+    Prefix: 'adxl372'
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL372.pdf
+
+Author: Stefan Popa <stefan.popa@analog.com>
+
+
+Description
+-----------
+
+The ADXL372 is an ultralow power, 3-axis, ±200 g MEMS accelerometer
+that consumes 22 μA at a 3200 Hz output data rate (ODR).
+
+The ADXL372 provides 12-bit output data at 100 mg/LSB scale factor.
+
+Using the FIFO Buffer
+---------------------
+
+The ADXL372 includes a deep, 512 sample FIFO buffer.
+The 512 FIFO samples can be allotted in several ways, such as the following:
+
+    170 sample sets of concurrent 3-axis data
+    256 sample sets of concurrent 2-axis data (see scan_elements/in_accel_*_en)
+    512 sample sets of single-axis data
+    170 sets of impact event peak (x, y, z)
+
+By default when using the buffer adxl372 will store all
+acceleration data. To store only the peak acceleration data, the user must
+select the peak data trigger: adxl372-dev0-peak
+
+The user can set the thresholds for each axis for activity and inactivity in:
+- events/in_accel_*_thresh_rising_value
+- events/in_accel_*_thresh_falling_value
+
+An inactivity/activity event is detected when acceleration in all enabled
+axes remains below/above a specified threshold for a specified time. The user
+can set these timings in:
+- events/thresh_falling_period
+- events/thresh_rising_period
+
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 58b7a4ebac51..3d0acb1eef86 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -10,3 +10,4 @@ Industrial I/O
    iio_configfs
 
    ep93xx_adc
+   adxl372.rst
-- 
2.20.1

