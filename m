Return-Path: <linux-iio+bounces-17299-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F90BA7403C
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 22:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A976D175690
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 21:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2B71DDA3E;
	Thu, 27 Mar 2025 21:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dbLmwXTU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D4B1DC99E;
	Thu, 27 Mar 2025 21:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743110727; cv=none; b=u00aIGhr/h+KeA3+3edqj9oHw1H2Yg3PYB+iPhceFx3wbXrKMJgFmFyfQ19ExTvuf8DnxOb/sRVU5xk7ddvQh46JldktvH/XzsD+iBNvKBgHkINaIJV1zLhXusovCXoZYCC6i4ZcCq3ueprso+7vuEqYN2nauteS4JAOR8CnU2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743110727; c=relaxed/simple;
	bh=YGEY1i0QhOzuo+4o4g8H9d3Ca2Xp6u5rUuCWfYE/nQU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOX9g5ZwM23fvTgeY4go5BAUaDnkmF2YayxsrePEmMdinx1dynrzT9yKTIVWA+RMwU5eFaBSF2Q3pmVr05A51rXexdjladWWwX1gc0dH287qqngZAbFBbXpD4FHTgu2RwOBjj66vDBWShaxOWHJ906qt8/2g7i3Q3v7jVnb9/Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dbLmwXTU; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RK9Wcs010423;
	Thu, 27 Mar 2025 17:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=YUnU0
	KKlkUVQvDTJu39A1ZMeGYWfwhvPlMJ5OkihYnc=; b=dbLmwXTUWhwBC5Ms9TTO9
	N4AvTYg193gdzbyBtbRbazbN4dd3gVvmyB6/21oT/oO9Nhfu6q1upSee5XXlY5z3
	yLVihwAEkUIh/aVThC2kJPhyem9zalXKbxZaLcQW7V71Ic8VrN4i3B1CqT8VTUQt
	krPVKaZLoQisQAe7AvUZ3CYs5P0GdttB0t5vB0yoAJaotTxXLj6dGQeBpQn5WlXI
	t4C1btk0EsL1xSOl2atupGK4iFYe66+jO1JnfrZnjvPAchTymbJBBPn1UJPP4ZO9
	8DzRIFt28OQzEz3LSJvb8l39IIyzgVODVyjt36/MmoWZZ0cM5DZSR5uU5nVAJpXc
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45mwxcdkmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 17:25:11 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 52RLPAOa047397
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Mar 2025 17:25:10 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 27 Mar
 2025 17:25:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 27 Mar 2025 17:25:09 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52RLOtUM022527;
	Thu, 27 Mar 2025 17:24:57 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <corbet@lwn.net>, <dlechner@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 2/4] Documentation: iio: ad4000: Add new supported parts
Date: Thu, 27 Mar 2025 18:24:53 -0300
Message-ID: <2b602abd0773af91e7ccd9dd7a2afe67f4792f95.1743110188.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1743110188.git.marcelo.schmitt@analog.com>
References: <cover.1743110188.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=AdmxH2XG c=1 sm=1 tr=0 ts=67e5c237 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=Mo7kHg2TyUSTJzBVpLsA:9 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: uAXMozB3m4vA-5UgTFecpKwzdB76EvJ7
X-Proofpoint-ORIG-GUID: uAXMozB3m4vA-5UgTFecpKwzdB76EvJ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 spamscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270144

Commit <c3948d090080> ("iio: adc: ad4000: Add support for PulSAR devices"),
extended the ad4000 driver supports many single-channel PulSAR devices.

Update IIO ad4000 documentation with the extra list of supported devices.

Reviewed-by: David Lechner <dlechner@baylibre.com>
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


