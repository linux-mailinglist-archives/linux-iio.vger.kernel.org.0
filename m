Return-Path: <linux-iio+bounces-21427-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C03AFB559
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 15:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941781AA647E
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 13:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCDB1891AB;
	Mon,  7 Jul 2025 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="iOyQ3dEC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EE719D880;
	Mon,  7 Jul 2025 13:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751896425; cv=none; b=rPKzjzjPxBHyQRIOE5eMnCtTHaMMiGFgU3ubTNo7m3z0ydzD5391/Y2wskvPRYvYK+ae0WBeQPHeB9qEYpy7Oyikll9PIxERcfWNOBHrvJhD4ECjaGov0M/CywORRb6WczefrrkA0/wOfla9QzODLQzMNWaJSWzC866JimVnp+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751896425; c=relaxed/simple;
	bh=8QD0QB0JFtAWQ8pMqEYQMTxq2uTM9hw1AHeH42QHSZ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JSm5GM2kvk7BDDAYxGEDy4NHnwWxcNuMpS4IP15ncSzs1+ov3UKOz8aDdcizoGlvjGmUja8Z1eE5YqLikQdL6lyy7/rdxxpJdehzHpI3BL3OFNoOCDZozTquEGgxAqBOmNhhldJKsvmAWt6tpK9cpDw6eisPFXtdVrKVuWCOfe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=iOyQ3dEC; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567DBY4n026983;
	Mon, 7 Jul 2025 09:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lHwY9
	3rLMAiHpkUtNryttT4RVADlVLuTP2wwnw3Oldo=; b=iOyQ3dECqG1EWGFr4Ex6X
	aj8NfyiOEzxpvQ78hMZOkh9z0k5H6iewWh882EpW9flx2VdJ0v812KAJ/cUKnTiD
	ow/li5inv+uR1GJafJWPFicP41lyJ9YnMQZWGOfISpYz+DyrzDkw+EpLp6A90udH
	3A9g3GM6fdfTFQ/n8y828VWcIb5RsOt806QXwasEiil11hoxYw/opoF5T4Kln5cv
	KWF48FAPC2TAE52J5nomPKF9+zt+E+2IWYNeK/IQYzmgDQtoMQ7Me+8FZhCHbN2j
	V80Td8HAoFOBdHLRSo4Y0Vijk15pQZzXqDpyiuiNEmLgfjks2BwXZApaYP6tYYQw
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 47rayqh6xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 09:53:26 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 567DrPQ1011719
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 7 Jul 2025 09:53:25 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 7 Jul
 2025 09:53:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 7 Jul 2025 09:53:25 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 567Dr8uk016181;
	Mon, 7 Jul 2025 09:53:11 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <andriy.shevchenko@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v8 08/12] iio: adc: ad4170-4: Add timestamp channel
Date: Mon, 7 Jul 2025 10:53:08 -0300
Message-ID: <e0af7e5424898bee0f3edfbb017133624efc169d.1751895245.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1751895245.git.marcelo.schmitt@analog.com>
References: <cover.1751895245.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=AP9nYgXq c=1 sm=1 tr=0 ts=686bd156 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=Wb1JkmetP80A:10 a=gAnH3GRIAAAA:8 a=WtUs5_ufmMxjYN1vTFoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA4MSBTYWx0ZWRfX3pVZofoaHMR7
 S55R2Y9WfmJdCVEGfzuXe+ooQJuzhiiIEDuQX/oK2j0xdKPlODnPSUKSgpYl64BBdij8Zz8fETj
 14I6zzgN4lMLGx40ZOiny+So5stzLcfBp3KbNiNhjJ+ZgMxvZcvQpddJMuLKU9thwhh9xlkS1bs
 Lo//WAJ1TWQnA771BZE1We6yM8GRTWSG6kToV8wL6k+ZPDKVAMhX6WLhXSlv62F1FlwB4l62vLz
 Od9Ta4cbzxX/3o3g7KWTmVUh1KsHojH+y7xRDSzSDBHcCXMZ+vzccl8uCm/PFbrADlsALsZKqG3
 N1mU3+AdzZaNLR8eteeid4XpDcd7nzPXIIOzvudmFVBnDRVEqF23WfiLLfcHjRpUCWFknIz52AA
 W1AE64+/7BaMUJFaPGXWUZKdbHFqSqxWPs/eOOtfhSMykIeDSybd4AWyZrHcHv6Q6W/CuPsm
