Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6922431D69D
	for <lists+linux-iio@lfdr.de>; Wed, 17 Feb 2021 09:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhBQIdm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Feb 2021 03:33:42 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:45028 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231846AbhBQIdk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Feb 2021 03:33:40 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11H8UMtA026130;
        Wed, 17 Feb 2021 03:32:48 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 36p9gb2hua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Feb 2021 03:32:47 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 11H8WkP3055863
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 17 Feb 2021 03:32:46 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 17 Feb 2021 03:32:45 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Wed, 17 Feb 2021 03:32:45 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 17 Feb 2021 03:32:45 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11H8WWlF007757;
        Wed, 17 Feb 2021 03:32:39 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 1/5] iio: Documentation: update definitions for bufferY and scan_elements
Date:   Wed, 17 Feb 2021 10:34:34 +0200
Message-ID: <20210217083438.37865-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210217083438.37865-1-alexandru.ardelean@analog.com>
References: <20210217083438.37865-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-17_06:2021-02-16,2021-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102170064
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since the new change to the IIO buffer infrastructure, the buffer/ and
scan_elements/ directories have been merged into bufferY/ to have some
attributes available per-buffer.

This change updates the ABI docs to reflect this change.

The hwfifo attributes are not updated, as for now these should be used
via the legacy buffer/ directory until they are moved into core.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 85 +++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d957f5da5c04..f2a72d7fbacb 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1118,12 +1118,16 @@ Description:
 
 What:		/sys/bus/iio/devices/iio:deviceX/buffer/length
 KernelVersion:	2.6.35
+What:		/sys/bus/iio/devices/iio:deviceX/bufferY/length
+KernelVersion:	5.11
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Number of scans contained by the buffer.
 
 What:		/sys/bus/iio/devices/iio:deviceX/buffer/enable
 KernelVersion:	2.6.35
+What:		/sys/bus/iio/devices/iio:deviceX/bufferY/enable
+KernelVersion:	5.11
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Actually start the buffer capture up.  Will start trigger
@@ -1131,11 +1135,16 @@ Description:
 
 What:		/sys/bus/iio/devices/iio:deviceX/scan_elements
 KernelVersion:	2.6.37
+What:		/sys/bus/iio/devices/iio:deviceX/buffeY
+KernelVersion:	5.11
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Directory containing interfaces for elements that will be
 		captured for a single triggered sample set in the buffer.
 
+		Since kernel 5.11 the scan_elements attributes are merged into
+		the bufferY directory, to be configurable per buffer.
+
 What:		/sys/.../iio:deviceX/scan_elements/in_accel_x_en
 What:		/sys/.../iio:deviceX/scan_elements/in_accel_y_en
 What:		/sys/.../iio:deviceX/scan_elements/in_accel_z_en
@@ -1164,6 +1173,34 @@ What:		/sys/.../iio:deviceX/scan_elements/in_pressure_en
 What:		/sys/.../iio:deviceX/scan_elements/in_rot_quaternion_en
 What:		/sys/.../iio:deviceX/scan_elements/in_proximity_en
 KernelVersion:	2.6.37
+What:		/sys/.../iio:deviceX/bufferY/in_accel_x_en
+What:		/sys/.../iio:deviceX/bufferY/in_accel_y_en
+What:		/sys/.../iio:deviceX/bufferY/in_accel_z_en
+What:		/sys/.../iio:deviceX/bufferY/in_anglvel_x_en
+What:		/sys/.../iio:deviceX/bufferY/in_anglvel_y_en
+What:		/sys/.../iio:deviceX/bufferY/in_anglvel_z_en
+What:		/sys/.../iio:deviceX/bufferY/in_magn_x_en
+What:		/sys/.../iio:deviceX/bufferY/in_magn_y_en
+What:		/sys/.../iio:deviceX/bufferY/in_magn_z_en
+What:		/sys/.../iio:deviceX/bufferY/in_rot_from_north_magnetic_en
+What:		/sys/.../iio:deviceX/bufferY/in_rot_from_north_true_en
+What:		/sys/.../iio:deviceX/bufferY/in_rot_from_north_magnetic_tilt_comp_en
+What:		/sys/.../iio:deviceX/bufferY/in_rot_from_north_true_tilt_comp_en
+What:		/sys/.../iio:deviceX/bufferY/in_timestamp_en
+What:		/sys/.../iio:deviceX/bufferY/in_voltageY_supply_en
+What:		/sys/.../iio:deviceX/bufferY/in_voltageY_en
+What:		/sys/.../iio:deviceX/bufferY/in_voltageY-voltageZ_en
+What:		/sys/.../iio:deviceX/bufferY/in_voltageY_i_en
+What:		/sys/.../iio:deviceX/bufferY/in_voltageY_q_en
+What:		/sys/.../iio:deviceX/bufferY/in_voltage_i_en
+What:		/sys/.../iio:deviceX/bufferY/in_voltage_q_en
+What:		/sys/.../iio:deviceX/bufferY/in_incli_x_en
+What:		/sys/.../iio:deviceX/bufferY/in_incli_y_en
+What:		/sys/.../iio:deviceX/bufferY/in_pressureY_en
+What:		/sys/.../iio:deviceX/bufferY/in_pressure_en
+What:		/sys/.../iio:deviceX/bufferY/in_rot_quaternion_en
+What:		/sys/.../iio:deviceX/bufferY/in_proximity_en
+KernelVersion:	5.11
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Scan element control for triggered data capture.
@@ -1185,6 +1222,23 @@ What:		/sys/.../iio:deviceX/scan_elements/in_pressure_type
 What:		/sys/.../iio:deviceX/scan_elements/in_rot_quaternion_type
 What:		/sys/.../iio:deviceX/scan_elements/in_proximity_type
 KernelVersion:	2.6.37
