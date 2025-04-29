Return-Path: <linux-iio+bounces-18803-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4A8A9FFA8
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 04:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7C2481441
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 02:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616AA29B760;
	Tue, 29 Apr 2025 02:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="aQNR+/tr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8672929AB11;
	Tue, 29 Apr 2025 02:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745893218; cv=none; b=J9iReHszQIt7qtEMZnM5nSbwYUL+i+J8FSAVDAFSFJ0ASgoetxtNBGhZQXEnB2IcbeG5MdEbsIS2rH7jNcoO/E/vqPovDXgx4Z57GWe7E8lZHBvdD+1040QCne4f72cL9Cmsc3OaEbBE9fW3c8lsf8A7sV19R6+//4ZjIicQmLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745893218; c=relaxed/simple;
	bh=VyVRX1HVLv5yTqUASg+tT29VXQ7lBcgGjSS/IHh5E/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nPCGbpzKYynlzzcsWpDRX7fSMlR1lmsyt/TPoBm8IMdwNv1Y1WvFUUidYDO73GiyB6CVFHAB7vMGBo/QdOvubYfhcTies1+USudHkZ3VGASPr0B/rn5BHwfyW6Xyzi030dMgyhRQjNmWrzGzK7lOGWZQlBUoDPguJm1ujcQUM/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=aQNR+/tr; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T1eFPx003171;
	Mon, 28 Apr 2025 22:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3tbVt
	N3yqWbEoBc5MNER1lXQSbvuE+z9mXtyhsHJPSA=; b=aQNR+/tr+e6WFZ1E++6eG
	wk2tdi6zh1ZkevTPyuzIkXRZ2mkKEW52Ox2fAwbnKBm5WcRMVEvU5/FSnRnZsrgO
	nDpvD6l3MOuHDMxPQL8LoGWmxBJ0roXx77uvr+X9eYXw51e7qLg5gGILCW479Lep
	z5ejI7EP3JERfVY77BKUh0AsiiyKY/pHZLJQuWL+G5A/ZFaVdrVmdPJlfcQHM6XT
	Zpfz8xmmoV2mF2b/+10tJs8jNFkjHID13FZDUxthS3JtlgS1Xvc3Lqb43ksjM984
	GnUaE22073zPhlvnJSq188PoEYET4ejnPRsFQf4w36k+ZrLea3sYwD2WVr46eDrJ
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 468sb79tnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 22:19:55 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53T2JsHR051535
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Apr 2025 22:19:54 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 28 Apr 2025 22:19:54 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 28 Apr 2025 22:19:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 28 Apr 2025 22:19:53 -0400
Received: from LRADU-D01.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.18.50])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53T2JPCt007738;
	Mon, 28 Apr 2025 22:19:41 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Tue, 29 Apr 2025 10:19:16 +0800
Subject: [PATCH v7 1/3] iio: ABI: add new DAC powerdown mode
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250429-togreg-v7-1-0af9c543b545@analog.com>
References: <20250429-togreg-v7-0-0af9c543b545@analog.com>
In-Reply-To: <20250429-togreg-v7-0-0af9c543b545@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745893165; l=1179;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=VyVRX1HVLv5yTqUASg+tT29VXQ7lBcgGjSS/IHh5E/s=;
 b=mR1zeAqmzMEPBvLKLyNiS5uWwIBqupXSHuwfrAGo8DAeJzUquEZxDBkg7UERrxf43YiO79Wzc
 pMC9ECSYExEBOdhl8tDkzeB79ZsoxkaR0fbl3oQzhcFSGvwZ+5lb6Sg
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: lt8J7QO3Dk2E47ZlnWMUJIXhy9hbRdfN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDAxNSBTYWx0ZWRfX6VNrVyemdHeQ BNbEMaU5Bxjp8+QoWJ5ASBFeVg3qrc7C6/d+LVgMQ4z9J6aw0n6YpeJ5y7y3UKkrO2p18CbblKf GFLIB/h62H8i9OjkbUYtwdzAvZWhDQ8tVFuupgdoWoD8Wm/I+4rz1dTTorx3+TidwjobnWQYGh3
 DDwmmMi9Qr59AtYdrMlMQKZUa8PTXpiF8BSD4O/AO+n5XiL94IdkclWXoas/8NNl4q+VE6BYsjn Dlrnq+xepyTUv2IoTROomF1/x5285tVKYQirV7r2lMXsp6TD5Qzv62jy7N5trkbFQSs1MzXCuF3 04pK/e7tOU7wm5wciCnbRnuTnAGelFGG60i+rJi+CA5dk8zBZNW6BYETHL5fM+7Q9fwhTMv2fUz
 zC/YN5Nk84t7E0P/iFUIceO/WVEJGLID5dkowI+Aus5U7UulSyhuEQdDsPRwVykJZxglC28r
X-Proofpoint-ORIG-GUID: lt8J7QO3Dk2E47ZlnWMUJIXhy9hbRdfN
X-Authority-Analysis: v=2.4 cv=HPzDFptv c=1 sm=1 tr=0 ts=6810374b cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=3Hb1o_MSCnf1oSB8FUQA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=714 adultscore=0
 suspectscore=0 impostorscore=0 phishscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290015

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


