Return-Path: <linux-iio+bounces-26799-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D62CA81F7
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 16:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56F4830540F7
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 15:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5039A34EEEE;
	Fri,  5 Dec 2025 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vM0OMKWH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB1930C61E;
	Fri,  5 Dec 2025 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947576; cv=none; b=mQo8DtLsGxjz0e1amg0PM5xopHG8X7p14NizXE4fAVlfMPM+T/b0ASBFzFsG/akNiDoPZk5ijIQrtChFj01sTeGnUImdJJw10WXiBBkD4OKL/5kWHmnC0wnNofCm8SNQAghd0Y47LLiEGD+rFQRGktdvuatS0YLKDN7S42FWD1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947576; c=relaxed/simple;
	bh=XIk76y3jSDAVXBb6uJHmtb6PMS6bAg5NLMLLxholcZ8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=nxkvraHbiFE9KItYicgjEgZmplavvcYmwThXxQ92DSKEXJm/XOEhfmrMNoiP6nz+/ZryfnNc4pSJOxgbJwifPEJgi+Wy8rZEMM3QQMTSuW0MO/IcktdJGVztIeKFBhDCHAg60iJgKhB3WgV7H/TAAHLSI1pdLEYTTAgVma3TyU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vM0OMKWH; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5ESBLJ625991;
	Fri, 5 Dec 2025 10:12:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=NZTRd3pHkC32An0N3HD7/jbcgCc
	5EUEP3OGmCsdJFU4=; b=vM0OMKWHOxiGdSMQyQr0kvsgp5d4EFbE00ePWGrIG9Y
	NsVlODJMKUz7I3KzgfWq/vEGOD7H7NUU30MhO5j8T+EZfI/jad4+MXtj2gqi9/9F
	61KQ3nNJXU1lGaJscgUJLTlADBavKCplGF66NxefaLUUWEEW7oELtLESPs9Q4s3z
	HG+q9q1bYg1cCQEI3ubcxzeOmYBB+f4t3jY+w/3rRa2k4shzEGwB+Y86GOQ2ccw1
	1CK9MdcTMEkbZueVAhgUo0z4g4pRymQemazxQO/R7vjGIJKc8E1BdQUZzdN7yVs9
	eVUt8TQhZVaFQJ+sVJkquELdQvYnrhYwKPmOhSLUIYQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4auhwwm5va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 10:12:26 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5B5FCP5d033526
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Dec 2025 10:12:25 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 5 Dec
 2025 10:12:25 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 5 Dec 2025 10:12:24 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5B5FC8SA029946;
	Fri, 5 Dec 2025 10:12:10 -0500
From: Jorge Marques <jorge.marques@analog.com>
Subject: [PATCH v3 0/9] Add support for AD4062 device family
Date: Fri, 5 Dec 2025 16:12:01 +0100
Message-ID: <20251205-staging-ad4062-v3-0-8761355f9c66@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEH2MmkC/2WQ3U7DMAxGX6XKNUHOT5O0V7wH4sJJ7S4Sa0fTV
 aBp7062Ck3A5WfpHH/2RRRaMhXRNxex0JZLnqcazFMj0gGnkWQeahYadKtAKVlWHPM0ShwsOC0
 1DKHzgzEYnajQaSHOn3fh61vNh1zWefm6+zd1m/6ozF/VpiRI4JDIM3EL6QUnfJ/H5zQfxc216
 QevtP3H68qj8a2DDjlG/4u/7uUW+jjXI9e94ePGvtm1SsscszxPBZmkDWysIeVDDH2tXx0RC8l
 qPOa1b7gjaH2nnNVBAUJip039RsfIg2NKLUG0Mdb112/UL9oYawEAAA==