+What:		/sys/.../iio:deviceX/bufferY/in_accel_type
+What:		/sys/.../iio:deviceX/bufferY/in_anglvel_type
+What:		/sys/.../iio:deviceX/bufferY/in_magn_type
+What:		/sys/.../iio:deviceX/bufferY/in_incli_type
+What:		/sys/.../iio:deviceX/bufferY/in_voltageY_type
+What:		/sys/.../iio:deviceX/bufferY/in_voltage_type
+What:		/sys/.../iio:deviceX/bufferY/in_voltageY_supply_type
+What:		/sys/.../iio:deviceX/bufferY/in_voltageY_i_type
+What:		/sys/.../iio:deviceX/bufferY/in_voltageY_q_type
+What:		/sys/.../iio:deviceX/bufferY/in_voltage_i_type
+What:		/sys/.../iio:deviceX/bufferY/in_voltage_q_type
+What:		/sys/.../iio:deviceX/bufferY/in_timestamp_type
+What:		/sys/.../iio:deviceX/bufferY/in_pressureY_type
+What:		/sys/.../iio:deviceX/bufferY/in_pressure_type
+What:		/sys/.../iio:deviceX/bufferY/in_rot_quaternion_type
+What:		/sys/.../iio:deviceX/bufferY/in_proximity_type
+KernelVersion:	5.11
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Description of the scan element data storage within the buffer
@@ -1241,6 +1295,33 @@ What:		/sys/.../iio:deviceX/scan_elements/in_pressure_index
 What:		/sys/.../iio:deviceX/scan_elements/in_rot_quaternion_index
 What:		/sys/.../iio:deviceX/scan_elements/in_proximity_index
 KernelVersion:	2.6.37
+What:		/sys/.../iio:deviceX/bufferY/in_voltageY_index
+What:		/sys/.../iio:deviceX/bufferY/in_voltageY_supply_index
+What:		/sys/.../iio:deviceX/bufferY/in_voltageY_i_index
+What:		/sys/.../iio:deviceX/bufferY/in_voltageY_q_index
+What:		/sys/.../iio:deviceX/bufferY/in_voltage_i_index
+What:		/sys/.../iio:deviceX/bufferY/in_voltage_q_index
+What:		/sys/.../iio:deviceX/bufferY/in_accel_x_index
+What:		/sys/.../iio:deviceX/bufferY/in_accel_y_index
+What:		/sys/.../iio:deviceX/bufferY/in_accel_z_index
+What:		/sys/.../iio:deviceX/bufferY/in_anglvel_x_index
+What:		/sys/.../iio:deviceX/bufferY/in_anglvel_y_index
+What:		/sys/.../iio:deviceX/bufferY/in_anglvel_z_index
+What:		/sys/.../iio:deviceX/bufferY/in_magn_x_index
+What:		/sys/.../iio:deviceX/bufferY/in_magn_y_index
+What:		/sys/.../iio:deviceX/bufferY/in_magn_z_index
+What:		/sys/.../iio:deviceX/bufferY/in_rot_from_north_magnetic_index
+What:		/sys/.../iio:deviceX/bufferY/in_rot_from_north_true_index
+What:		/sys/.../iio:deviceX/bufferY/in_rot_from_north_magnetic_tilt_comp_index
+What:		/sys/.../iio:deviceX/bufferY/in_rot_from_north_true_tilt_comp_index
+What:		/sys/.../iio:deviceX/bufferY/in_incli_x_index
+What:		/sys/.../iio:deviceX/bufferY/in_incli_y_index
+What:		/sys/.../iio:deviceX/bufferY/in_timestamp_index
+What:		/sys/.../iio:deviceX/bufferY/in_pressureY_index
+What:		/sys/.../iio:deviceX/bufferY/in_pressure_index
+What:		/sys/.../iio:deviceX/bufferY/in_rot_quaternion_index
+What:		/sys/.../iio:deviceX/bufferY/in_proximity_index
+KernelVersion:	5.11
 Contact:	linux-iio@vger.kernel.org
 Description:
 		A single positive integer specifying the position of this
@@ -1455,6 +1536,8 @@ Description:
 
 What:		/sys/bus/iio/devices/iio:deviceX/buffer/watermark
 KernelVersion:	4.2
+What:		/sys/bus/iio/devices/iio:deviceX/bufferY/watermark
+KernelVersion:	5.11
 Contact:	linux-iio@vger.kernel.org
 Description:
 		A single positive integer specifying the maximum number of scan
@@ -1473,6 +1556,8 @@ Description:
 
 What:		/sys/bus/iio/devices/iio:deviceX/buffer/data_available
 KernelVersion: 4.16
+What:		/sys/bus/iio/devices/iio:deviceX/bufferY/data_available
+KernelVersion:	5.11
 Contact:	linux-iio@vger.kernel.org
 Description:
 		A read-only value indicating the bytes of data available in the
-- 
2.17.1

