Return-Path: <linux-iio+bounces-20018-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B29AC846D
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 00:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D1EA7A3B54
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 22:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7433521E0BA;
	Thu, 29 May 2025 22:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1oVi1I3f"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C61720F087;
	Thu, 29 May 2025 22:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748558924; cv=none; b=piKuUeLzTbs26X1DR/1bUQTLF645HYZ01Gps4eZeX+jYRbcC0gvGmtqc6Wr18cRNWKdjh9srRSg/4Xu1ID6h+kYUSnZBBSw89xmVOKLYE208gBwurVl6GYBibYUdiWec95r4GZP+AUfV3m7/Ng+BmTWlHGtko1H5oYpm/BXxt4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748558924; c=relaxed/simple;
	bh=MUf1zRF11b2/Zim4UsDslgS8M+dVR0zpw3Iq52gtOPM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oFOaYfGNdyDq+deeubnIyNnUK4xNE/lvExdTP95nw8LaYE0WctORiZpCnaXJbPSC/pXInjXoWrvNQp010GBiWff8EW9i88Rpd/ELYsek0Jzc+JRzPJ2xU2w5Q3KkdKOuYtyXeQoiznvBmT3oVtMb+Fv+0ywY0fFBhS6ZwQR4AYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1oVi1I3f; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TJlShB030330;
	Thu, 29 May 2025 18:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=+1DV8yJjPDKROOOYMFwZ11kCKnF
	Ly6F7f+evQvNjzko=; b=1oVi1I3fedpqDrj6JS/P1JRpwAc9m+GMCoulSLnBiK6
	5bXwjlAN6CCQuGk56k/Hm3iV8PsWqkZfOlqC1s3JjgEC/CfMPqvvWGuybrty8GJC
	eblcrt0N2aYi+a3ttbmk+rc1t6lgJUY1ZNok3tW86npvVK++qiRT8EOAVMBAcD8p
	YPNsx8FtD0vEjqPT3CJ9LhkxS8Fkby+RNIlBYE2j80erBS/IrcTqWtzGG3aHGMUu
	qJYjm6aoNvXJwropodCh7EEvhqCBBUw3gzQGlRN5qzLRxGwW1TZruA4dLsQnZwL4
	ZLzDT+SltzPzfDLJS7GBc4dFmNbHAEuEvqGVHfHDUKw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46xth6hrva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 18:48:20 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 54TMmJ5W010273
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 May 2025 18:48:19 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 29 May
 2025 18:48:19 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 29 May 2025 18:48:19 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54TMlviV017121;
	Thu, 29 May 2025 18:48:00 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <andy@kernel.org>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <jonath4nns@gmail.com>, <dlechner@baylibre.com>,
        <andriy.shevchenko@linux.intel.com>, <rafael@kernel.org>,
        <djrscally@gmail.com>
Subject: [PATCH v9 00/12] iio: adc: ad7768-1: Add features, improvements, and fixes
Date: Thu, 29 May 2025 19:47:57 -0300
Message-ID: <cover.1748447035.git.Jonathan.Santos@analog.com>
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
X-Authority-Analysis: v=2.4 cv=CccI5Krl c=1 sm=1 tr=0 ts=6838e434 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=KVjtJqLLRZj_JVhx7eQA:9
X-Proofpoint-ORIG-GUID: 1WpTrMaJzBKRpOgnHX6LFU6ow4G7muGG
X-Proofpoint-GUID: 1WpTrMaJzBKRpOgnHX6LFU6ow4G7muGG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDIyMiBTYWx0ZWRfX7l+njXuUcNfn
 gMcc20IH47mGpIc2Xal6CznXhO9euYvExKnUkVJ4kawVohmNYo3QO1IvcpCFjtvdauIX+7gPaXy
 xWmhMGIcsNKo9j1b9VwVgJumdFIiAEg1LkVatoF299UdVi0GSUr3D1ZtR/xFeK7U/db/rOapJCW
 aOFDCBaqWXIkOsfmTKzSYb8L00QJbdfcbkLvd58YcPDpWAWSkQIT/e9qRN4cI2Qe9B9QwdeDsi5
 KICdF36+ZiXmqa6wpAhjsYISojOLJAMBlRGDY4TLKYiOEG2uo6MerxxRhOi9CesX0cczPMRUCr9
 gQSABEkXzicVAUixAuxKPp2dabjs8KY0XDD1/Krmux/nnKibSNp09K18WuqAVCPGhEia4G5/ZB6
 749EszNsxdxZd8o2/+7aFvkmumTZiNQF2AVUbt209MizraP9rEU0QDK4hmQ7H7sjt2poDoh2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_10,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1011 mlxscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290222

This patch series introduces some new features, improvements,
and fixes for the AD7768-1 ADC driver. 

The goal is to support all key functionalities listed in the device
datasheet, including filter mode selection, common mode voltage output
configuration and GPIO support. Additionally, this includes fixes 
for SPI communication and for IIO interface, and also code improvements
to enhance maintainability and readability.

---
Changes in v9:
* added fwnode_find_reference_args() patch.
* Refactored ad7768_trigger_sources_get_sync() to avoid jumps and used 
  fwnode_find_reference_args() to get the trigger-sources property with
  proper cleanup.
* Fixed oversampling_ratio_available attribute. Previous ranges did not 
  follow a standard. Now we mix range (for sinc3) with list 
  (for sinc5 and wideband).
* Addressed review comments, see individual pacthes.
* Link to v8: https://lore.kernel.org/linux-iio/cover.1747175187.git.Jonathan.Santos@analog.com/T/#t

Changes in v8:
* Removed "reorganize driver headers patch", since Jonathan said he picked 
  it.
* refactored ad7768_trigger_sources_get_sync() function.
* Addressed review comments, see individual pacthes.
* Link to v7: https://lore.kernel.org/linux-iio/cover.1746662899.git.Jonathan.Santos@analog.com/T/#t


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

Jonathan Santos (11):
  device property: add fwnode_find_reference_args()
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
 drivers/base/property.c                       |  32 +
 drivers/iio/adc/Kconfig                       |   1 +
 drivers/iio/adc/ad7768-1.c                    | 906 +++++++++++++++---
 include/dt-bindings/iio/adc/adi,ad7768-1.h    |  10 +
 include/linux/property.h                      |   6 +
 8 files changed, 952 insertions(+), 115 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml
 create mode 100644 include/dt-bindings/iio/adc/adi,ad7768-1.h


base-commit: 9415c8b5b9b7ba927d98f80022a2890e8639e9e4
prerequisite-patch-id: fbb33747cd0293bacd5b6d801d6cfc087449a28e
-- 
2.34.1


