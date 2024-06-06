Return-Path: <linux-iio+bounces-5882-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7DB8FDF6C
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 09:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB62287990
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 07:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6B013C820;
	Thu,  6 Jun 2024 07:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="EyR9y5MI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DC13D56D;
	Thu,  6 Jun 2024 07:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717658402; cv=none; b=cWHxG00jvZjU+YQGeePNbtQxHMg51q9OHlac5BsxrnwH0FqM0UqMXtSSbHmwQwL0uGo3D+nlzLjMBmGajH8aEDPG0ieAspNpMGjqZbfXbSMC0Gh0CND0fhA+CUjoiJJnNSBLFQc4vcENRa9nXmiQP26Y3CAW/nL6oaf7+RODlak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717658402; c=relaxed/simple;
	bh=OsovVgPh1Oh1YUHUMd1E03/7+jrnPnfqiPtBVblpv9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=F4qq3H5qMevcthwUhgdjL8XqY2ajRAKHsV02POAd3xcXRiHWiEnZ28yfBBn2+A4HStTnpFmNHwYRhAR0jzy7N8VQTxHxBGSrDe6fp1FhjMUqhB5muOExLjNFgNJZHeUypgMdp6fySfp8sBhS6UmnsI8sRizkImOaeCHjTt5eNIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=EyR9y5MI; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4565DJtX019258;
	Thu, 6 Jun 2024 03:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=FAj+p
	gJmEDllgvpSsEUgFzbngKUhGW2y7aItHl9cl6E=; b=EyR9y5MI0AS2aeuUGJ/j4
	J3JI9+z/wzeu4RcgmiA08/Vj8HOmVe/7VXavvbQxUOWC+/kO5QgpXUTfWQO3mHC/
	2CNCGRZldRdtmPZUWqoZP7cDeI6ELB7LCmGKBzm8R0AUQkRPtSbszuo67/QcfUcl
	6XcStHOQHPUbpP7RQ5ZTOdoWH/1mavAzFGpcgvi89YprM0vccUXKLtQBjc97va1+
	ZuWcqYLz0LI9WQLGdUxJpbtWtR3VPAYSkVfK/tdpwmAMWHDM91FbnImGnBuOCkKa
	mJqKxFHZEjbzJA3f4lnekG7HNfZw+HGGi4MVj9LorqoX9vO/rGQVm7QlezcsSMCG
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3yjuesjmhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 03:19:20 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4567JJqs030130
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Jun 2024 03:19:19 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 6 Jun 2024
 03:19:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 6 Jun 2024 03:19:18 -0400
Received: from [127.0.0.1] ([10.44.3.54])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4567ItBe025782;
	Thu, 6 Jun 2024 03:19:14 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 6 Jun 2024 09:22:39 +0200
Subject: [PATCH v3 3/4] iio: backend: make use of dev_err_cast_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240606-dev-add_dev_errp_probe-v3-3-51bb229edd79@analog.com>
References: <20240606-dev-add_dev_errp_probe-v3-0-51bb229edd79@analog.com>
In-Reply-To: <20240606-dev-add_dev_errp_probe-v3-0-51bb229edd79@analog.com>
To: Petr Mladek <pmladek@suse.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chris Down
	<chris@chrisdown.name>,
        John Ogness <john.ogness@linutronix.de>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Shyti
	<andi.shyti@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717658563; l=960;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=OsovVgPh1Oh1YUHUMd1E03/7+jrnPnfqiPtBVblpv9I=;
 b=8HR2zinO2yjseNWZUlbrgIBPYWeDOT94XjWOgTzUO2wWlwq9+l6LQFcetEj+J4MKCQc5lSNp0
 ccBuW2plZhiDy/W6DaYnC9LFxkKP/imSdgp/snT1OLcyIvV/br2cwWk
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: DboaPG8eU8Ky7JiiQ4xIWNClf_G4S1dV
X-Proofpoint-GUID: DboaPG8eU8Ky7JiiQ4xIWNClf_G4S1dV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406060052

Using dev_err_cast_probe() to simplify the code.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-backend.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 929aff4040ed..efe05be284b6 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -561,11 +561,9 @@ struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
 	}
 
 	fwnode = fwnode_find_reference(dev_fwnode(dev), "io-backends", index);
-	if (IS_ERR(fwnode)) {
-		dev_err_probe(dev, PTR_ERR(fwnode),
-			      "Cannot get Firmware reference\n");
-		return ERR_CAST(fwnode);
-	}
+	if (IS_ERR(fwnode))
+		return dev_err_cast_probe(dev, fwnode,
+					  "Cannot get Firmware reference\n");
 
 	guard(mutex)(&iio_back_lock);
 	list_for_each_entry(back, &iio_back_list, entry) {

-- 
2.45.2


