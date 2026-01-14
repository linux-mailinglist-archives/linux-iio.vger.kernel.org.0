Return-Path: <linux-iio+bounces-27775-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DEFD1EE8E
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 13:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D12DB3055D9A
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 12:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87011396D04;
	Wed, 14 Jan 2026 12:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rx/2nAOT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA732FBDED;
	Wed, 14 Jan 2026 12:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394839; cv=none; b=aiTG71+YA9Jrp4YTtFzM0+m6yLrbarLjZP6GiHW2cUnvfpQmbfEU3EAmuXe5iXNbgp5EyWmJb1a3Nu9kXEtWmQCf31/CEnxJcntMgMk4F1cQ88ajvGzRq/x16W8fhj9bhCQoAPs0HIZc+Xz8xZVgF5ohkeFutdYeQAYZQU3vhwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394839; c=relaxed/simple;
	bh=fqE/iW2Pn4jYDv2zxW4AlHGPVpWGgAheApWkx+7iBZk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=brLEIeghkeYYsAs2pw9507xo0GKG7ZgbLq/neohd0SOPTdXO0kJJZMLw6jFdD4N9uLjBKoT7vBOojqkea6ja6NU/ylZD+g7EQUsg33fzQeP56xw9TtIj99GuflvUIRbmhiDMbNteAgKOLoy/XKz1x18BfqfrVitVobaZvIVyaaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rx/2nAOT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EC4qCG3765811;
	Wed, 14 Jan 2026 07:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=+Y0K6MWYjw6b1NU5Gjgchbt2SR6
	Dghjcx2ukTmA2WWU=; b=rx/2nAOTfp0ppzbp9lsLef3J8GVXOoZmYtrWSCGz4/m
	iTdBze4AO7oDxxd1UNb1ZN8m6haBcC9sZMpRRRIpw6gnhO3YQEJliUXljIrHCetS
	XSlIBN2fzkJSi3w9mFfKcLoWgvc6fEBfUsfcAvoMUGP7OhQu3wW106BFVxIzMruK
	JOYWMjDL/6JXnfQ+Q+NiWZlmMRPhPCr3RcNxoR3AQGise4L+10X7TyJW0ArnLmWi
	Ah2ffETzvgt6bnMIQC4v31ybc3qDS7pU4KXySlRUzghLKTeWTuI0GMJC35SyQ8DT
	fgCu1wu2M+hRjx8RSNXIEe/3XaRxmoFvRdawZ0XFYeQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4bpau08gju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 07:47:00 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60ECkwaG061428
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Jan 2026 07:46:58 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 14 Jan 2026 07:46:58 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 14 Jan 2026 07:46:58 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 14 Jan 2026 07:46:58 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60ECkcX7001719;
	Wed, 14 Jan 2026 07:46:41 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <jonath4nns@gmail.com>
Subject: [PATCH v6 0/5] Add support for ADAQ776x-1 ADC Family
Date: Wed, 14 Jan 2026 06:26:22 -0300
Message-ID: <cover.1768350772.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEwNiBTYWx0ZWRfX/fat0h6jQT3s
 iSripvF0nijEYwLz6HvUr67TVA5RzVEPD1Chgo4bpUh8onppcY1C6vYRb1JR/ZKSnCINrwvfmuK
 1JZ46Phf5aNwJm4DbVt30TT2N+4Q1mg0qP73UD9iP4LbNwHY0Bw7tzrSChL7XV8fk6dsv5VUogf
 mLLdBAw2Lfx+cjO1laewy4alnlU2lM2eSXBH6cnWN1nAeRWztgRbgCZPGPAQ0tV09PWMdPboQ3K
 uPq77LVEpRURcPl/D6of86rPTk+MNmnp8rFsYMaQEzl4Rz4RVnPyJ0RsRvUhjsOSGB6Iu0Z79lM
 hxolF4t+uW1vqzLe5VEunDdele6bbCVzg2B4Bs13bXyq/CMV88oIFVapgbWEW1f/Y8ZUn5daEq4
 lCLNM0k3Gnb4CLLxif3YqGmDhCdTYGNWhRWI7PAue3RgpJCuvPtTACX7H0DbkezsLbz31eoa6qP
 DIpiXjxgCjKPJX90U7w==
X-Authority-Analysis: v=2.4 cv=YcWwJgRf c=1 sm=1 tr=0 ts=69679044 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=RBodamOL_v8OAKJrvLgA:9
X-Proofpoint-ORIG-GUID: kw0OkdXEwIyw8pZWRvaLHeYGZ40DtVg0
X-Proofpoint-GUID: kw0OkdXEwIyw8pZWRvaLHeYGZ40DtVg0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140106

This adds support for the ADAQ7767-1, ADAQ7768-1 and ADAQ7769-1 devices. 

The ADAQ7768-1 and ADAQ7769-1 integrate a programmable gain amplifier (PGA)
with 7 and 8 gain options, respectively. The ADAQ7767-1 and ADAQ7769-1 
also feature a 3-pin selectable Anti-aliasing filter (AAF) gain.

---
Changes in v6:
* Use Pattern PER* for all percentage-related macros and include macros 
  for Per mille and per cent mille units.
* Refactored ad7768_parse_aaf_gain() to improve cleanliness and readability.
* Link to v5: https://lore.kernel.org/linux-iio/cover.1765900411.git.Jonathan.Santos@analog.com/T/#t/

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

Jonathan Santos (5):
  dt-bindings: iio: adc: ad7768-1: add new supported parts
  iio: adc: ad7768-1: introduce chip info for future multidevice support
  units: add conversion macros for percentage related units
  iio: adc: ad7768-1: refactor ad7768_write_raw()
  iio: adc: ad7768-1: add support for ADAQ776x-1 ADC Family

 .../bindings/iio/adc/adi,ad7768-1.yaml        |  64 ++-
 drivers/iio/adc/Kconfig                       |   1 +
 drivers/iio/adc/ad7768-1.c                    | 423 +++++++++++++++---
 include/linux/units.h                         |  19 +
 4 files changed, 453 insertions(+), 54 deletions(-)


base-commit: e0bc6d7e258486c10bb11e31fd4421c134063b1d
-- 
2.34.1


