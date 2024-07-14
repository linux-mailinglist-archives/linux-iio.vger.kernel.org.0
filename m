Return-Path: <linux-iio+bounces-7606-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E74930A19
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2024 15:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D825280D21
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2024 13:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ACF139597;
	Sun, 14 Jul 2024 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SJNgSLp4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3E2132122;
	Sun, 14 Jul 2024 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720963859; cv=none; b=Cru9eVVazMO2GZB/ZCWqGr8e3JaBQRtWTDzq1YoJS9HVXylqtikZtCqplnQiDG+WnFAPxFAQs4OYsRUiv+F+lYuM4weZ5OhLEr6o6zLd6QgYebDyzl7am1IhAlFVpAHgsYCBIQp6oP6bwSWVfzzrsRucRrWyf6TZ6IU18wlNj+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720963859; c=relaxed/simple;
	bh=RXW0XWNGKF2MGUJFARpEaRquVPPefgViUGAFtnKsRGs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GztUtD/b1rJQuDzLxp65FZd8uoAKBWNer7xrfgGBrRj+ViDsLC9M0HJP8iXc5uWd9VawW4c6ZUsLhCrpvLtnLiNmsV6Ng7RrSuoLS60w7dCeazdvOpvHnyHrSsyYud1y+Wsrw6cNuFyahU3i83OlGp2MrFsFvV+SpUhNWsvOrbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SJNgSLp4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46ED299S004754;
	Sun, 14 Jul 2024 09:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=YZmxq+wu9QNYhqfPLdunVNrXRdx
	zTndu6wwjkARiCWQ=; b=SJNgSLp47EWW5zMO+YOSUOG0USfm4oJ6flcrO3Ln0SD
	d0yaAAgYH7ekSiBnYRfpHyth1s+L5x+OYq5FrQHYblQ4nsDgelYMa0xWZakGHxry
	cU0tUSOXkbXR2l41PjqGesADKLZRIGOTouuEb1saTQ6I3durjcn1nP/zC3QDwNqx
	sCvj1ga20PbaqR203gkstC4EXE3fSOJFJInWdrEMPLUc1qKUn4HgzjdJ0IFZtV8I
	y79Y+wuIJQsY6uqi+M/8lfquep4qu3EpEfxlTEVL60bMs0HOcVMw7RPIPLmn42wz
	DqFZcVpH7jclq2Mlh8cjoXljUsjDsnKB/MEGnZ1LOXg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 40bpg2amyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jul 2024 09:30:26 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 46EDUPV1050880
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 14 Jul 2024 09:30:25 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Sun, 14 Jul
 2024 09:30:24 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sun, 14 Jul 2024 09:30:24 -0400
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.18.97])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46EDU4QT028092;
	Sun, 14 Jul 2024 09:30:07 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
To: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Dimitri Fedrau
	<dima.fedrau@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Michael
 Hennerich <michael.hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<noname.nuno@gmail.com>,
        Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v7 0/6] Add driver for LTC2664 and LTC2672
Date: Sun, 14 Jul 2024 21:29:54 +0800
Message-ID: <20240714133000.5866-1-kimseer.paller@analog.com>
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
X-Proofpoint-GUID: BRnDIqHgdaEP9QRxl0PR8s-LX8u5DEjv
X-Proofpoint-ORIG-GUID: BRnDIqHgdaEP9QRxl0PR8s-LX8u5DEjv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-14_11,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407140107

Generalize the ABI documentation for DAC. The ABI defined for toggle mode
channels:

LTC2664:
  * out_voltageY_toggle_en
  * out_voltageY_raw0
  * out_voltageY_raw1
  * out_voltageY_symbol

LTC2672:
  * out_currentY_toggle_en
  * out_currentY_raw0
  * out_currentY_raw1
  * out_currentY_symbol

Default channels won't have any of the above ABIs. A channel is toggle capable
if the devicetree 'adi,toggle-mode' flag is set.

changes in v7:

Bindings:
  * Reverted DAC bindings to original conditional requirements.
  * Added Reviewed-by tag for dac.yaml.

changes in v6:

Bindings:
  * Added clarification description for output-range-microvolt property and
    modified conditional logic for output-range-microvolt for ltc2664 binding.
  * Simplified schema validation logic for DAC binding.
  * Added Reviewed-by tag for ltc2672 binding.

changes in v5:

ltc2664:
  * Removed return statement for error code in ltc2664_dac_code_read making it a
    void function.
  * Refactored voltage regulator error handling and logic setting for vref_mv.
  * Added Reviewed-by tag.

