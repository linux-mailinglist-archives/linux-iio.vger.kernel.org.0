Return-Path: <linux-iio+bounces-24577-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE29BAC86E
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 12:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4161188DACA
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 10:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7CE303A2B;
	Tue, 30 Sep 2025 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="AqZbCyfr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A39529B766;
	Tue, 30 Sep 2025 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759228384; cv=none; b=Dmu++JNc0X7OqZNhDqOWAUeH8qKwVzHBSQq1dc93wLDUYa0yWAqbJXzeadP7VIgC7t8J5PVIdvTN+WSGqTC+o+HH3QAnhnpbAc9t6z4HzBPgS6SfYHu+dQeuqcRPHmQO+d3VykvSMGijgCN4GxrwOWFPWId8vtBGp6JmClwtUZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759228384; c=relaxed/simple;
	bh=UQxfikSTP64QQcNIwEcsuiFkh1dnScLjJVncaQgEFDM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lc2XKvmJ7iGorFjpPGWcWdkdjdQU2a8uvUV487JCLDF9eMRC/G8+mrOCHIOOZOeu+YGug/HhJZQdVWL05Ldxf0b/16Sg8eQrZlbU2qgOq1naDV5gpQinbEwR6GBuamVtQUqwxth5nYH4v4d5anc9gslSwtPu0WtrVnW/JLPqZys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=AqZbCyfr; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U8FgKL026774;
	Tue, 30 Sep 2025 06:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=22Jom
	wbJA2rI0tLgFnpQx8wv9KEiqZH1MHNSu9XBQyw=; b=AqZbCyfrQisq6Ocm6yQLp
	9dqUB/GzahP/RFKTHAvYkPxR5ciEDRtGLzpxtnTMVSyu2ChfG9dFZ3ZdObbqn0+q
	Rpw1pJV3c/iWgm/lyV0lWOCx6Q68dhql2XsKlfNzQRb9H6lzddKBhrz1BHBx2nzS
	YTpxGX057mjVjSFmvWbqRfTHZeZ1jCEvd6vzq8bm0xiF0VlPgN2j51nVbWqL0w0q
	Uz4JHHkfmoohxE/ocy98PwT4N/dMWDBtJxM54g6U7BpaO+lyF6JxAwEKakJk1r3U
	pGBpUh6YNnsx+lfMfWKEy477T1fWqesmDqqCCo/FpfY8zvCzwE21kQISWunxOPVi
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 49g7sjhwnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 06:33:00 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 58UAWxUf027488
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Sep 2025 06:32:59 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 30 Sep 2025 06:32:59 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 30 Sep 2025 06:32:58 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 30 Sep 2025 06:32:58 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.188])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58UAWipX025133;
	Tue, 30 Sep 2025 06:32:53 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 5/6] dt-bindings: iio: adc: adi,ad4080: add support for AD4081
Date: Tue, 30 Sep 2025 10:32:28 +0000
Message-ID: <20250930103229.28696-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250930103229.28696-1-antoniu.miclaus@analog.com>
References: <20250930103229.28696-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 89XYOaM4Lf6_lQCviH3K2u7qljmS1hAr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDAzMyBTYWx0ZWRfX/Nx3i33Q+5MC
 FX3ZPO2fI5E9TbMbahP3+orcMNkVT69sqxjlDPv6YHbC00VSHAQYkwH9MAaX3YhKZgFN2JW9FTx
 McZy+xxEuu+maGBA5M51dvv2zlxXxI0EF+3I1vY7IsFq5HoE8WR1QuRfcxiq8TiEpxxxVWN0CKM
 Dj+k4Mp+3w6Mf4vlu281HuzNAx1DosPs5foAxL2UT7e18iNP0kRSHd/TxhJ5+3TlVEonKBZZCEE
 bPimC4c8wB4aRzgTuD8dhiMLmZQ+ubzmr6l0VChOuNMjCPAdQvRUAAUIQ+xWEAHYFiH3O+fcdPq
 4OfMhjiEEwekFfsLGqWKL5Uq8UR+AsuGkzJaGDTTyhFQq6aO9JMkta79UzQQKX9RhTeO6r57QuG
 4R2rmtHzErCB5GHWyampWlsZ0MuCkQ==
X-Proofpoint-GUID: 89XYOaM4Lf6_lQCviH3K2u7qljmS1hAr
X-Authority-Analysis: v=2.4 cv=U/CfzOru c=1 sm=1 tr=0 ts=68dbb1dc cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=agZHL2U0blbLjZyOsOkA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509300033

Add device tree binding support for the AD4081 20-bit SAR ADC.
Add adi,ad4081 to the compatible enum.

A fallback compatible string to adi,ad4080 is not appropriate as the
AD4081 has a different LVDS CNV clock count maximum (2 vs 7), requiring
different driver configuration.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - improve commit description with respect to fallback compatibility.
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


