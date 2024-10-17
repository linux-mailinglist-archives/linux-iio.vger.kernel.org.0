Return-Path: <linux-iio+bounces-10682-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC949A2030
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 12:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2801F22395
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 10:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FB01DA2E0;
	Thu, 17 Oct 2024 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feAz8L81"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228151DB92E;
	Thu, 17 Oct 2024 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729161494; cv=none; b=HgcAHk+NnXiLEeXH8LN0OeJL+r8xL2jwHLyou+aJFf8iSqlW6Kffy/5zxy9Z1cTynEKkZhUmnJVTuRBrPbwuYZhmviBSVqGYfqVoiDNJ8K5hEMXiYVO+IMVp8rcqUOgbUo2edNvRwODUIOOsCQkdPALxCn2575MwIZsv3wWtHJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729161494; c=relaxed/simple;
	bh=E+GnRkyTSIOyO92KPoBLDhVtU+ZCAKCKHoc2KE53rpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NxWBqAmr0EW+hxgMe5tVONrTfc5LA4cnNpQY/oACgp7wNzru02itWvLieEmHGWFLUD/pAsf4HOc5MHGv+4owGj6H/qAhYXvIY+X15CxUiB+OXTSxIBB0avykJbXoe3tnwv7LRg6JQt7JtfZPhbO6X6BGeRw+2LTTOLuR5YTYg9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feAz8L81; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7cd85502a34so105192a12.2;
        Thu, 17 Oct 2024 03:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729161492; x=1729766292; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Dzn7U1LMeWWKebsUs2ti8S/ZJFlZN95+8Bxqtv15kg=;
        b=feAz8L81wdx059NJh3ZEaVIzIVBdJcDfZEG8Dlv6m3c+Sxk6UXGjDiWQfWMbnmVbk+
         GjW14AiYcele/dwPyj5Tx/VwTSfCt74PkEO5tjRwTxeDgFyER4uU5jnjGZQd7TP9abvc
         zJsm8cA/Ra3CkmDdZWa8i1QeIFjAWhcXNCqEfodm4TR24Hm1D5hvzJKkSELS1/IFt2id
         ZtcSdVy5ml7x5zEehJq3tekvdr0aRoRIeniVgSK5HOXwGtyNolb9k9J9k0Kmgojox1Wc
         TK7XjyuZybog9eqVA3yEaJr2gmCNp3QoUZ26AZg14mQvf+GE4+OdLtskS1z5ll2YpLvh
         2mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729161492; x=1729766292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Dzn7U1LMeWWKebsUs2ti8S/ZJFlZN95+8Bxqtv15kg=;
        b=SJAPKHA6FYer1rHlVOMuEXPD3nHLoFw6puHwf5Me/U/JuTnKJg9WAbhcVhoHfX8slX
         TSnLEIEykNrbgoR/vodgIQwFAQxDW0HPgWV/UvxTkbb7jiqDA9drcK0GJHlsdmSxJz2p
         XeTX4X/5Q/Xi4YzVwit+M4mM5ygHDInvhPsBNrOXo7zPcPGuTl1TRYFMdE4tPp2jCuZ5
         x3xNA1Uw2PXXvEvp9gTP4JKlE9P1EsbP0foeIvgLubh4xmxOjEV+UQbrH2FYoBTiPVkt
         /hkD7MpYkyallRbXFMrJEUz4yIbG5GrQAOH7N3ryK8ULfQBUTXq6NOuAPPdexmTpRzey
         /zIw==
X-Forwarded-Encrypted: i=1; AJvYcCVjtCnjmqKWNWESQ8/QuL9VllGmUf6MURPmIFI5rBZPM1v4mfT6T2OVOgZ68Ys8Xm/W2HnaJrM+RxPf@vger.kernel.org, AJvYcCWRo9gpWbtit6pByR7vo/y9xgmU7aZma4XN2q2xJGNazdwFdQ5drPtGSDZexdIrBD+wXIDXkpp93Ow904xz@vger.kernel.org
X-Gm-Message-State: AOJu0YyqXLtxUXIkdYIb4FC7SghXnyg9eqLW7Jc0rs3j1/MdFKL4zu9M
	27CgQ8ABgAXgjNmt8dmZYerMH896KgblRdof2Re6ieVq5yOSGKeB
X-Google-Smtp-Source: AGHT+IEFiNg0gL8u2EYIE2ipWU57P3dUlEE7LKHmCHNX1nqWZ4wzBN5dvqhWhkjh9lGFGtOh1OQrRg==
X-Received: by 2002:a17:902:e808:b0:20c:e2ff:4a4c with SMTP id d9443c01a7336-20d47e23517mr14561335ad.3.1729161492134;
        Thu, 17 Oct 2024 03:38:12 -0700 (PDT)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9d51esm41899025ad.104.2024.10.17.03.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 03:38:11 -0700 (PDT)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Thu, 17 Oct 2024 18:36:45 +0800
