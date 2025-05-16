Return-Path: <linux-iio+bounces-19591-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDEFAB9AA7
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 12:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9173A45BD
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 10:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729B62367CB;
	Fri, 16 May 2025 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="fX4Qcerz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999AC236431;
	Fri, 16 May 2025 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747393167; cv=none; b=kVjpMWxBpP89B0IaR8eKTSCt6BmPEBl5M6XRJ3VWQi1gI8QD0zm8qLG++9m644Erxgkqt1UGYfqxxVYz0w0qLADNkbQSTirNiZDylREfW39XDTifMalywcZRdoIr/D3Ud8ofh7Dqj2U+J+2IJCKUZEiV9qpz5oJDy4rtYC7WRqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747393167; c=relaxed/simple;
	bh=8n5vfw2mNTOuq2EktnNj1CALxl3b0x26IBLkYOudw2U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHb87m2pFu/6B0Tfvp3IJp/fjVppnzWB2sB9Y+RnL8Ka6iX+z4TqhOAI20/CMJWaPEmWRKaaVRvdwG7jolOBndyha/yYympl5202SA8uAlwZz/XtQGL3B7fAIuPIJkzq/qWH477p6SzGVt7XkqdFiJlaI7/zVYhLOk42pvdRQdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=fX4Qcerz; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G8fjBq016350;
	Fri, 16 May 2025 06:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=qf2gi
	ndpfEn5Dnk29cqTyVX1Ov9nbZCV1G3+utnQJyw=; b=fX4QcerzzWkdb6x/RAzWb
	c+nxnekmM1jyRqIS333kgWW/ql6VWiVrAQBG1+1tGPo/CZrYcen/eO/V9V12IhvH
	/lYb8Bv0nPBgpz58yWu+IIYnqLkcfTpxPC0RHAN4bVZ6r3dGRmKNuCkGObeLjA9G
	b4oB0g5ms5TH4W/5eM15IjZowuD/BbPPZ7WsdYkp3e0HDv9azz8PmgCPqrFMKRfR
	egjAZC75jCNKnYjgvkuhzd26UccOyAMM2D2b5UqUe2VGtaf5rgbk4s2J9rx8o91h
	cGyg6BLyRUWDDWYvFDol/0tUGu5yYuQtUszwtXniJ0fElRg+kxoRpIquU2w5sFox
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46mn655jtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 06:58:59 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 54GAwwte050052
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 May 2025 06:58:58 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 16 May 2025 06:58:58 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 16 May 2025 06:58:58 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 16 May 2025 06:58:58 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54GAwRHv006196;
	Fri, 16 May 2025 06:58:48 -0400
From: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        "Dragos Bogdan" <dragos.bogdan@analog.com>,
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
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?=
	<joao.goncalves@toradex.com>,
        Herve Codina <herve.codina@bootlin.com>,
        "Ioan
 Daniel" <pop.ioan-daniel@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/4] iio: backend: update iio_backend_oversampling_ratio_set
Date: Fri, 16 May 2025 13:58:01 +0300
Message-ID: <20250516105810.3028541-2-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250516105810.3028541-1-pop.ioan-daniel@analog.com>
References: <20250516105810.3028541-1-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: jGpNSYt9TeuP3nSrjJ88BF_LLReK7_XI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDEwNCBTYWx0ZWRfXyxydKLcLgRIS
 SAm1IK1sBPxXjaEPDA+gfJfDY0YO9WssMzC8W/tZLfnrvLzNOcjdwyMulNIM/SYgy/2gmkpcdeK
 BpFUT7Y8OZ3MvZsljHDREnWG3RsRcrALcQ2eWeRLSc/GqwwCywgy3xZ+ksUUN6bYHqQ78mfPedj
 ySIv8IRpn6VnWc/CNtNmmm3eL42hxoNoCMozTjLxOJazwBVoqBxWIvf/sLioLVFQASsz3icZu0y
 pgytZE/+2U80RELjPt0rL1eAxxOi+dxbErWKpIiwth31R4atz0N5lRklINYpooVpG2zT+5FR3sY
 hVx/NdUQ/igHM0NQ1oYR/5sDONNJq6s5qOr2baS3Fo32PGzGO4R0HRu6gQPlgLJiHFHBrAJutWC
 TcvarNsZZRt67ETJKioy0Q1I6VJ/c0tFwhLwGBll82bJajVv77gYGk7tFXn3U6GbsWPc9NuW
X-Authority-Analysis: v=2.4 cv=SZL3duRu c=1 sm=1 tr=0 ts=68271a73 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=fL5q2TxrE0MATQOmR6AA:9
X-Proofpoint-ORIG-GUID: jGpNSYt9TeuP3nSrjJ88BF_LLReK7_XI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_04,2025-05-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0 spamscore=0
 clxscore=1011 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505160104

In the function iio_backend_oversampling_ratio_set the chan parameter
was added. The function can be used in contexts where the channel
must be specified. All affected files have been modified.

Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
changes in v3:
 - fix ad4851_set_oversampling_ratio function channel error
 drivers/iio/adc/ad4851.c           | 6 +++---
 drivers/iio/adc/adi-axi-adc.c      | 3 ++-
 drivers/iio/industrialio-backend.c | 3 ++-
 include/linux/iio/backend.h        | 3 ++-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
index 98ebc853db79..fccfca256670 100644
--- a/drivers/iio/adc/ad4851.c
+++ b/drivers/iio/adc/ad4851.c
@@ -294,7 +294,7 @@ static int ad4851_scale_fill(struct iio_dev *indio_dev)
 }
 
 static int ad4851_set_oversampling_ratio(struct iio_dev *indio_dev,
-					 const struct iio_chan_spec *chan,
+					 unsigned int chan,
 					 unsigned int osr)
 {
 	struct ad4851_state *st = iio_priv(indio_dev);
@@ -321,7 +321,7 @@ static int ad4851_set_oversampling_ratio(struct iio_dev *indio_dev,
 			return ret;
 	}
 
-	ret = iio_backend_oversampling_ratio_set(st->back, osr);
+	ret = iio_backend_oversampling_ratio_set(st->back, chan, osr);
 	if (ret)
 		return ret;
 
@@ -831,7 +831,7 @@ static int ad4851_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_CALIBBIAS:
 		return ad4851_set_calibbias(st, chan->channel, val);
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		return ad4851_set_oversampling_ratio(indio_dev, chan, val);
+		return ad4851_set_oversampling_ratio(indio_dev, chan->channel, val);
 	default:
 		return -EINVAL;
 	}
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


