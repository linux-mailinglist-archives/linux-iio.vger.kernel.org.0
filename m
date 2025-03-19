Return-Path: <linux-iio+bounces-17098-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C89DA692B7
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 16:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4891463493
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 15:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640871C7013;
	Wed, 19 Mar 2025 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="AR0uyPxc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0D01B4F17;
	Wed, 19 Mar 2025 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396261; cv=none; b=ZerVzib9DBjPbYjch3xSyaCFZ17HZlngX18WPZeclP0A6SyP5Jhvd6CGfJg1+btGhBB8/0ybh4adzTGdLxr4vjMFmOIv1F51Fj4D7RnygLhheN/BS/Xz3Ukk71n0hiQtUQAuuZI+BMbEl31+sAWXgMmZW1b/0OO/LpbalYYqnB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396261; c=relaxed/simple;
	bh=jsrgSdCU7MTlenpfDbyXsrXByYYRwXt5USGFHH2UUsE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zy2TNJYdUgGBD9eWqbln2vvc9qG4RXRg7Lnzz9iqt9bqznXIVNSnMzh5nzUIcW3kvMoP7Wdw1BxW/H9fbPfQF7XXhoA1XaNQg/oeyeUaZ0S84Z4eM3durNnR+q4DAbCAYZyihltukLDvheNlzZVYUlRkNh1HxPUCzK2akPHgGyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=AR0uyPxc; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JCTNur003551;
	Wed, 19 Mar 2025 10:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=fbVdy
	7SwPxeS08m1htoNmN03jVsR63bUoVc/h3pjYWI=; b=AR0uyPxcT//W0uaGNIMZB
	ZC2Ega9km9CfW6W8zz0pkLAPj4J5WOH+LE5naY/8nONuuRSYAxDt1DsQNEMbFIPF
	W7zvxL2iIDbU6vSYh6EFP20JodLUPoyaSIehIbT4BM2A8GsQ0eGwcLB0Sd4K+PA7
	5QjHSt2dQeBS3H3hS4BqSyAA4FkU2axP3aYdW88bRzcFj5S/Jwz2uv+IBby4K16v
	3+tGRb70r4H2/40DF3ZGaB+F8IBlc2hcEA/jRyNbo52a+61wDnAsg42OY/bdd+Yt
	4yqHTf4T5o3m2KGWsf81uWEJLjETIKL0jlNILs6MYUzyPwn/Ym/Dl41zou4WlVK2
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45ftbrsvts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 10:57:25 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 52JEvOH3048074
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Mar 2025 10:57:24 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 19 Mar 2025 10:57:24 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 19 Mar 2025 10:57:24 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 19 Mar 2025 10:57:24 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52JEvBC2025117;
	Wed, 19 Mar 2025 10:57:14 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 1/5] iio: adc: ad400: Set transfer bits_per_word to have data in CPU endianness
Date: Wed, 19 Mar 2025 11:57:10 -0300
Message-ID: <930560a0d0ca7af597d4ad901422bc9ba3fc6a79.1742394806.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1742394806.git.marcelo.schmitt@analog.com>
References: <cover.1742394806.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: sfkMNm94jycUrR5pVZ0JL3EGyFqAazbY
X-Proofpoint-GUID: sfkMNm94jycUrR5pVZ0JL3EGyFqAazbY
X-Authority-Analysis: v=2.4 cv=Qs5e3Uyd c=1 sm=1 tr=0 ts=67dadb55 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=KIVFCObac7ixMNWL0JcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_05,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190101

When SPI `bits_per_word` is not set, SPI transfers default 8-bit word size
and ADC data gets stored in big-endian format in memory. Because of that,
the IIO driver requests ADC data to be rearranged from BE to CPU
endianness. However, with `bits_per_word` set to the number of ADC
precision bits, transfers use larger word sizes that get stored in
'in-memory wordsizes' and can be read in CPU endianness.

Use proper `bits_per_word` size for SPI transfers thus saving the driver
from requesting endianness conversions. With that, shifting the buffer
data is also no longer needed. This change has no impact on IIO device
functionality.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4000.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
index 4fe8dee48da9..19bc021e1b5d 100644
--- a/drivers/iio/adc/ad4000.c
+++ b/drivers/iio/adc/ad4000.c
@@ -50,8 +50,7 @@
 		.sign = _sign,							\
 		.realbits = _real_bits,						\
 		.storagebits = _storage_bits,					\
-		.shift = _storage_bits - _real_bits,				\
-		.endianness = IIO_BE,						\
+		.endianness = IIO_CPU,						\
 	},									\
 }
 
@@ -79,8 +78,7 @@
 		.sign = _sign,							\
 		.realbits = _real_bits,						\
 		.storagebits = _storage_bits,					\
-		.shift = _storage_bits - _real_bits,				\
-		.endianness = IIO_BE,						\
+		.endianness = IIO_CPU,						\
 	},									\
 }
 
@@ -411,8 +409,8 @@ struct ad4000_state {
 	 */
 	struct {
 		union {
-			__be16 sample_buf16;
-			__be32 sample_buf32;
+			u16 sample_buf16;
+			u32 sample_buf32;
 		} data;
 		aligned_s64 timestamp;
 	} scan __aligned(IIO_DMA_MINALIGN);
@@ -516,11 +514,9 @@ static int ad4000_single_conversion(struct iio_dev *indio_dev,
 		return ret;
 
 	if (chan->scan_type.storagebits > 16)
-		sample = be32_to_cpu(st->scan.data.sample_buf32);
+		sample = st->scan.data.sample_buf32;
 	else
-		sample = be16_to_cpu(st->scan.data.sample_buf16);
-
-	sample >>= chan->scan_type.shift;
+		sample = st->scan.data.sample_buf16;
 
 	if (chan->scan_type.sign == 's')
 		*val = sign_extend32(sample, chan->scan_type.realbits - 1);
@@ -689,6 +685,7 @@ static int ad4000_prepare_3wire_mode_message(struct ad4000_state *st,
 	xfers[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
 
 	xfers[1].rx_buf = &st->scan.data;
+	xfers[1].bits_per_word = chan->scan_type.realbits;
 	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);
 	xfers[1].delay.value = st->time_spec->t_quiet2_ns;
 	xfers[1].delay.unit = SPI_DELAY_UNIT_NSECS;
@@ -719,6 +716,7 @@ static int ad4000_prepare_4wire_mode_message(struct ad4000_state *st,
 	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
 
 	xfers[1].rx_buf = &st->scan.data;
+	xfers[1].bits_per_word = chan->scan_type.realbits;
 	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);
 
 	spi_message_init_with_transfers(&st->msg, st->xfers, 2);
-- 
2.47.2


