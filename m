Return-Path: <linux-iio+bounces-19671-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D41AABC027
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 16:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F45918936C2
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 14:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FCA27CB3D;
	Mon, 19 May 2025 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="lhnOXz89"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30C72586CA;
	Mon, 19 May 2025 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747663429; cv=none; b=oL9CuHysRVGz8TSt7EDgErl5mXA2YP+DP1B+KyQgSY0XMx5MFggjF+rnQnP/Gf2H1kLgJB3F7Is98ZIxwQf4FDylRYdl50ew+qhwyNv7XArEjsK0TGLoWrohDLJ921Ru2jWgrGzox381GE7eWLZKIINNSPLuqDcScf0oS9AB0vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747663429; c=relaxed/simple;
	bh=dxKrONTUz7Yn3f+rST5oH5+Hj+KBcwuPb8DCRBEzaA0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qG2lqb7NzfyJ9p+whYZOsSEKBxXqJ9uqk4YBCL1ENARFxhXvjDhQRvtsY1vkppWj3CA8wW04he9HZhFrIDf3GcPKHW95o4ZTqfspEMGMpXmGtcEheDOOHMqq2zCUFaGjCtexJCgEPFWEITdOxontE2Hx8vx717hphXlmKFFRthw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=lhnOXz89; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JDVG2L012725;
	Mon, 19 May 2025 10:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=MElNI
	MeyW0gPszKkmcmqvag8Xk+RuOSaMKDhcdt0Hd8=; b=lhnOXz89bUxfoLGBLeXG/
	aTxG7O6TvP0Wo3Jtf0haL+vjvq6qiK4hLOL+7A9sumRliROHQVqR+jlxgsDekpff
	gLvBE+oNYqTpNQasB+JGhX0Apj22RHhtQATzvrneZp4CVucyqdhCWUW0T2JWxqvN
	OU160fXfaNI57fHkrZJGN2XYr00jQZFebABhC1RxSHSnZ13bZk3v6j4CYGruD9uH
	G4oofNuyub243yB8JTYVc9766SqZr28+yaaeqe4h+6Gz4pKQ4X8UIIbzB5lrvcT8
	MNTyPPIQHdYa4YfXFQzddX3K1lZAVGcfmaCxItQV9SvvMNlDzhu+GfDA+1ccOUPj
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46psveqt5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 10:03:09 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 54JE38X7038210
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 May 2025 10:03:08 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 19 May 2025 10:03:08 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 19 May 2025 10:03:08 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 19 May 2025 10:03:08 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54JE2bPD016713;
	Mon, 19 May 2025 10:03:00 -0400
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
        Thomas Bonnefille
	<thomas.bonnefille@bootlin.com>,
        Pop Ioan Daniel
	<pop.ioan-daniel@analog.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/6] iio: adc: ad4851: ad4851_set_oversampling_ratio parameters update
Date: Mon, 19 May 2025 17:02:09 +0300
Message-ID: <20250519140220.81489-2-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250519140220.81489-1-pop.ioan-daniel@analog.com>
References: <20250519140220.81489-1-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ZnlxzQHkSlL7RRVq6jsTxbXvw35DZf2N
X-Proofpoint-ORIG-GUID: ZnlxzQHkSlL7RRVq6jsTxbXvw35DZf2N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEzMCBTYWx0ZWRfXweykrdhZJqnW
 3un5UPBit5q2qw6q6ItNn2JrKNhxIngRjrTMJkYKSxy2z503W3vdFgaPLpSwMa0GoQzc326mbRj
 EptJ+qlnwNETvFVlI406jYHuM6bgDLl0gtNsdcFmM9WFwWDTeifjh3LfXVS9QMGepoGdMtCM1rP
 4St9VC5X2KuWRj7L3Of1MXMKoArv6ABsEhkie4bTCC9Nd4IDuPi9PQPG2nEJY07CSC+TsznQovw
 hdwwbsLbv6MjubDJ2fab1FDX1i9Bayae//rTPAKpqnqNmOzSPJG8+PG/+Y1aTbAz29jB3p/qS9V
 +894QF89p6cN372BfS1COziUHx1CQQNAVXFRpadpxZ/Z7qnJC4AsgGnl+pX8z4ShDgjtKTKuxCv
 ZhxvKioUceoTL7zy8fmNVXwNze/htayU0PCeblGhTHpv01nZH4puNNwaU9isqs3Bh4syBcnO
X-Authority-Analysis: v=2.4 cv=PqSTbxM3 c=1 sm=1 tr=0 ts=682b3a1d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=r0u9AmH2YJ65VWHPuukA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505190130

Remove chan parameter from ad4851_set_oversampling_ratio parameters
list.

Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
changes in v4:
 - remove chan parameter from parameters list
 drivers/iio/adc/ad4851.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
index 98ebc853db79..12f90aa3a156 100644
--- a/drivers/iio/adc/ad4851.c
+++ b/drivers/iio/adc/ad4851.c
@@ -294,7 +294,6 @@ static int ad4851_scale_fill(struct iio_dev *indio_dev)
 }
 
 static int ad4851_set_oversampling_ratio(struct iio_dev *indio_dev,
-					 const struct iio_chan_spec *chan,
 					 unsigned int osr)
 {
 	struct ad4851_state *st = iio_priv(indio_dev);
@@ -831,7 +830,7 @@ static int ad4851_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_CALIBBIAS:
 		return ad4851_set_calibbias(st, chan->channel, val);
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		return ad4851_set_oversampling_ratio(indio_dev, chan, val);
+		return ad4851_set_oversampling_ratio(indio_dev, val);
 	default:
 		return -EINVAL;
 	}
-- 
2.34.1


