Return-Path: <linux-iio+bounces-24444-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9907BA169F
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 22:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5FC91C029A1
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 20:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2674320CC1;
	Thu, 25 Sep 2025 20:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrRY3ZQY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C44A321F4C
	for <linux-iio@vger.kernel.org>; Thu, 25 Sep 2025 20:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758833175; cv=none; b=kB0NZgVmAo/ChkbmyEAHxUovWavGS0lAgh+3SLrWYksEOJ/LTZxGBMvAweLa10SBnOGkxKTjAsHdqAUUn21MShQcJNQRsFwozfh1K0iWW61dvVk6/aqIG53g3MJK2qzeMqhVm1iW98qKmCkBpfsUzbAM7r16E3k4qBQ4GIzYiNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758833175; c=relaxed/simple;
	bh=u/GRHoI6+QMWuN6Vgjvw8SAJW8N3epdnzemgpwb+gz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QyaW5N8/bWzqTNDi/QzB5aqSPJI/SO+7dlO0JnrWAFuyMjmD7ntC7TZDYrsI9IZOjsFWdLqbuKC5PMsR3/MMZLpOA8tecMG1A1WjvBUEWKXJVh1bXS3tFj4RByMUU/57YtMiSzvd4G5Dd2Rm86TzNz4rmPr4i6JeKc6EijfjCmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrRY3ZQY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46de78b595dso7765035e9.1
        for <linux-iio@vger.kernel.org>; Thu, 25 Sep 2025 13:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758833172; x=1759437972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zPbj99Jd6vk35LiQNF3EC6C/GileQTOnsmS8pZJrbM=;
        b=jrRY3ZQY3qs8MLajl0Iqw4igMD+QvppIhL69WcrMFDm7FYFhHy1h7slJdoAnraov06
         JhGWey76NxBG09129F3u7MQxieq56gdUj+UL39CapLY3SlkMv/TVYUMVndHcxTT4ljyh
         ySyjUKxk2kyWSrTPlq9CUDzmF89pknZ56UiUGhwHYYyMXwhIMFkCIGhyig4OSAJGLaOf
         N0652Akznx5NO1nKcofTkp8UuDxNGDeVmFjRvpL32zTlAZA+vRhlxw6UL+3yOnmf4REh
         iDHp6K2pxLJJuBRpx2OKGdPeOESrY8jbKb1CzcbobRE2h89TZ1VjcP+Brpl9NjtIwrP+
         /baA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758833172; x=1759437972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zPbj99Jd6vk35LiQNF3EC6C/GileQTOnsmS8pZJrbM=;
        b=OKb1QG8MgGRd4RCrWEDizP5FmXfpochTK/l9hHV8ARenAU9G5Y0S6AVbBZDhsSiNdP
         h/0aw+xLubrJPYgfnxuaUi0+BXeAgalGbhTR+Y/qkqMUKUQVAfwkOVregyBPFyy4w4Ng
         NMotXuH8g4BT7i4lbvmh92wvhUMpbrNrWhOXIUNDPBUFQRkHC1Jz3qaw0ZwQ8xoM8Ytu
         KfxmO4T0mufCTZTupe69GH6avhcE83+D6bph3ScSIqsUC0+Y+ZS0ulGnpmEIp/hmyCaD
         dWAwQuKz2JO+Qc4wQO+sd07APp2Ier9/XXaQzcELxH5JvegJ0k/NACnfUy5iifi99aRh
         aBEg==
X-Forwarded-Encrypted: i=1; AJvYcCUGzSOAY12+J9xWFC1eag8fFf0sTQz1EiDYfN7WU+Vx/1/JZYiBDruQnSLKRrZONr1fDjbAdHfZVdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPzzUJDs4UAN7pEfrcedT3glH47Ok4HgNYpEfaaRJdOEdOc2Dy
	HaLSNWJapWQOLTvUpz/RPZIXwyYpRoCgpJrHGLWPTCQJzB7mqhXIM2T9BvMMtyfl
X-Gm-Gg: ASbGncukZfWuu4XQK/pamGahEbRRd4BSyqbiACGASscEMwHbDcuLrwCGThtrpaRSeCl
	P6qGow6vugO3fPdI4vJofvk+d//w6B/NLPpBG3g6AaTHwD0Z4BaqdI8R7rv428+5hyBDbYiIwpZ
	w4OZA8ybeRy1ZjNj6aFo9T/zqvVyxti5rP51Bhhkk/AGMBtMzqCVUFiBMdIxIdkkrQ2TLnpHIYF
	BTry+v0blN4PIWjavcY6j6ahDjMJ478tKcwKp1brOKq5ozR25NKqhAv8R4/YkpxcHVJMVjE82mM
	zDPLCg7Ezy//9xdJcuhcRnVd+NcbFNeXiJI1nCLgpC9HVcxnkeNiFBkXlI7dwPeMf/kcWD59JMX
	rT0AGq8riP98yC0umBTTcmTGFxsJKh5TeVt5q7YE=
X-Google-Smtp-Source: AGHT+IEinpr7xThxxJ2V3S9ikl6fajqbnDTdglwGkk2yO6nzp2tfjtosXm54Fu/kSna8xTkM9qOt/A==
X-Received: by 2002:a5d:5d10:0:b0:401:c52f:62de with SMTP id ffacd0b85a97d-40e4486c1a4mr4024325f8f.12.1758833171707;
        Thu, 25 Sep 2025 13:46:11 -0700 (PDT)
