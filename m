Return-Path: <linux-iio+bounces-18494-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B23B1A9636E
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 11:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00FBC189D2CC
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 08:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900B02500DE;
	Tue, 22 Apr 2025 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ri2lFMF6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83BE9476;
	Tue, 22 Apr 2025 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745312159; cv=none; b=swI1q9u3ljE2Crn3h9de6uxkwafANn4QaG2nTHFSCd7GdpyZ7vmqHsLvtBwucupipAHhgIzgm9L8H1c5mlOcnOU+COjlMSiW5J9YXK4IiMkERU2lpUdMYYjQyFHeRBzG/kLbdB53dI6YTI/vCamLP5wa7R64vs6nRpO0zcp94N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745312159; c=relaxed/simple;
	bh=yX13Nrm7XU6lcL0Oap5aDNrx80Jy+5DZfYDRl7FDB38=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XmaggfiLLlEaPuVWBf6AEMqNaLqVLYZDIUYwpeJ1MZ7tByAj4i0OD8M3vwfekmsgTWnJ91yh8Sab5ddRNrcJE09KCw05s9GunADPwmWLD4jbxK2TpMYigPM48hA5HUlfF4hKGTVt8P7TN34w2/fMYAMt/oHA6obKOqq2lzki+w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ri2lFMF6; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M8jb28021970;
	Tue, 22 Apr 2025 04:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=EefXO0RJBAHGT9wE1slRaeGPqzD
	LrkK42wILdaoz2hQ=; b=ri2lFMF6jPQgr7afwzvNovTK1ytCECLBkeGBAMxUA0e
	dYCfheEanSKfFBGHRYRW+xvCzSLVjPSBY5Liw1lfFkXqgVn384adV1MSSKJPP3m1
	cEGzfzWeG+MmyJ7WqldfsRs9XtjAVv8IDT7xZNqRlEaYAGajSklJ9JG+37diuPEf
	hYiTNRQM9k2+q4fuOsNQKrLDybsbHrDzsyr7AK7o6d8cKQ2xPsts6TboBEx5CRem
	0Uefl8jbuAjedjVy/0b3dIGnlZ2MlqimOmI2sIen3VQxQp6qcEAt1ylrC5iKFggQ
	oPUYyNd0z7OR1DkCTh5DeD/RLhawW/J7g4/Rv7PA2SQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4645p7p8xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 04:55:54 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53M8trna041698
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 22 Apr 2025 04:55:53 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 22 Apr 2025 04:55:53 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 22 Apr 2025 04:55:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 22 Apr 2025 04:55:53 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.211])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53M8tjRW016347;
	Tue, 22 Apr 2025 04:55:47 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 1/2] dt-bindings: iio: dac: ad7293: add vrefin support
Date: Tue, 22 Apr 2025 11:55:28 +0300
Message-ID: <20250422085529.4407-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=D4VHKuRj c=1 sm=1 tr=0 ts=6807599b cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=HDJaYqw-a77z7M850UcA:9
X-Proofpoint-GUID: 1qzyEaTWT1rkKmrD4Htlm6SclVrd50fi
X-Proofpoint-ORIG-GUID: 1qzyEaTWT1rkKmrD4Htlm6SclVrd50fi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_04,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=923 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220066

Add support for vrefin supply responsible for providing external
reference to the SAR ADC within the part.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml
index 5ee80bf6aa11..f994c1ef6d41 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml
@@ -27,6 +27,8 @@ properties:
 
   vdrive-supply: true
 
+  vrefin-supply: true
+
   reset-gpios:
     maxItems: 1
 
-- 
2.49.0


