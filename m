Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B467C474897
	for <lists+linux-iio@lfdr.de>; Tue, 14 Dec 2021 17:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbhLNQ4q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Dec 2021 11:56:46 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:15298 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236162AbhLNQ4m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Dec 2021 11:56:42 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BEG6cwR002011;
        Tue, 14 Dec 2021 11:56:23 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3cxq9asmjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 11:56:23 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 1BEGuMtb026584
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Dec 2021 11:56:22 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 14 Dec
 2021 11:56:20 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 14 Dec 2021 11:56:20 -0500
Received: from NSA-L01.ad.analog.com ([10.32.224.5])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1BEGuEor021154;
        Tue, 14 Dec 2021 11:56:17 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 2/3] iio: ABI: add ABI file for the LTC2688 DAC
Date:   Tue, 14 Dec 2021 17:56:07 +0100
Message-ID: <20211214165608.7903-3-nuno.sa@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211214165608.7903-1-nuno.sa@analog.com>
References: <20211214165608.7903-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: bB1XLkVbyReG1PEJVm0mTY7HvV59UloS
X-Proofpoint-ORIG-GUID: bB1XLkVbyReG1PEJVm0mTY7HvV59UloS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_07,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=807 spamscore=0 phishscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=52 bulkscore=52 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112140092
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Define the sysfs interface for toggle or dither capable channels. Dither
capable channels will have the extended interface:

 * out_voltageY_dither_en
 * out_voltageY_dither_raw
 * out_voltageY_dither_raw_available
 * out_voltageY_dither_frequency
 * out_voltageY_dither_frequency_available
 * out_voltageY_dither_phase
 * out_voltageY_dither_phase_available

Toggle enabled channels will have:

 * out_voltageY_toggle_en
 * out_voltageY_raw1
 * out_voltageY_symbol

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 .../ABI/testing/sysfs-bus-iio-dac-ltc2688     | 67 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 68 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688 b/Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
new file mode 100644
index 000000000000..0c45de94dd75
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
@@ -0,0 +1,67 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_dither_en
+KernelVersion:	5.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Dither enable. Write 1 to enable dither or 0 to disable it.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_dither_raw
+KernelVersion:	5.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This raw, unscaled value refers to the dither signal amplitude.
+		The same scale as in out_voltageY_raw applies. However, the
+		offset might be different as it's always 0 for this attribute.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_dither_raw_available
+KernelVersion:	5.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Available range for dither raw amplitude values.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_dither_frequency
+KernelVersion:	5.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Sets the dither signal frequency.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_dither_frequency_available
+KernelVersion:	5.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Returns the available values for the dither frequency.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_dither_phase
+KernelVersion:	5.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Sets the dither signal phase.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_dither_phase_available
+KernelVersion:	5.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Returns the available values for the dither phase.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_toggle_en
+KernelVersion:	5.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Toggle enable. Write 1 to enable toggle or 0 to disable it.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_raw1
+KernelVersion:	5.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		It has the same meaning as out_voltageY_raw. This attribute is
+		specific to toggle enabled channels and refers to the DAC output
+		code in the INPUT_B register while regular out_voltageY_raw
+		refers to INPUT_A. The same scale, offset, etc applies.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_symbol
+KernelVersion:	5.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Performs a SW toggle. This attribute is specific to toggle
+		enabled channels and allows to toggle between out_voltageY_raw
+		and out_voltageY_raw1 through software. Writing 0 will select
+		out_voltageY_raw while 1 selects out_voltageY_raw1.
diff --git a/MAINTAINERS b/MAINTAINERS
index 90960e3d778f..61b1eaad4611 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11167,6 +11167,7 @@ M:	Nuno Sá <nuno.sa@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	http://ez.analog.com/community/linux-device-drivers
+F:	Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
 F:	drivers/iio/dac/ltc2688.c
 
 LTC2947 HARDWARE MONITOR DRIVER
-- 
2.17.1

