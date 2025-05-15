Return-Path: <linux-iio+bounces-19559-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB37AB913F
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 23:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9609F9E72F5
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 21:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC32F29B785;
	Thu, 15 May 2025 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="TsPG2w3Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB0E288512;
	Thu, 15 May 2025 21:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747343550; cv=none; b=s/tKl8uaSpsMTElDj474rMJ0yhHb9P5diKHZDQ6bsZN4WPavWEpnf6fXypbqMdLjhcH+0yTPR3xv53f1+bT3eI29WLfheCRfY9linPTRAYQCVtEiT/ImueFsPGTCnyuKcM7rns79xiONKpmmellOVOo636rhvw8+SDBc97zOyYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747343550; c=relaxed/simple;
	bh=G6vASOYh2SxiIF7LAUqwcQzAYeAm7Jen9OrBfkS/Gs0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fvjJuvRvkWBlDayRpVCjlmZgbZeTLFm0bLzrcUaCmBVIVVahgMSh22VsqXZaCUZZVRBl4Iy/xR0Z3dqwzMwtk4SuQfTitWZs/xVKflhpxEjHknkXEP/t+TvXnObCUjULuw2dtq5CzBRC4g0XqQ6eniPvI6bCD20YfqqOZn7MxAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=TsPG2w3Y; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FH8E8d010322;
	Thu, 15 May 2025 17:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=ggI85ZM6axxjTLuUfeNzv7zoLGA
	jrMMrrpe6gthhm9I=; b=TsPG2w3Y0WVSwhTBVzBAwZID775RDjJ2gmTKwuBdcqY
	2zA9rwCwNSa1iFBW27hYne1+9/y7fdQ1k5MzpMaCxNIIrjms9URzJImHRBr0YOoU
	DnRlR/dwXS8ESd0+p+Sv+G38xUF1BGHg7PlsBxmwI0m/CQBrnjIlEcDbG8tpiU2X
	q4/u5Kw0/bJuZIr0A7muFDxu2UonBQobsgaBAOwLQzVHQnBypURzi33kGRfyXCdJ
	7mnut0vRITPPkxrsi8CFUo6yvhewEiMRAeavr3Ovi8fsGIz6MknsVds0l8Z4Ni8b
	FI9MX70LfAMZ+6RGE89OnvPMYzU8tYRQSgfPd8p+osA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46ngknj9qc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 17:12:14 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 54FLCDov024887
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 May 2025 17:12:13 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 15 May
 2025 17:12:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 15 May 2025 17:12:13 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54FLBwLv018805;
	Thu, 15 May 2025 17:12:01 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <andy@kernel.org>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <jonath4nns@gmail.com>, <dlechner@baylibre.com>
Subject: [PATCH v8 00/11] iio: adc: ad7768-1: Add features, improvements, and fixes
Date: Thu, 15 May 2025 18:11:57 -0300
Message-ID: <cover.1747175187.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDIwNyBTYWx0ZWRfXyqOxou6skJLj
 y8QhXz0Ik1QHbL/pp0FSKXu7+rPBeJ7Foj4+BYmctx2UDYKqZxOElX1dVLg17wekwhZovgb06rE
 ac9MLywELUWlEacNvZnNv2g1ysCkrEdeYF0WTK9n5vkWOrcv9RJ/Z5+lXznmq4pXui3L8VGperB
 ifftR5q9LkbhQ2YwSl2A1ccWKLqK4C31z3D9yCDThl9MLCwgl2c/3TlsvnzAkstn2udjH9yYX9X
 IO+aMgA4qVgZ0SFmqN2HmK7SQ282SOkCy29ylwFssvDxDbXtgGJUO8GIxor9L8XclO5w5iiJwcF
 yP/E3tOJOxSuMwCCBxYeGlAK0C1uw7m3+YpbKXKjfbR/3EXuciUy0UpafQb5MMhzxGJOPznkigt
 tsnt2lxe7LeFOJjhbu0n29KA0q0qg0XiuszpgqL71YahembX7nGS91ccbIzx3yKsnZsoGE0P
