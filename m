Return-Path: <linux-iio+bounces-20761-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C4CADF3E0
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 19:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E712E189D1BE
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 17:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953472F0C5B;
	Wed, 18 Jun 2025 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="EEvSzUfU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0F12FEE02;
	Wed, 18 Jun 2025 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268078; cv=none; b=kdMR4Z+CpJX4AYj99oSOomq6ZfrgWSpimnKaY6naIQIGrtPe2H/7HYrKw+d2l5t4vMo89PNfIB9q+KwOXKzk8zVz+JX4a0ekDxEIZeLoNV+RMX6pnPsEaRe/QZcBDKJIWQg1apNCFwx4CctWQIvCWTytPxDJxOC6NxI11YFrJwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268078; c=relaxed/simple;
	bh=S0Y0NIrvyHPGvVRHrrHEEVyNWs+Y7aQ2cF/J/p36m9Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NBsucBZFNdANv1NTWVlthcDt8qpo9pjq3hF85/lW4QAqT30LpYaic5BXteGNfnwHeFYyE4GkBllg823fD35rvBpXiD8M1zfNTfqg+vipzGBBAh+CHghHvO9u3WKE9H9+IcYNaDbptt2t262+nTHiOLlKSnzaPGn9lvT2sfaL878=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=EEvSzUfU; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IH32Ds027657;
	Wed, 18 Jun 2025 13:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=X4IxZEv2AJ8NRfgfm8puQl5jpjl
	sth1sVkXAm1mr8as=; b=EEvSzUfUJ9kIQERVObkQXJZw+sBI+Gt+EM3MvqgaRWt
	1zBJ0DpCMXP3m5qQJKpA1qHJ6qGH9GFfVSGx2u8VKvfTa4PDEfEGCmHp0EEHAE8E
	LymCqfGbxypGjN13coWJqISnGPjXRQJkyns5GNekBn/orj201UL6mIAp5ZvWOtMN
	zotgCGhsYoJvm0QutIGnD5GHAzrc/YJsbAVLTg5Q2bft28HJKyN0W/Ej5fKaXG/S
	WtjHmDHJdqi8HxEXwrZfoGV0qVX1Uxu5Lcxh7X2c8Ur8NK/Kq9EFj8rep3DolS4C
	+vhuPbONsOmMuBce5zbCGiQfewCjD1aWXBOxDh68guQ==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 47bfxcwcr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 13:34:13 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 55IHYBHj031388
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 18 Jun 2025 13:34:11 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 18 Jun
 2025 13:34:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 18 Jun 2025 13:34:11 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55IHXrJc007373;
	Wed, 18 Jun 2025 13:33:55 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v6 00/12] iio: adc: Add support for AD4170 series of ADCs
Date: Wed, 18 Jun 2025 14:33:49 -0300
Message-ID: <cover.1750258776.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-ORIG-GUID: x8K3tgifp7eGus_Gd1EDW-DB3jO0fZs-
X-Proofpoint-GUID: x8K3tgifp7eGus_Gd1EDW-DB3jO0fZs-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDE0OSBTYWx0ZWRfX2ULPmt14TyJb
 oBWoXjHo5eP5H1VatFef3QkoOj44THTwBR9g7mTEvw2dpQ9E3QpFKWZu1e6DNQujCFz82Kvd53V
 g2CJIqWIdUG3mrkS2F1sFiiObkGKqSX9WZe84vVQEj8ZwJqqtxWRIOSwcjSKoIFZ+UCksSV5YPu
 n+n0+R45KadGsys0L2M9Lb4dWrDPqQ8/QqTYVrbCE0LJcO3hw1OlRfga8uRJGFdey0tVX21CSZO
 18f1L2bVvebo1G3gFKu3AfTzihTUOKputtbDf7emNCgGbRyUkNYodVjYBrayHaNPTDMb841wBWT
 JREWTFOdlVtStf5PBHWlQ6bXp7Eyuv/ks+l11XokzIx0B4oiIn7fCUhmu9rAkzhLGf+aQvw4VXz
 lE0laV0ejTG8o1LhHOYftiRY7/bqT8UVzRhbFpFxWruoOKZnchQinqUe4UBPon2FUQhmPUv7
X-Authority-Analysis: v=2.4 cv=Jb28rVKV c=1 sm=1 tr=0 ts=6852f895 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=R-fzppr3M00CTqMmcK8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 clxscore=1011 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180149

Hello,

This is version 6 of AD4170 support patch set.

