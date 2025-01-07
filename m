Return-Path: <linux-iio+bounces-13976-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 036E1A04452
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 16:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A781888032
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 15:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0921F0E36;
	Tue,  7 Jan 2025 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="R/sNnRn9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C341DED66;
	Tue,  7 Jan 2025 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263609; cv=none; b=RGbozJ2EqNfzFlHDPF7UF59D9xnTMbrGVLgsbzHpugSqwm6ibE1hSGTjnpoXkXAErTK0Pkc1NCldSBSt0QFtgzZ8mdW6F6biPVFVJbbpyRnye9mkVMxh6SgDYxXnGeWqpFF2Qs2P1kCJ3ku9pB0cBelJpJPdAK8YLcP8OwaE4eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263609; c=relaxed/simple;
	bh=UZP5UxYOZml3h+hk6jn7wfuQ1vk5HdR+BAbdisNi4Ac=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K8G1itNWWxsUNED8KO8gTPmqSGF77YYXMD1ZJylv1vgUSb56ap8fSt8rqmemT0qEF2PeOguDWqgrNgpBzXuu4Ozez55b1ne9fu5qHR935fpn6/xusxRJeea++w/7zvlkqYBmSSvlzSD404ivcsAnj51SQO6BRnWJx4B044OxkJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=R/sNnRn9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507EvDkD013534;
	Tue, 7 Jan 2025 10:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=qeHJo
	XvYG0S3NFOxA00Igqi+6hN/J8nJZnchelYSdlo=; b=R/sNnRn997W4p7Nz4XChS
	0hkTKBrjFOrySWZSUo2mXyLS9b6ElhrAadx6+rP50x6d8W8If0SRhPcVKEfsTh4w
	PHSgZIYfyuPxkiPGrXIMniDllGxFiqCttlKNDFgk0/SOZprWYA0NLm6KiYsZxNhp
	1hnLk7kAiT630tbsAItJ7J53wLHSfOgRRQrfhAjV2L+840iGQBG1JuXn5P7UbkH4
	PL9DoD/IBxLT2l8knjcPqq8ePMTFzXGgyU08OCUdxrDoYxglXQKFc6YvLDHhAfT2
	f/CRGKhG/nxkcMhlQZZT2yC6nQh6/oLlj88JHvpaVucMd6rUgKJN6i9jfCy2Ls74
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4415f6gdmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 10:26:30 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 507FQTgB034156
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Jan 2025 10:26:29 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 7 Jan 2025 10:26:28 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 7 Jan 2025 10:26:28 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 7 Jan 2025 10:26:28 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 507FQHqO030334;
	Tue, 7 Jan 2025 10:26:20 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 10/15] iio: adc: ad7768-1: Add support for variable VCM
Date: Tue, 7 Jan 2025 12:26:17 -0300
Message-ID: <a6999fc24a4c61498e55f23861997382df2ab4f4.1736201898.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1736201898.git.Jonathan.Santos@analog.com>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Nu4F-qAZ7SdenbZJKj-X2t7PVwsE__ha
X-Proofpoint-GUID: Nu4F-qAZ7SdenbZJKj-X2t7PVwsE__ha
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 adultscore=0
 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501070129

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

The VCM output voltage can be used as a common-mode voltage within the
amplifier preconditioning circuits external to the AD7768-1.

This change exports the VCM as an iio attribute and makes it available
for configuration.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
---
 drivers/iio/adc/ad7768-1.c | 56 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index eaa9a12737ac..574d735f2c3a 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -119,6 +119,17 @@ struct ad7768_clk_configuration {
 	enum ad7768_pwrmode pwrmode;
 };
 
+static const char * const ad7768_vcm_modes[] = {
+	"(AVDD1-AVSS)/2",
+	"2V5",
+	"2V05",
+	"1V9",
+	"1V65",
+	"1V1",
+	"0V9",
+	"OFF",
+};
+
 static const struct ad7768_clk_configuration ad7768_clk_config[] = {
 	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_8, 16,  AD7768_FAST_MODE },
 	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_16, 32,  AD7768_FAST_MODE },
@@ -133,12 +144,34 @@ static const struct ad7768_clk_configuration ad7768_clk_config[] = {
 	{ AD7768_MCLK_DIV_16, AD7768_DEC_RATE_1024, 16384, AD7768_ECO_MODE },
 };
 
+static int ad7768_get_vcm(struct iio_dev *dev, const struct iio_chan_spec *chan);
+static int ad7768_set_vcm(struct iio_dev *dev, const struct iio_chan_spec *chan,
+			  unsigned int mode);
+
+static const struct iio_enum ad7768_vcm_mode_enum = {
+	.items = ad7768_vcm_modes,
+	.num_items = ARRAY_SIZE(ad7768_vcm_modes),
+	.set = ad7768_set_vcm,
+	.get = ad7768_get_vcm,
+};
+
+static struct iio_chan_spec_ext_info ad7768_ext_info[] = {
+	IIO_ENUM("common_mode_voltage",
+		 IIO_SHARED_BY_ALL,
+		 &ad7768_vcm_mode_enum),
+	IIO_ENUM_AVAILABLE("common_mode_voltage",
+			   IIO_SHARED_BY_ALL,
+			   &ad7768_vcm_mode_enum),
+	{ },
+};
+
 static const struct iio_chan_spec ad7768_channels[] = {
 	{
 		.type = IIO_VOLTAGE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.ext_info = ad7768_ext_info,
 		.indexed = 1,
 		.channel = 0,
 		.scan_index = 0,
@@ -159,6 +192,7 @@ struct ad7768_state {
 	struct clk *mclk;
 	unsigned int mclk_freq;
 	unsigned int samp_freq;
+	unsigned int common_mode_voltage;
 	struct completion completion;
 	struct iio_trigger *trig;
 	struct gpio_desc *gpio_sync_in;
@@ -329,6 +363,28 @@ static int ad7768_set_freq(struct ad7768_state *st,
 	return 0;
 }
 
+static int ad7768_get_vcm(struct iio_dev *dev, const struct iio_chan_spec *chan)
+{
+	struct ad7768_state *st = iio_priv(dev);
+
+	return st->common_mode_voltage;
+}
+
+static int ad7768_set_vcm(struct iio_dev *dev,
+			  const struct iio_chan_spec *chan,
+			  unsigned int mode)
+{
+	int ret;
+	struct ad7768_state *st = iio_priv(dev);
+
+	ret = ad7768_spi_reg_write(st, AD7768_REG_ANALOG2, mode);
+
+	if (ret == 0)
+		st->common_mode_voltage = mode;
+
+	return ret;
+}
+
 static ssize_t ad7768_sampling_freq_avail(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
-- 
2.34.1


