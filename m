Return-Path: <linux-iio+bounces-22482-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18324B1EEAE
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 21:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2001C270F6
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 19:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457722749F1;
	Fri,  8 Aug 2025 19:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QBNd2E7G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944F22236EF;
	Fri,  8 Aug 2025 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754679749; cv=none; b=lR6yDinIqN2cr7z63D14cw1XCwe537A03ExSX6Wc1nmFhjesa0odmrHh6P83WZmFaI7Ry/SaDZnLE9QFPL1no8ylO+2gSHrBdvC6g4f4JDrAncZTfotmxY/qodduqKRE9k7TVaH7+bT5YpbN2Dlku1pIFkjyQKVKPmSOE44UGuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754679749; c=relaxed/simple;
	bh=eQ8ytLJi5toByHob9i50BAXYd1Iwa+jG+3VB6ovqqeY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FEIZzu70e+sQW63TO1ijtrZZ7O1slXVquzgYEJI1hKe1qNb22ywfXoPcbQRydfD5+BTj6Bu9dnMNGkHUjC+4OZue0IS7inq+4shDBuxubeGoFjLh0k9Nl8yyyEwonWXGrtHZo4+8AUCQ7FCC2DWi+61AlPBiDL5p5vmdp9aSbDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QBNd2E7G; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578Hi8mS026125;
	Fri, 8 Aug 2025 15:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=VN1UjMUHlJSm/HT5EgbShJr7JuY
	VsTATUzi/Sfgrmeo=; b=QBNd2E7GzCvbtsIBoVCKPbbiJ4vbehLh2IN+oIhkRL1
	xiuYxMtPXYT4uV3IXd4SoBDmaeG72qgHyJXWUZkFiYjuhw49E0sUbzGIclTbTzh0
	ydcC3yDwiuIKJiDvQnliJble0t/bhNB5UzcmttMTEfy82rwJbuHE3WmakW+E+WYM
	t2JO3P3TW95/K8BYX3PcxXpbFP+SDsYuH3InAMP+Ws+RJJTvRUdjxiRF02IgM5BM
	H8hy19+X5H2m6NxuJwujzBYMm23roCLDnTJkKdnH5z8OcSNylMdlX2ir4sdfSC51
	+3tkURtQt3d1wYTq0aLcLkq2TpTgeWEPG4ELMdde26g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48dj071ckb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 15:02:22 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 578J2LOc029384
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 8 Aug 2025 15:02:21 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 8 Aug 2025 15:02:20 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 8 Aug 2025 15:02:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 8 Aug 2025 15:02:20 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 578J27Wb028685;
	Fri, 8 Aug 2025 15:02:10 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <dave.hansen@linux.intel.com>, <andy@kernel.org>, <dlechner@baylibre.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH] MAINTAINERS: Update max30208 maintainership
Date: Fri, 8 Aug 2025 16:02:03 -0300
Message-ID: <20250808190203.7493-1-marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=R4sDGcRX c=1 sm=1 tr=0 ts=689649be cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
 a=3zS9p7B7kHnLUYigmQgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEwNyBTYWx0ZWRfX59huZ6mIk5WS
 /h2zIE0WDSxegebYaoXy1xdRMEI6HiQj7MKWZfWFLoqkdwAViYJ2jzU7Qu3uschy6YhsEyLgicY
 Nkrr6BaEUhzoBZ7vBrh6f5Uw+X/kfjLQI+MH1NTwiP3sKwwJeJBBNnFQshqd3luYGRokawHYBkm
 xJ9I1bAoMGqyLe5SMbybWz88b4Ac1hzytu88cg6ZIaxXj5QzT/JypgUpk6rU2Q5OBXYQsfHslzf
 DJXcaR8iR6BwzSUcPPwdBhMDAPph5ZRHHi/3GQ9EKGpsmfwtPDPH+nhoPSmdTTCOt6EMussKahR
 fsq+vCayVPptpSczfLpveapXyoTNFd0U1yHIRqKKLQ2HxH/wKPrxEA6u3vkERlv3u26CIwUQ75o
 868TFe35
X-Proofpoint-ORIG-GUID: 4G1RCc595kLj13KijZiMgrSn2-u30-b3
X-Proofpoint-GUID: 4G1RCc595kLj13KijZiMgrSn2-u30-b3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_06,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508080107

Update MAX30208 temperature sensor driver maintainer.
The previous maintainer's email bounces and no longer works.
Also mark the driver as supported.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4f03e230f3c5..0308dbfb98eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14981,9 +14981,9 @@ F:	Documentation/devicetree/bindings/regulator/maxim,max20086.yaml
 F:	drivers/regulator/max20086-regulator.c
 
 MAXIM MAX30208 TEMPERATURE SENSOR DRIVER
-M:	Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
+M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
 L:	linux-iio@vger.kernel.org
-S:	Maintained
+S:	Supported
 F:	drivers/iio/temperature/max30208.c
 
 MAXIM MAX77650 PMIC MFD DRIVER

base-commit: 6408dba154079656d069a6a25fb3a8954959474c
-- 
2.47.2


