Return-Path: <linux-iio+bounces-6922-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9DF9173B6
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 23:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A387B1F21EEC
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 21:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F016817DE33;
	Tue, 25 Jun 2024 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="iaZBMkWI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03C3143C49;
	Tue, 25 Jun 2024 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719352375; cv=none; b=JrzKkxtlm0QkGBsOgMcxFdRVLsqakApttmZcsm0GrQ/KBKXc3cLHdqEVVFMh/XW9LtT9UO6YWTQ4H9RswIf3fzbG5qoO+S2DDzPD7FYeNP7UpyHk67wK6qBL30y0QIq8Xb/9zCV4T4ru8mldgOr0J0OAiu031PZCwQns0zkwFgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719352375; c=relaxed/simple;
	bh=vsN9BKR6ClmgoRiQPXOQ9Fm5oFYvwZInU8pcdCZNoYE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bfnz78zfiyOIriqLE+qiKQMXd9xU5b28DpVPUnl0B5kvNa/YkRNIh8qFM37dDaAvjzd+5+QpXRw4G9d64sA3FbsVRn5cmd7+gscllW2P4iFSFhhMV2YMkYYQ/Ufe0JhMXY26GXh6W5RbolBET/5E5Sl92eMvBBvwnBBkpPDN/PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=iaZBMkWI; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PFhgL9031230;
	Tue, 25 Jun 2024 17:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=qUEsXlk5wwQ2gjFGWM2dsUa7eWk
	M4vfMapNl0DPbm3E=; b=iaZBMkWIfZZLxFUcGtfp1IrIKfB97+wn6ct2XSEpI5r
	/dgVwjZYV5ePMEsit3tlo6q35SmEzyKkEi6Pob8QEgGeTJBvBqykz/Be6h5+FK2Y
	wFClqh4WRSEFMp9HKVAis3y1h4yIdVq81SzyuP8RR0oL1YXvERCnX586qsKOH5HV
	p6UKxaIHk1m2CaZuT9rLwlQroP0eHb8hFw4shDzTAGZ1uWdL2puGS9TazpFhob/b
	4SLjlC1xh+M5V/aGhCcLa4IkWoX1AKCerL6mHNOcCjbMaQBqMPU6ck5mNkCZY36i
	gTpnV5LatK7BIElgipvUSjIiWfDsCL7kx8s3zq1AA4w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ywuh2m72e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 17:52:36 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 45PLqZeB006868
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Jun 2024 17:52:35 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 25 Jun 2024 17:52:34 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 25 Jun 2024 17:52:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 25 Jun 2024 17:52:34 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45PLq4WC013785;
	Tue, 25 Jun 2024 17:52:11 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nuno.sa@analog.com>, <dlechner@baylibre.com>, <corbet@lwn.net>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/7] Add support for AD4000 series of ADCs
Date: Tue, 25 Jun 2024 18:52:00 -0300
Message-ID: <cover.1719351923.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-GUID: RshEAHXam6ookfaQviYsBKdgQh6Y5czL
X-Proofpoint-ORIG-GUID: RshEAHXam6ookfaQviYsBKdgQh6Y5czL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_17,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406250162

This patch series extends the SPI bitbang, gpio, and spi-engine controllers to
support configurable MOSI line idle states.
It then introduces the ad4000 driver which uses the MOSI idle configuration to
provide improved support for the AD4000 series of ADCs.
Documentation is added describing the new extension to the SPI protocol.
The currently supported wiring modes for AD4000 devices were documented under
IIO documentation directory.

Change log v4 -> v5:

[SPI]
- spi: Fixed spi_setup() not failing if controller doesn't support requested MOSI config.
- spi-summary: CS active -> CS asserted; use of `` to highlight code elements.
- spi: spi-engine: renamed SPI_ENGINE_CONFIG_SDO_IDLE -> SPI_ENGINE_CONFIG_SDO_IDLE_HIGH.
[Device tree]
- Added missing compatibles for ADAQ4001 and ADAQ4003.
- Removed example comments.
- Split adi,spi-mode property into adi,sdi-pin and adi,cnv-pin properties.
- Updated property constraints.
[IIO]
- ad4000: Reviewed includes.
- ad4000: Fixed devm_regulator_get_enable_read_voltage() usage.
- ad4000: Used local lock to protect scale change read modify write cycle.
- ad4000: renamed _3wire -> _reg_access; three_w_chan_spec -> reg_access_chan_spec.
- ad4000: Use u8 tx_buf[2] and u8 rx_buf[2] for reg access transfers.
- ad4000: Simplified dt property read.
- ad4000: Use sample >>= chan->scan_type.shift;
- ad4000: Use devm_spi_optimize_message().
- ad4000: Improvement to macros.
[Documentation]
- [New patch] iio: Added documentation for AD4000 describing wiring connection modes.

Link to v4: https://lore.kernel.org/linux-iio/cover.1718749981.git.marcelo.schmitt@analog.com/
Link to v3: https://lore.kernel.org/linux-iio/cover.1717539384.git.marcelo.schmitt@analog.com/
Link to v2: https://lore.kernel.org/linux-iio/cover.1712585500.git.marcelo.schmitt@analog.com/
Link to v1: https://lore.kernel.org/linux-iio/cover.1711131830.git.marcelo.schmitt@analog.com/

I believe to have made everything suggested in v4, except for the following:

- Use of spi_w8r8().
I tried that but then the values I got from reg read alternated between 0x65 and
0xFF (sometimes 0x00).
I didn't find out why so I kept with spi_sync_transfer().
May investigate it better if re-spinning.

- Reducing sample buffer size
I agree we may save some memory reducing the sample buffer size from 32 to 24 bits.
I will probably use get_unaligned_be24() to get the data back but will have to
declare sample buffers as arrays. It was very tricky to get the buffer
declarations correct the first time and I didn't want to take much longer to
provide a v5.
May do it for v6 if re-spinning.


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

 .../bindings/iio/adc/adi,ad4000.yaml          | 190 +++++
 Documentation/iio/ad4000.rst                  | 131 ++++
 Documentation/iio/index.rst                   |   1 +
 Documentation/spi/spi-summary.rst             |  83 ++
 MAINTAINERS                                   |   9 +
 drivers/iio/adc/Kconfig                       |  12 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad4000.c                      | 711 ++++++++++++++++++
 drivers/spi/spi-axi-spi-engine.c              |   8 +
 drivers/spi/spi-bitbang.c                     |  24 +
 drivers/spi/spi-gpio.c                        |  12 +-
 drivers/spi/spi.c                             |   7 +
 include/linux/spi/spi.h                       |   6 +
 include/linux/spi/spi_bitbang.h               |   1 +
 include/uapi/linux/spi/spi.h                  |   5 +-
 15 files changed, 1198 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
 create mode 100644 Documentation/iio/ad4000.rst
 create mode 100644 drivers/iio/adc/ad4000.c

-- 
2.43.0