Bindings:
  * Added dac.yaml and generalized DAC common properties.
  * Modified ltc2664 binding adding constraints for the adi,manual-span-operation-config
    and output-range-microvolt properties.

changes in v4:

ltc2664:
  * Added comments for each field in the ltc2664_chan struct.
  * Changed global_toggle data type to bool and updated vref and rfsadj variables
    to include units.
  * Added 0,0 entry in ltc2672_span_helper to removed the id field from the
    ltc2664_chip_info struct.
  * Used mul_u64_u32_div helper function from linux/math64.h to avoid integer
    overflow during scale calculation.
  * Refactored code to use a single template for channel instead of separate
    channel arrays.
  * Used the devm_regulator_get_enable_read_voltage API for simplifying voltage
    retrieval.

ABI:
  sysfs-bus-iio:
    * Added commit message for the ABI changes.
  sysfs-bus-iio-dac:
    * Updated the description of toggle_en to clarify autonomous toggling.
    * Fixed inconsistent use of spacing and tabs.

Bindings:
  * Dropped Reviewed-by tag.
  * Updated the description for both bindings to include both 12-bit and 16-bit
    versions.

changes in v3:

ltc2664:
  * Added span sanity check for no match.
  * Initialized the variable 'span' to fix build warning.
  * Added Reported-by and Closes by tag.

ABI:
  * Modified descriptions to make it more generalize.
  * Removed MAINTAINERS file entry.

Bindings:
  * Changed clr-gpios to reset-gpios.
  * Added output range and reset code description for 'adi,manual-span-operation-config'
    property in ltc2664 binding.
  * Removed the $ref for 'adi,output-range-microamp' due to dt-schema warning
    in ltc2672 binding. Added Reported-by and Closes by tag.
  * Modified io-channels description and added maxItems constraint.

changes in v2:

ltc2664:
  * Updated struct ltc2664_chip_info to include device-specific data for scale,
    offset, measurement type, internal vref, manual span support, and rfsadj
    support.
  * Added a read-only extended info attribute powerdown_mode to indicate the
    state that the DAC output enters when the device is powered down.
  * Refactored code for setting the span into separate function and directly
    returning the span.
  * Adjusted memory allocation for st->iio_channels to include null terminator.
  * Spaces have been added after { and before }. Each pair of values is now
    placed on a separate line.

ABI:
  * Generalized the ABI documentation for DAC.
  * Added DAC 42kohm_to_gnd powerdown mode.

Bindings:
  * Created separate bindings for ltc2664 and ltc2672.
  * Added v-pos-supply and v-neg-supply regulator properties.
  * Renamed vref-supply to ref-supply based on the datasheet.
  * Added io-channels property and specifying the pin for multiplexer output.
  * Added vdd0-vdd4 supply properties for ltc2672, although they are not
    currently supported in the driver.
  * Changed clr-gpios description based on the datasheet.
  * Used 4 spaces for example indentation.

Kim Seer Paller (6):
  iio: ABI: Generalize ABI documentation for DAC
  iio: ABI: add DAC 42kohm_to_gnd powerdown mode
  dt-bindings: iio: dac: Generalize DAC common properties
  dt-bindings: iio: dac: Add adi,ltc2664.yaml
  dt-bindings: iio: dac: Add adi,ltc2672.yaml
  iio: dac: ltc2664: Add driver for LTC2664 and LTC2672

 Documentation/ABI/testing/sysfs-bus-iio       |   1 +
 Documentation/ABI/testing/sysfs-bus-iio-dac   |  61 ++
 .../ABI/testing/sysfs-bus-iio-dac-ltc2688     |  31 -
 .../bindings/iio/dac/adi,ltc2664.yaml         | 181 +++++
 .../bindings/iio/dac/adi,ltc2672.yaml         | 160 ++++
 .../devicetree/bindings/iio/dac/dac.yaml      |  50 ++
 MAINTAINERS                                   |  10 +
 drivers/iio/dac/Kconfig                       |  11 +
 drivers/iio/dac/Makefile                      |   1 +
 drivers/iio/dac/ltc2664.c                     | 735 ++++++++++++++++++
 10 files changed, 1210 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/dac.yaml
 create mode 100644 drivers/iio/dac/ltc2664.c


base-commit: 1ebab783647a9e3bf357002d5c4ff060c8474a0a
-- 
2.34.1


