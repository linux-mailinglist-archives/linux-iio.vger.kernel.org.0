Return-Path: <linux-iio+bounces-26358-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1380CC784BF
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 11:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 2A80A33116
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 09:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09537340DA1;
	Fri, 21 Nov 2025 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1t+fPVkl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D638330B00;
	Fri, 21 Nov 2025 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763718741; cv=none; b=MlUZbLZcOnXsgdKwLNdNk66/xckroXdn41TdeEIo5mZYPIH2hZor+Lg2/lcPlle4DwU0HOJu0htD0gqAvveWEzkRaroe7uS7IgcsvcQ5Cz57Y7bbw8gjd6ThUokzq22ArxxnAcDcNnAlV+u06/xRRVR+YAH5RaRWEegzWSaCkgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763718741; c=relaxed/simple;
	bh=MY0C6BVxLaPatPtXgydcoQY/R+wZioK3GyWYKkzGgtg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TySkNMoPFT9/ID6q0LkqIY7QzNQ1s82jptqm7K8/B8Yi2AyZLHoH9Zu4PZA+bUPrIAXalJGBnT/0Xzo+ISmBgwjmroG1+79AIvfbZC2IzzZJyjcsRpxLQ0TL7F4nTPhVPK4CF0jVoIuH/SbiWnDTjE33nh64Z3Y64TbjtNZ61p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1t+fPVkl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AL8Rjrs3386539;
	Fri, 21 Nov 2025 04:52:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=XvSAM9wSSnAPXxuG8/0e5aPAGtl
	+5KL1Rbr6wVkivbc=; b=1t+fPVklz3m5r73C5SCknpdHyeO9GEbdFp9hcsZl4Sv
	zQtQ/CcvHO2vdt09B89THfv0t2C6q3na7/UIBoFGuOUOFQSs8wRDKQiabRiFnS0b
	Irk52njWQhk/mFugSLx3gLyKML+Kh8JOKWGMXJCT9bBr1WUYWD6EEz9H3za18dvt
	zxIzd+QMaWS6KYq6CcMJjj3mQUoN3kDjP0bZeGIJDbgi5nanMM5alf2oosfHeCzU
	n+eoy9zS3j//opVfBSPDR3vEq4P4C5vtfY6VvR31Ymus6m/STGHTHdqtDxQilyl6
	h6RBMgoNrTV9fjJWeKi8yFdIckPaWUQMhOsuYV5JCRw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ajmkf8b37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 04:52:18 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5AL9qHqp014842
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Nov 2025 04:52:17 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 21 Nov 2025 04:52:17 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 21 Nov 2025 04:52:16 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 21 Nov 2025 04:52:16 -0500
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.187])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AL9q9RC026882;
	Fri, 21 Nov 2025 04:52:11 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 0/2] iio: amplifiers: add support for ADL8113 Low Noise Amplifier
Date: Fri, 21 Nov 2025 09:52:01 +0000
Message-ID: <20251121095204.18574-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=cuKWUl4i c=1 sm=1 tr=0 ts=69203652 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=nGdWsVW0n162tS-kH1oA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NCBTYWx0ZWRfX+VP7YXxT10zG
 EUegZ7tkN0cV59uAUSSV+mUdfR3+RuRiSWrjA0t3OCh+3aLTDmWF7Sk62uAW/Mwg+zNPvodCRCi
 8Cdk8jWstwH8d4kEgtSRjdq4tHKINpFnjlRVVF2clgGYesRyZJboNIDE34JF3RV8NnjI6VA58RG
 x32Kirn9WBoVdW8LyVDjIIEdsXf0Nw95c0Cwty1oUhv4myiLWCwh4bAjs0cjgy1+fJfMnkE38kS
 Zp4QzaY1dPV+GA20OUg1qztVUtAnh+P5/NSfQfjwMpZh/AuRwEmL5tcSdAnFgL5SmwT14hTrzna
 swvx4m6MvO6Qh236sQaWZW5btEI8AvhNxs4joCBEWdr5c4vjhHdOKQCcBduJDmquTgBMDGDQ/za
 W15VVsZLH1jIyM07voXPmseFKZhkTQ==
X-Proofpoint-ORIG-GUID: PR2zP-SeAmRCqOkTuv-5lnXZDLeauIyp
X-Proofpoint-GUID: PR2zP-SeAmRCqOkTuv-5lnXZDLeauIyp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210074

This patch series adds support for the Analog Devices ADL8113, a 10MHz to 12GHz
Low Noise Amplifier with integrated bypass switches.

The ADL8113 provides four operation modes controlled by two GPIO pins:
- Internal Amplifier (14dB gain)
- Internal Bypass (0dB gain)
- External Bypass A (0dB gain) - Signal routes from RFIN to OUT_A and from IN_A to RFOUT
- External Bypass B (0dB gain) - Signal routes from RFIN to OUT_B and from IN_B to RFOUT

Antoniu Miclaus (2):
  dt-bindings: iio: amplifiers: add adl8113
  iio: amplifiers: adl8113: add driver support

 .../bindings/iio/amplifiers/adi,adl8113.yaml  |  93 ++++++
 drivers/iio/amplifiers/Kconfig                |  12 +
 drivers/iio/amplifiers/Makefile               |   1 +
 drivers/iio/amplifiers/adl8113.c              | 277 ++++++++++++++++++
 4 files changed, 383 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
 create mode 100644 drivers/iio/amplifiers/adl8113.c

-- 
2.43.0