Received: from localhost.localdomain ([78.209.201.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996bf1sm91201395e9.1.2025.09.25.13.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:46:11 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux@roeck-us.net,
	rodrigo.gobbi.7@gmail.com,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	grantpeltier93@gmail.com,
	farouk.bouabid@cherry.de,
	marcelo.schmitt1@gmail.com,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v2 4/4] iio: mpl3115: add support for sampling frequency
Date: Thu, 25 Sep 2025 22:45:38 +0200
Message-Id: <20250925204538.63723-5-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250925204538.63723-1-apokusinski01@gmail.com>
References: <20250925204538.63723-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When the device is in ACTIVE mode the temperature and pressure measurements
are collected with a frequency determined by the ST[3:0] bits of CTRL_REG2
register.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/iio/pressure/mpl3115.c | 81 ++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index 13c8b338a15e..b854732e61cb 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -30,6 +30,7 @@
 #define MPL3115_INT_SOURCE 0x12
 #define MPL3115_PT_DATA_CFG 0x13
 #define MPL3115_CTRL_REG1 0x26
+#define MPL3115_CTRL_REG2 0x27
 #define MPL3115_CTRL_REG3 0x28
 #define MPL3115_CTRL_REG4 0x29
 #define MPL3115_CTRL_REG5 0x2a
@@ -48,6 +49,8 @@
 #define MPL3115_CTRL1_ACTIVE BIT(0) /* continuous measurement */
 #define MPL3115_CTRL1_OS_258MS GENMASK(5, 4) /* 64x oversampling */
 
+#define MPL3115_CTRL2_ST GENMASK(3, 0)
+
 #define MPL3115_CTRL3_IPOL1 BIT(5)
 #define MPL3115_CTRL3_IPOL2 BIT(1)
 
@@ -57,6 +60,25 @@
 
 #define MPL3115_INT2 BIT(2) /* flag that indicates INT2 in use */
 
+static const unsigned int mpl3115_samp_freq_table[][2] = {
+	{ 1,      0},
+	{ 0, 500000},
+	{ 0, 250000},
+	{ 0, 125000},
+	{ 0,  62500},
+	{ 0,  31250},
+	{ 0,  15625},
+	{ 0,   7812},
+	{ 0,   3906},
+	{ 0,   1953},
+	{ 0,    976},
+	{ 0,    488},
+	{ 0,    244},
+	{ 0,    122},
+	{ 0,     61},
+	{ 0,     30},
+};
+
 struct mpl3115_data {
 	struct i2c_client *client;
 	struct iio_trigger *drdy_trig;
@@ -174,10 +196,61 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = i2c_smbus_read_byte_data(data->client, MPL3115_CTRL_REG2);
+		if (ret < 0)
+			return ret;
+
+		ret = FIELD_GET(MPL3115_CTRL2_ST, ret);
+
+		*val = mpl3115_samp_freq_table[ret][0];
+		*val2 = mpl3115_samp_freq_table[ret][1];
+		return IIO_VAL_INT_PLUS_MICRO;
 	}
 	return -EINVAL;
 }
 
+static int mpl3115_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	if (mask != IIO_CHAN_INFO_SAMP_FREQ)
+		return -EINVAL;
+
+	*type = IIO_VAL_INT_PLUS_MICRO;
+	*length = ARRAY_SIZE(mpl3115_samp_freq_table) * 2;
+	*vals = (int *)mpl3115_samp_freq_table;
+	return IIO_AVAIL_LIST;
+}
+
+static int mpl3115_write_raw(struct iio_dev *indio_dev,
+			     const struct iio_chan_spec *chan,
+			     int val, int val2, long mask)
+{
+	struct mpl3115_data *data = iio_priv(indio_dev);
+	int i, ret;
+
+	if (mask != IIO_CHAN_INFO_SAMP_FREQ)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(mpl3115_samp_freq_table); i++)
+		if (val == mpl3115_samp_freq_table[i][0] &&
+		    val2 == mpl3115_samp_freq_table[i][1])
+			break;
+
+	if (i == ARRAY_SIZE(mpl3115_samp_freq_table))
+		return -EINVAL;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG2,
+					FIELD_PREP(MPL3115_CTRL2_ST, i));
+	iio_device_release_direct(indio_dev);
+	return ret;
+}
+
 static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -229,6 +302,9 @@ static const struct iio_chan_spec mpl3115_channels[] = {
 		.type = IIO_PRESSURE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available =
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.scan_index = 0,
 		.scan_type = {
 			.sign = 'u',
@@ -242,6 +318,9 @@ static const struct iio_chan_spec mpl3115_channels[] = {
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available =
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.scan_index = 1,
 		.scan_type = {
 			.sign = 's',
@@ -312,6 +391,8 @@ static const struct iio_trigger_ops mpl3115_trigger_ops = {
 
 static const struct iio_info mpl3115_info = {
 	.read_raw = &mpl3115_read_raw,
+	.read_avail = &mpl3115_read_avail,
+	.write_raw = &mpl3115_write_raw,
 };
 
 static int mpl3115_trigger_probe(struct mpl3115_data *data,
-- 
2.25.1


