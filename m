Return-Path: <linux-iio+bounces-7115-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FCE91ED34
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 05:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0C0CB20ADE
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 03:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841E12BB12;
	Tue,  2 Jul 2024 03:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bdRm4qeS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AAE22F14;
	Tue,  2 Jul 2024 03:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719889277; cv=none; b=NKqszZmpggrlYaOETIGscZF+X8hg5cQn4SZajZA7fu1eak4RgUj3zQJ+wOCUHZNnSWcUhZz0DSMgbnViyQhaV2zJqemOnUGnAwc517DD9nbMC8XQSLIUtnQjw8cs23YKoVwu57+fxbwAHj7Xqj3NaZeVmpgRQ7K5hLh1jjiBfUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719889277; c=relaxed/simple;
	bh=nwcfMSqH/kYP13NwxoZHW2cMqyqNnTFrGEgNrkNtHrY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gTnQbxOQ9AMaUDAcpSDlUyzM0QrinopRoz3KWMUwnOB5YBwnbmKl6lTYvoNCrWRz935MvXN0x/tKKGPwEuuUulcN/Z+Y4E1H3O1vYr/eAJqviChaisiXiw7DzWiKSvY365Sj0w0zOR/T4CuQIsg+GvI5RKKfp8c0xMyBXKVIb8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bdRm4qeS; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4622eGFA003330;
	Mon, 1 Jul 2024 23:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=t2sD/
	uYPph7dRsIn+CWLNsx6Jr3+Cb+Sw0FU5tjTH0E=; b=bdRm4qeSvwOLhGVGtNEIV
	ujjHzNYyyuAb+j8nQ1Hoxc433FLSJibic33WKE5MNVtyLK2vzSPF4sJBjNiK/EZt
	XHAsJbZwQTbP7Cqoib3WMd3ZVHkLvaeRjidgJv3ET7YvJq9Y/W5VDmyz5ZZQhfw0
	BvRXi+gTEuoIViV21s8B4xKy/nGepSu39Vo+82tL/2AXQ6LJU0Y2N8kq3Ty1khH2
	tguA8XSUhyhAhUpQw7GWMr/bJU0vhqb3nTK2MzxEGO5cQBS61EXlj94Ps4MUQeaB
	8+v+km/a1JspRDtkX0MoenSGbKNOTSTB+bdG4Hi3MpV12Lu3p+9OWf6MGxGlOWNJ
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 402c43ry62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 23:01:01 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 46231056041185
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 1 Jul 2024 23:01:00 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 1 Jul 2024
 23:00:59 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 1 Jul 2024 23:00:59 -0400
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.117.220.28])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46230WbN032046;
	Mon, 1 Jul 2024 23:00:49 -0400
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
        Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Michael
 Hennerich <michael.hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<noname.nuno@gmail.com>,
        Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v5 2/6] iio: ABI: add DAC 42kohm_to_gnd powerdown mode
Date: Tue, 2 Jul 2024 11:00:21 +0800
Message-ID: <20240702030025.57078-3-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702030025.57078-1-kimseer.paller@analog.com>
References: <20240702030025.57078-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: QNmV-JQIPng3zfmTlDH0zEDYQ3YsaRhi
X-Proofpoint-GUID: QNmV-JQIPng3zfmTlDH0zEDYQ3YsaRhi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_23,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 impostorscore=0 mlxscore=0 clxscore=1015 phishscore=0
 mlxlogscore=997 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407020020

Add a new powerdown mode for DACs with 42kohm resistor to GND.

Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
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


