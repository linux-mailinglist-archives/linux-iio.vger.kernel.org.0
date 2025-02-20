Return-Path: <linux-iio+bounces-15856-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DD1A3DBCE
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 14:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30EF57A2C60
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 13:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B9A1FA856;
	Thu, 20 Feb 2025 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="tpEaSE36"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293D11F9ED2;
	Thu, 20 Feb 2025 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059775; cv=none; b=HCMZrZLGbxdxgId1lct0h2wlYtLUbZzX5c3J4LaU9QMiHn5hBEn+cks2grGtMziga2bG/96m05G+etnpPbw474Pz8pRAYbh6G5UG2CRWSIgju20ba3auiiP66Ri2W/s4W6xDLRh6Iu9c2AsmQZnAN1WcTtBxWzGxsx2ejb2CdhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059775; c=relaxed/simple;
	bh=4IxQHPmAb3NjL5mQa0oAFxhPVAq8fpKTtW2QfqKxpcg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HPjZn9ybXEr/IgiyLqkR+DxPCcjTXdIKIKxDvWnqj/yR8KYbyBvh6TOXXcWa2HOtGAwEMwTddhs+waGA1ihPjQR7YyBYxhwieEzDP94L5j4dKmFYBZXeoHH/KLwiCqqNOK1xosNXhWMVrOw8+i20m+V5fdcoTJfASD00GqIvnqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=tpEaSE36; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KCCqjP024131;
	Thu, 20 Feb 2025 08:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=/NCZmUDdjkhdulyQwY89SaRH8rD
	5ZYNAaWWkjksia0U=; b=tpEaSE36ipzl1ysKoYVwtB9ZSn5S6gauRXkUcp8fFst
	YTZpS7VhH0r/MRLJZZkOPOCjlcJSTpWpMyPaV24m/xvCdyz8166+4+LvGcMJ5cim
	7/1NUHNjqAzn4ZTgt9TiqA3bUt34Kd8n3do8RkGnVgTfn2CziFMvAIAO99H6LCj+
	VLTvFo6U2yNekBRz2TbbRjrzJ/6nVScXaD4U7Ea2WC6RNfSQyX9RC544/cTS25We
	zcGvz4iDOOFtRY4qRMaDgBSKVHmcyGxxamvXMytQKDbbw+S7T5htkKm0louo5rIJ
	LTJOVD59FFs4l881SULdVtsFSEx9aBSR2hBoM+urINQ==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44x46yrc66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:56:11 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51KDuAsX054116
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Feb 2025 08:56:10 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 20 Feb 2025 08:56:09 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 20 Feb 2025 08:56:09 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 20 Feb 2025 08:56:09 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.155])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51KDtxqn008409;
	Thu, 20 Feb 2025 08:56:01 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 00/14] Add support for AD4080 ADC
Date: Thu, 20 Feb 2025 15:54:10 +0200
Message-ID: <20250220135429.8615-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: MO5n39ntajc5qJTyWlSQVLPvZ3Bua9gX
X-Authority-Analysis: v=2.4 cv=QdWcvtbv c=1 sm=1 tr=0 ts=67b7347b cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=rf51Nvf0UCcQLYGYZMkA:9
X-Proofpoint-ORIG-GUID: MO5n39ntajc5qJTyWlSQVLPvZ3Bua9gX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502200101

The AD4080 is a high-speed, low noise, low distortion, 20-bit, Easy
Drive, successive approximation register (SAR) analog-to-digital
converter (ADC). Maintaining high performance (signal-to-noise and
distortion (SINAD) ratio > 90 dBFS) at signal frequencies in excess
of 1 MHz enables the AD4080 to service a wide variety of precision,
wide bandwidth data acquisition applications. Simplification of the
input anti-alias filter design can be accomplished by applying over-
sampling along with the integrated digital filtering and decimation to
reduce noise and lower the output data rate for applications that do
not require the lowest latency of the AD4080.

Antoniu Miclaus (14):
  iio: backend: add support for filter config
  iio: backend: add support for sync process
  iio: backend: add support for self sync
  iio: backend: add support for sync status
  iio: backend: add support for number of lanes
  dt-bindings: iio: adc: add ad408x axi variant
  iio: adc: adi-axi-adc: add filter enable/disable
  iio: adc: adi-axi-adc: add bitslip enable/disable
  iio: adc: adi-axi-adc: add self sync support
  iio: adc: adi-axi-adc: add sync status
  iio: adc: adi-axi-adc: add num lanes support
  dt-bindings: iio: adc: add ad4080
  iio: adc: ad4080: add driver support
  Documentation: ABI: testing: ad4080 docs

 .../ABI/testing/sysfs-bus-iio-adc-ad4080      |  55 ++
 .../bindings/iio/adc/adi,ad4080.yaml          |  92 +++
 .../bindings/iio/adc/adi,axi-adc.yaml         |   2 +
 drivers/iio/adc/Kconfig                       |  15 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad4080.c                      | 768 ++++++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                 | 115 +++
 drivers/iio/industrialio-backend.c            | 113 +++
 include/linux/iio/backend.h                   |  24 +
 9 files changed, 1185 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4080
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
 create mode 100644 drivers/iio/adc/ad4080.c

-- 
2.48.1


