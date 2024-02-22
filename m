Return-Path: <linux-iio+bounces-2898-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48F985F8D7
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 13:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A5D1C24BA5
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 12:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D76012E1D6;
	Thu, 22 Feb 2024 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qrR/dK3g"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD023EA68;
	Thu, 22 Feb 2024 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606392; cv=none; b=V37JIGJF7woPjAxBGURqcMnywhT+Dqq3yW1lPIeZalP8YdR93NPemmTjt+8x1SOjyCzE/Ho+Z70uwXlG+NVRiVvVJiYdwOfqr3sZ0zi+SyYFfPksiRhBSEkI5pUmFTq76O3kIv7oFBFUXna/eCNOOp3048HrgaAm/+1qOzJYee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606392; c=relaxed/simple;
	bh=KPn/gGiZOcI/JFBHX2+OKDZD1hrMlq1IMEF8Ebg8ZNU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=NEKGUZL0l2KlXcJUmV5zEhKeE3VY30RIg7MfGpIH4FGQnSzNDUsFlBITZkCsxX/hYhJqCfdc+8pEcjxDAVNn6GyMwF1i/zx3Czt1edNfIRJYA279cVRD7bYVG0H5ivCwK9V3UR4zPm0n8kc/wVIkIO9rmG41MwCNsC6Xk2fDGow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qrR/dK3g; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M9uLNl014855;
	Thu, 22 Feb 2024 07:52:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=DKIM; bh=Um11GDqwlMkP4mfofg5
	tsr5KqlYadWQcEEDX8dJ0ehQ=; b=qrR/dK3gOJgl4gBI5Yn0saKCxNx2Bq/piEc
	qXnEEqqOr+RnQXwdnft0t49UXp4/2QiS3mN9KVmvL3N9+FhlbBNXSZ22ZGTBj5j7
	xqtl7OM5q9+LNwvN+7Vs5MEs5gdsilnobcnSP3AdpfLVVGXeLYQc1SqnJwF0oSLo
	P0eUu5L044RCyjo94g82GI4J0lDg3U9XdhRv1DXYBq5G3hlc9BGgp3aPvvPed5wB
	+Vf/Ks+kWSZ4ZBgru3pSRooqXX4/2btACVc7q2J4TpJSCVRJb81xPEdd5yAE2e1/
	8LJW+gaajmqZH4g0dm0H4ehQ784QfYDhuEWLJ6ZzcdgP61Uf8Vw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3wd21p8k9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 07:52:44 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 41MCqhs5022904
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 07:52:43 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 22 Feb 2024 07:52:42 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 22 Feb 2024 07:52:42 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 22 Feb 2024 07:52:42 -0500
Received: from [127.0.0.1] ([10.44.3.55])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41MCqTF7003844;
	Thu, 22 Feb 2024 07:52:32 -0500
From: Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH 0/6] iio: temperature: ltc2983: small improvements
Date: Thu, 22 Feb 2024 13:55:51 +0100
Message-ID: <20240222-ltc2983-misc-improv-v1-0-cf7d4457e98c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFhE12UC/x3MSQqAMAxA0auUrA1oKjhcRVxIjBpwKK2IUHp3i
 8u3+D9CEK8SoDcRvDwa9DozqsIAb9O5CuqcDVRSXRIR7jdT11o8NDDq4fz1YMXN1LTC0tkFcum
 8LPr+12FM6QPJOlwVZQAAAA==
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708606552; l=984;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=KPn/gGiZOcI/JFBHX2+OKDZD1hrMlq1IMEF8Ebg8ZNU=;
 b=taB58kK8pF/idaIV9Jskm5NRUJYuxbfe5vBpfcrodhLDEchy223ZLuTgccknl7E3BwosUEUcu
 vanIIADNFC5DRB27faQbvkFNe3B+GgVBNzPX3jWko/9IDYnMjVdQvbl
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: fFC3mk4wYfcTkpyDVNwqHYsy3ZzIK2Lj
X-Proofpoint-ORIG-GUID: fFC3mk4wYfcTkpyDVNwqHYsy3ZzIK2Lj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_09,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=701 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220101

This series adds small improvements to the driver. There's no functional
change intended for it.

Jonathan, this will conflict with your series on the cleanup stuff for
fwnodes. If you want, I can rebase on top of that series.

---
Nuno Sa (6):
      iio: temperature: ltc2983: make use of spi_get_device_match_data()
      iio: temperature: ltc2983: rename ltc2983_parse_dt()
      iio: temperature: ltc2983: convert to dev_err_probe()
      iio: temperature: ltc2983: explicitly set the name in chip_info
      dt-bindings: iio: temperature: ltc2983: document power supply
      iio: temperature: ltc2983: support vdd regulator

 .../bindings/iio/temperature/adi,ltc2983.yaml      |   2 +
 drivers/iio/temperature/ltc2983.c                  | 223 +++++++++++----------
 2 files changed, 123 insertions(+), 102 deletions(-)
---
base-commit: 3cc5ebd3a2d6247aeba81873d6b040d5d87f7db1
change-id: 20240222-ltc2983-misc-improv-1c7a78ece93f
--

Thanks!
- Nuno Sá


