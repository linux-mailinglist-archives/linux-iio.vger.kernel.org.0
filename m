Return-Path: <linux-iio+bounces-17269-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFB9A71780
	for <lists+linux-iio@lfdr.de>; Wed, 26 Mar 2025 14:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB65D177C46
	for <lists+linux-iio@lfdr.de>; Wed, 26 Mar 2025 13:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151101EF0AD;
	Wed, 26 Mar 2025 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Hxzxy95i"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEB31EEA38;
	Wed, 26 Mar 2025 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742995548; cv=none; b=SzZDah+c79B4fPoaNjAJi4WrenFD5pbLLjK2bUbzxCYqM31VWceWHRCgUEhscUsHGurW5yJjLdkT+kR4v4TEhLW1j+OEPVVNAL8eD0aPFrQdcCXhnQpqKFIHyp/tiY9iyqw2zGCBCmAesXdFtIeCv8pNKwCzNNwytZL965qkkvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742995548; c=relaxed/simple;
	bh=H355dxdG0Xsn4lZoOnn81EO/WIXIxpVgYqHnPiaIH+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TC472bU2FdzcOUPKBf4rMEn5s7I0RsRQCtshdf2Bs9ez8zL2G5su8tARSCHcTAjJlLdlxa9Duf0euTRjlYn83eZRUf4/VO3L2YAb3axI4drN7v4m1I8Dkii0FSG7KiOreQ24bWp/Osa9TZ9nEgOSjWAM+10CBfI8sWSGbQvsaYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Hxzxy95i; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QDFgYF023409;
	Wed, 26 Mar 2025 09:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=nr3gM
	JBeM30PXhkwotn96DJDbh2wJpdNOHdPtkfpqF8=; b=Hxzxy95i6SyE2U0HC0BZM
	qiKjxQ8tMTZlg+Ns3/hI4+dqJwZKc6GwwtudkayZpBRpcxMTl153bYZTU2WcfBeD
	DBUYovsmx9kkr5byThwH0BQ5iSI5fiiFeYPwRv/gciwX94xSDhQwuQ2Lur7RlsPQ
	nyxDeArQWoGv6HYDIvghWR4aYyu81vnjJnbUKanPd9V9qLutyqDjY3npINngOopv
	40PLYTC7IInkSjav92XIZBZqbhUF4IPZBy3z1Ua+qzy4+7n0NHvK9XRRWV2upZg0
	DQAIodEMIl1IYtKdYo5MK42fuYOfipBhakI7h5DHSwAFKpsgenLjP+dv+RaMZCgS
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45krwh766e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 09:25:31 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 52QDPUt2043146
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Mar 2025 09:25:30 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 26 Mar
 2025 09:25:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 26 Mar 2025 09:25:30 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52QDPFmp007576;
	Wed, 26 Mar 2025 09:25:17 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <corbet@lwn.net>, <dlechner@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 2/4] Documentation: iio: ad4000: Add new supported parts
Date: Wed, 26 Mar 2025 10:25:13 -0300
Message-ID: <bb57e4452cb6bf9f644c0ea2c248d4b72ecc65b8.1742992305.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1742992305.git.marcelo.schmitt@analog.com>
References: <cover.1742992305.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ATR3kskSbH8hakxsnS_L3aDDQWM_zRvq
X-Proofpoint-ORIG-GUID: ATR3kskSbH8hakxsnS_L3aDDQWM_zRvq
X-Authority-Analysis: v=2.4 cv=IuAecK/g c=1 sm=1 tr=0 ts=67e4004b cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=Mo7kHg2TyUSTJzBVpLsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_06,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260082

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


