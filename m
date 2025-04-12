Return-Path: <linux-iio+bounces-17990-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81625A86B22
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 07:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838AC1B84DAA
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 05:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDA918C903;
	Sat, 12 Apr 2025 05:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yImaaL23"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11C117E473;
	Sat, 12 Apr 2025 05:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744437518; cv=none; b=eJ+WTWE1GJYf1DdVtb59wzj9lC5SEyUWuyS0LgK/SshvWrLklw06aePu/krhY9fxUzfa8W7oXfaY8IJ7mdq9OXkgTSi83D1ZbgDDzqi1Vb8y4YfTSpfbyozb6N3jCzGApwI5eaoHEwpwf+gLrW9IwXRO+HB2clXCWe3So4+ouCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744437518; c=relaxed/simple;
	bh=CWPSFLzpZdUAVoKX4Y5Tce5c+YYCKMuBQ1vgBq7Dfpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=AiUNmok/nLaE/Ir9f9abQPfTqYSZ7XLhY/KzaTaivOjMQWafdtGplRUAs1AiNa+lnM7vQ7YEvZOgWKe00AXwN7ESCaiYqoa1BKoUFqH1kPD3JrQFvwAkZVXXls51pWL2toYVVXQqwflv7xx19Eo2DHquRL9El4tsCpdkCcfc6HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yImaaL23; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53C5QA8x006939;
	Sat, 12 Apr 2025 01:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=w+8OO
	jOX7ylFNOT/aCCC86xoGb04s4jd0X1owSarB+c=; b=yImaaL23zOvDnZD8qwpxP
	zRLgIzsSTEsKiLVKPwi4++j+aqqK8KwNRCWw2fsQD2aKYU05c+Vc6yzO/GfCgN7S
	TnzpxWRQwf811huNVPGwREVdk0lAVQ41pQMjrWfaBDHxM76t/NFeC7EHDKxqwYm/
	IbZIrZBWlaZ6UEzl9k9npOCb7DuKxA/5CPdsfRAH4ULs4dSf64T0mLcgV6LVp+UA
	0bhYkcaGoXKo3RHbJt9/djPZccZ67ZwWIjsHbdeezjcB7SyhfXKIfZjGMOikSreM
	SiXyNnvN35M2ZTbarQbHsFZBd5O1tp+/6eEoAOp/IYF2sNob9HPbXhSoaEubPaJ3
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45yj178399-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Apr 2025 01:58:17 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53C5wG0e064390
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 12 Apr 2025 01:58:16 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Sat, 12 Apr
 2025 01:58:15 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sat, 12 Apr 2025 01:58:15 -0400
Received: from analog.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.18.50])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53C5vswV023609;
	Sat, 12 Apr 2025 01:58:09 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Sat, 12 Apr 2025 13:57:30 +0800
Subject: [PATCH v4 1/3] iio: ABI: add new DAC powerdown mode
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250412-togreg-v4-1-cb9e5309b99d@analog.com>
References: <20250412-togreg-v4-0-cb9e5309b99d@analog.com>
In-Reply-To: <20250412-togreg-v4-0-cb9e5309b99d@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Kim Seer Paller <kimseer.paller@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744437475; l=1127;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=CWPSFLzpZdUAVoKX4Y5Tce5c+YYCKMuBQ1vgBq7Dfpk=;
 b=38XfwxMpEBLlCwYYrgQwFQG5TJTGd0puc3/uHPRz0seIZf1g5b6MH7zdpbzk6+QN2vvpZBpGI
 3AXPSHYOmqoCx/YTCbH/DtJ0cslpUKhv99IrZdZ7hHd7lpeTE5MHgNU
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=UIPdHDfy c=1 sm=1 tr=0 ts=67fa00f9 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=gcfc5SScG_S9f0DalRsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lt-x_46ZOfJ02U1q-fiCLIBvAwFX_WCy
X-Proofpoint-ORIG-GUID: lt-x_46ZOfJ02U1q-fiCLIBvAwFX_WCy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-12_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1011 suspectscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=706 bulkscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504120042

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


