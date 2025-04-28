Return-Path: <linux-iio+bounces-18737-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C994A9E541
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 02:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72472189A4BA
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 00:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387A3DDBC;
	Mon, 28 Apr 2025 00:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xthtjTWB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479832114;
	Mon, 28 Apr 2025 00:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745799150; cv=none; b=pBvn+qa3k0y6Cr0oGpWzcV9VuEf441oKfkWhxAjFWlCE53SubijQbFm7UWq7BDsWFJ271IZIeshRdWDODdYzKOx8yf0RNCDNV8nn9vGZQaQNv9aoWMzq5oMdEhyoVHf3Q71k1HKygK75JyAFsbXjHqk/fJ/sIriP+VF305hLOAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745799150; c=relaxed/simple;
	bh=exXF0F5O/sdbIfm2HdDPYyvkK+FRMFC5fYGeL5yZyXY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nh/YLz5CAVBDdP/WLrHENY+IvHt5/dCu6MhXci5+QXEf7HY6arzY59tbKm2EZrJ03iZJDrkjPuRkLLG02x0cPW3TT/EifG1JzfTv+E4enSCftpJQGOrV6CDXGhZW8CCvHQpdIN8VXGnz1of6S1v3rfzTs9VNCIzqFcrOPu7DwCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xthtjTWB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S03r0D027378;
	Sun, 27 Apr 2025 20:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=gk1E67aKgV4Z3w9Acc5z0e0A+XA
	hcFhE+RiMkW//0L8=; b=xthtjTWB5r4SNmEU/Ya/oiYQiVq30TJgEsfjvB0hRU+
	TqLLnfwTPQ+x5MvO5r4w3jTy8BHzDAN0/7baBDyetbpHGnJ/r2Nj4kINGbW53q1y
	O6kBm71dyKUMbie29wq9+JcrzQ9X1kO8owp/LrPJ1ay+yjjCOrDNtYvlCumqNMDx
	80MNUYg2ctben178tiucMbFB0xUGQG4teU0Z5tnPH8Tufg+G5g4v95k7ArnIwZiI
	jIjnI+U20fqXzkoiZnKv4Hpdt/s8rZ/KJE6clqkeBbwaQ6YBTcZ+zzLGjNI2nOVt
	6ZgDW7glAZGcq2RVLMUAX5S6mRdRJ1B0iU05gkBqOSw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 469dtgcm7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 27 Apr 2025 20:12:07 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53S0C6vY028745
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 27 Apr 2025 20:12:06 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Sun, 27 Apr
 2025 20:12:06 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sun, 27 Apr 2025 20:12:06 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53S0Bnvx014417;
	Sun, 27 Apr 2025 20:11:51 -0400
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
Subject: [PATCH v6 00/11] iio: adc: ad7768-1: Add features, improvements, and fixes
Date: Sun, 27 Apr 2025 21:11:48 -0300
Message-ID: <cover.1745605382.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI3MDIwMiBTYWx0ZWRfX6liJQFU04NvC 12PezxJxTpI/xxKMK0ESP6H4uwCDK4OK5c6Vy2TLyd+xTN94U2wpzsVuqd3aqDem9XYuiHCJSNg lYBUGVCiK/cxyVWWZWArnrzjopkTBcujNvgsCnYaYzvUGYllrtVAbEoki2Wd8NCZ/BbHGKTWeKF
 4XnNdRvJGoNxM7Rau0LyjKZGmnjubTRQMyoYr7hO44fGjbDO8+0tCNXEXRW6ST24v2T4lD3QMVz QDluiXbbt491NRu+83hTxmR+E0XSVsLi1+30vddAvh+duWk0Wr5Ramj2XEYPCBS9ez16M3fQn4g SGH3HJErQW5keZRbhhI3HrAjN/Xp/a7Z08XIM7EaHlaAbkjtl/aXEME2EFg45zimBtW38ZL4S7L
 bWq3FCEoU6VzsTM3RSQz6sm1jf5fqDGYnxE56xEsvUHshjWlYLjvkN1PLTnKfFnkV/xRv7aY
X-Proofpoint-ORIG-GUID: Gsm8vsy8Nsg90k6lamaliu_U8vSsHc-u
X-Proofpoint-GUID: Gsm8vsy8Nsg90k6lamaliu_U8vSsHc-u
X-Authority-Analysis: v=2.4 cv=crybk04i c=1 sm=1 tr=0 ts=680ec7d7 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=wEdGIpG45IeLlA7ASWQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-27_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504270202


This patch series introduces some new features, improvements,
and fixes for the AD7768-1 ADC driver. 

The goal is to support all key functionalities listed in the device
datasheet, including filter mode selection, common mode voltage output
configuration and GPIO support. Additionally, this includes fixes 
for SPI communication and for IIO interface, and also code improvements
to enhance maintainability and readability.

---
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

 .../bindings/iio/adc/adi,ad7768-1.yaml        |  60 +-
 .../bindings/trigger-source/gpio-trigger.yaml |  40 +
 drivers/iio/adc/Kconfig                       |   1 +
 drivers/iio/adc/ad7768-1.c                    | 918 ++++++++++++++++--
 include/dt-bindings/iio/adc/adi,ad7768-1.h    |  10 +
 5 files changed, 928 insertions(+), 101 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml
 create mode 100644 include/dt-bindings/iio/adc/adi,ad7768-1.h


base-commit: 9415c8b5b9b7ba927d98f80022a2890e8639e9e4
prerequisite-patch-id: fbb33747cd0293bacd5b6d801d6cfc087449a28e
-- 
2.34.1


