Return-Path: <linux-iio+bounces-6536-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C89BC90DF99
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 01:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6AE11C2247E
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 23:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32538180A99;
	Tue, 18 Jun 2024 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZW3SbKez"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD8F14D44D;
	Tue, 18 Jun 2024 23:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718752244; cv=none; b=ut5+OD2ED2MJkOGae+S5dukVwqqe9Lc05meeiY1pYnCWIHYyhimUKCQP1T3rKgIhOwARsBsnAkKxmU5VQLSNmN0FXUyHlXmN0GHDV7vXeKwuv3dMC6miLPO5Ffw/J3cMWdPM1AxOJ/S+GqBdUM39RSuq5d91bkpoBoY0U71DCUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718752244; c=relaxed/simple;
	bh=ZYdStGFd3utereEsSYiaVDaHMRfhLIco0X94W92XqXc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ekuV16ewnQLEwVYiFPwyQTaAObuPdHwjVexD7PRKuuSWOG1S7imsBe4NTXzs9abw25GftL3OruUHOGi5Ff8ygmRzZQelGqGJWOciT0RuGRqmv0jSy4x0+uX1S4JOqPBfurs6EfGetcxxxITIZGIhrTEdlgR2rEzOGmznF/h0h38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZW3SbKez; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILXenJ028414;
	Tue, 18 Jun 2024 19:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=GJKMkDLc5zy/PiUEj3DuN/xa3kY
	P87c6xBFdrTOetcA=; b=ZW3SbKezReWHrOhcUBOI/TAXUCXjqS+TUCHziApkV6x
	nbsjhN0s44Gr/E2q0e8TOgHEfJHfa4KM2YH2F1sDx9l6BAhgIjwNvWvPA7R/TTnq
	vduFv7irrB9rHNcDPuaeu9dH1zbSzFNFhkz3MSs9iyKmNpe+EMqYrMd+MOi7NRhM
	Ly+WwYFuLPtiATYfAnxG19kFKFXvFCfCMNfvwaG0SyrnBtt16Mm3TnbkbsDHCXlQ
	/Y2HQCSbbzVsrWQoL77GocD5QwxpbLfWpxOmt0UYf6Vf+oWvdPfo03AIYqBWZatb
	UK58H7PIeKDWIjspdXjz6cTEHS9qMtLIxDaQxd41OYg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3yuj8s87t1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 19:10:25 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 45INAOwl005792
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Jun 2024 19:10:24 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 18 Jun 2024 19:10:23 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 18 Jun 2024 19:10:23 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 18 Jun 2024 19:10:23 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45INA9Ix021723;
	Tue, 18 Jun 2024 19:10:12 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/6] Add support for AD4000 series of ADCs
Date: Tue, 18 Jun 2024 20:10:07 -0300
Message-ID: <cover.1718749981.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 1nEfj8sg0fTbDmMrapqCAQmpmbzLM_Ct
X-Proofpoint-ORIG-GUID: 1nEfj8sg0fTbDmMrapqCAQmpmbzLM_Ct
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_06,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180169

This patch series extends the SPI bitbang, gpio, and spi-engine controllers to
support configurable MOSI line idle state.
It then introduces the ad4000 driver which uses the MOSI idle configuration to
properly support AD4000 series of ADCs.

Change log v3 -> v4:

[SPI]
- spi: Added documentation for the MOSI idle configuration.
- spi: spi_setup() now fails on improper MOSI idle state configuration.
- spi: spi_setup() now fails if controller doesn't support requested MOSI config.
- spi: spi-engine: Only set MOSI idle mode bits if spi-engine version supports it.
[Device tree]
- dt: Made grouped compatible strings for devices that are similar to each other.
- dt: Updated dt-bindings to constrain properties that depend on reg access to
  "3-wire" mode only.
- dt: adi,gain-milli is now a 16-bit device tree property.
[IIO/ADC]
- ad4000: Used devm_regulator_get_enable_read_voltage() for ref regulator.
- ad4000: Tweaked gpiod_set_value comment explaining what happens when CNV GPIO is
  defined and when it is not.
- ad4000: Device configuration register write will now only happen if device is
  connected in a mode that allows register access.
- ad4000: scale attribute now only writeable if device connection allows user to
  change the scale.
- ad4000: scale_available attribute now is only visible if scale is writeable.
- ad4000: many minor changes.


Link to v3: https://lore.kernel.org/linux-iio/cover.1717539384.git.marcelo.schmitt@analog.com/
Link to v2: https://lore.kernel.org/linux-iio/cover.1712585500.git.marcelo.schmitt@analog.com/
Link to v1: https://lore.kernel.org/linux-iio/cover.1711131830.git.marcelo.schmitt@analog.com/

Thanks,
Marcelo

Marcelo Schmitt (6):
  spi: Enable controllers to extend the SPI protocol with MOSI idle
    configuration
  spi: bitbang: Implement support for MOSI idle state configuration
  spi: spi-gpio: Add support for MOSI idle state configuration
  spi: spi-axi-spi-engine: Add support for MOSI idle configuration
  dt-bindings: iio: adc: Add AD4000
  iio: adc: Add support for AD4000

 .../bindings/iio/adc/adi,ad4000.yaml          | 231 ++++++
 Documentation/spi/spi-summary.rst             |  83 ++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  12 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad4000.c                      | 715 ++++++++++++++++++
 drivers/spi/spi-axi-spi-engine.c              |   8 +
 drivers/spi/spi-bitbang.c                     |  24 +
 drivers/spi/spi-gpio.c                        |  12 +-
 drivers/spi/spi.c                             |   9 +-
 include/linux/spi/spi.h                       |   6 +
 include/linux/spi/spi_bitbang.h               |   1 +
 include/uapi/linux/spi/spi.h                  |   5 +-
 13 files changed, 1111 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
 create mode 100644 drivers/iio/adc/ad4000.c

-- 
2.43.0


