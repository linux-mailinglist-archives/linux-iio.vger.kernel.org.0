Return-Path: <linux-iio+bounces-27139-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AD3CC78DB
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 13:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3864D30887B2
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 12:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A405F342169;
	Wed, 17 Dec 2025 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="n1Qy5ZF0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC9833F8BF;
	Wed, 17 Dec 2025 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765973660; cv=none; b=e8OOtTSn7Uy3KA3DCM74BLCPkDavWpisYwVutnqnJ0ZM/2cgJONsJQ7MGgdQ2XM1cPzXRPwMksabQzzqNed4YNbAukIjJKrr7/0HigcZc9ovTYzud5Efr2es8xxH4zHStTV/1vl5wdLft+mJUjaIjwXwY+VpfHChbTSUaQ+79Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765973660; c=relaxed/simple;
	bh=MuHYsLjxwdN8IkJNsHAUBMs6LN4MRGpg5MuRP0IoWa8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rdb7ZmoxlaxYG/w9Np/yPi53sYk4Ql0vfOfxsXXdcxMpV5I6mVZ4KnnJzMhjyjkh7Bya9b7bdcXR1OfsbKjOERgnn/MaytWUBlvyn8tQo300DGsS3Y7Wj9YMuxVoiJqhQl4GZaofQ7dLrtwy4wg4zo49fJcRgwXYfEV+/lxlsh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=n1Qy5ZF0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHAsJYx3839967;
	Wed, 17 Dec 2025 07:13:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xrV4J
	cgO8S4mlg0S60Bb6DHITfHakEA08GWxAiwTfrU=; b=n1Qy5ZF0aRb252PGD/GMg
	9UHoAtDMUK//AkXKre7U8qz3qnWfPzH9dw+RJOQU2d/1mBVzvmob1YgHznVDEqhM
	Qisctj/o1htCVzP6+WDVlfzlL8aCIh+PU4luafAxgayRad5zBz+O4DrPetfTNv6Y
	7zO2R248YEZYzSlrRguPig7zoXEiUwLXPu1MidaiFdaIalmB2nrhZSnTB0b5D8YJ
	E3xGkwWsmAhxIYj7y9lBW5AG21lxU5u+0DskW98bbkBdVDqDb57nXY2SF5qu/9z0
	e1NlVZy0GLQAWmkMQF7yQKqtFv6Fp2KnH39AVtOkEt7bgZFKxfpcboDP99wD08k0
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4b3jw9jegb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 07:13:50 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5BHCDnho041082
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Dec 2025 07:13:49 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 17 Dec
 2025 07:13:49 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 17 Dec 2025 07:13:49 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5BHCDUv8014815;
	Wed, 17 Dec 2025 07:13:42 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Wed, 17 Dec 2025 13:13:25 +0100
Subject: [PATCH v4 2/9] docs: iio: New docs for ad4062 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251217-staging-ad4062-v4-2-7890a2951a8f@analog.com>
References: <20251217-staging-ad4062-v4-0-7890a2951a8f@analog.com>
In-Reply-To: <20251217-staging-ad4062-v4-0-7890a2951a8f@analog.com>
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
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Jorge Marques <jorge.marques@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765973610; l=4189;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=MuHYsLjxwdN8IkJNsHAUBMs6LN4MRGpg5MuRP0IoWa8=;
 b=X20dKF/QcN5DGrpOir73v8AawVMq83fiQvD+On/JHzQg4YhNG+nKSdazkThkWQ4u28i+XPhsS
 kewKQnbj1iWBhsk5UPa3TvNU0tUn9U3VytacQgTR1nnxXUWgv3g3so5
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA5NCBTYWx0ZWRfXwR+c+D0k6ocy
 gR7Q4vehIDyyW5XaSBONmRpu5nTxOJwsOwBR1urcYN8H2eWvtL6zveFoQod4MdzWLpBIh3cUhgY
 BL9Y6HW0pEtEKNAPVworFoLebTkU2eJ9k3A4B+P2py5pETjOtVW0/xez3AynI4W4yiASCDn9fn2
 w1QgN86B1uRxO8rgsynoY57jx3+/vOx3tpgOgUFFoR8baNcR/4wy/MB1eHVZX/YiMuzz/26LQpN
 PCwvLg5xQlaoSY/Tccngv281QzltMOTVWE9J4E0f7dlmVM2LnPhYwKrnEPwnnyFc/A0znvqpofm
 d6FR8ehjxt1qOLvErMMRm/Xe0yUOl0Y7B2cqUzgqjfdI6NdgEzDEZ5MEUX/uKUlJjVa+TJ4o35p
 DW14NvxCqgTtozmlsigLKG98T6ugjg==
X-Authority-Analysis: v=2.4 cv=TZGbdBQh c=1 sm=1 tr=0 ts=69429e7e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=5m_mccj1f-mIrhuec74A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: GHcQ39509lgPrKWvMBbAGQCkocVIVqxt
X-Proofpoint-ORIG-GUID: GHcQ39509lgPrKWvMBbAGQCkocVIVqxt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170094

This adds a new page to document how to use the ad4062 ADC driver.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 Documentation/iio/ad4062.rst | 86 ++++++++++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |  1 +
 MAINTAINERS                  |  1 +
 3 files changed, 88 insertions(+)

diff --git a/Documentation/iio/ad4062.rst b/Documentation/iio/ad4062.rst
new file mode 100644
index 0000000000000..30200adf90c38
--- /dev/null
+++ b/Documentation/iio/ad4062.rst
@@ -0,0 +1,86 @@
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
+the devicetree ``interrupt-names`` property:
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
+     - Sets the gain scaling factor that the hardware applies to the sample,
+       to compensate for system gain error.
+   * - ``in_voltage_oversampling_ratio``
+     - Sets device's burst averaging mode to over sample using the
+       internal sample rate. Value 1 disable the burst averaging mode.
+   * - ``in_voltage_oversampling_ratio_available``
+     - List of available oversampling values.
+   * - ``in_voltage_raw``
+     - Returns the raw ADC voltage value.
+   * - ``in_voltage_scale``
+     - Returns the channel scale in reference to the reference voltage
+       ``ref-supply`` or ``vdd-supply`` if the former not present.
+
+Also contain the following device attributes:
+
+.. list-table:: Device attributes
+   :header-rows: 1
+
+   * - Attribute
+     - Description
+   * - ``sampling_frequency``
+     - Sets the duration of a single scan, used in the burst averaging mode.
+       The duration is described by ``(n_avg - 1) / fosc + tconv``, where
+       ``n_avg`` is the oversampling ratio, ``fosc`` is the internal sample
+       rate and ``tconv`` is the ADC conversion time.
+   * - ``sampling_frequency_available``
+     - Lists the available sampling frequencies, computed on the current
+       oversampling ratio. If the ratio is 1, the frequency is ``1/tconv``.
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
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 315ae37d6fd4b..ba3e609c6a13c 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -22,6 +22,7 @@ Industrial I/O Kernel Drivers
    ad3552r
    ad4000
    ad4030
+   ad4062
    ad4695
    ad7191
    ad7380
diff --git a/MAINTAINERS b/MAINTAINERS
index bc1d6b2d0a11e..0730b79c3dd0d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1437,6 +1437,7 @@ M:	Jorge Marques <jorge.marques@analog.com>
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
+F:	Documentation/iio/ad4062.rst
 
 ANALOG DEVICES INC AD4080 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>

-- 
2.51.1


