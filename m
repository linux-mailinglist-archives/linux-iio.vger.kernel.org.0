Return-Path: <linux-iio+bounces-20144-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7478ACAF5A
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 15:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680E616BC5B
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 13:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E12221703;
	Mon,  2 Jun 2025 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="BP0RYbO+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341032206B1;
	Mon,  2 Jun 2025 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748871932; cv=none; b=bVH/FL9UiBnvtl4MDWvSfVoFxwZZtNKT12r3s61SAz0XB0j2m+4jmw5vUPL/aS9v8BIMVO4pgV6OHNm2bS8KC91BAL1WCDnFCAqDajVbyj76t3536qwLZhFF0NKZnmoQGih++KOJQ0H7M6uizA7aFq6qaJSq2UauGKlhNbiBxwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748871932; c=relaxed/simple;
	bh=1MlIF7M31QlsPFQDcjTmc9DyCW6ABClB+CWissbCxcU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ODtyFTgQtw2n0Wnz/6DUwAkQlLtVkxlPKVYXV4J/eMNfNYBAgp2obUVamfP3G875264W4xPrlkG8AIQMZ2B6IO855dLxQt25gZjUvwUaTx+k/5QRx2Ka7zcGrEKgSKDjmNAFh6ci0Z76cknl6hQ8biOnLulaUB7bTDhH8E8PfkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=BP0RYbO+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552BemiL005985;
	Mon, 2 Jun 2025 09:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TJFhf
	qdFiE5JfRPZgVZSPYnSMpU3/60kVuF22c8K30Y=; b=BP0RYbO+RW+c3PQ2PY049
	kvf85dH4KQuAFeYvuhEO1bxCOb4quEuQKyWoMyhQ9urf42h1QO2C6Vd6pzz0AsPK
	OxsKR63GwRr72ncWaYZ9cfC8P+XkatZHVDLgZBUDqA6A6NEpuK/oDzUNXljvjuv7
	55xpz1vOrju/0aW3M99seqpub2vlr1nsg/S+5DKlLPwGyiFB0LXj9hsj6xAhMDId
	MHvqUstD15WzHkS8C7MTRgppSzWfue6S/KpykjhdJS8pxxuka1ypCbC4J3UCmfO+
	3JXDqk3j7/Obkha4rGDZ8L1iVIf8bFa2R66Yo0p0ddPbiRdV/MWiutar2MtUy8aj
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 47133mjjyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Jun 2025 09:45:07 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 552Dj5IL036984
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Jun 2025 09:45:05 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Jun 2025 09:45:05 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Jun 2025 09:45:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Jun 2025 09:45:04 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 552DiSJN010531;
	Mon, 2 Jun 2025 09:44:59 -0400
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
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        Herve Codina <herve.codina@bootlin.com>,
        "Ioan
 Daniel" <pop.ioan-daniel@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/5] iio: backend: update iio_backend_oversampling_ratio_set
Date: Mon, 2 Jun 2025 16:43:40 +0300
Message-ID: <20250602134349.1930891-3-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250602134349.1930891-1-pop.ioan-daniel@analog.com>
References: <20250602134349.1930891-1-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 6O16xnYIGtEQzeJojyvWtwiqUl9ebIIC
X-Proofpoint-ORIG-GUID: 6O16xnYIGtEQzeJojyvWtwiqUl9ebIIC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDExMSBTYWx0ZWRfXw+8hrmXcpaVR
 lVuYqcJTMtdEo1AIK2DqCVIvcrGOsPxafoYXb2LLkSDeD3q0QdnG/vifcEyCC6+95E6P2BOAv7l
 zkbPCZqcwli5AzAIRzsojNCG3QEeKAKwzgWxiaXubOVlzf38HAKvpyz7eNEIS+yiRacKqMTTB1G
 Ln+3+aQ5dYkL60nA1RgTf14uacTEzD1CF1Gqv7tv3rGRRDxVFkCyfXorkBjORQnXVPR2k/INDcJ
 MhW1ouKbj4S6G7ek2PNkzZWEMTdCbCzBpQMwqxTXHiubmYiOmK7UKV4Pe0E3lkz1TCPORTpAfCq
 3Lv7SbtWy5eE4VOT8kb7vzpJxr/sHvpFlYjDlAtY4ZNjkcdqy+eHj47Y2S3Wny/lpd5hIBTVC9N
 KLJ3VpYSTShy47ycxB4yiCfRlEYNd9g4XFnBwRWaC+niPc3Ht/tZhWCaAPN4Y/5IYzSgOimV
X-Authority-Analysis: v=2.4 cv=DY4XqutW c=1 sm=1 tr=0 ts=683daae3 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=ZoRCdJloile0LmdOwKkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_05,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2506020111

Add chan parameter to iio_backend_oversampling_ratio_set() to allow
for contexts where the channel must be specified. Modify all
existing users.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
changes in v5:
 - update commit message.
 drivers/iio/adc/ad4851.c           | 4 ++--
 drivers/iio/adc/adi-axi-adc.c      | 3 ++-
 drivers/iio/industrialio-backend.c | 3 ++-
 include/linux/iio/backend.h        | 3 ++-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
index 12f90aa3a156..1f975858c496 100644
--- a/drivers/iio/adc/ad4851.c
+++ b/drivers/iio/adc/ad4851.c
@@ -319,8 +319,8 @@ static int ad4851_set_oversampling_ratio(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 	}
-
-	ret = iio_backend_oversampling_ratio_set(st->back, osr);
+	/* Channel is ignored by the backend being used here */
+	ret = iio_backend_oversampling_ratio_set(st->back, 0, osr);
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


