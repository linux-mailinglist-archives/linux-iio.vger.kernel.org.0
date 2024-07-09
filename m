Return-Path: <linux-iio+bounces-7463-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7755492B63B
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 13:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE33283851
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 11:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B090158201;
	Tue,  9 Jul 2024 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="re6j4p8c"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B516D155389
	for <linux-iio@vger.kernel.org>; Tue,  9 Jul 2024 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523495; cv=none; b=JZcRWl2tTAOqxZ/vWky1CLCMq7iNC+Mceug72bTN8kxmcnGzpPwL5tOrfGB2bHeUAMcR/5zlNkGFjEe1YU94UjCp9lDPbAOYN9xZmfuzcrsCAA+SZY4WQndBIh3OZ5aJuvGYX6OCAZwuauH9IhEXPz6OcEcsUDsxmSVCazn7XW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523495; c=relaxed/simple;
	bh=Al29ZryMOt7mW3zbmyPn+19GEwlMRD9iEs9gUbVZai4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=o36f1JAt9QhIVl/Rsws9w66Pb7ZdI/1HsPDAo0PYmEWpRJdYUSpF5NFzxFrDtLHSqpaKCKm05V42ibv0/boAEYRH+bDb7nm+vLrem5IGSsV3qg51zekzKTswD/jZcOxJvJ/7bWWpfOPOD/he1YJsQehOWm85CtmSgk8NYu/V1nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=re6j4p8c; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4695eVX5004270;
	Tue, 9 Jul 2024 07:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Nw5dO
	PGLvqy7uzeU9rXeimsxvHwod7kP3TtA7PWy1fM=; b=re6j4p8cqth2PbVeJCkgG
	2w0sW3fjrPXtAibcSptRcN4pTLomgvith1dn90cYnq/M6wjLxBVfMpu7EWq87t/n
	A8RAYmzj74dsPpyao15FnnCSgmv1fhnkptFeyb7iexCEsfSORGISqQFKxJOHMRfh
	v3WrJsbYPTgQRaWk5Xj7Bo1tPjY8LVfaWX53hibGXSRM4Tb9vbT1eZOhQJpfkf8L
	s6tqt6NaL+CIlV1RKvQEyLWFcY74/LnyzoaOtk/H8aPGZVAY1/3UsFaTZjdANYhK
	va8XVhAMhFctrqg9Ug96Rg5wZ/I5E/vrs0hY+qR5PC0mrZTnomXAO5TCynDKoNYi
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 408y9291nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 07:11:04 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 469BB3Ia055135
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jul 2024 07:11:03 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 9 Jul 2024 07:11:02 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 9 Jul 2024 07:11:02 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 9 Jul 2024 07:11:02 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 469BAlgk032387;
	Tue, 9 Jul 2024 07:10:55 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Tue, 9 Jul 2024 13:14:28 +0200
Subject: [PATCH 1/9] iio: backend: remove unused parameter
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240709-dev-iio-backend-add-debugfs-v1-1-fb4b8f2373c7@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720523682; l=2431;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Al29ZryMOt7mW3zbmyPn+19GEwlMRD9iEs9gUbVZai4=;
 b=oiswgVQEXtlCPM/5ZG8SWTtwVdW9QvhzNRt/BguBAZY7bUeuR51MLepT7xtNIlao3QfOxkgWS
 Jovf5tWZNczCf/kGfGDy8Uf+F5FQQSLZMwGWiBLI9LcRyEdx6T7+U4+
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 2xR6hp4_D9Tj6XD3FKMGIno8YsEf162y
X-Proofpoint-ORIG-GUID: 2xR6hp4_D9Tj6XD3FKMGIno8YsEf162y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=982 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090077

Indio_dev was not being used in iio_backend_extend_chan_spec() so remove
it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/dac/ad9739a.c          | 3 +--
 drivers/iio/industrialio-backend.c | 4 +---
 include/linux/iio/backend.h        | 3 +--
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/dac/ad9739a.c b/drivers/iio/dac/ad9739a.c
index f56eabe53723..9b1570e788b6 100644
--- a/drivers/iio/dac/ad9739a.c
+++ b/drivers/iio/dac/ad9739a.c
@@ -413,8 +413,7 @@ static int ad9739a_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = iio_backend_extend_chan_spec(indio_dev, st->back,
-					   &ad9739a_channels[0]);
+	ret = iio_backend_extend_chan_spec(st->back, &ad9739a_channels[0]);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index efe05be284b6..65a42944d090 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -451,7 +451,6 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_set, IIO_BACKEND);
 
 /**
  * iio_backend_extend_chan_spec - Extend an IIO channel
- * @indio_dev: IIO device
  * @back: Backend device
  * @chan: IIO channel
  *
@@ -461,8 +460,7 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_set, IIO_BACKEND);
  * RETURNS:
  * 0 on success, negative error number on failure.
  */
-int iio_backend_extend_chan_spec(struct iio_dev *indio_dev,
-				 struct iio_backend *back,
+int iio_backend_extend_chan_spec(struct iio_backend *back,
 				 struct iio_chan_spec *chan)
 {
 	const struct iio_chan_spec_ext_info *frontend_ext_info = chan->ext_info;
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 8099759d7242..4e81931703ab 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -142,8 +142,7 @@ ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
 ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
 				 const struct iio_chan_spec *chan, char *buf);
 
-int iio_backend_extend_chan_spec(struct iio_dev *indio_dev,
-				 struct iio_backend *back,
+int iio_backend_extend_chan_spec(struct iio_backend *back,
 				 struct iio_chan_spec *chan);
 void *iio_backend_get_priv(const struct iio_backend *conv);
 struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name);

-- 
2.45.2


