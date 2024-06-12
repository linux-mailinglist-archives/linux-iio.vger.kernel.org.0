Return-Path: <linux-iio+bounces-6213-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A159054EC
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 16:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D851F21E43
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 14:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FA517E915;
	Wed, 12 Jun 2024 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="r17g6HNR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8862117E90F
	for <linux-iio@vger.kernel.org>; Wed, 12 Jun 2024 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201854; cv=none; b=mbfXnGO5cwLRVhTTiOjXhCb9hOPKU1ajKjvVdQFkVKL/0eyJrbnu7l1FWxUApYZ4z+0+YjgHjUZDJQEIontt5qCtnJYlku9GiVFPZOsQlQX/pp+HYtmvCD1LDBdYfvdNGlVPyjvS98pwOVNucnun5PGT1bYRaNnveFeB9oYx0e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201854; c=relaxed/simple;
	bh=+hnurly2JGZ4xZiCxoJh3Tw0X2UwbUQO1AFXBq7dhjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EgoQGjaT35sFX3z3D1jZlNgEGSUvzx3FwkVl8u9Av+BPBusZT30wvYCibf08Nkk4KumTs03h85sRRJfhwS/p+M+zUFzoPdTz1f/dpB95TGerxB4dvoYY8T2mTtk+o8MtFnCNNNy70d/yYUoCKWlmXu7MnWpGM7slCBxzuHT1/cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=r17g6HNR; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CDndjt000785;
	Wed, 12 Jun 2024 10:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lUJOp
	hAD/q+V4mYZ2i0hysTxrxO7UC2IMjuwj5s3WFI=; b=r17g6HNRPKtzQVrcwwgv9
	obf05WqomBndZ9PMsP9Qdx4VDyPNotcNEhGdUiv88V2qP7Lxdn0tR23HxmzOZCq4
	RIdexgSm4EggPT3G/emvGcuaRNqjEVRC9hPlxtSxkZ0JN/ALq96no8YruPheJG+6
	hnoACg3iYsC2mFa1v7rNzR1Bzbj5RAMIZZVkpUt6+oFererIahfAK//nFq2TZADi
	q7SDceW0FC3DyP1UXEyZCgTWaA0yVjrfBaWtODk7CXqX6A5kExaYGcqGJfrfdXRT
	aTd1pMwS1k0VBDgurV2/9Jw3EVCw6j4Qb4esiPxFCpp866Zzaf8epGCfqjWKUHwz
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ymm727k47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 10:17:21 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 45CEHK1M053082
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 10:17:20 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 12 Jun
 2024 10:17:19 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 12 Jun 2024 10:17:19 -0400
Received: from [127.0.0.1] ([10.44.3.54])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45CEH4Ax027005;
	Wed, 12 Jun 2024 10:17:11 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Wed, 12 Jun 2024 16:20:50 +0200
Subject: [PATCH RFC 3/3] iio: core annotate masklength as private
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240612-dev-iio-scan-private-v1-3-7c75c8e3d30b@analog.com>
References: <20240612-dev-iio-scan-private-v1-0-7c75c8e3d30b@analog.com>
In-Reply-To: <20240612-dev-iio-scan-private-v1-0-7c75c8e3d30b@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718202053; l=702;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=+hnurly2JGZ4xZiCxoJh3Tw0X2UwbUQO1AFXBq7dhjU=;
 b=urzCe8U0EisuUmXkMMsJFqseo2Wrk169G/5NjWDVzvz9y52TRj3ag5hiMgc9BBqahgS/QHBzB
 wyKweIhXF/iDr6iDIDEz72JBWCQzQ/LjiI2vOywVifcL0sTGKV0ks6K
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: PGMIETpMUqeyKDJLsnzJZxSqMXKCJgVc
X-Proofpoint-GUID: PGMIETpMUqeyKDJLsnzJZxSqMXKCJgVc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_08,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 mlxlogscore=982
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120101

Annotate 'masklength' as private so that we can get checker warnings if
drivers directly access that variable.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 include/linux/iio/iio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index a63888746707..94677240df64 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -609,7 +609,7 @@ struct iio_dev {
 	int				scan_bytes;
 
 	const unsigned long		*available_scan_masks;
-	unsigned			masklength;
+	unsigned			__private masklength;
 	const unsigned long		*active_scan_mask;
 	bool				scan_timestamp;
 	struct iio_trigger		*trig;

-- 
2.45.2


