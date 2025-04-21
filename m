Return-Path: <linux-iio+bounces-18396-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8F6A94BEB
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 06:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8375516F00B
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 04:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BE52580FF;
	Mon, 21 Apr 2025 04:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="v31VfI71"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBD525743B;
	Mon, 21 Apr 2025 04:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745209555; cv=none; b=InUXIor/wbkr5BPX/6qKnkrN3q+bxTLJOVXoZ0u81kRFL7G5cwti3OQwKx5YQaIDzKSmLNZ/5b3Znebn6jOlt5s4EO08uLIiSESldQnvzGUtLVdP8Ss74YI36SYrEFtbktDqA2YeX/PzeRFyGZyPjHIeH09uMcJzc9lVPinuVX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745209555; c=relaxed/simple;
	bh=iWgb8wZWF6fJFTaZSiDHOqf0RPTkaQ269SUJypjUugo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=rr09/8Kf4b9b+8KSz/K+Ll3JDQuOciHPnTfQnMpvJwPSK/OtHefWQFiiJlug3Py5QZl4WfVZFbfIU0Zn6mt0xE/6OAVwCLR81UAaZmS6ir7exzPr19f2ycszVTkkzkpNQ5MUts2hWtfevc7RWAZ78jFBOnllbCAZnFGO7T5iJkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=v31VfI71; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53L27vsM026282;
	Mon, 21 Apr 2025 00:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=dhSCafYceyKK8n9dBAa90yDQKhV
	Cpt7a7pQoSUHZ5q4=; b=v31VfI71+unOh69FUbylL8joX0bPpz8OlyIkgnBN3Gf
	aCJbgoAEYz1fo7o21jzb304jpvGfFo6xh/H4ttzGjr5sLLs0FKBKM+gMh5XfwECb
	4682sfcC+R6PpWBVqS8eyFzLXf4hM1xKRxPyRhHRQcKIS40c1sGFv1fEtQK46SmA
	+a8PuNKjfj/bhVFwGOVXSltx8tLvcRhmEFwubuuSa5X5ODxF6/gjhNQFiWPanEKG
	ErE2ZwN1Tjwy/1c3rHQFgPi9sZaxBbb0FWpN9xCGc86Bpm7LNtYvs++enIPDUiI9
	5JQrfLud+e8uhfJV94seJy/iJoHJxntxUwM9VrllUMQ==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4648r663w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 00:25:22 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53L4PLkh006775
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 21 Apr 2025 00:25:21 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 21 Apr 2025 00:25:21 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 21 Apr 2025 00:25:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 21 Apr 2025 00:25:20 -0400
Received: from analog.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.18.50])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53L4P3of002018;
	Mon, 21 Apr 2025 00:25:06 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v5 0/3] Add driver for AD3530R and AD3531R DACs
Date: Mon, 21 Apr 2025 12:24:51 +0800
Message-ID: <20250421-togreg-v5-0-94341574240f@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJPIBWgC/2XNQQ7CIBCF4asY1mJggCquvIdxMYWhkmgx1DQa0
 7tLu6g1Xb4J38+HdZQjdey4+bBMfexiassw2w1zV2wb4tGXzUCAEUpa/kxNpoYHV6HAYCtJnpX
 Hj0whvqbQ+VL2NXbPlN9Tt5fjdZXoJRfcH0BrNAICuBO2eEvNzqU7Gxs9LBzo2UFxAaT0+4O0o
 Gjl1M9poWanxv90LSrUGAzaldMLJ2F2ujhXWzJK2Npa/+eGYfgCXDLJNEUBAAA=
X-Change-ID: 20250319-togreg-fc6a0af961ed
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Kim Seer Paller <kimseer.paller@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745209504; l=3634;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=iWgb8wZWF6fJFTaZSiDHOqf0RPTkaQ269SUJypjUugo=;
 b=75/qU5ZIixnNyrtGoNOMALyXV6SOFlbxAXgqPki8heAvWY0eQST3woAE1qjiR3679zkJtj89n
 OG1mKmeS/5ABs8T7OwH4csH8wgjAxeiswvlIdlNb8qqaxd4q/dhJNIi
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: HUy0xwbB8bHxta9AnCmB-4BFt30A74I-
X-Proofpoint-ORIG-GUID: HUy0xwbB8bHxta9AnCmB-4BFt30A74I-
X-Authority-Analysis: v=2.4 cv=d6z1yQjE c=1 sm=1 tr=0 ts=6805c8b2 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=0-fQSIx2x2jmDMUy4EgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_02,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504210031

The AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel) are
low-power, 16-bit, buffered voltage output DACs with software-
programmable gain controls, providing full-scale output spans of 2.5V or
5V for reference voltages of 2.5V. These devices operate from a single
2.7V to 5.5V supply and are guaranteed monotonic by design. The "R"
variants include a 2.5V, 5ppm/°C internal reference, which is disabled
by default.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
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
 drivers/iio/dac/ad3530r.c                          | 503 +++++++++++++++++++++
 6 files changed, 625 insertions(+)
---
base-commit: 3159d40a2ca0ae14e69e1cae8b12f04c933d0445
change-id: 20250319-togreg-fc6a0af961ed

Best regards,
-- 
Kim Seer Paller <kimseer.paller@analog.com>


