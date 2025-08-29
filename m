Return-Path: <linux-iio+bounces-23368-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6D3B3BA40
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 13:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25985A20B46
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 11:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBB2314A63;
	Fri, 29 Aug 2025 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Nq/bywy+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12B72D0C8E;
	Fri, 29 Aug 2025 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468384; cv=none; b=EJaLWRWZcvOkMh9AXOJBg1RaNWVURGk5Bo2e3FTRmzqjeUnFDMYwdYR5TbnwiTgnQcLlgy/qsobFxrBrxgfvVVKZtTD1kjypToLvEZEh85DM6cqg4hdOfxrVlUwR994n+c1kM2HjEPU/PxsDwKeCgTNpT0EvTKQoPBXM1WHJqKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468384; c=relaxed/simple;
	bh=J5GiYU0yvL3LPpaCVHMw2znaR61FT6kq/g1DIBrfj3k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OzhgGV2Ba4QW09d70bGzIZV0YIb7HiStKzP8KUPuTIt6YCjjLqzvRdL/ksWwUG6pNua/c0RY+2yXll7MO7H7rIrTfil3OD/IUPZ8u58Nhx6FvewzfLmiAwcm23+F2A+QuNeqqj7P7ZvcRdHTW9OKThInlxgWQ7zIe66v/FmV5VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Nq/bywy+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T8xbAu016244;
	Fri, 29 Aug 2025 07:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=pFdLi
	IoiIMfvbUeKgXfvNtubzXpDL+pf8/XF9Mqa31U=; b=Nq/bywy+4JsE6bmCG0gVq
	5T9Z35wbm8/SiXGZZ7XKSgg2XoD5hwncziTe1s3156cznfRxgMZCDe3OVyI1111K
	ddHxowpRWarV4ca5r9S5LH+8kQ0GF8bIZxh96gsJwGEsX4uZXcQh5w9WIbR7I/Wn
	R/8GW6Mvm+yh9JzaJqi3Awyhb2xpUZf1gtgNBgtHyfRoKh/0ONHbuKoJvK2Z+4AM
	9onP4+ozcESLo28H08b2AkvzzYD5OLd5R8ejtkIO1pTGpFlVfmU6wC6Cv5DBJqPv
	gWF3PbYMRVH4jMUbTXUGuho/XhQtPuiuguwqlwpRo4oX+CgpD1rAKYCOgsPEv1sV
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48u966rq2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 07:52:54 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57TBqrvO036278
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Aug 2025 07:52:53 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 29 Aug 2025 07:52:53 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 29 Aug 2025 07:52:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 29 Aug 2025 07:52:53 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.226])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57TBqdAX017911;
	Fri, 29 Aug 2025 07:52:50 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v6 6/6] Documentation: ABI: iio: add sinc4+lp
Date: Fri, 29 Aug 2025 11:41:40 +0000
Message-ID: <20250829115227.47712-7-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829115227.47712-1-antoniu.miclaus@analog.com>
References: <20250829115227.47712-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: BsuVtOTVzqNAapqFQUhpVslzq8zm52gr
X-Proofpoint-ORIG-GUID: BsuVtOTVzqNAapqFQUhpVslzq8zm52gr
X-Authority-Analysis: v=2.4 cv=J6Wq7BnS c=1 sm=1 tr=0 ts=68b19496 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=mZV6OjMThpI3IlpCzlYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI5MDA3NCBTYWx0ZWRfXzeXuFWSKybUU
 2P3uPDCnR74tygsnUH9FmFEumb9woKCtXmWZUxYMSEbQM4QZgSrXa8mKJzewkOQ3nPy6r22xsVB
 6A+szKdp42MuqzvQIJmc8v8VYmbgWN3a8Vf1SIy5JD7CWXaIY3hBP0uVkTJh6fOjKMNIGuvR1Xg
 P2VXpGpNB8XKJWuUo8j2qjll03Mih70s8oB333LEsTLj0uQ6EaseCI3truL+Umf2SXn2OUba72Q
 kIztu16s0wacvr7htWgFIAyrUVVAyCg3BPgDQMeecJ6fHqr3vJQH/tSN6ohy2b7hwFPcBccjSbZ
 GorOWXha73E7jDDD4JSHYXYfKhqtmQMb3LT6t+zxLlF0lytd+zzI7PQe8uBumk4G4wko+0NLXQ6
 ZIIDPm2r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508290074

Add new filter type to the sysfs-bus-iio ABI documentation:
- "sinc4+lp" for Sinc4 + Low Pass Filter

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v6.
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


