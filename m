Return-Path: <linux-iio+bounces-20126-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3467AACAD44
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 13:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33EB33BB724
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 11:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796BB1F866A;
	Mon,  2 Jun 2025 11:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="d1+1oxtz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870E92C3278;
	Mon,  2 Jun 2025 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748864129; cv=none; b=mnJwnsNL13XlidAGj/zWE9Eh9Vyr6azVmr34WoTVVjs6g1Ge+O0/MCZ7cBWSK3YwMe0gwgvtzs+IGQSpPXEwBTB4MeX5N0AVtKRc3AE0B4F7LtoexQSnylc7Z1WXZNU2rvAiVNr5zpRO8f9ULzTezt99a0r+ZQbsQDhF7Sm5J6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748864129; c=relaxed/simple;
	bh=rF/9b3LJ3IA8TfLAcik97ecBjzWIPZPNPh6eJpq38Io=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lT4+qT+Z2ovIxu0gZqBZbhnixpcEP7zLCNTrI893sXrIq5EJlISY95VNFOhzTKsmESHl719XAyZ8zyu4qfU1pWyTDoe7txjbkWQMiAlWIodyZLkUf5onk4EDTtgKviRHJ8ITNLUsESd+OyIyRIzjsRmL90/LsKX7ElM2i7An06w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=d1+1oxtz; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5528HtcN021951;
	Mon, 2 Jun 2025 07:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=StonQp8T+GwsIst/+wugE6MZqc/
	OMQy2k/0svrvjomI=; b=d1+1oxtzmTurjFlo+/BcekOfQubKo7GvKFd3DWk5+2b
	A9MIaUE9Gzf+IlkixTA/Uw4c91jH/vgB8cQar9u5nssH3xSTSUjY4ZW23rsQk8Ok
	9gaBKI/Xm8GNDLGL7oe/WHeugS1iOoZ5HPBI8/oT1n+otJcDSciaviA2fsse6S9O
	IeNfeBYPstymOm3OyVaxyooaV4V7E0bhlx2n9JtOQfXGBsJlfH9uyj/FKp8R4WCW
	gT2UpCBw91UuXkuVVEbS8PBCat5P5teS7OgWt9lt/G2cBLnUwGLbUgJvHQVztzuV
	hidRVnu3nZS/qBVlCF1uGU6y3CzysryMUfgZ9BJVVmg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46yxp57apk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Jun 2025 07:34:55 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 552BYsYf023136
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Jun 2025 07:34:54 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 2 Jun
 2025 07:34:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Jun 2025 07:34:54 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 552BYaou024822;
	Mon, 2 Jun 2025 07:34:38 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 00/11] iio: adc: Add support for AD4170 series of ADCs
Date: Mon, 2 Jun 2025 08:34:31 -0300
Message-ID: <cover.1748829860.git.marcelo.schmitt@analog.com>
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
X-Authority-Analysis: v=2.4 cv=HdIUTjE8 c=1 sm=1 tr=0 ts=683d8c5f cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=DCPjQr0N_ePN03jlYIoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDA5OSBTYWx0ZWRfXyBajPOEwOLzI
 6Rbd7FImKJ3hh66+wqFHaG4uskdIThJoUYM410WdjhTU6kgecnqVNRIrK2/lhvRO2yeVN0wmog6
 CjWkGf5j9+mYpHa4MrcRq9Dvro0smp1HkVkULPJfd3HLVD3hWFhUEaZpldwkV131W3Z6pnqSkEP
 QBEsnH2vsIGCqYtKnMVgq8KFkpBJoxnYJTviAl/wifoavufAi6iLALcjDUdGhQa7Extqe5qbpuC
 TvlCujVZj7fxdrAK/Kg4AC4bNbWYu5TOX1ERY625PKEtFZAlNXwd4wD+kI1MzaALQ8g7x3Z+yPd
 mdP0Ez43cPBQQGsXWqaSNTkJ+WbWAq1rnJekv862P4zKO55kENqxSlwEMRiOP9Zznv9ZaQl+mC2
 2c89Xcxe8w6hNvNK9lA62m8vclxOusOwWILCTM8mvvT5QYYDFd+uCd5mLbytQq1dJJ0gv/SZ
X-Proofpoint-ORIG-GUID: nRdhRdhYHL_nP-Nx18jD7ummIYC-iOjr
X-Proofpoint-GUID: nRdhRdhYHL_nP-Nx18jD7ummIYC-iOjr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_05,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2506020099

Hi,

As always, thank you to all reviewers of previous versions of this set.
v4 comes with a few changes to comply with suggestions provided to v3, being
most of them related to the adaptation of dt-binding properties.

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
Patch 11 adds timestamp channel [new patch]

Change log v3 -> v4

[Device tree changes]
- Dropped sensor-node and most of defs.
- Updated external sensor props to have similar name and type of adi,ad4130 ones.
- Added constraints to properties related to external bridge sensor excitation.

[General IIO driver changes]
- Locked device mutex to ensure attribute read correctness on all archs
- Fixed typo unasigned -> unassigned

[Basic driver patch]
- Added previously missing #include <linux/cleanup.h>.
- Moved struct completion declaration to reduce commit diff.

[Calibration scale/gain patch]
[Calibration bias/offset patch]
- No longer restoring calib gain or calib offset on reg write fail.

[Digital filter and sample frequency config patch]
- Use scoped_guard to ensure correct lock release order in ad4170_set_filter_type().

[Buffer support patch]
- Fixed a bug in the filling of the IIO device buffer.

[CLOCK provider patch]
- Explicitly stated that clock divider (CLKDIV) control support is not provided.
- Skipped clock provider register if "#clock-cells" is not present.

[GPIO controller patch]
- Made AD4170 depend on GPIOLIB.

[External sensor patch]
- Update to string adi,sensor-type dt property.
- Adapted external sensor dt prop parsing to work with the updated version of those props.
- Improvements to readability.

[New patch - Add timestamp channel]

Link to v3: https://lore.kernel.org/linux-iio/cover.1747083143.git.marcelo.schmitt@analog.com/
Link to v2: https://lore.kernel.org/linux-iio/cover.1745841276.git.marcelo.schmitt@analog.com/
Link to v1: https://lore.kernel.org/linux-iio/cover.1744200264.git.marcelo.schmitt@analog.com/

Ana-Maria Cusco (1):
  iio: adc: Add basic support for AD4170

Marcelo Schmitt (10):
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
  iio: adc: ad4170: Add timestamp channel

 .../bindings/iio/adc/adi,ad4170.yaml          |  543 +++
 MAINTAINERS                                   |    8 +
 drivers/iio/adc/Kconfig                       |   16 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ad4170.c                      | 2973 +++++++++++++++++
 5 files changed, 3541 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
 create mode 100644 drivers/iio/adc/ad4170.c


base-commit: c06335516e8c14f501a479a4d9de0e6c09c52ef2
-- 
2.47.2


