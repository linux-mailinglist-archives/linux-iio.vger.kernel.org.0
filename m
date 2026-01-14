Return-Path: <linux-iio+bounces-27790-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6107CD202B2
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 17:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA2553081FBB
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 16:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BB43A35DB;
	Wed, 14 Jan 2026 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rQbLJ7DZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491EA3A35AE;
	Wed, 14 Jan 2026 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407539; cv=none; b=YiFbuqUdel/Wt6H3cQCmONdZV2SKnBQHaHCAfzfZ9tGCYauqu0BCjRgFxIQ7/PupawzBSkmkZMLUxw4sEJvLCRDHgiEe/Efs3meNoMIA2yl87d1MmLcIyghVRuICmGrnwvi2yoq0eDhRb78TRnsFGcXGV615/Ihc9O5jMGnmzOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407539; c=relaxed/simple;
	bh=Nf+12xOltk2ropuig0YP9tBRUCODOe250oZIgxrR3D0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=F3ySBemrAHVb0vK8uBKSqL2BjwqkEIoEqjsYlNkFr29R/1MkR2Zkj2TY5FF7goIw4yT7Xxwmej7iRKOp2p0u99H7LZjCFw3V5JloYgTh6cows55SJ1JmRgVPFqEY3cZZxx25f0CNWQ0tpZ7FOar1ZtR8JqzmuJVZGRif8ONlm2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rQbLJ7DZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EG0kwA014549;
	Wed, 14 Jan 2026 11:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=cIdW2lOdZ86IqA1QSHntZFx4xWm
	DoFfI8aJkT86NS4A=; b=rQbLJ7DZ5D31IjFcuql9ypEtvFqT/V1M2QNQsOQgZYS
	6fG+W4HnLESBHRTLGQEeM9igSyAzuw7MP3s8zrLD4NAZ/nwkbGCRT1nhoJxI4wvx
	OkGnGRBDw+dtrXFwfzZ4BARCfYOFJWHN3DVEu3BWk9U4K7f9tX78L+qeD9mTv8v5
	V9Uz7khIZ+L2dmoykrdmkW3hbLBx2WQ9lfDydxxqLCmiU2En8CdqPD9hOidC+L31
	KTkOECClYvMqpcFMZsMUgIM0k3t1fPZa73G8/aMHWiXFohTVFfgVnyLKI88PzbWg
	LpujVgkZOPis9FqUn05rVsEJAzbiqimRMGeM1EkhNew==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4bpau0bkk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 11:18:30 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60EGI6v1028135
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Jan 2026 11:18:06 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 14 Jan
 2026 11:18:06 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 14 Jan 2026 11:18:06 -0500
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.126])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60EGHmHU028201;
	Wed, 14 Jan 2026 11:17:54 -0500
From: Janani Sunil <janani.sunil@analog.com>
Subject: [PATCH v3 0/2] iio: dac: Add support for MAX22007 DAC
Date: Wed, 14 Jan 2026 17:17:00 +0100
Message-ID: <20260114-max22007-patch-v3-0-769298f50b8a@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHzBZ2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0MT3dzECiMjAwNz3YLEkuQMXbMk02QTi1RjcxNTcyWgpoKi1LTMCrC
 B0bG1tQC3DWQFYAAAAA==
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
	<janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768407468; l=4450;
 i=janani.sunil@analog.com; h=from:subject:message-id;
 bh=Nf+12xOltk2ropuig0YP9tBRUCODOe250oZIgxrR3D0=;
 b=UFzSI/LYLsV2a+d9WLKOFyPohZPvBi2kAK0W5i1gQUNcLa166mWc4ncZhOvwb4RCFkusCxL1a
 LSB8v183saAAnKQw0Yqp9HNDY/Va/NqTyUSiycviVsrhfcaujCp9AAQ
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEzNCBTYWx0ZWRfX08jOt2cOQdyI
 uTrscGagHZcv4T3cqDtpjncKRfjahaq1UrkKLaJSGp932jS5JblmfT7DWFq1cWBWGfTqkCLV59W
 CmvbRsdeZVFNO7z4anf6q90QxQ52vqkkQ2PuunRW+iKZsrqvMBsL26C7mwZoXJWswLIcVDVpOok
 MuzMK3aBJhrlp1UEWPiSFWs6ZSZYCg3YAOFune0BBOWPA0p4IAHxwc+XKXEm1g24KNx0vQDwVre
 /tawEBIopsSFF5j6Vemfvbt0Cf6iQP4WvgckHYiJzgNZdD3FTvdWRXmXOCFY2vQdQrvV1jBNzx4
 gOyQfbtghb9EIB6s399NxNg6PoDGh9CsPy9KGEml5SLa4p78E7Dn46uRSPaVH7RHFi5MOU/0/tz
 trI536imwln3LxgcHWuoR0mr/D+pppM/Tag54VRzNdhFmC5v6nXoT5OkmBLp2EBAoFjfYAAzpAy
 +uaNAMWEhObkWifyhsA==
X-Authority-Analysis: v=2.4 cv=YcWwJgRf c=1 sm=1 tr=0 ts=6967c1d6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=07d9gI8wAAAA:8 a=pGLkceISAAAA:8
 a=VA_PCd8hym60q8TugJUA:9 a=QEXdDO2ut3YA:10 a=e2CUPOnPG4QKp8I52DXD:22
X-Proofpoint-ORIG-GUID: fTWq-H7k_QPd6evnuworkaTzXjXgrdbK
X-Proofpoint-GUID: fTWq-H7k_QPd6evnuworkaTzXjXgrdbK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_05,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140134

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

 .../devicetree/bindings/iio/dac/adi,max22007.yaml  | 116 +++++
 MAINTAINERS                                        |  16 +
 drivers/iio/dac/Kconfig                            |  13 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/max22007.c                         | 488 +++++++++++++++++++++
 5 files changed, 634 insertions(+)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260114-max22007-patch-6b5c48e37457

Best regards,
-- 
Janani Sunil <janani.sunil@analog.com>


