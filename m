Return-Path: <linux-iio+bounces-18775-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C92CA9F0B7
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 14:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2D9D168BC2
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 12:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120C7224244;
	Mon, 28 Apr 2025 12:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CADCIZsj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4731826A0AD;
	Mon, 28 Apr 2025 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745843383; cv=none; b=TsvoqfD4Py2uFOIBGkgWJtb4kXyz/DrQVeCaDS/b91PbCjfwZ5df3f5nsSvPbAKHUC7d4rGG4ssFKUkJypuGsZzuEiRQdZKE21tUoWWv9ViJg+D332kfR425Dx1NhffhlZoKpBybehLv9jqtvchJRJV+AO/TiTlmU/+P3Dhhy6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745843383; c=relaxed/simple;
	bh=S0hSiKAWNMP/RoqT/XgPH53RHq1h0lEsykvuH54nKT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SdQlJg27xvy0LE/CLRCS9FUhSmif5jtkTxdfiSTfW8oLYfLXMsRjoI6wDeoMOEX7Jt6v3omZlOy+q0gvFJY3LxwvSh9M9TSVIjXdMXRVnPIB/5f1tyVzHuAQL4AztbsyVOnyadpGEAAMBC3Vw4BuJJ6oZJED5a3rp8I5a9RMMgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CADCIZsj; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SBoOcK027402;
	Mon, 28 Apr 2025 08:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=wkQP7
	8hNZfAyrIdYhnzSjGub993BMX4Aumd8EDWtQj0=; b=CADCIZsjziTFjlbekQNsN
	SL3GmjK+aPFyVx/GSK8ZmIqDi8ZacKEWWg4xqosETW4h4FIiPBkhQPFUcqPC4i6P
	o32Cp+4nVty4XoITyhlCHzk6IFzDITcIZuOldxhlBCgcZHYyJLXOr9+ZBORfodR9
	Rp08Uhp0LUymHGUIIyk+M2d7nPP2LXZ+r99X1oM76rmXM3x2vdzrBGaEPmh4PG2q
	ADafImamoRlpoqtgZ4RISVoh75kcPpBrKzU9HBWN/0VvNfa2r+uAsR+Gzy+4j8ln
	taHxLNvYB4C8Kj8Hz5tBqy0uY0jj/V1rz4ivGQMSBua3hoA+BVqhJLe2RWP71VPr
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 469dtgh6fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 08:29:27 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53SCTQjG011856
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Apr 2025 08:29:26 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 28 Apr 2025 08:29:26 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 28 Apr 2025 08:29:26 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 28 Apr 2025 08:29:26 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53SCTDt7032550;
	Mon, 28 Apr 2025 08:29:15 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 6/7] iio: adc: ad4170: Add support for internal temperature sensor
Date: Mon, 28 Apr 2025 09:29:12 -0300
Message-ID: <c249f5c7ee07583b65cd40b0fc6f1faa79c3bfe9.1745841276.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1745841276.git.marcelo.schmitt@analog.com>
References: <cover.1745841276.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEwMyBTYWx0ZWRfX6UswnrUzOl/1 Bl0WNr1fr7VlJ9B5ZgfzthDO/EWqPHXEmeIQ0bB+HuAWlwKJG9ngnz1tNXpold2CZIVPHQyo9zT Lg0ajYHgb4SMn7B+mpIqiutZQ5gmGofXgZZ3l6gc81jIy7kHqb/gegTT3YtDHnEc876ERy0mre1
 b3EsTIe/85AU5cTxaZmxtNGcN9Qwn9UoSjBznCwVkVBcH8cBN0HWs85h8MLFUzjdItMeFrLFp6t L8AjVJcaAlWhN1GsRbqdXdbZC50QbbgF2XonQt2J8mnqbGUW0ijQ5YjMKVnF479X14QIIz14sDX qnuizAk9kHi0abwSP5j3ItkFr71pTPjLolNEN9VUE8BrYW/mcsUOmV83dJOOOhBrNRCBMO20VpO
 jA4sO2AX7nASR4osLpbHv1bpSf2brRx4Jf2q/W2Whhh3NhwpmpqmqnMN9bpkHlVYqTfzH9qQ
X-Proofpoint-ORIG-GUID: hAe2EYHOoY5YI1sbzJIhbL4Irfa5p6ab
X-Proofpoint-GUID: hAe2EYHOoY5YI1sbzJIhbL4Irfa5p6ab
X-Authority-Analysis: v=2.4 cv=crybk04i c=1 sm=1 tr=0 ts=680f74a7 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=o3DtMFfdRpqB0q9FUmIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504280103

