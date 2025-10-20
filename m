Return-Path: <linux-iio+bounces-25292-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 186DCBF328E
	for <lists+linux-iio@lfdr.de>; Mon, 20 Oct 2025 21:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27BEA189DDF3
	for <lists+linux-iio@lfdr.de>; Mon, 20 Oct 2025 19:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0E11C3C11;
	Mon, 20 Oct 2025 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="S/GV6Wmj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B5F2D7DE9;
	Mon, 20 Oct 2025 19:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987760; cv=none; b=cnBYGguK/+Kvzji2QVUVnM6l+kCasgQo1epe5nafwbrS+zAJunIe7RTNKOttES1yDWSa0NnL2cmRSwjo+RF9hGlefHYLVDiJOv9KbswIdwXIB+92+KzetcqZgw/FYNomYivYuvdpI3L68XYn1whRaX7FAFeGNUEpuuYPfA0tsLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987760; c=relaxed/simple;
	bh=DfSbOncfbSbWKBMEesbtZv1T8pP6N6YIiLr6TWtajIE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULYQ8l4URzRNJiKhz/zPav8gQc0qg0m1/ODNfW++5xg7S6AHBhcQ/dvvE25qWOLtcZ3R/RgSx3Pk0f4dEKfjtjyT+v/MNjL5EpOO+ugmGUwWl7UCO0nTQkVm0Q/UEF3znMCq9elCJMVUOdwMx17f3VgxEAs+6yaY+d938aCWZsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=S/GV6Wmj; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KFMlrS026606;
	Mon, 20 Oct 2025 15:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SiknH
	4v0/YW+i+jJQcVAZ379QT74Iw+cOocSzMCEvu8=; b=S/GV6Wmjvz6Xw3+byPE0T
	xXJ28Xi+a7DSz3cIc16osxGWpMmwhxn12VOr0jAzbnJYatJMkfGWWTDx81WlBI8e
	Vl4dPuzZ1BuSJ5vmd+ss1fpn7VebZGdpmmtra1s9KNVhLmKHFQeFcHbKSrX4fZfv
	ptgSyvWKXYNrEfCp7VbONvL8n19XU1SsKkZ7V7bKmowMV9Y4XeLZFOWMsLZ3xL+T
	ISf4AgYyBkxNhjkdYRsSPoIoEh4H2tf7Sao3Xh0cxaJKOJW+JWSC0/UdAr0tnMlD
	UwhaXgO8GV/ws4YFZqd7rxktMiVj9gptOv1RpDaybaIPzo/k4y8zhcpO2fudSofp
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49v7t3b4x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 15:15:54 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 59KJFrCC002701
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Oct 2025 15:15:53 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 20 Oct
 2025 15:15:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 20 Oct 2025 15:15:53 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59KJFeSk013489;
	Mon, 20 Oct 2025 15:15:42 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v6 8/8] iio: adc: ad4030: Support common-mode channels with SPI offloading
Date: Mon, 20 Oct 2025 16:15:39 -0300
Message-ID: <3fadbf22973098c4be9e5f0edd8c22b8b9b18ca6.1760984107.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1760984107.git.marcelo.schmitt@analog.com>
References: <cover.1760984107.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDA2MiBTYWx0ZWRfX7KxKEwT+UMGl
 0JD7+9UKIN+SdTjrzdXf7I78OlAnFI0wd6l94BXwSfH1hpGxupYeV3XNV96/S4EdLOWkZA1fRJq
 oCb//Uz0MdcWgBuFXrDhBl0ZEZjLWvw5ymX355O8Zu7Onzyksoio7GyXyNyd10lWCZYr2YPGLAf
 5okBmm0Mck5W0lPMxLCMzrHrzv1VpQTd4zH7Mb57YVhsM3deWPoiJUATxWxm9Iy8ZRbTxaPtkeR
 PPX3q3HpJfBOJng0Q31NRztpA8dBIfqDCvCoWbNgLcmz8lrNG4ApB/GhDrZTo7H9W1TG8fspgZy
 cOJ9pHlIyrD8+uh6lL7xKIFwDoBs6YSY5Ikh3qX+w91C/ZCw9GG552rQHoLGggzTgdg5IJoEajy
 oV6xaqjQeOSnsCUkGLyAdVnKNLu3mg==
