Return-Path: <linux-iio+bounces-2899-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFB885F8D9
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 13:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0EA286DDE
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 12:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A27E12FB02;
	Thu, 22 Feb 2024 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FSKXCQpp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CD660B90;
	Thu, 22 Feb 2024 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606392; cv=none; b=rhn+PVe67werINn2ShvrX3PensVZHWSkX3prrG/4HsQXa0rJEhxNWi+g6bF81HyCIEtxU3OSlXR9akHXdzxoJz7z3tMerAImxm/e1HWW5hEnUQIiIiOBxaa+bFCCX1GtdeOzri79ry7MKgkaLr32AwrG8S4WWMvNEeymvRE5UMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606392; c=relaxed/simple;
	bh=v5loQEcfCIJoJhzCt8ePUvNFfs0yZ6UNWSbufLX9E/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KX0HH9622Gzk0EspgxtcNCJNXfQLWh2n8Thnfw/w1uOxT1kBViJ7/Y2wyDCAP/WuIjM79qYk69cvJ47U1mDjOSojX4mSmTGDMdgku5aWKFsvKhyo0b3+j4z9k3wpa9TmTw3uM2yJi5vhTzxoLBI9xMfu1cqZZp6iWwfkOS4E54M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FSKXCQpp; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MAfFWf016288;
	Thu, 22 Feb 2024 07:52:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=cyF9bSmkLHTbgIOAHAAsLTu1Vwr2sxa/02k1qWn90Gs=; b=
	FSKXCQppkHcG1cynmZDrrh3PC+3loHT/fUViTJ2F5vTmhnHSmj9w/gYU7UtGQdan
	tpP452HYwwp7xYXcWOto5DcxkEcsj6TF2Pij7T+gl6N8JGibGV1szdL5rC2aT6rr
	oLD74vLd8KhPdb8yYeNntSOjf1ZBquvLp1gcPnYVbCHfBH6IRTaeEif9oloeQQ72
	L2uCzBDEPu0EcH0XCppLKzqRCzG7UC5JNgIc0A8HCiDOvNigPBwjzNremS33xrj7
	3164xxYJr5QoY0BDbKLy+QYl8A/MuokwauoP7rAE/baxitfoBnrB37KUNytVXEXt
	1BsOruqh8p2nbuuKajoQZg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3we4r2gd06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 07:52:44 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 41MCqhMF047592
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 07:52:43 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 22 Feb
 2024 07:52:42 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 22 Feb 2024 07:52:42 -0500
Received: from [127.0.0.1] ([10.44.3.55])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41MCqTF8003844;
	Thu, 22 Feb 2024 07:52:37 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 22 Feb 2024 13:55:52 +0100
Subject: [PATCH 1/6] iio: temperature: ltc2983: make use of
 spi_get_device_match_data()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-ltc2983-misc-improv-v1-1-cf7d4457e98c@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708606552; l=784;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=v5loQEcfCIJoJhzCt8ePUvNFfs0yZ6UNWSbufLX9E/w=;
 b=jAeNPlJa3eRP3Q13idxXiqPKB4MQROM8iCwq1IDj70Y19FB9LBJu4sJk9NbOzIXJUUOi9JVRM
 h9xprJZPMUsCYlM2gyKKLhgkS2z+LkvWNVi7vbn/3YuTOCMak50/STw
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: uXQU7vJgoqPcdvnFIAX0GwpBJw2D0wkX
X-Proofpoint-ORIG-GUID: uXQU7vJgoqPcdvnFIAX0GwpBJw2D0wkX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_09,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 adultscore=0 impostorscore=0 mlxscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220101

Use spi_get_device_match_data() as it simplifies the code. No functional
change intended...

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/temperature/ltc2983.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index fcb96c44d954..acc631857e27 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -1614,9 +1614,7 @@ static int ltc2983_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	st->info = device_get_match_data(&spi->dev);
-	if (!st->info)
-		st->info = (void *)spi_get_device_id(spi)->driver_data;
+	st->info = spi_get_device_match_data(spi);
 	if (!st->info)
 		return -ENODEV;
 

-- 
2.43.2


