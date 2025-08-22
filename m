Return-Path: <linux-iio+bounces-23153-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDC4B32020
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 18:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22BD1D2819D
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 16:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01FD277CAF;
	Fri, 22 Aug 2025 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SS1uCrt5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9442825B1DA;
	Fri, 22 Aug 2025 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878555; cv=none; b=LxH/zgChn6X0N2ZO+dGaSmoahuFtspu3XIYA9FqLOefQSpbE4IZCa1Bcrp/xlcmR+mHadbHqJH0BbbUNupnO66+IQ4xhD2njXcPGGPzUqTzLBC+ZbHt/lZG9fXQTTZ21OPFMqD2sVJ2Qq/M/fDMoSSR4852MWeVNIhFe6HXZubE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878555; c=relaxed/simple;
	bh=kspGLdPkNtzhu4rQDp5/TVNuldcYtNLHK/6wJj3wquE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kap85PJJ4UX+xi91kmzyKpaxog79s2Jy2NrbhRWDCtyz0r3P2WgX6KAuQtf4MCPeKJa+TYG2LNJn0Br9gFX0kQ8nH1IylC3JaUccFPaf2UIOyuX+4FzgHI/LSqMARS9N7qEE3KDLRFYS2iH5DWt7fqWgvdJg4ZbzgYHyWrHG1vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SS1uCrt5; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MEEmvV004396;
	Fri, 22 Aug 2025 12:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=PozY+
	M/LDTJ0jNL4YP/Fx/ozmIWeWf340wZY8rrkRC0=; b=SS1uCrt5Qr6jIgaUBXCqU
	wBlK+s4X5DkEgYUTq5wtwtDazCxyPvd+PQ0RBfwxJ4bhgPnbXbsNljFgjajgVj4E
	a3cGcp5RWoCLMTduRayysVJH8+PWi/IF06D73wELdjuucVHyZG2oMn6sOjgTYM9p
	8J+8//H8KirXo9yaUCKT/+RHDikxL9IvoDoWeto4HIRnnFSF+uhJwi2+CAHp/AT8
	Gq6qnPdl92dMwpmlBefmDaDagJQi7ELNFmr8IfzxW+PW+irkRUT6wHmh6TlAuzRO
	YxcZMn7zo4pKaAePTwekfDTcpU1D8giQI++t7AUlThXqU2QwgLx1ljL32mIQfy0V
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48n0tdh4uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 12:02:25 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 57MG2OQ2033828
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 22 Aug 2025 12:02:24 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 22 Aug 2025 12:02:24 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 22 Aug 2025 12:02:24 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 22 Aug 2025 12:02:24 -0400
Received: from Ubuntu.ad.analog.com ([10.32.13.98])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57MG263R000568;
	Fri, 22 Aug 2025 12:02:20 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v5 6/6] Documentation: ABI: iio: add sinc4+lp
Date: Fri, 22 Aug 2025 16:01:55 +0000
Message-ID: <20250822160157.5092-7-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822160157.5092-1-antoniu.miclaus@analog.com>
References: <20250822160157.5092-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=bvAVxEai c=1 sm=1 tr=0 ts=68a89491 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=U6ZNB8FNVxHzf_OyWnsA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: KcVwS01EDW1wDpRwWC4SLuRL8xH7JakT
X-Proofpoint-ORIG-GUID: KcVwS01EDW1wDpRwWC4SLuRL8xH7JakT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NSBTYWx0ZWRfX1Gyx0lGlWRJD
 sapyqPY+Yl6thDQ8W24we8ef3RDQcnxuSOpnHKTGAwzS369hmKebT0NvMZs1TQa9v77z5KjlxbW
 76iP8mZo//1JILQIP9L/kgcCnKSsU4YPrldWotUnG2HH2nzCesNgtbnmDfnGcPYF0nMlw94+ekq
 RLKhKfj07vp4MiGsUElI0kxt0eiqZQIygonL8ZZbMcCHUX74MvjK3KYyIlzcr148ChSWZnVYnDj
 MnGkpXtErefAKwdLeK2BQguLeKihdrExiZg/7dxlNrhhaFYCZTBzw9Wt2/1Rxh9N3G0sbHR3tcV
 vO+jWhwiuDakmPcXEapkEJaJHLnOtGtZXSq1hJ25EZQ1lI7q2uHLVkIUZo+o9tXOS+QXPIug8vL
 XtMVdi/zU8PntQEeDMLjl+EK6L/IzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190195

Add new filter type to the sysfs-bus-iio ABI documentation:
- "sinc4+lp" for Sinc4 + Low Pass Filter

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v5.
 Documentation/ABI/testing/sysfs-bus-iio | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 78da68826307..cb300135b4c4 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2319,6 +2319,7 @@ Description:
 		  time.
 		* "sinc4" - Sinc 4. Excellent noise performance. Long
 		  1st conversion time.
+		* "sinc4+lp" - Sinc4 + Low Pass Filter.
 		* "sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion
 		  time.
 		* "sinc5" - The digital sinc5 filter. Excellent noise
-- 
2.43.0


