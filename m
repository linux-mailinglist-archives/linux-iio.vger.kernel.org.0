Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1B1F16C063
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2020 13:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbgBYMJi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Feb 2020 07:09:38 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:12310 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730651AbgBYMJf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Feb 2020 07:09:35 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PC4tfl012993;
        Tue, 25 Feb 2020 07:09:34 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yay1brsvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 07:09:34 -0500
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 01PC9WtK058810
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Feb 2020 07:09:32 -0500
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Feb 2020 04:09:31 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Feb 2020 04:09:31 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 25 Feb 2020 04:09:30 -0800
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01PC9N1I003238;
        Tue, 25 Feb 2020 07:09:29 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>
Subject: [PATCH v2 6/6] iio: accel: adxl372: Update sysfs docs
Date:   Tue, 25 Feb 2020 14:09:09 +0200
Message-ID: <20200225120909.12629-7-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225120909.12629-1-alexandru.tachici@analog.com>
References: <20200225120909.12629-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_03:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250098
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds entries in the syfs docs of ADXL372.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 .../ABI/testing/sysfs-bus-iio-accel-adxl372   | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372 b/Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372
new file mode 100644
index 000000000000..709376b54bec
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372
@@ -0,0 +1,30 @@
+What:		/sys/bus/iio/devices/iio:deviceX/buffer_peak_mode_enable
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
+What:		/sys/bus/iio/devices/iio:deviceX/activity_detect_event
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		adxl372 works in loop mode. It will loop  between activity
+		and inactivity detection mode. The thresh_rising sysfs files
+		found in events/ need to be configured in order to define when
+		the device will mark a sensed acceleration over a period of
+		time as activity.
+
+What:		/sys/bus/iio/devices/iio:deviceX/inactivity_detect_event
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		adxl372 works in loop mode. It will loop  between activity
+		and inactivity detection mode. The thresh_falling sysfs files
+		found in events/ need to be configured in order to define when
+		the device will mark a sensed acceleration over a period of
+		time as inactivity.
-- 
2.20.1

