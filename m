Return-Path: <linux-iio+bounces-27135-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E79B6CC78B3
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 13:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BF73305B93F
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 12:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7794633FE35;
	Wed, 17 Dec 2025 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dLARWTq4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F7B33F393;
	Wed, 17 Dec 2025 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765973659; cv=none; b=HHNQQlKBTy6ZtazfkinrNmDd5iR0DowiQrZ4DpTEleRqlh0aatMgvjt/WnFB28MzFPiMrzdxrU2paKNmAbF4arImTIj1pHezC8P6k2n3o5oiwiyseG27NePODug7WWKhgiy4XjaUPxvZIGV4e5vS0yGehcl2ORTH0cHreVHaqMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765973659; c=relaxed/simple;
	bh=3xXovRQ/1ylp7buP09ZMaPp6n5XXl7n0zDhd/YnPNvQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=QGoulNfj3/+oSV3A/GuX5tQq69/1kbjo0AD5GwvAX1egFBAi2A6dG+OrsyEAOhhfti0dXrR0/ZWG6d0LEqnJypdLB7e0jdd99O3GMcUtDB3uNUq3R1haqg/mIVaEozqyBrNECEkK3ogwve+/n9r7/Eo8FCXGE4c1hJcg6e5On2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dLARWTq4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHC7Tww3978997;
	Wed, 17 Dec 2025 07:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=vbES2cAArBda0zrgo+2QaEFlawF
	LdgzMoGzKMM3jEeQ=; b=dLARWTq4UK5DsAiP3f8nsxAy013TcB9qO5UQKrauoBJ
	AIykIWYb3am1b1fUqnhFQaiJPEUNzDp4pyOCS4E1XY3TO5OOFtUWY4lS08Umxhz2
	/FTPNqO0ITq4nh/EDKY+xgrdmi5o6LsNr3By3SDg1887WfPgrdpjqOXye9ZJCz/v
	g3++0VEsznt3iGojAG3xDMALt1jjht5qp2XOmR+Jl79zvoVvqut++24KQghKa7Vq
	xfgmsBYz+GUp4znUTYNN1P5t7wr0RLarmSNt1HbPkdFlToiIjTMwBg96YxImz9Hz
	QBm4hr2HZcyGbVnBUU4TEqm85yGLWpNeXqBluc60opA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4b3bbevk59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 07:13:46 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5BHCDjdJ041070
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Dec 2025 07:13:45 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 17 Dec
 2025 07:13:45 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 17 Dec 2025 07:13:44 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5BHCDUv6014815;
	Wed, 17 Dec 2025 07:13:32 -0500
From: Jorge Marques <jorge.marques@analog.com>
Subject: [PATCH v4 0/9] Add support for AD4062 device family
Date: Wed, 17 Dec 2025 13:13:23 +0100
Message-ID: <20251217-staging-ad4062-v4-0-7890a2951a8f@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGSeQmkC/2WRy07DMBBFfyXyFoz8tpNVvwBVUDYgFrYzTi21C
 dhpClT9d9wWVEGW19I5nrlzQBlShIya6oASTDHHoS9B3FbIr23fAY5tyYgRJimhFOfRdrHvsG0
 FUQwz0ppat5xbp1CB3hKE+HEWvryWvI55HNLn2T/R0+uviv9XTRQTTILxoAMESfzC9nYzdHd+2
 KKTa2JXnjIx41nhLddSkdoG5/SM51eeETnjeeGNVpRLGWqv1B/+eFkuwfuulDReNrx21FSXsSj
 D0UW867MNgIUJXHCg2jjTlPWLw9kMuBi3cWyqUAORuqZKMEOJJT4oxkubdbChVQG8BOKEcydwC
 znbn7/sA9zfLOXT86p/pKv9frGJX+uIlwn8+YJ4NewhYVmkZfLjN4SLU9jmAQAA
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
        <linux-gpio@vger.kernel.org>, Jorge Marques <jorge.marques@analog.com>,
        Linus
 Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765973610; l=9702;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=3xXovRQ/1ylp7buP09ZMaPp6n5XXl7n0zDhd/YnPNvQ=;
 b=sv+DxD0//soL3j8+OqPpFICAJdfB/ZQ5VOqahSCVfs6oDqh1cbpRYAlsH9LRe6xKkqCuEuN8u
 7gf7gONrRCOBBRCCqnqw6EHqxW9vxcDcKIFkCcZAnFNgTFFH4B3+V5K
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: apS4_mqk3Rz6uDPCT2LBdk1kRIo38dbM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA5NSBTYWx0ZWRfX+s3FjL2v6ku/
 QryK1TZ63/Yh3yvhH7K5QXOBfM4OPd871Vp2/0w09vBTADasGiyQF6yXMoTglDAejVlEbu0JXjS
 ZbsPjsm4vw15p1IG5FOVy7Uzp3NrjR26VyxMBNTCJWkAxc/nMRm9pfOQtPtKH82GOZ4YLI/JOim
 M8F8z3ioyTKZH2JChga22Is7Ow7kx3oVPDQT+ffr7WtQGDAn0PTvfz6ztdJRI16X8hdXgPHBlLr
 nZ3iBQpmXckgKNdw/RPG+xxMe6MXSzQvxp8NWNqvU3wpLsxzFtXzPqixP8aYNglnbRPZkmaRUBW
 Cjgo9qJjYBGIPiDEtOAdjmW/pAPrE1XZMaNuNca6sYGm0j/mh+IGywMFqB8a2749CIPQREf2LUw
 UNVYQeXdPW2Gtow0UJne/6oKr5quSA==
