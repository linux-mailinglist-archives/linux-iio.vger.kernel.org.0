Return-Path: <linux-iio+bounces-16492-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0E3A55800
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 22:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A0537A6EEC
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 21:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3EE20ADCF;
	Thu,  6 Mar 2025 21:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="jyl8fYeX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AAD207E04;
	Thu,  6 Mar 2025 21:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294883; cv=none; b=UVzg1siGNDGAOJC0+7Vog/KdlWtj1Vz53foS91NgU48xaCfu3oDDryeObYqT6tIhre0AC05b7+n0WELCqfWKTi1xZA16OJNskT67Vl3Cyvzr4VvR8sNH9hAetpkpDb8tiTR9sMFtA0FzJHUqJYoiC9jCEM56fP2ttNEfoMHF3qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294883; c=relaxed/simple;
	bh=NlDPOSLI9ZcGj7jD5ktaGo9sbNmgAANX13OGGXnvuPc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E8tnKSbRB4mzZbdUfT+A2XQF1LKEogusLA7TBVHQjlC9qoswp8wA1b1wO95fZ0vlqoRyk7iCbcRqxtA5+TomiYpCwciVf/Ds5ccVar22MoSRvFHq6GiI26We+cipHo9iy9nhyAP9DXq4Ww2k6r4mbhtXtkAe/7dT3y+0wo4lorE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=jyl8fYeX; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526HfcmD031360;
	Thu, 6 Mar 2025 16:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=vukytWQst32XEtZyJvS/dCkd4lu
	uefdu1bzysWOHepo=; b=jyl8fYeXLtCCknZzOmZTEyYqsRX0ahFkpwG2UJpV3LD
	DlHlqX6wYEpRskGAL2w8MFetpae03cSYY8VcJYN+rPlvHWBanlxr8rYrdPXpXAOh
	aMAFZJK2n8Vyitpi19Ip1ijzSFr6WyI3I8hgG+7nS2kSaDNoSPcIPR2A0EXt/Y7t
	DYrXBE+ipbP7c37RWY4SmozPxI3nHuzEe3JBXwgZ6g6Zr0aWAwIW6mR9Xf997n1c
	IuikxlxXQrmfnRwL/3VToVPNcyBOXxHVK4JdHZHTCk5AZ35nLTdi383bDW4iU3sZ
	9CZ4EMAbQpzgZEjGbTIo8Fkdc7aq1Qvf0VAB7qVD92w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 456j6dhkm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 16:01:00 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 526L0Xjd034657
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Mar 2025 16:00:33 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 6 Mar 2025
 16:00:32 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 6 Mar 2025 16:00:32 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 526L0GbK011242;
	Thu, 6 Mar 2025 16:00:18 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <dlechner@baylibre.com>,
        <marcelo.schmitt1@gmail.com>, <jonath4nns@gmail.com>
Subject: [PATCH v4 00/17] iio: adc: ad7768-1: Add features, improvements, and fixes
Date: Thu, 6 Mar 2025 18:00:15 -0300
Message-ID: <cover.1741268122.git.Jonathan.Santos@analog.com>
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
X-Authority-Analysis: v=2.4 cv=R+r5GcRX c=1 sm=1 tr=0 ts=67ca0d0c cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=DcVhKpCQim4X3dEw7YsA:9
X-Proofpoint-ORIG-GUID: PcJ60qQDPMO0FNkS1t1irkG8-68BlBGv
X-Proofpoint-GUID: PcJ60qQDPMO0FNkS1t1irkG8-68BlBGv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_07,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=862 impostorscore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060160

This patch series introduces some new features, improvements,
and fixes for the AD7768-1 ADC driver. 

The goal is to support all key functionalities listed in the device
datasheet, including filter mode selection, common mode voltage output
configuration and GPIO support. Additionally, this includes fixes 
for SPI communication and for IIO interface, and also code improvements
to enhance maintainability and readability.

---
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
---

Jonathan Santos (13):
  iio: adc: ad7768-1: set MOSI idle state to prevent accidental reset
  dt-bindings: iio: adc: ad7768-1: add trigger-sources property
  dt-bindings: iio: adc: ad7768-1: Document GPIO controller
  dt-bindings: iio: adc: ad7768-1: document regulator provider property
  Documentation: ABI: add wideband filter type to  sysfs-bus-iio
  iio: adc: ad7768-1: remove unnecessary locking
  iio: adc: ad7768-1: convert driver to use regmap
  iio: adc: ad7768-1: add regulator to control VCM output
  iio: adc: ad7768-1: add multiple scan types to support 16-bits mode
  iio: adc: ad7768-1: add support for Synchronization over SPI
  iio: adc: ad7768-1: replace manual attribute declaration
  iio: adc: ad7768-1: add filter type and oversampling ratio attributes
  iio: adc: ad7768-1: add low pass -3dB cutoff attribute

Sergiu Cuciurean (4):
  iio: adc: ad7768-1: Fix conversion result sign
  iio: adc: ad7768-1: Add reset gpio
  iio: adc: ad7768-1: Move buffer allocation to a separate function
  iio: adc: ad7768-1: Add GPIO controller support

 Documentation/ABI/testing/sysfs-bus-iio       |    2 +
 .../bindings/iio/adc/adi,ad7768-1.yaml        |   59 +-
 drivers/iio/adc/Kconfig                       |    2 +
 drivers/iio/adc/ad7768-1.c                    | 1116 ++++++++++++++---
 4 files changed, 999 insertions(+), 180 deletions(-)


base-commit: 5de07b8a24cf44cdb78adeab790704bf577c2c1d
prerequisite-patch-id: 8b531bca46f7c7ea1c0f6d232d162fd05fda52f7
-- 
2.34.1


