Return-Path: <linux-iio+bounces-7121-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE9F91F0EA
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 10:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB351C2261D
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 08:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6EF14B950;
	Tue,  2 Jul 2024 08:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="MdN91Y4X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE69514884C;
	Tue,  2 Jul 2024 08:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719908371; cv=none; b=sxIcHw9u6yf0VtR8tYDHqsZ/PVYoo/KoF4qysQFwoAFBEY/KyqF+nynLcDMIWIPUgQ324ItMCJy1nYbSNrDOfuAnwoZaEapzK7/gjs5+PcbRlmiRtBMu/aF1WNUaNr9ag7mspaIhLQVF7sv8W5l/QxoAicFBbt8Pwp15eExf8n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719908371; c=relaxed/simple;
	bh=q5MZcYXTG4Pd0D+0SZGew/DTm9RJ1zf3Kssculi3i88=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I7zG+gilwc4tCdzaaNp8ERRR3uqPWjlJ3XCTtNKduPxfrfCP5+WkjMLxQHExdmH3qyjOvp2cf+tFa3yvxcamdJ1VLeFO4ovpWuYC6yNSMCJU5X9YjkdBKKyfyYEhXngi05MKo+G8qBo2n5s3ueCgiVqzd/plFZpafo9vNfA2i9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=MdN91Y4X; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4627I45A022022;
	Tue, 2 Jul 2024 04:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=za7IYtfl6n1xtDLxO19ry0fEsMv
	qhvDostuZGHAhhds=; b=MdN91Y4XU9DV4NCeL1piqtwgN0Vi1597WhV5WT9Cgvd
	HdD/KoNFvRG7aT+/QE0Nae7aFEuJ6kI/itckdFzPbJhrcR7XWuTGQIRTlgWNShfG
	MP1aAN5q0fC2B1a6diAQxN23uHZxxpH0WT6J+DbwQh7mJm2UfrrRt/OG6nEF+g1T
	oeRKdtI3MO6ipT2a7Yr1REJASOig/6MQQrVXkQrwJXxYbCx/bjAgTBC0qCu/zEwG
	uDXCeDcA4N++4KpoDspVVb0dtrJ1P95vlwx0qv+ZrbLylabFVZ0T9dGMhWtuRxt5
	a4ARyzLd+SBEqTKcV/xqT9f40HOnCtnQaUPu0X7Tb9g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 402f639upr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 04:19:07 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4628J6hS003280
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Jul 2024 04:19:06 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 2 Jul 2024 04:19:05 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 2 Jul 2024 04:19:05 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 2 Jul 2024 04:19:05 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.159])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4628Isft025612;
	Tue, 2 Jul 2024 04:18:57 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ABI: testing: fix admv8818 attr description
Date: Tue, 2 Jul 2024 11:18:50 +0300
Message-ID: <20240702081851.4663-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: kDzv8nf4JqwuyL_bH0-b3w1ubChJY5Gn
X-Proofpoint-ORIG-GUID: kDzv8nf4JqwuyL_bH0-b3w1ubChJY5Gn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_04,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=956
 adultscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407020062

Fix description of the filter_mode_available attribute by pointing to
the correct name of the attribute that can be written with valid values.

Fixes: bf92d87 ("iio:filter:admv8818: Add sysfs ABI documentation")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818 b/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
index 31dbb390573f..c431f0a13cf5 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
+++ b/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
@@ -3,7 +3,7 @@ KernelVersion:
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Reading this returns the valid values that can be written to the
-		on_altvoltage0_mode attribute:
+		filter_mode attribute:
 
 		- auto -> Adjust bandpass filter to track changes in input clock rate.
 		- manual -> disable/unregister the clock rate notifier / input clock tracking.
-- 
2.45.2


