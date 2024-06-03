Return-Path: <linux-iio+bounces-5657-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A5E8D79B3
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 03:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007AA1C20F2A
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 01:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F881862;
	Mon,  3 Jun 2024 01:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="fuVrvGoe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CAA1C2D;
	Mon,  3 Jun 2024 01:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717377777; cv=none; b=D5NpPJ+k/wNcXfPRUyJNDjcUwrU836tfMTrt6JRhT+htryKZyKRB4W7/qKMX58Jwwp3bMSAResJHy73h4vhV89HEDokFgiH9eIy/rHQrW/LosdkgyMrKqF2UB8BGz9ORb1xZ1y0he1Z9LBp2ewvDK34YR03zS3RZZAWNM4y9XRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717377777; c=relaxed/simple;
	bh=8jerwMNhqDq2e4narHB8OrK2/SCWeKrrup9XC1624ls=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ckX4BMvMDRsnbFLbXrpAjJHXw0SybcuFZexgGwEQneE/Sy7Dg8D1mE23jUU0+HSLyKQW34nad1O9tG1SMPQhAb7QZpcsPnPQfNL65lnEz0G9SKAAr2OOVx2F7hEE7O6pl8HATfbvuFXLq5Qa3csCQAhcWAVk14JTgNMQYkN2OLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=fuVrvGoe; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 452MZo0N030278;
	Sun, 2 Jun 2024 21:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=ZlCYZxmFV0ulZK+NjSjVq4N1rWz
	DwUJfGzD7krgZzHc=; b=fuVrvGoeKNkWs/88T9ChafOjyVkGVPW+GgeofdG2LHk
	W9TlzpT7Jl48WAfYAVHojamVDPSEs4NPv0tHBTgoA4DRY/1xIroc0bUrxEmZvI6G
	mUbo4yOjK6d7Gizp2ng88p9rUp3j53cxfP4kDAoyY9FMvhdmiWP6u6c3aBycj4M/
	JNBB29sfwtCmtjAwl7yN7R5aln14dbOMjldIv/zRse2lXCMZORl7DKuBttF7sYtK
	gSNYGQl2CZnD+FDEO4t9/L0HuTTNXdtgbnphOBk3pH4FC/Zjp7Dsy4qQIjUoUI2C
	GaPkmpKVZLSlMPK048iVGfH5VSEzYpn3EP/mFPDQaVQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3yg0j1c3d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Jun 2024 21:22:34 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4531MXUS065139
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Jun 2024 21:22:33 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Sun, 2 Jun 2024
 21:22:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sun, 2 Jun 2024 21:22:32 -0400
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.242.67])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4531MFWO007966;
	Sun, 2 Jun 2024 21:22:18 -0400
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
Subject: [PATCH v3 0/5] Add driver for LTC2664 and LTC2672
Date: Mon, 3 Jun 2024 09:21:55 +0800
Message-ID: <20240603012200.16589-1-kimseer.paller@analog.com>
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
X-Proofpoint-ORIG-GUID: eKTy6ncbldIKZyAHPoaUvLd4dz65axXA
X-Proofpoint-GUID: eKTy6ncbldIKZyAHPoaUvLd4dz65axXA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_15,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406030010

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
 drivers/iio/dac/ltc2664.c                     | 806 ++++++++++++++++++
 9 files changed, 1215 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
 create mode 100644 drivers/iio/dac/ltc2664.c


base-commit: 15895709c7dc5f1a8b53b3564fc2bed724209611
-- 
2.34.1


