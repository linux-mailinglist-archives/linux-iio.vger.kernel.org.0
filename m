Return-Path: <linux-iio+bounces-25326-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C37BF5E95
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 12:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEF97502ADB
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 10:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB48832E738;
	Tue, 21 Oct 2025 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QsJW2kTI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4679232E6A2;
	Tue, 21 Oct 2025 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044061; cv=none; b=pIWiYVQQdVM/2DiCtDtPSzsdr5XKAK4+0bgupMb+n0n5BnTi5zDT3i15Gcfhyc+ru9f0Y3EZFcXB3rVDWuiWhb42ybgInUiel7QTEk/INsni2J1tS0JyMCWzh4rFRESwKsuQpUJzcCtvRn508sA3eLXDn5QVAZW07/Yj4hIOgmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044061; c=relaxed/simple;
	bh=nhstXw68qPkj+poR2pfsuybCQtcRqHQQ5NSXLsuOtM4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDHIDQN9DJioDz0ubxEL6eEl2m8WlG+jqJVp//RGdDc+jHZHqaXd4dwnp1Led1XaYMi6/hMprE4UZF2iATIsMveH4Reph6q+f/xSCZG2Xv6K303oAoWlIBM4LG4ouY8jr9HFrydFa+c1IuTt3xbV1q0H1PnBGmSNUo+9MHUAT7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QsJW2kTI; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L9qf5E026565;
	Tue, 21 Oct 2025 06:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jpyh5
	UHPIwBjmL6vwIsNQM3Kcmm8gX58vFkaFpk58SY=; b=QsJW2kTIV+GBXFLb2/TqF
	MpGB15TYtdTZTRaNSTiAfT0EqPy8tPfuS6TC8d5vWpxUS6iIhlVUOITlTksoKKgf
	lmmr8PL04efEcAQ98W0SRXUcVelc5AHoFrKd2zNhBr3YnLOHgyWoN2Kh9wIx6rXb
	54gXy7oB0T76En4k8LYhy6uh8vsxZ0b6bbKobR6i6B9nbwqhN2xWTnLuqOcmzN8M
	PkJZkHR6EZltncxuO7CQvmmRrUlotgQQKmBiVpgjOjfdBeZw9eULOL+c7ATIft3S
	XgVt5cHqBAEXPp/5G69xjR7vVnf6X2qYbJ1T4d85kEYYewVljjSpeKzTQ72IojZg
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49v7t3f459-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 06:54:18 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 59LAsHXT061044
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Oct 2025 06:54:17 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 21 Oct
 2025 06:54:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 21 Oct 2025 06:54:16 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.161])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59LAs1Kn002507;
	Tue, 21 Oct 2025 06:54:11 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 5/6] dt-bindings: iio: adc: adi,ad4080: add support for AD4087
Date: Tue, 21 Oct 2025 10:53:47 +0000
Message-ID: <20251021105349.21145-6-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021105349.21145-1-antoniu.miclaus@analog.com>
References: <20251021105349.21145-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDA2MiBTYWx0ZWRfX6KgVFqMeWDOL
 qEogc71LVXLKXJAG+ZonCLGaD3PsLDCbSDgrbMNhLRLfDLsUg2lHL5Mjxd+VfvVnqAqYHTpLx9/
 wuxeVeti0X+RzRcvDOE5Cws/TLWKa+IQFqt2rv4oq95k81LKNusKAohZ6idqvcQbYj5ck3VL5UU
 qTyCfE1qZlv0hvYsaP/e9H/u+G/HY05XOedxUnT+oRzznFdaySmjXh+fUTDDlcGMYCaom3gBzN2
 MYAqqiFbskAW1xkuEgxP60TzHjDGgeZV3fxV8jJ9+U4Qlx4++iJsqh+0clt6s1qatlNWVbOq4ta
 Wa26QH7l+M9NliCUEEt9xP3phloBkaYlOhy4OmAhgFm3Gctj85f9zENeTRRNIVjSg3aKAkZNXCR
 GVeMVfphBCm3Z4zpqlvmH986L+DUIw==
X-Authority-Analysis: v=2.4 cv=UPPQ3Sfy c=1 sm=1 tr=0 ts=68f7665a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=SRnQe2WNJfzaPNS0TT0A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: cQlxghB1idgGrn5w6l8-xOK_mRDDFBfI
X-Proofpoint-GUID: cQlxghB1idgGrn5w6l8-xOK_mRDDFBfI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180062

Add device tree binding support for the AD4087 14-bit SAR ADC.
Add adi,ad4087 to the compatible enum.

A fallback compatible string to adi,ad4080 is not appropriate as the
AD4087 has different resolution (14-bit vs 20-bit) and LVDS CNV clock
count maximum (1 vs 7), requiring different driver configuration.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
index db136bff45b7..ccd6a0ac1539 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
@@ -30,6 +30,7 @@ properties:
       - adi,ad4083
       - adi,ad4084
       - adi,ad4086
+      - adi,ad4087
 
   reg:
     maxItems: 1
-- 
2.43.0


