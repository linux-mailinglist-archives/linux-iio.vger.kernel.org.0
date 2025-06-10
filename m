Return-Path: <linux-iio+bounces-20375-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFCFAD43D1
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 22:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F01D3A6206
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 20:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D89265CCA;
	Tue, 10 Jun 2025 20:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="tpvFQ4aH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0957265CA8;
	Tue, 10 Jun 2025 20:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749587543; cv=none; b=P9+cEi/8fhXhOz3/NXAVgb5AfVC5J960fZcyisJJR2H7kCcghxFX1Ubv25fcCG92lXv+0ykmoGENr6cBY3qfQFB3vexVmT2178fN2cW37524J3zEvomOE9nfj93/rt1HQfWiErz0c8p1/dWg9d2Lu40vDGBqZoSMsa4O/CUvl70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749587543; c=relaxed/simple;
	bh=2aHPIQxgXsraavz+sdJ4W4mijxJP3iXKeh4ksV+fxKg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C7Gy0D3/jb4XtdKO8NfyFACj1MACMv2wYbSBgonvm1Pr62119bP56HevvC+B3bHY9x7fgc+Qu1ulrnJ+kiWP7GyIxI5OQVNIFlhsOkV/hWN0ZONCofKUBV21eGWUNQZFaImMdBe4E8bIzVuDlvaBMWk7m9ZrHCDP9VOFgbfFLr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=tpvFQ4aH; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AIBxdC012590;
	Tue, 10 Jun 2025 16:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=wuz2A
	JmE8hQCiTm0enl+eOJ7oPmhut2K+IFpKJlfa2I=; b=tpvFQ4aHw6ms89ksjLAL9
	2WLfLm1LusAXz0K15ELFEamlgDYBWAzLT3wtd2jxW7wmGDm28v+CRE+DcVBGAwIY
	E3vsIxC/l/zpezTu2SRMiaY66O2C+F06NxoDu/oU2+sC96wBShumeuqZByz3cYPt
	y3gj+MSKCAPPqFwSnp3W73J6yd2BTHvcdVulb1HJtFsqL3FOYzYFPfNfZiTAXn13
	kpl9JJCa582w96wHhsGH+wYoZrXkp+xlFlnUVXxkeOeY1xbKESqGpYhKQVb8n2xi
	EXpPj0un0mwf96mZQs5Ywa/IzsCEMtKBCrY6eR2JiUQrTJzAZ5w86E1t+CicBt11
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 476hwsbkc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 16:32:04 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 55AKW32C040122
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Jun 2025 16:32:03 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 10 Jun
 2025 16:32:03 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Jun 2025 16:32:03 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55AKVlvj019891;
	Tue, 10 Jun 2025 16:31:50 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v5 03/11] iio: adc: ad4170: Add support for calibration gain
Date: Tue, 10 Jun 2025 17:31:47 -0300
Message-ID: <9b7e87d9d757ad06919ff241b5269eaf350f39b0.1749582679.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-ORIG-GUID: LiWjM5POMKvq6MULtkjJkMyTRhjMBi4j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE2NiBTYWx0ZWRfX+lt0pT4zJwZP
 fDTWkLbRqWmCUkTlDJBl/iSgrdHej5zi//GGBuLNOq+1sE0g7HapDOB2HodaED4qC8L6fiA1qz6
 DCb9CskBzAVUOym6ZTU43Jw1Y3wNRV+UTOICPxXimnl2ZTxCv/T9s6EUg1m6/SE8q1oXopL4O/p
 Xwft7rCKMB6xo4gqQSBHBSyszuaQI6ApNP0eBkM7PnuaoulJLgKuTHorIwIOg2Vm1rNIl/0htTw
 ZUHfQK5d3/DZywx7vDsOg5u655p1mVG6+XL+hqIBLss1jFxPDvLVDqoNiyD0P0bdKY9Vf9yi2m1
 1ekPztnH73DbK1mS1KzOZiuMDQAQTHboocZNVMr9ACpt4ONOaiS3vePeFqSlVV96MTSAhmpN8QS
 r4XS/6sMYWiVOUILx2tKqB12hq8+FWgYNRgb1g0g5GO/hLTYvxOG2IilEsRTuArMHWWZXcyj
X-Authority-Analysis: v=2.4 cv=daWA3WXe c=1 sm=1 tr=0 ts=68489644 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=s1qB4CsIdprNQQnv0OQA:9
X-Proofpoint-GUID: LiWjM5POMKvq6MULtkjJkMyTRhjMBi4j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_09,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=999 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100166

Add support for ADC calibration gain configuration.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v4 -> v5
- Squeezed info_mask_separate additions to reduce change diff.

 drivers/iio/adc/ad4170.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index d0628430ed14..8e422c76f03a 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -636,6 +636,7 @@ static const struct iio_chan_spec ad4170_channel_template = {
 	.differential = 1,
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			      BIT(IIO_CHAN_INFO_SCALE) |
+			      BIT(IIO_CHAN_INFO_CALIBSCALE) |
 			      BIT(IIO_CHAN_INFO_OFFSET),
 	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
 	.scan_type = {
@@ -950,6 +951,9 @@ static int ad4170_read_raw(struct iio_dev *indio_dev,
 		pga = FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe);
 		*val = chan_info->offset_tbl[pga];
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		*val = setup->gain;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -1064,6 +1068,18 @@ static int ad4170_set_pga(struct ad4170_state *st,
 	return ad4170_write_channel_setup(st, chan->address, false);
 }
 
+static int ad4170_set_calib_gain(struct ad4170_state *st,
+				 struct iio_chan_spec const *chan, int val)
+{
+	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
+	struct ad4170_setup *setup = &chan_info->setup;
+
+	guard(mutex)(&st->lock);
+	setup->gain = val;
+
+	return ad4170_write_channel_setup(st, chan->address, false);
+}
+
 static int __ad4170_write_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan, int val,
 			      int val2, long info)
@@ -1073,6 +1089,8 @@ static int __ad4170_write_raw(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
 		return ad4170_set_pga(st, chan, val, val2);
+	case IIO_CHAN_INFO_CALIBSCALE:
+		return ad4170_set_calib_gain(st, chan, val);
 	default:
 		return -EINVAL;
 	}
@@ -1099,6 +1117,8 @@ static int ad4170_write_raw_get_fmt(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
 		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
-- 
2.47.2


