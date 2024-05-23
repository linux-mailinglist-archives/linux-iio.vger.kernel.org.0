Return-Path: <linux-iio+bounces-5196-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D53398CCB0C
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 05:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624CA1F22B9D
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 03:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776B112AAF8;
	Thu, 23 May 2024 03:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="exKKcrQR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BDF13AD28;
	Thu, 23 May 2024 03:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716434398; cv=none; b=TLedKRRAFnq3ht2GgX+E0sl6dRIqcHvo05dioYc/SnsOVSQTL7zHuiF+no5V+HUY92ZQDOvqo972KTFFj9XoJlPqAGPFJ/JdgZyCJ42c8q0LjDfDr8Q0FlAgmTxODFL5YPf+VC47IyiA1ix+B7DJxX5fJqS4m3uAbjij5aHqX6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716434398; c=relaxed/simple;
	bh=bEFDGtAw+jPgtTO93q/jH+mFbcpxJPQhNdkliwkQENU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OwHcqUrVTJKx3pr1LazjyAAbH8Jshu+6fg+vBu41eHzQ4bGEXySCriG46AOBudmylIxldExG1OjJh5c+nnJR+DyodcBE9kgWqbNNJ/KIFKZ88O96jLrvLe3rVjd6uZ0Wi98PKI2TexShBNdNH1sbHg9Powlo6LTPHv3mf1bYhoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=exKKcrQR; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44N0FBCm011838;
	Wed, 22 May 2024 23:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=DKIM; bh=fPwWOPFvm/y+
	cQEeNFDKjJ7FgFnXlrJ1R1+yiVA+p/c=; b=exKKcrQRfo+wrNqxcsl20hqTEH9g
	M21MSOO1kBAFerH5mTUARHOEZkHN1cFfB1RzpKsFCREHqMEXHHPRKTs+cyHC6haf
	ZnhYBT/Ejf8zndvZA79bN9zxagxmqCk1A4QIBIPKqYa3FRkTEDbf9qmSGe2dJqtz
	1i9/Ls7nbY9eV11+5TwnQ1QgukG3olS+DW3lLZ1IK+j6+WPEe9N8eRv7wI3vMuLc
	aSaZnh+lOOzZN+27Y6A2UkWW7KG04+EghbwTZtlRAV9tR+1BbPUxcnqyPiIgNOc1
	MGgo0lKU6oHd0vIjcwVtkAtHnCvxFsYMBXTYB3FMzlgShzlM+mCEcv7LtQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3y87pwkyjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 23:19:35 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 44N3JXqB004173
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 May 2024 23:19:33 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 22 May 2024 23:19:32 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 22 May 2024 23:19:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 22 May 2024 23:19:32 -0400
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.117.220.38])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 44N3JG8r018850;
	Wed, 22 May 2024 23:19:19 -0400
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
        "Rob
 Herring" <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        "Michael
 Hennerich" <michael.hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<noname.nuno@gmail.com>
Subject: [PATCH v2 0/5] Add driver for LTC2664 and LTC2672
Date: Thu, 23 May 2024 11:19:04 +0800
Message-ID: <20240523031909.19427-1-kimseer.paller@analog.com>
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
X-Proofpoint-ORIG-GUID: mfcHQf4Sx5UGF74cvzbbMnoUE0Md-ahL
X-Proofpoint-GUID: mfcHQf4Sx5UGF74cvzbbMnoUE0Md-ahL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_01,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 malwarescore=0 clxscore=1011 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405230022

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
 .../bindings/iio/dac/adi,ltc2672.yaml         | 159 ++++
 MAINTAINERS                                   |  11 +
 drivers/iio/dac/Kconfig                       |  11 +
 drivers/iio/dac/Makefile                      |   1 +
 drivers/iio/dac/ltc2664.c                     | 802 ++++++++++++++++++
 9 files changed, 1213 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
 create mode 100644 drivers/iio/dac/ltc2664.c


base-commit: 827dca3129708a8465bde90c86c2e3c38e62dd4f
-- 
2.34.1