X-Authority-Analysis: v=2.4 cv=UPPQ3Sfy c=1 sm=1 tr=0 ts=68f68a6a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=HoujexutVUGUbmyXq-QA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 9xg1Rnwvn8KvWhlgSlnR_yYb6oXSPoRB
X-Proofpoint-GUID: 9xg1Rnwvn8KvWhlgSlnR_yYb6oXSPoRB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180062

AD4030 and similar devices can read common-mode voltage together with
ADC sample data. When enabled, common-mode voltage data is provided in a
separate IIO channel since it measures something other than the primary
ADC input signal and requires separate scaling to convert to voltage
units. The initial SPI offload support patch for AD4030 only provided
differential channels. Now, extend the AD4030 driver to also provide
common-mode IIO channels when setup with SPI offloading capability.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
New patch.
I hope this works for ADCs with two channels. It's not clear if works as
expected with current HDL and single-channel ADCs (like ADAQ4216).

The ad4630_fmc HDL project was designed for ADCs with two channels and
always streams two data channels to DMA (even when the ADC has only one
physical channel). Though, if the ADC has only one physical channel, the
data that would come from the second ADC channel comes in as noise and
would have to be discarded. Because of that, when using single-channel
ADCs, the ADC driver would need to use a special DMA buffer to filter out
half of the data that reaches DMA memory. With that, the ADC sample data
could be delivered to user space without any noise being added to the IIO
buffer. I have implemented a prototype of such specialized buffer
(industrialio-buffer-dmaengine-filtered), but it is awful and only worked
with CONFIG_IIO_DMA_BUF_MMAP_LEGACY (only present in ADI Linux tree). Usual
differential channel data is also affected by the extra 0xFFFFFFFF data
pushed to DMA. Though, for the differential channel, it's easier to see it
shall work for two-channel ADCs (the sine wave appears "filled" in
iio-oscilloscope).

