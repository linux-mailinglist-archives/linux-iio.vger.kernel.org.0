Return-Path: <linux-iio+bounces-20766-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A3FADF3F3
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 19:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E257189EC3E
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 17:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08422F2C72;
	Wed, 18 Jun 2025 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="H9l9aCZq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F84D1E8323;
	Wed, 18 Jun 2025 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268248; cv=none; b=CX+fMg8GvvaHgw+QGS9sVAMerdXJ3f4hMhcpF5eEg4ke46lnunpl2DfUz4iSMUph6F4oTWptJJ4jis1UCN6g6mJPtIpV3MKJtEmut3YDUdcLQVDHOnwW9i7yHJweI/mZcp3j/NQez1U2N31aQ42sXLZR+QPzFi+d92xyiELefqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268248; c=relaxed/simple;
	bh=EkMkmb2apmpGfdW8a0cKv5WdVY0/XoKw7zMvdFh3c6M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MbVfWRkHfSvI7mWcO3gU1R4MeLEm83i+70YOcYNPQw+USTVMoHJjInIuFwLFKNDvbX6nXuFEIgFUQYigKGDuRStLCL13LplC8nJvB7vxMXL0GrDNR3LOE08HO2Ib41rVKI0zFv6hi+q2GlvOD/Zm/qRMdjADO1AobSbR5XNrjdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=H9l9aCZq; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IGSPm7032314;
	Wed, 18 Jun 2025 13:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Fzq/m
	fM41vs4V3T90HK6Qq/7jrwfsMZwqU9a6+JLdec=; b=H9l9aCZq5eNpn9mbTZsEs
	RZv3ZriqWlmzMU46UwiJ4WQOkUSIQ56DlMLbwCXh11urDLqtsa3FbNr2OSKsp+vr
	ZLFfXf9cm+CN6+ccFYqPRL5TqCEhYXxQJT2Sg5WroOelwI8i1TIepHR3eG4a+Jx4
	RLgQEAI/MTbiMQOnKTPBcLUwaHIF3UTYVSeXyY5J/3mCVeecsZwqVE3dU5c4DKzi
	SayycY/ygUn7YuRg7NUC25hFk3SY2HgwArXMeQiC6Rag6WeNvf2CCjl6RHO+sXLX
	oL+p0IKJ1y18WxQX66c8+XRffqabpLAPj3i65dcrWk5+Y5cCiTu1Nx9GpN2gqa55
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 47bfshdda3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 13:37:10 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 55IHb9vk031809
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 18 Jun 2025 13:37:09 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 18 Jun 2025 13:37:08 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 18 Jun 2025 13:37:08 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 18 Jun 2025 13:37:08 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55IHaqdX007469;
	Wed, 18 Jun 2025 13:36:55 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v6 05/12] Documentation: ABI: IIO: Add sinc5+avg to the filter_type_available list
Date: Wed, 18 Jun 2025 14:36:51 -0300
Message-ID: <58854f63fb664b9d99a5404b02794718c01a34ea.1750258776.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1750258776.git.marcelo.schmitt@analog.com>
References: <cover.1750258776.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 7h90lcZu7U0-0kBir70y7TYlOrrM77ys
X-Authority-Analysis: v=2.4 cv=SKhCVPvH c=1 sm=1 tr=0 ts=6852f947 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=PC3yhc9nkE4EivMybyoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDE1MCBTYWx0ZWRfX3d/5Citj9BI/
 pBmncswX5yVXeltCEmU2ieeoYODXE0RfckZOpoyeHH0dO4G/e1Ls9v3sFCKAvNimHtGWq41kZTO
 ZteAyqeOFfW2h4lBGTaQjYvnda9pY0GSW4fbTGi6fRCZ7zVNZxCrLfg/dPI8uJ1YH5I3xWWI/HW
 rnDO6BWopGvquG9Aca5BsjCg4AqWvTdBFfiCMpcry1dJT+2QZxcHe6ZB4XfyMbnHK+0OnbmtMte
 YB0EdPVv/CVOLneyiIhU7E2g8Zsmey+QszFlmbMAA5UyRvZzsIh/Ml+Vdm2mDnZGbDdI86mgP7m
 J8GHqLiJYqDwQP/tk8LuJs8/28dhIfe6sy+PrIEjQbRFEQCuJK1QwTzNpsOQ2TpZsOAiz/p44Xb
 bFAAlSaX18oyzQXZJvr7OyvTGXhNf2CGjgXjkcTQbsT22stV1PtoabUgLnWfxFeuEsZC9iyc
X-Proofpoint-GUID: 7h90lcZu7U0-0kBir70y7TYlOrrM77ys
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 clxscore=1011
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506180150

Add the sinc5+avg filter type to the list of possible values for the
filter_type_available attribute.

The sinc5+avg filter type is handled by the ad4170 driver.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
New patch in v6.

 Documentation/ABI/testing/sysfs-bus-iio | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 3bc386995fb6..c1f657182ad8 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2321,6 +2321,7 @@ Description:
 		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
 		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
 		* "sinc5+pf1" - Sinc5 + device specific Post Filter 1.
+		* "sinc5+avg" - Sinc3 + averaging by 4.
 		* "wideband" - filter with wideband low ripple passband
 		  and sharp transition band.
 
-- 
2.47.2


