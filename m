Return-Path: <linux-iio+bounces-20245-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5A5ACF2B6
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 17:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010C8169778
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 15:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826FC215793;
	Thu,  5 Jun 2025 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vc3yWXZ2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9EE1D0F5A;
	Thu,  5 Jun 2025 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136285; cv=none; b=hwAzYESVoaK1hCkU7oBDW+hhCoTPA68EYcW1yQlMYGuQJcqgBD7u6/kHOxLSa7f3Rw4+CPHLrQOAcy8km+Urww9+AhKREcGrcPXmvQPNRqbewGbD7lJRLNe3yzmzVGgz7YfNVk/KvMZMOJzPFM/ACcEvzTs6mAJHlTjDqJvqUqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136285; c=relaxed/simple;
	bh=vnDYG3F1y5twics2NHVWZutAOWqilkNCVUEhlS9M/eM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CfTjiJZev/51/P4Ejk+dTWrH2A3kijV7WzhD2g/KCm9yxK2f2en7DaJiyNe1jb3Ww7+fivpkaGszVrG9oBov21F1KrYpi6tSX5dHWcRYreX6r1uMh0qCKv1k5K7HrSPJTsEhs9uUafhOo2oD/AnJXwQJ9ly9ckio9lvuq6ZuQFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vc3yWXZ2; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555EaO4T023329;
	Thu, 5 Jun 2025 11:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=MR6Bo
	XpsdS/SXAJaEvwZvfZ5xtcl5301pDnaUQZ1C1M=; b=vc3yWXZ2MsL934sMgWg1H
	Ev2ZTHFVDrYJlKV292ReedWCT3n2YAVWFs+FeG0hxIo9R2HWecMBk4rmtcN7bjYR
	OLExUBjloef3supjr/BbqrtjjXC33d3ZBi0nqyAZ687MtrTShF1/OOJUx+7k5oE5
	cofofZ3cV/DMfbFB4/+C+XUbmDAWfYxRd9DY8svX/AYWKEQlalPUumb7IYLwfNCm
	9v7/SSys8BGg+AXR/Ri/WoS0kusD8Er+9PD1C/ePel2ZdS6aus5LipOR72umhGxo
	s5Ws/PCswNhlf4D662ZNLgO7amASAGaz3F4wQCEIfeG6Le/km0rFSojDt6CYh/7G
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 472k2u7b2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 11:10:52 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 555FAiiN004142
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Jun 2025 11:10:44 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 5 Jun 2025 11:10:44 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 5 Jun 2025 11:10:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 5 Jun 2025 11:10:43 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 555FA1ur027831;
	Thu, 5 Jun 2025 11:10:33 -0400
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
        Angelo Dureghello <adureghello@baylibre.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Tobias Sperling
	<tobias.sperling@softing.com>,
        Trevor Gamblin <tgamblin@baylibre.com>,
        "Matteo Martelli" <matteomartelli3@gmail.com>,
        Thomas Bonnefille
	<thomas.bonnefille@bootlin.com>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        Ramona Alexandra Nechita
	<ramona.nechita@analog.com>,
        Ioan Daniel <pop.ioan-daniel@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 2/5] iio: backend: update iio_backend_oversampling_ratio_set
Date: Thu, 5 Jun 2025 18:09:40 +0300
Message-ID: <20250605150948.3091827-3-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250605150948.3091827-1-pop.ioan-daniel@analog.com>
References: <20250605150948.3091827-1-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: wmgQPYtQoLOBQvvMCMmjJl6E8qDxuwbN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDEzMiBTYWx0ZWRfX51eGc7d6RUL4
 D2qoOLBZmY9lWBpTBMblziPiXaHnhuEhIuuHUR4Rp/+WiwN5oEoF0Fz4XTGJlLsa/fh7ZiSm1+K
 YmqkX/5oQIgzYk0lOazeyswKM6+KRy0b4OIXUnKFZY0XN2HuF7M6BqhDbRzA70QdTMtqFWug7lH
 vxEKx8fAmxqAGbbZlKROLciXlkwcuk471IjwWzmbWW45C7NnWB4VUqKClm+p7rgyath4DVNvNCf
 M7VHU3xHYulJhbWLO8jhYeAXisX1C+oiz2GlD2QZReJ9Ai8aSoxgtRw1CLUilAWTvqqb141ORe3
 VHS8BsosKPXbWe9Xl7kozrZZzGmYUiQPMT+2CB0wU1W9X7rEJh9nI3s7ypot1CU7/R7fs8qyn0L
 TTpVTYmc6paiw+6aeNFFQI+zYB9/Z0OKyFyrBQCPEkQfCG3sC9S8H31u+ktF9lYnkoagln1i
X-Proofpoint-ORIG-GUID: wmgQPYtQoLOBQvvMCMmjJl6E8qDxuwbN
X-Authority-Analysis: v=2.4 cv=Fv4F/3rq c=1 sm=1 tr=0 ts=6841b37c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=ZoRCdJloile0LmdOwKkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_03,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506050132

Add chan parameter to iio_backend_oversampling_ratio_set() to allow
for contexts where the channel must be specified. Modify all
existing users.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
no changes in v7.
 drivers/iio/adc/ad4851.c           | 3 ++-
 drivers/iio/adc/adi-axi-adc.c      | 3 ++-
 drivers/iio/industrialio-backend.c | 3 ++-
 include/linux/iio/backend.h        | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
index 12f90aa3a156..f395fa9f654a 100644
--- a/drivers/iio/adc/ad4851.c
+++ b/drivers/iio/adc/ad4851.c
@@ -320,7 +320,8 @@ static int ad4851_set_oversampling_ratio(struct iio_dev *indio_dev,
 			return ret;
 	}
 
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


