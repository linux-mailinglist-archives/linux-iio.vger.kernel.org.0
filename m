Return-Path: <linux-iio+bounces-20376-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF96AD43D4
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 22:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F5C166218
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 20:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC8E265CC8;
	Tue, 10 Jun 2025 20:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hpYjCW/M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67856261390;
	Tue, 10 Jun 2025 20:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749587565; cv=none; b=nx5o+5DIldRQ7zj0uK4vpFZcNcngi0W8eHWH1vuxxNmHXXemwO7Mer6I1El7A/XmANqARae3upEY5YVCnehZRlP7eMyt4m+7eVeZfWpA1/4qLQ6wxSIMwif8v2m37nR47dXyABdq1bBuIxpUS5eN8SEIckWwUXfgeg39uIGLD28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749587565; c=relaxed/simple;
	bh=6sDkntmKQj+bEI7ddKQ3b+WGfCoRBHMQJtnjZ067pbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JGRiuq7M2jG5u8/AdycXi0TpQhSGs5HFuTv3VQNvFY40gtlftArHZhltpnYEg/V0namyOGJ8qnIqttGjA8GPDCHPlaCClQagukrbrRUTxv0tlo7nYrZnTQrPOMQdPFuYScplpN0yfERl1fjvNU6/zXpy6wQdIx3OS4SreGGd25o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hpYjCW/M; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AIBmlH022384;
	Tue, 10 Jun 2025 16:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=8Peyh
	FYcI7RcJ2dwaYdORit+OTZKD9NZUjvO5Ku/alc=; b=hpYjCW/MnxVGH+V/m527s
	es9k0INflHJ6xLIBI60Vmd35B+dcTzYjXqSyDX+tyrw/d4tHZJW10lctQauiMvUF
	T38qptuFYLwm9QOTPT/9vNKO4PbTwwA1I0S7aMscAa4ODtsaTH/LlzeUJAAUSXpp
	mxrrm5+AmrPkWT0RpVugXPHLnyVqr0wfqqi+1yUJ4E0CPBgB/Tdj/j3a5fM8WMz8
	9OWJmMTU4hs1cicGqNhqT4wqhfp0OClTZgLlQUgAyTsgHm81+xR+H4isNACERQlT
	5pvFWP/EFfU+Ov6neexExVHQbejPFBNW34GBlLke+zo47rXswakTtuJfLgVZfhu6
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 476n67tdb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 16:32:25 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 55AKWOdx037641
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Jun 2025 16:32:24 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Jun 2025 16:32:24 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Jun 2025 16:32:24 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Jun 2025 16:32:24 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55AKW60H019910;
	Tue, 10 Jun 2025 16:32:09 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v5 04/11] iio: adc: ad4170: Add support for calibration bias
Date: Tue, 10 Jun 2025 17:32:06 -0300
Message-ID: <a6374407f1c6f1aa722025954fd1a759cd42a528.1749582679.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1749582679.git.marcelo.schmitt@analog.com>
References: <cover.1749582679.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: y6ia-WiYTC7k6qOGLsMcWc-E2_OYtg-k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE2NiBTYWx0ZWRfXw4pHhBK4XS4V
 A057C5hgawGyG8oknchyjzbuCY2MSPwve0w4lSxqeFDiVgY1DVb66aMlbQPXtoYwlBHJomNQtjQ
 ijHcxzZm8wYX513d6BxSj/rcWEDokT+9/c8VWgKb8iXrKouc5fTteXSONR6snVmyN11bprn3TN2
 jw2TGnGd83gHfSDcTLOaxn1aV69LbCHUhZulFLGCaRc+WX7A4gz7+agRGTo8JD0p6Z3aWcJaN97
 UbQrn5Rv0w6E24KYg39wajGzZ+Kv897nPfsI4GHw4w0tPxsDJ3XUIvvL93UtWKqoHNpnQ30fgoC
 G2i4WCvMW28odUsiCYah2c8JRBpcOIEAUrRNge4fSZBM+XP5fC9uwE8q8MB1aQqm9TybG7W1ZT1
 aS2TdrU0T//bvXOLsc4bPWqpLl4ubeLwg/pzjJJCbaGiJQwZ5afWdPZss/nicqdvMCAEypfR
X-Proofpoint-ORIG-GUID: y6ia-WiYTC7k6qOGLsMcWc-E2_OYtg-k
X-Authority-Analysis: v=2.4 cv=a/gw9VSF c=1 sm=1 tr=0 ts=68489659 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=1daVv4cnZmPfqeT0XEsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_09,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 impostorscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506100166

Add support for ADC calibration bias/offset configuration.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v4 -> v5
- Squeezed info_mask_separate additions to reduce change diff.

 drivers/iio/adc/ad4170.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index 8e422c76f03a..d0482f3b6f01 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -636,6 +636,7 @@ static const struct iio_chan_spec ad4170_channel_template = {
 	.differential = 1,
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			      BIT(IIO_CHAN_INFO_SCALE) |
+			      BIT(IIO_CHAN_INFO_CALIBBIAS) |
 			      BIT(IIO_CHAN_INFO_CALIBSCALE) |
 			      BIT(IIO_CHAN_INFO_OFFSET),
 	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
@@ -951,6 +952,9 @@ static int ad4170_read_raw(struct iio_dev *indio_dev,
 		pga = FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe);
 		*val = chan_info->offset_tbl[pga];
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*val = setup->offset;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBSCALE:
 		*val = setup->gain;
 		return IIO_VAL_INT;
@@ -1068,6 +1072,18 @@ static int ad4170_set_pga(struct ad4170_state *st,
 	return ad4170_write_channel_setup(st, chan->address, false);
 }
 
+static int ad4170_set_calib_offset(struct ad4170_state *st,
+				   struct iio_chan_spec const *chan, int val)
+{
+	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
+	struct ad4170_setup *setup = &chan_info->setup;
+
+	guard(mutex)(&st->lock);
+	setup->offset = val;
+
+	return ad4170_write_channel_setup(st, chan->address, false);
+}
+
 static int ad4170_set_calib_gain(struct ad4170_state *st,
 				 struct iio_chan_spec const *chan, int val)
 {
@@ -1089,6 +1105,8 @@ static int __ad4170_write_raw(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
 		return ad4170_set_pga(st, chan, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return ad4170_set_calib_offset(st, chan, val);
 	case IIO_CHAN_INFO_CALIBSCALE:
 		return ad4170_set_calib_gain(st, chan, val);
 	default:
@@ -1117,6 +1135,7 @@ static int ad4170_write_raw_get_fmt(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
 		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_CALIBBIAS:
 	case IIO_CHAN_INFO_CALIBSCALE:
 		return IIO_VAL_INT;
 	default:
-- 
2.47.2


