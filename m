Return-Path: <linux-iio+bounces-4046-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E3B898393
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 10:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD75288C11
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 08:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51BE7351C;
	Thu,  4 Apr 2024 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0UVTtqLV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3856271B5F;
	Thu,  4 Apr 2024 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712220928; cv=none; b=SutqK1RkHFYIVk4H4h/orKKIwfl5izx5oWSH2yfPgYe5KaYV00dHVdqmYQzKajR5GV0hQhhMGRza7mvlOwm+L7swn9Gm8JFLGnwlXQNBYqFR3tyrMo1J3ii4G5QUyOB8TMcozKkuvVk146jhNWn5wdlxSlIVbrEotYNiPxyU4fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712220928; c=relaxed/simple;
	bh=3UYDorInvey7nQI7WMgBACMDcgbmPy0ynB6yOVD2j6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=id7oDo8EhP+3nbd5GcGdo+8/rnnpOK1pUTB3/Uw3AIJ53L8MYT6s9+D6Fg9IpNpG6Kfjq9M+Ty/zSg4XsGUAK3Rhiu6DLeo1VVe6l7DfaXPhqxpKG3bZ3iPJ1VfJ0vl93V8o3mki0DeFVRtLJItkNjcFYFRAa+bN+LrmRBCsMp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0UVTtqLV; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4348ducW001566;
	Thu, 4 Apr 2024 04:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=S/JE/q+yecJ+hhhn20Pa60Y1rLF+8emoePICUwwC3zM=; b=
	0UVTtqLV+KoqxizD0OlBX+f7/dao1LN2uN9BIQ3I5ZpmATXA1vrhAKSoSFB+npCM
	3MGdA0IQ58joaeF7//8dlIG2yul/ZC/JnW1s5d6wn7zLIm1A2ktLZqt2Su17ezz7
	9GWJdX4tpLqZQ++/CN33F9B4xjAfw+VjxR/BqHZ6DNihFsP/yEywXUVGsaVat1TZ
	Z8ejEHtEkJZuDUykYEe7WAhDbYPY+5WCOKLdIWXU0N2Nrvz54DrXQmHZsT1omrtg
	ws7/X9URckTB/VOGs4p0lZjkCnGcSrsJmSCkTbTt4atdyU7NpIfvoOAcYjSuLWj3
	IwrJHhuSMW9N2/z6dla/8g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3x9eks27d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 04:55:13 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4348tCcb008120
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Apr 2024 04:55:12 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 4 Apr 2024
 04:55:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 4 Apr 2024 04:55:11 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4348sssf001282;
	Thu, 4 Apr 2024 04:55:05 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 4 Apr 2024 10:58:18 +0200
Subject: [PATCH v5 2/2] iio: temperature: ltc2983: support vdd regulator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240404-ltc2983-misc-improv-v5-2-c1f58057fcea@analog.com>
References: <20240404-ltc2983-misc-improv-v5-0-c1f58057fcea@analog.com>
In-Reply-To: <20240404-ltc2983-misc-improv-v5-0-c1f58057fcea@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712221106; l=918;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=3UYDorInvey7nQI7WMgBACMDcgbmPy0ynB6yOVD2j6Y=;
 b=FIXo+0S++5vWrGo6zYMMnZaIQLPkuh0+KT92qBt+vnyndiSWuL9J59TPqgkwAx6AX/X3JQ7Ql
 AuPbcbPYs56Agj/Hvp/E6ewlPrSO3m0OMkWZ7J1xx8RMtcAbpwvAeGQ
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: jWyLloGnCYJWMScZ17kfPNwGJYG7MGvu
X-Proofpoint-ORIG-GUID: jWyLloGnCYJWMScZ17kfPNwGJYG7MGvu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_04,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=818 clxscore=1015
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404040058

Add support for the power supply regulator.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/temperature/ltc2983.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 3c4524d57b8e..24d19f3c7292 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
 #include <asm/byteorder.h>
@@ -1597,6 +1598,10 @@ static int ltc2983_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = devm_regulator_get_enable(&spi->dev, "vdd");
+	if (ret)
+		return ret;
+
 	gpio = devm_gpiod_get_optional(&st->spi->dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);

-- 
2.44.0


