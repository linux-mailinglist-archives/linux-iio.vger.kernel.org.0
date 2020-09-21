Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD9527258B
	for <lists+linux-iio@lfdr.de>; Mon, 21 Sep 2020 15:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgIUNar (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Sep 2020 09:30:47 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:18918 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726749AbgIUNar (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Sep 2020 09:30:47 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08LDU8up022676;
        Mon, 21 Sep 2020 09:30:45 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33nbu66g95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 09:30:45 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 08LDUh6V064136
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 21 Sep 2020 09:30:44 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 21 Sep 2020 06:30:45 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 21 Sep 2020 06:30:45 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08LDUW2F021472;
        Mon, 21 Sep 2020 09:30:39 -0400
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH v6 2/4] iio:Documentation: Add documentation for label channel attribute
Date:   Mon, 21 Sep 2020 16:30:18 +0300
Message-ID: <20200921133020.62978-2-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921133020.62978-1-cristian.pop@analog.com>
References: <20200921133020.62978-1-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-21_05:2020-09-21,2020-09-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009210097
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If a label is defined for this channel add that to the channel specific
attributes. This is useful for userspace to be able to identify an
individual channel.

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
Changes in v6:
 - Fix documentation
 Documentation/ABI/testing/sysfs-bus-iio | 72 +++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index a9d51810a3ba..53c5156362af 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1715,6 +1715,78 @@ Description:
 
 		Raw counter device counters direction for channel Y.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_powerY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_accelY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_accelY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_angl_velY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_angl_velY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_magnY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_magnY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_lightY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_lightY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_intensityY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_intensityY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximityY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_proximityY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_tempY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_incliY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_incliY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_rotY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_rotY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_anglY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_timestampY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_timestampY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_capacitanceY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_cctY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_cctY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_pressureY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelativeY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_humidityrelativeY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_activityY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_activityY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_stepsY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_stepsY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_energyY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_energyY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_distanceY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_distanceY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_velocityY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_velocityY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_concentrationY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_resistanceY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_resistanceY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_phY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_phY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_uvindexY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_uvindexY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_electricalconductivityY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_electricalconductivityY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_countY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_countY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_indexY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_indexY_label
+What:		/sys/bus/iio/devices/iio:deviceX/in_gravityY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_gravityY_label
+KernelVersion:	5.8
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Optional symbolic label to a device channel.
+		If a label is defined for this channel add that to the channel
+		specific attributes. This is useful for userspace to be able to
+		better identify an individual channel.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_phaseY_raw
 KernelVersion:	4.18
 Contact:	linux-iio@vger.kernel.org
-- 
2.17.1

