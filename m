Return-Path: <linux-iio+bounces-21153-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1639BAEDFC3
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 15:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE9F1898056
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 13:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3382328B7E9;
	Mon, 30 Jun 2025 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="TaU3rLyx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3916325BEE8;
	Mon, 30 Jun 2025 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751291904; cv=none; b=diYsQVbaTogwrI86IcUBm26tLcvdWRf5NzOQvfaVmFKga9sFa8LpzcyGI/8Ht17X3DM+C/dks2RyzIdQZaoRB61OX4lPSQNFPjvG5cbnhlT4uUa1Cci05sTQNxmCzOcBi1RwLeAG0QZbK2/w4SNjOOddfvP/DsPJesDtJ5HR4Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751291904; c=relaxed/simple;
	bh=+mUOGNyvnmJqJTQr8FKPFy4+r/6M3Ks91jztxb1kRSY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ScxUjGyCpjs+qg/mIB54E3WxCzC1+M3XZy3pIFqs9gza9ODggEv/McTmlxe/sTAaCEJjTI4FO/rFz/nDn0X5KPiQZMY5NZN3yetbNVsI9N5L9pjCdS0FnaP2oaHGUQdKrrTa4cgaevkE9kEf5dmIRt4IXFkL1Es1xd3panr0Uk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=TaU3rLyx; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UCqOiH011063;
	Mon, 30 Jun 2025 09:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=eJ6VzebltKwMMRwRYWzN7TXWK5U
	Z5cQmU354S1mH8EU=; b=TaU3rLyxAVT0UQdktrhai3dx5xmsbfigV3OS3C6mNKm
	OGFZaXJ/jYwUb/jm5xA3P+je4jmwPChkuIsfV6lffss2teKZBKnesCL5EggEWZ/0
	v1yVQ+Fu0K2lt2pRdc1dEo7VdtaNn0dRXgxtE/lWhpwbZUw27/DvHapOJXTua7ZM
	tjnpaY7nxHIatjnlYwAFPrGRrYH/QA1eQldQ68UUfSW52LMOIA3y7x8AKwSUlxYH
	s059N9DjzquQjzGgd1oKDcUSxnjxIXrmSryKHN6SmhaB2CJw77ms0CrCjq2R6kEq
	xnYPwAyutRwA50nla8A1inyJxp82s2SIRb7aRIY6ydQ==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 47kqwj18dr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 09:57:57 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 55UDvuwu039144
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Jun 2025 09:57:56 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Jun 2025 09:57:56 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Jun 2025 09:57:56 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Jun 2025 09:57:56 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55UDvbsS008238;
	Mon, 30 Jun 2025 09:57:40 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v7 00/12] iio: adc: Add support for AD4170 series of ADCs
Date: Mon, 30 Jun 2025 10:57:32 -0300
Message-ID: <cover.1751289747.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDExNSBTYWx0ZWRfX8jlwswqfCyl4
 riFyBSUxZIogvhukSIspJL8enLT6f300MCmmbwGqcEG8AOODJKw8F9FB13A8WwwlzqZn91X1bks
 1WVlbFdAmg8+7OGNnSYnu/CSdrczoKAO17muGY3BP7Ylrv0t84zu3BIWJJNxqZdIPVpyBNgMBUx
 uNIPxuoApumwB1HUHWYxw5FwbvwmOQHjuaxwLEelZuGK649T5AzWyjbJlu680bukswxfxDt8EoP
 OUYt0WLI+OXdVTY/Lg6hsUhC2EllAW+KzCxKgsfvc9h1HG9rwxD6KDaNp2K0zzSGh3NHGnc8Db5
 4MvtpCkyYITV8KFCnGGrZhqxxUxyVwYD53qWFdcRd82zBxXi4lYEk11CCYWTwM862uuj2W2mmDY
 nAG44cwRmpLFbq5w9uKBzCzOF/NrZOhLZABpzLkAgZ0YintfHKhQQY1hqSVAAbgz1/aZSuwf
X-Proofpoint-GUID: cOe44bxx6jGrjCumxvuKV48xn-nBFiIG
X-Proofpoint-ORIG-GUID: cOe44bxx6jGrjCumxvuKV48xn-nBFiIG
X-Authority-Analysis: v=2.4 cv=SsiQ6OO0 c=1 sm=1 tr=0 ts=686297e5 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=d2l83gEL7BD-IQ41SLYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_03,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300115

Hello,

