Return-Path: <linux-iio+bounces-9378-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2083A97156E
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 12:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89AD01F23BC5
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 10:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731351B4C5F;
	Mon,  9 Sep 2024 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKN809dq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7C65733A;
	Mon,  9 Sep 2024 10:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725878242; cv=none; b=gX0RLVHVvqBC5IDUKLG+PjAqNFn+oLJPok/6XnqCd2mIu5uAeTh/D4/gyApGyazsQIShXwBC4MsSKg1TJieNPwHKUovXggpKetsUnLummFiPbcV59dUUbVLNzKh7OwChU4aSffgWXFmRZVVSC3WYBZWaw8PuMzl4aa4TOY93pvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725878242; c=relaxed/simple;
	bh=skbp0YrM2RADqkbI/Z5Qxcn6D38PFT221Jr/tgf3w/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxRtom8SFZdhjl3CKav7uXw7KgNnM24HPTDgJpGczwpxlJjX86cW4nP3xPjDkVtv5B1kMusR9gbITfNnPY/8SD+274yBGhIKldaV0LYz0okKM1jzpqSEJI72ai6SWqJEPLkRbK75j2Hp5nmRLrY8UK9oZz//VoabBUFK0EadQvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKN809dq; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-710da168ea0so1251972a34.0;
        Mon, 09 Sep 2024 03:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725878239; x=1726483039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJtcIGVTfhzjKM3GKhKbnrLKBv2BYLTrCHHS5t8BPkM=;
        b=UKN809dqLDejSjyAWzsbrK2pxvzbN2E8gvZv6O80QoH+pcNxdWLH3JBy8lxVxblda8
         CRpWkYKwqeGCQhR+UtHB3etJe9CpVma7CDDFvqi4SvePMGMD8SY39009FB7qDAkgBXvY
         LSYxMjCdywVYHWOo60BJFw3ztrKWTGpoYCv/xYMR008Ic7+eHsd5ZFxXfTDqRy1P1iok
         mJlj7g0v7PQrKUz78vOkWcINHdZoIzkY4eUVmwaOBTwvhT8i1lA50qFC57iBfPIHDxzH
         qIqzGfKHNwHNok7xUoWEpkuJmHCKVmvxv60XhBlcDrktqVizXUNam1Ge6UgZAfWKbnHs
         GHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725878239; x=1726483039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJtcIGVTfhzjKM3GKhKbnrLKBv2BYLTrCHHS5t8BPkM=;
        b=hnAK+TusQVlMDnIpEQAVPfDCa/eDJwT3MNghYlEDV8fF+tUNWmoNCvI8l20RujFL4D
         SJkkwrDFtGyd1rRlQ7hxkoQ1+ezX4sQU90lyaGCExIhLoDBht55A2VY1PmGUN8Chb2FO
         x0518aId4tySPfB7bfPuXttR0lBecYJ+9Z6NXcQ0XJQoDxHk9Hwfovxw07xFol7qPuqP
         H92KK1xwukmBRdME4raEzSV3rAVbqzpsXbz9Q6vF/itt5moGxevA5eUWXHQgQSfz3Nic
         BII25FEyCpDfcEERHpX8jfZC6cHFvQB/Oi1Ag0Np0aeBLNrMif46ZQeMVIm6fYToIWfx
         FfLg==
X-Forwarded-Encrypted: i=1; AJvYcCUalMKCWSGXiSAkeYx1y4mivaWpa6YnGdBOYhDdmrmmJnkJIiUGCgwMuXXBZTr9T4ivoLlPFmHb0c0o5P0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSdoswKmQfo447749FkSk92rcMIop8qUOdx++uwORSYQpI0/jC
	rM7wc41Sq1rLe65gg1pCx1pCxpOvFyEizPOhovti1ind/xiF9b2G4hyZUY4RhEw=
X-Google-Smtp-Source: AGHT+IG0oQmaGBjgLMpWGuse9NYxwzolnohkDmZnYJsa6vb5JeaSj1RlMwm7IIjUMUbSVAS0OboOUw==
X-Received: by 2002:a05:6830:3148:b0:703:783a:dad5 with SMTP id 46e09a7af769-710cc26e969mr9072989a34.27.1725878238708;
        Mon, 09 Sep 2024 03:37:18 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-718e5897b3fsm3258032b3a.25.2024.09.09.03.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 03:37:17 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH 1/4] iio: light: ltr390: Added configurable sampling frequency support
Date: Mon,  9 Sep 2024 16:06:20 +0530
Message-ID: <20240909103623.264113-2-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909103623.264113-1-abhashkumarjha123@gmail.com>
References: <20240909103623.264113-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provied configurable sampling frequency(Measurement rate) support.
Also exposed the available sampling frequency values using read_avail
callback.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/ltr390.c | 68 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index 7e58b50f3..73ef4a5a0 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -39,6 +39,7 @@
 
 #define LTR390_PART_NUMBER_ID		0xb
 #define LTR390_ALS_UVS_GAIN_MASK	0x07