Subject: [PATCH v3 2/2] iio: proximity: hx9023s: Add performance tuning
 function
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-add-performance-tuning-configuration-v3-2-e7289791f523@gmail.com>
References: <20241017-add-performance-tuning-configuration-v3-0-e7289791f523@gmail.com>
In-Reply-To: <20241017-add-performance-tuning-configuration-v3-0-e7289791f523@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10193;
 i=yasin.lee.x@gmail.com; h=from:subject:message-id;
 bh=E+GnRkyTSIOyO92KPoBLDhVtU+ZCAKCKHoc2KE53rpQ=;
 b=owGbwMvMwCEYyfeRr6Zs90zG02pJDOkCL1knJOSycp4ut4hd2T1dqn1xwZSwc4yMftYCuik/c
 vVzpyV2lLIwCHIwyIopspx5/YY1X/XhnuDfrhkwc1iZQIYwcHEKwEQu/mdk2BG6N231uryEzlnX
 gv/MEsxZWfTnxeewqJtnt/BaeNusfMvIMFv4MEfNfuNJCx60XXle1GjmwiUWsfm/Uunh20UXiy4
 s1wUA
X-Developer-Key: i=yasin.lee.x@gmail.com; a=openpgp;
 fpr=CCEBEC056F25E1BC53FB4568590EF10E7C76BB99

When hardware design introduces significant sensor data noise,
performance can be improved by adjusting register settings.

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 234 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 234 insertions(+)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 8b9f84400e00..5d0338588616 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -61,6 +61,7 @@
 #define HX9023S_OFFSET_DAC4_9_8                0x1E
 #define HX9023S_SAMPLE_NUM_7_0                 0x1F
 #define HX9023S_INTEGRATION_NUM_7_0            0x21
+#define HX9023S_GLOBAL_CTRL2                   0x23
 #define HX9023S_CH_NUM_CFG                     0x24
 #define HX9023S_LP_ALP_4_CFG                   0x29
 #define HX9023S_LP_ALP_1_0_CFG                 0x2A
@@ -623,6 +624,235 @@ static int hx9023s_property_get(struct hx9023s_data *data)
 	return 0;
 }
 
