Return-Path: <linux-iio+bounces-19295-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EDBAAFA0A
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 14:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A2C50032C
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 12:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9D1226CFC;
	Thu,  8 May 2025 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="BqcYmesB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3A9223DE1;
	Thu,  8 May 2025 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746707545; cv=none; b=rlFBHdKEbfk2JWKsiuA09sKhJGLqJqnAYGNG0S+PaM3tAZs5xUp32Z6NBTDOalZxof1AgGH4g0vk9IwGYcaTbX5l+r5gyIECGMpKGcww+Fb6YUcyRnmKNBUWSEnMXePhihkFtwhQYHVwIamIByl0Qfrlph1fpmePiXlcea1Ml7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746707545; c=relaxed/simple;
	bh=E4oEosSyCiPNDkT22KvKs41/Oniec7K9eXj1nBEHYXY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMq4DdKleVR9fV7BqV7rqcH6HBHEweqoUDcCz7unKUusD9c+2lKmS0a4upH7QjNFaZXFblY5+Sx+9bo9c7IAhsc+JVVofPWoFdu+Ifg3jJscbKheA9VbAHgGeJ2qU8CemWKSDY9YlHsId98sOU38YEpPq2FryahkBlADm0+3Ze0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=BqcYmesB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5489D7e8013396;
	Thu, 8 May 2025 08:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=luQpb
	VFooXCJXBeCKn2OxAfDeV2OTc2lqpPMukD7Zgo=; b=BqcYmesBZr2TwJBWw0CsW
	6mN4HTp9XSl/oVuMx8cLJ51OySwa1XZYRbPtCzrng4mh4fIMObnKp17g+2aSukGo
	SoVPTTNFLs0RSY/sZ65ShJJ0O6E1Y1Ijk6tVZaFTyy70JauqB8Sn3gT8tSr7DsMj
	TOVGPfOG4QNrcLgFPvJwc35a4i2SP2SmTmrDdTfT3cyMeB9SkpYdVjZ2kCL62RJo
	my7ZnX6wYruiyHPB24q0qoDf5yLZ3E8lSDoYipNtSKlYM8teOvcSbB4GoULWaxj+
	VeFLAArKR2E4TBsKtoJrYJxWtlXFceorYMi2WYuVyo205wiloNW/fzF7Kgu/7Cg7
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46gpct1uj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 08:31:49 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 548CVmI9019187
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 May 2025 08:31:48 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 8 May 2025
 08:31:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 8 May 2025 08:31:47 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 548CVFtd002317;
	Thu, 8 May 2025 08:31:40 -0400
From: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Dragos
 Bogdan <dragos.bogdan@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Tobias Sperling <tobias.sperling@softing.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Alisa-Dariana Roman
	<alisadariana@gmail.com>,
        Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
        Ramona Alexandra Nechita <ramona.nechita@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/4] iio: backend: update iio_backend_oversampling_ratio_set
Date: Thu, 8 May 2025 15:30:54 +0300
Message-ID: <20250508123107.3797042-2-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250508123107.3797042-1-pop.ioan-daniel@analog.com>
References: <20250508123107.3797042-1-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=J/eq7BnS c=1 sm=1 tr=0 ts=681ca435 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=fL5q2TxrE0MATQOmR6AA:9
X-Proofpoint-GUID: koe-7oWa1sQGWmPwVKEKvxKeRElGbmu1
X-Proofpoint-ORIG-GUID: koe-7oWa1sQGWmPwVKEKvxKeRElGbmu1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDEwMyBTYWx0ZWRfX9QPTZDp8ssJG
 lYABLio9pFUTHLDqRp06dFJ8O4SKAUQOAb9zn3PAlf+vdFPqgVWGzcDob+Yg78NaFYGG8TQDawR
 3jQ1p6ZiPPsGcdEAgYLue4QgBmQiFMm+gorO2yVxahqN1Udfc/F2TuL/2DihApugCmWz+eu0lJ4
 claPHMVUjfXSisZ3XX3tDr/6Ia2i09KmfvXt0bKdLjc2821srrlQqP6ex1GwMG/y465TQGLBe2a
 Us+R5Z1DLT/qADuPhyXyc61Ae2OYZznO9hw7vPgtW2pEW/zaqbAs35iUB68OFQ7k1dz1fv1B9K1
 VAk9s5QZBP443ljSMXABPio0zziswFvKi7DxuNMOgibX/Rq8CbtbNZpnoY+gBbY1QwNLhmqnqRH
 eA7AwBZL0uJBE+RH2n3p5wSl3feSdGtPFJaUrvNslIHaNpRm19Fa0akQKTB9T7Q3/9S49HiU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_04,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505080103

In the function iio_backend_oversampling_ratio_set the chan parameter
was added. The function can be used in contexts where the channel
must be specified. All affected files have been modified.

Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
changes in v2:
 - remove iio_backend_set_dec_rate function and use 
   iio_backend_oversampling_ratio_set function
 drivers/iio/adc/ad4851.c           | 2 +-
 drivers/iio/adc/adi-axi-adc.c      | 3 ++-
 drivers/iio/industrialio-backend.c | 3 ++-
 include/linux/iio/backend.h        | 3 ++-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
index 98ebc853db79..a943d5aac9e5 100644
--- a/drivers/iio/adc/ad4851.c
+++ b/drivers/iio/adc/ad4851.c
@@ -321,7 +321,7 @@ static int ad4851_set_oversampling_ratio(struct iio_dev *indio_dev,
 			return ret;
 	}
 
-	ret = iio_backend_oversampling_ratio_set(st->back, osr);
+	ret = iio_backend_oversampling_ratio_set(st->back, chan, osr);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 4116c44197b8..9e8c30230791 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -381,7 +381,8 @@ static int axi_adc_ad485x_data_size_set(struct iio_backend *back,
 }
 
 static int axi_adc_ad485x_oversampling_ratio_set(struct iio_backend *back,
-					  unsigned int ratio)
+						 unsigned int chan,
+						 unsigned int ratio)
 {
 	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
 
diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index c1eb9ef9db08..a4e3e54fecb1 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -720,9 +720,10 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set, "IIO_BACKEND");
  * 0 on success, negative error number on failure.
  */
 int iio_backend_oversampling_ratio_set(struct iio_backend *back,
+				       unsigned int chan,
 				       unsigned int ratio)
 {
-	return iio_backend_op_call(back, oversampling_ratio_set, ratio);
+	return iio_backend_op_call(back, oversampling_ratio_set, chan, ratio);
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_oversampling_ratio_set, "IIO_BACKEND");
 
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index e59d909cb659..dbf4e4a5f4b1 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -144,7 +144,7 @@ struct iio_backend_ops {
 				  enum iio_backend_interface_type *type);
 	int (*data_size_set)(struct iio_backend *back, unsigned int size);
 	int (*oversampling_ratio_set)(struct iio_backend *back,
-				      unsigned int ratio);
+				      unsigned int chan, unsigned int ratio);
 	int (*read_raw)(struct iio_backend *back,
 			struct iio_chan_spec const *chan, int *val, int *val2,
 			long mask);
@@ -209,6 +209,7 @@ int iio_backend_interface_type_get(struct iio_backend *back,
 				   enum iio_backend_interface_type *type);
 int iio_backend_data_size_set(struct iio_backend *back, unsigned int size);
 int iio_backend_oversampling_ratio_set(struct iio_backend *back,
+				       unsigned int chan,
 				       unsigned int ratio);
 int iio_backend_read_raw(struct iio_backend *back,
 			 struct iio_chan_spec const *chan, int *val, int *val2,
-- 
2.34.1


