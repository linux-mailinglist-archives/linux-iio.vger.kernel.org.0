Return-Path: <linux-iio+bounces-4084-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D14D89A050
	for <lists+linux-iio@lfdr.de>; Fri,  5 Apr 2024 16:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B55286F86
	for <lists+linux-iio@lfdr.de>; Fri,  5 Apr 2024 14:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9041716F83C;
	Fri,  5 Apr 2024 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="pGWsI5wL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05E616E89A;
	Fri,  5 Apr 2024 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329037; cv=none; b=kcRlyaYUSaXOBY77YiJgMX+MHLnepcaudHqy3T8gOwkyaP+7LL3AAYYl0JEWHGZV5zzraKPx7ijLOI7/bOWTaQFbWXy1iWXFhP0lH6jGMJmS9RNCLIPlNqp8n8foan49xcljCFGGw5fUedS1J4JSXTE0HKaGQkQI4HFnyALUhQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329037; c=relaxed/simple;
	bh=mCB16t3+g129ghh2o430OaRwSkYkPeXRs4g+4R0Qrnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=guRlN6z9/qPpw7ksEnW2r/fuxrfaLCMAxSDSyB6aFkPouXQVtN5FMokWn+4K/6pOtgXLviQGdyLpGpV/dmzpAOE4XrCSokhRbYwSqwtFbCUSOJf7VbppLK5SdG2VcdlGb3K3MVJQyJZL6CeT3IiNUQtsE/H9MteufI4NLtwEPJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=pGWsI5wL; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435EeVgK002587;
	Fri, 5 Apr 2024 10:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=26rbx00DbDmhlj/4NhogudIvf+TAi3HsFqUm8YDkX8Y=; b=
	pGWsI5wLbB7FedSdLK6VpdKd7sYxhQHhAbRYLzS0Q4mTMnI+bbDseD931OGtNFfT
	DB76Scf6RZClmuNYENrvvCiVQNUoNXPlYPbh3GUa0QaHMgVJY4sb+kdATVP+lLrj
	eFdD+BF23m4OigR23awTAW/2RhjualNCQj5/qea5VwTNGGZLr+EnmnxHv4XbB4c3
	QVygVfddVB8WTx4DkezSzFolXfe6t2+JcCU+C3UD1INfIDZCPrBW5awzx78n+AG1
	6nyp70q8UqcsHZKWeMZa+Eu8ImQixP5A+6RKMATpBMh37rLt8uOA4YLjNHsGhQ0H
	BUVvkElsMAa4z5wz0Ce/cw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3xak96r2k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 10:56:58 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 435Euvdh022824
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Apr 2024 10:56:57 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 5 Apr 2024 10:56:56 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 5 Apr 2024 10:56:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 5 Apr 2024 10:56:55 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 435EuSI6019011;
	Fri, 5 Apr 2024 10:56:49 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Fri, 5 Apr 2024 17:00:06 +0200
Subject: [PATCH v2 08/11] iio: core: add get_iio_backend() callback
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240405-iio-backend-axi-dac-v2-8-293bab7d5552@analog.com>
References: <20240405-iio-backend-axi-dac-v2-0-293bab7d5552@analog.com>
In-Reply-To: <20240405-iio-backend-axi-dac-v2-0-293bab7d5552@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Dragos Bogdan <dragos.bogdan@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712329201; l=1045;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=mCB16t3+g129ghh2o430OaRwSkYkPeXRs4g+4R0Qrnw=;
 b=NLXX21lHC7mwFKVpRocSeU6Pv61PJSkiRBE/HqdPkFAN+MxyLBtsNgbS1ctI5Y9/ahz9HbTT4
 WP4Ucp+10D0ALNbDg9a0AINvWv2PQ6I+WtiZeoF/iDzcXOh3ZAUj0Xg
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: gIoIuoIYgulIILFUwyPApOr3p5jBANxI
X-Proofpoint-GUID: gIoIuoIYgulIILFUwyPApOr3p5jBANxI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_16,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxlogscore=872 impostorscore=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050106

This new callback is intended for IIO frontends that have more than one
backend and these somehow extend some channels. In these cases, if the
backend framework is responsible for handling some IIO userspace
interface directly, it needs to be capable to get the right backend from
an iio device. Hence, we need to callback into the frontend so it can
give us the right backend given a specific channel.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 include/linux/iio/iio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index e370a7bb3300..83158c93330f 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -526,6 +526,8 @@ struct iio_info {
 	int (*hwfifo_set_watermark)(struct iio_dev *indio_dev, unsigned val);
 	int (*hwfifo_flush_to_buffer)(struct iio_dev *indio_dev,
 				      unsigned count);
+	struct iio_backend *(*get_iio_backend)(struct iio_dev *indio_dev,
+					       struct iio_chan_spec const *chan);
 };
 
 /**

-- 
2.44.0