+static int hx9023s_performance_tuning(struct hx9023s_data *data)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+	bool dither;
+	bool chop;
+	u32 odr;
+	u32 range[HX9023S_CH_NUM];
+	u32 avg[HX9023S_CH_NUM];
+	u32 osr[HX9023S_CH_NUM];
+	u32 sample_time;
+	u32 integration_time;
+	u32 lp_alpha[HX9023S_CH_NUM];
+	u32 bl_up_alpha[HX9023S_CH_NUM];
+	u32 bl_down_alpha[HX9023S_CH_NUM];
+	u32 drdy_interrput;
+	u32 int_high_num;
+	u32 int_low_num;
+	u32 temp;
+
+	/* dither */
+	dither = device_property_read_bool(dev, "tyhx,dither");
+	if (dither)
+		ret = regmap_update_bits(data->regmap, HX9023S_GLOBAL_CTRL0, BIT(6), BIT(6));
+	else
+		ret = regmap_update_bits(data->regmap, HX9023S_GLOBAL_CTRL0, BIT(6), 0);
+
+	/* chop */
+	chop = device_property_read_bool(dev, "tyhx,chop");
+	if (chop)
+		ret = regmap_update_bits(data->regmap, HX9023S_GLOBAL_CTRL2, GENMASK(4, 0),
+					GENMASK(4, 0));
+	else
+		ret = regmap_update_bits(data->regmap, HX9023S_GLOBAL_CTRL2, GENMASK(4, 0), 0);
+
+	/* odr */
+	ret = device_property_read_u32(dev, "tyhx,odr", &odr);
+	if (!ret) {
+		ret = regmap_update_bits(data->regmap, HX9023S_PRF_CFG, GENMASK(4, 0),
+					FIELD_PREP(GENMASK(4, 0), odr));
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to update odr\n");
+	}
+
+	/* range */
+	ret = device_property_read_u32_array(dev, "tyhx,range", range, ARRAY_SIZE(range));
+	if (!ret) {
+		temp = FIELD_PREP(GENMASK(2, 0), range[0]) | FIELD_PREP(GENMASK(6, 4), range[1]);
+		ret = regmap_update_bits(data->regmap, HX9023S_RANGE_7_0, GENMASK(6, 0), temp);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to update range for ch0 and ch1\n");
+
+		temp = FIELD_PREP(GENMASK(2, 0), range[2]) | FIELD_PREP(GENMASK(6, 4), range[3]);
+		ret = regmap_update_bits(data->regmap, HX9023S_RANGE_9_8, GENMASK(6, 0), temp);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to update range for ch2 and ch3\n");
+
+		temp = FIELD_PREP(GENMASK(2, 0), range[4]);
+		ret = regmap_update_bits(data->regmap, HX9023S_RANGE_18_16, GENMASK(2, 0), temp);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to update range for ch4\n");
+	}
+
+	/* avg */
+	ret = device_property_read_u32_array(dev, "tyhx,avg", avg, ARRAY_SIZE(avg));
+	if (!ret) {
+		temp = FIELD_PREP(GENMASK(7, 5), avg[0]);
+		ret = regmap_update_bits(data->regmap, HX9023S_AVG0_NOSR0_CFG, GENMASK(7, 5),
+					temp);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to update avg for ch0\n");
+
+		temp = FIELD_PREP(GENMASK(6, 4), avg[2]) | FIELD_PREP(GENMASK(2, 0), avg[1]);
+		ret = regmap_update_bits(data->regmap, HX9023S_AVG12_CFG, GENMASK(6, 0), temp);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to update avg for ch1 and ch2\n");
+
+		temp = FIELD_PREP(GENMASK(6, 4), avg[4]) | FIELD_PREP(GENMASK(2, 0), avg[3]);
+		ret = regmap_update_bits(data->regmap, HX9023S_AVG34_CFG, GENMASK(6, 0), temp);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to update avg for ch3 and ch4\n");
+	}
+
+	/* osr */
+	ret = device_property_read_u32_array(dev, "tyhx,osr", osr, ARRAY_SIZE(osr));
+	if (!ret) {
+		temp = FIELD_PREP(GENMASK(4, 2), osr[0]);
+		ret = regmap_update_bits(data->regmap, HX9023S_AVG0_NOSR0_CFG, GENMASK(4, 2),
+					temp);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to update osr for ch0\n");
+
+		temp = FIELD_PREP(GENMASK(6, 4), osr[2]) | FIELD_PREP(GENMASK(2, 0), osr[1]);
+		ret = regmap_update_bits(data->regmap, HX9023S_NOSR12_CFG, GENMASK(6, 0), temp);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to update osr for ch1 and ch2\n");
+
+		temp = FIELD_PREP(GENMASK(6, 4), osr[4]) | FIELD_PREP(GENMASK(2, 0), osr[3]);
+		ret = regmap_update_bits(data->regmap, HX9023S_NOSR34_CFG, GENMASK(6, 0), temp);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to update osr for ch3 and ch4\n");
+	}
+
+	/* sample time */
+	ret = device_property_read_u32(dev, "tyhx,sample-time", &sample_time);
+	if (!ret) {
+		ret = regmap_write(data->regmap, HX9023S_SAMPLE_NUM_7_0, sample_time);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to update sample_time\n");
+	}
+
+	/* integration time */
+	ret = device_property_read_u32(dev, "tyhx,integration-time", &integration_time);
+	if (!ret) {
+		ret = regmap_write(data->regmap, HX9023S_INTEGRATION_NUM_7_0, integration_time);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to update integration_time\n");
+	}
+
+	/* lp-alpha */
+	ret = device_property_read_u32_array(dev, "tyhx,lp-alpha", lp_alpha, ARRAY_SIZE(lp_alpha));
+	if (!ret) {
+		temp = FIELD_PREP(GENMASK(6, 4), lp_alpha[1])
+			| FIELD_PREP(GENMASK(2, 0), lp_alpha[0]);
+		ret = regmap_write(data->regmap, HX9023S_LP_ALP_1_0_CFG, temp);
+		if (ret)
+			return dev_err_probe(dev, ret,
+						"Failed to update lp-alpha for ch0 and ch1\n");
+
+		temp = FIELD_PREP(GENMASK(6, 4), lp_alpha[3])
+			| FIELD_PREP(GENMASK(2, 0), lp_alpha[2]);
+		ret = regmap_write(data->regmap, HX9023S_LP_ALP_3_2_CFG, temp);
+		if (ret)
+			return dev_err_probe(dev, ret,
+						"Failed to update lp-alpha for ch2 and ch3\n");
+
+		temp = FIELD_PREP(GENMASK(2, 0), lp_alpha[4]);
+		ret = regmap_update_bits(data->regmap, HX9023S_LP_ALP_4_CFG, GENMASK(2, 0), temp);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to update lp-alpha for ch4\n");
+	}
+
+	/* bl-up-alpha */
+	ret = device_property_read_u32_array(dev, "tyhx,bl-up-alpha",
+					bl_up_alpha, ARRAY_SIZE(bl_up_alpha));
+	if (!ret) {
+		temp = FIELD_PREP(GENMASK(7, 4), bl_up_alpha[1])
+			| FIELD_PREP(GENMASK(3, 0), bl_up_alpha[0]);
+		ret = regmap_write(data->regmap, HX9023S_UP_ALP_1_0_CFG, temp);
+		if (ret)
+			return dev_err_probe(dev, ret,
+						"Failed to update bl-up-alpha for ch0 and ch1\n");
+
+		temp = FIELD_PREP(GENMASK(7, 4), bl_up_alpha[3])
+			| FIELD_PREP(GENMASK(3, 0), bl_up_alpha[2]);
+		ret = regmap_write(data->regmap, HX9023S_UP_ALP_3_2_CFG, temp);
+		if (ret)
+			return dev_err_probe(dev, ret,
+						"Failed to update bl-up-alpha for ch2 and ch3\n");
+
+		temp = FIELD_PREP(GENMASK(3, 0), bl_up_alpha[4]);
+		ret = regmap_update_bits(data->regmap, HX9023S_DN_UP_ALP_0_4_CFG, GENMASK(3, 0),
+					temp);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to update bl-up-alpha for ch4\n");
+	}
+
+	/* bl-down-alpha */
+	ret = device_property_read_u32_array(dev, "tyhx,bl-down-alpha",
+					bl_down_alpha, ARRAY_SIZE(bl_down_alpha));
+	if (!ret) {
+		temp = FIELD_PREP(GENMASK(7, 4), bl_down_alpha[0]);
+		ret = regmap_update_bits(data->regmap, HX9023S_DN_UP_ALP_0_4_CFG, GENMASK(7, 4),
+					temp);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to update bl-dn-alpha for ch0\n");
+
+		temp = FIELD_PREP(GENMASK(7, 4), bl_down_alpha[2])
+			| FIELD_PREP(GENMASK(3, 0), bl_down_alpha[1]);
+		ret = regmap_write(data->regmap, HX9023S_DN_ALP_2_1_CFG, temp);
+		if (ret)
+			return dev_err_probe(dev, ret,
+						"Failed to update bl-dn-alpha for ch1 and ch2\n");
+
+		temp = FIELD_PREP(GENMASK(7, 4), bl_down_alpha[4])
+			| FIELD_PREP(GENMASK(3, 0), bl_down_alpha[3]);
+		ret = regmap_write(data->regmap, HX9023S_DN_ALP_4_3_CFG, temp);
+		if (ret)
+			return dev_err_probe(dev, ret,
+						"Failed to update bl-dn-alpha for ch3 and ch4\n");
+	}
+
+	/* dydy-interrupt */
+	ret = device_property_read_u32(dev, "tyhx,drdy-interrupt", &drdy_interrput);
+	if (!ret) {
+		ret = regmap_update_bits(data->regmap, HX9023S_CALI_DIFF_CFG, GENMASK(7, 4),
+					FIELD_PREP(GENMASK(7, 4), drdy_interrput));
+		if (ret)
+			return dev_err_probe(dev, ret,
+						"Failed to update drdy-interrput for ch0~ch3\n");
+
+		ret = regmap_update_bits(data->regmap, HX9023S_DITHER_CFG, BIT(7),
+					FIELD_PREP(BIT(7), drdy_interrput >> 4));
+		if (ret)
+			return dev_err_probe(dev, ret,
+						"Failed to update drdy-interrput for ch4\n");
+	}
+
+	/* int-high-num */
+	ret = device_property_read_u32(dev, "tyhx,int-high-num", &int_high_num);
+	if (!ret) {
+		ret = regmap_update_bits(data->regmap, HX9023S_PROX_INT_HIGH_CFG, GENMASK(3, 0),
+					FIELD_PREP(GENMASK(3, 0), int_high_num));
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to update int-high-num\n");
+	}
+
+	/* int-low-num */
+	ret = device_property_read_u32(dev, "tyhx,int-low-num", &int_low_num);
+	if (!ret) {
+		ret = regmap_update_bits(data->regmap, HX9023S_PROX_INT_LOW_CFG, GENMASK(3, 0),
+					FIELD_PREP(GENMASK(3, 0), int_low_num));
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to update int-low-num\n");
+	}
+
+	return 0;
+}
+
 static int hx9023s_update_chan_en(struct hx9023s_data *data,
 				  unsigned long chan_read,
 				  unsigned long chan_event)
@@ -1045,6 +1275,10 @@ static int hx9023s_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(dev, ret, "channel config failed\n");
 
+	ret = hx9023s_performance_tuning(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "performance tuning failed\n");
+
 	ret = regcache_sync(data->regmap);
 	if (ret)
 		return dev_err_probe(dev, ret, "regcache sync failed\n");

-- 
2.43.0


