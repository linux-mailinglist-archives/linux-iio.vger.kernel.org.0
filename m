Return-Path: <linux-iio+bounces-2904-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE5885F8E6
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 13:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A078DB233A5
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 12:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5657712EBCD;
	Thu, 22 Feb 2024 12:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="k+UP0DkY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B3212DD96;
	Thu, 22 Feb 2024 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606475; cv=none; b=F9+HUNDXVcQg+ZRVBRGMW8zEFl08qDZw3DwFTJNYY3YaaLma2YQLnV3LK1nsQ/KYCGETTh2+efeZaT8BbAKCsXyZT2RWUsw4j5RZnwIw7TSBFyyV3iDMNZDnhyQfHMK9AEDXiR69QRynAZo08hO9pZdElXTgd/9437rx5oas7ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606475; c=relaxed/simple;
	bh=rCnlKD8b+gtA03NTNp9yXgTO+UWNnKjvPIXyqlwcN1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mwtYvPhNTzmm8xIU/ae3UzWg9BYV64ZktlXhBVwIkDijK6tGgy9jG+eOc6RAFk2ZsBkYcf699xmInjXyJrUCI868lvk7mO7nMBij1Ppb3/IAdrety2VBpAnnU7Et0IxDDY5yPlUlDOnYJF423IU24LK4FsgIlg8UbyvBVO+yPx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=k+UP0DkY; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MAfLjJ016357;
	Thu, 22 Feb 2024 07:54:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=6/J6c7gdgJfA1dTJNS21v/V1aKxV/G+GTCGksVKLi+0=; b=
	k+UP0DkYLw+sJwbw/M/HvvSGpUlEJAd6+dEjM2fE8+H2verHJhm4ze9doOSFbJZx
	wQIBvTKvq+xH9SXEqL3cgfbjokme12xctSfoxUAtMFcc5ZdP3kJ+Td2jpuAv+KHv
	zfiYMhcsnMm1Gzf91zHnrDFSsNxqRPyLnR/JMjVp+OQWfExNvFRFhFFmH0gDXK+z
	Y3uvIp2jy2ahffBl3nJd+i82KwgBnDLVGnFm6BnFF6UcG4A8KVXNGFXPxfBGuiuY
	JOm3LJAqavlqt0aoKYwlbzfv/u34OjlvE7Wt3GbivdrWDCNeqsbJIT8vc41S8E9Y
	/xunMcnxbJ4IjNTgfzs47Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3we4r2gd0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 07:52:46 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 41MCqjuS047599
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 07:52:45 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 22 Feb 2024 07:52:44 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 22 Feb 2024 07:52:44 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 22 Feb 2024 07:52:44 -0500
Received: from [127.0.0.1] ([10.44.3.55])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41MCqTF9003844;
	Thu, 22 Feb 2024 07:52:38 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 22 Feb 2024 13:55:53 +0100
Subject: [PATCH 2/6] iio: temperature: ltc2983: rename ltc2983_parse_dt()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-ltc2983-misc-improv-v1-2-cf7d4457e98c@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708606552; l=1042;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=rCnlKD8b+gtA03NTNp9yXgTO+UWNnKjvPIXyqlwcN1E=;
 b=XptwqaqLuZsK3OLCZh1omMt75l8dijwvZWaHOmcDpwPpmKHZBb23F/k4DSXIpEsDDwI/+kuAj
 nVr5EJz6WT3Dq4TcXsb5F557OgiZV81L+FSbwPHagMYxJoxHG++WTBE
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 0YTL4vtjmxlrLhxkC8gWkzU0yX6ut8yq
X-Proofpoint-ORIG-GUID: 0YTL4vtjmxlrLhxkC8gWkzU0yX6ut8yq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_09,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 adultscore=0 impostorscore=0 mlxscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=598 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220102

Rename ltc2983_parse_dt() to ltc2983_parse_fw() as there's no explicit
dependency on devicetree. No functional change intended...

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/temperature/ltc2983.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index acc631857e27..23f2d43fc040 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -1346,7 +1346,7 @@ static irqreturn_t ltc2983_irq_handler(int irq, void *data)
 	__chan; \
 })
 
-static int ltc2983_parse_dt(struct ltc2983_data *st)
+static int ltc2983_parse_fw(struct ltc2983_data *st)
 {
 	struct device *dev = &st->spi->dev;
 	struct fwnode_handle *child;
@@ -1630,7 +1630,7 @@ static int ltc2983_probe(struct spi_device *spi)
 	st->eeprom_key = cpu_to_be32(LTC2983_EEPROM_KEY);
 	spi_set_drvdata(spi, st);
 
-	ret = ltc2983_parse_dt(st);
+	ret = ltc2983_parse_fw(st);
 	if (ret)
 		return ret;
 

-- 
2.43.2


