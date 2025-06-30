Return-Path: <linux-iio+bounces-21165-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22A6AEDFFF
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 16:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDD3C7A38E6
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 14:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A50528C851;
	Mon, 30 Jun 2025 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uPGkZxM8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89F3286D5D;
	Mon, 30 Jun 2025 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292161; cv=none; b=RfgecU1BppQtY3taFneEwt7pUxYZMNg2e9rhuNjRRhHJOT/5MiHiPDmidUfm11W4ApDfdDTBCjmRaMbnr2NLgRGBJEom2s/47FQfyEfZizkPvwBY6Bnrv7ncf4QgGjrbIdbBXP4BomqaNLj3g1Xtt2iYtIUNlyl+Y1CQDQNkdyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292161; c=relaxed/simple;
	bh=CERrMN1d3ZFqHU7gFszcxxxmVWa30PuxIIVY7qj37W8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IjiUWJQxTXedUEoYgq9HolaqddgcmDiXcTHzHk5bqZ4ifqOum6FD6kD1nrkMzFxUulU66JkH8xK9GjJZwnMfYNZXygUqz1eycCLvUGCDqZ+8T55ss3UrZYRbuYamkP3VS1fr1U9Na8q6kijB+EP3+WVJS7mxMbHK5eQ4oQDRAqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uPGkZxM8; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UDc97d026449;
	Mon, 30 Jun 2025 10:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=gpIyt
	FLSmYcHOo7QvRrFC4g1sC0UPrKUJCM+Rfjt4P0=; b=uPGkZxM8V5UyoN9mYPKGZ
	jkKp+dwyKwE3PjuEomG9H76RC+Co5EH+4x1eUqZVNLAMoOuL2nO6X0ULciWLG6UW
	rSml48qt82bi79hpE1JOknGR6LMoHe9AO/SkO04PiSRUu3lndVSfQurFTaM7o75/
	d0SYfLUvzYgcj7IRJPmF/Jp5PP8qNbYkv8TobgIEI+D/ClYldUQSIWZKsR8lyvEe
	Y3M7nlT7hrnrYcXAFJM29B3hZLVbciyDPvoFk2aaqDtJHIXutCKojZ1zLoCslkc0
	b1zhcqYtmdfD7ysBRwov4uFwY4f/UsCdBOOSir8I+AYYMoFqyVJ/jwo7XzgnV2vR
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 47krqa110y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 10:02:14 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 55UE2Dbv054752
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Jun 2025 10:02:13 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Jun 2025 10:02:13 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Jun 2025 10:02:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Jun 2025 10:02:13 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55UE1uIV009320;
	Mon, 30 Jun 2025 10:01:59 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v7 12/12] iio: adc: ad4170-4: Add timestamp channel
Date: Mon, 30 Jun 2025 11:01:55 -0300
Message-ID: <b7789604240f964ddeb756f9d17002371435f936.1751289747.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDExNSBTYWx0ZWRfX5LkCLmfzYSu9
 6QqUcjpluRlbMdGrsT4yRsBhbqnj7I0Bzy3wG2/XV3u9BaaOKjMMHK+v/qs142PW3vR3sOS/jGJ
 7wvrwRIcil93y8cRTWDru+oBc8fX4BZznUiMcQcU+tUAmw12PnOlQLonn7OdJ/5MZd4AANrYVOW
 Iby3vcFNuP6098HWwWCll0BaFEWnAePKDu3IePZoAmM9kMYj/RffRy5Lu8o6HRkCyBhmiju+74n
 iKgUoL0W/oWZHHUkw+X55mQT9XWEUHhl2tOd8i67S9uG/uuUQpzFR+KpgM6RsxitkujLtu90wQh
 3ZV/QGo8feuCCKEPybFwXNZ5b4y2hdzUfWmcV/pq2MQhK86e1n1mjjYq3TAvphiB6nfZ9sIUceY
 k1NdmBji80c3WPLphMn6Y5y2fajj01Gw9Ft3JZjKslkeXChIoHCyNQbpZYusUDMOslWk/+Vs
