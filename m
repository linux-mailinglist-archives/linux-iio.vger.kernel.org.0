Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CEF4960AB
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jan 2022 15:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381017AbiAUOZk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Jan 2022 09:25:40 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:12444 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380991AbiAUOZj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Jan 2022 09:25:39 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20LCEIAm008982;
        Fri, 21 Jan 2022 09:25:22 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3dqj3ku0ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 09:25:22 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 20LEPL23002034
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Jan 2022 09:25:21 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 21 Jan 2022 09:25:20 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 21 Jan 2022 09:25:20 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 21 Jan 2022 09:25:20 -0500
Received: from NSA-L01.ad.analog.com ([10.32.224.71])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 20LEP5pl017001;
        Fri, 21 Jan 2022 09:25:13 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH v3 2/3] iio: ABI: add ABI file for the LTC2688 DAC
Date:   Fri, 21 Jan 2022 15:25:00 +0100
Message-ID: <20220121142501.151-3-nuno.sa@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220121142501.151-1-nuno.sa@analog.com>
References: <20220121142501.151-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: tHVzr8fpR55CI9zhSdOhouHty5lxkMfw
X-Proofpoint-GUID: tHVzr8fpR55CI9zhSdOhouHty5lxkMfw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_06,2022-01-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=931 phishscore=0 bulkscore=6 lowpriorityscore=6
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201210097
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

The common interface present in all channels is:

 * out_voltageY_raw (not present in toggle enabled channels)
 * out_voltageY_raw_available
 * out_voltageY_powerdown
 * out_voltageY_scale
 * out_voltageY_offset
 * out_voltageY_calibbias
 * out_voltageY_calibscale

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 .../ABI/testing/sysfs-bus-iio-dac-ltc2688     | 86 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 87 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688 b/Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
new file mode 100644
index 000000000000..0ceded7e932b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
@@ -0,0 +1,86 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_dither_en
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Dither enable. Write 1 to enable dither or 0 to disable it. This is useful
+		for changing the dither parameters. They way it should be done is:
+
+		- disable dither operation;
+		- change dither parameters (eg: frequency, phase...);
+		- enabled dither operation
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
+		Sets the dither signal frequency. Units are in Hz.
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
+		Sets the dither signal phase. Units are in Radians.
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
+		Toggle enable. Write 1 to enable toggle or 0 to disable it. This is
+		useful when one wants to change the DAC output codes. The way it should
+		be done is:
+
+		- disable toggle operation;
+		- change out_voltageY_raw0 and out_voltageY_raw1;
+		- enable toggle operation.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_raw0
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_raw1
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		It has the same meaning as out_voltageY_raw. This attribute is
+		specific to toggle enabled channels and refers to the DAC output
+		code in INPUT_A (_raw0) and INPUT_B (_raw1). The same scale and offset
+		as in out_voltageY_raw applies.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_symbol
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Performs a SW toggle. This attribute is specific to toggle
+		enabled channels and allows to toggle between out_voltageY_raw0
+		and out_voltageY_raw1 through software. Writing 0 will select
+		out_voltageY_raw0 while 1 selects out_voltageY_raw1.
diff --git a/MAINTAINERS b/MAINTAINERS
index 419b181f4749..1ce4bb5e460a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11195,6 +11195,7 @@ M:	Nuno Sá <nuno.sa@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	http://ez.analog.com/community/linux-device-drivers
+F:	Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
 F:	drivers/iio/dac/ltc2688.c
 
 LTC2947 HARDWARE MONITOR DRIVER
-- 
2.34.1

