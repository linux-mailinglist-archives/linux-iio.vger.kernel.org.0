Return-Path: <linux-iio+bounces-21430-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE3EAFB56E
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 15:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6C41AA69E6
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 13:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694FC2BDC2F;
	Mon,  7 Jul 2025 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Q5F8RdQW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920762BCF65;
	Mon,  7 Jul 2025 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751896489; cv=none; b=ivsFBrg43OtPXe5OEAjoITLLYPpkWUuojnkUOY+eR3XTCRQd0LIXkfeN90WB3P8sTebbIWWim01qUGNq05Glb/NzgBGqckllD1+vLuBDcZld/6eaRcRPMKZLwC9dQ9UtXLQ+TA8TKVuHtSqX78/t1OXGddOBY59aYg7/oaiK4CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751896489; c=relaxed/simple;
	bh=+XPLRascporc1Mz9DuRS3u/SmMqDWuYhjLR6JqfcpQE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TiQrUpqGo9xfw3Xroh17pCUEZF5iV4Vz5pqOia4ABaTazE/8b5BybtPEfykqVirbNkNp9NePciX987GK3NoMGY2CM8hejLcol3XO3//cJIOyAUuyRZ+z4s+Xv3veSOfnmHfQdRXL4MrzSd4mRcB7wc1wK9pg1YtkYV4+2KeP+wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Q5F8RdQW; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567CemAU027299;
	Mon, 7 Jul 2025 09:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=uQcJR
	adJwUFtdvWn2EST8rXICxH5j2D0LO+nTlBuVrI=; b=Q5F8RdQWMeW4fBbE4Pydb
	rOPAXSknkt9atgg7MjPA09aJ6YDKhu6vACLGKLKuI6CPDlNrjluwo4ZiSwD1tReC
	uzFyknGikFCLS500ydFGyC57RVXetROQU10oVQPwdNraDhyM0Zk+anKqMjmMSUfQ
	jRDNQB1rO5u81euysLbV2ynurEpsJi6n57ASw9acB58lCD8Z2etNkOxTzj9t4d62
	gyHKRex0ij+c+RIAg7cxhCVvdxWqDp0UURwr2dfTCPN+2fiD+/QJMcamWKbnMVpa
	pQoL4lfxYr1HIQMLqcnX+eS7ylAogCljusINDAfi96HdD0NZOBHmvLdqOf8YpRcl
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 47rayqh727-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 09:54:29 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 567DsSOt011838
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 7 Jul 2025 09:54:28 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 7 Jul 2025 09:54:28 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 7 Jul 2025 09:54:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 7 Jul 2025 09:54:28 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 567DsAev016347;
	Mon, 7 Jul 2025 09:54:12 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <andriy.shevchenko@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v8 11/12] iio: adc: ad4170-4: Add support for internal temperature sensor
Date: Mon, 7 Jul 2025 10:54:09 -0300
Message-ID: <71ac994060cf79a6c49f39b0c7d04c6c9cbbab00.1751895245.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1751895245.git.marcelo.schmitt@analog.com>
References: <cover.1751895245.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=AP9nYgXq c=1 sm=1 tr=0 ts=686bd195 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=gAnH3GRIAAAA:8 a=o3DtMFfdRpqB0q9FUmIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA4MSBTYWx0ZWRfX3YfE0BWE80k+
 5Y/wAYpgia+ccGSGt4Nuh0H5I6DT68dChjC++5J7GUj/U4+HUt9CP8jzI/nd3rDBtpSIXvXbQmf
 AffTDor8iS43vw24q5oHXBq+wQ5d0/kqy/5FVBCRJT5NpCFhVZwlfTVFKMlvt9NJwe7z+lVAdBl
 p9OpqXOdCqlU+t83MvMt4mlkPGQhzzcFGDFpEwa/r7zZvJn7WrKsLXjvHZDzvSliz433akO9dYi
 M/7ABcZtBOI0hJjizNK9qHiq1qbNKWUNQSS2phC0hSpY/nHNhNOZ/9my8KGj+//ZyfN3w7RhOw3
 GgRrjPHhBr+2xGEgk4CJMI9nYlZGP1yv1wvD3A2IUhIjVEa0VWuw/AxXvLNfXqKelAc5A2iCz3Q
 vhTdoAoe0JLs0RwNkWdHajNNuKi3m5Qb3anpOWIdLu0VmzeyyyDYS0QFcYlkMLx/SAPG3M1o
X-Proofpoint-ORIG-GUID: YF3jiuLuJtYhWSN7dkevxHbeJVHlOkOt
X-Proofpoint-GUID: YF3jiuLuJtYhWSN7dkevxHbeJVHlOkOt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507070081

The AD4170-4 has an internal temperature sensor that can be read using the
ADC. Whenever possible, configure an IIO channel to provide the chip's
temperature.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v7 -> v8
- Reduced number of line removals in code diff.

 drivers/iio/adc/ad4170-4.c | 62 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/iio/adc/ad4170-4.c b/drivers/iio/adc/ad4170-4.c
index 3153680c0a30..2a20868a1db7 100644
--- a/drivers/iio/adc/ad4170-4.c
+++ b/drivers/iio/adc/ad4170-4.c
@@ -874,6 +874,27 @@ static const struct iio_chan_spec ad4170_channel_template = {
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
@@ -1181,6 +1202,18 @@ static int ad4170_read_raw(struct iio_dev *indio_dev,
 			*val = chan_info->scale_tbl[pga][0];
 			*val2 = chan_info->scale_tbl[pga][1];
 			return IIO_VAL_INT_PLUS_NANO;
+		case IIO_TEMP:
+			/*
+			 * The scale_tbl converts output codes to mV units so
+			 * multiply by MILLI to make the factor convert to µV.
+			 * Then, apply the temperature sensor change sensitivity
+			 * of 477 μV/K. Finally, multiply the result by MILLI
+			 * again to comply with milli degrees Celsius IIO ABI.
+			 */
+			*val = 0;
+			*val2 = DIV_ROUND_CLOSEST(chan_info->scale_tbl[pga][1] * MILLI, 477) *
+						  MILLI;
+			return IIO_VAL_INT_PLUS_NANO;
 		default:
 			return -EINVAL;
 		}
@@ -1859,6 +1892,9 @@ static int ad4170_parse_channels(struct iio_dev *indio_dev)
 	if (num_channels > AD4170_MAX_ADC_CHANNELS)
 		return dev_err_probe(dev, -EINVAL, "Too many channels\n");
 
+	/* Add one for temperature */
+	num_channels = min(num_channels + 1, AD4170_MAX_ADC_CHANNELS);
+
 	chan_num = 0;
 	device_for_each_child_node_scoped(dev, child) {
 		ret = ad4170_parse_channel_node(indio_dev, child, chan_num++);
@@ -1866,6 +1902,32 @@ static int ad4170_parse_channels(struct iio_dev *indio_dev)
 			return ret;
 	}
 
+	/*
+	 * Add internal temperature sensor channel if the maximum number of
+	 * channels has not been reached.
+	 */
+	if (num_channels < AD4170_MAX_ADC_CHANNELS) {
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
+		chan_num++;
+	}
+
 	/* Add timestamp channel */
 	struct iio_chan_spec ts_chan = IIO_CHAN_SOFT_TIMESTAMP(chan_num);
 
-- 
2.47.2


