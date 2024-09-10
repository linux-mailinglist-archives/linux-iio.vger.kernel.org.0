Return-Path: <linux-iio+bounces-9420-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 981B197289A
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 06:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03313B23C50
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 04:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DC316DEA7;
	Tue, 10 Sep 2024 04:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxpLCBs2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4451684A6;
	Tue, 10 Sep 2024 04:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943900; cv=none; b=GwcuXwax2r8F/HQ1jpAVKmXd0oh78KkeBhMkxORkuez9zbqKEKujOUz9Tl8xB1u8SxvN8z5Kt11nJchrGVx1qa+zXkDrbVe2ytTH7DnOY6E3r/t5Dhc1Q4VmXdjMV9X3z4F4dyilB5+dOWT1d9VAgA0H3/8CSrFATWV7SvKKHW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943900; c=relaxed/simple;
	bh=skbp0YrM2RADqkbI/Z5Qxcn6D38PFT221Jr/tgf3w/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXeDza0NLoc2TQ4M/4AXu6eRCpkAxUIomQDKb3LyZ3OkoapzJ9+v+qFacR4M0o0khmCy97xIzI/fkCejeuRBTrFcSpUY4zJRZ7Abeb4mIhLUEVi/SCitKTBIdtMiIiVqq6Eu+UuxnYjTpWrhUDJLBRuuS5Hy+v+z1AEmnLQwmFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxpLCBs2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2059112f0a7so46848035ad.3;
        Mon, 09 Sep 2024 21:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725943898; x=1726548698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJtcIGVTfhzjKM3GKhKbnrLKBv2BYLTrCHHS5t8BPkM=;
        b=TxpLCBs20l276nOwpdxSq+lCZtha16EYSERnu4+XhPfUYKixPJpminwj3jhI8lKypo
         WWxDDb4BFxcvNCw9X2ayep45sNfa9D5wMLiamUkfhEugOxJt7qeKJvAf03ChzqAw6T+0
         rxN2mxAuxsgHz47KIWc37Qmve1ugAarlAV6Xr/fTeDrPWS64kZFnZhMetg4rkkRX1SbS
         BqYCY7kiZQaJAClZ+KtDNkDcSEfQcCVZ4kCq+XRvuyTIhcgd7/PRzn19F/V9evQ5lThz
         PNs2b9mY9D8h465DslAAt0dDR8tziQxRB68JNBVo3eXj1Dl7YuImhkATfgfRYeIuJBSc
         sWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725943898; x=1726548698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJtcIGVTfhzjKM3GKhKbnrLKBv2BYLTrCHHS5t8BPkM=;
        b=R7ecXprkPDkKyHL4tf+r5GqaY9vlMlwZj+clFo6WXLAhuHmUCEgZBtw9n4UrttoB9y
         ooPT8KDNwBJ8uabHajmNAAIynluTioXv7rZPgrDxsFbxxpl1UO7WQn6VGOzvd6gAzUgZ
         wtP+LWWOV1FfXPJdiPcgCy2TXm8a+0i4raNL7gyBajKjPNlCcVPyggACo8L51z6tjM+D
         hKy5dTbukKf3Dus3KP6RwB9cWqd369EhdNwkTfvMZ0r3wCY0yoeTUiMdY77zwNnJi/aQ
         8KebhQMe6S/fuu62fCww0JmhhUHbOiyYm83XYE/AnKUQhTuHn0uozxepQ59HrM8e1C5M
         7Tmw==
X-Forwarded-Encrypted: i=1; AJvYcCWdL6JSsf82BYgRjiuSLG7eHQVXC66E9PcRFv3tG4yF7FRzYVNo6Tkwfi4Ronm9IV8oMDEipoPAT8hOALI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr1LuvXqB/yIIamF6zX8Tj6zs96ffvpgisan6Rrbr+L43kQ9yx
	OzpK0AiNC8pr5Mvm+CILtDnfX3s4a4itiHNNqYd9/I6xxsNx6cpj4t20AsVVngk=
X-Google-Smtp-Source: AGHT+IFMeIirR37eFjiaSRYN3Bz3jdqtWYTJT/Mk36/BPEUU25Jqo9V2Gy2AfqlJNfyeC1oTrAtcCg==
X-Received: by 2002:a17:903:22d2:b0:205:5427:2231 with SMTP id d9443c01a7336-20706ffde4cmr134009155ad.47.1725943897747;
        Mon, 09 Sep 2024 21:51:37 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20710ee70a1sm40882965ad.121.2024.09.09.21.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 21:51:36 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v2 1/4] iio: light: ltr390: Added configurable sampling frequency support
Date: Tue, 10 Sep 2024 10:20:26 +0530
Message-ID: <20240910045030.266946-2-abhashkumarjha123@gmail.com>
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


