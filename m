Return-Path: <linux-iio+bounces-7059-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B9991CEA7
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 21:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2351C20B85
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 19:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD47136665;
	Sat, 29 Jun 2024 19:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="NNMWX/Xy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C8739ADD;
	Sat, 29 Jun 2024 19:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719687892; cv=none; b=QHVrrMl2bVBMhH1C0g0etDInhWo4zUUJzTdTuhh+wfxZpMffqpuZrjtWiz/iBQCNB8XqYzpy5gWKbfpne0bxHXxo36QmkLw8bWOrgF9exwSWQjPu8T90os9mZ1kjVn272t6mETtFo5azPF7EYnVV/3dXe8Qb9wzgvVp/pKbsmdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719687892; c=relaxed/simple;
	bh=M7245ErFBTK3qum1BE1BUj/k6Xbrk55q6Nk2C3zvNuo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gisH1lYZxDQSTVXsC4ABHvmM9OUrOpkHeFKUQwbOkQMnMI+4MoLcvQUxn5kpbXq2VhVX4sllNrsLHwCO2TbnH9h/6nTYLfkZaI2UD0ajGp/t4oseNx3Cf8HfXMwz2LnBA2IQ4hRbQjqIoCBaWf9NCKvcqd4kBaty4QnSp5P+fpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=NNMWX/Xy; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45T92kK9003733;
	Sat, 29 Jun 2024 15:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=gamZLFnG9GA8frpgD48IAV4Glyb
	BrXa18lHHkbZdurA=; b=NNMWX/XyktxeM+mQukB4MbucfS8gkyFVnxTU6Oyk2aA
	e2ignlq+Tzvhm8M0l/8J5RKjLHoCN4liMhaPp1fnYC4euUy9rIz0pnsVBpRExCZs
	U9fH4vFAod1WdJChIlAqS2ZjgrjzG6e7PZsrfHoc/+vW74jBxF0w/2U1ea2Zo/ah
	Lq9moLhg4u6ekLpFXnGyY1WHlOtZj7Ev/TGDk2twTBozDXRcbbstOCpNxyn7mFT1
	44whcR22tqFqJr3Zq7UOjNAW/LrVwF8iK0/UNuWJfX9KiZsnrN6z094BMiTBUzge
	LDp2iSolss/BOif9DX++9CF9sjxGLovEvQhh/pV3JIw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 402f9u0yj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 15:04:26 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 45TJ4PLK046781
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 29 Jun 2024 15:04:25 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sat, 29 Jun 2024 15:04:24 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sat, 29 Jun 2024 15:04:24 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sat, 29 Jun 2024 15:04:24 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45TJ44sv001311;
	Sat, 29 Jun 2024 15:04:06 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nuno.sa@analog.com>, <dlechner@baylibre.com>, <corbet@lwn.net>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 0/7] Add support for AD4000 series of ADCs
Date: Sat, 29 Jun 2024 16:04:00 -0300
Message-ID: <cover.1719686465.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-ORIG-GUID: SwvAbGBDWYH4XCukG3yiExQUdF1xA1Zk
X-Proofpoint-GUID: SwvAbGBDWYH4XCukG3yiExQUdF1xA1Zk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-29_08,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406290138

This patch series extends the SPI bitbang, gpio, and spi-engine controllers to
support configurable MOSI line idle states.
It then introduces the ad4000 driver which uses the MOSI idle configuration to
provide improved support for the AD4000 series of ADCs.
Documentation is added describing the new extension to the SPI protocol.
The currently supported wiring modes for AD4000 devices were documented under
IIO documentation directory.

To apply this series, it requires the patches for SPI-Engine SPI_CS_HIGH feature
and the patches for devm_spi_optimize_message() helper.

89c2657429c4822a2697077bbb3a8d126d826ced "spi: axi-spi-engine: remove platform_set_drvdata()"
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?h=for-6.11&id=89c2657429c4822a2697077bbb3a8d126d826ced

7e74a45c7afdd8a9f82d14fd79ae0383bbaaed1e "spi: add EXPORT_SYMBOL_GPL(devm_spi_optimize_message)"
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?h=for-6.11&id=7e74a45c7afdd8a9f82d14fd79ae0383bbaaed1e

