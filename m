Return-Path: <linux-iio+bounces-7468-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F8392B644
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 13:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4391F2316B
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 11:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA9215884F;
	Tue,  9 Jul 2024 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rGbTCWBD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733B41586C0
	for <linux-iio@vger.kernel.org>; Tue,  9 Jul 2024 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523498; cv=none; b=rcfs3mJyz7kHngXCzqfkc54WCG8h7Y+COUsnUfaqrHvVixWXPNipiOkp3zLV7+FBsjCllM9xn/8Qo0/UVKEbqgpC5jJHkfkpHAorUJ+uV82JAm0AdfrHhxgz/EuAcQhbzoOPGf5HNcomBi4CWKY5US/jSlPqzMYpIFY7QGc4uKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523498; c=relaxed/simple;
	bh=tK8Yviq+3nXdKD/hKLYBM5KYfUTuZS8wuUq/gPw1kRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qeOuO5MVkXeAaNKIWTJQLRaaHdMythrTtGegKT0TxqrYKZf4HfoQ6zld5+BfgKZQb4c8sJ+NJv159qOd0SGUJ4VER4capqasheM8+1sIa3jiFAje+29ETiTm+/EpfslpLv5s2mvBw5MCYVNwc4eJsQVoyMllquckn+b+zXjxdnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rGbTCWBD; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697Z95M011314;
	Tue, 9 Jul 2024 07:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=FjlLS
	WZUvn24siIHzIoCLohnbPXGknueBcfRclZplSE=; b=rGbTCWBDQAeYGLxy0Ox7U
	LzNwGJWcvM85NZBfgTfg4pOwdYipHuktoOykrEm1Otiiof/3JTsJNjgqk3GBhTZ4
	bWhBE3Qquy8bcIfMYeY7FYgqJb8CoMbKQpIVvDSnbKqgw43Bkt6FAIgn8Dg8+jWH
	iSHXDvrNQj5oOzSu3SoQEYWEPJwxgidMVvXHtbFtZH+yuTwUglPPYTBMMELtCQPt
	td+BrfTJg3EvCUGChWpn8NpMImwoPOUhgio3N0fkzHfPT29bKO9ofTeEGDioTzUX
	7XtdW2lkhd+Ffc6BKFF7H5M2cYe4Nkq/SnopBzcu0YH9BJ3zOwQmSza7eDQrbbli
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 408fy4m1qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 07:11:06 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 469BB55C046287
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jul 2024 07:11:05 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 9 Jul 2024 07:11:04 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 9 Jul 2024 07:11:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 9 Jul 2024 07:11:04 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 469BAlgo032387;
	Tue, 9 Jul 2024 07:10:58 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Tue, 9 Jul 2024 13:14:32 +0200
Subject: [PATCH 5/9] iio: adc: adi-axi-adc: support modified prbs23
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240709-dev-iio-backend-add-debugfs-v1-5-fb4b8f2373c7@analog.com>
References: <20240709-dev-iio-backend-add-debugfs-v1-0-fb4b8f2373c7@analog.com>
In-Reply-To: <20240709-dev-iio-backend-add-debugfs-v1-0-fb4b8f2373c7@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Olivier
 Moysan" <olivier.moysan@foss.st.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720523682; l=882;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=tK8Yviq+3nXdKD/hKLYBM5KYfUTuZS8wuUq/gPw1kRU=;
 b=07n4Lm7aHsKPzRbiZbQ73Pv75WZ1tkTtpXKf0a1izppQQ+yqLfkW3GYb1cY1mMEQi337rZlsD
 Y3IFxX88T3/DppSGs43m0N3edsK/fsaZ5VcrJsWJRplrEsLXIhpnEN+
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: zE6JifwVPdZlbkc-5PeTUk6Ow3l17xzB
X-Proofpoint-ORIG-GUID: zE6JifwVPdZlbkc-5PeTUk6Ow3l17xzB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=757 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407090076

Add support for configuring the prbs23 sequence.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 21ce7564e83d..54499653d888 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -199,6 +199,10 @@ static int axi_adc_test_pattern_set(struct iio_backend *back,
 		return regmap_update_bits(st->regmap, ADI_AXI_ADC_REG_CHAN_CTRL_3(chan),
 					  ADI_AXI_ADC_CHAN_PN_SEL_MASK,
 					  FIELD_PREP(ADI_AXI_ADC_CHAN_PN_SEL_MASK, 0));
+	case IIO_BACKEND_ADI_PRBS_23A:
+		return regmap_update_bits(st->regmap, ADI_AXI_ADC_REG_CHAN_CTRL_3(chan),
+					  ADI_AXI_ADC_CHAN_PN_SEL_MASK,
+					  FIELD_PREP(ADI_AXI_ADC_CHAN_PN_SEL_MASK, 1));
 	default:
 		return -EINVAL;
 	}

-- 
2.45.2


