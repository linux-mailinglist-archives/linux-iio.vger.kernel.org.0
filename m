Return-Path: <linux-iio+bounces-7604-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FA3930A13
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2024 15:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35485B21324
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2024 13:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B8984A56;
	Sun, 14 Jul 2024 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XsR+QCWB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793E08F5C;
	Sun, 14 Jul 2024 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720963856; cv=none; b=nSVxrJLeWBMM6YZ+FXEhnYL1nc7xV82BFXwXsnQRF5jDOK2KtXnAklRgV/rwLPqPvJspGZxaE33N8zKAPQ388Wsk7VN92dmYfAkUjWj9A69WQT5GW5pwHdzHFAHIaC6LjAYhjmztQfeAPLTAxeza1LtH6iafXsBpihc31wyX1i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720963856; c=relaxed/simple;
	bh=rocfJ17GW3D5x83ogfqr5R7069P3habSyW6AMwJQtMI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s778/eL1A+tl6zmJi5Qvsu6ClppyePpu88y2CDNXRXp0IPmTRW7a1pvYejF5rVDL2t3M7Wf4+4dKzvNIlcGVKwN91X+J6wAZwSi6068aLOYoRRl+HLK+bJs71A03xX4WGwA4EY210sm2QhPrR9S4HLV9KZy30T25lEkdWv6FzCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XsR+QCWB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46E9YwtT028378;
	Sun, 14 Jul 2024 09:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ug/VS
	VOVn06zFyebYkwUUM2p7hPf8JPIueT/B4GO5Mo=; b=XsR+QCWB+xDKn23QIdSJ0
	DN04PIdXo1mQuV7/8189fL42AbEgw5v4DmvxxDVLB4tgIDaHIVsCESDkGWOZ6OV0
	oK0UJNOpaVxYQDsCBR0BY94pnxRwm/dr0fqs0Lt/xD5uc7yhZfdqpzXMKLVxzmMF
	D/duZkix7GiuZTrKYE+WxZobMIGgnTpl+v4xBt2Y+Hr63xHqsiGRnmu1Wusqcnx0
	juOnLNK3bxZRiAmjJvlXGBhwHgcwMaT04zumJ2Qe+42UxfROti3ICGV+dUERB6Ir
	9bu/aS3yexujR3/RsYYJ8HmSeqQ5XNGlAmjKPaR/jSK+myaqw4ZOUMWEWgG024nG
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 40bke3jywh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jul 2024 09:30:34 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 46EDUXox050886
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 14 Jul 2024 09:30:33 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 14 Jul 2024 09:30:32 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 14 Jul 2024 09:30:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sun, 14 Jul 2024 09:30:31 -0400
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.18.97])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46EDU4QV028092;
	Sun, 14 Jul 2024 09:30:22 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
To: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Dimitri Fedrau
	<dima.fedrau@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        "Michael
 Hennerich" <michael.hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<noname.nuno@gmail.com>,
        Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v7 2/6] iio: ABI: add DAC 42kohm_to_gnd powerdown mode
Date: Sun, 14 Jul 2024 21:29:56 +0800
Message-ID: <20240714133000.5866-3-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240714133000.5866-1-kimseer.paller@analog.com>
References: <20240714133000.5866-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: TEiHlzCwlcza-GgTuLB1jm3zXSorcycl
X-Proofpoint-GUID: TEiHlzCwlcza-GgTuLB1jm3zXSorcycl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-14_11,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 spamscore=0 mlxlogscore=953 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407140107

Add a new powerdown mode for DACs with 42kohm resistor to GND.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 7cee78ad4108..6ee58f59065b 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -708,6 +708,7 @@ Description:
 		2.5kohm_to_gnd: connected to ground via a 2.5kOhm resistor,
 		6kohm_to_gnd: connected to ground via a 6kOhm resistor,
 		20kohm_to_gnd: connected to ground via a 20kOhm resistor,
+		42kohm_to_gnd: connected to ground via a 42kOhm resistor,
 		90kohm_to_gnd: connected to ground via a 90kOhm resistor,
 		100kohm_to_gnd: connected to ground via an 100kOhm resistor,
 		125kohm_to_gnd: connected to ground via an 125kOhm resistor,
-- 
2.34.1


