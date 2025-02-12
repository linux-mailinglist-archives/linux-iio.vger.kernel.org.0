Return-Path: <linux-iio+bounces-15457-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5165DA32E40
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 19:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F3B188AB49
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 18:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E4225C709;
	Wed, 12 Feb 2025 18:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="H7ltxvsI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD0C1DC075;
	Wed, 12 Feb 2025 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384182; cv=none; b=f7mOq40ucxtdaztZxi1ooH89X39jjhs3qrzABJmBJxR9kmxwZ7Qqaif1Z4hhxlhST798yWsgq2pD6S0lIM3zelYBDvcaZMS0pk+DaH8BhTmrIWs/vZNsTMQTV5TBIs3OsNP6zXcvKV37tcdVDDuMIeK1Z4vhhtCUXLi06SY4BJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384182; c=relaxed/simple;
	bh=F+ddp0E8y9LH9F/gg9FhbVFc9alvG2IbgpM3lTTq3Nk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rBiDnLn97j0RkOltzmFRb5eOXyvYeyii04FHTH6Uh4pV24WEXD/Agf1CDqfrJ79F3j2TfDryihYlP/yjqr0IeDpQv4uc9h9KFRt2ErJVFYlvEYjRowDmE9I5uh9TwsF8IB1zdE3eMqFpyGeU3YXs+3lb0iv1umc3anwntyddoMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=H7ltxvsI; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CFHXJk023492;
	Wed, 12 Feb 2025 13:16:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=q2+JYf3/wZ2dItUDJ3ENscIRZOv
	quwHJTPgPTubc2o0=; b=H7ltxvsIR8MEGr7thoxaodKlS+BxwxzzKSPzk7JRbud
	NW/d7dG9ykI2sCHdrl6UfA5nnz3Tv12dv32LNRh6patsNWWH1sKZrwqW92+8B2M8
	qSPpC0Ar8yIuSETtjlTT3Zf0aL1mWAIqGVqxKfyGZkbZRqkFL3P4GMO8XfUVeq65
	cB863feYg5INYy3YVtXpyf1zitjCjEjSm0kV0h+NLpeHpohH2yKXNy8ZaXNZm28D
	LU/vCWsGrqUX7wsg2re+ZcPtyyjAIZkqHPLmsVT5PjsE1Kk59bxZBiHSC0JXjlfs
	78NIL1YmaPZ2kARrh3zVxCaPe0MfY7CI3c4xVksHXFA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44rnspk2d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 13:16:02 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51CIG199046376
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Feb 2025 13:16:01 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 12 Feb 2025 13:16:01 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 12 Feb 2025 13:16:01 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 12 Feb 2025 13:16:01 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51CIFlmf017299;
	Wed, 12 Feb 2025 13:15:50 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, <dlechner@baylibre.com>
Subject: [PATCH RESEND v3 00/17] iio: adc: ad7768-1: Add features, improvements, and fixes
Date: Wed, 12 Feb 2025 15:15:47 -0300
Message-ID: <cover.1739368121.git.Jonathan.Santos@analog.com>
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
X-Authority-Analysis: v=2.4 cv=RZxqC0tv c=1 sm=1 tr=0 ts=67ace563 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=DcVhKpCQim4X3dEw7YsA:9 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-GUID: gLAGNUO5i3JiJpYXa_GY4LGLBvoQVJcl
X-Proofpoint-ORIG-GUID: gLAGNUO5i3JiJpYXa_GY4LGLBvoQVJcl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502120132

This patch series introduces some new features, improvements,
and fixes for the AD7768-1 ADC driver. 

The goal is to support all key functionalities listed in the device
datasheet, including filter mode selection, common mode voltage output
configuration and GPIO support. Additionally, this includes fixes 
for SPI communication and for IIO interface, and also code improvements
to enhance maintainability and readability.

OBS: Resending patch series due to issues in the previous submission;
patches were generated without using the "--thread" option.
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


