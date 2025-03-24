Return-Path: <linux-iio+bounces-17238-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB864A6D912
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 12:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC33C16A6A0
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 11:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F81525E45B;
	Mon, 24 Mar 2025 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="POA7UHmy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9BB25DD1A;
	Mon, 24 Mar 2025 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742815451; cv=none; b=ghsXNzZFJl01s7onsKgErke3Uos5zfk4lp77j09POYg9qqPeR1lEVSO3QErKBfBFDYfWUA5//t3ej+hFQJPiJozB4uz8J2IJ2oKcHbCof5tY4Xdg3sCijzpTqZCeqbf7IHuzQWRJzgJ++hmlJaEndnacd8wb2mDsG2D1r4xkquo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742815451; c=relaxed/simple;
	bh=CWPSFLzpZdUAVoKX4Y5Tce5c+YYCKMuBQ1vgBq7Dfpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Zz4LFSsJEt8IzIhA+mO13JjICIEXHVLA6iccw12/CFUCTyA+6q6KT80FvJjDsRr+mb0T/Ay6D1IbtllG209FpyLGZDoPMB8r7vLQWBKd2l/MJGffcBaHRiHnyJliCOBxUoq6QYUdBh5M6VJCiWrA0SUYaXWcp3ObJmce43ikaV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=POA7UHmy; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52OBKsmY018547;
	Mon, 24 Mar 2025 07:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=w+8OO
	jOX7ylFNOT/aCCC86xoGb04s4jd0X1owSarB+c=; b=POA7UHmyI9gKLmdIgPvOF
	HSnxaNrStJOjIPhQCEzmGJMbaU3FmN/yNR5FUGzYn7DsAsZ7vqg9s2HWNzOBFPyW
	RRx4LoMWOwWDYB26J5h0Rn4KTQtBFp41IBNBhauhQmVE19fVOccNHd9cC9gqqIhZ
	ynKCYfjn2B46cz/9oN0y9cZ0pjialnd9RnYi6dYAVG6iDQgdOSOMAus3DlXO54qp
	H2OPuMe1aEMTaLDoMcYOzMW4TfZRe7L0rEwLXK2rS5tlcdJ9XtV6oA2vrjhoaEq+
	EkRcOB/4MyiNi1X/nPEMBJQHrRau4DVUoav0T5fwrnliZe6BUFPeCB0+d1rDECnT
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45ht4aa6ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:23:57 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 52OBNu0S052248
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Mar 2025 07:23:56 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 24 Mar 2025 07:23:56 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 24 Mar 2025 07:23:56 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 24 Mar 2025 07:23:56 -0400
Received: from [10.0.2.15] (KPALLER2-L03.ad.analog.com [10.117.223.46])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52OBNb9h007643;
	Mon, 24 Mar 2025 07:23:46 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Mon, 24 Mar 2025 19:22:55 +0800
Subject: [PATCH v2 1/4] iio: ABI: add new DAC powerdown mode
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250324-togreg-v2-1-f211d781923e@analog.com>
References: <20250324-togreg-v2-0-f211d781923e@analog.com>
In-Reply-To: <20250324-togreg-v2-0-f211d781923e@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Kim Seer Paller <kimseer.paller@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742815405; l=1127;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=CWPSFLzpZdUAVoKX4Y5Tce5c+YYCKMuBQ1vgBq7Dfpk=;
 b=1vgtrHNSOO/7BKV3K0jRQkUKYzEaIVxLa7pdB6nl+8jJz0k4zz+VM5oibGZ52AIcvcD6KGVGE
 eGojyygHb7dCE9dNGv8TcYg8dfuKop68gJohlnaIeC8kPBBbMdiENlp
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: cjcXuMgydwByvkpqws8rD70HsOW6LwQ9
X-Authority-Analysis: v=2.4 cv=YNCfyQGx c=1 sm=1 tr=0 ts=67e140cd cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=gcfc5SScG_S9f0DalRsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: cjcXuMgydwByvkpqws8rD70HsOW6LwQ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=704 adultscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240082

Add a new powerdown mode for DACs with 7.7kohm and 32kohm resistor
to GND.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 722aa989baac43f694076074b307d134867b4533..85790f943fd858021c75d67375abbd8b2976bb8b 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -740,7 +740,9 @@ Description:
 		1kohm_to_gnd: connected to ground via an 1kOhm resistor,
 		2.5kohm_to_gnd: connected to ground via a 2.5kOhm resistor,
 		6kohm_to_gnd: connected to ground via a 6kOhm resistor,
+		7.7kohm_to_gnd: connected to ground via a 7.7kOhm resistor,
 		20kohm_to_gnd: connected to ground via a 20kOhm resistor,
+		32kohm_to_gnd: connected to ground via a 32kOhm resistor,
 		42kohm_to_gnd: connected to ground via a 42kOhm resistor,
 		90kohm_to_gnd: connected to ground via a 90kOhm resistor,
 		100kohm_to_gnd: connected to ground via an 100kOhm resistor,

-- 
2.34.1