X-Proofpoint-GUID: NdKChKeZMOnQNOqpp-26XfVk4kX_RgS5
X-Proofpoint-ORIG-GUID: NdKChKeZMOnQNOqpp-26XfVk4kX_RgS5
X-Authority-Analysis: v=2.4 cv=U8+SDfru c=1 sm=1 tr=0 ts=686298e6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=ooJTjvKFDTQpXrV7GjsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_03,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300115

Add timestamp channel allowing to record the moment at which ADC samples
are captured in buffered read mode.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes since v5.

 drivers/iio/adc/ad4170-4.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad4170-4.c b/drivers/iio/adc/ad4170-4.c
index 05730e36deea..b1476479b950 100644
--- a/drivers/iio/adc/ad4170-4.c
+++ b/drivers/iio/adc/ad4170-4.c
@@ -187,6 +187,7 @@
 #define AD4170_NUM_ANALOG_PINS				9
 #define AD4170_NUM_GPIO_PINS				4
 #define AD4170_MAX_CHANNELS				16
+#define AD4170_MAX_IIO_CHANNELS				(AD4170_MAX_CHANNELS + 1)
 #define AD4170_MAX_ANALOG_PINS				8
 #define AD4170_MAX_SETUPS				8
 #define AD4170_INVALID_SETUP				9
@@ -439,7 +440,7 @@ struct ad4170_state {
 	int vrefs_uv[AD4170_MAX_SUP];
 	u32 mclk_hz;
 	struct ad4170_setup_info setup_infos[AD4170_MAX_SETUPS];
-	struct iio_chan_spec chans[AD4170_MAX_CHANNELS];
+	struct iio_chan_spec chans[AD4170_MAX_IIO_CHANNELS];
 	struct ad4170_chan_info chan_infos[AD4170_MAX_CHANNELS];
 	struct spi_device *spi;
 	struct regmap *regmap;
@@ -456,6 +457,7 @@ struct ad4170_state {
 	unsigned int clock_ctrl;
 	int gpio_fn[AD4170_NUM_GPIO_PINS];
 	unsigned int cur_src_pins[AD4170_NUM_CURRENT_SRC];
+	unsigned int num_adc_chans;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
 	 * to live in their own cache lines.
@@ -2395,7 +2397,16 @@ static int ad4170_parse_channels(struct iio_dev *indio_dev)
 			return dev_err_probe(dev, ret, "Invalid input config\n");
 
 		st->chan_infos[chan_num].input_range_uv = ret;
+		chan_num++;
 	}
+	st->num_adc_chans = chan_num;
+
+	/* Add timestamp channel */
+	struct iio_chan_spec ts_chan = IIO_CHAN_SOFT_TIMESTAMP(chan_num);
+
+	st->chans[chan_num] = ts_chan;
+	num_channels = num_channels + 1;
+
 	indio_dev->num_channels = num_channels;
 	indio_dev->channels = st->chans;
 
@@ -2608,7 +2619,7 @@ static int ad4170_initial_config(struct iio_dev *indio_dev)
 		return dev_err_probe(dev, ret,
 				     "Failed to set ADC mode to idle\n");
 
-	for (i = 0; i < indio_dev->num_channels; i++) {
+	for (i = 0; i < st->num_adc_chans; i++) {
 		struct ad4170_chan_info *chan_info;
 		struct iio_chan_spec const *chan;
 		struct ad4170_setup *setup;
@@ -2733,7 +2744,7 @@ static int ad4170_buffer_predisable(struct iio_dev *indio_dev)
 	 * is done after buffer disable. Disable all channels so only requested
 	 * channels will be read.
 	 */
-	for (i = 0; i < indio_dev->num_channels; i++) {
+	for (i = 0; i < st->num_adc_chans; i++) {
 		ret = ad4170_set_channel_enable(st, i, false);
 		if (ret)
 			return ret;
@@ -2785,7 +2796,9 @@ static irqreturn_t ad4170_trigger_handler(int irq, void *p)
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


