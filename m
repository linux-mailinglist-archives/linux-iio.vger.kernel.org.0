Return-Path: <linux-iio+bounces-27551-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EF5D02E10
	for <lists+linux-iio@lfdr.de>; Thu, 08 Jan 2026 14:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A1F1314DECA
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jan 2026 13:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7A944B660;
	Thu,  8 Jan 2026 12:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ALiTIn9x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0223FB23A;
	Thu,  8 Jan 2026 12:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767877154; cv=none; b=tZBCL4qVOqfhbJZn7fCPnic7fwkYwrawwLWGTE4/1kZW6xIipJUCspvtQbd64TmPsj6PLrUvnELxFNi+zv/NOXZKzjb7qzAdGiAkDdg3tPL5XLmjqkVG0T0tHFe+Q+uH4hbn5QRde5FgTjT+XxX314t7ML+SM4/z0E8j/WdmnSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767877154; c=relaxed/simple;
	bh=GIGWmCOhSWxzlOF3iCBOFJmMnjV2NFQFhntQhDwwkQ4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=I7zDGAMQmZbvh0eEKcR2+XJNuPV9bCTxPwsZJaBfQicJLPG2FfDDdY7LsiiE4xnF9XG8EOvSmX8VFQ/z8ex8ZAYJPhxOs2/rJ7u46Do7bF85AXsJl9HLWTWT7dVAk71wRUrGMFWf+6t3jg6HtPhISCAClHhn25WSrlI8P+XvKpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ALiTIn9x; arc=none smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608CWaev951792;
	Thu, 8 Jan 2026 07:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=szLcsqzGtQNj3+aedKG4zimv4jM
	XzNwJbbDdLzPdjMc=; b=ALiTIn9xC1XinBPrt/RFYpC9KIcvrinZs3e35UxEX9n
	5xjRFTM15xlxfDPaFXgR5QgqCPcjPbmwAtWbXI9n9+9Q8MmFRRhuJ2Nd3skE9+XR
	Gy6Z4qf+GK1oIAaOPK/CyLffg0LYZw/ija38b6ycVw1P9NX4i57FFKrUiGOVnDgq
	f4jZ23Jr1cqTvz5XmV0ps0oWTZuQz+GqGU3RkLNPfgwh+NWEvxkMC1bouFkQ8Yvn
	tLAl6Lqe8Rw5qxoAgRp+Ih4YWDnSg21JNwbu7SdEGwSVN92yc9koDViEvTDpjKVx
	5H+MGkvyzjeVL+wC6gMXb0pBFsbLFoLo6XW/7oA3h5Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4bj7pm9nkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 07:58:43 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 608CwgRG033905
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Jan 2026 07:58:42 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 8 Jan
 2026 07:58:41 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 8 Jan 2026 07:58:41 -0500
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.88])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 608CwSiD012447;
	Thu, 8 Jan 2026 07:58:31 -0500
From: Janani Sunil <janani.sunil@analog.com>
Subject: [PATCH v2 0/2] Subject: [PATCH v1 0/3] iio: dac: Add support for
 MAX22007 DAC
Date: Thu, 8 Jan 2026 13:58:22 +0100
Message-ID: <20260108-max22007-dev-v2-0-2506c738784f@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO6pX2kC/3XMQQ7CIBCF4as0sxYDE7XUlfcwXUxh2pJYaMCQm
 oa7i927/F/yvh0SR8cJ7s0OkbNLLvgaeGrAzOQnFs7WBpR4Vag6sdCGKGUrLGehiEap7dDqTkK
 9rJFHtx3cs689u/QO8XPoWf3WP1BWQgq8oCU0OOibfpCnV5jOJizQl1K+xxq+h6kAAAA=
