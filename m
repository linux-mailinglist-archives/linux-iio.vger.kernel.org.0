Return-Path: <linux-iio+bounces-18748-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CB1A9E6C8
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 05:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC19F3B8ACE
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 03:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CBB155725;
	Mon, 28 Apr 2025 03:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0312Omj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0424431
	for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 03:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745811830; cv=none; b=QjYTd4lWlfXKGqEhXEcUb9hGqhO8l/ooDSJ9kNfXSxWJsD1iMWYOiNBW8ohbwcJ7Wp5fuEhzGoAIXCjwzyvf9tEHzmoT3ul8+yeoa/WThfOpN0DIsFExbFDiCPuLLapXDjDWilP7MeIpU15Nth6Go2uhZZXMz7R6XF1ulXhtW3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745811830; c=relaxed/simple;
	bh=WbBTqAmPd1TCqo0a0QLtNiDiKduoudoC0GBaUr2IHH0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J6RdN5oN/L3dJtkoVZv584PzlHl9f4R4Y9f8wK72Au8lehYeL3W7UFx9e9tkKuBpfUZxsF5bkL/q4z4eNAEoTxgRHaALxdx14UD+kI09WNodoNSXlg67IJ69vvwBDhWVE0ctdCYADTF2yEAjfob9TKhv9Tmc1PBXQp9i4eapRBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0312Omj; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5f6f3f2af91so544536a12.2
        for <linux-iio@vger.kernel.org>; Sun, 27 Apr 2025 20:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745811826; x=1746416626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qGzp6ZU2kGqrljcpQVrXsb8tqkvs1zg1VeY4ORptDi0=;
        b=B0312Omjc35NTwVxKUM9rs6ioToHOAQGDpy6Z1J2h6nFLEn2PUtInBb3G92/ceYB9G
         Y9W5ddcXn09DzL0P7FfUlzE2qgRb6qs0l1kh3wbldKHFgpZtHw65Odcj4r5Wy6ZVVtkq
         jCElIODD1peEV+nfG3jBIto9kqWsZ9e7CufIhmFm6/zy2r0xR9TvVrdstEadPnBeX4UX
         e9xdanzyHNoMz5E+aF4ySPswRysy2Xr/PwG80kK3wIxy5IMyB+mKW1rhuL1JS/fyQjRG
         yCfAB1V9M0LoKAPr9pdM/GzeDFgLkV9PCHFZRlD45qGY9/JbCJ0GFwQs7DZlRIepednZ
         KnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745811826; x=1746416626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGzp6ZU2kGqrljcpQVrXsb8tqkvs1zg1VeY4ORptDi0=;
        b=NG2SOGpDydVYUoD/e8L2+JErNOHS0L4HUNjP0hNZBLP9oL69y1gDVhfTwgv7klXENo
         UgjTZaogJVdlJFEBAM+AL8p6IAGasTD7/q6iLiWifd1i4AYxlHNiR5Vnd6lrVe2oF8Sk
         Vyh1xr8+HoY+bojrxu6Xwtlu2oFY1zXNQwTwzAMDZ2Hk4HQ5rfYT1li3etXDiWc+mHlb
         svzQzRsqw+VB7hfkcAk6al/I+dOiFe/SIayt7G64jCnW0n6CCXdftLVZWeCz/QzC8Pru
         N0TAWIw31ndPelf6sf+Js0ZZc/E3TxFSAHfysVoX5Te/VVB+C3PQ+WR4ED35cCUBEuJR
         DTWg==
X-Forwarded-Encrypted: i=1; AJvYcCUV8mBJOPqb2Fz798dySnAdxsMZoViis59TuthrcUERZgU87WRSyTC0sHwyhTARpTvvNauqONkZrJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKn14qotJ7YiO8HepGFLJbkwvDhyrNGs6oRpfGAWGthcimCcXw
	CMy+UaFBvdOtiK3IKQ69gHDt/1iTiqa2YvnkpNExETk/CVXB2F1c
X-Gm-Gg: ASbGncsiQWF8RKUJKReHxVcdPPX9CC6HuFnGA4PfR7Hl94QdNCzRrSLgE48sSZLusBG
	DzgSFWDNaNaewy4Nx1Fu/JhkqqOj07CoH4nxxBTL49fmrAnJC4NqMkWqwzwThNHqgY9dDm6H5pQ
	j3+1xgc/xM3SlFntxYdH1xXHNhzmxtSHlyYjX0Ua3ZfPgLUiocNkOwWEtA9knHcWfvJAQKgDd/5
	shRwysdO0pydcBU9nhZev3eb9p0jJcoPGrd3/NbNI8Y0ULafAcrBoMl0bh8qf2Q5Ogh2rhEDSSW
	OUOgv5sDLdfMISf+UwqKT+vWVb9IzKyXSMLGEkoo6Pg/7XWPqDY3BUPPNrT9JYuyMpA3SqVInnh
	SPDFyxeg8GXoGstu+OvKvsCBN+9UXz8PFR3qK61NElg==
