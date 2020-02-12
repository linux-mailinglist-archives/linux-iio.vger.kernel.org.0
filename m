Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8B6D15AD19
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2020 17:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgBLQSJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Feb 2020 11:18:09 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:47778 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728696AbgBLQSI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Feb 2020 11:18:08 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CGEOab001210;
        Wed, 12 Feb 2020 11:18:08 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y1udmyfpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 11:18:06 -0500
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01CGI4w0052895
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 12 Feb 2020 11:18:05 -0500
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 12 Feb 2020 08:18:02 -0800
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 12 Feb 2020 08:18:02 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 12 Feb 2020 08:18:02 -0800
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01CGHsfA001230;
        Wed, 12 Feb 2020 11:17:59 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v3 4/5] Documentation: ABI: testing: ad7192: update sysfs docs
Date:   Wed, 12 Feb 2020 18:17:20 +0200
Message-ID: <20200212161721.16200-5-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200212161721.16200-1-alexandru.tachici@analog.com>
References: <20200212161721.16200-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_08:2020-02-11,2020-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120125
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Updated mainline documentation on ad7192 userspace sysfs.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 .../ABI/testing/sysfs-bus-iio-adc-ad7192      | 24 ++++++++++++++-----
 .../iio/Documentation/sysfs-bus-iio-ad7192    | 20 ----------------
 2 files changed, 18 insertions(+), 26 deletions(-)
 delete mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-ad7192

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
index 7627d3be08f5..f8315202c8f0 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
@@ -2,17 +2,22 @@ What:		/sys/bus/iio/devices/iio:deviceX/ac_excitation_en
 KernelVersion:
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Reading gives the state of AC excitation.
-		Writing '1' enables AC excitation.
+		This attribute, if available, is used to enable the AC
+		excitation mode found on some converters. In ac excitation mode,
+		the polarity of the excitation voltage is reversed on
+		alternate cycles, to eliminate DC errors.
 
 What:		/sys/bus/iio/devices/iio:deviceX/bridge_switch_en
 KernelVersion:
 Contact:	linux-iio@vger.kernel.org
 Description:
-		This bridge switch is used to disconnect it when there is a
-		need to minimize the system current consumption.
-		Reading gives the state of the bridge switch.
-		Writing '1' enables the bridge switch.
+		This attribute, if available, is used to close or open the
+		bridge power down switch found on some converters.
+		In bridge applications, such as strain gauges and load cells,
+		the bridge itself consumes the majority of the current in the
+		system. To minimize the current consumption of the system,
+		the bridge can be disconnected (when it is not being used
+		using the bridge_switch_en attribute.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration
 KernelVersion:
@@ -21,6 +26,13 @@ Description:
 		Initiates the system calibration procedure. This is done on a
 		single channel at a time. Write '1' to start the calibration.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage2-voltage2_shorted_raw
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Measure voltage from AIN2 pin connected to AIN(+)
+		and AIN(-) shorted.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration_mode_available
 KernelVersion:
 Contact:	linux-iio@vger.kernel.org
diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-ad7192 b/drivers/staging/iio/Documentation/sysfs-bus-iio-ad7192
deleted file mode 100644
index 1c35c507cc05..000000000000
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio-ad7192
+++ /dev/null
@@ -1,20 +0,0 @@
-What:		/sys/.../iio:deviceX/ac_excitation_en
-KernelVersion:	3.1.0
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This attribute, if available, is used to enable the AC
-		excitation mode found on some converters. In ac excitation mode,
-		the polarity of the excitation voltage is reversed on
-		alternate cycles, to eliminate DC errors.
-
-What:		/sys/.../iio:deviceX/bridge_switch_en
-KernelVersion:	3.1.0
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This attribute, if available, is used to close or open the
-		bridge power down switch found on some converters.
-		In bridge applications, such as strain gauges and load cells,
-		the bridge itself consumes the majority of the current in the
-		system. To minimize the current consumption of the system,
-		the bridge can be disconnected (when it is not being used
-		using the bridge_switch_en attribute.
-- 
2.20.1