X-Proofpoint-ORIG-GUID: oqYSJoIQOhkmj1qN-UuqOVze4Rs4pNL_
X-Proofpoint-GUID: oqYSJoIQOhkmj1qN-UuqOVze4Rs4pNL_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507070081

Add timestamp channel allowing to record the moment at which ADC samples
are captured in buffered read mode.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v7 -> v8
- This is now patch 8 in the series (moved from end of the series to right after
  buffer support patch).
- Reworked to not add 'num_adc_chans' field to struct ad4170_state.

 drivers/iio/adc/ad4170-4.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4170-4.c b/drivers/iio/adc/ad4170-4.c
index 738f37394402..30ae667a252c 100644
--- a/drivers/iio/adc/ad4170-4.c
+++ b/drivers/iio/adc/ad4170-4.c
@@ -138,6 +138,7 @@
 
 #define AD4170_NUM_ANALOG_PINS				9
 #define AD4170_MAX_ADC_CHANNELS				16
+#define AD4170_MAX_IIO_CHANNELS				(AD4170_MAX_ADC_CHANNELS + 1)
 #define AD4170_MAX_ANALOG_PINS				8
 #define AD4170_MAX_SETUPS				8
 #define AD4170_INVALID_SETUP				9
@@ -334,7 +335,7 @@ struct ad4170_state {
 	struct ad4170_setup_info setup_infos[AD4170_MAX_SETUPS];
 	struct ad4170_chan_info chan_infos[AD4170_MAX_ADC_CHANNELS];
 	struct completion completion;
-	struct iio_chan_spec chans[AD4170_MAX_ADC_CHANNELS];
+	struct iio_chan_spec chans[AD4170_MAX_IIO_CHANNELS];
 	struct spi_device *spi;
 	struct regmap *regmap;
 	int sps_tbl[ARRAY_SIZE(ad4170_filt_names)][AD4170_MAX_FS_TBL_SIZE][2];
@@ -1633,6 +1634,12 @@ static int ad4170_parse_channels(struct iio_dev *indio_dev)
 			return ret;
 	}
 
+	/* Add timestamp channel */
+	struct iio_chan_spec ts_chan = IIO_CHAN_SOFT_TIMESTAMP(chan_num);
+
+	st->chans[chan_num] = ts_chan;
+	num_channels = num_channels + 1;
+
 	indio_dev->num_channels = num_channels;
 	indio_dev->channels = st->chans;
 
@@ -1693,6 +1700,9 @@ static int ad4170_initial_config(struct iio_dev *indio_dev)
 		unsigned int val;
 
 		chan = &indio_dev->channels[i];
+		if (chan->type == IIO_TIMESTAMP)
+			continue;
+
 		chan_info = &st->chan_infos[chan->address];
 
 		setup = &chan_info->setup;
@@ -1812,6 +1822,9 @@ static int ad4170_buffer_predisable(struct iio_dev *indio_dev)
 	 * channels will be read.
 	 */
 	for (i = 0; i < indio_dev->num_channels; i++) {
+		if (indio_dev->channels[i].type == IIO_TIMESTAMP)
+			continue;
+
 		ret = ad4170_set_channel_enable(st, i, false);
 		if (ret)
 			return ret;
@@ -1863,7 +1876,9 @@ static irqreturn_t ad4170_trigger_handler(int irq, void *p)
 		memcpy(&st->bounce_buffer[i++], st->rx_buf, ARRAY_SIZE(st->rx_buf));
 	}
 
-	iio_push_to_buffers(indio_dev, st->bounce_buffer);
+	iio_push_to_buffers_with_ts(indio_dev, st->bounce_buffer,
+				    sizeof(st->bounce_buffer),
+				    iio_get_time_ns(indio_dev));
 err_out:
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
-- 
2.47.2


