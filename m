Return-Path: <linux-iio+bounces-7302-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4023A9272DF
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 11:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7158F1C2339E
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 09:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1AE1AAE0C;
	Thu,  4 Jul 2024 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Mza6HcmC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0AA1A4F27;
	Thu,  4 Jul 2024 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720084951; cv=none; b=XXl0BVGSA6gYNp+uJAzmunTwlc54EI23su7E8k2foZ5nMo3Par9SV9Ef1LwBD8vSRTdjlyBYPRrd973yiqRyJL+UiAv2tYbaxpZ+VjSGlBdyT6mjhvWpjz2TxlasZIEbWwb1ar+FZqcv1CIjdO2Q8WcNoPvtpsj0/UYT9ztP/QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720084951; c=relaxed/simple;
	bh=FM3j6eBYC6DBRvKqO2bJS1PF/k26PJFo78mBeYYmajo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=kjXU1KqeUnuGKns+royYez/Yfsi9Ti5XJbo7c84xL0fPQwrBscMTxz/Pv7psglFkWGvGb+ORgPKBiwRjVnPIKc7m57jMUlsRzkwaM6wgpozQjotoKuvlUzmecMOQHGVX5LPm/d4IoiML7+FkX1rqPrE4noZKyZYHr3cAL4MJQQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Mza6HcmC; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4646iljc003902;
	Thu, 4 Jul 2024 05:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=GdrJvTsJ+AZBrKoztv/qSONgLH4
	MvIxbBUpVh47eqgI=; b=Mza6HcmCGJh+3oXWM/OqHZ5T9r7ucVsCC94zJvk11TQ
	RPOnlEou23+R8dOX2+S+hcpgU8gBii+841FY6QpzDuhzy2RAxPptiuq5Y+OHpXiK
	kwuCWu9K30ZDIDzzEoM/rSepG8J7UMLMX/yjxHIURKpZd4DOpepXI4qYDigJ+sSx
	+tTYFSfltbkax6XbBUBUEIH153eJIhpZmM+MbbujC6lrfl2nMk5sum+u4qlNJOZy
	5aa/n371JEZspudbOo3/8FIIaD7bllOdCs2vRb58685uuWQZIFlxklIeeREVQxCY
	+9JU6kEmrx7AphebXHvTnRwm4E+G85EehXIWBj7XR4w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 405a7natfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 05:22:16 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4649MFhq058891
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jul 2024 05:22:15 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 4 Jul 2024 05:22:14 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 4 Jul 2024 05:22:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 4 Jul 2024 05:22:13 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4649M1di012858;
	Thu, 4 Jul 2024 05:22:03 -0400
From: Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH 0/5] iio: adc: ad9467: support new devices
Date: Thu, 4 Jul 2024 11:25:20 +0200
Message-ID: <20240704-dev-iio-ad9467-new-devs-v1-0-f1adfee921f7@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIBqhmYC/x2MQQqAMAzAviI9W6hVJ/oV8SCu016mbKDC8O9Oj
 wkkCaIElQhDkSDIqVF3n6EqC1i22a+CajMDEzdkmNDKiao7zrZvTIderk9FdDVJ29aGmRzk+gj
 i9P7P4/Q8L/rRZLVpAAAA
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720085156; l=937;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=FM3j6eBYC6DBRvKqO2bJS1PF/k26PJFo78mBeYYmajo=;
 b=mRcuDrqSoTDXKv/928djI61Szt3QkMGi75UL9AqK/VfxFx55QeabszeqNDbe/XNRKg+nfVssH
 lZy9y+3kuzBDz8pE96ybzZvKfCUCWIsNZgqdfwfPjL7BoAQu1h0fYC4
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: S4OOZoDMfLUi3VThxEt0B_xOX1cmGuVi
X-Proofpoint-GUID: S4OOZoDMfLUi3VThxEt0B_xOX1cmGuVi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_06,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=698 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040064

This series adds support for more devices:
 * Analog Devices AD9652 16-bit 310 MSPS ADC;
 * Analog Devices AD9643 14-Bit, 170/210/250 MSPS ADC;
 * Analog Devices AD9649 14-bit 20/40/65/80 MSPS ADC.

The first pacthes are just in preparation to make adding the new devices
straightforward.

---
Nuno Sa (5):
      iio: adc: ad9467: support multiple channels calibration
      iio: adc: ad9467: add new chip_info variables
      iio: adc: ad9467: don't allow reading vref if not available
      dt-bindings: adc: ad9467: support new parts
      iio: adc: ad9467: support new parts

 .../devicetree/bindings/iio/adc/adi,ad9467.yaml    |   3 +
 drivers/iio/adc/ad9467.c                           | 277 ++++++++++++++++-----
 2 files changed, 224 insertions(+), 56 deletions(-)
---
base-commit: 7db8a847f98caae68c70bdab9ba92d1af38e5656
change-id: 20240620-dev-iio-ad9467-new-devs-f30e5536220f
--

Thanks!
- Nuno Sá