d4a0055fdc22381fa256e345095e88d134e354c5 "spi: add devm_spi_optimize_message() helper"
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?h=for-6.11&id=d4a0055fdc22381fa256e345095e88d134e354c5

6ecdb0aa4dca62d236a659426e11e6cf302e8f18 "spi: axi-spi-engine: Add SPI_CS_HIGH support"
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?h=for-6.11&id=6ecdb0aa4dca62d236a659426e11e6cf302e8f18

Change log v5 -> v6:
[SPI]
spi.h: Removed unused SPI_CONTROLLER_MOSI_IDLE_LOW and SPI_CONTROLLER_MOSI_IDLE_HIGH
spi-summay: Minor nit: inactive -> not asserted
spi-engine: Moved MOSI idle support check to IP core version check section
[IIO]
ad4000: Fixed ad4000_read_reg(). *val = st->tx_buf[1]; -> *val = st->rx_buf[1];
ad4000: Use devm_regulator_bulk_get_enable()
ad4000: Use iio_device_claim_direct_scoped() and guard() to protect scale update
ad4000: Fail probe if ad4000_config() fail
ad4000: Moved ad4000_prepare_..._message() closer to probe to reduce scope
ad4000: Added AD4000_SDI_GND and switch case for more accurate error msg
ad4000: Removed unused st->turbo_mode
ad4000: Removed old misleading comments in enum ad4000_sdi
ad4000: A few minor readability and code style nits

Link to v5: https://lore.kernel.org/linux-iio/cover.1719351923.git.marcelo.schmitt@analog.com/
Link to v4: https://lore.kernel.org/linux-iio/cover.1718749981.git.marcelo.schmitt@analog.com/
Link to v3: https://lore.kernel.org/linux-iio/cover.1717539384.git.marcelo.schmitt@analog.com/
Link to v2: https://lore.kernel.org/linux-iio/cover.1712585500.git.marcelo.schmitt@analog.com/
Link to v1: https://lore.kernel.org/linux-iio/cover.1711131830.git.marcelo.schmitt@analog.com/

Regard using spi_w8r8(), I tried it again and it doesn't work for ad4000.
Looks like the smallest transfer size for these devices is 16-bit.
From datasheets:
"The AD4000/AD4004/AD4008 configuration register is read from and written to
with a 16-bit SPI instruction."

Regarding the sample buffer size, I'm keeping it 32-bits long following
suggestion from Nuno and due to a bit of laziness from my side to re-test it.
Will change if required.

Thank you to everybody who reviewed these patches. I appreciate your support.

Thanks,
Marcelo

Marcelo Schmitt (7):
  spi: Enable controllers to extend the SPI protocol with MOSI idle
    configuration
  spi: bitbang: Implement support for MOSI idle state configuration
  spi: spi-gpio: Add support for MOSI idle state configuration
  spi: spi-axi-spi-engine: Add support for MOSI idle configuration
  dt-bindings: iio: adc: Add AD4000
  iio: adc: Add support for AD4000
  docs: iio: Add documentation for AD4000

 .../bindings/iio/adc/adi,ad4000.yaml          | 197 +++++
 Documentation/iio/ad4000.rst                  | 131 ++++
 Documentation/iio/index.rst                   |   1 +
 Documentation/spi/spi-summary.rst             |  83 ++
 MAINTAINERS                                   |   9 +
 drivers/iio/adc/Kconfig                       |  12 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad4000.c                      | 708 ++++++++++++++++++
 drivers/spi/spi-axi-spi-engine.c              |  15 +-
 drivers/spi/spi-bitbang.c                     |  24 +
 drivers/spi/spi-gpio.c                        |  12 +-
 drivers/spi/spi.c                             |   7 +
 include/linux/spi/spi_bitbang.h               |   1 +
 include/uapi/linux/spi/spi.h                  |   5 +-
 14 files changed, 1200 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
 create mode 100644 Documentation/iio/ad4000.rst
 create mode 100644 drivers/iio/adc/ad4000.c

-- 
2.43.0


