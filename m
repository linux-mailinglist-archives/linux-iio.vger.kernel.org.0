Return-Path: <linux-iio+bounces-4635-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E428B5A93
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2024 15:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324B01F210F7
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2024 13:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9437F74E09;
	Mon, 29 Apr 2024 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="abpxbv40"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABE6745FD
	for <linux-iio@vger.kernel.org>; Mon, 29 Apr 2024 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398700; cv=none; b=pP15xpduFj/I4FfBx7wGGyRuSQkeq2fg/YiqO96pI04//NKzBakZmfLg1QQZKAY84HFLrqtRNQIGXnOLWV7S89h5GKypJb5PKdG4+SDnnu9KzzRx3a3wzOLKffU8uPNi8VTYCGTGI4lp5qUQZCyqqrxJ/VU+ms9TTt/yZd71jUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398700; c=relaxed/simple;
	bh=mrhwHgoQ1CWWEnt6m2M91twvGMUFm+T1ZFJUxhVCRmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=S+IQdCq75qLaV981f2GOSbyY8Bf/kGVyhxWrnqP/Q3nne8XhUdMaRLZzommgvZu6Dz/B/vK9ZXLAW9aFhkkbb3cBnv9Ag5yo09EYNS/WsMObaaK3g2561GtJQmZ1WX5LkVphxWBUYNlcxK9qgXVWQH16mlNm+PnuTWHuUtytWjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=abpxbv40; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43TD347A016935;
	Mon, 29 Apr 2024 09:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=DKIM; bh=dP3woZij
	WoZVqsvFzibWoiQQNga0jDwidZicQXfxHsY=; b=abpxbv40sCnti5zZOrIR4hjS
	IhYg94Hr3OHG6MBwCeZ6Yxnl3JyuO27/CLw0jpWI1XItjCiOVw3Fuo8xXZUPs52x
	FC9L03x4pRKy21hXI54xpvblW+kInW1sobLRHub+T6oloDa6Aj4woY7/XbQruSEE
	lgmfEcEPTFtuo148EXC36y5b/qXdWE5euUeM+YmWm/cTpEDvZbpuZ1Wr5VAYPV3X
	kmDhCYuqWz+MY6Z242vd6t0KXXshSabDmhvVApkXTv4YPcLo75eXBgP3oth3j/D9
	+7foIJc6Re3lUiD8nXbANbt1OR2wWhQ13iTq/ANq5LHBbI5625IlOkK+yvMlcw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3xsetbvyxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 09:51:19 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 43TDpICJ057902
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Apr 2024 09:51:18 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 29 Apr
 2024 09:51:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 29 Apr 2024 09:51:17 -0400
Received: from [127.0.0.1] ([10.44.3.54])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 43TDp5MQ021315;
	Mon, 29 Apr 2024 09:51:07 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Mon, 29 Apr 2024 15:54:39 +0200
Subject: [PATCH] iio: dac: ad9739a: write complete MU_CNT1 register during
 lock
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240429-ad9739a-improv-v1-1-c076a06a697d@analog.com>
X-B4-Tracking: v=1; b=H4sIAJ+mL2YC/x3MQQqAIBBA0avIrBPUrLCrRAtppppFFgoSiHdPW
 r7F/wUSRaYEsygQKXPiOzToTsB2+nCQZGwGo4xV1jjp0U2985KvJ965kdDrkRTiAC16Iu38/sN
 lrfUDG7/FrWAAAAA=
To: <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714398883; l=1955;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=mrhwHgoQ1CWWEnt6m2M91twvGMUFm+T1ZFJUxhVCRmk=;
 b=83FNGgFgK9Q6UmsBvbV9haKe+bre/EhUJdvSLHKWpQDDmXkMC7dSF18NfhzomQWE841fnIKOG
 U/zfgvKsLLNBxaN50MLZ1zEtTNgti6taOMv1SueXyif+DO+MG2La+er
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: alTepTXrT8RGkvHfGsExd7xy-j0cmnTs
X-Proofpoint-ORIG-GUID: alTepTXrT8RGkvHfGsExd7xy-j0cmnTs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_11,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1011
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404290087

As specified by the datasheet we should write the value 0x3 (enable
plus tracking gain) into the MU_CNT1 register during the MU lock phase.

Currently we were only setting the enable bit (bit 0) as the tracking
gain default value is already set to 1. While we should be mostly fine
in assuming the tracking gain will have the value it should, better to
explicitly write it. On top of that the datasheet also states to
re-attempt the writes in case the lock fails which we were not doing for
the tracking gain bit.

Lastly, the recommended value for the MU phase slope lock (bit 6) is 0
but for some reason the default value is 1 and hence, we were not
changing it accordingly.

Note there was no problem with the MU lock mechanism so this is not
being treated as a fix but rather an improvement.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/dac/ad9739a.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad9739a.c b/drivers/iio/dac/ad9739a.c
index ff33120075bf..f56eabe53723 100644
--- a/drivers/iio/dac/ad9739a.c
+++ b/drivers/iio/dac/ad9739a.c
@@ -45,6 +45,7 @@
 #define AD9739A_REG_MU_DUTY		0x25
 #define AD9739A_REG_MU_CNT1		0x26
 #define   AD9739A_MU_EN_MASK		BIT(0)
+#define   AD9739A_MU_GAIN_MASK		BIT(1)
 #define AD9739A_REG_MU_CNT2		0x27
 #define AD9739A_REG_MU_CNT3		0x28
 #define AD9739A_REG_MU_CNT4		0x29
@@ -220,8 +221,8 @@ static int ad9739a_init(struct device *dev, const struct ad9739a_state *st)
 			return ret;
 
 		/* Enable the Mu controller search and track mode. */
-		ret = regmap_set_bits(st->regmap, AD9739A_REG_MU_CNT1,
-				      AD9739A_MU_EN_MASK);
+		ret = regmap_write(st->regmap, AD9739A_REG_MU_CNT1,
+				   AD9739A_MU_EN_MASK | AD9739A_MU_GAIN_MASK);
 		if (ret)
 			return ret;
 

---
base-commit: b22457f6c572c1b453207d13613a4e476d3dd0fb
change-id: 20240429-ad9739a-improv-adeda16e0dd5
--

Thanks!
- Nuno Sá


