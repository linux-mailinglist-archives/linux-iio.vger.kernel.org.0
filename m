Return-Path: <linux-iio+bounces-7565-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 440AE9300CA
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 21:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A2E1C21238
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 19:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A092282F4;
	Fri, 12 Jul 2024 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FyTVNHU1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8C21B95B;
	Fri, 12 Jul 2024 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720812055; cv=none; b=Ze6VLhc7c817nm+Zw2e+bd4bgkqsLYMPWDVoB+Ql7mKWEkk/8tfiCO/6I3Arj7Zl0j/tX+LoP5wdos5BXTubvOE8jshyrGWM1cPs2DfsDPuGPeNNFbmR/gqYvJPUZFTU5XAUqJ4GdLVycrm2eU8N1/6mCLgFARU9vtXmRDxNk2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720812055; c=relaxed/simple;
	bh=THUpWrDo0OgbU7slolZtvkJhZMQ17aaiYCWO3LnLLlU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=beso7kx72qbmoXEPux/2hbYgW/pZi/PrWOGDnTP/wHLu1ExrmITSnNAmKotY1SUYHMsqA/vlrgUhOt/GnzLJxnlWsUygTFnOvZvpOIYLIZ1E3Dg+iCFpnW4l/K/hoIp8UD+/uu0/89pyf9GZOYf17G1rDuHXA8I1f7WoZCTw6bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FyTVNHU1; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CHYOpY007162;
	Fri, 12 Jul 2024 15:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=lab2yG3e1sxorMpsMsndwrtH7zQ
	aZ6/VGdPmhlRQiZQ=; b=FyTVNHU1a7oD+ZJn98wYKUTvJwTXy7l2ft0/dMmljHY
	5Uc1mtBaN3cpCldj5PbueUoUChE288ASr8LexSD3gCcIVc6zmF9eb6DJwYNxG5AD
	jcNV4eVgbqNlJWkQhtWpV4svfkx7nvZm7U36cceAwi8wIS0wqFOxLbCuNTL+xKJd
	zVuoLpq72Aj3CR3Gq/A+nEvuYXMJAY8FqF/9cUJ/Fy304AZlI6w+kNL3TP+5v5gc
	Jjc0dH06siMZ4YP8kHrUhMuC/Te60LCzd8PKfXcQGWhCJEVkd4UITVW+2zdMBCo8
	wuIDaaJzu7lgWL79SEbJ2wbOI5wHm7yzgrbpMw4uzLA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 40b2qp1gwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 15:20:22 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 46CJKLbt009408
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Jul 2024 15:20:21 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 12 Jul
 2024 15:20:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 12 Jul 2024 15:20:20 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46CJK2GH004274;
	Fri, 12 Jul 2024 15:20:05 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nuno.sa@analog.com>, <dlechner@baylibre.com>, <corbet@lwn.net>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 0/7] Add support for AD4000 series of ADCs
Date: Fri, 12 Jul 2024 16:20:00 -0300
Message-ID: <cover.1720810545.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-GUID: U4OmiQgC8yJToMuAcb4mHxqhycM2WacO
X-Proofpoint-ORIG-GUID: U4OmiQgC8yJToMuAcb4mHxqhycM2WacO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_15,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407120130

This patch series extends the SPI bitbang, gpio, and spi-engine controllers to
support configurable MOSI line idle states.
It then introduces the ad4000 driver which uses the MOSI idle configuration to
provide improved support for the AD4000 series of ADCs.
Documentation is added describing the new extension to the SPI protocol.
The currently supported wiring modes for AD4000 devices were documented under
IIO documentation directory.

Change log v6 -> v7:
[Device tree]
No changes to device tree from v6 to v7.
[SPI]
spi.c: Removed blank line added in code not related to MOSI idle feature.
spi: bitbang: Rewrapped commit message.
spi: bitbang: Rebased bitbang patch on top of spi for-next branch.
[IIO]
ad4000: Checked gain-milli read from dt and made it match one of supported gains or fail.
ad4000: Added blank lines to improve code readability.
ad4000: return 0; when known that no errors occurred.

Link to v6: https://lore.kernel.org/linux-iio/cover.1719686465.git.marcelo.schmitt@analog.com/
Link to v5: https://lore.kernel.org/linux-iio/cover.1719351923.git.marcelo.schmitt@analog.com/
Link to v4: https://lore.kernel.org/linux-iio/cover.1718749981.git.marcelo.schmitt@analog.com/
Link to v3: https://lore.kernel.org/linux-iio/cover.1717539384.git.marcelo.schmitt@analog.com/
Link to v2: https://lore.kernel.org/linux-iio/cover.1712585500.git.marcelo.schmitt@analog.com/
Link to v1: https://lore.kernel.org/linux-iio/cover.1711131830.git.marcelo.schmitt@analog.com/


Prerequisite patches to apply this series to IIO testing branch:

c3358a746e078d0f9048732c90fdab4f37c00e0d "spi: bitbang: Convert unsigned to unsigned int"
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?id=c3358a746e078d0f9048732c90fdab4f37c00e0d

f261172d39f358dcecce13c310690d3937e0cca6 "spi: bitbang: Use typedef for txrx_*() callbacks"
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?id=f261172d39f358dcecce13c310690d3937e0cca6

6ecdb0aa4dca62d236a659426e11e6cf302e8f18 "spi: axi-spi-engine: Add SPI_CS_HIGH support"
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?h=for-6.11&id=6ecdb0aa4dca62d236a659426e11e6cf302e8f18


Prerequisite patches to apply the series to SPI for-next brach:

ef60f9ca26d33d0f8e1a709771c61d3e96f64559 "docs: iio: add documentation for adis16480 driver"
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=ef60f9ca26d33d0f8e1a709771c61d3e96f64559


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
  Documentation: Add AD4000 documentation

 .../bindings/iio/adc/adi,ad4000.yaml          | 197 +++++
 Documentation/iio/ad4000.rst                  | 131 ++++
 Documentation/iio/index.rst                   |   1 +
 Documentation/spi/spi-summary.rst             |  83 ++
 MAINTAINERS                                   |   9 +
 drivers/iio/adc/Kconfig                       |  12 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad4000.c                      | 722 ++++++++++++++++++
 drivers/spi/spi-axi-spi-engine.c              |  15 +-
 drivers/spi/spi-bitbang.c                     |  24 +
 drivers/spi/spi-gpio.c                        |  12 +-
 drivers/spi/spi.c                             |   6 +
 include/linux/spi/spi_bitbang.h               |   1 +
 include/uapi/linux/spi/spi.h                  |   5 +-
 14 files changed, 1213 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
 create mode 100644 Documentation/iio/ad4000.rst
 create mode 100644 drivers/iio/adc/ad4000.c


base-commit: 986da024b99a72e64f6bdb3f3f0e52af024b1f50
prerequisite-patch-id: 76a35c35c2af889be2ff20052da02df561b3d71b
prerequisite-patch-id: ce5abb83d4f04e72c69d0df4ded79077065cd649
prerequisite-patch-id: b30f54a92e47dbad33ca7450089c7b19610e9cf2
-- 
2.43.0