X-Authority-Analysis: v=2.4 cv=YqsChoYX c=1 sm=1 tr=0 ts=69429e7b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=wI1k2SEZAAAA:8 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8
 a=cvPtK7EBaPg4IFj9mP0A:9 a=QEXdDO2ut3YA:10 a=6HWbV-4b7c7AdzY24d_u:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: apS4_mqk3Rz6uDPCT2LBdk1kRIo38dbM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170095

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
Changes in v4:
- dt-bindings:
  * Simplification of interrupts description
  * Add minItems to interrupt-names, now symmetrical to interrupts.
- docs/ad4052.rst:
  * Drop "Unimplemented features" list (normally forgotten in the long term).
- Move scan_type implementation to iio trigger commit.
- Move #include sysfs.h to iio event commit (used by events/sampling_frequency)
- Fix avg_max type (u8 -> u16) to fit all variants.
- Assert val2 != 0, -EINVAL at oversampling_ratio, store bit position
  instead of resolved value
- Use u32 instead of u64 arithmetics on all possible locations.
- Fix regression at ad4062_get_sampling_frequency missing IIO_VAL_INT return.
- Use be*_to_cpu/cpu_to_be* instead of get/put_unaligned_u*
- Use devm_add_action for IBI
- Refactor methods to use _dispatch methods to, for future usage with
  "ACQUIRE for claim direct mode".
- Fix regression on GPIO configuration, introduced by misuse of masks.
- Simplify calibscale by using IIO_VAL_FRACTIONAL_LOG2.
- Simplify read_chan_raw by using "un-optimized" option for sample
  read, to not depend on scan_type (triggered buffer uses the optimized
  version).
- Fix non-compile constant ad4060_chip_info.prod_id at i3c_device_id by
  using defines AD406*_PROD_ID (kernel ci caught).
- Fix scan-type realbits/storagebits.
- Introduce st->conv_sizeof, st->conv_addr for the optimize triggered
  buffer readings (lest protocol overhead). Adds intuitive
  ad4062_sizeof_storagebits() and ad4062_get_conv_addr() helpers for the
  changing scan_type (due to oversampling).
- Use iio_push_to_buffers_with_ts
- Review chan_scale, add clearer units and move "signed" comment to the
  vref_uV multiplication, as in the datasheet (result is unchanged).
- Use devm for trigger_work.
- Use clearer fieldbit-dependent expression like
  `val != sign_extend32(val, AD4062_LIMIT_BITS - 1)` instead of magic numbers
  `val > 2047 || val < -2048`
- Fix regression on range for threshold value.
- Fix regression on enter MONITOR_MODE by adding missing address point
  write
- Note: false checkpatch positive at "iio: adc: ad4062: Add IIO Trigger
  support" due to macro change adding "bits", used by the ext_scan_type.
- Link to v3: https://lore.kernel.org/r/20251205-staging-ad4062-v3-0-8761355f9c66@analog.com

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

 .../devicetree/bindings/iio/adc/adi,ad4062.yaml    |  120 ++
 Documentation/iio/ad4062.rst                       |  148 ++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |    8 +
 drivers/iio/adc/Kconfig                            |   13 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad4062.c                           | 1609 ++++++++++++++++++++
 7 files changed, 1900 insertions(+)
---
base-commit: f9e05791642810a0cf6237d39fafd6fec5e0b4bb
change-id: 20251011-staging-ad4062-20d897d33ab6
prerequisite-change-id: 20251112-ibi-unsafe-48f343e178b8:v1
prerequisite-patch-id: 5f04cbbca0fcc3657c7a4d254656b03e289ad222
prerequisite-message-id: aReN+P5UZTnS1Tww@lizhi-Precision-Tower-5810

Best regards,
-- 
Jorge Marques <jorge.marques@analog.com>


