Return-Path: <linux-iio+bounces-26217-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A4FC5CFA1
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 13:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC7F535AD1A
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 11:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DDD31618E;
	Fri, 14 Nov 2025 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="PuHN+dmM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B736A315D26;
	Fri, 14 Nov 2025 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763121588; cv=none; b=AGHLPwcp/+XP1fhfrUFxBPkqEZ3eStKs+GbLlnfUE9vSYZ2dDWqdDM6+bGastRO28dwQjFVG1lNhwxsZYvR7ZFSWHgYH78mprpoAzwf4QUl4ftLvFXHQDhxdfPAyhEE2D7bIHWt3617/Kmh+q0IPTEYUVjstM0ZT+tOVPuYPCYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763121588; c=relaxed/simple;
	bh=eNU2dfgFmtBJq37mteaUxJp1cGsyEgobjPsimxjft7E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EO9bwr2D6PCfXalam8pBo7vGirGmf7366o1mPkEHNfhzCiemaOo++AXPqB5HFgryL1m62gQtxE2i0CUqn6cM6IEiJmj1vNlO8UT5ar7MAK+nygpoXq8d73iMYM5PlgsgXEU65nATuJeJGgWVxu9VnLUN0ZWZ6ZiEtnpk6hoqU7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=PuHN+dmM; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AE8eSW33654633;
	Fri, 14 Nov 2025 06:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=lxfbEMVp3frthPM2L9tfN8WBAWF
	oJYHNYY5cA7X/Z80=; b=PuHN+dmMte+GwgCV9ogs3Pe9AfflLHSTvEYrX6Cwi0c
	OcJDfD1LOE9e0Gt863xHi2IBXOe2UnjFym+b7wpsXdJxdIzveR4+39kucie7K6oi
	OQivvzIdGtYX9EsXFKjAPBDFp/fV0eSTltAqxLSD8b/OQiBNF4KnOtWQUHBMWHBz
	bcu8AXkWZ6MwxTA/ypTqBneMAZb1Xqv+IMVKHTkjh1dPB5lnQONuKXl4wwCkGE4r
	m3ce1mt9AQLPRpJsqyw2ZLWepR/ObDlZJR3Oqt7bez0VOar4e5RDS0/yFKN5b7ms
	Ix90OFLhYLYhTUCtn0ecnAFEye8P6wy403nKSJ3tBug==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4adwaw1v1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 06:59:03 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5AEBx2La016249
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Nov 2025 06:59:02 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 14 Nov 2025 06:59:02 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 14 Nov 2025 06:59:01 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 14 Nov 2025 06:59:01 -0500
Received: from Ubuntu.ad.analog.com ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AEBwodg018389;
	Fri, 14 Nov 2025 06:58:53 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 0/3] iio: amplifiers: add support for ADL8113 Low Noise Amplifier
Date: Fri, 14 Nov 2025 11:57:22 +0000
Message-ID: <20251114115725.5660-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA5NSBTYWx0ZWRfX0SbCbRpgZMzI
 8ehXrIYQ7wINlj1GvKzkBsExdHiXnUtBY/dOJvwkiq1M31QPBI/2RFnglkcWQ2tsZn2tk17dkwE
 Sd+M4P8msi8w8QTr7tPKRdmA0moe60SHN4ezKIOWcpsuTt0v21q1G5w3LNViE7G+nL7EGq2A45B
 T4o9YcxfgaVrXQJbXHY7c4DXCCYrEFngvQoHDKO5YVslqfrzDp0N5cgpti/rqTVSPtduzD0vVzi
 RE7x8EQEnIGOFcuRorfXx7a177D2N4bQPOcDBDs9SGeeBRxGdZ2aqsn2RvwgjQQJ891HtmOSgxv
 FC5MZ1aiVTTCrk5PggNOz4Ar64JurRAuKIi9m2AarMQ/6Qsa6TYDvIBSebs97iid0i5yah4BizW
 9FRVb34MjwkODQ4KnOjf/Jn47GuKow==
X-Proofpoint-ORIG-GUID: Dm8rQ4OKq9Z-iLZJmRo26spzCjiLjT-l
X-Authority-Analysis: v=2.4 cv=M91A6iws c=1 sm=1 tr=0 ts=691719b0 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=_jDn8YihPVvimUYNn0YA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: Dm8rQ4OKq9Z-iLZJmRo26spzCjiLjT-l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140095

This patch series adds support for the Analog Devices ADL8113, a 10MHz to 12GHz
Low Noise Amplifier with integrated bypass switches.

The ADL8113 provides four operation modes controlled by two GPIO pins:
- Internal Amplifier (14dB gain)
- Internal Bypass (0dB gain)
- External Bypass A (0dB gain) - Signal routes from RFIN to OUT_A and from IN_A to RFOUT
- External Bypass B (0dB gain) - Signal routes from RFIN to OUT_B and from IN_B to RFOUT

The external bypass modes enable external signal processing, conditioning, or filtering
while maintaining signal integrity through dedicated signal paths.

Changes in v3:
- Refactor driver architecture to separate gain mode and signal path controls
- Replace single "mode" attribute with separate "signal_path" and "hardwaregain" attributes
- Add write support for hardwaregain to enable switching between amplifier (14dB) and bypass (0dB) modes
- Automatically handle signal path constraints (external paths force bypass mode)
- Simplify device tree bindings by removing extra blank line
- Update ABI documentation to reflect the new signal_path attribute interface
- Add comprehensive validation for gain/path combinations

Antoniu Miclaus (3):
  dt-bindings: iio: amplifiers: add adl8113
  iio: amplifiers: adl8113: add driver support
  Documentation: ABI: adl8113: add documentation

 .../testing/sysfs-bus-iio-amplifiers-adl8113  |  30 +++
 .../bindings/iio/amplifiers/adi,adl8113.yaml  |  64 +++++
 drivers/iio/amplifiers/Kconfig                |  12 +
 drivers/iio/amplifiers/Makefile               |   1 +
 drivers/iio/amplifiers/adl8113.c              | 252 ++++++++++++++++++
 5 files changed, 359 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
 create mode 100644 drivers/iio/amplifiers/adl8113.c

-- 
2.43.0


