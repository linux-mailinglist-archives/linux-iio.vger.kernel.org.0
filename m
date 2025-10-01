Return-Path: <linux-iio+bounces-24632-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D23BB0C80
	for <lists+linux-iio@lfdr.de>; Wed, 01 Oct 2025 16:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48AD18858E1
	for <lists+linux-iio@lfdr.de>; Wed,  1 Oct 2025 14:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850B42F0666;
	Wed,  1 Oct 2025 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oy7/xgBf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC50D26F46F;
	Wed,  1 Oct 2025 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329925; cv=none; b=UQBX2iZweL166qny7TSYSjMxebcEueOTa5JVUfL2uBz9k4VXVBowETmqPhM7b7V2395jEAaPx9Xs38Z/M4+QE9F9mk3s26U80QhOgF7YUNNvCYS5nDI+wDpN+EhNC4R4AF/tbWUovxQBJCAxFr+BlqPi38rDpiU4DAN9sj8HnZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329925; c=relaxed/simple;
	bh=W0Q3qHRmI4NEaQgmei73T1z6QW0+SYmu+lHtEGoBVZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5V65yZZbgngz6u9bTRFSnwJOK5SWEGQ17J6CLFSO7FOT5tvnyPmMKtAICacsBROTlNHi6B+7Vyx6mJFWHCnT7ILfLEYSKbYUCEC2thORHxli6TKrUEOT8DBRe5rc2q/aoK6EfcvoBln0wtIy7P6Y3Q7tYxYHYoZaZCdhErYamI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oy7/xgBf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591CqBhu026144;
	Wed, 1 Oct 2025 14:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KtNynSvFVjpudk4Te
	AKmNfR+UQ5kPia28l4BEDQM4xU=; b=oy7/xgBfotnRyrKeNl0o3xdXMa5IlOJ8r
	p/v5jvtL02w2Wupq4Vf4BoRyHVVy15eSbt0L5EzSXval9+75hB5DF54RqOob4Yux
	QbgB6aqUgrqR5Z19rDjGhIhZ9PbbZAoa2TgI1k2appidlmXckCkgRlrQjJvUohVw
	07XsEb24qr/bbo1zuA0NBFiWWOBdJ9T2Cud4Qr/naN3ycGeOMgencY2R53pK2KGf
	i3hr3kQflUMckdKzwCvYc8gYbo2PpBFLMF8WsXal/vdNRFV+8NaQ1HlrpE/lhugZ
	Q+dCyZT8g1Qq+90dhsC16SG0cjN1k0YFifw4x+ASs3Yk22v7Cvf8Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7n7yyxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 14:44:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 591DLRSu007313;
	Wed, 1 Oct 2025 14:44:49 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eurk16y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 14:44:49 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 591EimU857868716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Oct 2025 14:44:49 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A91535805D;
	Wed,  1 Oct 2025 14:44:48 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E38C58055;
	Wed,  1 Oct 2025 14:44:48 +0000 (GMT)
Received: from slate16 (unknown [9.61.71.223])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Oct 2025 14:44:48 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andrew@codeconstruct.com.au, joel@jms.id.au,
        linux@roeck-us.net, chanh@os.amperecomputing.com, jic23@kernel.org,
        dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v7 RESEND 2/7] dt-bindings: arm: aspeed: add IBM Bonnell board
Date: Wed,  1 Oct 2025 09:44:36 -0500
Message-ID: <20251001144441.310950-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001144441.310950-1-eajames@linux.ibm.com>
References: <20251001144441.310950-1-eajames@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uAQ83X2FDtryFV6zaca4tRqICdie8eJ9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX92dmH2WqoCMn
 pAmUtwkqXe7iniXCUU5C8mXka2QoCbC0fA574JDdIQZ0sNTVjfusoSPVg4tL66TYu5L65bIK1ub
 0XlkLM3Qpi7ZU7hLQLoVRfZy1OIUrQimYXzPqlHbrGODEI5StdYcsPG18KwBkPPz1NMr3uvu78t
 //FEPk4wFIj08lnB3GnQfKOMg06sjobV1r38NHxl2I9mCkpYTxOFbgLtYj3SYEgrfNK8clXDSNE
 ie6JQSvRWpa6QszX+WgpLp1y1ZzbSJTijBMwGLH+qOehGjGVYPM2jt/M3Dsio+WAmpURZA3v6ul
 tOM4WtNGGwncblDCBIP3bWn4ECpb6xxYMrQTEhVJ4b5/UuFbScIn0aojG8BWXLr3ti3ief1Fdf7
 6SlZfuV/9Ix/icP75MdswDe6SYcDRg==
X-Proofpoint-GUID: uAQ83X2FDtryFV6zaca4tRqICdie8eJ9
X-Authority-Analysis: v=2.4 cv=T7qBjvKQ c=1 sm=1 tr=0 ts=68dd3e62 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=3pJJXNp13jenLdaujSYA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025

Document the existing AST2600 BMC board for IBM P10 server.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index b2fcfcc4a3b9a..9730df98b945a 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -95,6 +95,7 @@ properties:
               - facebook,yosemite4-bmc
               - ibm,balcones-bmc
               - ibm,blueridge-bmc
+              - ibm,bonnell-bmc
               - ibm,everest-bmc
               - ibm,fuji-bmc
               - ibm,rainier-bmc
-- 
2.51.0


