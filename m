Return-Path: <linux-iio+bounces-27145-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C4CCC7BC1
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 14:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6AD38301C1A8
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 13:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE723559E3;
	Wed, 17 Dec 2025 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KLy5gQND"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D1A3559CD;
	Wed, 17 Dec 2025 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975384; cv=none; b=XomsEB/UhtMu7Z5fQArcGxL3IprKLnwt2+eU9115FqNrhCdCEoNwHx6+5hOjXDP7CqmrNm4/2LJ4sm1omT5GA9b37zoO+uJxkPYOt6IGGUojPJRKMO22OxPo+oRX4BZ39N0e99JPhJZQPXgfGpSMqFy2DYfLUeEeuBUCnqlhh8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975384; c=relaxed/simple;
	bh=A1/IwyhuHOX+5mmLy3vaEK5HHt8Ue95dnT2Ixpmo3l4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ic7TeGJl2Mew9AgSUbLIUOC7Ko/PWf4NydJgn5GZYdOZKKrcEcMftyKPJOBwSFNO4X02yLoa6dmovDAhsxL7W5Fxs5kOA7Iq9pcrjFapP3CUL+p6Bpx4sWy/jPkr7CKfPxRf8O8adrXGGRD1xI/wyUd3Vzt1VfjVOb+Y3bNQFjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KLy5gQND; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHAqq6g3839561;
	Wed, 17 Dec 2025 07:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=u+Jqr2CCrZIK9Mr/ypi8EMitlsv
	W31q+ALUCssDDxXE=; b=KLy5gQNDA3z0VCVBy2sfw8jOD5qFFrDhFH7d/91n3DW
	wZyRQJzWPMkaIopX4W7h6jOEOXlUJ74c6tXkMlGtR4ZJesYug8ZBjOcmWsxjyI1d
	t+F5VZ00J1oYa36Rg7jHcV2QU4/W1/+4FVETKyZzkEAQOnDeA+ORaT+d2mGlnFLp
	2J5YF1+Fbj1xbbfzDb2GHGr3DDaQ0i70prOOXHsZQHz699+8x+pJZ7uWYBa3GZT0
	ErzlfG4MBh1FFX80WNUfkr4mYcioZrT7r7+4kQ5DCDl1GR3LkgtxdpsSBdZvsUzi
	EzNuzW4evIk3QSzlraRxoSnhZwlgstgISq0ss+EwIyQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4b3jw9jj4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 07:42:46 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5BHCgjBL043069
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Dec 2025 07:42:45 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 17 Dec
 2025 07:42:44 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 17 Dec 2025 07:42:44 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5BHCgT0M015731;
	Wed, 17 Dec 2025 07:42:32 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <jonath4nns@gmail.com>
Subject: [PATCH v5 0/5] Add support for ADAQ776x-1 ADC Family
Date: Wed, 17 Dec 2025 02:52:12 -0300
Message-ID: <cover.1765900411.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA5OCBTYWx0ZWRfX/oXFruO/x9QL
 jLKAopUeFy/zrHRn9OORG+cJgCT8P3+EMgJwXRfyRym2y5C3NQJD5JrlOZeKTES8khhETqUcY5A
 um7uBVPXhoFKRIyeQYTf9klCa/pC9JbFz3SY+raXUQJZtuxapsZbtx6V8LqQwgYyDodIfu7L9U0
 2kOgQbnKiDcSWlWUNEtMVzSVmRKl7wXFuz9sSyN5G8njf6s1H9I/mPGCyF2nyXH5r88gqbEk6SW
 PlKjBv5HbxQ4UbK7qQF1TJ3OMGPqaIyIVfqnoPhugjy7qsJqATwTHDWmxYNHam00YFmBQTIh6S0
 bdDGzXKmaA2pe000l4B4k1q1zAHFIBvmFnt9UoyMsDbp/JNZJCeTFrN7CTEwGBIlUgzL/QFLerB
 SbBJu2gfzKy1RLr0U8j3br96xYlwEA==
X-Authority-Analysis: v=2.4 cv=TZGbdBQh c=1 sm=1 tr=0 ts=6942a546 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=RBodamOL_v8OAKJrvLgA:9
X-Proofpoint-GUID: W8gswQl6DAClJCFhlP5VO9E9K_fqqaWU
X-Proofpoint-ORIG-GUID: W8gswQl6DAClJCFhlP5VO9E9K_fqqaWU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170098

This adds support for the ADAQ7767-1, ADAQ7768-1 and ADAQ7769-1 devices. 

The ADAQ7768-1 and ADAQ7769-1 integrate a programmable gain amplifier (PGA)
with 7 and 8 gain options, respectively. The ADAQ7767-1 and ADAQ7769-1 
also feature a 3-pin selectable Anti-aliasing filter (AAF) gain.

---
Changes in v5:
* Added PERCENT macro along with BASIS_POINTS in units.h.
* Added new patch to allow writing attributes without direct mode claim.
* Write scale attribute without direct mode claim to avoid deadlock
  when using GPIOs from the device's own controller.
* Link to v4: https://lore.kernel.org/linux-iio/cover.1764101647.git.Jonathan.Santos@analog.com/T/#t


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

Jonathan Santos (5):
  dt-bindings: iio: adc: ad7768-1: add new supported parts
  iio: adc: ad7768-1: introduce chip info for future multidevice support
  units: add PERCENT and BASIS_POINTS macros
  iio: adc: ad7768-1: squash __ad7768_write_raw() back to
    ad7768_write_raw()
  iio: adc: ad7768-1: add support for ADAQ776x-1 ADC Family

 .../bindings/iio/adc/adi,ad7768-1.yaml        |  64 ++-
 drivers/iio/adc/Kconfig                       |   1 +
 drivers/iio/adc/ad7768-1.c                    | 428 ++++++++++++++++--
 include/linux/units.h                         |  14 +
 4 files changed, 453 insertions(+), 54 deletions(-)


base-commit: daea3a394a8b425a2dd206ab09eb37f0d1087d35
-- 
2.34.1


