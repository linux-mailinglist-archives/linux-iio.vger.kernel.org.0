Return-Path: <linux-iio+bounces-26411-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B76BC7F946
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 10:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A84434A4C5
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 09:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FC92F99AD;
	Mon, 24 Nov 2025 09:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="svjx55pW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B4F2F5A30;
	Mon, 24 Nov 2025 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975943; cv=none; b=PbcRujlZ6InoWOyIhYly6nTZeHhrQ1Nt4/RbW9RKxrXJnfq3gdV48eBAprdnMSGrMIR3seFQzh7B6yZp2S+6ildEGvNh3vh/OB89kgXoUnvypbtrsvE3/XAWmEfuK9v0CTEDg7DeqWm8GeOKP9wYaPcEqmJd/yp1zqXidn7iK8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975943; c=relaxed/simple;
	bh=4P/RqBEcX19v2SQ2Hadch135990cWmTU6gATYHLDJC0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=VEKyV174ZNNhd+Wg12G8ky8iVcnJmOsrPP30jbNCmqRZZGM/iqxpkpToeHq5hQ8qZstr548HeIM4U7HJalF2rAIQd5tcjwR2JBRAPJUKxJ1YJWWvCkoIXfLLwQlS+N5gMb6UcUpXTCsg+gGpq7sJ0jS+KIsSK8QvZgLoIy0Hcn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=svjx55pW; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AO74McF3692353;
	Mon, 24 Nov 2025 04:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=3oNRuA//PVzYPplPiLPxNRSlQeH
	2f8d4+dq/qecqKCE=; b=svjx55pW8snnswej1uNLgYGBdLNzsDlyBk0VfxTytML
	neRFQTFhM//SxohDaZvbfAhf3ELkvvzjLfNATT4qN2SbzEuxrRHaPYu/puxkd6lc
	N3cAqFYeIXWFsiEJIMSHR+6PxKuKfMCQTKMIzpeRw94tCUm+i1IjEQN1HYU2Fbs6
	NELFj3aleJsgh1EZ1EWZP6QFRVvMBh47uG24+c7MG5MbT2/tWO7hWeVW/3+B+MCe
	j4TwizMN0g1fGdC8asQm+TceSELYdRUBEuco5BmSj/IJFkywQNz8r8eLH5DbpTCh
	bOfmm4PfC0aEHLE/SB88QMgsVFg6v06utKow2FkMiIQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4akvcjmw8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 04:18:32 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5AO9IVcF050893
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Nov 2025 04:18:31 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 24 Nov 2025 04:18:30 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 24 Nov 2025 04:18:24 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 24 Nov 2025 04:18:24 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.82])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AO9I8VJ024016;
	Mon, 24 Nov 2025 04:18:10 -0500
From: Jorge Marques <jorge.marques@analog.com>
Subject: [PATCH v2 0/9] Add support for AD4062 device family
Date: Mon, 24 Nov 2025 10:17:59 +0100
Message-ID: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMgiJGkC/13Py2rDMBAF0F8xWldl9LAse9X/KFnoMeMIGjuVH
 NMS8u+dJJRCl3dA515dRcNasImpu4qKe2llXTjol06kY1hmlCVzFhp0r0Ap2bYwl2WWIVtwWmr
 IfhyyMSE6wY/OFal8PcD3A+djadtavx/+ru7XX8r8p3YlQQL5hAMh9ZDewhI+1vk1rSdxuD3xi
 p8XHrk9G/428uQ7q5SWJRZ5WVoglNaTsQbV4KOfuJ6NGBpKFk9lmzoaEfphVM5qryBAIqcN/2a
 kQNkRph4h2hi5/vYDL3EkOisBAAA=
X-Change-ID: 20251011-staging-ad4062-20d897d33ab6
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763975888; l=5706;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=4P/RqBEcX19v2SQ2Hadch135990cWmTU6gATYHLDJC0=;
 b=rnAJHgBrwE8xSR5cAgbkwfI228mIG27A8rBWWvrmaZdH174QHViGUaMvPYUA5IHvTCD6rIDmk
 q2L2UivMW88AQa6G82qcjcSYDUC5NGpLBOWHm5GN8giJdn/vF2WE9lz
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDA4MSBTYWx0ZWRfX1dK+KLnGiGqu
 JkK+1uuyb+Egto4c/TB+4pWnTx2A23U70o+vjLzetwtVkSNuRGzrYlgH4JOJwjc/8BOPi0wyKs0
 Nh11njj5xFl0hyJTs11AHb5gYDQvikWE/cDmTCFov19J9o9rmGO+NVtF6v5CzqVMH3ZRYAfNVP3
 2UHu8PdhPUzzNTsVg1+p4Qj9ujbGFlgJsbdd2BfBeAcJZ2t5B+M9W8+RaVfrpfg7/SnfxOyTMZV
 L8mxkiA4rkTha3jFj/Y5G7Cn4h49zPWwExvPfq/mUt3CrOYncc6YOodTZgujft7xeYS6br9st5/
 jSiWfskA8qltTupFH/hNeTs9RaM6+UPZzESJd71lkj5+N7DPvNSHFGYbB58vGxVRyBj13i9+jEO
 4KsuYQssd3YkAlXk2vEcUEPFdRDtPw==
X-Authority-Analysis: v=2.4 cv=EqrfbCcA c=1 sm=1 tr=0 ts=692422e8 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=wI1k2SEZAAAA:8 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8
 a=Jnkzt8pN31_VuvyRtUoA:9 a=QEXdDO2ut3YA:10 a=6HWbV-4b7c7AdzY24d_u:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: n_1HD_ulEfCbf33DWV0A4y1fkvPtGTEL
