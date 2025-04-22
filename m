Return-Path: <linux-iio+bounces-18495-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AA6A96377
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 11:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E62B164B5F
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 08:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5475253F3F;
	Tue, 22 Apr 2025 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OAKwebQs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FBB25486B;
	Tue, 22 Apr 2025 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745312170; cv=none; b=LqOahOU4ew5RxQwfqbMd/NAYovtGERRPnJ87E3lpsCJE5EYik0BBzqviSzR8aTrPeDkplH14q4GQ4VsqLB9FTT3qeG8RcQYJNFYHDBDnWbBWuSbpD++RT0rm3Phzpx3sB/1bZhKruPPkb2RuLNlczEgHBRMJgy/t+EiQNmtyRcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745312170; c=relaxed/simple;
	bh=47Fl3alaoy9MJ9oE1dW53liNawNp3fX4xzOoCfOY3nk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVAyjW6UE1+/UEnRddd3Zlf8k+iyEB983dFFjVkLC+J7C1KTeWHHktzacwbfay/2tffUFgO3JA0ECqHQ0bUqTw/WXlmAbLJIoTs+1jF/roXyLLLXSJjMEflxbsFktNpnQdPCyrdfrhtfNtTlowVF+t80DOQYZLQig3vxQHV4J1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OAKwebQs; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M7ciGP026127;
	Tue, 22 Apr 2025 04:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=yOySj
	TPHGjn1zF8roB5u3h3nRAAWfkKlV1XNNw9xY9E=; b=OAKwebQsZbJ306GUrWQOj
	z/+P5KxV3iJBlE82ZE05sZTLv+ymxwplB48VY/zLgT9a7xpPy71e++nQVLwN7JH0
	DjycVaWRP9DDILYs3uTglRa5TiOVWsFVhR3z4wHOcSipH8RCOyn9HLTwxFBRG5HG
	z7O4sKciu6vlYqGNyvBx/vYW5oZl6ieFk/9JpgbnBz8wAGlvipqsMTEVMqvbELYw
	7zOSK7XB9esgvmWn+98oYw+t/ImX/emgrB71YRwBTVlXzrWr8mAH5meS9Mp147Rc
	uGePfZ6u1rWyrDFSYRmHeK1zG1KeGW9zFf3DyznaD4Iw+guTiG4K56inFrbWCDBs
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4648r6du0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 04:56:02 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53M8tsba041701
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 22 Apr 2025 04:55:54 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 22 Apr
 2025 04:55:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 22 Apr 2025 04:55:54 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.211])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53M8tjRX016347;
	Tue, 22 Apr 2025 04:55:51 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 2/2] iio: dac: ad7293: add adc reference configuration
Date: Tue, 22 Apr 2025 11:55:29 +0300
Message-ID: <20250422085529.4407-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422085529.4407-1-antoniu.miclaus@analog.com>
References: <20250422085529.4407-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: JarI4uqTEJxw_srIHaV9N1_Rxgb0aSwl
X-Proofpoint-ORIG-GUID: JarI4uqTEJxw_srIHaV9N1_Rxgb0aSwl
X-Authority-Analysis: v=2.4 cv=d6z1yQjE c=1 sm=1 tr=0 ts=680759a5 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=kyzOxrww9Jkk1N5gqB0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_04,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504220066

Add support for configurating the ADC reference (internal/external).

According to the datasheet, the external reference is enabled by
default.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/dac/ad7293.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/dac/ad7293.c b/drivers/iio/dac/ad7293.c
index 99fa2d1f8299..c3797e40cdd9 100644
--- a/drivers/iio/dac/ad7293.c
+++ b/drivers/iio/dac/ad7293.c
@@ -114,6 +114,7 @@
 #define AD7293_REG_DATA_RAW_MSK			GENMASK(15, 4)
 #define AD7293_REG_VINX_RANGE_GET_CH_MSK(x, ch)	(((x) >> (ch)) & 0x1)
 #define AD7293_REG_VINX_RANGE_SET_CH_MSK(x, ch)	(((x) & 0x1) << (ch))
+#define AD7293_GENERAL_ADC_REF_MSK			BIT(7)
 #define AD7293_CHIP_ID				0x18
 
 enum ad7293_ch_type {
@@ -141,6 +142,7 @@ struct ad7293_state {
 	/* Protect against concurrent accesses to the device, page selection and data content */
 	struct mutex lock;
 	struct gpio_desc *gpio_reset;
+	bool vrefin_en;
 	u8 page_select;
 	u8 data[3] __aligned(IIO_DMA_MINALIGN);
 };
@@ -785,6 +787,12 @@ static int ad7293_properties_parse(struct ad7293_state *st)
 	if (ret)
 		return dev_err_probe(&spi->dev, ret, "failed to enable VDRIVE\n");
 
+	ret = devm_regulator_get_enable_optional(&spi->dev, "vrefin");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(&spi->dev, ret, "failed to enable VREFIN\n");
+
+	st->vrefin_en = ret != -ENODEV;
+
 	st->gpio_reset = devm_gpiod_get_optional(&st->spi->dev, "reset",
 						 GPIOD_OUT_HIGH);
 	if (IS_ERR(st->gpio_reset))
@@ -818,6 +826,11 @@ static int ad7293_init(struct ad7293_state *st)
 		return -EINVAL;
 	}
 
+	if (!st->vrefin_en)
+		return __ad7293_spi_update_bits(st, AD7293_REG_GENERAL,
+						AD7293_GENERAL_ADC_REF_MSK,
+						AD7293_GENERAL_ADC_REF_MSK);
+
 	return 0;
 }
 
-- 
2.49.0


