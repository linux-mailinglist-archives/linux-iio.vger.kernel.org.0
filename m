Return-Path: <linux-iio+bounces-19582-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6687AB97A9
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 10:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3ADA068C3
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 08:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC26231858;
	Fri, 16 May 2025 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Qecex/xD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0FD231A55;
	Fri, 16 May 2025 08:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747384024; cv=none; b=kcu9Emt9jNQoqIlbf9CP6X7x5S0k+ty2Nw+7e10hFPM1eH8Ky8w1RJeeE8CTgMW2ogsINq9Z1pzimpEPAHy3RbctKQyAUPoeLnY4SSNa9UNy96tS3yTSOUS5HXbthDsfnVFPImDPZLeNU8r7mqq4rKpzoxpsaFT9gvDwK3Dhpt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747384024; c=relaxed/simple;
	bh=vyxMLZmxWYiwenu6+giMa/I1usvgFZdyycJmA0g9+mk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LguLWsB2+BDUr2ODYWNcDALBqCEUcXQsYG5O2sRYfnN3q/qKQE3nwU0okE2fx2/VqD2/5YdaGB1QJh4F3twCmltpDEEcKFhHe8LFFJPqolXdKCP0/uQ5JSCsZH7+l+vb1SBWaU5EZCMiAmW2abmCEuuHnFeiw0C63Ih0vlXhelY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Qecex/xD; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G5JmSu001876;
	Fri, 16 May 2025 04:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3H5eu
	BVbY8Bnek23yjLpqqTV1wOC1T0xzcGOdxpX/ns=; b=Qecex/xDkeSoNyMIjfIVs
	D+l55DIbn9L1TEOhTRujOvRfQzfJG4y5dIBHLKCTBJXJ26YjKmZRdVymnGuXm4jo
	E4qxzrZ5ZiPUYMwY4rWMjtUPnAwJ8qqkmfd3S+z31jkq8I65leMJoFHVDNZFyr86
	kFz8t0tiJd3RgQSoqMc8nwgP9X3+h/y/8cPIdor7SiK7fKJSh1NHy/2bBdyQNiGY
	52cpA8p61yXSXSrXZHRsOoNW6RTwkEcPG+7Nk21MWNXn8+on2L2n5JqBIZxwsdjf
	aofWlQ+hJoVyK+eH8XWc+YOJfKyl8XqEMb8VKBwqeSA1j6qszO6j0Q1PJewQL9kv
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46ny4a8qk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 04:26:59 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 54G8QwjF033664
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 May 2025 04:26:58 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 16 May
 2025 04:26:58 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 16 May 2025 04:26:58 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.120])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54G8QZwo031549;
	Fri, 16 May 2025 04:26:52 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v6 10/10] Documetation: ABI: add sinc1 and sinc5+pf1 filter
Date: Fri, 16 May 2025 11:26:30 +0300
Message-ID: <20250516082630.8236-11-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516082630.8236-1-antoniu.miclaus@analog.com>
References: <20250516082630.8236-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: m04rQ1e6JqtfprfUJ3SBYs11rhIP_iMb
X-Authority-Analysis: v=2.4 cv=MvdS63ae c=1 sm=1 tr=0 ts=6826f6d3 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=BGrlU3uRz5xgvmwuAssA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
X-Proofpoint-ORIG-GUID: m04rQ1e6JqtfprfUJ3SBYs11rhIP_iMb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDA3OSBTYWx0ZWRfX+91QNo+Ok3zL
 rBNe1xhpWIEcw0M7U0HpFpYFxjA37bK7jWoqBHKwoKqNuxV504ph4+JZuVtFXFysbFLu2exZ6LQ
 vxI/Ru1u+W90PG7qkxt04XOwBaoYa6x+taxqFMdUrUXDLdGDVViEEpJyQJ7YL7x8s37fSGPCh1n
 YWoMBoFnNYlqDcXhVoTFPtyVyMEkzd6M/3xyuqvD2MrtCO6jofEpWPmBxgglh/X6Y689uUbZqUC
 lQWhk+Q9Kx53CRdac2dqzPnBlHo3J23H4DvME2tiLMY28B6TX2D449gTY+Dvbj1EEI6aFyIAcrC
 cLDcoRSy9PdYnshhmqFupYZ5ct1zrjYbpXA0csTsCzOpyh2XiWy+pwLTFA19ZHGcL3454iyXUlB
 RL8t2pHJDQHr91l1z4KXs0bVZuRYM+RnTXGzWIpAVqePrZOvBVJtWIxGy2/OF1wXlmalJ6fD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_03,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 phishscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160079

Add sinc1 and sinc5+pf1 filter types used for ad4080 device.

Include these two options into the filter_type available attribute.

Add also the option for filter disabled.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v6:
 - add doc for filter "none".
 Documentation/ABI/testing/sysfs-bus-iio | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index b8838cb92d38..c67b63653441 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2275,6 +2275,9 @@ Description:
 		Reading returns a list with the possible filter modes. Options
 		for the attribute:
 
+		* "none" - Filter is disabled/bypassed.
+		* "sinc1" - The digital sinc1 filter. Fast 1st
+		  conversion time. Poor noise performance.
 		* "sinc3" - The digital sinc3 filter. Moderate 1st
 		  conversion time. Good noise performance.
 		* "sinc4" - Sinc 4. Excellent noise performance. Long
@@ -2290,6 +2293,7 @@ Description:
 		* "sinc3+pf2" - Sinc3 + device specific Post Filter 2.
 		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
 		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
+		* "sinc5+pf1" - Sinc5 + device specific Post Filter 1.
 
 What:		/sys/bus/iio/devices/iio:deviceX/filter_type
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_filter_type
-- 
2.49.0


