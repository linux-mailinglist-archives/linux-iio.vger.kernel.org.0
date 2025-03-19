Return-Path: <linux-iio+bounces-17100-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6EBA692C8
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 16:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED154809E3
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 15:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A721DD0C7;
	Wed, 19 Mar 2025 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hSJJjtbx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A661DA314;
	Wed, 19 Mar 2025 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396294; cv=none; b=RNr9WOOGwKilfFiZ6+iDSfZZ0F4hT99vJbylLZ4WhGEDZ1GFYslb4dvNnjmJvlPdz4D/H4Apm0MalQjEWXXDBlNGDjpm7c8ouRK6PAHbuBdB1r4gQTenWxrCrqZDFX2wyaNvo5Ps5oDa/DCik0YlS8TQIYUxmpEU3A71Q13o4HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396294; c=relaxed/simple;
	bh=H355dxdG0Xsn4lZoOnn81EO/WIXIxpVgYqHnPiaIH+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a/KC66AJdUsAiQfThBJDVnAgIIPNtu7dmaeoblz1h0DJQ48Bk5PQI24DCjLjWE8MUNF3FrxFzMOwBMZRZYMmMbPqrJABdl1uDlX0jJ907lCIPYRh2CGA+zrQTTRxq5K7oX4c+cTRHeUn/b5LPzDJaYwpQnpDnIGCZgfLt4NjoIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hSJJjtbx; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JC29u4031606;
	Wed, 19 Mar 2025 10:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=nr3gM
	JBeM30PXhkwotn96DJDbh2wJpdNOHdPtkfpqF8=; b=hSJJjtbx9/ypwxGmijey5
	/8nsM6RtwVwzYNofvDxhGScuBLEK4TgLv0J0VXXdZ8G7/DSlV4DekXN4RWwLQg2j
	scQDGW1BU0njRbxJxTq3QgwdfnsUSUzKYpK8rA5IxXfXhj0hWNIcWiyDHuocc40o
	ojg8EDrr7lJHmdt6f/JI4w/2VNWxYH2NHmCP4HYfM43FK3PMdDwZg3ZwnlYrj1eT
	DL2S4yTh73JL/pechZlnQQH3crc6N0KDvsVl88pMnx+A5JOGC12hxVD21cL+5oIc
	yCuEqW8bT5gMJ8BYuV4QnYH/uQ+utNB7mKrIOQJSMCBLo5GJ78nkmdqQm484xe3g
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45fwjx0xny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 10:57:58 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 52JEvvxZ043992
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Mar 2025 10:57:57 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 19 Mar 2025 10:57:57 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 19 Mar 2025 10:57:57 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 19 Mar 2025 10:57:56 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52JEvg7v025140;
	Wed, 19 Mar 2025 10:57:44 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 3/5] Documentation: iio: ad4000: Add new supported parts
Date: Wed, 19 Mar 2025 11:57:40 -0300
Message-ID: <4ad6c3d6dbfac9d5e9321a23a647cf333d7f96b6.1742394806.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1742394806.git.marcelo.schmitt@analog.com>
References: <cover.1742394806.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=V/Z90fni c=1 sm=1 tr=0 ts=67dadb76 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=Mo7kHg2TyUSTJzBVpLsA:9
X-Proofpoint-ORIG-GUID: lIZbbnWB9-uNSG7Jh8C8_J-XTSKYU35Q
X-Proofpoint-GUID: lIZbbnWB9-uNSG7Jh8C8_J-XTSKYU35Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_05,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190101

Commit <c3948d090080> ("iio: adc: ad4000: Add support for PulSAR devices"),
extended the ad4000 driver supports many single-channel PulSAR devices.

Update IIO ad4000 documentation with the extra list of supported devices.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/iio/ad4000.rst | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/iio/ad4000.rst b/Documentation/iio/ad4000.rst
index de8fd3ae6e62..5578a9cfd9d5 100644
--- a/Documentation/iio/ad4000.rst
+++ b/Documentation/iio/ad4000.rst
@@ -4,7 +4,7 @@
 AD4000 driver
 =============
 
-Device driver for Analog Devices Inc. AD4000 series of ADCs.
+Device driver for Analog Devices Inc. AD4000 series of ADCs and similar devices.
 
 Supported devices
 =================
@@ -25,6 +25,21 @@ Supported devices
 * `AD4022 <https://www.analog.com/AD4022>`_
 * `ADAQ4001 <https://www.analog.com/ADAQ4001>`_
 * `ADAQ4003 <https://www.analog.com/ADAQ4003>`_
+* `AD7685 <https://www.analog.com/AD7685>`_
+* `AD7686 <https://www.analog.com/AD7686>`_
+* `AD7687 <https://www.analog.com/AD7687>`_
+* `AD7688 <https://www.analog.com/AD7688>`_
+* `AD7690 <https://www.analog.com/AD7690>`_
+* `AD7691 <https://www.analog.com/AD7691>`_
+* `AD7693 <https://www.analog.com/AD7693>`_
+* `AD7942 <https://www.analog.com/AD7942>`_
+* `AD7946 <https://www.analog.com/AD7946>`_
+* `AD7980 <https://www.analog.com/AD7980>`_
+* `AD7982 <https://www.analog.com/AD7982>`_
+* `AD7983 <https://www.analog.com/AD7983>`_
+* `AD7984 <https://www.analog.com/AD7984>`_
+* `AD7988-1 <https://www.analog.com/AD7988-1>`_
+* `AD7988-5 <https://www.analog.com/AD7988-5>`_
 
 Wiring connections
 ------------------
-- 
2.47.2


