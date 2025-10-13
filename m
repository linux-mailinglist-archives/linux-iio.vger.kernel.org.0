Return-Path: <linux-iio+bounces-25020-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AB6BD1C9D
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 09:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8703BA297
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 07:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4982E8E11;
	Mon, 13 Oct 2025 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="aKSuwlZl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194E12E7F29;
	Mon, 13 Oct 2025 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340558; cv=none; b=NTYvMLZwHt2fNdMmra1GkncFcHVEgwK9bGiZlTccFoHslS5Y2GoGhvy5LvJjWQpzeJMsIGH3pQvzkfoZDHFe3/T2Oj846bMRXczJy2Sjj8o52NitmnGSvtNVUJrmWneosCwO4hwcXIkltAKoDHjBRw7W5do8sUUf61c56gU9ywM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340558; c=relaxed/simple;
	bh=16ST8mC9fFPbFSQ5bTzHqg9UclfNbE/xz75c5MTChP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FiWo0SQdXUnS32THnX/BlA3C/ER+GrBC0eaK0yAmDX5peIIfST2wIJxJB4O4sDB7SImajl7/iZ/gkPx4AxK86QVYp5+QwACuWHmzbZ6fZFgQ5ZaXezu/rmq1btf/+EXzDetcQvA4HPaASUKtMtHGfQRcPGrpDsVjsdVm0QWbNVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=aKSuwlZl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D3xRbj008597;
	Mon, 13 Oct 2025 03:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Pd0Q8
	OVyfLr7zlEhQkgFB/ukWlNhG2Q3zVaQpfGFukA=; b=aKSuwlZlJyIJ4AJejhh0a
	gjsx1o6h3t0nLFQbjdlvE+EV1TLQ5nmXonsZn4tXQHaTGsuLmj2RGjvzD7Jgm3YZ
	EDB+FlWaObbtlaj69Jho0EZTC+mGCu60hxgUqCr6RtCyA0vv+KFra0NVkUUbS1GO
	9SiCiwylfCgSEEwTAr2gdbstT+JGF/6d4qpaK8Cz/pFR3iyph0EYmY60QnJhIgIv
	B9JB9z6jr3ajElt6hCQv45dBVOGZPSuq8PdHyuD8eOiNOR5CkD0INMPxF5QbxibZ
	TIcrhpOBlEhtSi3jaUzMsLgRpVjVA25Cv1+mxxdNbf8mx1y0jAyb1OJYEU7ZRS+a
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49qm508agk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 03:29:00 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 59D7SxaW022862
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Oct 2025 03:28:59 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 13 Oct
 2025 03:28:59 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 13 Oct 2025 03:28:59 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59D7ShZ8013800;
	Mon, 13 Oct 2025 03:28:53 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Mon, 13 Oct 2025 09:28:00 +0200
Subject: [PATCH 2/7] docs: iio: New docs for ad4062 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251013-staging-ad4062-v1-2-0f8ce7fef50c@analog.com>
References: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
In-Reply-To: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Jorge Marques
	<jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760340523; l=3623;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=16ST8mC9fFPbFSQ5bTzHqg9UclfNbE/xz75c5MTChP0=;
 b=qrwkD4YAS7opmFLWTfg379hPKktEdFaj+YrnL15wT3T7+RIoKycFhMbIervMhLWAWVo+W0pJg
 YMOoI32yTy2CIKRAoo/clzghAOnbMO0AbyiWy3acjelCJIrUSTwu2wc
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=cJ7tc1eN c=1 sm=1 tr=0 ts=68ecaa3c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=gAnH3GRIAAAA:8 a=KQWnvXESmFA-g6fypRYA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDA0NyBTYWx0ZWRfX0zZK222toRdz
 PA0RmsE0U5Yt3Vo+ZTN7GI8FiMnVpS7fpZKVZiTsZDiCGkvxCcswSENUoySvExAs61B7pJyoWjF
 79R2ZVNaUW8Y7gGhZrrqCV2/apjguB1JSOolUYmbheml1gezmLnVEQxmpblSDs3NhK40hqLvZWa
 6Q8Q6LhGbWdLL4TTyTeKjg3dgv/umQimTvoFVUCYz7d0ybvE7GZzTlnyOpjFy69zmuKyWZDyaXL
 BrYnfLsedCMQG1rY11USeA/+4GgMXFOH5OxSBQ9rKpzQWToFZ1AyDv9LepxVB/zX3n0FLUiNZtg
 FnwONEkBp/K0v5o6vP5beC7hnaTk2ca9SiuZQSmQvFGHBLxsnJA/bNsWsF6Iv2cuZ/fOyfoMNfA
 NYISdfe/IrKDwHVjGNfxc2M1LniHug==
