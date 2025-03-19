Return-Path: <linux-iio+bounces-17070-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BFCA683EB
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 04:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4565D3B82D0
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 03:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A130124EA9B;
	Wed, 19 Mar 2025 03:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="PSR/jRy+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2CA35958;
	Wed, 19 Mar 2025 03:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742356143; cv=none; b=HqJwsXKe6USleIkpdGP1ArTLaz+xOTcOfhNMGDBwtEi1MiMyC3XFVs/Iz/xj1PvhQv7YY2am0E09Uu4+a/iuSXhZu2F3X91uJJgmIT5jZ3y8oIKOSzKS3cTaRoJ7pIXC4bXXcI2eCZFtSRfPEQEkv9NAXWh1L7FQT3OKw4/WyT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742356143; c=relaxed/simple;
	bh=CWPSFLzpZdUAVoKX4Y5Tce5c+YYCKMuBQ1vgBq7Dfpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Abj0Rd2OyvfKDSZkEyt8EiaYEUBl54D11EjXnf95sJwsGAYY1ihbqm5MLHMUH4QytUTqjQ7Fo0jnNAnzi8lkt8kjPXlMM8pkIh3nUpTVZMzXAccJgkNwHXoAfTLiyBjgcwdEPUD8zrrd+iUji6U5e5qlxcmzfraT8GQado1H3NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=PSR/jRy+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J1k9w8018562;
	Tue, 18 Mar 2025 23:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=w+8OO
	jOX7ylFNOT/aCCC86xoGb04s4jd0X1owSarB+c=; b=PSR/jRy+cWx4LPKlscB/x
	extkjK01y1f995EDPD/Htmo6ifUJdmCcBG2P1HoseY2X7JoHFnYBs+i7deYOu81Q
	c8G6gGE6I9pxtMvYdryt2PBLsXHWbwfqCnkk0Fgqsk3k4fkZIpm+c+ymCaZi2bwE
	RYtnRiJrU6BDH2/gd22HnsAGBJ+8SwKNCbN46XGR6K7ZpsWpYt86Hv5fVPohJ2cL
	tjT1Bf0jXuSiY7A6vH+NffClbUO4ZQ2BE6VOgFOVWkUPozx7B2J5bx1umfw+U7DC
	GPNhIKmgUz5V78LBBlP7aW3wE4SPlLK5CyEmeoONQLDSDsfHgLwOddLMI1q0o3i3
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45d3d6ufk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 23:48:36 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 52J3mYIc048039
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Mar 2025 23:48:34 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 18 Mar
 2025 23:48:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 18 Mar 2025 23:48:34 -0400
Received: from [10.0.2.15] (KPALLER2-L03.ad.analog.com [10.116.18.50])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52J3mIC1005894;
	Tue, 18 Mar 2025 23:48:27 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Wed, 19 Mar 2025 11:47:55 +0800
Subject: [PATCH 1/4] iio: ABI: add new DAC powerdown mode
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250319-togreg-v1-1-d8244a502f2c@analog.com>
References: <20250319-togreg-v1-0-d8244a502f2c@analog.com>
In-Reply-To: <20250319-togreg-v1-0-d8244a502f2c@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742356088; l=1127;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=CWPSFLzpZdUAVoKX4Y5Tce5c+YYCKMuBQ1vgBq7Dfpk=;
 b=HAb/Qn+KTYsjeiEAluyzkbt+Od43iek+rR+azJBCSfXKnf3gZmeC1k+gQw7398YGwbw+h2g/7
 JgQsy2PSGRtA3XXNVzN7xZCT2bSscG20BWtXzBzqJyH9lMi0dP/brbX
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: LdxTdAv0wib-0p1RxiagL9-qhg5Y88uS
X-Authority-Analysis: v=2.4 cv=MsRS63ae c=1 sm=1 tr=0 ts=67da3e94 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=gcfc5SScG_S9f0DalRsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: LdxTdAv0wib-0p1RxiagL9-qhg5Y88uS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_01,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 mlxlogscore=713
 suspectscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190023

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


