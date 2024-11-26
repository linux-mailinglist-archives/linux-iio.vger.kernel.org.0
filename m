Return-Path: <linux-iio+bounces-12721-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D750F9D9FF1
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 01:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828C5168CB9
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 00:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437DA2F42;
	Wed, 27 Nov 2024 00:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Idvf7GU9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C80D517;
	Wed, 27 Nov 2024 00:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732666658; cv=none; b=PKRkBXiQD0Msxcs43RZaHBuiPs/pmo8TmxBUWOVADPuxIHLueEZ5bdfsAYanHxswVcBQrJPHOhmsl/A8/Tu0zMChKAnJI8njmboAsTpvbNOxv6lDtvJQNMJel9x7z48kGfuboBFq5mO+xoBLc+7PzZ2VlgizS6hnl+rdVRk04uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732666658; c=relaxed/simple;
	bh=3zQGgYViYfddDFudo4XQx+PIFRbdURjDIECwTHZcNVg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hyk7mDxDBih7jrey/a/TX2PMlWPGZtytaTHx6QS5/A4v7a0koHtdQr1ouwJHknx3888QFNRsePrtOlV2jOBWb9zOZpJQfXYMXYhl0fx57JTiv6VHvVLVXKaeEoUwjb5uRD98+KpPY6yt7AZ4pPeAEv/Y21B3PWGttEXMYD4Ycwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Idvf7GU9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQKD623005108;
	Tue, 26 Nov 2024 18:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=Afs1oJHuuK8U+LzMvoQBlS7DAgr
	/xKze3s6A4DgU3so=; b=Idvf7GU9ZrnnzCMXf/tmc6oz0ZFgVyD63KC4Ly0USdw
	wZ3jZoxIgrkM2z13zpzQzJ3nDj0bGD+QgyrOSQS08tngGDS82WrNVoP0vLAR7Acl
	w56X6/lts+5BTWsHxzoPgqv6t/AeirIxZ0gD9l0itZwffNlni0FAJk1KQxnz8zf9
	RM1H7WuBX8GU+2cWjm8tKiyHxekpiEb2APZg/03kSoCRaYHXZvGPlM5GLNsfRuNN
	/nc/+PGH6E/T3ioM8r0URz1hLaw79ipCfOAsAVlr/a3eHl3E+l6rF0h1Fu7UWNQR
	0eOOATJsYBCDmhowp/v/HjXbu1unbudhxX5sCzuVHhg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 433cu71346-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 18:15:01 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4AQNF074016276
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Nov 2024 18:15:00 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 26 Nov 2024 18:14:59 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 26 Nov 2024 18:14:59 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 26 Nov 2024 18:14:59 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4AQNEmur017847;
	Tue, 26 Nov 2024 18:14:50 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 0/4] Timestamp and PulSAR support for ad4000
Date: Tue, 26 Nov 2024 20:14:44 -0300
Message-ID: <cover.1732660478.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-GUID: UCxtWM6RShCt_VpWzjcYCeIelOEathtc
X-Proofpoint-ORIG-GUID: UCxtWM6RShCt_VpWzjcYCeIelOEathtc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411260186

Complement the ad4000 driver with a timestamp channel, a minor adjust in
transfer timing, and support for single-channel PulSAR devices.

Change log v3 -> v4
[IIO]
- No changes.
[Device tree]
- Sorted compatible strings in alphabetical order.
- Left only fallback compatibles in allOf check list for adi,sdi-pin property.
- Improved patch description with explanation about how the AD4000 and PulSAR
  devices are different.

Change log v2 -> v3
[IIO]
- Reverted to direct assignment of ad4000_time_spec structs.
[Device tree]
- No changes.

Change log v1 -> v2
- Added Suggested-by and Reviewed-by tags.
[IIO]
- Commented the removal of unused AD4000_TQUIET1_NS define in commit body.
- Made a common macro to assign ad4000_time_spec.
- Explicitly initialized PulSAR t_quiet2_ns with 0 as those don't need any quiet time.
- Improved PulSAR support commit description with more context.
- Dropped support for AD7694.
[Device tree]
- Made "cs" the default adi,sdi-pin value for PulSAR devices.

Link to v3: https://lore.kernel.org/linux-iio/cover.1732020224.git.marcelo.schmitt@analog.com/
Link to v2: https://lore.kernel.org/linux-iio/cover.1731953012.git.marcelo.schmitt@analog.com/
Link to v1: https://lore.kernel.org/linux-iio/cover.1731626099.git.marcelo.schmitt@analog.com/


Marcelo Schmitt (4):
  dt-bindings: iio: adc: adi,ad4000: Add PulSAR
  iio: adc: ad4000: Add timestamp channel
  iio: adc: ad4000: Use device specific timing for SPI transfers
  iio: adc: ad4000: Add support for PulSAR devices

 .../bindings/iio/adc/adi,ad4000.yaml          |  56 ++++
 drivers/iio/adc/ad4000.c                      | 311 +++++++++++++++---
 2 files changed, 316 insertions(+), 51 deletions(-)


base-commit: 9dd2270ca0b38ee16094817f4a53e7ba78e31567
-- 
2.45.2


