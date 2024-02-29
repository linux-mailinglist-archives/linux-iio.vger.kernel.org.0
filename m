Return-Path: <linux-iio+bounces-3234-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3063086CED8
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 17:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FCAAB26D90
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 16:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DA614BD63;
	Thu, 29 Feb 2024 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="iH6WOGww"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5CD14BD55;
	Thu, 29 Feb 2024 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222932; cv=none; b=eSgIuXFVbwL3wI8nuKopAs5m9ckB0tugB0xy28TrvH2VATBpwe/lyfVr/tYzW2gL9m5cD3/wAyEtiZJTRGlW8eMbJgcq1c2yuLIBmKHslP90vKxJeiNSM02c+Zvq2qWx6Pi/ZbGHph588hK0XHOGh10mYxltSgGFr9PrlrAJOdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222932; c=relaxed/simple;
	bh=phQc4hkSIQn3yiHAXeWQFXx0gX5DVha/1Nz+fvFb5T4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Dn30VJDI9m1vUbSkXFHqnaAlsPejfqNNZwgz/rPlQS+KQp+wj7xtsw1QzXWL74KrMjWYtuno99c5aqd1EEBobOTeWvf9WNFGGrONVwdyK38aaIQozx9Xx+LfTPz0DVf1RLNdNPhyPf8w3rEcAYsl+cKoWi1GdyHgQKZrm6xDn6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=iH6WOGww; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TEaiRk007950;
	Thu, 29 Feb 2024 11:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=ra31unJsEAYSWY1z1PbIppgkrQBB0gAJpLnLbGWvzX0=; b=
	iH6WOGwwP4t4JmeH0qTwgP2Yap3rpj7MxqvZcM7q7CLhfY5VCd/wTFMNSDyzkgcj
	cUs9O/a2c/7ioCAT3+ykAPs0Rm4cv/S/6IFKOSpookA2xS4WakVOSeFlbS3NjRt2
	ZUpmDg2KuU7eolZMSWTofDM/k70fFXFAeBxc223oLscgv7SBJASeldiRDu4cRbtL
	jXg2XKEjF6TBWTKURsJga4qym6wHVONT0uJYhxqa9xkxN3Zr/wJJYCY3Won7UfnJ
	ZjDUQFsoMW4/lSmEXSGE1z8TbTxV96FZ0ygCSrWmDMudJi+fJt28hcN9X/+oOQWr
	FSgBdiBLfMxDhiFqHlPnHA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3wjcr2utnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 11:08:37 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 41TG8Z76034092
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Feb 2024 11:08:35 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 29 Feb 2024 11:08:34 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 29 Feb 2024 11:08:34 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 29 Feb 2024 11:08:34 -0500
Received: from [127.0.0.1] ([10.44.3.58])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41TG8J9G018856;
	Thu, 29 Feb 2024 11:08:27 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 29 Feb 2024 17:11:42 +0100
Subject: [PATCH v2 2/3] dt-bindings: iio: temperature: ltc2983: document
 power supply
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240229-ltc2983-misc-improv-v2-2-cc6f03da2529@analog.com>
References: <20240229-ltc2983-misc-improv-v2-0-cc6f03da2529@analog.com>
In-Reply-To: <20240229-ltc2983-misc-improv-v2-0-cc6f03da2529@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709223103; l=919;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=phQc4hkSIQn3yiHAXeWQFXx0gX5DVha/1Nz+fvFb5T4=;
 b=2OuzH1kF906TvjFiJDcpTN+R7LBDKz09rrCxfMZy3wSCTZXW4AlsoRn4hrv0jmtU7MU1ba07M
 wR+unqQkTZSBq+q4wfLQTDNRJLTPHAlngRfrTgj3KQK7FYia/eocjMz
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 5oxWpDwAiVCnMUdI3g4LuOXj73FdW5eR
X-Proofpoint-ORIG-GUID: 5oxWpDwAiVCnMUdI3g4LuOXj73FdW5eR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=815 clxscore=1015 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290124

Add a property for the VDD power supply regulator.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index dbb85135fd66..2e4a2fc71d23 100644
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
@@ -460,6 +462,7 @@ required:
   - compatible
   - reg
   - interrupts
+  - vdd-supply
 
 additionalProperties: false
 

-- 
2.44.0


