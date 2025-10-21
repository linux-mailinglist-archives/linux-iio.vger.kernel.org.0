Return-Path: <linux-iio+bounces-25323-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C26BF5E6E
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 12:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BD55502333
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 10:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9033932C954;
	Tue, 21 Oct 2025 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="U0vO9sV6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA392E8B8A;
	Tue, 21 Oct 2025 10:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044057; cv=none; b=amu/FDnLCI1VQMQmT5Mnx2DC8DPFVH9eNFQyZiwisorLooAVU8wcO7Vx7j+S/TQ9fPaqZJN+/vmqbGP7K9ClHGKKhQet0dlDpjLI6/HkgpNuaA5Nk9jQCUOTWuxldR7DkbSb7DgXPvlg6M/FhY9pYo+GeeX5hGz0J7KoI8EycP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044057; c=relaxed/simple;
	bh=Z3j+leuLHrc+jYxLqg3wFif0SikZ1nYjlMvcBtnyz+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=clIZhl09aHdYI3YZfpCn8+sUgzNpFgFXqLsCJXhMMCQ7ZuXC3m+9a/1vJ7+ntbfZd8J3ECjQh4/vl4QK0JP/kDOeQ6+7uDnB1vklz9EtJyfgOF3GroRpRcb7FlS5s93fiaJt+MAOcsqaNd25NxQ22ZpX46jiZvXPgd6PkIDe3oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=U0vO9sV6; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L9qf5C026565;
	Tue, 21 Oct 2025 06:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=BNZ7f
	AVJoRG6dNhPSI1c8dR9rav0Ozws775WSOQMbN0=; b=U0vO9sV6ghUmusOIpQpYz
	QCvirhKjmg/eV/YbybNbYCU9yuuRbBERixGknLcxCunXsSKnfnmeWID5S5jHlH3K
	jaZ2CCbD9fDRxRqkYxblq1J//zCbhui8Hkgpl8UdDEpT7qDQ/gykZpgMHNt5bSrv
	yzEvL3z+CTJ9j/CFeVZtWrI5l8KBK1yGX51T+xjj/w4rpQNS5rXaQEXZfn4JSj/Y
	axKT1bxhBZYg53xT/kptaeSYuiAkUzSefpiahrnfNE9QAVz9of3hwU1g6b749HwX
	EyNlNpzpsxVzUB/qdG6ogFvVFBaV/fq/DHLruRsceqd274Fs54z1YY76ac78I9Fs
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49v7t3f454-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 06:54:13 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 59LAsCPl051718
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Oct 2025 06:54:12 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 21 Oct 2025 06:54:12 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 21 Oct 2025 06:54:12 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 21 Oct 2025 06:54:12 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.161])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59LAs1Kj002507;
	Tue, 21 Oct 2025 06:54:06 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 1/6] dt-bindings: iio: adc: adi,ad4080: add support for AD4083
Date: Tue, 21 Oct 2025 10:53:43 +0000
Message-ID: <20251021105349.21145-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021105349.21145-1-antoniu.miclaus@analog.com>
References: <20251021105349.21145-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDA2MiBTYWx0ZWRfXyw/piqAZozfe
 KQeomYKV5QllSYlpgQc3x5h8Uf0CUzcEdgJbzP2CCnMPNgJVAlv/3c3U9WrmMakMhiLrZAVBF6p
 WowZkwSdgbGXksclfCOgx27DpGfzYqOQzrmeKfcw9OOeKhmn5GOtSTDT6lX17ViS7DeZjPBLJGH
 XuZ1uQcKPCbMUPW6yXF0AziiSSG4PbtlXHE9tynnkaOwDakCuFAlYXzhn0Ez2sYmnG9SxFiK4QB
 8drA6UIq8QzMVbU9zl+NX7aFM8GNK1mnmHFvcgd17l/UJV81RPAY7KYqOqt+kBlA/pHry5UOb5v
 ZuDMleOyXzlW0hm2QO0vMFmVG8ty7fN0uNDvgDg+8AdHp/b3lURDY9/6bdd4JEhg7yfZXuCDqhQ
 VxRu/Z/qD0NTRBEG4JMw88i4owvD3A==
X-Authority-Analysis: v=2.4 cv=UPPQ3Sfy c=1 sm=1 tr=0 ts=68f76655 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=CsfnnTbuaMHnaP1EV_UA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: hyLFFG4AcKnPQgjJmQkytjAO4Qd2o3E7
X-Proofpoint-GUID: hyLFFG4AcKnPQgjJmQkytjAO4Qd2o3E7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180062

Add device tree binding support for the AD4083 16-bit SAR ADC.
Add adi,ad4083 to the compatible enum.

A fallback compatible string to adi,ad4080 is not appropriate as the
AD4083 has different resolution (16-bit vs 20-bit) and LVDS CNV clock
count maximum (5 vs 7), requiring different driver configuration.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
index a9fa068189ea..9d2b4b8edf42 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
@@ -27,6 +27,7 @@ properties:
     enum:
       - adi,ad4080
       - adi,ad4081
+      - adi,ad4083
       - adi,ad4084
 
   reg:
-- 
2.43.0


