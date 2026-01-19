Return-Path: <linux-iio+bounces-27954-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 365DFD3A6D4
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 12:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02E0A3085F8F
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 11:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC5B310627;
	Mon, 19 Jan 2026 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="HAAzutWZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C323019D9;
	Mon, 19 Jan 2026 11:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768821936; cv=none; b=dM6VAZ519cOgdv1QYSYCYlgvvwKuxSRPSgM9dpnR8Colf41mGcov2JkaUcmDHc1i9WRDxv4agiHPyNz0TqOmRq6IEJDq4ykCkr6Z6Z0A+RdaEg9DRNcf07QdzCZM62c5CeuJbXKLSufZkn396xrPW/IYNr4874KASW5ypnUbLVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768821936; c=relaxed/simple;
	bh=9WWRaBXOj9FVOKMR8Jrg0FvjLO0roqJU7i/MK/AWi/4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=jb8JqlQjiDkJTsF9IBlJ+4Al7qC7xjbQ/PukQrMyFOPYC6XJtYHj1ugRs3h4w2KKlYF9BOUNf8k6w789Ymdlz2pcCd7gLtxr9ApkHYXBymAg2UHHIEezTTTBooRZSI0sMVTH7eEvBNpO7A5TBebNjWMbggMaQX4BgNRuWhw06EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=HAAzutWZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J83Enb490623;
	Mon, 19 Jan 2026 06:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=XOqfxA6X7jrLLbXcf9tTCIydtzV
	0K8yV21EofBuXDBQ=; b=HAAzutWZTMsOCVTWq2R3dBGQlBwIBdRyLaeWigclMZT
	xAHwq11dkjmNb8cZNpGTrEpWjZ+iGnUE9F5ArqbiVGL5OAO8I0Nro1JRnmu1nC8Q
	PfDRNzZ7ifOTAFNP7ZLVlsFOBkIBLtO+aOKE6h5Qql8CLjozNY7czZQEaVvtxCKf
	8QWA+WmvXEi8W07jfN47I3dAUW7d5i3OCn2p1cMrbl2rYIx7O1cZfI6tSrqGokQm
	rIkDn1xWG2N/poFocLfUZTUDf1ypjjuH+VxC2K2d0mOcni/awTa1YTpnki3yVz7E
	ZXU7DTbTLacH2PJNG58kwTDOxqPCxW2QLozyraKzfmg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4brrfymcqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 06:25:11 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60JBPABS041169
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Jan 2026 06:25:10 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 19 Jan
 2026 06:25:10 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 19 Jan 2026 06:25:10 -0500
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.126])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60JBOwHq023363;
	Mon, 19 Jan 2026 06:25:00 -0500
From: Janani Sunil <janani.sunil@analog.com>
Subject: [PATCH v4 0/2] iio: dac: Add support for MAX22007 DAC
Date: Mon, 19 Jan 2026 12:24:22 +0100
Message-ID: <20260119-max22007-patch-v4-0-e22404a885a6@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGYUbmkC/3XMTQ6DIBhF0a2Yb1wa5F9H3UfjACkKSQUDhtgY9
 17qvMP7kncOyDZ5m6FvDki2+OxjqMFuDRinw2yRf9UGgonAbcvQondCMJZo1ZtxSIzcMGWpZFx
 CPa3JTn6/wOdQ2/m8xfS5/EJ/61+qUISRFB3p1MTxqPRDB/2O893EBYbzPL/MpmEurQAAAA==
X-Change-ID: 20260114-max22007-patch-6b5c48e37457
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jan.sun97@gmail.com>, <gastmaier@gmail.com>,
        Janani Sunil
	<janani.sunil@analog.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768821898; l=4765;
 i=janani.sunil@analog.com; h=from:subject:message-id;
 bh=9WWRaBXOj9FVOKMR8Jrg0FvjLO0roqJU7i/MK/AWi/4=;
 b=+LvxDhKa67a2sN1nu8eGdwy9uZRdDmE19BfVrRfu8YmdQ+L5HEU6JYvR8F2vktjRSqUrpp6gZ
 ULjaqDrvPLPDK8mJHJI5uBvvaJlitooDjXeKEdJH0ui4sJ3KzQluM9Y
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: RlMIWep7b_-jtiMWz8IBWXHJByuJAkSU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA5NCBTYWx0ZWRfX7zkj93dIOWzu
 8RW2qPUO72pMaoHCWOxxv/s+R5MH1CA5rdtQJSDCmCdk4yf6+nBN8HFLTBY4zlVdlov8S+Wdy/e
 UUaiLGAsmhoGx07rfqEqPwz/3T4lV0YmulQuNv6ZYBnGfxYLkXZ4bpfVX1FNXYF+bN6rzj9zmMl
 dU6UVIHcrR4V+Va/Wn6hH6FBgR6cFt3qc/jhROGNUxcXldNYqPokHPlDGHP5tiLvTAxmrgMacIz
 86Ed5NpI09VgRuIK6Sf2vtcXywlirVu249gENYqTItM9iGzpX9DmXUcRbpCncT+nncphsf8QRnG
 Nlda8IPnNdpgPs9Et1kJtn4S3oV8szOnEnRYC5MxMa7hZkom4KzaDtJn9llZwO2gjf1UcsX88Ka
 rH+8Zr04kAdKqriTqfuYg7SjQHZu/f7xRfCPfzL/WcTRS5AKy5EbCZqUdDhbPsmH/Xr7nJkHJka
 Pvr/LLTrXA1bjJBHIBA==
X-Authority-Analysis: v=2.4 cv=COYnnBrD c=1 sm=1 tr=0 ts=696e1497 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=07d9gI8wAAAA:8 a=pGLkceISAAAA:8
 a=VA_PCd8hym60q8TugJUA:9 a=QEXdDO2ut3YA:10 a=e2CUPOnPG4QKp8I52DXD:22
X-Proofpoint-ORIG-GUID: RlMIWep7b_-jtiMWz8IBWXHJByuJAkSU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_02,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601190094

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
Cc: gastmaier@gmail.com
Signed-off-by: Janani Sunil <janani.sunil@analog.com>

---
Changes in v4:
- Re-sent of improper v3 (at v3 I *accidentaly* reverted the dt-binding
  commit to v1 after a rebase).
- Corrected description for reset GPIO in the dt-binding
- Wrap commit description at 75 columns
- Link to v3: https://lore.kernel.org/r/20260114-max22007-patch-v3-0-769298f50b8a@analog.com

Changes in v3:
- Remove node defined for power supplies in the devicetree documentaiton
- Made use of CRC8_TABLE_SIZE macro in the crc table definition
- Corrected casting of reg address in the SPI read function
- Applied reverse christmas tree variable ordering
- Added a macro fro the reference voltage and reused the same in the
  scale factor
- Removed usage of 'supplies' in enabling bulk regulator and removed
  unused variable 'i'
- Added step n the probe function to toggle the reset GPIO
- Updated spacing in macro definitions
- Link to v2: https://lore.kernel.org/r/20260108-max22007-dev-v2-0-2506c738784f@analog.com/

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

 .../devicetree/bindings/iio/dac/adi,max22007.yaml  | 120 +++++
 MAINTAINERS                                        |   8 +
 drivers/iio/dac/Kconfig                            |  13 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/max22007.c                         | 488 +++++++++++++++++++++
 5 files changed, 630 insertions(+)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260114-max22007-patch-6b5c48e37457

Best regards,
-- 
Janani Sunil <janani.sunil@analog.com>