So, I sign this, but don't guarantee it to work.

 drivers/iio/adc/ad4030.c | 49 ++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 5f968f2a2b3c..74ff35742cda 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -192,7 +192,7 @@ struct ad4030_state {
 	unsigned int avg_log2;
 	enum ad4030_out_mode mode;
 	/* Offload sampling */
-	struct spi_transfer offload_xfer;
+	struct spi_transfer offload_xfer[2];
 	struct spi_message offload_msg;
 	struct spi_offload *offload;
 	struct spi_offload_trigger *offload_trigger;
@@ -237,7 +237,7 @@ struct ad4030_state {
  * - _idx - _ch * 2 + _ch gives the channel number for this specific common-mode
  *   channel
  */
-#define AD4030_CHAN_CMO(_idx, _ch)  {					\
+#define __AD4030_CHAN_CMO(_idx, _ch, _offload)  {			\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
 		BIT(IIO_CHAN_INFO_SCALE),				\
 	.type = IIO_VOLTAGE,						\
@@ -247,12 +247,18 @@ struct ad4030_state {
 	.scan_index = (_idx),						\
 	.scan_type = {							\
 		.sign = 'u',						\
-		.storagebits = 8,					\
+		.storagebits = (_offload ? 32 : 8),			\
 		.realbits = 8,						\
-		.endianness = IIO_BE,					\
+		.endianness = (_offload ? IIO_CPU : IIO_BE),		\
 	},								\
 }
 
+#define AD4030_CHAN_CMO(_idx, _ch)					\
+	__AD4030_CHAN_CMO(_idx, _ch, 0)
+
+#define AD4030_OFFLOAD_CHAN_CMO(_idx, _ch)				\
+	__AD4030_CHAN_CMO(_idx, _ch, 1)
+
 /*
  * For a chip with 2 hardware channel this will be used to create 2 differential
  * channels:
@@ -1180,6 +1186,7 @@ static const struct iio_buffer_setup_ops ad4030_buffer_setup_ops = {
 static void ad4030_prepare_offload_msg(struct iio_dev *indio_dev)
 {
 	struct ad4030_state *st = iio_priv(indio_dev);
+	bool common_mode;
 	u8 offload_bpw;
 
 	if (st->mode == AD4030_OUT_DATA_MD_30_AVERAGED_DIFF)
@@ -1187,10 +1194,22 @@ static void ad4030_prepare_offload_msg(struct iio_dev *indio_dev)
 	else
 		offload_bpw = st->chip->precision_bits;
 
-	st->offload_xfer.bits_per_word = offload_bpw;
-	st->offload_xfer.len = spi_bpw_to_bytes(offload_bpw);
-	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
-	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
+	st->offload_xfer[0].bits_per_word = offload_bpw;
+	st->offload_xfer[0].len = spi_bpw_to_bytes(offload_bpw);
+	st->offload_xfer[0].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+
+	common_mode = st->mode == AD4030_OUT_DATA_MD_24_DIFF_8_COM ||
+		      st->mode == AD4030_OUT_DATA_MD_16_DIFF_8_COM;
+
+	if (common_mode) {
+		offload_bpw = 8;
+		st->offload_xfer[1].bits_per_word = offload_bpw;
+		st->offload_xfer[1].len = spi_bpw_to_bytes(offload_bpw);
+		st->offload_xfer[1].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+	}
+
+	spi_message_init_with_transfers(&st->offload_msg, st->offload_xfer,
+					common_mode ? 2 : 1);
 }
 
 static int ad4030_offload_buffer_postenable(struct iio_dev *indio_dev)
@@ -1273,6 +1292,7 @@ static int ad4030_offload_buffer_predisable(struct iio_dev *indio_dev)
 static const struct iio_buffer_setup_ops ad4030_offload_buffer_setup_ops = {
 	.postenable = &ad4030_offload_buffer_postenable,
 	.predisable = &ad4030_offload_buffer_predisable,
+	.validate_scan_mask = ad4030_validate_scan_mask,
 };
 
 static int ad4030_regulators_get(struct ad4030_state *st)
@@ -1524,7 +1544,7 @@ static int ad4030_probe(struct spi_device *spi)
 		 * Offloaded SPI transfers can't support software timestamp so
 		 * no additional timestamp channel is added.
 		 */
-		indio_dev->num_channels = st->chip->num_voltage_inputs;
+		indio_dev->num_channels = 2 * st->chip->num_voltage_inputs;
 		indio_dev->channels = st->chip->offload_channels;
 		ret = ad4030_spi_offload_setup(indio_dev, st);
 		if (ret)
@@ -1645,6 +1665,7 @@ static const struct ad4030_chip_info ad4030_24_chip_info = {
 	},
 	.offload_channels = {
 		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(1, 0),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4030_24_GRADE,
 	.precision_bits = 24,
@@ -1666,6 +1687,8 @@ static const struct ad4030_chip_info ad4630_16_chip_info = {
 	.offload_channels = {
 		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_16_offload_scan_types),
 		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_16_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(2, 0),
+		AD4030_OFFLOAD_CHAN_CMO(3, 1),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4630_16_GRADE,
 	.precision_bits = 16,
@@ -1687,6 +1710,8 @@ static const struct ad4030_chip_info ad4630_24_chip_info = {
 	.offload_channels = {
 		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
 		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_24_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(2, 0),
+		AD4030_OFFLOAD_CHAN_CMO(3, 1),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4630_24_GRADE,
 	.precision_bits = 24,
@@ -1708,6 +1733,8 @@ static const struct ad4030_chip_info ad4632_16_chip_info = {
 	.offload_channels = {
 		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_16_offload_scan_types),
 		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_16_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(2, 0),
+		AD4030_OFFLOAD_CHAN_CMO(3, 1),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4632_16_GRADE,
 	.precision_bits = 16,
@@ -1729,6 +1756,8 @@ static const struct ad4030_chip_info ad4632_24_chip_info = {
 	.offload_channels = {
 		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
 		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_24_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(2, 0),
+		AD4030_OFFLOAD_CHAN_CMO(3, 1),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4632_24_GRADE,
 	.precision_bits = 24,
@@ -1747,6 +1776,7 @@ static const struct ad4030_chip_info adaq4216_chip_info = {
 	},
 	.offload_channels = {
 		ADAQ4216_OFFLOAD_CHAN_DIFF(0, ad4030_16_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(1, 0),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_ADAQ4216_GRADE,
 	.precision_bits = 16,
@@ -1766,6 +1796,7 @@ static const struct ad4030_chip_info adaq4224_chip_info = {
 	},
 	.offload_channels = {
 		ADAQ4216_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(1, 0),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_ADAQ4224_GRADE,
 	.precision_bits = 24,
-- 
2.39.2


