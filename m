Return-Path: <linux-iio+bounces-2903-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB8485F8E5
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 13:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C54CB235FC
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 12:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AB512E1E9;
	Thu, 22 Feb 2024 12:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="I8icC6XX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FF35FBA5;
	Thu, 22 Feb 2024 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606475; cv=none; b=ZhXFgaDBxODHXdLyhQC001U4IOqhnjanLsuKutjgZxrW9LqMjKYH5oY+Jy6bq9RRg94rNV6u6+T3e4aYU/st2x/uOrUplngrlT8wuVwxNUhPr/KHeAFG2tYjp3dz69m3FbTHO6rIWI04J2PLGVmSsxZsg7KXHqm5heeNULORFVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606475; c=relaxed/simple;
	bh=ZTYlvwiK9vVN69GcFo/qAmR8YHixWv+wRqRxKtADJM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=VGeeyhoRYkuHGRk9Bqbi7wzg7XRBvvcUX8cDyxHdi4kZ0/kDII9uYlXG4y+9NyDuxSjV1es3Fjb439IdiZAeaSxHVIt92veOuPAuDtgohT6hKySmicdpgBjwWhpC2S20pPGcKwmJ4Bh3VI6x5NKSbEM2UujJfIJGUPCGspMcoP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=I8icC6XX; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MAfYYs016571;
	Thu, 22 Feb 2024 07:54:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=VIv4rW3ent6lnScEcJpfZujhTy9YTm3BxVqW5yvh6Yg=; b=
	I8icC6XXa7kUufc6hj3TIcx9kjCI2V7nyRAg5xTLlHD7k3J0ALLXU+CrhCEfwu7H
	9s3UqOqNz1LIf6nODslq9wKB7/x6xD7eJLMCRkL4z6F6vXuykP2Yz2ixwRBvQk/F
	MuXXHhQ8IBZolx/yOgi+buB8yWU6HbrKrlwcURdCV6im3xcPIoUwyAR3M+7QGADT
	LdMvv5JHuPAhz2RsZGRJFI9CGtEJSD+itOs97vcxlQDXmi7wFpY/qienvm7y8CZF
	Yb0VlflpyoVMeaKxQc7WoWLyc57jhyA7Z5Daq2kqfexRuW/dlugVfT0GSfQAOJUL
	Z6bsSTUXgyFc7nPym1ogng==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3we4r2gd0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 07:52:49 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 41MCqmxh047608
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 07:52:48 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 22 Feb
 2024 07:52:47 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 22 Feb 2024 07:52:47 -0500
Received: from [127.0.0.1] ([10.44.3.55])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41MCqTFC003844;
	Thu, 22 Feb 2024 07:52:41 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 22 Feb 2024 13:55:56 +0100
Subject: [PATCH 5/6] dt-bindings: iio: temperature: ltc2983: document power
 supply
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-ltc2983-misc-improv-v1-5-cf7d4457e98c@analog.com>
References: <20240222-ltc2983-misc-improv-v1-0-cf7d4457e98c@analog.com>
In-Reply-To: <20240222-ltc2983-misc-improv-v1-0-cf7d4457e98c@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708606552; l=790;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ZTYlvwiK9vVN69GcFo/qAmR8YHixWv+wRqRxKtADJM8=;
 b=5Kvk8Qq8zutX1xjjUfZ1u/PiWOgN624RxfnuvZr073l85r9qM4ehzGV9yGpok2dzihVBdMRZJ
 ZvSAKD2D5BABaIk8d8rSPegzuA2llibsTOavYnilBu6ZqCXgM3vv9Uv
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 7d9XSzTIf7ouIcIZ96wO9ODMD47ukuXj
X-Proofpoint-ORIG-GUID: 7d9XSzTIf7ouIcIZ96wO9ODMD47ukuXj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_09,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 adultscore=0 impostorscore=0 mlxscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=745 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220102

Add a property for the VDD power supply regulator.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index dbb85135fd66..8aae867a770a 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -57,6 +57,8 @@ properties:
   interrupts:
     maxItems: 1
 
+  vdd-supply: true
+
   adi,mux-delay-config-us:
     description: |
       Extra delay prior to each conversion, in addition to the internal 1ms

-- 
2.43.2


