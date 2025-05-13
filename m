Return-Path: <linux-iio+bounces-19485-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9DCAB54CB
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 14:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 507E0863587
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 12:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3064525F7BD;
	Tue, 13 May 2025 12:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RSh3ORIZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1931A1DF72E;
	Tue, 13 May 2025 12:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747139595; cv=none; b=W3zxV6Nk6i1UDLyKInnehcTmktlDBSR3Fbc9+nA9eA0ArR0opDIj9T1h273Y4F3CztvD8idLN5cUTIpc4oM+aTQURkW0h8cs4w12ur+djmYJcyGL80VdnfIZxpNYuYZ2jhMvGBMCeEeCTZI5dT/whoX8Hp85a3kDWSWZeh8stdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747139595; c=relaxed/simple;
	bh=b4fDO5yqSfbMqvXwlk8lm29BBkwSUn7ZEYDsDrEImsA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FgGKQlmXQZ8A/dDFR+cUJUyQwgOjvnDmoYapnqXzAXJT5OlbfRfinTM7zOeYFYaAnIgMarj3iVaDMSrxPiGH9ZX4cbEwDKgaTNr8MHIsgMfI+90IkLH+FCgCQO8bsbppk6swcpy5QW1WIxJIVNFer7c/LhB7+US9GJCecVXje2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RSh3ORIZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D9mOtF024809;
	Tue, 13 May 2025 08:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=iGjKBdn5/wXqIA9OJrR4YDR0kDs
	seWwE5E8vLT+uvek=; b=RSh3ORIZn4Qv6pe04dwUoCaT/QDhgNOywdkQBRQQD2p
	gmadlK57CdQizuOT1KZ2aXWArllVShR+iNMOC3ZXgABgFElgC4WS0gQrtupHEgms
	kzDu4HPvDu8E/2dztQs1/jObr2aGbm5E1uTuAFd/clYqATi2zF4fuy+7ZGPdCM9H
	H7sYOMRwmt1TBMGShlqzfPzybzXh/za7e2WDSxFupyWtfCLl5JgCcmXNWnvg93MG
	AIe4nd7QJIqRraFaIl6WaOWJ6g8U7OCQgCABiwoQ7sDs5YZRms3WzphM3bFAZAW5
	YjD86fH4Lsnos1goHsPYBLWII7M8oBTMjB2xbAJ3Cqg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46m3s98s7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 08:32:41 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 54DCWesC040862
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 May 2025 08:32:40 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 13 May 2025 08:32:40 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 13 May 2025 08:32:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 13 May 2025 08:32:40 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54DCWL9X007434;
	Tue, 13 May 2025 08:32:25 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 00/10] Add support for AD4170 series of ADCs
Date: Tue, 13 May 2025 09:32:20 -0300
Message-ID: <cover.1747083143.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: L_nxBtDCPU6i71WQYhc7EPXs95Kl7MOt
X-Authority-Analysis: v=2.4 cv=ZaUdNtVA c=1 sm=1 tr=0 ts=68233be9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=PUqQMfyijoDRfx14XwYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: L_nxBtDCPU6i71WQYhc7EPXs95Kl7MOt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDExNyBTYWx0ZWRfX6A0VwugECuex
 IsMB3GYEAbUJpbhSeEhn95ctH0cHtVtBY1IviUDpfHKyGxku40tpDl3fIBVPhjZWm1W1RUTDd3r
 8Ab7am3lxRCqakGVXq/zOHkuwqdW7SNI0s9IVOyVSiek/xgH1GO6H4Y9fsUv9DEMlBBmFXgB/SF
 rx0jvAdYq0IcOLVvHsWPQlt3AVsBfCmU1qV9ffAN5uaj04D/tc7QdOcgaSKdcMdRQ8w+JozubEO
 SGDRhelAt3bIf8Q3h665oKpCdlFeoFi45zTYjW0WUEtHcnn3d/BXV/4Y1UsAVp9sR/yKSBfO3xD
 QoAMIFPTEJhMrKcL1D4xw7laj7jIdRGnfZ0yNJXM2c3ICPMNNwAl8cu/R2+2SZcsQ4FOqGwaOf9
 Q67PGID2kRGlG0AH4w0quZRLk4sa9oCg2xIh5ja29s8Nu8L3/fWjCwiktx4bVCveHnCHQYkM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1011
 mlxscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130117

Hello,

Thank you to all reviewers of v1 and v2.
Hope I've been able to sort out all issues raised and incorporate all
improvement suggestions in v3. Despite splitting some parts out of the base
driver, that's still not a small patch. I understand that it may take more than
usual to receive reviews for this series. Thank you.

There is actually one thing left that I'd like to improve which is the support
for negative/bipolar voltage references. Though, that will lead to changes in
the regulator subsystem/framework which would bloat this series even more.
If possible, I'd like to do that on a separate patch set.


This patch set adds support for Analog Devices AD4170 and similar sigma-delta ADCs.

Patch 1 adds device tree documentation for the parts.
Patch 2 adds basic device support.
Patch 3 adds support for calibration scale.
Patch 4 adds support for calibration bias.
Patch 5 adds support for sample frequency along with filter type configuration.
Patch 6 adds support for buffered ADC reading.
Patch 7 adds clock provider support
Patch 8 adds GPIO controller support.
Patch 9 adds internal temperature sensor support.
Patch 10 adds support for external RTD and bridge circuit sensors.

