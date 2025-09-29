Return-Path: <linux-iio+bounces-24561-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 593C0BA9BC7
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 17:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E0A3B3380
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 14:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E0C30BF59;
	Mon, 29 Sep 2025 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UuqJZDfR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49D730B506;
	Mon, 29 Sep 2025 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759157977; cv=none; b=aVjxtpQQsFw+W9avPk69faTeTBBB31aG0Eo3eY2t1XRqlDZBja4rcKZNapGjnNlmn/FAsTvaqcJVw1FykfaIPxfsZMOYrSpukPHvQpIBjST36xi3q42Z+CCzsaB3CSNpb4z3tOivqXJppF3v4kVqfI4SLFEtu5NpZyKnfgOC7pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759157977; c=relaxed/simple;
	bh=1Si6LRPLEnEuKAZr/+XCFpEbrfsUKAMk06OOyf8/UtM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nUv9TKOv3thyL2RO9ZVKAU16SyjS7hxZ3kZsQBUQWEpPT6xLhZSLp8j3ehwrWxvYV4uHzntLenRRvv8Ndk4S18GgLNk8C1fEOSpXh4tTz4RAaihJpb0q1PmoPVfIov02jdsj1mJWhf1MmgGKPhRig70B4fN776A9FlRWBqhFMig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UuqJZDfR; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TCM7eb000989;
	Mon, 29 Sep 2025 10:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=JgRr6
	BMXmX1dzW2eLzd+xwgIXicNcoqws+2rKQdYqI4=; b=UuqJZDfR8LDr/iTkeOx7B
	8pPq9y9R/p86G1lantEXB/9DA2maedWygIPne1tXVw/GhMr/a9egYpIjOLctKHy9
	I532i9bjdEWzXF/nEXZzlYA2KFr9IFw/LoHXcOHk7RQhMAd7yLaZgsp61Om6+u0U
	zxCAS6v0rje5ExsBfmgZBol3auKnvG2jtiAK667mMgp6nUu6kDZ3dXttS/ieG96f
	XGIojFY0LxAsHJGerJXSr+Gw+Dn7wF0qumbm5tS6GjxZD0j/5AzQohpwhtiyEqT2
	RoapJBmCJTU0eUQEVeaAhvbsYo02kSnhnkk08KmA6kPP0O5QA8YrZD1a4XmO6xJp
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49ecu1jeya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 10:59:26 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 58TExPDJ013580
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Sep 2025 10:59:25 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 29 Sep 2025 10:59:25 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 29 Sep 2025 10:59:24 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 29 Sep 2025 10:59:24 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.188])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58TExDGA023559;
	Mon, 29 Sep 2025 10:59:21 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 4/5] dt-bindings: iio: adc: adi,ad4080: add support for AD4081
Date: Mon, 29 Sep 2025 14:59:08 +0000
Message-ID: <20250929145909.111243-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929145909.111243-1-antoniu.miclaus@analog.com>
References: <20250929145909.111243-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: IV5p-M3AgJgjzHXsBm6iSxbjQhlriszX
X-Proofpoint-GUID: IV5p-M3AgJgjzHXsBm6iSxbjQhlriszX
X-Authority-Analysis: v=2.4 cv=A5Nh/qWG c=1 sm=1 tr=0 ts=68da9ece cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=u6jFpFUtrpAD1STt0M0A:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA4NCBTYWx0ZWRfX5kdBklYWXgBA
 VqpR23GN5EmUh/QuMVUPz94HuuczFk2pqGKd1EuuRRwOA/98YR+DB2zldTLDPRzgbjDGAx6Dgm9
 Lcs5XY9ivo3hMnETMXYUHeDzaw0GMWwlOslM6v0ZqXdhIISWEsLzz0MTuFjG4K5uywqdltj03J+
 PWuJOiYKDnqprpvZcEgw4B0f9b9FKBOVdG/+1ZPR+lRk3IM4xupKXbWxENIDeKaZEasyi6ojVUE
 zU8yyQAnWTkZhdtZsd3o8MZA5ATYsyhxAsseTC92NGaqGQ++BZXJI7f04EVAVaW9dlbbqrY+zIM
 q9o9k2kFThDZEoK8E+X2AwQYmklCCx0yG6K7hEhveIutwoc7k5Mp9mMXLNok8p0ICpc2U1Uw9bH
 S4yO+PFG0EbLO5Ghp47UF48l02x1uQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_05,2025-09-29_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270084

Add device tree binding support for the AD4081 20-bit SAR ADC.
Add adi,ad4081 to the compatible enum.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
index c4c5d208f502..a9fa068189ea 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
@@ -26,6 +26,7 @@ properties:
   compatible:
     enum:
       - adi,ad4080
+      - adi,ad4081
       - adi,ad4084
 
   reg:
-- 
2.43.0


