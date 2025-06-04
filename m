Return-Path: <linux-iio+bounces-20214-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2146ACE4D9
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 21:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2AD5188FC86
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 19:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B7F20D500;
	Wed,  4 Jun 2025 19:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KlOq/F33"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC8E211C;
	Wed,  4 Jun 2025 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065741; cv=none; b=OhYjwhmsIKw318mSBZwDG8sE7Cg8l9FFn52xkKxr0dA8J+RF9aSdTckTybFjSNMfm4WexRkQUgYXAxZnj3JVTtIHufxQe89I7uvVbxkfb716+cAaF+rbbI30ORD3PydRe/CQthOooKQsL1GMsKV03k3L6Zv3f0FoKVI0TvTufrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065741; c=relaxed/simple;
	bh=B2ZYF6tF94bN9A741W76pcYPI/v0JnHbuzVTtGwvq+s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nNXCxt4+b7K9vKpxbla4FfXgwr76j8uwU/sJTDDyF/OheqYIC20HheDNf4EasA6p0ofAQLSSfHR9iW7LwjOA1RXSAQf7sTr9Tc83GMHHhIHzhwI+O37KDrx5UKPz2ktdAilt707Q6UHfXg9jRwZkVCNpcMo4UMHaLKW+abl4NoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KlOq/F33; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554GdciY023428;
	Wed, 4 Jun 2025 15:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=bZmmm4xfVGuP56cs/+88josFnoP
	sx75nws0xXcYesgk=; b=KlOq/F33Esx/zwYPYTu2XnffIl6AEnZJMOl53A2BpcG
	J9VjH6mypObKJeh3wwcWvETZj2OO6Y7vPVE5AJ6kLzVsgnEvkBkdw2rlLAKQBJyF
	s0zp4egaXG4lPi2d1wi4dyHmMTOxc/Ni2Aal6YYW7C95H6a4ByUTc3NCU2TsfvuE
	q+w5HkrzlQhWjKGQlWRDY8+gluwOpqnk820NM/0fBU8zMigZYWmKc8ByZ7fqHQm7
	k0lOdbdqRYNVU43d71al2W6kMPQEiyqCA9HtMHyQ7QLh/j4Ny793d/SBhflm1QE2
	BIttRiJCbQ2Bz8LspKJsDhJvi7XNFjB+Do8gKKJKiPQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 472k2u2qmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 15:35:31 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 554JZOVO053699
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Jun 2025 15:35:24 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 4 Jun
 2025 15:35:23 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Jun 2025 15:35:23 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 554JZ9DL014289;
	Wed, 4 Jun 2025 15:35:11 -0400
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
Subject: [PATCH v10 00/12] iio: adc: ad7768-1: Add features, improvements, and fixes
Date: Wed, 4 Jun 2025 16:35:06 -0300
Message-ID: <cover.1749063024.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 4zbL6Cyq-nYwX9n71JUvxV3qJ6oM-HSa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE1NSBTYWx0ZWRfX5JC00waVA6mY
 BO2NoHKEt0FxuCBkuUDpANaIDpBXS8nbiZ0KuPaZnZ63B8ItRJEp5l8rvuYkKj0SQ57IVFDwOyK
 7r6N0vui02V9wgsHJD16goBfuRd1w+s7raLxNxbo3IhKvpCi9sh0c8ffXGFxfW80uzYqyNm96if
 cFBJthfQzMJZePVdZB/cIU7OZcvtVEkcWZV0FOnaMttTZbVVyC36sPyVHrUSmjZkel/1/s7H1U9
 GnJhbypcqiupG+47/6X1RpmZjqm9zOcCVgaf+zBRBWzL7cXvn5B0jqoLyb3NERJOvFh0O00lEfb
 sAAdwuooEqPUgeEwplkn5HWwTwEJt+fHD8PTkwQlNY6L/eeJ4XW7x311aOXKB0f3GpG65Hv6vib
 HKriyeomUYF3bFFCbG+fbQlQN8Fl1IBFtD7dN2u4p7i3w/5sHQX5j8mg2aei21u7omNNB+Pn
X-Proofpoint-ORIG-GUID: 4zbL6Cyq-nYwX9n71JUvxV3qJ6oM-HSa
X-Authority-Analysis: v=2.4 cv=Fv4F/3rq c=1 sm=1 tr=0 ts=6840a003 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=KVjtJqLLRZj_JVhx7eQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040155

This patch series introduces some new features, improvements,
and fixes for the AD7768-1 ADC driver. 

The goal is to support all key functionalities listed in the device
datasheet, including filter mode selection, common mode voltage output
configuration and GPIO support. Additionally, this includes fixes 
for SPI communication and for IIO interface, and also code improvements
to enhance maintainability and readability.

---
Changes in v10:
* Removed fwnode_find_reference_args() wrapper patch.
* Added SYNC_IN pulse timing requirement patch.
* Replaced fwnode_find_reference_args() back for the
  fwnode_property_get_reference_args(), but now with the cleanup.
* Link to v9: https://lore.kernel.org/linux-iio/cover.1748447035.git.Jonathan.Santos@analog.com/T/#t

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
  iio: adc: ad7768-1: Ensure SYNC_IN pulse minimum timing requirement
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
 drivers/iio/adc/ad7768-1.c                    | 908 +++++++++++++++---
 include/dt-bindings/iio/adc/adi,ad7768-1.h    |  10 +
 6 files changed, 916 insertions(+), 115 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml
 create mode 100644 include/dt-bindings/iio/adc/adi,ad7768-1.h


base-commit: 8bd4d29e36cd44abe95e1b289994bcda47e011ee
-- 
2.34.1


