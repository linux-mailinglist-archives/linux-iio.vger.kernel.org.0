Return-Path: <linux-iio+bounces-19730-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9221ABD5B7
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 13:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1CA3A2416
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 11:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F60219A8A;
	Tue, 20 May 2025 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ch7aMp1t"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9250117E4;
	Tue, 20 May 2025 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747738881; cv=none; b=cwnU3Kdt86uF67GzpYVSOFMADzB29yURp0fk29QaCeJxlQbefJqE9YYh+hIygJHbL1TkoRsHpfDYPNSlsfT4W6q1eoPLiVP9yHvVHvlXGrxXk9wH2DtGzpWWm516+w1qwYUMU2lGJJ0gLnLpJ9SotPvswcIwcAAu715mvnxqE8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747738881; c=relaxed/simple;
	bh=aKM7z7V9vZD94uOUrlMczwM0qDHt504xNFxDKQFxpXo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aS7URMXm22IacumTXnaJWA/bx8oiJGADHsaXctnb9zeE3K5+bUFmBvqRjEkHuINuwFwa4slIEtzsiwRmlfTi5Ckxf6ZCO1M64FBK3W7D5w3QNbx26fArrKybpFLqTk2anEG+e1nCTXWHWy+i4a02iQKfl6a8j3xiyyIShL9ieHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ch7aMp1t; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K7BQSG012776;
	Tue, 20 May 2025 07:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=irH1CvHHCc3AEbhxP0+D/coQHo/
	SwCW+R4fTXfR5LLc=; b=ch7aMp1tblR0Q2qFMGMFoCwG1WcIMDYPOZpQRKIiegT
	JLSpS0c9xYYVYooFefAYCpvG0sk3INXkzN2rtOLcQZ9UwLuixREM1ZJCyS4CAVlT
	BqGMgbafITyyfXPL5GsNepNGChmnjrMmnQSrW99Se+p9PjBTHu/+RmistLbNyejK
	dKit7cERHCxRiMIcjE6YCeiZMGn1hZH6BnTDy2T1xvh7VmB9UIW1BQxhT4CfI81h
	2HUIxmZLAXssISf0pfR7opu9A55tTkQZS6I0rPGpGYZ7nCljYxeyrzJYzOuc4RIo
	E0o5g/+OP8G4RecNIJRtOxAChT6igXxpZBD5Y8rMnFg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46psvevje7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 07:01:16 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 54KB1F7W050313
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 May 2025 07:01:15 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 20 May
 2025 07:01:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 20 May 2025 07:01:14 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.168])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54KB1715022189;
	Tue, 20 May 2025 07:01:09 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 1/2] iio: adc: ad4080: use lowercase device name
Date: Tue, 20 May 2025 14:01:00 +0300
Message-ID: <20250520110101.29478-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: qfLX2xrVCwALkOT3_3PFNKnK7_MHdWFe
X-Proofpoint-ORIG-GUID: qfLX2xrVCwALkOT3_3PFNKnK7_MHdWFe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA5MSBTYWx0ZWRfXw0BkIOPYycDQ
 8+6hwjUWrfSvbLBKavbMxGoPhaTlUKmhl2rcConakrt4xwSCcdzGUX20ebg4gEiOWW6a5FAbqgA
 wZgw4ZkT+L77IcML0IDn7S2giWNPc+T/dIicqZFFNCnuNjEtJjSAKitMv3Ien9HCY4j4i9FlPHF
 t8MRQLGh+bxGP608rsjFdUgjvayTEwZFVEE+xiQxptRm6bawayysZLk+OyyTbXmC2tH4C33bA/d
 zcToIvnWaFa62Pxshq6K6pGvUHQmmlnzPggeFvF/oEm30ZyZuDjjBVh5ukaTrG13Q8B1huifcSK
 Znw5jg77m0x1F482DE2LNYpOv5egHILU43AWmTzUUOvLhdaVwYZX6DqdLjbKKd4510jo6y6Yh6m
 H2U7wSznDfodUcNDzmkQC77gjHjseFYF23+2RNVtBHPmH4ypzVJeTVCeQp+t5Ysu51HRp8qu
X-Authority-Analysis: v=2.4 cv=PqSTbxM3 c=1 sm=1 tr=0 ts=682c60fc cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=DGHZmdoWxMtMbgdTRaoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=916 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505200091

Update the .name field in the ad4080_chip_info struct
from "AD4080" to "ad4080" to follow the common convention
in IIO drivers of using lowercase names for device identifiers.

No functional changes are introduced.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad4080.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index e8b2e5e7a68a..c36eb41d738a 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -433,7 +433,7 @@ static const struct iio_chan_spec ad4080_channel = {
 };
 
 static const struct ad4080_chip_info ad4080_chip_info = {
-	.name = "AD4080",
+	.name = "ad4080",
 	.product_id = AD4080_CHIP_ID,
 	.scale_table = ad4080_scale_table,
 	.num_scales = ARRAY_SIZE(ad4080_scale_table),
-- 
2.49.0