X-Proofpoint-GUID: qgJe7Pl9A7NhmhggJrmbf9EQvBa1mTdM
X-Proofpoint-ORIG-GUID: qgJe7Pl9A7NhmhggJrmbf9EQvBa1mTdM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 suspectscore=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110047

This adds a new page to document how to use the ad4062 ADC driver.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 Documentation/iio/ad4062.rst | 89 ++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                  |  1 +
 2 files changed, 90 insertions(+)

diff --git a/Documentation/iio/ad4062.rst b/Documentation/iio/ad4062.rst
new file mode 100644
index 0000000000000000000000000000000000000000..b486d7fe1916d2963c94581be3696cf58d51ca48
--- /dev/null
+++ b/Documentation/iio/ad4062.rst
@@ -0,0 +1,89 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=============
+AD4062 driver
+=============
+
+ADC driver for Analog Devices Inc. AD4060/AD4062 devices. The module name is
+``ad4062``.
+
+Supported devices
+=================
+
+The following chips are supported by this driver:
+
+* `AD4060 <https://www.analog.com/AD4060>`_
+* `AD4062 <https://www.analog.com/AD4062>`_
+
+Wiring modes
+============
+
+The ADC is interfaced through an I3C bus, and contains two programmable GPIOs.
+
+The ADC convert-start happens on the SDA rising edge of the I3C stop (P) bit
+at the end of the read command.
+
+The two programmable GPIOS are optional and have a role assigned if present in
+the devicetree:
+
+- GP1: Is assigned the role of Data Ready signal.
+
+Device attributes
+=================
+
+The ADC contains only one channel with following attributes:
+
+.. list-table:: Channel attributes
+   :header-rows: 1
+
+   * - Attribute
+     - Description
+   * - ``in_voltage_calibscale``
+     - Sets the scale factor to multiply the raw value.
+   * - ``in_voltage_oversampling_ratio``
+     - Sets device's burst averaging mode to over sample using the
+       internal sample rate. Value 1 disable the burst averaging mode.
+   * - ``in_voltage_oversampling_ratio_available``
+     - List of available oversampling values.
+   * - ``in_voltage_raw``
+     - Returns the raw ADC voltage value.
+   * - ``in_voltage_scale``
+     - Returs the channel scale in reference to the reference voltage
+       ``ref-supply``.
+
+Also contain the following device attributes:
+
+.. list-table:: Device attributes
+   :header-rows: 1
+
+   * - Attribute
+     - Description
+   * - ``samling_frequency``
+     - Sets the sets the device internal sample rate, used in the burst
+       averaging mode.
+   * - ``sampling_frequency_available``
+     - Lists the available device internal sample rates.
+
+Interrupts
+==========
+
+The interrupts are mapped through the ``interrupt-names`` and ``interrupts``
+properties.
+
+The ``interrupt-names`` ``gp1`` entry sets the role of Data Ready signal.
+If it is not present, the driver fallback to enabling the same role as an
+I3C IBI.
+
+Low-power mode
+==============
+
+The device enters low-power mode on idle to save power. Enabling an event puts
+the device out of the low-power since the ADC autonomously samples to assert
+the event condition.
+
+Unimplemented features
+======================
+
+- Monitor mode
+- Trigger mode
+- Averaging mode
diff --git a/MAINTAINERS b/MAINTAINERS
index afbfaeba5387b9fbfa9bf1443a059c47dd596d45..ce012c6c719023d3c0355676a335a55d92cf424c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1405,6 +1405,7 @@ M:	Jorge Marques <jorge.marques@analog.com>
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
+F:	Documentation/iio/ad4062.rst
 
 ANALOG DEVICES INC AD4080 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>

-- 
2.49.0