X-Change-ID: 20251219-max22007-dev-1aaf08db7890
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Alexandru Ardelean
	<alexandru.ardelean@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jan.sun97@gmail.com>, Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767877109; l=3836;
 i=janani.sunil@analog.com; h=from:subject:message-id;
 bh=GIGWmCOhSWxzlOF3iCBOFJmMnjV2NFQFhntQhDwwkQ4=;
 b=KA6P//WcbQOQydE7OdpFRNCx/oMt81yj7lArqQ+RkO6hGB/UdlgjzlwVNrohDLDQ5BdCZ0zbr
 f46lhSDKT7YD4i72uuUtxVWrw2PM6QRy9m/B9YkKPP/HjRoeeqo7dyZ
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=EtnfbCcA c=1 sm=1 tr=0 ts=695faa03 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=07d9gI8wAAAA:8 a=pGLkceISAAAA:8
 a=hT07yNKm7YZZmlAkMzEA:9 a=QEXdDO2ut3YA:10 a=e2CUPOnPG4QKp8I52DXD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA5MiBTYWx0ZWRfXx+pC2a6i7XS3
 qqLEGOr0HkDjO8GXvo85R9fBbveChP47c6oedAMg4ssoAR/uJPSErFtA5q0RFSw1Kpmob7BJrhA
 lD7NBn8vvRUpxjvVOi1WZTUudBiPap7SQXAnZvJcLXuLnuvK9v5tVsP19j1BEVwh5QjYbT2hRAU
 fiCl5lcrjTkffECW5ElK0PEvSo/fRFjOtUpS+gQCe4GzqUDelePofLZ+5u4fpXZynriGAK98eBY
 Fzcv2TK4rp7FrqDF48u2KRGQH2+R3bRrOzptlwnPOcwj7uAWKaaQKvxAnb/ulargcyETHgx2Uyo
 xjXHK3WwxPtQ2J8GvEoyb1P2ZmUMw+7zbke2Uw0/HU81E2Uo6oOSGmWkDJWCElWkCmj9aLSaFvw
 upSyMf70gfVFOpZ7K2BLwHfmdgumffktCKlRLdYVB0k58SCjObvo0+bB2sa+D+ZJ4CAg6hJsLRh
 wcjL/axBdqZETP9nMjw==
X-Proofpoint-ORIG-GUID: CUId89ZVQB_0EcwhbbQQNlBPuNTM3w49
X-Proofpoint-GUID: CUId89ZVQB_0EcwhbbQQNlBPuNTM3w49
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1011
 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601080092

This patch series introduces support for the Analog Devices MAX22007, a
quad-channel, 12-bit digital-to-analog converter (DAC) with integrated
precision output amplifiers and configurable voltage/current output capability.

**Device Overview:**
The MAX22007 features four independent DAC channels that can each be configured
for either voltage output (0-12.5V) or current output (0-25mA) mode. The device
communicates via SPI interface with built-in CRC8 error checking for data integrity.

**Features Implemented:**
- Support for all 4 DAC channels with 12-bit resolution
- Per-channel voltage/current mode configuration via device tree
  property `adi,ch-func = [voltage, current]`
- Independent power control for each channel (attribute)
- Hardware reset support via GPIO (during probe)
- CRC8 error checking for SPI communication

**Patch Summary:**
1. dt-bindings: Binding documentation with channel configuration
2. driver: Implement IIO DAC driver

**Testing:**
The driver was hardware tested on a Raspberry Pi4 on top of v6.12.y
kernel using the MAX22007EVKIT evaluation board.

Janani Sunil (3):

dt-bindings: iio: dac: Add max22007
iio: dac: Add MAX22007 DAC driver support
---
To: Lars-Peter Clausen <lars@metafoo.de>
To: Michael Hennerich <Michael.Hennerich@analog.com>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: jan.sun97@gmail.com
Signed-off-by: Janani Sunil <janani.sunil@analog.com>

---
Changes in v2:
- Wrap commit messages as per coding guidelines
- Removed all driver references from the hardware
- Update property description for reset-gpio
- Removed allOf
- Added minimum/maximum limits for channel number in the devicetree
  binding
- Replaced adi,type with adi,ch-func.
- Added reference to required supplies in the binding, configured them
  in the driver
- Channels are not a required property anymore.
- Replaced instances of 'channel' in macros to just 'ch'
- Added trailing commas wherever necessary, removed them as per comments
- Add explicit values for enum- max22007_channel_power
- Replace channel spec structure member 'iio_chan' with 'iio_chans'
- Use spi_write_then_read() API in the max22007_spi_read() API
- Check for reg_size ==1 and hardcode the size otherwise
- Wrap lines in the driver to 80 characters
- Update in-line comment on the resolution
- Separate declarations with assignment, from the ones that don't
- Update the usage of channel template
- Add a local device descriptor to point to the SPI device
- Add a transition of the Reset GPIO from low to high in the probe
- Make use of regmap_set_bits() instead of regmap_update_bits during CRC
  Enable function call.
- Remove the documentation commit, as it is not needed anymore.
- Link to v1: https://lore.kernel.org/r/20251219-max22007-dev-v1-0-242da2c2b868@analog.com

---
Janani Sunil (2):
      dt-bindings: iio: dac: Add max22007
      iio: dac: Add MAX22007 DAC driver support

 .../devicetree/bindings/iio/dac/adi,max22007.yaml  | 136 ++++++
 MAINTAINERS                                        |   8 +
 drivers/iio/dac/Kconfig                            |  13 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/max22007.c                         | 507 +++++++++++++++++++++
 5 files changed, 665 insertions(+)
---
base-commit: a7b10f0963c651a6406d958a5f64b9c5594f84da
change-id: 20251219-max22007-dev-1aaf08db7890

Best regards,
-- 
Janani Sunil <janani.sunil@analog.com>