Change log v2 -> v3

[device tree changes]
- Removed unneeded allOf.
- Removed occurences of adi,sensor-type type re-declaration.
- Created type for the AD4170 channels, allowing to avoid dt doc repetition.

[General IIO driver changes]
- Fixed issues reported by 0-DAY kernel test robot.
- Used pahole to reorder ad4170_state fields for better cache line alignment.
- Replaced all occurrences of `int i` by `unsigned int i`.
- Replaced all `if (ret < 0)` by `if (ret)` whenever appropriate.

[Basic driver patch]
- Updated Copyright year.
- Separated handling of channel setup cases for better understanding of code flow.
- Now comparing setups field by field instead of using memcmp().
- Disable channel on ad4170_read_sample() error path.
- Reinit completion before entering single conversion mode.
- Organized ad4170_sinc3_filt_fs_tbl.
- Used clamp to simplify configuration value checking.
- Returned earlier whenever possible.
- Used HZ_PER_KHZ/MHZ.
- Declared internal voltage reference constant AD4170_INT_REF_2_5V
- Many other minor code style and readability improvements.

[New patch - Add support for calibration scale/gain]
[New patch - Add support for calibration bian/offset]
[New patch - Add support for adjustable sample frequency]

[Buffered capture patch]
- Made validate_scan_mask() return false if no channel enabled (bitmap_weight() == 0).
- Use local variable device pointer to simplify trigger setup and better wrap lines.
- Tidy up buffer declaration, function returns, comments, and other minor things.
- Fixed data handling in trigger handler which I hadn't noticed to became buggy
  after xfter buffer type was changed from __be32 to u8 array.

[CLOCK provider patch]
- Applied minor changes according to v2 review.
- Avoid unmet dependencies by depending on COMMON_CLK rather than selecting that.
- Brought early external clock defines from early patches to this one.
- Picked up a review tag from v1 review that I failed to include in v2.

[GPIO controller patch]
- Defined masks for updating GPIO mode register.
- Replaced regmap_clear/set_bits() by regmap_update_bits() to set GPIO direction.
- Removed GPIO direction check before setting GPIO output values.
- Made use of regmap_assign_bits() to set GPIO output reg bits.
- Made value to be set as GPIO output state be either 0 or 1.
- No longer locking on state mutex on GPIO set since GPIO output should not
  conflict with other direct mode functionality (e.g. single-shot read).

[Internal temperature sensor patch]
- Wrapped line according to logical approach.

[External sensor patch]
- Added trailing comma to ad4170_iout_current_ua_tbl array.
- Simplified AD4170_CURRENT_SRC_REG constants with macros.
- Used temporary variable to keep logical line wrapping of vbias calculation.
- Dropped ad4170_find_table_index() after open coding both uses of that.
- Extracted pin validation to reduce indentation.
- Inverted ad4170_setup_bridge() logic to reduce indentation.
- Used GPIO register masks to convey reg write meanings in ad4170_setup_bridge().
- Reworked ad4170_setup_current_src() to make it readable.

Link to v2: https://lore.kernel.org/linux-iio/cover.1745841276.git.marcelo.schmitt@analog.com/


Change log v1 -> v2

[IIO driver changes]
- Call gpio_set() at begining of gpio_direction_output() instead of at the end of it.
- Return -EPERM if try to set a GPIO configured for input.
- Now locking on state mutex before setting output GPIO values.
- Used gpiochio init_valid_mask() to only init available GPIOs.
- Replaced 3 regmap configs by regmap with custom reg_read/write implementation.
- Improved to support more than one extarnal sensor connected.
- A few other minor improvements.

[device tree changes]
- Referenced adc.yaml from sensor-node.
- Merged property descriptions to reduce doc duplication.
- Every child node type is now in the example.
- Better described sensor-type property with a list of possible types.
- Updated adi,excitation-pins description to cover a use case I had overlooked.
- Added default to interrupt-names and to clock-names.
- Dropped '|' from descriptions when not needed.
- Added extra example

Link to v1: https://lore.kernel.org/linux-iio/cover.1744200264.git.marcelo.schmitt@analog.com/


Thanks,
Marcelo


Ana-Maria Cusco (1):
  iio: adc: Add basic support for AD4170

Marcelo Schmitt (9):
  dt-bindings: iio: adc: Add AD4170
  iio: adc: ad4170: Add support for calibration gain
  iio: adc: ad4170: Add support for calibration bias
  iio: adc: ad4170: Add digital filter and sample frequency config
    support
  iio: adc: ad4170: Add support for buffered data capture
  iio: adc: ad4170: Add clock provider support
  iio: adc: ad4170: Add GPIO controller support
  iio: adc: ad4170: Add support for internal temperature sensor
  iio: adc: ad4170: Add support for weigh scale and RTD sensors

 .../bindings/iio/adc/adi,ad4170.yaml          |  544 +++
 MAINTAINERS                                   |    8 +
 drivers/iio/adc/Kconfig                       |   16 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ad4170.c                      | 2921 +++++++++++++++++
 5 files changed, 3490 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
 create mode 100644 drivers/iio/adc/ad4170.c


base-commit: d820bea88e277acc38b011fde9a8dc9f5310a6b9
-- 
2.47.2


