Return-Path: <linux-iio+bounces-27218-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9699CCD0869
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 16:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C92730ED051
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 15:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24EF32B9B5;
	Fri, 19 Dec 2025 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WS8xMDIJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB34A27FB32;
	Fri, 19 Dec 2025 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766158311; cv=none; b=R5SqJ7r7IdvH/fst8cmzig5fYf/VFsEtIKYrBaFdGhq+kHJto8U4MUrGKbbnWebBwPww0RDRgmI5ZCXSbz0RV4op/INk20tLcR/8y/l6cGy4ZoaSmsMA6CDusliH05QzPv/B0NEzDXeKKsT0y/N/P43bGwOZfyx0C85U9OQxAdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766158311; c=relaxed/simple;
	bh=oA1ASgydthLCu0G227T6yvkarKR6e0WSbIQdPZU72+Q=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=BOZuXw8nB+HuSDl4tU/R7krM5gVc8jHu7ZV2Vdj7CbOPN8zzbmvFFTAhHHZ+dSVc7G4SoeLnnfUA4lrsUTYxbcHORh/e8z+kFJpMyyoBxEinw+vmNAe4I/fSfU28CewuHgPti1ZMHhy+Vu6Usel8inHt6lLrQtfyfP6kjDS+Bug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WS8xMDIJ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJDL0NV2185193;
	Fri, 19 Dec 2025 10:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=OC7GVzfO1zheINt55lvS1wkHCrI
	RXG9aMXhjJL3uX9s=; b=WS8xMDIJSMYchzELrVMBRoOEAadNw1rD0FLGPT/Inb+
	d+b/eZbmTl39Z8MNSar3D58bkMY27/VAOHs0XpcnKxTjM4JvSyuLsrgY6NanDTTu
	Bi9Swm/02uTt4EzBHJtDBGLXGvCWfihwx/8LUge1lbC6gtbzHBDr7Lr1wzCw6x7R
	6cEYyR00dbgI2+7q3FK6RuPAKrkb0YuIfx+9PSRr1IhqCc5/3uYU4gc47LAqBzm8
	twGXzz7epuZk6A/HOhZevLbZJuyMGsVUI/AoUo0/v4b87FtDLMhE0A0lldWaaYIw
	lP4KNa17z0PqTE670AoI22GnxThnZhpatVGhWdkbMUg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4b4r3ucrvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Dec 2025 10:31:34 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5BJFVW2g051281
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 19 Dec 2025 10:31:32 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 19 Dec
 2025 10:31:31 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 19 Dec 2025 10:31:31 -0500
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.88])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5BJFVIW2004160;
	Fri, 19 Dec 2025 10:31:21 -0500
From: Janani Sunil <janani.sunil@analog.com>
Subject: [PATCH 0/3] Subject: [PATCH v1 0/3] iio: dac: Add support for
 MAX22007 DAC
Date: Fri, 19 Dec 2025 16:31:14 +0100
Message-ID: <20251219-max22007-dev-v1-0-242da2c2b868@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMJvRWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDI0NL3dzECiMjAwNz3ZTUMl3DxMQ0A4uUJHMLSwMloJaCotS0zAqwcdG
 xtbUAz5H1T14AAAA=
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
        Janani Sunil
	<janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766158278; l=3294;
 i=janani.sunil@analog.com; h=from:subject:message-id;
 bh=oA1ASgydthLCu0G227T6yvkarKR6e0WSbIQdPZU72+Q=;
 b=+lIvU1WrTE+8dt2kWMcPKkbYaRkSstKdquCl7pQosEWjo75w3LDuBi0EKZBn/NqIgzQrLzBrW
 WVEgKDiki2fBh6PGFlMYDkRsRJ0qk5+FT+3i0Q7qMzuOAolwurDJuqZ
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=L/oQguT8 c=1 sm=1 tr=0 ts=69456fd6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=07d9gI8wAAAA:8 a=hT07yNKm7YZZmlAkMzEA:9
 a=QEXdDO2ut3YA:10 a=e2CUPOnPG4QKp8I52DXD:22
X-Proofpoint-GUID: iYcVeoNGGS8oJaVxqdUGdGV1ZbDYoX51
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEzMCBTYWx0ZWRfXy94gBG3Pgi78
 Fj1KfsRlbFwer3XWlHARXwRhmdc+0POWzuJt715YvWN+UdMCEknP1bR47F7WG5dtd9LsbNcp1QE
 tv0lXjxBtx0ACfJ3Bz3KEov6SUrGOLgb9pCcjXUEhO4ppOoZg+nzZ9nBDXH1o+29i3WSzyPETG1
 Z1KHH3e4H327IXT/5vOBFGDGQLgemIwSjfitVKUPijvuxDZRgctgqoh8JFtuQPq6dG2sPy8t/NZ
 Mmbp3/bmQf952LmVs4m69D1FskzC66Gz6/4TOv/mrAjnYWsA5DetizHLBquPaYaqgI1mZQXLFYM
 EHnnke7XwIg8pm4xDm71b0E9yR8MdgT6AUxqFeK1ipZrKFkolQ4lP8CKdf9q/jSQcGB8PpeQuKL
 uSOLZ/naU6UFssYfWZSalI0h+P9ZST4j1KoKS8GALFWTDjmAyJiZZtizhHpS7UVwOmJB3CW1RVI
 i/xisyGx7O+Gcdf+Fzg==
X-Proofpoint-ORIG-GUID: iYcVeoNGGS8oJaVxqdUGdGV1ZbDYoX51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_05,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190130

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
  property `adi,type = [voltage, current]`
- Independent power control for each channel (attribute)
- Hardware reset support via GPIO (during probe)
- CRC8 error checking for SPI communication

**Patch Summary:**
1. dt-bindings: Binding documentation with channel configuration
2. documentation: Driver documentation with usage examples
3. driver: Implement IIO DAC driver

**Testing:**
The driver was hardware tested on a Raspberry Pi4 on top of v6.12.y
kernel using the MAX22007EVKIT evaluation board.

Janani Sunil (3):
dt-bindings: iio: dac: Add max22007
iio: dac: Add MAX22007 DAC driver support
docs: iio: Add documentation for MAX22007 driver

.../bindings/iio/dac/adi,max22007.yaml       | 117 ++++
   Documentation/iio/index.rst                  |   1 +
   Documentation/iio/max22007.rst                | 170 ++++++
   drivers/iio/dac/Kconfig                       |  12 +
   drivers/iio/dac/Makefile                      |   1 +
   drivers/iio/dac/max22007.c                    | 522 ++++++++++++++++++
   6 files changed, 823 insertions(+)
   create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
   create mode 100644 Documentation/iio/max22007.rst
   create mode 100644 drivers/iio/dac/max22007.c

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
Signed-off-by: Janani Sunil <janani.sunil@analog.com>

---
Janani Sunil (3):
      dt-bindings: iio: dac: Add max22007
      docs: iio: Add documentation for MAX22007 driver
      iio: dac: Add MAX22007 DAC driver support

 .../devicetree/bindings/iio/dac/adi,max22007.yaml  | 116 +++++
 Documentation/iio/index.rst                        |   1 +
 Documentation/iio/max22007.rst                     | 145 ++++++
 MAINTAINERS                                        |   9 +
 drivers/iio/dac/Kconfig                            |  13 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/max22007.c                         | 487 +++++++++++++++++++++
 7 files changed, 772 insertions(+)
---
base-commit: a7b10f0963c651a6406d958a5f64b9c5594f84da
change-id: 20251219-max22007-dev-1aaf08db7890

Best regards,
-- 
Janani Sunil <janani.sunil@analog.com>


