Return-Path: <linux-iio+bounces-15379-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E28BA319C7
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 00:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F243A7465
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 23:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834BC26A0A0;
	Tue, 11 Feb 2025 23:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="eok11hbJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7152D26A0AE;
	Tue, 11 Feb 2025 23:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739317678; cv=none; b=bx82ftYdMD2jeG3CgBDGK6YQyE1WU++lkGFm9nTaoil5GJm+xuShysMOCZsLB/YYCMb+6HLM7AgCq5yKo8PPi1ympmDGtALnQptgsaHh4sxHBTc9Vva1ejaN9as1HsRTbf1t05/58W4i2OWH/7UUEUoIxc1HKt5Lwgq8MI8ZNgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739317678; c=relaxed/simple;
	bh=a/5fkw/9B9O10VHmyzZD1LRyjCU4vglXrIMpHZxGZRI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NHwbBd4ySEK54VxzFmrIfxenxAyfsPy9lc05BO3dpzOXMeKNlBoPdhoTdRPk2QrDWumEmLjfpgqenPVW00WTkao/LTIBELMYs8PsS8L0765rbjhRnUNtVcAiJxEzZ8pVoku1l4YbSlribv1Le4v7/+b5Rr5O1t3z9Vb/PTemM7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=eok11hbJ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BJXLST002742;
	Tue, 11 Feb 2025 18:47:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=tkFxcxTE4GZyrj7JwrgQNbVIJRi
	f/t1yLTIf6Z1MtMU=; b=eok11hbJ0pSlc38+xeX0NQ8XguobgorWEyHvZASXVsy
	2QKDzwNT8pR31OiTzZzPqu5FHN2Sy4sizU3sxnGKmNBjg8s0yRuam8K3j+Huz5tY
	QYDBZ2NRS7nofiUD7pDqOSU9MVibOsWDYQCzcGZvHmcM/KBCp3ZPb4gNDyaRlavf
	p6jOFQHbOMFBZEgpxlUCCQ4P+2yPLMYTvONHwE8t2O+hVWsxXvGuoX+7FUPBXHqP
	YNtBsNU4xOlCfHKV7WukXjvsFOhr3eVCslGflfjSFJXsQkPEvK36XY8VSzdr9unZ
	/ik+0OV9OvTTHIK1O9eWd+xPdXC1vbhxKpCXR2gwuJA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44r857j5tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 18:47:42 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51BNlfFG017046
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Feb 2025 18:47:41 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 11 Feb
 2025 18:47:41 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 11 Feb 2025 18:47:41 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51BNlSGu009887;
	Tue, 11 Feb 2025 18:47:30 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 06/17] Documentation: ABI: add wideband filter type to  sysfs-bus-iio
Date: Tue, 11 Feb 2025 20:47:27 -0300
Message-ID: <20250211234727.1008437-1-Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 2Zo-1JP16-JP0uCC1z7ZYkONvvfW3ZkF
X-Proofpoint-ORIG-GUID: 2Zo-1JP16-JP0uCC1z7ZYkONvvfW3ZkF
X-Authority-Analysis: v=2.4 cv=U5VoDfru c=1 sm=1 tr=0 ts=67abe19f cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=3Hb1o_MSCnf1oSB8FUQA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_10,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502110158

The Wideband Low Ripple filter is used for AD7768-1 Driver.
Document wideband filter option into filter_type_available
attribute.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v3 Changes:
* None, since we still did not agree on a better name for this filter type.

v2 Changes:
* Removed FIR mentions.
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index f83bd6829285..9b879e7732cd 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2291,6 +2291,8 @@ Description:
 		* "sinc3+pf2" - Sinc3 + device specific Post Filter 2.
 		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
 		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
+		* "wideband" - filter with wideband low ripple passband
+		  and sharp transition band.
 
 What:		/sys/.../events/in_proximity_thresh_either_runningperiod
 KernelVersion:	6.6
-- 
2.34.1


