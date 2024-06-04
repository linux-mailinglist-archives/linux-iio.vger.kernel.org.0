Return-Path: <linux-iio+bounces-5788-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076EE8FBF20
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 00:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBD302851D2
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 22:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E468614B97D;
	Tue,  4 Jun 2024 22:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="PA86CCzy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A94614B06E;
	Tue,  4 Jun 2024 22:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540910; cv=none; b=R3f0psrtJ00XxF2VQLP8JkiAc/JLHQAUzC/ropmkkvJhF2TVTTwyz8wfN9d5+LJ3/5nBRk9NTLQ7mBW9avqlJn5fO8SpTuwo8/AZpX/68e1GZ8nPLCQiEizUO1ADX1kkpYkSl3KfZpbVFkbbFmRweBrMs/I7GyJQwEQHi7XJVZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540910; c=relaxed/simple;
	bh=yuZKQqpqmxwyDNVBJjjuic8k9T9N0zt4jUtnRywhVyc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oRS2BUWFt2PdDmRbLdTZHuEymq0twOh45Ba7g/oA6Ls1/2Q3ZycE9m7UYsQYym8N5/PXs9Yjx6SqkHqP1RSCeyfTxOushqa5gFJ3r3PQ2YsxMBYJj+qxRmhl4t0TP6bvkUAtPBEQqidBvjWI54r1MDE/+lFMa2/S3IgPqLK9FCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=PA86CCzy; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454K0N3h015061;
	Tue, 4 Jun 2024 18:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=oN/4JX8Lx+3D+bSydBJVahix/UU
	ZEC7PQQ+hSFktC6s=; b=PA86CCzyBgCEQe3fZc8lagO2sj8wnAxiCo9NDWIvJho
	i6FZwRTYQZLjtx0rM97YzUjfMEtSN16KGRtVM6EJq1ClYlv3HSIwm4jB9zVKNcOJ
	Wr869cMbZCuvi2CCAqGmowx8mpd5KzYcTsSxLatZZFubG1/GCSaxJNNVQy/iDGHe
	w2cWKdPu96rGVqZf5srfvLVhIETRG8/9vL5NgnleqtXRnnRcqJ/5e6C14gzJj3VO
	ftf2Gvvh8iMwh90NnFs+kvpOXytriijscTJ4AEGLW5RoTjZ16qHj+xeVqg0QQ06Y
	3bytcuAIEQVKnI2DC9hso/VrDEXddC0CE9lUpS/I7bw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3yj0hvakj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 18:41:20 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 454MfJPB010856
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 18:41:19 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 4 Jun 2024
 18:41:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 4 Jun 2024 18:41:18 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 454Mf2xc001165;
	Tue, 4 Jun 2024 18:41:05 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/6] Add support for AD4000 series of ADCs
Date: Tue, 4 Jun 2024 19:40:56 -0300
Message-ID: <cover.1717539384.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-GUID: MUO5teRQRbHDdxsS36D6OaO3q_CZLHlq
X-Proofpoint-ORIG-GUID: MUO5teRQRbHDdxsS36D6OaO3q_CZLHlq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=974
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406040183

This patch series extends the SPI bitbang, gpio, and spi-engine controllers to
support configurable MOSI line idle state.
It then introduces the ad4000 driver which makes use of the MOSI idle
configuration to properly support AD4000 series of ADCs.

Change log v2 -> v3:
- [new patch] Extended SPI modes to allow MOSI idle high configuration.
- [new patch] Implemented configurable MOSI idle state for spi-bitbang controller.
- [new patch] Implemented configurable MOSI idle state for spi-gpio controller.
- [new patch] Implemented configurable MOSI idle state for spi-axi-spi-engine controller.
- Dropped spi-cpha property (these devices communicate in SPI mode 0).
- Added dt-binding check to constrain adi,gain-milli property to ADAQ devices only.
- Device config doesn't enable TURBO anymore to save power.
- Fixed device buffer declaration.
- Simplified ADC input gain handling by keeping gain value from DT.
- Reworked ADC sample read function in "3-wire mode" making it latency free.
- Added ADC sample read function for "4-wire mode".
- Read adi,spi-mode dt prop and use "3-wire" or "4-wire" mode accordingly.
- Many other minor improvements such as better code execution flows and comments.
- Removed Mircea Caprioru from authors. This driver is now completely different
  from what Mircea left in ADI Linux.

I'll leave additional ADC features (e.g. single-ended to differential configuration)
for future patches if no one minds it.

Thanks,
Marcelo

Marcelo Schmitt (6):
  spi: Add SPI mode bit for MOSI idle state configuration
  spi: bitbang: Implement support for MOSI idle state configuration
  spi: spi-gpio: Add support for MOSI idle state configuration
  spi: spi-axi-spi-engine: Add support for MOSI idle configuration
  dt-bindings: iio: adc: Add AD4000
  iio: adc: Add support for AD4000

 .../bindings/iio/adc/adi,ad4000.yaml          | 207 +++++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  12 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad4000.c                      | 735 ++++++++++++++++++
 drivers/spi/spi-axi-spi-engine.c              |   8 +-
 drivers/spi/spi-bitbang.c                     |  24 +
 drivers/spi/spi-gpio.c                        |  12 +-
 drivers/spi/spi.c                             |   6 +
 include/linux/spi/spi_bitbang.h               |   1 +
 include/uapi/linux/spi/spi.h                  |   3 +-
 11 files changed, 1014 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
 create mode 100644 drivers/iio/adc/ad4000.c

-- 
2.43.0


