Return-Path: <linux-iio+bounces-17574-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F596A79B5F
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 07:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC1816F211
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 05:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEB019F12A;
	Thu,  3 Apr 2025 05:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="iDRdzWj+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775E719D897;
	Thu,  3 Apr 2025 05:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743658492; cv=none; b=KGRM27jKzfu3bj+L4rPUw7NRyuafuyozMCMfpaC/qmS5lcOyFzxOhTMh7tV+JToYBG+/iDCz05YPXSkk8HUhTQo+7HxTMC0Cix7Azd/hSI/72dE7rMma/T0UUD3MnhoDerAstjPeD104k8FI2YyWE1DGdFogUFU908bPbNRMjI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743658492; c=relaxed/simple;
	bh=CWPSFLzpZdUAVoKX4Y5Tce5c+YYCKMuBQ1vgBq7Dfpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BRASgfUuNsxelTiFZHTj+6K/sj1Z+mrk8Bq3CVk+9vgQwGSbFvBx8RmppoFtCRmGC0E7Jfaf9woxLNhti3EC9Hw2YU5CoUuARHbWu2OK38+I1CduyEqriNJM8NE+j2wbGKBLtm8Zdj9wqwxn5wlRpqKweIMvZXDyiqMxqGX4yys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=iDRdzWj+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5331hZ6x017986;
	Thu, 3 Apr 2025 01:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=w+8OO
	jOX7ylFNOT/aCCC86xoGb04s4jd0X1owSarB+c=; b=iDRdzWj+kTko1/gwTRDit
	fe291lmAuSG+uoQWZge70ey6D7sSdQQ68MD8qnd4LhGHwdfoKb9fdfrgfj7OZKgu
	hnE3VbpGbq2ql1F7W0pjaG1e6Ex7qsA0kx70hW4C4SdnYiVMxb+ZLNtt3+siKku6
	lYFmYGF77PYc39KULLRjLQg0P0Bn2zHfSJC6wX0t4lBw9pr2Pz2YfGpdX7n8Ve+Y
	qdqKNKxu0/77vQhkRTGemSnd6BiJ7R/1iBXlG11SjNJ51EALxL05yvl66IZ9E/Ba
	1PdGPZHh1E5KpOVpG3Tz8f4i/PSFSR4sx1ETEHzbziSPFUGMSrWOnXqns2xgzzjL
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45rcrx40jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 01:34:37 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5335Ya4o004216
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 3 Apr 2025 01:34:36 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 3 Apr 2025
 01:34:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 3 Apr 2025 01:34:36 -0400
Received: from [10.0.2.15] (KPALLER2-L03.ad.analog.com [10.116.18.50])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5335YHaV007295;
	Thu, 3 Apr 2025 01:34:26 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Thu, 3 Apr 2025 13:33:55 +0800
Subject: [PATCH v3 1/3] iio: ABI: add new DAC powerdown mode
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250403-togreg-v3-1-d4b06a4af5a9@analog.com>
References: <20250403-togreg-v3-0-d4b06a4af5a9@analog.com>
In-Reply-To: <20250403-togreg-v3-0-d4b06a4af5a9@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743658457; l=1127;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=CWPSFLzpZdUAVoKX4Y5Tce5c+YYCKMuBQ1vgBq7Dfpk=;
 b=dngpfo7BzTTIV6Cbx3VrOu5abfQfC8z/+NR+gLLtpYrJgGInvjKBdIu4VhD8m0JAP7Gq+JsK1
 0o+uy7z1M3TCx9v0LZnUs3A/X5NhncmpF704172gIf5gE0QpX3ndARV
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=KqVN2XWN c=1 sm=1 tr=0 ts=67ee1ded cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=gcfc5SScG_S9f0DalRsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FCRnzjzk__FwlaM_qom1d54MHtmL7hux
X-Proofpoint-ORIG-GUID: FCRnzjzk__FwlaM_qom1d54MHtmL7hux
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_01,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=707 adultscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504030027

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


