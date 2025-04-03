Return-Path: <linux-iio+bounces-17573-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 920B7A79B5A
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 07:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDDFA1896A2E
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 05:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0423A19E7F8;
	Thu,  3 Apr 2025 05:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="iaRrqQ/w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B05419CD1D;
	Thu,  3 Apr 2025 05:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743658490; cv=none; b=GZ6Qb5QzFf8XhsUq5+4giMBnGg08NPWBpR3GGWpyrgcPVP5pP48AMZTYDDSFwC5UUzKQGIcqMx9WQiuEMTX+Ex5rQYK4dDdR55FoCZdy0AcFYzhXekcz1RXgEQHvgq2WRuxFKMX2yk+RdRI04enABjZvHfaZ9iLVWQMmt+j2Uqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743658490; c=relaxed/simple;
	bh=+KgRRrVkhdEH83dWq8VuVTcakbsmjiUG2cFGm5+d/H4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=sO89xcnbxUVpi5svVyQzNJPpMQtqFUb/YCjKRUCDdMUDgf9vOO7QA+zaFOL+XVW0yKON0Nn0zSO5w9s7uWGJtWuZgPFJjjX+uSCj6sYy/zRtzCXkEgfak0RVDD/khrLz+ePEx0ukBh4CHhNOTGyXmpqXK0gKisyEYYuWmjhMP8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=iaRrqQ/w; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5331alx6018304;
	Thu, 3 Apr 2025 01:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=EdUHjytkp06SnWtxffVLQhd8UPa
	yk/8Md4Cr471hBOQ=; b=iaRrqQ/wWika6Sa6yX7GGXDcaGWaw/n4cGMUKj1kRrW
	+i5eZBkkkG0mGRbGkE202bzYZCdEafgtA9i+3lreVPLAOCPtXBvxFVMYnOsw0P6W
	TqBCb0vrPQGjNRokbLbx0QcRmX9zHTYfnBjixN8TrxYa3CsjLuz7O9jlbuhtGfhD
	a2U6araNnFAbbwFvR9C82fdlnWKexAmp8852YM0ReFBjsNaA8ckydOwd86zaN/jH
	lXMwMwSifS9maNaGTAD+GTbs3BCiwxHTcF5uvHgSrAbc6Cphxs5M7plRJyrv+ftt
	O/Iwe4uuLcqs/Qn4eMkcAawNalR0T9WPfjBVVJLIz8Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45rcrx40jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 01:34:34 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5335YWq0004207
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 3 Apr 2025 01:34:32 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 3 Apr 2025 01:34:32 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 3 Apr 2025 01:34:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 3 Apr 2025 01:34:32 -0400
Received: from [10.0.2.15] (KPALLER2-L03.ad.analog.com [10.116.18.50])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5335YHaU007295;
	Thu, 3 Apr 2025 01:34:20 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v3 0/3] Add driver for AD3530R and AD3531R DACs
Date: Thu, 3 Apr 2025 13:33:54 +0800
Message-ID: <20250403-togreg-v3-0-d4b06a4af5a9@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMId7mcC/2WMywrCMBBFf0VmbSQzfdi68j/ERUgmaUAbSUpQS
 v/dtAtRXJ7LPWeGxNFzgtNuhsjZJx/GAtV+B3pQo2PhTWEgSY2ssBdTcJGdsLpVUtm+RTZQzo/
 I1j+30OVaePBpCvG1dTOu618io5DCdFTXqpFkSZ/VqG7BHXS4w9rI9OVR/fGoeJYQzbHDnir+8
 ZZleQM6GZOh1QAAAA==
X-Change-ID: 20250319-togreg-fc6a0af961ed
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Kim Seer Paller <kimseer.paller@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743658457; l=2595;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=+KgRRrVkhdEH83dWq8VuVTcakbsmjiUG2cFGm5+d/H4=;
 b=dFul9Ito//sa9NmAdrXKeUKcbYmSrkkZ9IzoF2VwgC3C2QvXsv2V5yvZX5pBLJeKPqfIkV0aE
 ds6CvXX5SkeAeVZHbwnFtUl/Gl/+nrRtebai0n/f3NB4P8XUy9tgetf
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=KqVN2XWN c=1 sm=1 tr=0 ts=67ee1dea cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=ABwU-0_bCvWcPI1q2z4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: id4XuffdJ6nnyzGHI1qRR1dlgGp0X86V
X-Proofpoint-ORIG-GUID: id4XuffdJ6nnyzGHI1qRR1dlgGp0X86V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_01,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504030027

The AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel) are
low-power, 16-bit, buffered voltage output DACs with software-
programmable gain controls, providing full-scale output spans of 2.5V or
5V for reference voltages of 2.5V. These devices operate from a single
2.7V to 5.5V supply and are guaranteed monotonic by design. The "R"
variants include a 2.5V, 5ppm/°C internal reference, which is disabled
by default.

The AD3531R/AD3531 is not yet released, so the only available datasheet
for now is the AD3530R/AD3530. The only differences between the two is
the number of channels, and register addresses of some registers.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
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
 .../devicetree/bindings/iio/dac/adi,ad3530r.yaml   |  99 ++++
 MAINTAINERS                                        |   8 +
 drivers/iio/dac/Kconfig                            |  11 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ad3530r.c                          | 514 +++++++++++++++++++++
 6 files changed, 635 insertions(+)
---
base-commit: 8dbeb413806f9f810d97d25284f585b201aa3bdc
change-id: 20250319-togreg-fc6a0af961ed

Best regards,
-- 
Kim Seer Paller <kimseer.paller@analog.com>


