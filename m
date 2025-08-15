Return-Path: <linux-iio+bounces-22756-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5677FB27DA1
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 11:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4680C588ADD
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 09:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281C22FE07B;
	Fri, 15 Aug 2025 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ofQgVmnB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C692FDC32;
	Fri, 15 Aug 2025 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251870; cv=none; b=MLfbiqe9fDojs7AJNDZSpDN9YSRc3jpzpQvdnd12NtXZW3NvMW5Yj/o5Aa5HqILDltN6yi146r0gAhb6FacR1Djt8Y6J4TVi8aKUKpWq34BMXV1AgSy+bqhmmQDl6qMmGnf5Cd9njMZD9yUH/vxUD0gDijmrh4x6c1vn63oqMxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251870; c=relaxed/simple;
	bh=Q1UBPkWMlzZipcMrvvaZw+zth4fxYWAALQUS+9HbCKc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c05wMCQtZEi6IITMdHMKxeUikF36ugOFlYzqFudln39IcmgJ7AUJsdtwMVlVmitvxPRLqjLm7Qrm7xiS/UxFYX4atC/jmbDYm/1otlIk6x1Aa5wFVqNbydQ2bt9QPS29EXw+Y693a8kbtkzDKpL06HaNkRGinR4O95J0GRM+5Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ofQgVmnB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57F8oJFK006855;
	Fri, 15 Aug 2025 05:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=zJxsD
	CATAb2E2uCWzu1Gcil7LGV3F+sWNQe5nju9lw0=; b=ofQgVmnB0ivfetHuwzYYv
	ZoJlXcg1MNk/lgr9pO11rTyxMX23TjKFzjHjw3Vo4syFABCAQGC/PD6bMyJ77m//
	MmOhaWwJDP39rhYOtXxS1pUCKUWu+Q1J8xHc8hZEUGaE5vOJC/InXIExuXJKa0rf
	n4D3thV4SIt4wTwutzT37mtKwHtXBqBbJno0Vx8b9OoVtpOtrmVswmMFOe1bO+hu
	8MLkAoLbJF5E7GOVaH6sYAl/QKlrT7NDv2vUK/mMn4Q0XsMwIwwVnFks3ADIjZXU
	qX7YUdAU6yAIfVzaQYgY7W94jiz2gYMOf8HFQWhIwsiR0LB8Y9dntQteWGkoZU+i
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48h58mgfgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 05:57:35 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57F9vYLB034257
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 15 Aug 2025 05:57:34 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 15 Aug
 2025 05:57:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 15 Aug 2025 05:57:34 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.226])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57F9vJix027486;
	Fri, 15 Aug 2025 05:57:30 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 5/5] Documentation: ABI: iio: add sinc4+lp
Date: Fri, 15 Aug 2025 09:56:38 +0000
Message-ID: <20250815095713.9830-6-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250815095713.9830-1-antoniu.miclaus@analog.com>
References: <20250815095713.9830-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDAwMSBTYWx0ZWRfX8vALX7gwalnF
 H7QCAT55FepCGsjCi36cXKCsN9BYWzcE0Yguvl7e1gvagCSpw7H0z33EfCwsrRaRrlkAz1LMWgQ
 6cu0zLtxEpk55bu5EAaTaVWF8VFvdynydYBxsD/3abVhB0Ce1U7f/MVzXGijpZCJ9jop09rVcoQ
 xCFpqhweVuLzm/XcekngoE7QdRJhIfehTchrOxoDDa5caF3/bwaoCNllhwy1rVM0GLys5ZHe2sm
 Bw1APdTUFY2p3wKtG5qszdmAcAUISOvED8M8c98b+HQpbGikHb1dNiVJQzACcGldfRN6DnEv7PB
 zgVDRjccbnVi7QCDLeAdxBluovnvP9sUXmStbriO0YU+BLIoiBla0s5SelOBfZ5zCgJIUtW53+z
 7e2G2s+n
X-Authority-Analysis: v=2.4 cv=BsGdwZX5 c=1 sm=1 tr=0 ts=689f048f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=rzIQo91_iFM3IlyHPcMA:9
X-Proofpoint-ORIG-GUID: 0t2LfOpmXPTOBwU4lbj271mT4zjXaHtm
X-Proofpoint-GUID: 0t2LfOpmXPTOBwU4lbj271mT4zjXaHtm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508140001

Add new filter type to the sysfs-bus-iio ABI documentation:
- "sinc4+lp" for Sinc4 + Low Pass Filter

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v4:
 - reorder placement of sinc4+lp
 Documentation/ABI/testing/sysfs-bus-iio | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 9d283b23d3c0..53289c085e0a 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2317,6 +2317,7 @@ Description:
 		  time.
 		* "sinc4" - Sinc 4. Excellent noise performance. Long
 		  1st conversion time.
+		* "sinc4+lp" - Sinc4 + Low Pass Filter.
 		* "sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion
 		  time.
 		* "sinc5" - The digital sinc5 filter. Excellent noise
-- 
2.43.0


