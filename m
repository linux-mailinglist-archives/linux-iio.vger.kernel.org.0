Return-Path: <linux-iio+bounces-26801-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D528BCA8357
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 16:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C96B4305B2A1
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 15:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDB734EF10;
	Fri,  5 Dec 2025 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Lx44SxfD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E2D34DCE4;
	Fri,  5 Dec 2025 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947582; cv=none; b=LCmF3NBA2x6mnrnlSbhZ8GyaUwUYQpDTQ7Npltjzuh1C4uv2J2FxW5/DOpgSNK+Gj2fDzch17rLGBqfng28xomOgZOe0zMZ2uuamnP+17luOxVkymRT1FEmbEXzbQxEXptLFH8VWE1CX4YpWv2ZrZ1k2xzTizT0NT/UeJ2yhS/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947582; c=relaxed/simple;
	bh=Z8LmT3qY041U83j0q+I/X13ABeV5uquFKXkkjyjU46A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Irt9im504DEn/Zfa1o1Oi+DHOUP4rZugJieaMLRIzHWsP0jy0OZoUjMCKxKSSjE8vLksTzW0HXEZuUJFyJW5IK5DUDqP/+i46ZI3y/1CyftCJZFMTQJUGZQCRaAd4tOE+gC36gUdzIr/z2tyUc/Lks8TtwRqbr2qa4o2Juvw64Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Lx44SxfD; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5BN6RC3489746;
	Fri, 5 Dec 2025 10:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=P0sLh
	+LxqQq6lmxSuci+6Il+GFar9iBr5Mc1DPZRFLY=; b=Lx44SxfD6fhq36uL6fkQE
	jb93bZ8o3b9lKDe6hLNGk6p4bzZXcZ/brET6HQi3fINHxsechxqGVE5Gc7NGkN+q
	u61kH1mfGB6ZHGEkfMRoqgj1ct5KhaoGrAyNrJGjhB4PLxZPXeH2ytyqFCYQgvcc
	kVs85mdGxwnPsMM1Rl9glVJAA7nYtw50Tst1VHWfZv/SbrrLqQUjbqSGp5CJFZYF
	7py2wsDlEnbIcxr5RpcmKWltfMlbopCuKiMYF14g67NDii5V4rV3xFaUjuUm6BJf
	9ibKKhW8CB1rSOih9YtGkTAgZTRXGkCvo+4nAnXnDjFqQWJONw+c4muH2h4dEr8f
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4auhvuv2gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 10:12:33 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5B5FCWce033539
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Dec 2025 10:12:32 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 5 Dec 2025 10:12:32 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 5 Dec 2025 10:12:32 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 5 Dec 2025 10:12:32 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5B5FC8SC029946;
	Fri, 5 Dec 2025 10:12:23 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Fri, 5 Dec 2025 16:12:03 +0100
Subject: [PATCH v3 2/9] docs: iio: New docs for ad4062 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251205-staging-ad4062-v3-2-8761355f9c66@analog.com>
References: <20251205-staging-ad4062-v3-0-8761355f9c66@analog.com>
In-Reply-To: <20251205-staging-ad4062-v3-0-8761355f9c66@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764947528; l=4325;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=Z8LmT3qY041U83j0q+I/X13ABeV5uquFKXkkjyjU46A=;
 b=wLtsg9C+ftw4C9/Hw9/yFN1IwZe/lFdV0zKDaNznJYe6gNy8A9MJkqE3Z/iuBf516V8yXQdgV
 4mfB0GtHSkVAW9jlb0j/LIJUNTYPCu61GjBQx/jB9c83zPYSzXznnuw
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDEwOSBTYWx0ZWRfX5onSU7GzlK0k
 Q2bE09q8JI29xbv/uXWaRz2bnfikD3IOrhm7aOhVeU4/sFCd5YXeIX3MlGsoAqQfupWe7GSdhD7
 uy9yvADfQ409oad1P4EWRVxiTIXnNhOvyOPw5psMycdunHSQ20q9m++594mNc5vUHcM12TYzoFQ
 PaLSCpEdzHcz+aPr2662nM4X6EroQguBdMuZzfd7WnR2ZR7e8gMQSfk1Mt7eNdNuRYNDx9fG/BF
 ybm9JieY4vLW5+1CBphZP1B8zkl2F5nd5fFNQTP4K6jyJGdcvFB5TBjny9Q2qZa46RvPZqfDA8B
 BKkw48abaXtaJ0s5zRmQiKATDzOcwOOmEW6/APnkOVgV9/ev525saSMYb+CHB7JfhI3u9lE0xAS
 qXPdYm9IiZ6aVzm0Y+aKWL7Mt8J4Zg==
X-Authority-Analysis: v=2.4 cv=Q+nfIo2a c=1 sm=1 tr=0 ts=6932f661 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=5m_mccj1f-mIrhuec74A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3CBcdwLKj-hLFWlhDQV7Dcr1t784YGzc
X-Proofpoint-GUID: 3CBcdwLKj-hLFWlhDQV7Dcr1t784YGzc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_05,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512050109

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


