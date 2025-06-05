Return-Path: <linux-iio+bounces-20243-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C92ACF2DB
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 17:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BCF57AB76E
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 15:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188C11EA7DF;
	Thu,  5 Jun 2025 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="O7RHUmB3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545F41A2622;
	Thu,  5 Jun 2025 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136274; cv=none; b=WmW5yZdInXCW6h+vahBHEvXuv0OUq2ws081c28QGpfDkiu+9brgQ8ZIu38liBFiIYLE1MmXPEuVfAklpb5AqPklRM5MndAsb+YDn4KHBwrkhb5YI3eGM0LGwdHjFo2iMtcsNmvsbd30zodIP27jTRTOC5T/Co5mCqaXZTb7mke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136274; c=relaxed/simple;
	bh=SAS9KPdrdQHxXpDY6p7CdH/q5tq1rQIrV4rn7Eb5u84=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKE52IESWnKpTjgYc7WbTlHDc23edB5sZvvNA8mRzhan0eClzn1JqLllCUiEE4tb7OD0eUANONjbvZ0MQ1WwiSHw/7lIHP+RWhau4HH2L3wvRag058NU6dGnyOmAHl9ZkwKQpiRBKIn6VPQjmqhRzF3cZU1Zppvg8M3nHqs/z88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=O7RHUmB3; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555CdYA2014189;
	Thu, 5 Jun 2025 11:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Kx8qR
	pFICWjAGXPdjx+oP5SD1WFa+YnN4FVxsBxtQbY=; b=O7RHUmB3RNe5ZCUx09nwU
	bNJcMaT7WZilvkCF4iKmLMjO/5ztSFRLRoZ3m0uvn3qcyifbSJ4PpCZW3XZg9QuK
	vr3R3qJVKGyk4yKUdUFtr+NPzFjExYmsrvXtPhGHui3iHWuLlo/iKF3/7mbNGNXZ
	siclfIYiiSgkmO3J7Nj5IACmODf+3efOksCSeGff2/mhtYloaTWNvPutbpTYaXYr
	ZpoqDZNI68Ou624WfEYQclI2l1OkRslagWllmGUejnKTATgrScML4s5DnESjb3dT
	1k9NHOjPJEQO0zGmoXHp7f3q7Z1JZQo7Ywa/GR/QBkh8MBodewgEagr8EzAhYhF2
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 47386c9pk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 11:10:44 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 555FAY4x004127
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Jun 2025 11:10:34 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 5 Jun
 2025 11:10:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 5 Jun 2025 11:10:34 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 555FA1uq027831;
	Thu, 5 Jun 2025 11:10:24 -0400
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
        Angelo Dureghello <adureghello@baylibre.com>,
        Tobias Sperling <tobias.sperling@softing.com>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        Trevor Gamblin <tgamblin@baylibre.com>,
        Pop
 Ioan Daniel <pop.ioan-daniel@analog.com>,
        Matteo Martelli
	<matteomartelli3@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Thomas Bonnefille
	<thomas.bonnefille@bootlin.com>,
        Ramona Alexandra Nechita
	<ramona.nechita@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 1/5] iio: adc: ad4851: ad4851_set_oversampling_ratio parameters update
Date: Thu, 5 Jun 2025 18:09:39 +0300
Message-ID: <20250605150948.3091827-2-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250605150948.3091827-1-pop.ioan-daniel@analog.com>
References: <20250605150948.3091827-1-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Jr_TJkPYAKwFIZwKZE2dNjRGkKpFGq4x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDEzMiBTYWx0ZWRfXzH+JW0Paxb64
 4TnSC9QvJjadKRsRdRWVnZgf8fQhPCvApLCt5kSlZKW3GnLuD3usB7Pmdax044cra8yz460DgY/
 rKMdymx8BlBn/RsS8yvUi5f+SfzDBCpPZE8e5d+8H7+dBej1f9yGPn2ufbiTyx8DwgHDNRa7Zeh
 ldjfsf4zpclcjgHA/ISZOz4Asz4MSpk7cr92EHV+xRSy2X4sa1YGO6ZLG5SCTrvqilPhtuLyBBF
 MmoIoFm0Q/1uqVAalad0ZYaIvaIM5IDbdzOTtIm2kt5TfeWSn4EmOwpuSKBI9wyU/2WK7rTZOjA
 kNnrSH53A+QMawkqwwA8hYizRwcORrBtdxKBbj7mO9U5by8nQYNC8FerKf9P4YBb0p6XJsCG5gB
 JTcn+qBYMd4WH1ffZ5MufDcFIxvHMtP44oTAa91Qr4V03IY1yvlY05kyHrN+cb87rEaTaGeh
X-Authority-Analysis: v=2.4 cv=KYLSsRYD c=1 sm=1 tr=0 ts=6841b374 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6IFa9wvqVegA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=r0u9AmH2YJ65VWHPuukA:9
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: Jr_TJkPYAKwFIZwKZE2dNjRGkKpFGq4x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_03,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506050132

Remove chan parameter from ad4851_set_oversampling_ratio parameters
list because the parameter is not used.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
no changes in v7.
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


