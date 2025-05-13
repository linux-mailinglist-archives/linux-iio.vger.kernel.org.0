Return-Path: <linux-iio+bounces-19489-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 722AAAB54E6
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 14:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91967189EBFA
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 12:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255FF28DF0F;
	Tue, 13 May 2025 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="L+cplbNC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473EB2580FD;
	Tue, 13 May 2025 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747139721; cv=none; b=TLGxS/A2aD2CntUcw5ZnjZGo2i1vTei9Bn26GAiU0Z9akcNrkU4/YgJsAYzkOPsl05+6i9tHlkFKj8hgoOuwb3EXDnjtpMqey4ju0lkSKPWxTGJWg7T7mse3K0+tECIKYAupHjllBrt4t4rAXIkaBCalgDkY9TOlg+XRedyCbwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747139721; c=relaxed/simple;
	bh=zGg7o0AByn4EdPHDp/nX5exWXbLFjJ584UbITqi5ydM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPC53oaPkNzxttSmpJ2TlbgesPRPgU0aZ20KuEL6ni451bLs2gwXHgvWyFntvewLpoArsofciykyNNLupwVveMb8xo3V8jgUzR5XrM9HUfkhlFA/ay9QrMtevie4UO1wplxiwZzj+98W6RdLmOYEKuqCqkKFl+A5OvXHS0bJXD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=L+cplbNC; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D9mZxC025002;
	Tue, 13 May 2025 08:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=zbreg
	+lph2fMuopB8ba+1C84A61YYcv+j3DhZpyOmVA=; b=L+cplbNCK75xhWgwg6m5o
	LY5rWPNDSdAbh/JKLNf9kq/v7U7TcIf2TJtUloCb8rkeg53qgjeJiSBxpI61smPM
	F2jj97qMVYT9TjE2ZLdFEHSLC2s352Q7NUXYGJl88IcICh6c0NuBuVDMPU4+wUaX
	waY2lLr4tXtDbn3OWqfIRR9wunNRmeYhwZKJBb2crm7DB3WSoGVn8qVwIPtsClfD
	rpJEaGToFUC46lh2NncULhxJUj64kzzIkuKpk8Pgcs5EVxv1lOVyJDt3x84G7ufj
	MbcXLTkzVc/FfD96IdsuI2WJVZt7aeh/bmbyQ6Xyko+CcXXkT8uBuLUFLD4kDR8q
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46m3s98spn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 08:35:03 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 54DCZ2bf041030
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 May 2025 08:35:02 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 13 May 2025 08:35:02 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 13 May 2025 08:35:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 13 May 2025 08:35:01 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54DCYirk007479;
	Tue, 13 May 2025 08:34:46 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 04/10] iio: adc: ad4170: Add support for calibration bias
Date: Tue, 13 May 2025 09:34:42 -0300
Message-ID: <6213d7b7fb913520f1f143e7ccf8fe16b8579d0c.1747083143.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1747083143.git.marcelo.schmitt@analog.com>
References: <cover.1747083143.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 9tyFkPhOrUuBf3P-Yo9NCXin5PEqGoGg
X-Authority-Analysis: v=2.4 cv=ZaUdNtVA c=1 sm=1 tr=0 ts=68233c77 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=1daVv4cnZmPfqeT0XEsA:9
X-Proofpoint-GUID: 9tyFkPhOrUuBf3P-Yo9NCXin5PEqGoGg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDExNyBTYWx0ZWRfX6qiUWuaUTZqM
 ZRhF6pXfDkYH9Xm8X7inNaak49xYwqPnaEjleJuqQw04xIWkITpvi3MxbW7yFynCVow8ZxCCmCT
 9sis0q9q5lzW+DZbOaU9g2A3kYE6EB6FtGg/QeCu3UD0ld95zRHXL5chpqRn/uPvnwS8UI0mGBP
 bfe75bu4NTp93SyullXgwKA11T+Ivhlzjats0uTu4g9H2OyJloaXGz591SWoTgFVzZ4DuWnObvD
 wRUE4YzpFGRgjbbEI8CCNVWB6nBkE3ZjCZm+q4kva6/9/8bNIhCOLkWFxBK53UG4kFidL+TX/gx
 9m2uZtdozFuYDgAfM8j8hGpoH4v63C3DQ65DsYWFvZOvwDuSbphli6+BpEJwFhTNIpHv4Em9aIr
 1w954rmQ4pE5xgbayvn6hSjkt42WR+t8P2eFrxZG6hkMedj2rmZrGNLVUINQXdBO15IBaZYd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1011
 mlxscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130117

Add support for ADC calibration bias/offset configuration.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v2 -> v3
- New patch spun out of the base driver patch.

 drivers/iio/adc/ad4170.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index 1df214f7fdec..b02fdd25b4c8 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -643,6 +643,7 @@ static const struct iio_chan_spec ad4170_channel_template = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			      BIT(IIO_CHAN_INFO_SCALE) |
 			      BIT(IIO_CHAN_INFO_OFFSET) |
+			      BIT(IIO_CHAN_INFO_CALIBBIAS) |
 			      BIT(IIO_CHAN_INFO_CALIBSCALE),
 	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
 	.scan_type = {
@@ -954,6 +955,9 @@ static int ad4170_read_raw(struct iio_dev *indio_dev,
 		pga = FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe);
 		*val = chan_info->offset_tbl[pga];
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*val = setup->offset;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBSCALE:
 		*val = setup->gain;
 		return IIO_VAL_INT;
@@ -1083,6 +1087,25 @@ static int ad4170_set_pga(struct ad4170_state *st,
 	return 0;
 }
 
+static int ad4170_set_calib_offset(struct ad4170_state *st,
+				   struct iio_chan_spec const *chan, int val)
+{
+	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
+	struct ad4170_setup *setup = &chan_info->setup;
+	u32 old_offset;
+	int ret;
+
+	guard(mutex)(&st->lock);
+	old_offset = setup->offset;
+	setup->offset = val;
+
+	ret = ad4170_write_channel_setup(st, chan->address, false);
+	if (ret)
+		setup->offset = old_offset;
+
+	return ret;
+}
+
 static int ad4170_set_calib_gain(struct ad4170_state *st,
 				 struct iio_chan_spec const *chan, int val)
 {
@@ -1111,6 +1134,8 @@ static int __ad4170_write_raw(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
 		return ad4170_set_pga(st, chan, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return ad4170_set_calib_offset(st, chan, val);
 	case IIO_CHAN_INFO_CALIBSCALE:
 		return ad4170_set_calib_gain(st, chan, val);
 	default:
@@ -1139,6 +1164,7 @@ static int ad4170_write_raw_get_fmt(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
 		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_CALIBBIAS:
 	case IIO_CHAN_INFO_CALIBSCALE:
 		return IIO_VAL_INT;
 	default:
-- 
2.47.2


