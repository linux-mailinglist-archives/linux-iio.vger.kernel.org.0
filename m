Return-Path: <linux-iio+bounces-26402-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FB2C7F8E9
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 10:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F04D14E592F
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 09:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B242F547D;
	Mon, 24 Nov 2025 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SmA7eRj5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8162F4A16;
	Mon, 24 Nov 2025 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975939; cv=none; b=EDmIrSThYPfbYZJRZ7U4G7BJuril6O300IhERF4d/ZH7bxrPmdcgn7P2kximdFRsVG+fCi35J+QKk5/1DNXC7RtGlJTmHgYlp2JyDUVHJ72UXBuDembSPLETzD6JWjdtw/eUMJ7Xm1ptxkRQSmuKCrc0wkjv3tMhteZkxNpEP6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975939; c=relaxed/simple;
	bh=Z8LmT3qY041U83j0q+I/X13ABeV5uquFKXkkjyjU46A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NyC6rRYySb+Q1mLWnNf6A3h8ZgRhyc66+fL59eVYtwDrlY91ohWlbn0fBLdeIqBTZstJYmwe40T671iIh8E/RzCFevD1CAFaM6W4d2TXCweI8V+45mLMI5JPMrjwQX9gQV8G7NLgAiVKZQ7q1K/K3TBwkHXa3JYqgQ76IEhgluk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SmA7eRj5; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AO72rRt3692062;
	Mon, 24 Nov 2025 04:18:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=P0sLh
	+LxqQq6lmxSuci+6Il+GFar9iBr5Mc1DPZRFLY=; b=SmA7eRj5rcxN6NdXvvuIA
	psb/Zr4QvNJnTJ017G5Xjsk2x9bdwlpUYvqJe+5jVQwG5upymSj06pHFIyxnbJoF
	+SyUmmiJ1+4a5iTPnelTJakirAoVfShtpdWn0bR6+maz9B4spPGHv11xEJr7GLom
	Jtm0JU07RYE1DBSD2qHfMcn8qVBIgs+Q/P1MinhsofZAZawG2XN/iNtpH7b3jIlR
	ObrwfmOVsXWF0dcsMy6FXJtqP21pACcBtoS7Fji0UUxRv7kJAodfoQf50SwhIDED
	HADYz1phOnkjyDK3apj0fc7CIV+OwieL52K7Q4Depfd0IcqI9y2UGLF/7GEFwXk+
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4akvcjmw7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 04:18:28 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5AO9IR8J050884
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Nov 2025 04:18:27 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 24 Nov
 2025 04:18:27 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 24 Nov 2025 04:18:27 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.82])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AO9I8VL024016;
	Mon, 24 Nov 2025 04:18:20 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Mon, 24 Nov 2025 10:18:01 +0100
Subject: [PATCH v2 2/9] docs: iio: New docs for ad4062 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251124-staging-ad4062-v2-2-a375609afbb7@analog.com>
References: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
In-Reply-To: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763975888; l=4325;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=Z8LmT3qY041U83j0q+I/X13ABeV5uquFKXkkjyjU46A=;
 b=jJNj03hkSeBFF9vkNqDG9dZrPgoF43A3DbjgZmysB03r5VB5qLsuCbuY1b7za0N/W/1cYfFHj
 0PiDJzywFR2CLYi5wEkJ2/N3l89jXQ6YjlhOjWT01RXrD4yoNtJaKYi
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDA4MSBTYWx0ZWRfXxZ/qTJBhbYe5
 tBhuWZhMaw4340Jmr9lVy9tASE1Xbsxi2/CTtBEicUE2aZO5Oa4kK7STr1yD9vD5+X5M6QWIrZi
 DSgLnZE18WHRQks8b5aU8f3L33OYF9TiOjv8Vow1hih+Q4eM4N9SHZDScXd/5lKXkjTAFiGBLkS
 TwZ+RkDt89RyZcaMqRBfsZqfbqM3qpUiJHf5s5jymXbmIUxAUvIaHT0alcUwOW7GZVcEEcxYf2j
 e5sMzE9vtzepHsCMAGDkRItLUOkvihy9OGC0WskPsDYRfF4yzDsB90TXDTTcJC0vFJTIG/SOcLg
 5yWQfDS0KmnCfOTB0M9hQOGLqxEtQBMY/yY7RCyVJcpJvERn7cgOlTPDShdwYCR8Lup40to0W67
 AjNaLsFlH9bH6jpBo2CEHouJP+dqYw==
X-Authority-Analysis: v=2.4 cv=EqrfbCcA c=1 sm=1 tr=0 ts=692422e4 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=5m_mccj1f-mIrhuec74A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: NlgkzN2oYlEEivSc8m3yj9ygm_2uOyVt
X-Proofpoint-GUID: NlgkzN2oYlEEivSc8m3yj9ygm_2uOyVt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_03,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240081

This adds a new page to document how to use the ad4062 ADC driver.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 Documentation/iio/ad4062.rst | 94 ++++++++++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |  1 +
 MAINTAINERS                  |  1 +
 3 files changed, 96 insertions(+)

diff --git a/Documentation/iio/ad4062.rst b/Documentation/iio/ad4062.rst
new file mode 100644
index 0000000000000..e6bcca2bef24b
--- /dev/null
+++ b/Documentation/iio/ad4062.rst
@@ -0,0 +1,94 @@
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
+
+Unimplemented features
+======================
+
+- Monitor mode
+- Trigger mode
+- Averaging mode
+- General purpose output
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
index e22ba5ec8c849..8fc28b789d639 100644
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


