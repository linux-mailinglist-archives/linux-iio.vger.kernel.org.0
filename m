Return-Path: <linux-iio+bounces-4088-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCC889A057
	for <lists+linux-iio@lfdr.de>; Fri,  5 Apr 2024 16:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A0A2870A3
	for <lists+linux-iio@lfdr.de>; Fri,  5 Apr 2024 14:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332F516F27A;
	Fri,  5 Apr 2024 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="g/gs4c6x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC8016F83A;
	Fri,  5 Apr 2024 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329039; cv=none; b=pAt7KBym2JHjbeNQCX+RVwa2YmCv1UVYw6fjfofXfwTqTHlUGKOP/zpBsd0LJVQdyAPZqoqQcn6dg91Gh3Ow0FBnxVDo22lQ2Ci8+9GSU3DJCm61a73weShpuLUnzDI5ZEzAdX7mpZM5dEhyO2oTJ8BncFKLHPPbV4HM5zAZrQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329039; c=relaxed/simple;
	bh=Fk4lWJpMLZkXmh2N8T8oTjFVOtwLh8aQfDOUkMx9F6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=sEdp8xWlrC9FuQNx86kDialrtbYHnl/arcXPiOROw1XzYjTVa/rhvtTiKzkVa2AgYvkX/eUMmzhQeFL5/KtByeZfYTuupdNrGHiWqiVL+F+s7wNXVz9HwCjSRGl2TlVww1KvvoLFAx1O+4QEfF9E7tLSvlLAPZXaOla3ymS2DFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=g/gs4c6x; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435DaOL9010390;
	Fri, 5 Apr 2024 10:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=YVKGNoKzrvkurl2nO2h9vb6vOjILdh+BjuxYqEdiIMQ=; b=
	g/gs4c6xu+g5b1S6I9VCMWboXtS8Jj1Yi9ghrrVMrplz0j+Ooa90TQxmRGOi3FTq
	2yzfTJlBECKpasXqtTFtyG7IU+fTt+zaiG4/Ta/P7EPsDXT5OIjXfmN9REHWAwB4
	KA5Y7bCdo6AWFCucCGJFc1LSgYdDA2iU6ps+J1yjGnfYr+oIXxZ26YYnHhq05+OX
	Dq0l0j41AZ1KBPhCO5WcCocynbH/4CoDqg6pY0op3IdR+Xi1g0vVK6T52gGZoPNe
	dIgYlCuH/3hTvTJsrPs672Q1kbnvw8K0BDKnUNbAuCImYpS6eqyD0D1FNmom/xDc
	cmt5s267Jj3+KJVH8s4DSw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3x9epgr9j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 10:56:51 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 435EuooG022801
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Apr 2024 10:56:50 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 5 Apr 2024 10:56:49 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 5 Apr 2024 10:56:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 5 Apr 2024 10:56:49 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 435EuSI3019011;
	Fri, 5 Apr 2024 10:56:45 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Fri, 5 Apr 2024 17:00:03 +0200
Subject: [PATCH v2 05/11] iio: buffer-dmaengine: Enable write support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240405-iio-backend-axi-dac-v2-5-293bab7d5552@analog.com>
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
        Olivier Moysan <olivier.moysan@foss.st.com>,
        "Paul
 Cercueil" <paul@crapouillou.net>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712329201; l=1350;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=hXi2S9a5+uGRDuzr8SCbjBuocFR5uBxzW+WmAaRiTGE=;
 b=QFMJEDxlzTbTNE9mxkNujadqoWY5zuMtDwaxoORP+bvGsVz4yq9swT01hNQXqQXm2PfpaZ2wg
 q5wsCnq5mCYAFd+4scwPKz6qWNFHiE1tlHi4G1g1FW9rf/IlHPtHLYg
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: aZ8IjIbnJC4uwv9_P4xN-UFic0ySkiNY
X-Proofpoint-GUID: aZ8IjIbnJC4uwv9_P4xN-UFic0ySkiNY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_16,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=820 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404050106

From: Paul Cercueil <paul@crapouillou.net>

Use the iio_dma_buffer_write() and iio_dma_buffer_space_available()
functions provided by the buffer-dma core, to enable write support in
the buffer-dmaengine code.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 051e1758e020..e5492572b248 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -123,12 +123,14 @@ static void iio_dmaengine_buffer_release(struct iio_buffer *buf)
 
 static const struct iio_buffer_access_funcs iio_dmaengine_buffer_ops = {
 	.read = iio_dma_buffer_read,
+	.write = iio_dma_buffer_write,
 	.set_bytes_per_datum = iio_dma_buffer_set_bytes_per_datum,
 	.set_length = iio_dma_buffer_set_length,
 	.request_update = iio_dma_buffer_request_update,
 	.enable = iio_dma_buffer_enable,
 	.disable = iio_dma_buffer_disable,
 	.data_available = iio_dma_buffer_usage,
+	.space_available = iio_dma_buffer_usage,
 	.release = iio_dmaengine_buffer_release,
 
 	.modes = INDIO_BUFFER_HARDWARE,

-- 
2.44.0


