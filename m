Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFD6615D4C7
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 10:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgBNJcm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 04:32:42 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:7784 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbgBNJcm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Feb 2020 04:32:42 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01E9WcoS027027;
        Fri, 14 Feb 2020 04:32:41 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y1udn4rrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Feb 2020 04:32:41 -0500
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 01E9WdSl059653
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 14 Feb 2020 04:32:40 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 14 Feb
 2020 01:32:38 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 14 Feb 2020 01:32:38 -0800
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01E9WaZj029532;
        Fri, 14 Feb 2020 04:32:36 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>
Subject: [PATCH 5/5] iio: accel: adxl372: Update sysfs docs
Date:   Fri, 14 Feb 2020 11:32:23 +0200
Message-ID: <20200214093223.24664-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214092919.24351-1-alexandru.tachici@analog.com>
References: <20200214092919.24351-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-14_02:2020-02-12,2020-02-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002140077
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds entries in the syfs docs of ADXL372.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 .../ABI/testing/sysfs-bus-iio-accel-adxl372   | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372 b/Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372
new file mode 100644
index 000000000000..1d74fc2ea0ac
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372
@@ -0,0 +1,40 @@
+What:		/sys/bus/iio/devices/iio:deviceX/peak_fifo_mode_enable
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute allows to configure the FIFO to store sample
+		sets of impact event peak (x, y, z). As a precondition, all
+		three channels (x, y, z) need to be enabled.
+		Writing 1, peak fifo mode will be enabled, if cleared and
+		all three channels are enabled, sample sets of concurrent
+		3-axis data will be stored in the FIFO.
+
+What:		/sys/bus/iio/devices/iio:deviceX/time_activity
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute allows to set the activity timer in ms,
+		the minimum time measured acceleration needs to overcome
+		the set threshold in order to detect activity.
+
+What:		/sys/bus/iio/devices/iio:deviceX/time_inactivity
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute allows to set the inactivity timer in ms,
+		the minimum time measured acceleration needs to be lower
+		than set threshold in order to detect inactivity.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_threshold_activity
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute allows to set the activity threshold in 100 mg
+		(0.1 m/s^2 SI).
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_threshold_inactivity
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute allows to set the inactivity threshold in 100 mg
+		(0.1 m/s^2 SI).
-- 
2.20.1

