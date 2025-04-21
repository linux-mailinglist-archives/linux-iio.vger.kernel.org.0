Return-Path: <linux-iio+bounces-18394-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CA6A94BE5
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 06:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9B93B02B8
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 04:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A72D2571BC;
	Mon, 21 Apr 2025 04:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="R/HQlobo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8F1D531;
	Mon, 21 Apr 2025 04:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745209553; cv=none; b=JlTQx07kpyZgWhTV4mAx9dyGLGYlYwByCSWArmNyqLaHVLrg46uYiMwUp+Gc5WEJfMPUVSKmU7NYCjhdMCNorR/xSAtjKgNrtYmMqa/8yhqFAt79x9bHKeQ4pgJolYfkUQy14unuDF11TlgTotX9cKeUgOAs3+vozhUqs8Rm5Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745209553; c=relaxed/simple;
	bh=VyVRX1HVLv5yTqUASg+tT29VXQ7lBcgGjSS/IHh5E/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=c7ygTsvd5eCZaRgexHY+flUVwFOs78vLTyxjHSH4nDvjFFeGWWx7LWmszWr732+xZ7qsUMtlBe5a94lt5yl89hg42NBQc6Rf8D4bCe/eLPiZEzHkn21hSx3oVan/zf1N9FbXQBQqkZS6SUUODwPFePpdyH6H3uKy+kGvqJ2xo5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=R/HQlobo; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53L40d1j021966;
	Mon, 21 Apr 2025 00:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3tbVt
	N3yqWbEoBc5MNER1lXQSbvuE+z9mXtyhsHJPSA=; b=R/HQloboZ0wYfy0kBJ2Zu
	2cnrDLClFZC92VTupk9XHLxKMz0efQ1ny6I2VbWVqDgoEuVssjSWWSzNjA2Dz7aI
	3fMhiCbqfP5arKl4Bl8ORVT9ppFmCZyJTGEW86LPszYEC2mRC9C6YjEfJYiepyzG
	hqd0maKvG9pCOFRlJo4DaLvzEP+X0MWC+Knfj4I7Rt8y/Ev1wOAZ5iUrDBgBN9EH
	U4XpFGTK9Ysc6oX/HobaRaYQaPY9mUE2QAjVFJcEfUr9vVyDoUMWxqT2p+Ispj3z
	m61qJeqxzby0Lw1pj/jFvOxf4Tu+TRs/ueA2hodVJS0q88ZU2TKuFsPdM/3gZsFi
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4645p7emqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 00:25:30 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53L4PT77006788
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 21 Apr 2025 00:25:29 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 21 Apr 2025 00:25:29 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 21 Apr 2025 00:25:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 21 Apr 2025 00:25:28 -0400
Received: from analog.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.18.50])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53L4P3og002018;
	Mon, 21 Apr 2025 00:25:19 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Mon, 21 Apr 2025 12:24:52 +0800
Subject: [PATCH v5 1/3] iio: ABI: add new DAC powerdown mode
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250421-togreg-v5-1-94341574240f@analog.com>
References: <20250421-togreg-v5-0-94341574240f@analog.com>
In-Reply-To: <20250421-togreg-v5-0-94341574240f@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Kim Seer Paller <kimseer.paller@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745209504; l=1179;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=VyVRX1HVLv5yTqUASg+tT29VXQ7lBcgGjSS/IHh5E/s=;
 b=tTPLzrDemlS7PMe1AZwvFIu4Tmz02vOUkPSRw0U8EllmyvCNnsRc2LD/FqAaA8C2VV3QLk+FI
 OuJEzJ8+C/DB4eQ3NL1rgN4M7r66Gx/9GfvEWLeO+Ofy0ENXDGEtFyJ
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=D4VHKuRj c=1 sm=1 tr=0 ts=6805c8ba cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=3Hb1o_MSCnf1oSB8FUQA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: gtCdBypFTE5jazwwSaKKyj7HuG4z9NJo
X-Proofpoint-ORIG-GUID: gtCdBypFTE5jazwwSaKKyj7HuG4z9NJo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_02,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 mlxlogscore=780 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210031

Add a new powerdown mode for DACs with 7.7kohm and 32kohm resistor
to GND.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 33c09c4ac60a4feec82308461643134f5ba84b66..190bfcc1e836b69622692d7c056c0092e00f1a9b 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -741,7 +741,9 @@ Description:
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


