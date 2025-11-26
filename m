Return-Path: <linux-iio+bounces-26499-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AF8C8C1EB
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 22:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A6884E72F3
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 21:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D54332EC8;
	Wed, 26 Nov 2025 21:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0JIIpJgT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32E0201278;
	Wed, 26 Nov 2025 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764194183; cv=none; b=GEwXqdExuL9dSmDAnTaAnDCj3tw7bMWexPjmHQhP1Zve1ObVrwDO04FEt6uc+65IA5qiPlS645Er2ud01eAtx18O9iC0zmlAbVfIyjnyNCC5+35k8d/NOxnrfHCwMP9zGkBYhYlzwOtw+zvf/TqugspFHWs58vQoIyD2Y98s27U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764194183; c=relaxed/simple;
	bh=CHobtmRNYNk50c+ySTgooKD6I4+bC+CKoWkRaXJ157s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dxnpNkTfc0+PNRBcMQ1vE9g5g+5eEd8OMltBSpatB/y/ACKOp/Ig2G5XEKIrqvvoFd4p6pmN/qU8lcc1jp6UCoN/AL4NF+F2eyUcZNLGaqbB8kuHPWxEobcwNNpRDReOqRprLAJF78hdS/KcbNidVNs7/MB0F4WbXSlfLKDyfsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0JIIpJgT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQHmPvU2016713;
	Wed, 26 Nov 2025 16:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=jHOXY5Ps75V6LrhXfGeAC854IlQ
	K9lrNRmK6lUg7hTk=; b=0JIIpJgTyPSEY/v1q5TpM99BonlbadRL15yE7YWoJCz
	ZWMgZK5nO5guhOMBAsULlhsMr6xRS0vKiVuihuGWxHv0U1irymwS9cpM0qPTaKGr
	HWFwhztsqcveG2i/fe19smhlCXLKBfVpqZztoUrw7P9FoMYv9vcDWS4co0fjPIbV
	2MRmWefDYGBk6rJQX20kzarKheS8ALucSTiVYq2dUWTEO8ZVhIVqSxXSfhe9JQqF
	oJrcO5aSQcJoPaMF/6AcnCtX5CandpSYC6GtiuuvHAoJOgO6rRlZDN9YUBifKvFR
	tIBAvOBHia1A9xfATeqeOMs33k7H4j3HqhsWKnrCO4Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ap2wcj0s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 16:56:06 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5AQLu5LK035492
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Nov 2025 16:56:05 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 26 Nov
 2025 16:56:05 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 26 Nov 2025 16:56:05 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AQLtpxd002837;
	Wed, 26 Nov 2025 16:55:54 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt@analog.com>, <jonath4nns@gmail.com>
Subject: [PATCH v4 0/4] Add support for ADAQ776x-1 ADC Family
Date: Wed, 26 Nov 2025 18:55:49 -0300
Message-ID: <cover.1764101647.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-GUID: e6FrJCYh-y6RJtl_AcCRztW39F5ZqhZ-
X-Proofpoint-ORIG-GUID: e6FrJCYh-y6RJtl_AcCRztW39F5ZqhZ-
X-Authority-Analysis: v=2.4 cv=E7PAZKdl c=1 sm=1 tr=0 ts=69277776 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=Okd9DVRjih-662Yax-MA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDE3OCBTYWx0ZWRfX3OHkUpQJEmAr
 V0m5RwHDQcaSOPwxM/yYPtUT3Uhc1ger0BLucRXi2/XMlMt+1QsnfStTTvKrmtmg2DTUA2aPDDr
 ztc+K2k3pgpQG2OTbI5nX0RePr8hW32arG4A1pp5KfDSBPUoRiroqkSoRHgClmNDnYkbxilUd7c
 dPlY0UMdVxMo0r7x7mSBwZJIf1XEUkWjyVKSQAb+xVp460AKGgAWyJZpVHXulVAb4MK3WnEt5OW
 V/AqIARZi3Xk3rDxTOfx7JOTf++SIXK3Alx/lENjrMaxnx9eBfJ4YBUopaBWzWe1wdTTAdHKRD+
 vyuBUnwAVr0Yf0TCdgBjjqT9pExVR8MtcDkeES9YEWFJDcp6oxn63kmMr7F+BITjj+9OuP6+68S
 MEy0kpAIU4ojvrPrsi+Em5cK6mhUzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511260178

This adds support for the ADAQ7767-1, ADAQ7768-1 and ADAQ7769-1 devices. 

The ADAQ7768-1 and ADAQ7769-1 integrate a programmable gain amplifier (PGA)
with 7 and 8 gain options, respectively. The ADAQ7767-1 and ADAQ7769-1 
also feature a 3-pin selectable Anti-aliasing filter (AAF) gain.

---
Changes in v4:
* Removed u64_fract type patch, as it is not used. u32_fract is sufficient
  for the PGA gain calculations.
* Added new patch adding BASIS_POINTS macro to units.h.
* Included pga-gpios property for parts that support PGA gain.
  Before we were using the internal gpio controller to manage the PGA pins,
  but still exposing the controller for external use (causing possible conflicts).
* Addressed other review comments, see individual patches.
* Link to v3: https://lore.kernel.org/linux-iio/cover.1757001160.git.Jonathan.Santos@analog.com/T/#t

Changes in v3:
* Renamed adi,gain-milli to adi,aaf-gain-bp. Now it represents basis points
  (one hundredth of a percent).
* ad7768_channel_masks removed along with available_masks element in
  ad7768_chip_info struct. It does not add anything for single channels,
  so not needed, at least for now.
* New patch adding 64-bit fractional number types to math.h.
* Moved aaf gain parsing to its own function, and now returning after
  warning to avoid setting a variable when it shouldn't (avoid confusion).
* ad7768_set_pga_gain(): removed the pgia enable check, relying on the
  regmap cache.
* Addressed other review comments, see individual patches.

Changes in v2:
* adi,aaf-gain property renamed to adi,gain-milli. Default value added.
* fixed some commit messages. 
* Added 'select RATIONAL' to Kconfig.
* Added lock to protect PGA value access.
* rewrote AAF gain check and replaced error returns with warnings.
* Addressed other review comments, see individual patches.
* Link to v1: https://lore.kernel.org/linux-iio/cover.1754617360.git.Jonathan.Santos@analog.com/T/#t
---

Jonathan Santos (4):
  dt-bindings: iio: adc: ad7768-1: add new supported parts
  iio: adc: ad7768-1: introduce chip info for future multidevice support
  units: add BASIS_POINTS macro
  iio: adc: ad7768-1: add support for ADAQ776x-1 ADC Family

 .../bindings/iio/adc/adi,ad7768-1.yaml        |  64 ++-
 drivers/iio/adc/Kconfig                       |   1 +
 drivers/iio/adc/ad7768-1.c                    | 386 ++++++++++++++++--
 include/linux/units.h                         |   2 +
 4 files changed, 422 insertions(+), 31 deletions(-)


base-commit: f9e05791642810a0cf6237d39fafd6fec5e0b4bb
-- 
2.34.1


