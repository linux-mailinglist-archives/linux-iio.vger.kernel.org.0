Return-Path: <linux-iio+bounces-17991-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CA3A86B25
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 07:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0C64627E2
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 05:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1E718F2EF;
	Sat, 12 Apr 2025 05:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DcOQSaqU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D117217BED0;
	Sat, 12 Apr 2025 05:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744437519; cv=none; b=NFnjhOoeSc0uLICDdfPolNeiAJpq7I4G0xh32yMRNuZ/eY0LvNslYkD4jlgj8EEyQT3XBZ6IJ9pVtxTBb5gmWv1YMtHDzrpcX/1oi+2/hXy1mOCtRmK6b2mserUfyAtKNDrTlO23CeZunsW9pgzuAiEvebTXzvsqvTRsp9KrH98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744437519; c=relaxed/simple;
	bh=kEclPaW8ZXhx5Z3H4yPfXzZx+JT31fc81HgL7FhCS0s=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=G8YymxKUzri/FBgszcZ8qenrJF91OeFCrf1uuEy/1CNRchaf6cxU4QSkLnIHAZ0jiRz/NIsejA6gmbA9s7+AwYG0yLOzHykY1N7tjswLxtPVVgd38JhefjaXi5jQk398c7DOGohc/K01ph0rcFmji4jRzKSgGBxBHgIWx94+l/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DcOQSaqU; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53C5QA8w006939;
	Sat, 12 Apr 2025 01:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=iV8cNTP7PVRNw4O5nSu63TVly+B
	piRjgPXbUtnIzOPo=; b=DcOQSaqUhwAZ9kQ+2Sjqpm65wqnJtLn9wL7R2Obq68U
	UZjavn6DFYM6WHk+a8uOMSkPp56UCF/gxYTVeDMPF/Qa/q1OQ2RTK0Vc4l/iqRRi
	PSGEpTih4w49I7UHg4383WYTsqqlhXgY5Z5N54Sx0FiDqL5NFXN+3nhqIknySPTX
	uSwyuyDWeqdICodYwL/j1frHaibOpF3vx09K5yOhDyZtWONSG2I3exND6IqvQ4UX
	ytK2vGTvOcbIfrB/ue80z89kMAWPT5Xu2YQcGqXD6+4cOobaMxHiDpBazxMjO0Hw
	H48/AH7ieNlkOKxA65BvXc09iAXQIqOY6DEUmvfYa8w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45yj178390-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Apr 2025 01:58:12 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53C5wBUK064375
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 12 Apr 2025 01:58:11 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Sat, 12 Apr
 2025 01:58:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sat, 12 Apr 2025 01:58:11 -0400
Received: from analog.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.18.50])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53C5vswU023609;
	Sat, 12 Apr 2025 01:57:58 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v4 0/3] Add driver for AD3530R and AD3531R DACs
Date: Sat, 12 Apr 2025 13:57:29 +0800
Message-ID: <20250412-togreg-v4-0-cb9e5309b99d@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMkA+mcC/2XNTQ7CIBCG4asY1mJgoLV15T2Mi5G/kmgx0BBN0
 7tLu6iaLr8Jz8tIkoneJHLajSSa7JMPfRlyvyOqw94Z6nXZBBhUTPCWDsFF46hVNTK0bc2NJuX
 xMxrrX0voci2782kI8b10M5+vm0TmlFHdgJRYMbCgztjjPbiDCg8yNzL8OJCrg+IscK6PDW9Bm
 I0TXyeZWJ2Y/5M3VqNEW2H756Zp+gBCNpTQDQEAAA==
X-Change-ID: 20250319-togreg-fc6a0af961ed
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Kim Seer Paller <kimseer.paller@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744437475; l=3150;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=kEclPaW8ZXhx5Z3H4yPfXzZx+JT31fc81HgL7FhCS0s=;
 b=RLtv7VlmCe2hlaqalSMh9NsRu2gBek4a9V/dqAHZYmeAV9jWMvbQuCUMITGQtvzHLUNvEXEcR
 Jm4xBYFjDzcA0tJE7spwnvI2tyJDBFbGPRX8WK4b2xUc4LL+xi646vn
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=UIPdHDfy c=1 sm=1 tr=0 ts=67fa00f4 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=0-fQSIx2x2jmDMUy4EgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: yqTzYeoJv7doCyyPhR45hdeBjiff5BmU
X-Proofpoint-ORIG-GUID: yqTzYeoJv7doCyyPhR45hdeBjiff5BmU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-12_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1011 suspectscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504120042

The AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel) are
low-power, 16-bit, buffered voltage output DACs with software-
programmable gain controls, providing full-scale output spans of 2.5V or
5V for reference voltages of 2.5V. These devices operate from a single
2.7V to 5.5V supply and are guaranteed monotonic by design. The "R"
variants include a 2.5V, 5ppm/°C internal reference, which is disabled
by default.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
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
 drivers/iio/dac/ad3530r.c                          | 506 +++++++++++++++++++++
 6 files changed, 628 insertions(+)
---
base-commit: 8dbeb413806f9f810d97d25284f585b201aa3bdc
change-id: 20250319-togreg-fc6a0af961ed

Best regards,
-- 
Kim Seer Paller <kimseer.paller@analog.com>