X-Google-Smtp-Source: AGHT+IGtHSuQwlNqRsXEmZH9nSJVBY9V1WPcp2WQt9ZbgeE5zW4BeX2v9KRwfV3LN5UyI5UgNhnelA==
X-Received: by 2002:a05:6402:2755:b0:5f4:35c7:ff65 with SMTP id 4fb4d7f45d1cf-5f7226908bfmr2989389a12.4.1745811826184;
        Sun, 27 Apr 2025 20:43:46 -0700 (PDT)
Received: from vmi2506601.contaboserver.net (vmi2506601.contaboserver.net. [161.97.103.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7016f666fsm5212015a12.45.2025.04.27.20.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 20:43:45 -0700 (PDT)
From: Gabriel Geraldino <gabrielgeraldinosouza@gmail.com>
To: jic23@kernel.org,
	orsonzhai@gmail.com,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: gabrielgeraldinosouza@gmail.com,
	Nicolas Borsari <nicborsari@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: sc27xx: Refactor sc27xx_adc_scale_init to reduce duplication
Date: Mon, 28 Apr 2025 05:42:22 +0200
Message-Id: <20250428034222.318898-1-gabrielgeraldinosouza@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the sc27xx_adc_scale_init() function by refactoring scale ratio
initialization logic for SC2720, SC2730, and SC2731 PMICs. This removes
code duplication by using a data structure to represent channel/scale
mapping.

This change improves readability and maintainability without changing
functional behavior.

Signed-off-by: Gabriel Geraldino <gabrielgeraldinosouza@gmail.com>
Co-developed-by: Nicolas Borsari <nicborsari@usp.br>
Signed-off-by: Nicolas Borsari <nicborsari@usp.br>
---
 drivers/iio/adc/sc27xx_adc.c | 90 +++++++++++++-----------------------
 1 file changed, 32 insertions(+), 58 deletions(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index 2535c2c3e..a8312859d 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -407,78 +407,52 @@ static int sc2731_adc_get_ratio(int channel, int scale)
 /*
  * According to the datasheet set specific value on some channel.
  */
+struct adc_channel_scale {
+	int channel;
+	int scale;
+};
+
+static void sc27xx_adc_scale_init(struct sc27xx_adc_data *data,
+	const struct adc_channel_scale *table,
+	int table_len,
+	int default_scale)
+{
+	int j;
+
+	for (j = 0; j < sizeof(data->channel_scale); j++)
+		data->channel_scale[j] = default_scale;
+
+	for (j = 0; j < table_len; j++)
+		data->channel_scale[table[j].channel] = table[j].scale;
+}
+
 static void sc2720_adc_scale_init(struct sc27xx_adc_data *data)
 {
-	int i;
-
-	for (i = 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
-		switch (i) {
-		case 5:
-			data->channel_scale[i] = 3;
-			break;
-		case 7:
-		case 9:
-			data->channel_scale[i] = 2;
-			break;
-		case 13:
-			data->channel_scale[i] = 1;
-			break;
-		case 19:
-		case 30:
-		case 31:
-			data->channel_scale[i] = 3;
-			break;
-		default:
-			data->channel_scale[i] = 0;
-			break;
-		}
-	}
+	static const struct adc_channel_scale sc2720_table[] = {
+		{5, 3}, {7, 2}, {9, 2}, {13, 1}, {19, 3}, {30, 3}, {31, 3}
+	};
+	sc27xx_adc_scale_init(data, sc2720_table, ARRAY_SIZE(sc2720_table), 0);
 }
 
 static void sc2730_adc_scale_init(struct sc27xx_adc_data *data)
 {
-	int i;
-
-	for (i = 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
-		switch (i) {
-		case 5:
-		case 10:
-		case 19:
-		case 30:
-		case 31:
-			data->channel_scale[i] = 3;
-			break;
-		case 7:
-		case 9:
-			data->channel_scale[i] = 2;
-			break;
-		case 13:
-			data->channel_scale[i] = 1;
-			break;
-		default:
-			data->channel_scale[i] = 0;
-			break;
-		}
-	}
+	static const struct adc_channel_scale sc2730_table[] = {
+		{5, 3}, {10, 3}, {19, 3}, {30, 3}, {31, 3},
+		{7, 2}, {9, 2}, {13, 1}
+	};
+	sc27xx_adc_scale_init(data, sc2730_table, ARRAY_SIZE(sc2730_table), 0);
 }
 
 static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
 {
-	int i;
 	/*
 	 * In the current software design, SC2731 support 2 scales,
 	 * channels 5 uses big scale, others use smale.
 	 */
-	for (i = 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
-		switch (i) {
-		case 5:
-			data->channel_scale[i] = 1;
-			break;
-		default:
-			data->channel_scale[i] = 0;
-			break;
-		}
-	}
+	static const struct adc_channel_scale sc2731_table[] = {
+		{5, 1}
+	};
+	sc27xx_adc_scale_init(data, sc2731_table, ARRAY_SIZE(sc2731_table), 0);
 }
 
 static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
-- 
2.39.5


