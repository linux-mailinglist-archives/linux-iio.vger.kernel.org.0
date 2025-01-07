Return-Path: <linux-iio+bounces-13965-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E34A043ED
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 16:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9A01886473
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 15:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A8E1F2398;
	Tue,  7 Jan 2025 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="m+g/Imfj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E0C1E377F;
	Tue,  7 Jan 2025 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262874; cv=none; b=JUB5JBn9/i05JDgyBtPlfRzL2mccBaghwfseKMALZ7BawNWpOjfLA6FEq5W8sL9x3XzKVfylGVRg/soYpumJXoIt7HOwaP4Ra626fn2QMvWjF95sME1qTRCrRnCFNxRt0BwFDheQv8FGGbtLoa+ZtovJDRw1iRAl91a9cVuY0e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262874; c=relaxed/simple;
	bh=NMYUwlFnQ00zAJN/gcwg4jMYr2nTTDrMP6U2gBts5Zo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PkvhSNEn/Gzi9ypQqh43eoAopEYLKl8TN0vAcSc5gmOsSh46kCrdxd08b2d++4w1UDmT1AtdY+CqGRHZ/bF1Q7DqKkv/qR1o3Bd63TqoXZ08CFcMDAA/fNs9xBcstB8o1Gsem4SsETltpMRNdOA/MdH0vS+E46KFISjd/dyv/dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=m+g/Imfj; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507EvDpi008016;
	Tue, 7 Jan 2025 10:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=d5mL9
	MyfdZRgNBJPVHrhytM+BCqFw35SuFYUL/7tsSo=; b=m+g/Imfj7QlMr2FyeCp/P
	UmWdJcrIQxVLyHImfUhp9CP5M/CdwuI6fwcBWeDg/5TC99UKHGn4P+IbMhG7o2s8
	kQ1u/4XKAOdYGsGA+BulBgtBV274s0Coei5vYS4AEm/j4o3RacEyjj9ZHJnnAVV0
	aFLPX+95wgvTJE6NBV4ELKQM5ui+gHB1UUN0ODktvTRxIj06ScIDUos+4i3I+ARD
	aT67Yd7npuk445NkE5b1jlbE4hc0s9DuuOSP7CmNuXQIEqQpbNGJgEl5S4Kkssvu
	SrSSCmKl2pJ9kIyJjqarz2J6pVsVVMXA6AvgXxCTa4IoaHsqxyga5/7pzi3LhuGy
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4410d0spr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 10:14:16 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 507FEFaH033754
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Jan 2025 10:14:15 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 7 Jan 2025 10:14:15 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 7 Jan 2025 10:14:15 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 7 Jan 2025 10:14:15 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 507FE0Rl029900;
	Tue, 7 Jan 2025 10:14:03 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <cosmin.tanislav@analog.com>, <jic23@kernel.org>, <lars@metafoo.de>,
        <marcelo.schmitt@analog.com>, <dlechner@baylibre.com>,
        <granquet@baylibre.com>, <u.kleine-koenig@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 3/3] Documentation: ABI: IIO: Drop AD4130 specific filter_type_available options
Date: Tue, 7 Jan 2025 12:13:58 -0300
Message-ID: <5b86acb56fd2aa337223a6467c1caf2a06682fcd.1736261048.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1736261047.git.marcelo.schmitt@analog.com>
References: <cover.1736261047.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: X8qqxE_DsBT09vwd1KrMT_naTkk4kBOo
X-Proofpoint-GUID: X8qqxE_DsBT09vwd1KrMT_naTkk4kBOo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070127

The only driver exporting filter_type_available attribute is ad7779 and it
only supports sinc3 and sinc5 filters. Remove options that are not
presented through filter_type_available attribute.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Maybe this is not worth it (or desirable?) since the options may come back in
the future if new drivers happen to need them.

 Documentation/ABI/testing/sysfs-bus-iio | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 1ddf3d7dd2b3..946c519f8687 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2280,24 +2280,13 @@ What:		/sys/bus/iio/devices/iio:deviceX/filter_type_available
 KernelVersion:	6.1
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Reading returns a list with the possible filter modes. Options
-		for the attribute:
+		Lists all available filter types. Possible options for the
+		attribute:
 
-		* "sinc3" - The digital sinc3 filter. Moderate 1st
-		  conversion time. Good noise performance.
-		* "sinc4" - Sinc 4. Excellent noise performance. Long
-		  1st conversion time.
+		* "sinc3" - The digital sinc3 filter. Moderate 1st conversion
+		  time. Good noise performance.
 		* "sinc5" - The digital sinc5 filter. Excellent noise
-		  performance
-		* "sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion
-		  time.
-		* "sinc3+rej60" - Sinc3 + 60Hz rejection.
-		* "sinc3+sinc1" - Sinc3 + averaging by 8. Low 1st conversion
-		  time.
-		* "sinc3+pf1" - Sinc3 + device specific Post Filter 1.
-		* "sinc3+pf2" - Sinc3 + device specific Post Filter 2.
-		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
-		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
+		  performance.
 
 What:		/sys/bus/iio/devices/iio:deviceX/filter_type
 KernelVersion:	6.1
-- 
2.45.2


