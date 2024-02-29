Return-Path: <linux-iio+bounces-3233-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E82786CEBF
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 17:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6A01C22196
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 16:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C0B14BD5C;
	Thu, 29 Feb 2024 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="tACAVdTw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4306D14A0B1;
	Thu, 29 Feb 2024 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222930; cv=none; b=YgROdlYq6q/DNXCsbkjlMh8ZCTKDV+eH47dkrUaQuAWhir79rYkjkbe1AgxOE6Ni9col/Ma2lf2vygbJ9PBVx5Tit+qE17F/Cfx7T5rzoRTqCwEyFwQktWrkY7XPuXwvMjocz3pU38tk8002tyn+GQEpHP8IGCkF3bfJ7XayO6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222930; c=relaxed/simple;
	bh=ZTFAqIXrt40zj7jnvaRPiHeD0ohnUEb81wo1XJdYbyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bNqAn07B2eSy9xS1+hg4OP75PFM8SvaWTL13qza7pk+Mj+nVA85sb2MspCt5OjHW9e6JKo42TS52sGtAGofTV964ekMZKe5OcsWO6YFjVAFMPa8A8RwefHOkV/FdXOmSVBBYSO+hSutNtJS5CWhXNYEc4depX8DgI5nRfGpncSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=tACAVdTw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TDkso2006875;
	Thu, 29 Feb 2024 11:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=/VLfDtZRVsneUB3arPi8dmNIB0QGU5yhhFHQSWLwmPI=; b=
	tACAVdTwq1q0C3a82iylquEG48RZB/YAvd5S8K0IK9MABGdnIOqQ1Xu9G09BtmnG
	JF5NsgxYN1+dJpR+mu8rUTaAzc62WwDKWAzDgRgFRRQqfi48/jhimWbN60nmKDEK
	4R4JoCD9IWXmb5Lg2S2CaUmg2X14ZjzB4yRp54W2Ox2Up/EhjXjm8iykuwhl7N+6
	2eUmGbluSQrIkpixIerLMOoxMA+x1N/rJZ13yiFJ5v0zfRsC1IiwjT5C2oynQpHF
	JQKcZmkbhE+pGcCInzQ1sJ/ODr3JeFPQvAC1HRpvPPD2huhhCIDWSjCntO7gAXWe
	eedY1FeLxUKCUGsfTLDiFA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3wjp9qhnvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 11:08:35 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 41TG8YEE025984
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Feb 2024 11:08:34 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 29 Feb 2024 11:08:33 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 29 Feb 2024 11:08:32 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 29 Feb 2024 11:08:32 -0500
Received: from [127.0.0.1] ([10.44.3.58])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41TG8J9H018856;
	Thu, 29 Feb 2024 11:08:28 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 29 Feb 2024 17:11:43 +0100
Subject: [PATCH v2 3/3] iio: temperature: ltc2983: support vdd regulator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240229-ltc2983-misc-improv-v2-3-cc6f03da2529@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709223103; l=908;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ZTFAqIXrt40zj7jnvaRPiHeD0ohnUEb81wo1XJdYbyc=;
 b=Ghcx8Zz2Vin0C0rTuzfxaDNTIF58i5y9SqAcCQnw7HTfY3xej3owbcb25+80Fr0hh+gH6HAo8
 gRRKg7N/e2VDIG/LVSi45I9J/pPKX3ebUhrNwcWI3ijNh/XqkCreSrB
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: OnvdbSRO51LmNNMi4_PXZuGHyAmTEoOU
X-Proofpoint-ORIG-GUID: OnvdbSRO51LmNNMi4_PXZuGHyAmTEoOU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=828 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290124

Add support for the power supply regulator.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/temperature/ltc2983.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 592887097117..9fb547417536 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
 #include <asm/byteorder.h>
@@ -1581,6 +1582,10 @@ static int ltc2983_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = devm_regulator_get_enable(&spi->dev, "vdd");
+	if (ret)
+		return ret;
+
 	gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);

-- 
2.44.0