X-Authority-Analysis: v=2.4 cv=B5u50PtM c=1 sm=1 tr=0 ts=682658ae cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=wUxFP8jSl_fENa0tmKEA:9
X-Proofpoint-GUID: 0bMa4OJiiCO_whDg6Kc5svm-mLKGi0L1
X-Proofpoint-ORIG-GUID: 0bMa4OJiiCO_whDg6Kc5svm-mLKGi0L1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_09,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150207

This patch series introduces some new features, improvements,
and fixes for the AD7768-1 ADC driver. 

The goal is to support all key functionalities listed in the device
datasheet, including filter mode selection, common mode voltage output
configuration and GPIO support. Additionally, this includes fixes 
for SPI communication and for IIO interface, and also code improvements
to enhance maintainability and readability.

---
Changes in v8:
* Removed "reorganize driver headers patch", since Jonathan said he picked 
  it.
* refactored ad7768_trigger_sources_get_sync() function.
* Addressed review comments, see individual pacthes.
* Link to v7: https://lore.kernel.org/linux-iio/cover.1745605382.git.Jonathan.Santos@analog.com/T/#t


Changes in v7:
* Added a new patch to reorganize driver headers.
* Added the new files to MAINTAINERS.
* Added dependencies to constrain the use of trigger-sources and
  adi,sync-in-gpios properties at the same time.
* Self triggering is enabled only when the trigger-sources property is
  not defined. Added TODO to support other trigger sources when the subsystem
  is available.
* Refactor code to avoid forward declarations.
* Mentioned that sampling frequency changes is not allowed in
  buffered mode.
* Addressed review comments, see individual pacthes.
* Link to v6: https://lore.kernel.org/linux-iio/cover.1745605382.git.Jonathan.Santos@analog.com/T/#t

Changes in v6:
* Changed description and addressed other nits in the gpio-trigger patch.
* Rewrote the #trigger-sources-cells description and removed mentions 
  to offload engine.
* Added adi,ad7768-1.h header with macros for the trigger source cells.
* removed of_match_ptr() from regulator_desc.
* Replaced deprecated .set callback with .set_rv in the gpio controller
  patch.
* Use `trigger-sources` as an alternative to `adi,sync-in-gpios`
  (now optional), instead of replacing it.
* Check trigger source by the compatible string (and the dev node for the
  self triggering).
* Addressed review comments, see individual pacthes.
* Link to v5: https://lore.kernel.org/linux-iio/cover.1744325346.git.Jonathan.Santos@analog.com/T/#t

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

Jonathan Santos (10):
  dt-bindings: trigger-source: add generic GPIO trigger source
  dt-bindings: iio: adc: ad7768-1: add trigger-sources property
  dt-bindings: iio: adc: ad7768-1: Document GPIO controller
  dt-bindings: iio: adc: ad7768-1: document regulator provider property
  iio: adc: ad7768-1: add regulator to control VCM output
  iio: adc: ad7768-1: add multiple scan types to support 16-bits mode
  iio: adc: ad7768-1: add support for Synchronization over SPI
  iio: adc: ad7768-1: replace manual attribute declaration
  iio: adc: ad7768-1: add filter type and oversampling ratio attributes
  iio: adc: ad7768-1: add low pass -3dB cutoff attribute

Sergiu Cuciurean (1):
  iio: adc: ad7768-1: Add GPIO controller support

 .../bindings/iio/adc/adi,ad7768-1.yaml        |  68 +-
 .../bindings/trigger-source/gpio-trigger.yaml |  40 +
 MAINTAINERS                                   |   4 +-
 drivers/iio/adc/Kconfig                       |   1 +
 drivers/iio/adc/ad7768-1.c                    | 896 +++++++++++++++---
 include/dt-bindings/iio/adc/adi,ad7768-1.h    |  10 +
 6 files changed, 904 insertions(+), 115 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml
 create mode 100644 include/dt-bindings/iio/adc/adi,ad7768-1.h


base-commit: 9415c8b5b9b7ba927d98f80022a2890e8639e9e4
prerequisite-patch-id: fbb33747cd0293bacd5b6d801d6cfc087449a28e
-- 
2.34.1