+#define LTR390_ALS_UVS_MEAS_RATE_MASK	0x07
 #define LTR390_ALS_UVS_INT_TIME_MASK	0x70
 #define LTR390_ALS_UVS_INT_TIME(x)	FIELD_PREP(LTR390_ALS_UVS_INT_TIME_MASK, (x))
 
@@ -87,6 +88,18 @@ static const struct regmap_config ltr390_regmap_config = {
 	.val_bits = 8,
 };
 
+/* Sampling frequency is in mili Hz and mili Seconds */
+static const int ltr390_samp_freq_table[][2] = {
+		[0] = {40000, 25},
+		[1] = {20000, 50},
+		[2] = {10000, 100},
+		[3] = {5000, 200},
+		[4] = {2000, 500},
+		[5] = {1000, 1000},
+		[6] = {500, 2000},
+		[7] = {500, 2000}
+};
+
 static int ltr390_register_read(struct ltr390_data *data, u8 register_address)
 {
 	struct device *dev = &data->client->dev;
@@ -135,6 +148,18 @@ static int ltr390_counts_per_uvi(struct ltr390_data *data)
 	return DIV_ROUND_CLOSEST(23 * data->gain * data->int_time_us, 10 * orig_gain * orig_int_time);
 }
 
+static int ltr390_get_samp_freq(struct ltr390_data *data)
+{
+	int ret, value;
+
+	ret = regmap_read(data->regmap, LTR390_ALS_UVS_MEAS_RATE, &value);
+	if (ret < 0)
+		return ret;
+	value &= LTR390_ALS_UVS_MEAS_RATE_MASK;
+
+	return ltr390_samp_freq_table[value][0];
+}
+
 static int ltr390_read_raw(struct iio_dev *iio_device,
 			   struct iio_chan_spec const *chan, int *val,
 			   int *val2, long mask)
@@ -191,6 +216,10 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 		*val = data->int_time_us;
 		return IIO_VAL_INT;
 
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = ltr390_get_samp_freq(data);
+		return IIO_VAL_INT;
+
 	default:
 		return -EINVAL;
 	}
@@ -199,6 +228,7 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 /* integration time in us */
 static const int ltr390_int_time_map_us[] = { 400000, 200000, 100000, 50000, 25000, 12500 };
 static const int ltr390_gain_map[] = { 1, 3, 6, 9, 18 };
+static const int ltr390_freq_map[] = { 40000, 20000, 10000, 5000, 2000, 1000, 500, 500 };
 
 static const struct iio_chan_spec ltr390_channels[] = {
 	/* UV sensor */
@@ -206,16 +236,18 @@ static const struct iio_chan_spec ltr390_channels[] = {
 		.type = IIO_UVINDEX,
 		.scan_index = 0,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
+						| BIT(IIO_CHAN_INFO_SAMP_FREQ)
 	},
 	/* ALS sensor */
 	{
 		.type = IIO_LIGHT,
 		.scan_index = 1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
+						| BIT(IIO_CHAN_INFO_SAMP_FREQ)
 	},
 };
 
@@ -264,6 +296,27 @@ static int ltr390_set_int_time(struct ltr390_data *data, int val)
 	return -EINVAL;
 }
 
+static int ltr390_set_samp_freq(struct ltr390_data *data, int val)
+{
+	int ret, idx;
+
+	for (idx = 0; idx < ARRAY_SIZE(ltr390_samp_freq_table); idx++) {
+		if (ltr390_samp_freq_table[idx][0] != val)
+			continue;
+
+		guard(mutex)(&data->lock);
+		ret = regmap_update_bits(data->regmap,
+					LTR390_ALS_UVS_MEAS_RATE,
+					LTR390_ALS_UVS_MEAS_RATE_MASK, idx);
+		if (ret)
+			return ret;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static int ltr390_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
 				const int **vals, int *type, int *length, long mask)
 {
@@ -278,6 +331,11 @@ static int ltr390_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec con
 		*type = IIO_VAL_INT;
 		*vals = ltr390_int_time_map_us;
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*length = ARRAY_SIZE(ltr390_freq_map);
+		*type = IIO_VAL_INT;
+		*vals = ltr390_freq_map;
+		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
 	}
@@ -301,6 +359,12 @@ static int ltr390_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec cons
 
 		return ltr390_set_int_time(data, val);
 
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val2 != 0)
+			return -EINVAL;
+
+		return ltr390_set_samp_freq(data, val);
+
 	default:
 		return -EINVAL;
 	}
-- 
2.43.0