To regulator framework maintainers:
The AD4170 and similar devices have a AVDD/AVSS pair of supply input pins that
allows to provide a bipolar power supply to the ADC. On that power scheme, the
AVSS input takes a negative voltage supply. Also, since those supplies can also
serve as reference to ADC conversions, the voltage level of each supply is
relevant to converting ADC output codes into milli voltage units (i.e. a
particular output code with ±2.5V AVSS/AVDD supply maps to a different voltage
than the same output code with 0V to 5V AVSS/AVDD supply). AD4170 also has
REFIN- and REFIN2- negative supplies that can occasionally be positive. For
better AD4170 support, we would need a way of reading negative voltages from
regulators, which doesn't seem to be currently supported by the regulator
framework.

There seems to be no opposition to having negative supplies on an old thread
about the subject [1]. Question is, do negative supply support still sounds
feasible?

[1]: https://lore.kernel.org/linux-iio/544AC56F16B56944AEC3BD4E3D59177137546EF3FC@LIMKCMBX1.ad.analog.com/

As always, thank you to all reviewers for your advice and patience.

This patch set adds support for Analog Devices AD4170 and similar sigma-delta ADCs.

Patch 1 adds device tree documentation for the parts.
Patch 2 adds basic device support.
Patch 3 adds support for calibration scale.
Patch 4 adds support for calibration bias.
Patch 5 adds sinc5+avg to filter_type_available IIO ABI documentation. (new patch)
Patch 6 adds support for sample frequency along with filter type configuration.
Patch 7 adds support for buffered ADC reading.
Patch 8 adds clock provider support
Patch 9 adds GPIO controller support.
Patch 10 adds internal temperature sensor support.
Patch 11 adds support for external RTD and bridge circuit sensors.
Patch 12 adds timestamp channel

Change log v5 -> v6

[device tree changes]
- Made reference-buffer string type.
- Moved required section before patternProperties.
- Made avss, refin1n, refin2n documentation open to accepting positive and
  negative voltage specifications where appropriate.

[Basic driver patch]
- Added trailing commas to enum declarations.
- Updated int pins_fn -> unsigned int pins_fn.
- Use local string to simplify dt parsing and error handling.
- Updated 'if (ret < 0)' to 'if (ret)' wherever appropriate.
- Expanded code comment to clarify that refp can only be >= at ad4170_get_input_range().
- Pass fwnode_property_read_u32() return to dev_err_probe() in case of error.
- Declared a define for the constant 2 byte size SPI instruction phase.
- Dropped use of static_assert().

[New patch - Add sinc5+avg to filter_type_available list ABI]

[Buffer support patch]
- Used local variable to minimize the risk of race conditions when checking IIO
  scan_mask.

[Clock provider patch]
- Now using device_property_present() to check #clock-cells presence.

Link to v5: https://lore.kernel.org/linux-iio/cover.1749582679.git.marcelo.schmitt@analog.com/ 
Link to v4: https://lore.kernel.org/linux-iio/cover.1748829860.git.marcelo.schmitt@analog.com/
Link to v3: https://lore.kernel.org/linux-iio/cover.1747083143.git.marcelo.schmitt@analog.com/
Link to v2: https://lore.kernel.org/linux-iio/cover.1745841276.git.marcelo.schmitt@analog.com/
Link to v1: https://lore.kernel.org/linux-iio/cover.1744200264.git.marcelo.schmitt@analog.com/

Ana-Maria Cusco (1):
  iio: adc: Add basic support for AD4170

Marcelo Schmitt (11):
  dt-bindings: iio: adc: Add AD4170
  iio: adc: ad4170: Add support for calibration gain
  iio: adc: ad4170: Add support for calibration bias
  Documentation: ABI: IIO: Add sinc5+avg to the filter_type_available
    list
  iio: adc: ad4170: Add digital filter and sample frequency config
    support
  iio: adc: ad4170: Add support for buffered data capture
  iio: adc: ad4170: Add clock provider support
  iio: adc: ad4170: Add GPIO controller support
  iio: adc: ad4170: Add support for internal temperature sensor
  iio: adc: ad4170: Add support for weigh scale and RTD sensors
  iio: adc: ad4170: Add timestamp channel

 Documentation/ABI/testing/sysfs-bus-iio       |    1 +
 .../bindings/iio/adc/adi,ad4170.yaml          |  558 +++
 MAINTAINERS                                   |    8 +
 drivers/iio/adc/Kconfig                       |   16 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ad4170.c                      | 2994 +++++++++++++++++
 6 files changed, 3578 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
 create mode 100644 drivers/iio/adc/ad4170.c


base-commit: 4c6073fec2fee4827fa0dd8a4ab4e6f7bbc05ee6
-- 
2.47.2


