Return-Path: <linux-iio+bounces-21156-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F03BAAEDFE8
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 16:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85D2B3BED4A
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 14:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD5228D8E7;
	Mon, 30 Jun 2025 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uXGPeQOX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFCE28C01C;
	Mon, 30 Jun 2025 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751291967; cv=none; b=Sb8jaKpAIPv6/ZGXoESnqUBkdpnlLTrs5fA7SjPfAgK3Qcn/UgQ2W3YPZi4YTouFxf1s0X3cnPhvzGwxgITuBd+Tchff0oNbCeWS3yk4Q8l1XZylzLbyFeGgSKQ0fjQO1PF+ajB9CaJ8JMxuJl/YfTCX2JjIdeV0tSI7i7HwUtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751291967; c=relaxed/simple;
	bh=A1yX+H85JhsfJK0CcHMjJeFLpZ22UZXv/+7RY3hEz5w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHTj/IgOpHqD/7sbGWbnv5L3mKLUSmCmZiJccGH8dOyWt6mgn17xeBPKiIIm3DMic/W+G7/+dWCHJfMKr0Ly48L9gjPtFqXqbX7GoLgO0xSBO0b7LobAtTzJA06PKyx8PC6BOEhPLUGwgMW7ycWDbrOVC5zeGCLf3WIzkYN2bRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uXGPeQOX; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UCx7uM010827;
	Mon, 30 Jun 2025 09:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lz2ok
	0DGa1G7f+CjOHkG/qA3RigPwSA/naJ1HxP1Uvw=; b=uXGPeQOX3honDnQ8KJvNd
	4ReJPjrqBwTl7yzWzjlH5VxcEXnKXHld9AjeObM/LFff09dXsukJpA6d7p3Ehv8P
	YNWOYDHphln2AXncshCo9IqFY6qXbpKoKqqcn3iCcfGtKfo7pKR9ZG4uj48zGcjQ
	H/v+t4hUlmpJwHHB4MF/Ey/H2HLV94Q266rODcJmpwsOmhrZOz4m+rCoMXL8+Z2S
	xPSTH6ShaiISjnRJ9W6zDGHTOghVBhRGIqEXpFTlRMOURjI/22P3gHWCJQZbrpF/
	NNQcrsVhKo98Dw9W1cIagXfUPHQtvDpTbmEs8KBgT7A0qSbdl05gUaXSewXoItUz
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 47kqwj18j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 09:59:09 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 55UDx8Bo039317
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Jun 2025 09:59:08 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Jun 2025 09:59:08 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Jun 2025 09:59:08 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Jun 2025 09:59:08 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55UDwp8E008266;
	Mon, 30 Jun 2025 09:58:54 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v7 03/12] iio: adc: ad4170-4: Add support for calibration gain
Date: Mon, 30 Jun 2025 10:58:50 -0300
Message-ID: <f87b5dd7ffa08f366feb2b977ffcbfb8b67bdf1c.1751289747.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1751289747.git.marcelo.schmitt@analog.com>
References: <cover.1751289747.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDExNSBTYWx0ZWRfX6GtN27aGMHCG
 PS9R8HtKCq8LhP18Jc/TyUcUlNnqVi2AW968jzkZVcLpVZJicx6vLBsLZztX3cfDQ965dXapkgk
 m4yxXlscG9ffCTmBtggTXQlQdzUXJKHrzOgTzxY/Hi+eC6yT8cfTJSOQMM9hwJmkd9nGuI46tKY
 KXWMvD+s6o2exfAohH4IT6dPFSbkr4SwVPMcwh1VlYb5hNMgXh754VRpoz7PN+gYMHiIEF8xI9P
 8KiOcY3xxC4yiBO1lmvibAIAMi4iHJhhONPz/Yx/fqCus1e4ten00DODfqDoHeA3emnz5nLL1vS
 g3PzjHzST3X5sOE9rLK/K4CwSbAeoQkQyBxahNxR5gZSWIxYhhhqPTKWBlteShFjkA1oGwLr1aC
 ueUISbJ1hcS+qEAW9bofwEhj9wEOfWjci4xLvNETiCXgBzvCjxG4068jr7SdiJ8AMVBb5pem
X-Proofpoint-GUID: dLAhPdNutIrmArxYDuuWLDRRBHnY6OT-
X-Proofpoint-ORIG-GUID: dLAhPdNutIrmArxYDuuWLDRRBHnY6OT-
X-Authority-Analysis: v=2.4 cv=SsiQ6OO0 c=1 sm=1 tr=0 ts=6862982d cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=s1qB4CsIdprNQQnv0OQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_03,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300115

Add support for ADC calibration gain configuration.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes since v5.

 drivers/iio/adc/ad4170-4.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/adc/ad4170-4.c b/drivers/iio/adc/ad4170-4.c
index ecda8e8a41eb..c45203c0b479 100644
--- a/drivers/iio/adc/ad4170-4.c
+++ b/drivers/iio/adc/ad4170-4.c
@@ -623,6 +623,7 @@ static const struct iio_chan_spec ad4170_channel_template = {
 	.differential = 1,
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			      BIT(IIO_CHAN_INFO_SCALE) |
+			      BIT(IIO_CHAN_INFO_CALIBSCALE) |
 			      BIT(IIO_CHAN_INFO_OFFSET),
 	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
 	.scan_type = {
@@ -940,6 +941,9 @@ static int ad4170_read_raw(struct iio_dev *indio_dev,
 		pga = FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe);
 		*val = chan_info->offset_tbl[pga];
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		*val = setup->gain;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -1054,6 +1058,18 @@ static int ad4170_set_pga(struct ad4170_state *st,
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
@@ -1063,6 +1079,8 @@ static int __ad4170_write_raw(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
 		return ad4170_set_pga(st, chan, val, val2);
+	case IIO_CHAN_INFO_CALIBSCALE:
+		return ad4170_set_calib_gain(st, chan, val);
 	default:
 		return -EINVAL;
 	}
@@ -1089,6 +1107,8 @@ static int ad4170_write_raw_get_fmt(struct iio_dev *indio_dev,
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


