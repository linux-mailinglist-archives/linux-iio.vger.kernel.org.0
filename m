Return-Path: <linux-iio+bounces-15373-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7728FA319AF
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 00:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D8E3A7A5E
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 23:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7D126A08F;
	Tue, 11 Feb 2025 23:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qZ82eL/O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9262E268FEE;
	Tue, 11 Feb 2025 23:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739317594; cv=none; b=G8hqnhnz0B8+FS752ZSjU486U4F91PJ0am5OboyQ+smFkIpyG18muJ/r7ISOfy6lhjjn1VejUNiT0M8T0ihhzw8LCzqEa4u6Fbp6WwoaEIidV/uU10l4vIY11GW0LEqYkW6Ed96ogUDuynGJfiRVurCFnOMOs169euOCqXD59EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739317594; c=relaxed/simple;
	bh=dk11KWQbyxf+KzJS8aYIAh3CE0Kh/l9sVLzYcmT6jls=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K7RpGIyrliUOjaJsIFa4h2k0Gnc/sxUW/DJC011YATRHHWhusl3y7n/iVu0n9xgezlnLj0J8XCFUVDC6Qh/ySdsfv1rVgzdchq9Ra2HY/EpmIJbVzj/daTVOkTmJU1UtQAjgNjmBxsRGc42ghwY6NNBinN+gSUVaKhQmpVBMWeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qZ82eL/O; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BK0bDR014127;
	Tue, 11 Feb 2025 18:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=kCoYyWpLAjZeie4mU2JKL3RDK1j
	XLmGZP/wib7tTW4M=; b=qZ82eL/OJtGAUCDct6P8NWt+SDISJBmPOsTqm7T3Ivt
	yPJapKcIxRf/5YoZ6PSgWi2ht3esunfVlrGb38RMXLOHpWZDLd0M0easbzb0Npdp
	RNr7FClwh0En42hOk17D3+0zInZw1HxCLFhPJT+ythxxGTWcgtrJOHCt1VR1Ybib
	RFlIdttt1jOzi6FBUFrRKUb6RdQlfxR4o1F1FXPUksTeEzMNYRa8Sju+8HtXShbA
	Ox9ZynCXKpwkZRIV2MSEr8jv9efgTpL1rR0zA63FA7FhnQ9ZpJODxGO34UN9SmlP
	K699ZZpflEKfQMZdG/uIlu+i2od4dOd6RgLHFy3J0Cw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44p529y7nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 18:46:13 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51BNk6Kq016911
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Feb 2025 18:46:06 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 11 Feb 2025 18:46:06 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 11 Feb 2025 18:46:06 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 11 Feb 2025 18:46:06 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51BNjrIi009712;
	Tue, 11 Feb 2025 18:45:55 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 00/17] iio: adc: ad7768-1: Add features, improvements, and fixes
Date: Tue, 11 Feb 2025 20:45:52 -0300
Message-ID: <20250211234552.1007753-1-Jonathan.Santos@analog.com>
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
X-Proofpoint-ORIG-GUID: 5bT_UhXQ1NqFzK8Rxh7eRWAMFRXES6rX
X-Authority-Analysis: v=2.4 cv=FabNxI+6 c=1 sm=1 tr=0 ts=67abe146 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=DcVhKpCQim4X3dEw7YsA:9 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-GUID: 5bT_UhXQ1NqFzK8Rxh7eRWAMFRXES6rX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_10,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=909 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502110158

This patch series introduces some new features, improvements,
and fixes for the AD7768-1 ADC driver. 

The goal is to support all key functionalities listed in the device
datasheet, including filter mode selection, common mode voltage output
configuration and GPIO support. Additionally, this includes fixes 
for SPI communication and for IIO interface, and also code improvements
to enhance maintainability and readability.
---
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
---
Jonathan Santos (13):
  iio: adc: ad7768-1: set MOSI idle state to prevent accidental reset
  dt-bindings: iio: adc: ad7768-1: add trigger-sources property
  dt-bindings: iio: adc: ad7768-1: Document GPIO controller
  dt-bindings: iio: adc: ad7768-1: document regulator provider property
  Documentation: ABI: add wideband filter type to  sysfs-bus-iio
  iio: adc: ad7768-1: remove unnecessary locking
  iio: adc: ad7768-1: convert driver to use regmap
  iio: adc: ad7768-1: add regulator to control VCM output
  iio: adc: ad7768-1: add multiple scan types to support 16-bits mode
  iio: adc: ad7768-1: add support for Synchronization over SPI
  iio: adc: ad7768-1: replace manual attribute declaration
  iio: adc: ad7768-1: add filter type and oversampling ratio attributes
  iio: adc: ad7768-1: add low pass -3dB cutoff attribute

Sergiu Cuciurean (4):
  iio: adc: ad7768-1: Fix conversion result sign
  iio: adc: ad7768-1: Add reset gpio
  iio: adc: ad7768-1: Move buffer allocation to a separate function
  iio: adc: ad7768-1: Add GPIO controller support

 Documentation/ABI/testing/sysfs-bus-iio       |    2 +
 .../bindings/iio/adc/adi,ad7768-1.yaml        |   59 +-
 drivers/iio/adc/ad7768-1.c                    | 1068 ++++++++++++++---
 3 files changed, 949 insertions(+), 180 deletions(-)


base-commit: 5de07b8a24cf44cdb78adeab790704bf577c2c1d
prerequisite-patch-id: 8b531bca46f7c7ea1c0f6d232d162fd05fda52f7
-- 
2.34.1


