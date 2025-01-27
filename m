Return-Path: <linux-iio+bounces-14614-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D94A1D911
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 16:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1201A165B5E
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 15:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED1F136E3F;
	Mon, 27 Jan 2025 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QINq9xwl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FA538DEC;
	Mon, 27 Jan 2025 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990667; cv=none; b=nLfnvkeMaBcRm6EqZr5AXLpWqKkuhFyBrQRszruyJIXBy27LKtwGSgv3r01N2G9FXNPbbYsbGC8IpgulPkT0CAZXv4TbVQZr7VfIWrrEOnp4R+TV9KUOmX7pFArmWS4VEmPExFbUR559/qO2nQ8ijj0m0lQqrFXCd8lR5bd6LbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990667; c=relaxed/simple;
	bh=FV5x4h1U7sxcz55kqdgXTDcicKcC67T4rW37QzwoaXM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H5voSoTwJqozkfvLUbYBQm0Y7fbTufs2SMakMaau5vJbMJ7OO0EsIht5/TbIbck8IJYDFztpZSN++ruJOh4iNpKh+jZuXXmQ79W3u40BV5o2irIAPL4In37joKmuGvXR/T+bKhXMrHT1n0D/dvi6ajvPUmnWQSS160s5wkoIeIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QINq9xwl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RDWCMw005712;
	Mon, 27 Jan 2025 10:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=z/Ft/eDFh9IU3HITlqMjO/x0cqA
	TfPsAbE5Ol/sBiMc=; b=QINq9xwlFQMIKhjbY73aZKV5oW7i87Zzr0I+KqaO9MI
	VBeQWYInnz7kyhAieiv9mHXHxHc2O5gs6qTUYSyOnIN2ALheP7TzrN7/FrQsvTy0
	f9W3DEOy4ZQS8+Uo4lbyU0x3SJxXbkF2b/Rdglr9t4IZpLgp6BQCyc8SLMoSr926
	r6vksGRGM90egQt9ftZZsGDIGmkx9aB4fVlIsWjVzvbM+56BVfn3nlc6YGbBtKWL
	mDwL/ePi87VOx+7sWBHWgeV2yGIHmiSc8fYegf5+tFGLsSNKAO2gUrxNfyMj9bOF
	WG1TWyNKZZmyIh7olhlq/1Wz4qWoVo/HKlz2TivMW5g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44eb44gd9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 10:10:49 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 50RFAm9N038336
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jan 2025 10:10:48 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 27 Jan
 2025 10:10:47 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 27 Jan 2025 10:10:47 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50RFAYqW008222;
	Mon, 27 Jan 2025 10:10:36 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 00/16] Add features, improvements, and fixes
Date: Mon, 27 Jan 2025 12:10:31 -0300
Message-ID: <cover.1737985435.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-ORIG-GUID: 8vPwloxfYnQqo3D2hKjy06i9Js_nLyiJ
X-Proofpoint-GUID: 8vPwloxfYnQqo3D2hKjy06i9Js_nLyiJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_07,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=919 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270121

This patch series introduces some new features, improvements,
and fixes for the AD7768-1 ADC driver. 

The goal is to support all key functionalities listed in the device
datasheet, including filter mode selection, common mode voltage output
configuration and GPIO support. Additionally, this includes fixes 
for SPI communication and for IIO interface, and also code improvements
to enhance maintainability and readability.
---
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
Jonathan Santos (11):
  dt-bindings: iio: adc: ad7768-1: add trigger-sources property
  dt-bindings: iio: adc: ad7768-1: Document GPIO controller
  dt-bindings: iio: adc: ad7768-1: add VMC output property
  Documentation: ABI: add wideband filter type to  sysfs-bus-iio
  iio: adc: ad7768-1: set MOSI idle state to prevent accidental reset
  iio: adc: ad7768-1: convert driver to use regmap
  iio: adc: ad7768-1: remove unnecessary locking
  iio: adc: ad7768-1: add multiple scan types to support 16-bits mode
  iio: adc: ad7768-1: add support for Synchronization over SPI
  iio: adc: ad7768-1: add filter type and oversampling ratio attributes
  iio: adc: ad7768-1: add low pass -3dB cutoff attribute

Sergiu Cuciurean (5):
  iio: adc: ad7768-1: Fix conversion result sign
  iio: adc: ad7768-1: Add reset gpio
  iio: adc: ad7768-1: Move buffer allocation to a separate function
  iio: adc: ad7768-1: Add VCM output support
  iio: adc: ad7768-1: Add GPIO controller support

 Documentation/ABI/testing/sysfs-bus-iio       |   2 +
 .../bindings/iio/adc/adi,ad7768-1.yaml        |  42 +-
 drivers/iio/adc/ad7768-1.c                    | 889 +++++++++++++++---
 include/dt-bindings/iio/adc/adi,ad7768-1.h    |  16 +
 4 files changed, 816 insertions(+), 133 deletions(-)
 create mode 100644 include/dt-bindings/iio/adc/adi,ad7768-1.h


base-commit: 5de07b8a24cf44cdb78adeab790704bf577c2c1d
prerequisite-patch-id: 8b531bca46f7c7ea1c0f6d232d162fd05fda52f7
-- 
2.34.1


