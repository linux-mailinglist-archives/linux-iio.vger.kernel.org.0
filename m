Return-Path: <linux-iio+bounces-7470-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5815392B648
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 13:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135D728375F
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 11:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7B81586D0;
	Tue,  9 Jul 2024 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mhrRiAY9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576B5155389
	for <linux-iio@vger.kernel.org>; Tue,  9 Jul 2024 11:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523506; cv=none; b=ZLSZeFNuE0BDOeZhrRJEAWo9g2jFixLvyL0dSeS2cuHgmSbF+bG4WAAzZF+XjhhWanbHTo0xMoFS8Cw8WyhKLSBv3wl2WlPRUumDSvUcF11ZyfoWhXWC9DcBLCUZ2hSdl5szK60aOi+aHDnG/fa+dvckSoKrs4e67OBn9Cysx+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523506; c=relaxed/simple;
	bh=o50v2cJuiKP8YniWONn9l3GpdiNckMIc1Fnj6RUCT+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lxqS/l5q58VlK0UGo8qQoiQ7ysP8HmLLBo+ABwsrsLTDRsUdnEJbWd1oZOrUwZifXT809/K+P8MUiUzcFsg1l1V6fUvGGLG3w4+S07WB7giYdVC2TmcxnIecAu6yELXxoUJ10Jnx7jWikidN6I5CHvsiWKMJ15GmCO4+4ew4AaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mhrRiAY9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697grl0029841;
	Tue, 9 Jul 2024 07:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=fkgBB
	ukgMdl0yPC3xMRBr0VWsgGPAhcytTqKtBKhtNQ=; b=mhrRiAY90urWGvByqWIS9
	sHMnOmnJQmXwl3Bna+NKdHfgWiy6HktVgE1kZGJ95EvYRR9byojt9KEIshepst+9
	apVKlwIiMURCG5U5+poKD6xkrdoH5fZTS+AsECcryTqJCdrVkCUCznCnv/BWUSaj
	SlRG/Vx9nE9dhPbSpRAeXxywvtYkhPr9FZ3yvU0Nmvsj0x3UXVx6VMTGT76YZTNB
	J9y4/ny9xhyepVOa84kliWHhRqGiDe7RZRTban3TPFlPkOzALB0WOKRap/AzGVi9
	h+zxY7JfnzPaMAi8qL4g0SEnHmZ/S+rOzgOMwPni6jNIBP73fFJ2h/ntIN3Et7xE
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 408fy44100-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 07:11:06 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 469BB5J2046284
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jul 2024 07:11:05 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 9 Jul 2024
 07:11:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 9 Jul 2024 07:11:04 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 469BAlgl032387;
	Tue, 9 Jul 2024 07:10:56 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Tue, 9 Jul 2024 13:14:29 +0200
Subject: [PATCH 2/9] iio: backend: print message in case op is not
 implemented
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240709-dev-iio-backend-add-debugfs-v1-2-fb4b8f2373c7@analog.com>
References: <20240709-dev-iio-backend-add-debugfs-v1-0-fb4b8f2373c7@analog.com>
In-Reply-To: <20240709-dev-iio-backend-add-debugfs-v1-0-fb4b8f2373c7@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Olivier
 Moysan <olivier.moysan@foss.st.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720523682; l=1120;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=o50v2cJuiKP8YniWONn9l3GpdiNckMIc1Fnj6RUCT+E=;
 b=dAaUv2pd6eStfOClkw5zDO5pjW5G8rYl7z9mHQjgZgFOvf9zS2X1CU2uZnln5nhhIDPh40ahI
 uNh2rs4qAA2D+R4R+3uAn5/kTok9ouBZIMLVD9MbSi9A3jC68CLL/fH
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: iQGcJ-NfH-QNeOhESClkDHlukmUy23nW
X-Proofpoint-ORIG-GUID: iQGcJ-NfH-QNeOhESClkDHlukmUy23nW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=633
 clxscore=1015 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090077

For APIs that have a return value, -EOPNOTSUPP is returned in case the
backend does not support the functionality. However, for APIs that do
not have a return value we are left in silence. Hence, at least print a
debug message in case the callback is not implemented by the backend.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-backend.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 65a42944d090..f9da635cdfea 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -40,6 +40,7 @@
 #include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include <linux/stringify.h>
 #include <linux/types.h>
 
 #include <linux/iio/backend.h>
@@ -111,6 +112,9 @@ static DEFINE_MUTEX(iio_back_lock);
 	__ret = iio_backend_check_op(__back, op);		\
 	if (!__ret)						\
 		__back->ops->op(__back, ##args);		\
+	else							\
+		dev_dbg(__back->dev, "Op(%s) not implemented\n",\
+			__stringify(op));			\
 }
 
 /**

-- 
2.45.2


