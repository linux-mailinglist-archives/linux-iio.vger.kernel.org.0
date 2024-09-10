Return-Path: <linux-iio+bounces-9423-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3B697289F
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 06:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 194581C23AAF
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 04:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170AF17DFFD;
	Tue, 10 Sep 2024 04:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQZ8NwgX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6709917DE15;
	Tue, 10 Sep 2024 04:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943910; cv=none; b=Kz0NFahtz4mJsxz+EoqVALn05ChsxbZqbpJPA54YAdCqumSKp6IZ4W2E+46mWMf4G3rEMc3SMeevUPZrBNLV91r6hHrVXcDRi51Sh9cK6ll4vqjF8BalRaOrmPZVZ02aleNwVYpCj1u1LIR8ZTVC8UD2v4yLMKTu0X3pkfncRrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943910; c=relaxed/simple;
	bh=VOuv3djESEvw7P505CzZyiQP2j1nSX/lht7pwBok8vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HE7agSd+yar1fCKa24w7xK6R7ls+UKa5pTxNbf5WcpjgPHWZJkQv6W1MjLq8S1SN9/XG0GjkueLcnWrPF0HHBR14BQopoGibWH4ip4T1iTFnEJNQbGANMfAmpWk+2yQPL7MidVgcOOMbH3nDXa9TlnJZlqN6vVBH54vRMz0Ylbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQZ8NwgX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2055f630934so2961005ad.1;
        Mon, 09 Sep 2024 21:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725943908; x=1726548708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlOPJ/ylC24BWfeRWAwVgQ++41LRYuaxkLK4GT7ljqY=;
        b=NQZ8NwgXHAAYPncNCxTC/97wwg7HPJc3UBMCcUP5R8TvwRoSCujM6xBgSMgXneSbLj
         acxNxVaOF147vAyJut1WuCG8aVYOXQv0TDQkFlQ9n9O9r6qG40HDTuohbvbgvKNfC3KD
         BEgFwG17HxPgT+hnp3zGDMMD8ZZBg5pN6zDeUUz6e+NDMe/WCqhFGRgKmbmz06X3gC13
         opkuCVtZ1gGFN8POPRWjYIqFu7c5ajmUV4nHDTfnwf3/3sYyT865izQvo67irlwZp8t3
         JXugpzCA31tNEouz4rdsvzOqBTziD6zi0ZT0ECtYgnBjpZord5lJEZ6ya4Dr/zfpEbfF
         BGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725943908; x=1726548708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlOPJ/ylC24BWfeRWAwVgQ++41LRYuaxkLK4GT7ljqY=;
        b=oVxqW7XOysDkE8rmTO6n2OSQavN03boPJjW1mHexj8GCgV7c5GAeWn8USm0mWef/bC
         6sKhLXHWwCu4HnDq4lLbMmSeNEdlohyHyyDIE6S9ceZc3908g83Wi8NjAkSNqZ3ccUvo
         i5KeIgCMnV48EdMoghnXEXYY8p0ciGMIZ64GMKlJOUArKixaU+mUWI7SqDp03SKuvix2
         cbqzcpvengoCP69eaXehOc+wBVE4wQxakm+bYp5CoVuFrmAMiUgauwIsUolMdg1F95Nd
         vdo/PLqvho1XJEn8839GnN6YmIurha4kER1/rMoMSMh0DuXXAZgaTBoJBvcKaU7RDZB6
         f0xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaXqitris6FglxDBOFt7qOvJs1bZCbedtkdTzuxkrcOV80DEPXB0uAFdzi9bnIoZLfOvU/sOwnZ3ICWaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6/AQJws1i3Acy+cds693OZXMZ7zcHszTmi9yf2gEv2gZzM00a
	XIKZ0t2ohLwKsfcHDFqQ6TkEifGKGSM6Slbjf6m+7TGBQUCU/dG2aQW8rAkIjZE=
X-Google-Smtp-Source: AGHT+IHhKFspCEdi70+8WnP9gh8IIk4ATkEdd+pWTzRJ2UaZXQXSM8vtl9goJ154SuhXqDa1telKmQ==
X-Received: by 2002:a17:902:d4cd:b0:205:826e:6a13 with SMTP id d9443c01a7336-2070a816a6bmr114706035ad.54.1725943907470;
        Mon, 09 Sep 2024 21:51:47 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20710ee70a1sm40882965ad.121.2024.09.09.21.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 21:51:46 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v2 4/4] iio: light: ltr390: Add interrupt persistance support
Date: Tue, 10 Sep 2024 10:20:29 +0530
Message-ID: <20240910045030.266946-5-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910045030.266946-1-abhashkumarjha123@gmail.com>
References: <20240910045030.266946-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added support to configure the threshold interrupt persistance value by
providing IIO_EV_INFO_PERIOD attribute. The value written to the
attribute should be in miliseconds and should be greater than the
sampling rate of the sensor.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/ltr390.c | 66 +++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index 8a8a118ca..9706105c6 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -40,6 +40,7 @@
 #define LTR390_ALS_DATA			0x0D
 #define LTR390_UVS_DATA			0x10
 #define LTR390_INT_CFG			0x19
