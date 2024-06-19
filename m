Return-Path: <linux-iio+bounces-6550-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF53190E3B8
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 08:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 352F8B21045
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 06:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DFC6F304;
	Wed, 19 Jun 2024 06:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CsfjiGv5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956FB28EC;
	Wed, 19 Jun 2024 06:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718779795; cv=none; b=B22kBmcEKisuptAglB0XeEYkCV4FEel5khRyYlIhw/E0ic41sYBlGK1WhIeflLlvJNfp+ejtENG7gMyVbyxusFVerAuO/weI6SmthIfOWojiz/d/AA3azf0otjvG29gj9HyJZFLrMwoUKxJKj6RAdbLqT1rVdhhxQXgNACYLYOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718779795; c=relaxed/simple;
	bh=QRbBxk36TKELNT+KlUVraRuBJo6WSa4s4G7hk1SI7nw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FOkiMVTojqq48fiTISa8k6NsxdRsaZRGizQUUHEoFYWLTL/fAcED3xqRX4LxE/bR0o2ox98bkWidnxwXwzCLW8s02PUA49DwMFHNxYGM2wGT6lXFeNMtF/rILCb5/0xd2EWZTwSFrVB5ls5ZCpeJvEKYz2tbLsWsp86bTGaJeUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CsfjiGv5; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J6ePk0001410;
	Wed, 19 Jun 2024 02:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=42lVyecVe7v6w/yanxyaXD0FDR1
	myt7dG08UiL/DXiw=; b=CsfjiGv5QRmUBMvmsY9tCGvoNh5cZjn/C4yBfsokhSJ
	F7VOFbCm+UFUHUWoXzg91vCweraR2RlBjN1nX7EaJg4ZQNMNSRnpQRoTRyeworH8
	95QWn7/HcqUSD/oQjnObx/vgOMbs1litDIC+5wW4iw0De5sjTDSzAZaW4n0A/DD8
	kCNpVC5NN0/x3lKmio3bsYZocaF8YN42IwXf8f6CRHZzm4GMjQgLuLSpEDloRsne
	/hLohFPltNTkz5phW6f0fyCWcp+PWyRpTkl9EX1xrw084O8yBB3nLlgJHR+bHMkN
	YfSCknonxsjTqsKLIG7JC9sgSNxwBe54Aqk37lx4/sg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3yut9280u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 02:49:37 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 45J6nZSR048526
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Jun 2024 02:49:35 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 19 Jun
 2024 02:49:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 19 Jun 2024 02:49:34 -0400
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.117.220.25])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45J6nEve011796;
	Wed, 19 Jun 2024 02:49:16 -0400
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
Subject: [PATCH v4 0/5] Add driver for LTC2664 and LTC2672
Date: Wed, 19 Jun 2024 14:48:59 +0800
Message-ID: <20240619064904.73832-1-kimseer.paller@analog.com>
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
X-Proofpoint-GUID: ugWSz_HGi_XwU0A9IatFQN2Yzr-FZEjH
X-Proofpoint-ORIG-GUID: ugWSz_HGi_XwU0A9IatFQN2Yzr-FZEjH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190049

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

Kim Seer Paller (5):
  iio: ABI: Generalize ABI documentation for DAC
  iio: ABI: add DAC 42kohm_to_gnd powerdown mode
  dt-bindings: iio: dac: Add adi,ltc2664.yaml
  dt-bindings: iio: dac: Add adi,ltc2672.yaml
  iio: dac: ltc2664: Add driver for LTC2664 and LTC2672

 Documentation/ABI/testing/sysfs-bus-iio       |   1 +
 Documentation/ABI/testing/sysfs-bus-iio-dac   |  61 ++
 .../ABI/testing/sysfs-bus-iio-dac-ltc2688     |  31 -
 .../bindings/iio/dac/adi,ltc2664.yaml         | 167 ++++
 .../bindings/iio/dac/adi,ltc2672.yaml         | 158 ++++
 MAINTAINERS                                   |  10 +
 drivers/iio/dac/Kconfig                       |  11 +
 drivers/iio/dac/Makefile                      |   1 +
 drivers/iio/dac/ltc2664.c                     | 755 ++++++++++++++++++
 9 files changed, 1164 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
 create mode 100644 drivers/iio/dac/ltc2664.c


base-commit: 07d4d0bb4a8ddcc463ed599b22f510d5926c2495
-- 
2.34.1


