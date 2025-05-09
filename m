Return-Path: <linux-iio+bounces-19371-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 269B4AB1136
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 12:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9593A1C407CC
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 10:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4F0291166;
	Fri,  9 May 2025 10:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="u6J4fl1U"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F98328F51F;
	Fri,  9 May 2025 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787849; cv=none; b=nw0LZiGn+MkXbbYPgBJI+N3Xmn4MN8UniXTP/4Ai9T/e9my3GGaa5AxNsZD+dSK9l1BZbbuSGIv+xyOBi+tZ1kpTGMHPTzHLYoKXx8qfd737q8s9O97JqjxK13zpeZBNtnybP1wwO3QueQt+6VgeTYZB3+y9l6F6D6a6kPuGpgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787849; c=relaxed/simple;
	bh=J/wcDT6qZyY5vPNBfpk3pjfrmURCBKSmkchRCipnz2U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9RCEfQoak+gX++338ApGq5PmjNvl4W+KdKagi83GTN4jrQK3BiEPMTssvBRsJuLSVqB+j0hl9W62cedt9pQMaynlDZvvfgrGAvuHHOtqecotetisX9VeuLQH2BTGKDuUXG1n4liPzoqriZwJjSKOiitvRfPhqHMpv8kKXNGm/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=u6J4fl1U; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549AH0JL001889;
	Fri, 9 May 2025 06:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=RSI4p
	duHjkvPzIQQUDZW5Kd3nXOFACdk0nUJaWx4USU=; b=u6J4fl1UKG8+QWyrMDkTa
	ub6LPHAFiAchgriywnJAw7FB+5gukKSuS1abmwLxNkPzNvwJtc0Uf8Q+PwbBdUGp
	imgdAZtgr98HGG7wIdRGaKDyOyeLjtYqO4IDNlPCEHPhG/lauyRqV7vyFGr6wRQE
	w3hKDKoAyDtRk1gM8+PXnSXspNGp8XMb5hKlRjqo3AZix/pDFKg0K6TGhtA3DeAg
	G7mUV8SjTrFjDXxW0Woe8dAGjWTHd/Cz4KIu3whVxkvMbsCPwFIyQNPpL7WUs+H8
	LU8DZa0ZgBACmAwZ/wBLEbuFc1nLW/Olv3+ASXAVrWkn/j9hZLskWYohq80w8yIm
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46hftdr3w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 06:50:43 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 549AogsX049072
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 May 2025 06:50:42 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 9 May 2025 06:50:42 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 9 May 2025 06:50:42 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 9 May 2025 06:50:42 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.148])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 549AoK1A014223;
	Fri, 9 May 2025 06:50:37 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v5 10/10] Documetation: ABI: add sinc1 and sinc5+pf1 filter
Date: Fri, 9 May 2025 13:50:19 +0300
Message-ID: <20250509105019.8887-11-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509105019.8887-1-antoniu.miclaus@analog.com>
References: <20250509105019.8887-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=CP4qXQrD c=1 sm=1 tr=0 ts=681dde03 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=Jj58fO0nKZ7HuPVzIAUA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDEwNCBTYWx0ZWRfXxwcASVNlwIty
 79hUZp+9UmMPvY0lb9av97PRzCdJIVV/VBpVwY+wCElFWP/pvmTdhgsz6CFp5fobI1TLB0EaM5Q
 JltUHfV41CDc7iA54KOCQdCHWdTv2hFby/rgqm5MToQ5ZGuTFVF4qcb1cEjONtGGWcTBizN/ECW
 Px2NSJZe22q+z0lF+ECNLKinSvpx3WzBN4neEqgvWFF0DLNJDX3eU4V8tvLteXxQKcdvFYdZxEM
 XbmAk74WJXOeUiFuSVkIl10l3iCTZcXMbT51/OC84TZjsLJR5X3spTqeCYQ/5kEybZcURbOV4VS
 ezYi5TFGx+czojr8YpBDnN2EwdAH5BjRJKiL7Id+eJf5QyUfaB/iZIVcDLmC3/V9GlbCLtcRRss
 pARst0UgEMVWgAkGNLt9/N0lgqzVEOMeGLIWfZyUn9kS+4BxZbCElikodfyyWNsPlG0k3aSr
X-Proofpoint-GUID: 0KVRNoHHTKS91nuxIGGFS9TXgbPSuWOS
X-Proofpoint-ORIG-GUID: 0KVRNoHHTKS91nuxIGGFS9TXgbPSuWOS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 mlxscore=0 mlxlogscore=947
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090104

Add sinc1 and sinc5+pf1 filter types used for ad4080 device.

Add these two options into the filter_type available attribute.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index b8838cb92d38..2dfb74b5a990 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2275,6 +2275,8 @@ Description:
 		Reading returns a list with the possible filter modes. Options
 		for the attribute:
 
+		* "sinc1" - The digital sinc1 filter. Fast 1st
+		  conversion time. Poor noise performance.
 		* "sinc3" - The digital sinc3 filter. Moderate 1st
 		  conversion time. Good noise performance.
 		* "sinc4" - Sinc 4. Excellent noise performance. Long
@@ -2290,6 +2292,7 @@ Description:
 		* "sinc3+pf2" - Sinc3 + device specific Post Filter 2.
 		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
 		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
+		* "sinc5+pf1" - Sinc5 + device specific Post Filter 1.
 
 What:		/sys/bus/iio/devices/iio:deviceX/filter_type
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_filter_type
-- 
2.49.0


