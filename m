Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D9E48F625
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jan 2022 10:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbiAOJ1r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Jan 2022 04:27:47 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:58344 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbiAOJ1q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Jan 2022 04:27:46 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20F4QHs7005023;
        Sat, 15 Jan 2022 04:27:28 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3dkq81rvre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Jan 2022 04:27:28 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 20F9RR4R015121
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 15 Jan 2022 04:27:27 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sat, 15 Jan 2022 04:27:26 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sat, 15 Jan 2022 04:27:25 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sat, 15 Jan 2022 04:27:25 -0500
Received: from NSA-L01.ad.analog.com ([10.32.224.71])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 20F9RBL7010081;
        Sat, 15 Jan 2022 04:27:19 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH v2 2/3] iio: ABI: add ABI file for the LTC2688 DAC
Date:   Sat, 15 Jan 2022 10:27:04 +0100
Message-ID: <20220115092705.491-3-nuno.sa@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220115092705.491-1-nuno.sa@analog.com>
References: <20220115092705.491-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: QQUTE7eClWD3j_JRpGCYp288qEdlj2BT
X-Proofpoint-ORIG-GUID: QQUTE7eClWD3j_JRpGCYp288qEdlj2BT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-15_01,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=899 bulkscore=5 clxscore=1015 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=5 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201150055
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Define the sysfs interface for toggle or dither capable channels. Dither
capable channels will have the extended interface:

 * out_voltageY_dither_en
 * out_voltageY_dither_raw
 * out_voltageY_dither_offset
 * out_voltageY_dither_raw_available
 * out_voltageY_dither_frequency
 * out_voltageY_dither_frequency_available
 * out_voltageY_dither_phase
 * out_voltageY_dither_phase_available

Toggle enabled channels will have:

 * out_voltageY_toggle_en
 * out_voltageY_raw0
 * out_voltageY_raw1
 * out_voltageY_symbol

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 .../ABI/testing/sysfs-bus-iio-dac-ltc2688     | 80 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 81 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688 b/Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
new file mode 100644
index 000000000000..38d1df81c6dc
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
@@ -0,0 +1,80 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_dither_en
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Dither enable. Write 1 to enable dither or 0 to disable it.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_dither_raw
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This raw, unscaled value refers to the dither signal amplitude.
+		The same scale as in out_voltageY_raw applies. However, the
+		offset might be different as it's always 0 for this attribute.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_dither_raw_available
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Available range for dither raw amplitude values.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_dither_offset
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Offset applied to out_voltageY_dither_raw. Read only attribute
+		always set to 0.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_dither_frequency
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Sets the dither signal frequency.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_dither_frequency_available
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Returns the available values for the dither frequency.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_dither_phase
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Sets the dither signal phase.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_dither_phase_available
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Returns the available values for the dither phase.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_toggle_en
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Toggle enable. Write 1 to enable toggle or 0 to disable it.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_raw0
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		It has the same meaning as out_voltageY_raw. This attribute is
+		specific to toggle enabled channels and refers to the DAC output
+		code in INPUT_A. The same scale, offset, etc applies.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_raw1
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Same as out_voltageY_raw0 but referring to the DAC output code
+		in INPUT_B.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_symbol
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Performs a SW toggle. This attribute is specific to toggle
+		enabled channels and allows to toggle between out_voltageY_raw
+		and out_voltageY_raw1 through software. Writing 0 will select
+		out_voltageY_raw while 1 selects out_voltageY_raw1.
diff --git a/MAINTAINERS b/MAINTAINERS
index 16e344d52b1e..16a7fd7f98ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11187,6 +11187,7 @@ M:	Nuno Sá <nuno.sa@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	http://ez.analog.com/community/linux-device-drivers
+F:	Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
 F:	drivers/iio/dac/ltc2688.c
 
 LTC2947 HARDWARE MONITOR DRIVER
-- 
2.33.1

