Return-Path: <linux-iio+bounces-17957-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E01F1A8626C
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 17:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26D74C138B
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 15:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812D0213E81;
	Fri, 11 Apr 2025 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0N8ZaVrY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFD0211711;
	Fri, 11 Apr 2025 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744386993; cv=none; b=pu5k0Z9iqBXdcLZMkuIywcIe96SGuFdURgmNdltIpaaGmZKPp64DCTyR/IiLohsSGI6rLqLQvTlHmmLbBoawcFQbf9Bgkn1WH3v7j4TF0n/NZkvklLF4PiaswcWPBAUnD3b7/kRay90pPpSeIiGflQxIdy4Tht4iKkWttHSqVjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744386993; c=relaxed/simple;
	bh=Cch5sGaTT2+F0YWxSz4AB3xkKvujbKcwFLNV1deiUUc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qcSd5iFQERlzwjSVmrydlSEOLHKKSmXTlGxUGeiKUDUzhf882aXrvbpziQLxYQE0P2iVCKDMU1b4e68GKS/p8r70E6EebzvIzSzSN1FpU1IkYUOymaDMobbRZDdka3mN/vuVkvS4B4c5E+tmIfoS0z4ty7tXGwFfjVEhlGBh1eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0N8ZaVrY; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BEoVFc001831;
	Fri, 11 Apr 2025 11:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=j9xtUhdGhdkE8EyjBRJ/O22T4tN
	Jah4ogLXZDU/tV8I=; b=0N8ZaVrYTbMppqCdcHAjAO9gFTUr2A1L47TKpQd3d4i
	AePqVJkYStxGOpnI1cv1YFWGxsNv+Urkugs1IINWQebb0e31co/xiG1mk3UpnBC6
	Bu9S6JJO1WjXK5XcZJW3bAbJoK+98iX7Kwr5CGy9ipdCZd/j5PNpm7NT8R50Unhb
	2iuPRsK7W/vfJGVbDGQF+cQxG7rIGvS/S3WGB0MyfiBnAnNTJjyPomk3DtA2L6+F
	/rZ8iyxti7UQIpv9ysyaOeswrv9wdfMCRVpDsq59TWluBBrHnJlGgPQywvsY8JiR
	uZo2Ivcz0z5qKl1dDqaM/05a2+6zYeHbYyMktn4OVhQ==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45x8yp16tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 11:56:12 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53BFuBFr022161
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 11:56:11 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 11 Apr 2025 11:56:11 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 11 Apr 2025 11:56:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 11 Apr 2025 11:56:11 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53BFtqcs015425;
	Fri, 11 Apr 2025 11:55:54 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <nuno.sa@analog.com>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <jonath4nns@gmail.com>, <dlechner@baylibre.com>
Subject: [PATCH v5 00/14] iio: adc: ad7768-1: Add features, improvements, and fixes
Date: Fri, 11 Apr 2025 12:55:51 -0300
Message-ID: <cover.1744325346.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 1V0-SBfQHb1mGgX1etPvE0AWIn-r8FTk
X-Authority-Analysis: v=2.4 cv=BoqdwZX5 c=1 sm=1 tr=0 ts=67f93b9c cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=AKSQIOYSF6qBGy93K6UA:9
X-Proofpoint-GUID: 1V0-SBfQHb1mGgX1etPvE0AWIn-r8FTk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110101

This patch series introduces some new features, improvements,
and fixes for the AD7768-1 ADC driver. 

The goal is to support all key functionalities listed in the device
datasheet, including filter mode selection, common mode voltage output
configuration and GPIO support. Additionally, this includes fixes 
for SPI communication and for IIO interface, and also code improvements
to enhance maintainability and readability.

---
Changes in v5:
* Added gpio-trigger binding patch.
* Include START pin and DRDY in the trigger-sources description.
* increased trigger-source-cells to 1: this cell will define the trigger
  source type.
* Fixed the holes in the regmap ranges.
* replace old iio_device_claim_direct_mode() for the new 
  iio_device_claim/release_direct() functions.
* Changed some commit messages.
* Link to v4: https://lore.kernel.org/linux-iio/cover.1741268122.git.Jonathan.Santos@analog.com/T/#t

Changes in v4:
* Added missing `select REGMAP_SPI` and `select REGULATOR` to the device's Kconfig.
* VCM output regulator property renamed.
* Added direct mode conditional locks to regulator controller callbacks.
* Renamed regulator controller.
* Created helper function to precalculate the sampling frequency table and avoid
  race conditions.
* Link to v3: https://lore.kernel.org/linux-iio/cover.1739368121.git.Jonathan.Santos@analog.com/T/#t

Changes in v3:
* Fixed irregular or missing SoBs.
* Moved MOSI idle state patch to the start of the patch, as the other fix.
* fixed dt-binding errors.
* Trigger-sources is handled in a different way, as an alternative to sync-in-gpio.
  (this way we avoid breaking old applications).
* VCM output is controlled by the regulator framework.
* Added a second regmap for 24-bit register values.
* Add new preparatory patch replacing the manual attribute declarations for
  the read_avail from struct iio_info.
* included sinc3+rej60 filter type.
* Addressed review comments, see individual pacthes.
* Link to v2: https://lore.kernel.org/linux-iio/cover.1737985435.git.Jonathan.Santos@analog.com/T/#u

Changes in v2:
* Removed synchronization over SPI property and replaced it for trigger-sources.
* Added GPIO controller documentation.
* VCM output control changed from an IIO attribute to a devicetree property (static value).
* Converted driver to use regmap and dropped spi_read_reg and spi_write_reg pacthes.
* replaced decimation_rate attribute for oversampling_ratio and dropped device specific documentation patch.
* Added low pass -3dB cutoff attribute.
* Addressed review comments, see individual pacthes.
* Link to v1: https://lore.kernel.org/linux-iio/cover.1736201898.git.Jonathan.Santos@analog.com/T/#t

Jonathan Santos (11):
  dt-bindings: trigger-source: add generic GPIO trigger source
  dt-bindings: iio: adc: ad7768-1: add trigger-sources property
  dt-bindings: iio: adc: ad7768-1: Document GPIO controller
  dt-bindings: iio: adc: ad7768-1: document regulator provider property
  iio: adc: ad7768-1: convert driver to use regmap
  iio: adc: ad7768-1: add regulator to control VCM output
  iio: adc: ad7768-1: add multiple scan types to support 16-bits mode
  iio: adc: ad7768-1: add support for Synchronization over SPI
  iio: adc: ad7768-1: replace manual attribute declaration
  iio: adc: ad7768-1: add filter type and oversampling ratio attributes
  iio: adc: ad7768-1: add low pass -3dB cutoff attribute

Sergiu Cuciurean (3):
  iio: adc: ad7768-1: Add reset gpio
  iio: adc: ad7768-1: Move buffer allocation to a separate function
  iio: adc: ad7768-1: Add GPIO controller support

 .../bindings/iio/adc/adi,ad7768-1.yaml        |   67 +-
 .../bindings/trigger-source/gpio-trigger.yaml |   40 +
 drivers/iio/adc/Kconfig                       |    2 +
 drivers/iio/adc/ad7768-1.c                    | 1105 ++++++++++++++---
 4 files changed, 1040 insertions(+), 174 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml


base-commit: 5d1a5c4f121f0ec50327e899c9450978505f1560
prerequisite-patch-id: 933ca5331b0044084f60cba5f9019663e01fa9c2
-- 
2.34.1


