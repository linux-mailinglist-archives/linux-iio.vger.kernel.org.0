Return-Path: <linux-iio+bounces-18649-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B91A9C9A6
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 14:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F9816DA78
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 12:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E839B2500DF;
	Fri, 25 Apr 2025 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="HzHS+Rhb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1986724EAB7;
	Fri, 25 Apr 2025 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745585738; cv=none; b=RtQR7nXxLuhc2EHYLQ9jaPQsi4jcsGhrfLz02ruU9/AKHnwR4C7UYxqjm158k2JVMrkyII9WdNN963NMfJSYnqr4xv1rlB3B2T47cKDBmxe9DOKNAnNNYRmsVd06lcBSjHVvicgdQD9/swAdcE7+5l9q28wQXzv9zu3E1JG0T94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745585738; c=relaxed/simple;
	bh=VyVRX1HVLv5yTqUASg+tT29VXQ7lBcgGjSS/IHh5E/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=dPp6+D8Yyc4CmBX/3fAmTwL4OMn2UKKXW6Vs38LOGiebn0vdxJSp57VFsOcauBD+/dHJ/Le9ISyWH0ILD30r6FGBHneRgp8emmfZS/V4lJkL8y11p/cn1B10Y6WgSQkI9KOhYhylSFM5h7u0eY8AVwJNtLohFM9275P86gaLl+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=HzHS+Rhb; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PAxBTS019343;
	Fri, 25 Apr 2025 08:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3tbVt
	N3yqWbEoBc5MNER1lXQSbvuE+z9mXtyhsHJPSA=; b=HzHS+Rhbyb29UfmORVOV8
	t7FPRLmenaq9MU/93ahJqIlsmLYWK7vnCmv2W28DHwFG+KZnkcsF3kYZGAf/pCI+
	+H7iM3nbbt5nyDq9HFCGuhWWH10sYa6u06fRNsk9J64Db/hl31fKUTe19+uh4bZX
	bSAMjqThCDa9QdRoZ4cuWNpjz9UW+lHu8416FwbScX6PknqhCdbq7umQ9+ob5+ue
	BaQ8akxM5HbBLFkG3e91zIO/Mrmaseq5ZXhF6jWEFEOunmvLenHXZRbnq6URrzuB
	ozYpxHKVktqJVYvkCyG6j7Y3ymx5BEXbdkBO3929OjG/W/YC2f49zwVkPIYXbPuP
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 466jjqybe6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 08:55:22 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53PCtL7C054018
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Apr 2025 08:55:21 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 25 Apr 2025 08:55:21 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 25 Apr 2025 08:55:21 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 25 Apr 2025 08:55:21 -0400
Received: from LRADU-D01.ad.analog.com ([10.117.223.12])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53PCsuax019034;
	Fri, 25 Apr 2025 08:55:13 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Fri, 25 Apr 2025 20:54:46 +0800
Subject: [PATCH v6 1/3] iio: ABI: add new DAC powerdown mode
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250425-togreg-v6-1-47b6f9878ae5@analog.com>
References: <20250425-togreg-v6-0-47b6f9878ae5@analog.com>
In-Reply-To: <20250425-togreg-v6-0-47b6f9878ae5@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Kim Seer Paller <kimseer.paller@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745585696; l=1179;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=VyVRX1HVLv5yTqUASg+tT29VXQ7lBcgGjSS/IHh5E/s=;
 b=6hGCjXkbRzHNfKlvbg3fNgIRNG24qbW6jh01UJ+QNogdfrLdCQmpvgmj040FoCnaPBjowla0a
 Zz02EEhKwm2CpQJQI4AXdrGmfR7EVk9Ac9Jw/UO+9Bjn697EKvyblHZ
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: f-F95--d-RiX3XSI7s_d2yM_-oL9repg
X-Authority-Analysis: v=2.4 cv=DoJW+H/+ c=1 sm=1 tr=0 ts=680b863a cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=3Hb1o_MSCnf1oSB8FUQA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA5MyBTYWx0ZWRfXz6nWPB4l78vB IOYVsNIw+tIF4leiVZuizMCv6dfz9SZkOWFRjGj9Q20qCsXqB+ztlYk517iLwjn+w+vqE+Vjnki BTsLjQ017cpce26YUz4ET262l6OjleK9xIQgcX2+gBbeuWx8OL+pFI2yns3YW44e7a8EBY9cozP
 SDi9ovn5EchaQkq7SjM5BOV5ii98W8aZv0ccE3vStSYQOllfJSOg7PtN0J2b6KpheO8TVwttsII pUOXvLwRt4DXX9QIfJ1eawdYIC6XRAXEB6IUEYdVSYS7AvS1LN8ztR7C1QvYsaDTNO7zsIFcmlv KBkR/0Y7RckSs86jLmgV7hJMWR0YS2UQK8d5CE7MyD1VmkWFftelVshBn3yOF4XmuouRf6yvtP/
 WB6k9THIXUrPtL1HpGZnMirQ6G8Lq8gHHT4gja4dQ42vw3aGRZSctzt45IBCpZo5vA7iNycm
X-Proofpoint-GUID: f-F95--d-RiX3XSI7s_d2yM_-oL9repg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=714
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250093

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


