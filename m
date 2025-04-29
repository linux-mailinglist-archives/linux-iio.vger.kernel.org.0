Return-Path: <linux-iio+bounces-18805-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CE3A9FFAE
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 04:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7213B4CE6
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 02:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FFF29C35F;
	Tue, 29 Apr 2025 02:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZhjLdD5w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A771C29C33B;
	Tue, 29 Apr 2025 02:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745893222; cv=none; b=YGEJ7fmz6SyiqbuMMXRC9a4ZdSYn7KpgLJd4dq6LXjvuyCqG9OGOWPyKEbc3WXUdcW6MT7i+JudXtnU+n+IdjgulONbnSElCvr544OYBB5B6S85obDpIRDctmE60i0dIFDnyPpL2Ni4sHDJJEg/MW9y+RgcUwsYBApGvKW5ij4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745893222; c=relaxed/simple;
	bh=Y6HP5BqKB+1woZEbS7r0XI5tKR9giwUkyw8pLirIh7I=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=eCelqTURY6u3MuOhSyPaEoimN9r8r+BUPHTWrJ8t1aQ0EcKhhgeeVigepy9Sl7BH0toI+qDZYX75Nc2SMVPG3Ex2opEYijAs0mjrtRivsfZ4FJA85PXJGikWoT8pTiXRBgZ+jjnZVDjScBtax4wrJOwuyYLbON4BQRN/yaqutS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZhjLdD5w; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SKGlR1011175;
	Mon, 28 Apr 2025 22:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=a/UiBTcM9nZ2vMyGMH0D31TITYa
	Rx/jamTfakDoNjv8=; b=ZhjLdD5wM2HJWhPZeCAd58VvcPIpxWrKace4ROQ1HIj
	LQsW7D0MdPWP3juQBIXP5qdnFbbXc0dk5ETyNoZLIg/daa9+bnun7OYZuq2oST3O
	oCZ38dhcgKrfbUycwMQFx5yO97LPdLIMk2JbtbKBV7KoRY4pqMYXaYhr6H7pxPST
	1gDpsMRWKut8tfENCx+JZA1VeKdyw7hw+baUK0IYAECi7KZLl4kWI8zZe5RDwxNp
	V1pHXH3CQ+rh2p+sQemxgfvJ/ZH7gytpH54Y1ldksxHGyXhqyw6vLxwLVSQW8IY9
	LiruaCKma71YYFog3g1f9BsywCqxBlgID25Ln4mzDUQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 468vd71078-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 22:19:48 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53T2Jl2J051532
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Apr 2025 22:19:47 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 28 Apr 2025 22:19:47 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 28 Apr 2025 22:19:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 28 Apr 2025 22:19:47 -0400
Received: from LRADU-D01.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.18.50])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53T2JPCs007738;
	Mon, 28 Apr 2025 22:19:29 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v7 0/3] Add driver for AD3530R and AD3531R DACs
Date: Tue, 29 Apr 2025 10:19:15 +0800
Message-ID: <20250429-togreg-v7-0-0af9c543b545@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACM3EGgC/2XNzU7EIBSG4VuZsBbDORyguPI+jAvKT4dEW0Mnj
 WbSe5fOAmtYfic8L3e2xpLjyl4ud1bilte8zHWYpwvzVzdPkedQN0OBSkiw/LZMJU48ee2ES1Z
 DDKw+/iox5e9H6O297mteb0v5eXQ3OK5dYgMueBiQyCmBCf2rm93HMj375ZMdjQ1PDqk5rC4hQ
 DADWJSxc/LPkZDNyeM/GoV25JJytnN0coDNUXV+tFFJYUdrQ+fUySE0p6qzJAmUISSROqfPTjW
 nqyMz6mQHM7io/rl9338BmfHurrUBAAA=
X-Change-ID: 20250319-togreg-fc6a0af961ed
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Kim Seer Paller <kimseer.paller@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745893165; l=4791;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=Y6HP5BqKB+1woZEbS7r0XI5tKR9giwUkyw8pLirIh7I=;
 b=UR2yCsCXUuaPOAbs/3xsajpAGD4I+9uchlt3Ih6xO2TQQrv229Y+hqhLHfAghgIBdJuMh+MqI
 mg2gWR6kbfuDR/aurPY/6vXf6xYkdPHa4HVZ4MhWRPsLn/kDuAdP6ac
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ORDUMKJVwdUax_7GIyBaJczyP_EVpnX9
X-Authority-Analysis: v=2.4 cv=b+Wy4sGx c=1 sm=1 tr=0 ts=68103744 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=ZmZyb2ABJOtKvUGprvYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDAxNiBTYWx0ZWRfX/VFClq0Q02Ly R1qYuI19s8WLa2wsGECA2iRwit/q5WHx0Rz15cUbnAhc9hX9U1XyGeK/9UumVLDbDqrcQdK8HSC 44Yp6OnTaydNhENabwtCp4KXlRLR/VzPrNKV3L8FMrnEgkgJaK8UZM89eWO633Y9S6uDoXbUHTh
 5GvWhdNCuKy6WRJW2uovaKAE7FUIf+yORpP00gDmYlFM37ZQJiP9jorrWLlEUQZVmkWY+gKeyUi DiVqRhawd/rbu87V8f6RIaz3O+RvFLuomIzf6Be76ueJYnBz98ExgOuxASaDpLTu/UcIB3Nams0 6UVZtJ45H91LHSJh8O9NuWyZ+BTcKWch9kIak+1nhXukfBryZF4Oz2aKIuAK+0LQTvkGaelsvXA
 32cPtv/217FZjjvW3QSxF4cZeA9led9Hgco/fpBNrOG8yMJRXrDI/N1M9VHKfUYCgP+bjKkM
