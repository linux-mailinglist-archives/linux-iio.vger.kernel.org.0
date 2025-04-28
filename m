Return-Path: <linux-iio+bounces-18769-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F182A9F09E
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 14:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD4917FE23
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 12:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8BE267B9D;
	Mon, 28 Apr 2025 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1UyBz6m9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10CD14A60F;
	Mon, 28 Apr 2025 12:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745843283; cv=none; b=YWgqlAoTP0d/Uk1rHpn+dr9GpD1A45wObdcY11Cm+1vNvFJ/39a7oJfAFwWOWhpVktnpaSWtoHMFHhOaRt0PoEZm8YdsWGhbRFtfKNj+mRTxNnO/MCvGkyjK2q/2lw1ak2y5hK1v62icONpqVhXMS4npY89K7PW42IT/ssqyBX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745843283; c=relaxed/simple;
	bh=mA2O10h2DhxbKsKifzYq26kOHcscLaXYq0rxvzf5vVI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ScgZwNrjWbkD4M0Af7I/hdczsuEPIZwp3jbosMn0qqWRsIISR5ZSGoQmnqLN/lS5ooaTkcNzBkBVH0AEe9rghJGIOgslp9MISxsaLeASh7rQEHArya9ytX1QPWzN4Z20I3qfdFXlyZ58AWXZW9NvE7XTOK9CLI8g47hEge2Yer8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1UyBz6m9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SCD0R7027668;
	Mon, 28 Apr 2025 08:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=OCYzhg4KxQU44Ntv7FHWMgpswkJ
	Hr55hJBOBLcQVCFc=; b=1UyBz6m9nkY7mgqW9+snsGm+YIhpVSXSEOP7DwBq/fz
	ziLJOfQK08ca1STKQJys6WCWYeNPCbJaFGMdaEnVi1RZClCPNZe9CewqJqHzAtfi
	iY0KehBYCk2j2n2y1o9ctuJd6szUIQNtSMitygPAvtMSPNuipZumfzHWfrNjOdYx
	I2R8Dh5Wkh1Z+JIZx1h61OL1FADEB4IDse+w4CiRvv6LcgiOt67eri5GyE3hHlE0
	LyRKn45xHGjkX/Yvu9wjirHabdZ0gV5rqDaB4uwqaRjrWtQ9/IvRihq+DUJICag5
	4Y+r+TT+iYPfsIMmIwdoNIkRVkymb4dpyJ4jXBIMVxg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 469dtgh6a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 08:27:45 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53SCRh2t011765
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Apr 2025 08:27:43 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 28 Apr 2025 08:27:43 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 28 Apr 2025 08:27:43 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 28 Apr 2025 08:27:43 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53SCROG0032497;
	Mon, 28 Apr 2025 08:27:26 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 0/7] iio: adc: Add support for AD4170 series of ADCs
Date: Mon, 28 Apr 2025 09:27:21 -0300
Message-ID: <cover.1745841276.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEwMiBTYWx0ZWRfXwxX6zTCgfNGs RcyNnswjx2W8t2M3JqUjGfspVoxNWf8Kk3BwFcRrreKJoidnmgi319CFRoTMDg5z1cRlIMIHKRr WPIXOj+yCH1wMVh+8SodQuXbY1NKW3jM6CkOQcgZb1x7lAp2ILjGSDZkgEzy58x6Uy7xY6Ffd2k
 z/GK6DA3LGNHjVneqTZKWGfE7S4R1ArA1gI2tiLaWE9gCIVAXKz5atzmaTfPONoSS2exTFT/JTe KceWeCG9jhSkkFQHANxngCP2H/BEJixSpAUfc23rITMhzhwwEwzHtyfFyVRjyVB6WeM767iFsHe S6nUenCuohm/qxmcoER1SfKbqj1A5VbNHbaxVkRvueQaUzfBDHqRw+M7SNP3gJl37vDKM6adLb1
 PNcOhuHOA0VEs8s6oeGIDXk1t5YmV1wPdGAKMEFVzGoofUZSecFUCULhpurZ3cLblhRirtgD
X-Proofpoint-ORIG-GUID: tvShJ6Mu8I9NDtrhWKlinpEneVUvnxE1
X-Proofpoint-GUID: tvShJ6Mu8I9NDtrhWKlinpEneVUvnxE1
X-Authority-Analysis: v=2.4 cv=crybk04i c=1 sm=1 tr=0 ts=680f7441 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=uC2PzzgbNJLNdZvJMSYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=994
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504280102

This patch set adds support for Analog Devices AD4170 and similar sigma-delta ADCs.

Patch 1 adds device tree documentation for the parts.
Patch 2 adds basic device support.
Patch 3 adds support for buffered ADC reading.
Patch 4 adds clock provider support
Patch 5 adds GPIO controller support.
Patch 6 adds internal temperature sensor support.
Patch 7 adds support for external RTD and bridge circuit sensors.

I believe to have updated the series according to all suggestions offered during
v1 review. The exceptions should be the IOVDD (discussed below) and regmap bulk
access which I decided to replace by a custom regmap_read/write implementation
instead.

Thank you for providing your insights and help.

Change log v1 -> v2

[IIO driver changes]
- Call gpio_set() at begining of gpio_direction_output() instead of at the end of it.
- Return -EPERM if try to set a GPIO configured for input.
- Now locking on state mutex before setting output GPIO values.
- Used gpiochio init_valid_mask() to only init available GPIOs.
- Replaced 3 regmap configs by regmap with custom reg_read/write implementation.
- Improved to support more than one external sensor connected.
- A few other minor improvements.

Previously, I thought IOVDD supply could be optional but it seems to be required.
I have only remote access to a setup with EVAL-AD4170-4 but am pretty sure the
link in the eval board was set to provide 3.3V to IOVDD pin.
Datasheet sais 'This supply sets the interface logic levels on the SPI interface
and powers an internal regulator for operation of the digital processing.'
Since IOVDD supply will presumably be enabled, I kept reading it's voltage
even though ADC channels might not use that info.

[device tree changes]
- Referenced adc.yaml from sensor-node.
- Merged property descriptions to reduce doc duplication.
- Every child node type is now in the example.
- Better described sensor-type property with a list of possible types.
- Updated adi,excitation-pins description to cover a use case I had overlooked.
- Added default to interrupt-names and to clock-names.
- Added support for clock-output-names
- Dropped '|' from descriptions when not needed.
- Added extra example

Link to v1: https://lore.kernel.org/linux-iio/cover.1744200264.git.marcelo.schmitt@analog.com/


Marcelo

Ana-Maria Cusco (1):
  iio: adc: Add basic support for AD4170

Marcelo Schmitt (6):
  dt-bindings: iio: adc: Add AD4170
  iio: adc: ad4170: Add support for buffered data capture
  iio: adc: ad4170: Add clock provider support
  iio: adc: ad4170: Add GPIO controller support
  iio: adc: ad4170: Add support for internal temperature sensor
  iio: adc: ad4170: Add support for weigh scale and RTD sensors

 .../bindings/iio/adc/adi,ad4170.yaml          |  554 ++++
 MAINTAINERS                                   |    8 +
 drivers/iio/adc/Kconfig                       |   16 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ad4170.c                      | 2846 +++++++++++++++++
 5 files changed, 3425 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
 create mode 100644 drivers/iio/adc/ad4170.c


base-commit: 1c2409fe38d5c19015d69851d15ba543d1911932
-- 
2.47.2