+#define LTR390_INT_PST			0x1A
 #define LTR390_THRESH_UP		0x21
 #define LTR390_THRESH_LOW		0x24
 
@@ -48,6 +49,8 @@
 #define LTR390_ALS_UVS_MEAS_RATE_MASK	0x07
 #define LTR390_ALS_UVS_INT_TIME_MASK	0x70
 #define LTR390_ALS_UVS_INT_TIME(x)	FIELD_PREP(LTR390_ALS_UVS_INT_TIME_MASK, (x))
+#define LTR390_INT_PST_MASK		0xF0
+#define LTR390_INT_PST_VAL(x)		FIELD_PREP(LTR390_INT_PST_MASK, (x))
 
 #define LTR390_SW_RESET	      BIT(4)
 #define LTR390_UVS_MODE	      BIT(3)
@@ -79,6 +82,11 @@ enum ltr390_mode {
 	LTR390_SET_UVS_MODE,
 };
 
+enum ltr390_meas_rate {
+	LTR390_GET_FREQ,
+	LTR390_GET_PERIOD,
+};
+
 struct ltr390_data {
 	struct regmap *regmap;
 	struct i2c_client *client;
@@ -156,7 +164,7 @@ static int ltr390_counts_per_uvi(struct ltr390_data *data)
 	return DIV_ROUND_CLOSEST(23 * data->gain * data->int_time_us, 10 * orig_gain * orig_int_time);
 }
 
-static int ltr390_get_samp_freq(struct ltr390_data *data)
+static int ltr390_get_samp_freq_or_period(struct ltr390_data *data, enum ltr390_meas_rate option)
 {
 	int ret, value;
 
@@ -165,7 +173,7 @@ static int ltr390_get_samp_freq(struct ltr390_data *data)
 		return ret;
 	value &= LTR390_ALS_UVS_MEAS_RATE_MASK;
 
-	return ltr390_samp_freq_table[value][0];
+	return ltr390_samp_freq_table[value][option];
 }
 
 static int ltr390_read_raw(struct iio_dev *iio_device,
@@ -225,7 +233,7 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = ltr390_get_samp_freq(data);
+		*val = ltr390_get_samp_freq_or_period(data, LTR390_GET_FREQ);
 		return IIO_VAL_INT;
 
 	default:
@@ -250,7 +258,8 @@ static const struct iio_event_spec ltr390_event_spec[] = {
 	}, {
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_EITHER,
-		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				BIT(IIO_EV_INFO_PERIOD),
 	}
 };
 
@@ -398,6 +407,44 @@ static int ltr390_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec cons
 	}
 }
 
+static int ltr390_read_intr_prst(struct ltr390_data *data, int *val)
+{
+	int ret, prst, samp_period;
+
+	samp_period = ltr390_get_samp_freq_or_period(data, LTR390_GET_PERIOD);
+	ret = regmap_read(data->regmap, LTR390_INT_PST, &prst);
+	if (ret < 0)
+		return ret;
+	*val = prst * samp_period;
+
+	return IIO_VAL_INT;
+}
+
+static int ltr390_write_intr_prst(struct ltr390_data *data, int val)
+{
+	int ret, samp_period, new_val;
+
+	samp_period = ltr390_get_samp_freq_or_period(data, LTR390_GET_PERIOD);
+
+	/* persist period should be greater than or equal to samp period */
+	if (val < samp_period)
+		return -EINVAL;
+
+	new_val = DIV_ROUND_UP(val, samp_period);
+	if (new_val < 0 || new_val > 0x0f)
+		return -EINVAL;
+
+	guard(mutex)(&data->lock);
+	ret = regmap_update_bits(data->regmap,
+				LTR390_INT_PST,
+				LTR390_INT_PST_MASK,
+				LTR390_INT_PST_VAL(new_val));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int ltr390_read_threshold(const struct iio_dev *indio_dev,
 				enum iio_event_direction dir,
 				int *val, int *val2)
@@ -458,6 +505,10 @@ static int ltr390_read_event_value(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
 		return ltr390_read_threshold(indio_dev, dir, val, val2);
+
+	case IIO_EV_INFO_PERIOD:
+		return ltr390_read_intr_prst(iio_priv(indio_dev), val);
+
 	default:
 		return -EINVAL;
 	}
@@ -476,6 +527,13 @@ static int ltr390_write_event_value(struct iio_dev *indio_dev,
 			return -EINVAL;
 
 		return ltr390_write_threshold(indio_dev, dir, val, val2);
+
+	case IIO_EV_INFO_PERIOD:
+		if (val2 != 0)
+			return -EINVAL;
+
+		return ltr390_write_intr_prst(iio_priv(indio_dev), val);
+
 	default:
 		return -EINVAL;
 	}
-- 
2.43.0