X-Change-ID: 20251011-staging-ad4062-20d897d33ab6
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764947528; l=7316;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=XIk76y3jSDAVXBb6uJHmtb6PMS6bAg5NLMLLxholcZ8=;
 b=tfM4pRv8B7eNCBqXHsW0uAY9S1Uej3QZ/Wn9Q7ZjOlWlFNj6JsSKEro2jZo0pBMQ/aAuBbZiU
 hOMuMH4qqwkAj1UI/5zdhzG7aov29qcxrx8/fELpD2RDNP4ZYpTqfle
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Y531cxeN c=1 sm=1 tr=0 ts=6932f65a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=wI1k2SEZAAAA:8 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8
 a=rg3eyM4qIcSk8hNEcmQA:9 a=QEXdDO2ut3YA:10 a=6HWbV-4b7c7AdzY24d_u:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: koBSIuxhfnH6XgqvTK0BWxG-9zqxzjPm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDEwOSBTYWx0ZWRfXxhiX9peuou8E
 9AW6NUhG+u+XC72G+B2KRgN4/yQk4trFlj8z4j2LlbSeRSkR1QZDD0gIzZHNJ/0kIp3zx3mbnJ6
 5JPeswxaKKMWkrxPS94NnN1+XQwPQLpEJfrGu7eCJOG3ft+of50rzwYJHNwrOB1DDPb5SdMeA2r
 s89Pf6yF0jK8AlaunrsQ4IBHj3tm49Cm44I1OcnEgmiDMBYCq6nOIfeCFjnv76vjVyffTumlQyM
 oyxtTJ3DI3R6mRkJi6z9zhapdxfwHPXP7BP9mHeWC59CWCV0zyMM/0bSwosh6ZyHcTgtwZb73i9
 f5SywXqOxlo6lXfHtgOoWMuqmIX/spFMMgn/3m5QnhhmHxL+JerDxi2Wtq4WY1WDQo7ftpLU0Y4
 dCLkfSNp3eZTF1ec3CcSIxh+R+Euow==
X-Proofpoint-ORIG-GUID: koBSIuxhfnH6XgqvTK0BWxG-9zqxzjPm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_05,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512050109

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
Changes in v3:
- dt-bidings:
  * Add minItems to interrupt-names, to match interrupts.
  * Reword descriptions.
- Add () to methods in commit messages.
- Group defines by context, adding blanking line between.
- Change ad4062_conversion_freqs from int to unsigned int
- Rename vref_uv to vref_uV
- Re-order state struct, to save some bytes.
- At oversampling_ratio(), use in_range()
- Add formulas, units where appropriate.
- Tune reset delay (data sheet value) and sleep mode resume delay
  (experimental).
- Rework st->oversamp_ratio to store the exponent, so 0 is ratio 1 (2**0).
- Rework get_chan_calibscale() to use IIO_VAL_FRACTIONAL_LOG2,
  simplifying the logic.
- Rework set_chan_calibscale() to not use 64-bits arithmetics, and
  provide formulas, and comments.
- Merge __ad4062_read_chan_raw() into ad4062_read_chan_raw(), since was
  the only consumer.
- Optimize readings with GPO set as DATA_READY, by using CONV_READ
  register (roughly doubles the effective sample rate).
- Use new ACQUIRE macros for pm.
- Use devm wrapper for INIT_WORK, cancelling on driver removal,
  resolving exception if the duffer was enabled during removal.
- When possible, use  `return ret ?:`.
- Use IIO_DEVICE_ATTR_RW() instead of IIO_DEVICE_ATTR().
- Use AD4062_LIMIT_BITS - 1 or BIT(x) - 1 to indicate hw limit/field
  size.
- Explain in the commit message why gpio-regmap cannot be used, and
  gpio-controller is used instead.
- Return  relational operator directly (has type int).

- Link to v2: https://lore.kernel.org/r/20251124-staging-ad4062-v2-0-a375609afbb7@analog.com

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

 .../devicetree/bindings/iio/adc/adi,ad4062.yaml    |  124 ++
 Documentation/iio/ad4062.rst                       |  154 ++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |    8 +
 drivers/iio/adc/Kconfig                            |   13 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad4062.c                           | 1530 ++++++++++++++++++++
 7 files changed, 1831 insertions(+)
---
base-commit: f9e05791642810a0cf6237d39fafd6fec5e0b4bb
change-id: 20251011-staging-ad4062-20d897d33ab6
prerequisite-change-id: 20251112-ibi-unsafe-48f343e178b8:v1
prerequisite-patch-id: 5f04cbbca0fcc3657c7a4d254656b03e289ad222

Best regards,
-- 
Jorge Marques <jorge.marques@analog.com>


