Return-Path: <linux-iio+bounces-14975-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281F1A27550
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 16:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A791657F4
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 15:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A88218AB0;
	Tue,  4 Feb 2025 15:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="amLJcHNq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E032185BE;
	Tue,  4 Feb 2025 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738681257; cv=none; b=OcwlhRgl+MgicFF1twGGFRaJLO9o7kOPUbLnuO7+GoCnDE99ML6seo4lZQrDdgkfbLmo9jkpT2OKQHEacFZTERwuPjsq8lQjkbz2+98nFjqOkxK86MFEKcUb3cFOGsTPOM31Ne+TAWiEWlgcuVR1qOQ+YoUKAVVcPWYw9Yj5qVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738681257; c=relaxed/simple;
	bh=JrMQtwWvw++t0m1aaUBMCJYoi19hZMjIR3xe0cCFBTw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r40aLupiVgFDO6mI+PVE4w24ssheS9dNUe0ceppRR1/7qeeuGXGhLbxwwPLAWDsgvbsJ1sTD2v4mCn8+yo6woyMwZcCD4b8/HN/bs7UTMuWR8ZLRuttXP5xnCqUWoXu3pZoS2ox6DTpR8hehJtPml/scXbkTR9hCCYArmeIo2f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=amLJcHNq; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514E1rwB006936;
	Tue, 4 Feb 2025 10:00:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=1mdmadFdDewtQKg+KQxOp0uE4Sl
	xF2battpRFh536JM=; b=amLJcHNq8At3g5e9m3vSe5OxNGuSe6dHGhl+IRf7UHn
	ZnKueHHGUp2ZPBXHV01V6Qmt9SHd5rYj9TP5GOLgoIZ53tn+n2xiIR12OuTGTv0c
	J/ah1zrbBm0DV/rd9fyvRCnsnTFTyYvgiw2LUgpPBoAW5dVbt0NOUlAJ9O2AWkYX
	to665ck3Pa63+fHQ0NWBAH8RVFvrqiU7wSbRy9VNX3rUpitcrgRwfdi/NYYZ9hRb
	Y8we61VtA+27yHVw9zJawU0/0A9IZ5fjyrqwoavYvgWMR968cnX880IQd9Y07KmX
	sDdlscffFc4NV+fOgngPPbhuEqZ0AnPzb8GLeVz5u2Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44kma3g86q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 10:00:39 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 514F0bL0020790
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Feb 2025 10:00:37 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 4 Feb 2025
 10:00:37 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 4 Feb 2025 10:00:37 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 514F0IIM005231;
	Tue, 4 Feb 2025 10:00:20 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <cosmin.tanislav@analog.com>, <jic23@kernel.org>, <lars@metafoo.de>,
        <marcelo.schmitt@analog.com>, <dlechner@baylibre.com>,
        <granquet@baylibre.com>, <u.kleine-koenig@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 0/3] Re-add filter_type/filter_mode
Date: Tue, 4 Feb 2025 12:00:16 -0300
Message-ID: <cover.1738680728.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Df7tqutW c=1 sm=1 tr=0 ts=67a22b97 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=oVIT7rmBcKe9iQlKvSsA:9 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-GUID: Awj4fV68aTCQO9pKeZ_qdd9cpbDzoV6L
X-Proofpoint-ORIG-GUID: Awj4fV68aTCQO9pKeZ_qdd9cpbDzoV6L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_07,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 suspectscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040117

Better document sysfs ABI for ADC digital filter configuration.
Also update ad4130 driver to support the standardized IIO ABI for digital filter
configuration.

Change log v3 -> v4
- Renamed in_voltage-voltage_filter_mode_available to
  in_voltage-voltage_filter_type_available instead of just removing the mode
  variant from sysfs-bus-iio.
- Added comment about backwards compatibility near ad4130 filter attribute
  declarations.
- Reordered patches so attributes are documented before use.
- Minor re-word of in_voltage-voltage_filter_mode_available text in
  sysfs-bus-iio-adc-ad4130 to make it more generic.
- Picked up review tags.

Change log v2 -> v3
- Added in_voltageY-voltageZ_filter_type to main IIO ADI doc too.
- Added filter_type attributes to ad4130 driver so it also supports the
  standardized ABI for digital filter configuration.
- No longer dropping AD4130 specific filter_type_available options from sysfs-bus-iio.
- Re-add sysfs-bus-iio-adc-ad4130 just mentioning the ABI at sysfs-bus-iio instead
  of repeating the doc.

Change log v1 -> v2
- Split into 3 patches.
- Re-added sysfs-bus-iio-adc-ad4130 to keep filter_mode separate from filter_type.
- Removed in_voltage-voltage_filter_mode_available from sysfs-bus-iio.
- Added deprecation notes in sysfs-bus-iio-adc-ad4130 asking to use filter_type
  for new drivers and referencing sysfs-bus-iio.
- Improved commit message with explanation about use of filter type attributes.
- Dropped AD4130 specific filter_type_available options from sysfs-bus-iio.

Link to v1: https://lore.kernel.org/linux-iio/b2132bd3ca1d64cdd8d5afab1f1f33c574718b50.1732901318.git.marcelo.schmitt@analog.com/
Link to v2: https://lore.kernel.org/linux-iio/cover.1736261047.git.marcelo.schmitt@analog.com/
Link to v3: https://lore.kernel.org/linux-iio/cover.1738608986.git.marcelo.schmitt@analog.com/


Marcelo Schmitt (3):
  Documentation: ABI: IIO: Add filter_type documentation
  Documentation: ABI: IIO: Re-add sysfs-bus-iio-adc-ad4130
  iio: adc: ad4130: Add filter_type attributes

 Documentation/ABI/testing/sysfs-bus-iio       | 10 +++++++++-
 .../ABI/testing/sysfs-bus-iio-adc-ad4130      | 20 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 drivers/iio/adc/ad4130.c                      |  7 +++++++
 4 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130


base-commit: 9b75dd1b7d6b98699a104c6b1eec0c8817e5fd4b
-- 
2.47.2


