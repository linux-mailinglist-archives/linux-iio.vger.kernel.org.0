Return-Path: <linux-iio+bounces-1730-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF2483069C
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jan 2024 14:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C2C287E5A
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jan 2024 13:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E858C1EB36;
	Wed, 17 Jan 2024 13:08:04 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856AB1EB2B
	for <linux-iio@vger.kernel.org>; Wed, 17 Jan 2024 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496884; cv=none; b=hYebg7tIuUg6bfsBsPi+IRFshEziWMz0c/BvLAYuSDYVkCPIhf1D22JNBzqjMDDwyzaq7W0n+BKsEZNzB4ENZDhb9eVtNMuupnxSfLVl2BdvhaNc/3i7yfQfD4RQeG78y9bIHHgntvBYdaxlllIXb6XYxnBUK6d3zCJoogSPSbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496884; c=relaxed/simple;
	bh=KPZSUGWf+IqIb2W9Qv0Gh2YhDQ1fqyiDABaPa0ogpEY=;
	h=Received:Received:Received:Received:Received:Received:From:
	 Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:CC:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=AjkKpfVQe2oDWDXtNxpR3qEojwJEQ/RgQ3tUkZZeD6HIV1foOPN1H3D78re/dDldaqLCeck43Zk4AF85VJ4inCO+Fp1VJTrQlmVfijsmgyttY94v1R+tUwBuVfwM3c+7cYdTFsNBXEffY2t9biNLRPPHQNK6cGecgLv6u50IXr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H9r6Ix016278;
	Wed, 17 Jan 2024 08:07:50 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3vnm166q3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 08:07:50 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 40HD7m3T032879
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Jan 2024 08:07:48 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 17 Jan
 2024 08:07:47 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 17 Jan 2024 08:07:47 -0500
Received: from [127.0.0.1] ([10.44.3.50])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 40HD7ZCj030917;
	Wed, 17 Jan 2024 08:07:37 -0500
From: Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH 0/3] iio: imu: adis: misc fixes/improvements
Date: Wed, 17 Jan 2024 14:10:48 +0100
Message-ID: <20240117-adis-improv-v1-0-7f90e9fad200@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANjRp2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQ0Nz3cSUzGLdzNyCovwyXUuTNEsjCzML48SkRCWgjoKi1LTMCrBp0bG
 1tQCcio0dXQAAAA==
To: <linux-iio@vger.kernel.org>
CC: Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705497049; l=817;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=KPZSUGWf+IqIb2W9Qv0Gh2YhDQ1fqyiDABaPa0ogpEY=;
 b=36kFCnMZxm6Hn3Kq/eH2I+g63UPQM6rvcnhdA33C744ngiTwuVirZkNwAiHiZty2q0CGRSmGR
 g44TVmwlfYdCPinlLnr9YfGXvv/1jK9U5Ap2/E7By0iUXj4z0Ez0ZS3
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Rvige4t1nreuMbdiXBuO1wY7RelJERU3
X-Proofpoint-ORIG-GUID: Rvige4t1nreuMbdiXBuO1wY7RelJERU3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_07,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=444 phishscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170094

The first patch is for ensuring proper alignment for the sigma_delta
buffers so they can be safely used in DMA context. I'm adding a fixes tag
on it but the deal is the same as in the sigma_delta series.

The following patches are just about code simplification (no functional
change intended).
 

---
Nuno Sa (3):
      iio: imu: adis: ensure proper DMA alignment
      iio: imu: adis16475: make use of irq_get_trigger_type()
      iio: imu: adis16480: make use of irq_get_trigger_type()

 drivers/iio/imu/adis16475.c  | 8 +-------
 drivers/iio/imu/adis16480.c  | 9 +--------
 include/linux/iio/imu/adis.h | 3 ++-
 3 files changed, 4 insertions(+), 16 deletions(-)
---
base-commit: 801590b27bfbdb6721f85e2c3af70e627e52c8d5
change-id: 20240117-adis-improv-94f928683aba
--

Thanks!
- Nuno Sá