X-Proofpoint-ORIG-GUID: ORDUMKJVwdUax_7GIyBaJczyP_EVpnX9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504290016

The AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel) are
low-power, 16-bit, buffered voltage output DACs with software-
programmable gain controls, providing full-scale output spans of 2.5V or
5V for reference voltages of 2.5V. These devices operate from a single
2.7V to 5.5V supply and are guaranteed monotonic by design. The "R"
variants include a 2.5V, 5ppm/°C internal reference, which is disabled
by default.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
Changes in v7:
- Add non-constant mask variant of FIELD_PREP() for powerdown dynamic
  bitfield operation.
- Rename vref to external_vref_uV and simplified validation logic by
  removing redundant checks.
- Add reviewer's tag.

- Link to v6: https://lore.kernel.org/r/20250425-togreg-v6-0-47b6f9878ae5@analog.com

Changes in v6:
ad3530r:
- Drop reviewer's tag, a re-review might be required due to changes.
- Add includes: dev_printk.h, array_size.h, sysfs.h, kstrtox.h, types.h,
  and err.h.
- Add AD3530R_OP_MODE_CHAN_MSK() macro to drop using chan->address.
- Update logic to explicitly set operating modes for all 4 fields of the
  register.
- Update naming to use _mV for proper spelling.
- Assign pdmode separately before shifting for powerdown.
- Replace U16_MAX with a hardware-defined limit using GENMASK().
- Replace hardcoded delays with USEC_PER_MSEC.
- Update `vref / 1000` to use MILLI.
- Simplify logic of setting vref to 0 when it's -ENODEV and directly
  check the value, removing the need for an additional boolean variable.

- Link to v5: https://lore.kernel.org/r/20250421-togreg-v5-0-94341574240f@analog.com

Changes in v5:
ad3530r:
- Replace return value to -ENODEV if no external and internal reference
  found.
- Replace device_property_present() with device_property_read_bool() for
  flag handling.
- Simplify vref_mv calculation by using range_multiplier directly.
- Change ldac GPIO initial state as it is toggled high to low later.
- Drop linux/kernel.h include.
- Add reviewer's tag.

- Link to v4: https://lore.kernel.org/r/20250412-togreg-v4-0-cb9e5309b99d@analog.com

Changes in v4:
Bindings:
- Add ad3531/ad3531r datasheet link.
- Add reviewer's tag.

ad3530r:
- Add commit description for unimplemented MUXOUT ADC monitoring feature.
- Use a DMA-safe buffer for bulk register read/write.
- Inline the AD3530R_CHAN_EXT_INFO macro for the "powerdown" attribute
  since it is only used once.
- Use enum ad3530r_mode for powerdown_mode.
- Refactor ad3530r_set_dac_powerdown() use chan->address for bitmask
  calculations and add helper variables.
- Simplify single-bit configuration with regmap_set_bits().
- Add .max_register for regmap_config.
- Rework regulator handling and move ad3530r_setup() after enabling the
  regulators.

- Link to v3: https://lore.kernel.org/r/20250403-togreg-v3-0-d4b06a4af5a9@analog.com

Changes in v3:
- Drop ABI docs.

Bindings:
- Drop reviewer's tag.
- Update commit message.
- Add non-r variants to compatible list.
- Add io-channels property to enable ADC channel support for MUXOUT
  readings.
- Switch to unevaluatedProperties: false.

ad3530r:
- Update commit message.
- Drop spi field from ad3530r_state and use regmap to retrieve the device
  pointer.
- Update mutex lock comment and use devm_mutex_init().
- Fix LDAC gpio pulse logic.
- Replace usleep_range() with fsleep().
- Use sizeof(reg_val) instead of hardcoded value in regmap_bulk_read.
- Drop reporting of zero offset.
- Add internal_ref_support chip_info parameter and modify reference
  handling.

- Link to v2: https://lore.kernel.org/r/20250324-togreg-v2-0-f211d781923e@analog.com

Changes in v2:
Bindings:
- Updated commit message.
- Changed adi,double-output-range to adi,range-double property.

ad3530r:
- Changed data type to __be16 to resolve sparse warnings related to
  type mismatches.

- Link to v1: https://lore.kernel.org/r/20250319-togreg-v1-0-d8244a502f2c@analog.com

---
Kim Seer Paller (3):
      iio: ABI: add new DAC powerdown mode
      dt-bindings: iio: dac: Add adi,ad3530r.yaml
      iio: dac: ad3530r: Add driver for AD3530R and AD3531R

 Documentation/ABI/testing/sysfs-bus-iio            |   2 +
 .../devicetree/bindings/iio/dac/adi,ad3530r.yaml   | 100 ++++
 MAINTAINERS                                        |   8 +
 drivers/iio/dac/Kconfig                            |  11 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ad3530r.c                          | 517 +++++++++++++++++++++
 6 files changed, 639 insertions(+)
---
base-commit: b475195fecc79a1a6e7fb0846aaaab0a1a4cb2e6
change-id: 20250319-togreg-fc6a0af961ed

Best regards,
-- 
Kim Seer Paller <kimseer.paller@analog.com>