X-Proofpoint-GUID: n_1HD_ulEfCbf33DWV0A4y1fkvPtGTEL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_03,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240081

The AD4060/AD4062 are versatile, 16-bit/12-bit, successive approximation
register (SAR) analog-to-digital converter (ADC).

The device uses a 2-wire I3C interface. The device simplifies acquisition
by providing 4-bytes in the register map, signal-extending the sample
reading accordingly.

The device has autonomous monitoring capabilities, that are exposed as
IIO events. Since register access requires leaving the monitoring state
and returning, any device access exits monitoring mode, disabling the
IIO event.

The device contains two optional outputs:

- gp0: ADC conversion ready signal on the falling edge.
       The user should either invert the signal or set the IRQ as falling edge.
- gp1: Threshold either event interrupt on the rising edge.

The devices utilizes PM to enter the low power mode.

The devices datasheet:
https://www.analog.com/media/en/technical-documentation/data-sheets/ad4060.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/ad4062.pdf

The monitoring capabilities, I3C protocol, and multiple GPIOs were the
decision factor to have a standalone driver for this device family. The
device is expected to work with any I3C Bus. I tested the device with
with off-the-shelf I3C controllers STM32H7 (baremetal only) and the
open-source ADI I3C Controller (with Linux driver):
https://analogdevicesinc.github.io/hdl/library/i3c_controller/index.html
ADI I3C Controller lore:
https://lore.kernel.org/linux-i3c/175788312841.382502.16653824321627644225.b4-ty@bootlin.com/

The series is divided in 3 blocks, adding:
- The base driver.
- An software IIO trigger: captures samples continuously.
- IIO events support: exposes the device's threshold monitoring
  capability.

The device internal clock register is exposed twice, as
sampling_frequency and events/sampling_frequency, storing in distinct 
state variables, since the usage (burst averaging mode and monitor mode)
cannot be executed at the same time.

Non-implemented features:

- Averaging mode: Similar to burst averaging mode used in the
  oversampling, but requiring a sequence of CNV triggers for each
  conversion.
- Trigger mode: Similar to monitor mode used in the monitoring mode, but
  exits to configuration mode on event.

This device is almost identical to AD4052 family, but I decided to
submit the AD4062 before re-submitting AD4052 to better contextualize
the focus of the device family (high latency, medium-speed protocol,
low-power autonomous monitoring rather than high-throughput
acquisition).

Depending on the resolution of this driver, the AD4052 family may be
added to it, by splitting into ad4062_i3c.c, ad4062_spi.c,
ad4062_core.c, or as a standalone driver ad4052.c.

Depends on:
https://lore.kernel.org/linux-i3c/aRYLc%2F+KAD13g7T7@lizhi-Precision-Tower-5810/T/#t
(for devm ibi clean-up)

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
Changes in v2:
- dt-bindings:
  * add a short description of all mode that can be configured to during
    runtime.
  * add gpio-controller, to expose GPs not listed in interrupt-names as
    a GPO.
- sampling_frequency is the duration of a single sample (convert-start
  high edge until RDY falling edge) ((n_avg - 1) / fosc + tconv)
- Remove .grade from chip_info, since the supported devices have a
  single speed grade.
- Update state buffer to use dma-aligned union of __be32, __be16, u8 bytes[4].
- Use standard IIO_CHAN_INFO_SAMP_FREQ and _AVAIL
- Add defines to magic numbers.
- Ensure commits only contain code related to the particular commit.
- Use new ACQUIRE pm macros.
- Drop lock for debugfs, let user mess the state thorugh the debug
  interface.
- Restructure vio, vdd, ref voltages, only read if needed.
- Have error handling on top.
- Drop unnecessary check_ids error message.
- Use devm for IBI remove (requires patch on i3c subystem).
- Use heap buffers for all i3c_priv_xfer.
- Use CONV_READ if GP1 is routed (less overhead), use CONV_TRIGGER for
  IBI fallback.
- Drop usage pm_runtime_mark_last_busy, since it is now internal to pm_runtime_put_autosuspend
- Don't allow access if monitor mode is enabled, return -EBUSY.
- Implement gpio-controller to expose GPs not listed in interrupt-names
  as a GPO.
- Value in mv as ``raw * _scale`` (embed caliscale).
- Link to v1: https://lore.kernel.org/r/20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com

---
Jorge Marques (9):
      dt-bindings: iio: adc: Add adi,ad4062
      docs: iio: New docs for ad4062 driver
      iio: adc: Add support for ad4062
      docs: iio: ad4062: Add IIO Trigger support
      iio: adc: ad4062: Add IIO Trigger support
      docs: iio: ad4062: Add IIO Events support
      iio: adc: ad4062: Add IIO Events support
      docs: iio: ad4062: Add GPIO Controller support
      iio: adc: ad4062: Add GPIO Controller support

 .../devicetree/bindings/iio/adc/adi,ad4062.yaml    |  123 ++
 Documentation/iio/ad4062.rst                       |  154 ++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |    8 +
 drivers/iio/adc/Kconfig                            |   13 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad4062.c                           | 1531 ++++++++++++++++++++
 7 files changed, 1831 insertions(+)
---
base-commit: f9e05791642810a0cf6237d39fafd6fec5e0b4bb
change-id: 20251011-staging-ad4062-20d897d33ab6
prerequisite-change-id: 20251112-ibi-unsafe-48f343e178b8:v1
prerequisite-patch-id: 5f04cbbca0fcc3657c7a4d254656b03e289ad222

Best regards,
-- 
Jorge Marques <jorge.marques@analog.com>