AD4170 support v7 comes after testing the driver with even more variations of
channel setups. Signal offset and amplification can be tricky to grasp at times.

Thank you to all reviewers of previous versions. This intends to comply with all
comments and suggestions to v6.

Same amount of patches than v6.

Patch 1 adds device tree documentation for the parts.
Patch 2 adds basic device support.
Patch 3 adds support for calibration scale.
Patch 4 adds support for calibration bias.
Patch 5 adds sinc5+avg to filter_type_available IIO ABI documentation.
Patch 6 adds support for sample frequency along with filter type configuration.
Patch 7 adds support for buffered ADC reading.
Patch 8 adds clock provider support
Patch 9 adds GPIO controller support.
Patch 10 adds internal temperature sensor support.
Patch 11 adds support for external RTD and bridge circuit sensors.
Patch 12 adds timestamp channel

Change log v6 -> v7

[Generic changes]
- Renamed dt-doc and driver from ad4170 to ad4170-4. This will hopefully be more 
  future proof since there is precedent of different devices with names ending
  with and without -N (e.g. AD7091R and AD7091R-5, AD7768 and AD7768-1).

[Device tree changes]
- Dropped leftover/unneeded list of valid reference-buffer values.
- Set vbias at AIN8 in example. The vbias is expected to be set on the IN- pin.

[Basic driver patch]
- Refactored ad4170_parse_adc_channel_type() to use fwnode_property_present()
  so to return errors early if required properties are not present.
- Use spi_write_then_read() to skip dealing with DMA safe buffers in slow data paths.
- Minor tweaks to comments such as 'handle options ...' -> 'handle PGA options ...'.

[sinc5+avg ABI patch]
- Fixed IIO ABI documentation by specifying the correct filter enabled with sinc5+avg.

[Digital filter and sample frequency config patch]
- Now reading SPS table within filter type switch to ensure in bounds array access.
- Squeezed info_mask_separate additions to reduce change diff.

[Buffer support patch]
- Dropped extra assignment of st->trig->dev.parent.

[GPIO controller patch]
- Used local device pointer (replaced &st->spi->dev with dev) in ad4170_parse_firmware().

[External sensor patch]
- adi,vbias was previously set per channel in ad4170 dt-binding but it is set
  per device in adi,ad4130.yaml. Fixed ad4170 parsing of adi,vbias. The
  dt-binding had been updated to the established use of adi,vbias in v4.

Link to v6: https://lore.kernel.org/linux-iio/cover.1750258776.git.marcelo.schmitt@analog.com/
Link to v5: https://lore.kernel.org/linux-iio/cover.1749582679.git.marcelo.schmitt@analog.com/ 
Link to v4: https://lore.kernel.org/linux-iio/cover.1748829860.git.marcelo.schmitt@analog.com/
Link to v3: https://lore.kernel.org/linux-iio/cover.1747083143.git.marcelo.schmitt@analog.com/
Link to v2: https://lore.kernel.org/linux-iio/cover.1745841276.git.marcelo.schmitt@analog.com/
Link to v1: https://lore.kernel.org/linux-iio/cover.1744200264.git.marcelo.schmitt@analog.com/


Ana-Maria Cusco (1):
  iio: adc: Add basic support for AD4170-4

Marcelo Schmitt (11):
  dt-bindings: iio: adc: Add AD4170
  iio: adc: ad4170-4: Add support for calibration gain
  iio: adc: ad4170-4: Add support for calibration bias
  Documentation: ABI: IIO: Add sinc5+avg to the filter_type_available
    list
  iio: adc: ad4170-4: Add digital filter and sample frequency config
    support
  iio: adc: ad4170-4: Add support for buffered data capture
  iio: adc: ad4170-4: Add clock provider support
  iio: adc: ad4170-4: Add GPIO controller support
  iio: adc: ad4170-4: Add support for internal temperature sensor
  iio: adc: ad4170-4: Add support for weigh scale and RTD sensors
  iio: adc: ad4170-4: Add timestamp channel

 Documentation/ABI/testing/sysfs-bus-iio       |    1 +
 .../bindings/iio/adc/adi,ad4170-4.yaml        |  555 +++
 MAINTAINERS                                   |    8 +
 drivers/iio/adc/Kconfig                       |   16 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ad4170-4.c                    | 3020 +++++++++++++++++
 6 files changed, 3601 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170-4.yaml
 create mode 100644 drivers/iio/adc/ad4170-4.c


base-commit: 42498420746a4db923f03d048a0ebc9bd2371f56
-- 
2.47.2


