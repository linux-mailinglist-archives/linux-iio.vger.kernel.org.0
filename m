Return-Path: <linux-iio+bounces-4044-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1A8898392
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 10:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97C7FB28375
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 08:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E657317E;
	Thu,  4 Apr 2024 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hi4BgndK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A3D4597A;
	Thu,  4 Apr 2024 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712220927; cv=none; b=QKuJ+rWi6Y4dPcFIo4nCFyeqLeAH1kQGaulqGbOzLPweiC1jRzjLhQRuiItKgCQtYn3A6DcCO5V1fv9vhvESxgUt0gs4V3Ov6kgmkSvHO7+cpkDPDYxaKNpxlluGcpuXz1dJfe0FKxIZuVpb3V1OIVOfvHEU9j1l0+NCB4FR30k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712220927; c=relaxed/simple;
	bh=Bmluy+xRk8DrXO78R+oX07cL8R8W3C8ZFNiksVO25b4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Ew/HxNh0jLEhTTRXE+JliBxBjcWFTfZMlrz63Ezj1uKGbFMapEYrvHM4VXqzIMnS4LuSkdi3ORf/lZ4m8Kxet3mvKDJqh6qGvEhjfSwzW3FZ6GE7t7vAkJwY7LGYyfZ/tk7IAqzud6KUehDF0Rqlq8YM85dVAywf5aTe3wTzMGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hi4BgndK; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4348kTIh001466;
	Thu, 4 Apr 2024 04:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=DKIM; bh=L+/ZK/+9rFTuwo2kmZ4
	T+prN647kubpX9fiMdgLiuh8=; b=hi4BgndKCb4a5mU/Wp7mVQ0ud488/LsuL9p
	cD348Fh3a+twr8UhKJt/TKHyCocAuXXGC0RWeq4K5eN/Yp9pzjB4kZKoHBPLakCY
	yMAhhNplPT2dpHatZyWIErrhTgMbDRHXMyxk2z5Xz8Kw0Ab3PEjZpMR8i0+FQYSp
	LSLfoY0Qq368Eb6AYSbIGkd31bT0GJrvdAFtdQW/teGpSP3rzh4bIo/f9I5kUf6s
	G1HRps7V4a4JEqKFDsk4ZP/hAqk/G8225Pw/ZLRBIwskUQJNdBq4LiRb5am9nQAx
	dIJsI11Q3MkqxYUT1FCT+En1vgNB56mnHSUvBvvrEBYKqmQqgSg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3x9eks27d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 04:55:11 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4348t9hA008114
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Apr 2024 04:55:09 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 4 Apr 2024 04:55:09 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 4 Apr 2024 04:55:08 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 4 Apr 2024 04:55:08 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4348sssd001282;
	Thu, 4 Apr 2024 04:54:58 -0400
From: Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v5 0/2] iio: temperature: ltc2983: small improvements
Date: Thu, 4 Apr 2024 10:58:16 +0200
Message-ID: <20240404-ltc2983-misc-improv-v5-0-c1f58057fcea@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKhrDmYC/33NQQqDMBCF4atI1k2Jozamq96jdBHGUQfUSCKhR
 bx7o6sWSpf/g/lmFYE8UxDXbBWeIgd2U4rqlAns7dSR5Ca1AAWlAgA5LAimLuTIASWPs3dR5qi
 trgnJFK1Il7Onlp+Hen+k7jkszr+OJzHf1/9ezKWS2OqmLCtNpsabnezgujO6UexghE/E/EZgR
 /DSqqKxUIH5QrZtewOTrBli/AAAAA==
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712221106; l=766;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Bmluy+xRk8DrXO78R+oX07cL8R8W3C8ZFNiksVO25b4=;
 b=HpLMtPF7iT2Fv7afGShjfQTLveJwpvqS2Hcgpbif2nHRaN8RBKzXzSQ8reWIKtKlOyxcrJN3Q
 x0bDHO7OuJhDQr5Lctaqrrex+IM2y3mUyt/g2RMxvbnAWrQthSDazJM
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: nw88TIYCfixt9pBhNiLqEDawMs7aIxpa
X-Proofpoint-ORIG-GUID: nw88TIYCfixt9pBhNiLqEDawMs7aIxpa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_04,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=664 clxscore=1011
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404040058

Hi Jonathan,

As suggested by you, v5 only has the regulator stuff. I'll send another
series for the new dev_errp_helper().

---
Changes in v5:
- Dropped patches 1,2,5 and 6.
- Link to v4: https://lore.kernel.org/all/20240328-ltc2983-misc-improv-v4-0-0cc428c07cd5@analog.com/

---
Nuno Sa (2):
      dt-bindings: iio: temperature: ltc2983: document power supply
      iio: temperature: ltc2983: support vdd regulator

 Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml | 4 ++++
 drivers/iio/temperature/ltc2983.c                                  | 5 +++++
 2 files changed, 9 insertions(+)
---
base-commit: 6020ca4de8e5404b20f15a6d9873cd6eb5f6d8d6
change-id: 20240222-ltc2983-misc-improv-1c7a78ece93f
--

Thanks!
- Nuno Sá


