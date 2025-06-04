Return-Path: <linux-iio+bounces-20205-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C913ACDF42
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 15:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B76189A076
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 13:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3194328FFC6;
	Wed,  4 Jun 2025 13:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RaVGgLpg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D33528FAB9;
	Wed,  4 Jun 2025 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749044137; cv=none; b=axhNueGROUrXVbq/Z/90lgX4J7r8mtXGwQPi1fM7tCdVwxTA/e7YOgm6SnJ8uH/Kyrt/4D3a4eOhkaCdqJ4wC77ze1avTJAm/sK9Ff3e8NKNyqozOZ9ih6B3Hx4xU8V8K4dJ4dSa2HgtnO9ydjK1/uIePn9IqVp8D6BWV8Syrvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749044137; c=relaxed/simple;
	bh=wun51i7URakc6i/FGsVgpXrptnLFIPS3LX1tgkKVSak=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IwGefGPmgS0Wwzk1A+2IbMEDjL37Ajy9qrt0GjAmyBcHkxPlAM80oMo1G6EIW5th3kGq6NI+1T+achtgVCixO8kfARjqYAbNybiQTwYUYqIBA6ckSlg2AxtBdGBHNP8RK271Jn7SEoICchvlEmZvFrj1be3AmIGe95VzPxFN204=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RaVGgLpg; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554Bhis8028811;
	Wed, 4 Jun 2025 09:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TJl3c
	o7VEXd+IIi0GWLaGm70QpRQustSdK4Y0fQhg7o=; b=RaVGgLpg/EWfKbO5J+c8S
	EzOo5HknpAowUEaJy7jbq0ZbQpvarzaUtTToBGGEXhysp7zrcrXsGo6DkSrqcnVx
	QPuM3PJUmZC90eC+3sIRyUsZ/TPCPFBzKnOV/COaTUbvFhEgvfuxCGgm8vn+6TTT
	d8XUIANwE+ik5jxJW5sExrAKl1Iam0q/isdu7a1ZzcVEWAZcZG0R3PD97iEiW2T6
	OdJJGxZT4MIeKELysTXsJRPmx/a+F7FG+pUTCMnV0v4jE+XjLQyNL2LwjRnjHdPk
	Odvn3rS24y0iJTuq5JLnTG6sA+qHDgB0S3abxsip6QKjiAi8LrwqAKZ7hH/jeE3f
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 471g9j2jhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 09:35:14 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 554DZDlC030286
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Jun 2025 09:35:13 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 4 Jun 2025 09:35:13 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 4 Jun 2025 09:35:12 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Jun 2025 09:35:12 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 554DYVPY029277;
	Wed, 4 Jun 2025 09:35:05 -0400
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
        Ramona Alexandra Nechita
	<ramona.nechita@analog.com>,
        Esteban Blanc <eblanc@baylibre.com>,
        Ioan Daniel
	<pop.ioan-daniel@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 2/5] iio: backend: update iio_backend_oversampling_ratio_set
Date: Wed, 4 Jun 2025 16:34:04 +0300
Message-ID: <20250604133413.1528693-3-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250604133413.1528693-1-pop.ioan-daniel@analog.com>
References: <20250604133413.1528693-1-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 7HF6eiNmsz_1hOg5on5x_zHyWonL5tWw
X-Authority-Analysis: v=2.4 cv=DfIXqutW c=1 sm=1 tr=0 ts=68404b92 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=ZoRCdJloile0LmdOwKkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: 7HF6eiNmsz_1hOg5on5x_zHyWonL5tWw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDEwMyBTYWx0ZWRfX4C5t5Z9frj6z
 jjcsLjPmliMR5Jc/aoNW/t5/Hb0eYJHFXhVLe82+99Z3CABoO0eBCoizHENdZQrg7MxdcyFS8Xe
 +qqDU5aZT45lvxaWnkD8k+d5+B/Tc48CP3bElVYgVO0ynOdA2PhpQPSNVi6+RN3R0UerTqVfAgs
 wuhXV6Aucih6LOBdbiAyBHi2J6aDU+0RTlFs8CEBbzgW0VKBIETkcIAsy/XWe3slQk6xgwpGpR2
 DbcSLc86SWMxBik1fQKRCnxrwpYuvCpzDhXhlvbv8zKX1zOhD5KKkbgGynH3PLqkoxJZigFF3JM
 nE8gpJLo+TbnQVCx6DYmk9caeT7Ts9pnkePSUh9EPTPOa8kJ+Ly7eSEiDQx5SdurLHBiLey7eSR
 F5apH/eFnFUTnhUssS9I7iWqLyG5vQ9nd8yg+5ksMVjLi8ZGV5Vf6wIhN3V0skk3Nf6oW3VB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040103

Add chan parameter to iio_backend_oversampling_ratio_set() to allow
for contexts where the channel must be specified. Modify all
existing users.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
changes in v6:
 - add blank line
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