The AD4170 has an internal temperature sensor that can be read using the
ADC. Whenever possible, configure an IIO channel to provide the chip's
temperature.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
changes since v1:
- Dropped a unneeded comment
- Collected review tag

 drivers/iio/adc/ad4170.c | 72 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index 612676c1c88a..335b4194c7eb 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -891,6 +891,27 @@ static const struct iio_chan_spec ad4170_channel_template = {
 	},
 };
 
+static const struct iio_chan_spec ad4170_temp_channel_template = {
+	.type = IIO_TEMP,
+	.indexed = 0,
+	.channel = 17,
+	.channel2 = 17,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			      BIT(IIO_CHAN_INFO_SCALE) |
+			      BIT(IIO_CHAN_INFO_OFFSET) |
+			      BIT(IIO_CHAN_INFO_CALIBSCALE) |
+			      BIT(IIO_CHAN_INFO_CALIBBIAS) |
+			      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.scan_type = {
+		.sign = 's',
+		.realbits = 24,
+		.storagebits = 32,
+		.shift = 8,
+		.endianness = IIO_BE,
+	},
+};
+
 /*
  * Receives the number of a multiplexed AD4170 input (ain_n), and stores the
  * voltage (in µV) of the specified input into ain_voltage. If the input number
@@ -1189,9 +1210,27 @@ static int ad4170_read_raw(struct iio_dev *indio_dev,
 		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		pga = FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe);
-		*val = chan_info->scale_tbl[pga][0];
-		*val2 = chan_info->scale_tbl[pga][1];
-		return IIO_VAL_INT_PLUS_NANO;
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*val = chan_info->scale_tbl[pga][0];
+			*val2 = chan_info->scale_tbl[pga][1];
+			return IIO_VAL_INT_PLUS_NANO;
+
+		case IIO_TEMP:
+			/*
+			 * The scale_tbl converts output codes to mV units so
+			 * multiply by MILLI to make the factor convert to µV.
+			 * Then, apply the temperature sensor change sensitivity
+			 * of 477 μV/K. Finally, multiply the result by MILLI
+			 * again to comply with milli degrees Celsius IIO ABI.
+			 */
+			*val = 0;
+			*val2 = DIV_ROUND_CLOSEST(chan_info->scale_tbl[pga][1] * MILLI,
+						  477) * MILLI;
+			return IIO_VAL_INT_PLUS_NANO;
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_OFFSET:
 		pga = FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe);
 		*val = chan_info->offset_tbl[pga];
@@ -1852,12 +1891,39 @@ static int ad4170_parse_channels(struct iio_dev *indio_dev)
 	if (num_channels > AD4170_MAX_CHANNELS)
 		return dev_err_probe(dev, -EINVAL, "Too many channels\n");
 
+	/* Add one for temperature */
+	num_channels = min(num_channels + 1, AD4170_MAX_CHANNELS);
+
 	device_for_each_child_node_scoped(dev, child) {
 		ret = ad4170_parse_channel_node(indio_dev, child, chan_num++);
 		if (ret)
 			return ret;
 	}
 
+	/*
+	 * Add internal temperature sensor channel if the maximum number of
+	 * channels has not been reached.
+	 */
+	if (num_channels < AD4170_MAX_CHANNELS) {
+		struct ad4170_setup *setup = &st->chan_infos[chan_num].setup;
+
+		st->chans[chan_num] = ad4170_temp_channel_template;
+		st->chans[chan_num].address = chan_num;
+		st->chans[chan_num].scan_index = chan_num;
+
+		st->chan_infos[chan_num].setup_num = AD4170_INVALID_SETUP;
+		st->chan_infos[chan_num].initialized = true;
+
+		setup->afe |= FIELD_PREP(AD4170_AFE_REF_SELECT_MSK,
+					 AD4170_REF_AVDD);
+
+		ret = ad4170_get_input_range(st, &st->chans[chan_num], chan_num,
+					     AD4170_REF_AVDD);
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "Invalid input config\n");
+
+		st->chan_infos[chan_num].input_range_uv = ret;
+	}
 	indio_dev->num_channels = num_channels;
 	indio_dev->channels = st->chans;
 	return 0;
-- 
2.47.2


