Return-Path: <linux-iio+bounces-20418-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B7FAD5484
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 13:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192351888C93
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 11:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B452D276038;
	Wed, 11 Jun 2025 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="oI99eXMA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05AD2E613D;
	Wed, 11 Jun 2025 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749642615; cv=none; b=X5PgpKhKgXxer14pibF8WnnugX3GhDa4v3LG2iH59acVhd1X6Bbro+7bFntj7j0oD7LCi7AYDhpkdaPjXTWSlg30Qye3JTnGyGQtXkyYmrZsoiSVr8oqb55l+ZpHLAb+PbuMd83RgKGVlvORtUc+8GDxRxlifHe0SEIpao8Ru4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749642615; c=relaxed/simple;
	bh=ZShzju29YN9SUyiZ60OQnyOx1z0ZZxHtfDf2/9/ohsM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HyK2nzfomhFwBzz81QSxQGpqUhlkSnzWi0fx5II1hmrdwLYc5hmhZHq//Vs4ijrb7CN8i0pcmq9uaUsJGlKU4w0vIsFBrkKqluKJ2T9T2mFN8Vg0vjy7TBKqp4GpmI6gZxkAtzaPDTO/aGUVf5UHLQkMCGEyiz/sgqugehryF5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=oI99eXMA; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B8vZPI018146;
	Wed, 11 Jun 2025 07:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=NJQLOWrL1D4EcnOFjwJRIcQ1uPs
	f+cwkybB8KtbpyvE=; b=oI99eXMAcSNb796YgNj2hh8eRva99bpYopMRXjvEL2T
	JCkpct7Fg9K8NlonXHGGTdMpDvp5/XKML+noOLRnTVTmx9q0hwfV1gzx5P0cV+oN
	8kRt45DkL7R7N3GayF6endE/p3AZK+Wjptpg+IcZxQ+V39JABG5S8+x21zGLqpGa
	iIJXVC4RYIpF7JCZoFA/Ej7unjpU8qbdomATs19YNHXOlLHCefclknQq2i06ekYI
	KfWbtM0B19n4/3RF8ICO7KZmfUpvTYVJQzoDiEa+cS71gS1vB/9grgtnbTaqtgll
	aI4zEX3iIOhnwGXxgK/oOorApZU54nbpsUJj9TlIgjg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4776r9rvt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 07:49:54 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 55BBnrT4031401
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 11 Jun 2025 07:49:53 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 11 Jun 2025 07:49:53 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 11 Jun 2025 07:49:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 11 Jun 2025 07:49:53 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55BBnab5008856;
	Wed, 11 Jun 2025 07:49:39 -0400
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
Subject: [PATCH v11 00/11] iio: adc: ad7768-1: Add features, improvements, and fixes
Date: Wed, 11 Jun 2025 08:49:34 -0300
Message-ID: <cover.1749569957.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-ORIG-GUID: 2CNyhaeZEpEfOu-ef8mXyoYIKknOamMF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEwMCBTYWx0ZWRfXy8phO/5l1WmW
 VlapSmKI3xL+kvdVxXP46QLL8jO1SQQ8wLlyBBnRWPvE+bBu1kfPBWCaJM1fnVQvu7ajhlKg8wp
 Mlw95LK/8LEGD/ow0hRtISi9+KtabsKG7h6bIo2u+SlZj3m+samJrNVWFu3UcSIUQN6C3qkCHqB
 87BoauqlBX6zZYbngVdwSN8xD1njIKHiVB+5a4iScVHpdosmJO007Xq0ZdOL17hPH900tAgayL7
 uygRLJNzNaFc1SrUb7d7cWlTvxcZ7SkEF6toC1LuPPmACjsvhAarEqlTpVjEkUxVEHJhDSpmJCZ
 Ems+SpQQJrUYG76nfq11dyMfMKk3vfqAZhQENPabmnit6kXn7sLnk/+BAn/8vJYE51bJbMWQI28
 Qo1w5O9iMbScgk/ywfrXXOTvi6DuTTCabGMjEectR9bxcVx6Rk3or7gH3EcR05J46zm4jCl/
X-Authority-Analysis: v=2.4 cv=CKMqXQrD c=1 sm=1 tr=0 ts=68496d62 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=6mXrWtWfNG3HPuFurDMA:9
X-Proofpoint-GUID: 2CNyhaeZEpEfOu-ef8mXyoYIKknOamMF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999 impostorscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110100


This patch series introduces some new features, improvements,
and fixes for the AD7768-1 ADC driver.

The goal is to support all key functionalities listed in the device
datasheet, including filter mode selection, common mode voltage output
configuration and GPIO support. Additionally, this includes fixes
for SPI communication and for IIO interface, and also code improvements
to enhance maintainability and readability.
---
Changes in v11:
* Rearranged dt-bindings commits in the order they are used, in case something 
  goes wrong with this new version.
* Opted to use a local version of the fwnode_find_reference_args() function
  created in v9 for now to comply with the cleanup.h requirements.
* Addressed review comments, see individual patches.
* Link to v10: https://lore.kernel.org/linux-iio/cover.1749063024.git.Jonathan.Santos@analog.com/T/#t

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
* Addressed review comments, see individual patches.
* Link to v8: https://lore.kernel.org/linux-iio/cover.1747175187.git.Jonathan.Santos@analog.com/T/#t

Changes in v8:
* Removed "reorganize driver headers patch", since Jonathan said he picked
  it.
* refactored ad7768_trigger_sources_get_sync() function.
* Addressed review comments, see individual patches.
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
* Addressed review comments, see individual patches.
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
* Addressed review comments, see individual patches.
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
  dt-bindings: iio: adc: ad7768-1: document regulator provider property
  dt-bindings: iio: adc: ad7768-1: Document GPIO controller
  dt-bindings: iio: adc: ad7768-1: add trigger-sources property
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
 drivers/iio/adc/ad7768-1.c                    | 900 +++++++++++++++---
 include/dt-bindings/iio/adc/adi,ad7768-1.h    |  10 +
 6 files changed, 909 insertions(+), 114 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml
 create mode 100644 include/dt-bindings/iio/adc/adi,ad7768-1.h


base-commit: 4c6073fec2fee4827fa0dd8a4ab4e6f7bbc05ee6
-- 
2.34.1


