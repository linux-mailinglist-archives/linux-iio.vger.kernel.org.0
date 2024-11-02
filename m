Return-Path: <linux-iio+bounces-11833-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE1A9BA045
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 14:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3652826A0
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 13:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C8A19ABBD;
	Sat,  2 Nov 2024 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3kx6gz0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361E818BB8B;
	Sat,  2 Nov 2024 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730553212; cv=none; b=rde38avE3Q1tv6fLUiRCfkMqtZJVy70f30jAJNAewVtE1tNy6gV3uWTAcm2wOCYRnDGpO7sS8CWbO7aMSDzLj9ub53yqtuDRI1ZxEweqkPWhkaH5VF7OUFreqPK178WgIXcG0LWwV35RQhmc3c1sKiYwiN+DKJfAWp1LbBDKBC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730553212; c=relaxed/simple;
	bh=hpZ7s1TKLNsx3yD0VK+9X+2FkS+kR2XEN8EtMR/yUUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUdtg3osBWEPp0/wFQZiaXHn8Y4zhAsxsZnfv70dXB7QkcUGj+rWvqyOZQRrWmHUln/dyn1IfOVz2Md7qs8vqUIZWCkoTJWgK3HHZxJGj0zzO99bYM6+gnrZeTIJGA1v+j4DB82wHm8wyvCa++briHmlt0tAtNmcXiHGA6NmQRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3kx6gz0; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d49ffaba6so1878040f8f.0;
        Sat, 02 Nov 2024 06:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730553208; x=1731158008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bxa5B2WoofuznyY0TJXdMJAjcuehnDgQbKM8qtJik0Y=;
        b=G3kx6gz0+Zvkn5umPYnMvvkyUjFD4IOW5nNR2w/h15SpleDUkKvntwHzgshpl94pPz
         0VIKodarQGWbXClTw/A27MNoD95QGEwma5FWGsDsUnSwqvK/RTsJrD5qy2G+D+ZPVsoQ
         axddoPNpjVW8qd4I5p8hIJZ3nNbo/xaiV7RIMOLv1FJxGMh0aTvJYq9Zup6dhsht+rSP
         v5os4XJmUBYJQS0SPMHAFds3WP3IKMVaz+Md6YPdvv6t5GIgA4P0FPqD5fTUPfS6DtCH
         Przv7TxVmjhMPxSTFH9KhTRtRvNN2W4V2YhqQJ1cdtbkXX3o2LL2P7NuNucuNgIiNMud
         YJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730553208; x=1731158008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bxa5B2WoofuznyY0TJXdMJAjcuehnDgQbKM8qtJik0Y=;
        b=NWQ+6kBllCuVRvGwYT+QxE7GYKDAPK2j7Ai7bVhisqOu7Zf8TforMwSemjBanJIOTn
         L1rQMlyoW6VVXjBJgnF45vvhAOKF2EC/jEWjgIbQlYneCf9FO2vb6+1qMmQnZOx1NWil
         WHbSkA5FIb8dSDa4lhzUOOGW0lI/F+t6mxlXoSgWidciO2SAIE81mD5UEBCz0wcIzYzw
         wDmIfoQpO4kH9U0vIon0xTS9QNqGwPFj399N/7b54d4iVod71ctk8otDI6+V4FUedf2R
         me8fTBi87oEo0z9HfaZhxMdkmwku/S4oF3xJ3j3HKm1huP2TCQjgpQ+UQkbze1+Js0OS
         6sPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU18rEioIKAvtI76nfyP++a+S6+OI7NrKSSd48BteZieKd7Smh67M7N4p71vVfif0USrbrQzhU4yga2pE2r@vger.kernel.org, AJvYcCUB4yyiSxdx9e4xcUDL/IOs3wtREi6pOVMyJM3NM2epSc8d5yXUH/CgV/KEJEvsrhuDRPQxaMZ8LNvr@vger.kernel.org, AJvYcCVf/nZlwc+hllJxvdD4MRpqhKt9Hzo6P1HXse6XnHXLLNYSy1k4oR3ZENnLzWZw0TchJJ/wO6IzvZyN@vger.kernel.org
X-Gm-Message-State: AOJu0YwzmpoDiVW0PAH3dsU/ZjhH8LbQeH6uF01xxwn7+WmGkw1P9JN9
	TnMI251VpY4sKMn60jWnfIWuqUBpXz16Y247gSDP6ESlb2fZcsPG
X-Google-Smtp-Source: AGHT+IEcd2TQHJTCED8JlppR3V8PQ8ys3ru7tBZ+dl/gyO4ZLyyfQ46UadCseH1OZcn9wqZ4uSzTSA==
X-Received: by 2002:a5d:4d82:0:b0:371:8319:4dcc with SMTP id ffacd0b85a97d-381b705764fmr10769065f8f.2.1730553206869;
        Sat, 02 Nov 2024 06:13:26 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:b243:5cd3:bfdd:a16e])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381c113e5cbsm8081570f8f.80.2024.11.02.06.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 06:13:26 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/7] iio: chemical: bme680: Add SCALE and RAW channels
Date: Sat,  2 Nov 2024 14:13:06 +0100
Message-ID: <20241102131311.36210-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102131311.36210-1-vassilisamir@gmail.com>
References: <20241102131311.36210-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SCALE,RAW channels to the device. Even though PROCESSED should be
kept for backwards compatibility add comment to avoid using it if the
value is not actually reported in IIO values.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 51 ++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 5c2c327c4540..ea1ee9964870 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -144,17 +144,26 @@ EXPORT_SYMBOL_NS(bme680_regmap_config, IIO_BME680);
 static const struct iio_chan_spec bme680_channels[] = {
 	{
 		.type = IIO_TEMP,
+		/* PROCESSED maintained for ABI backwards compatibility */
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 	},
 	{
 		.type = IIO_PRESSURE,
+		/* PROCESSED maintained for ABI backwards compatibility */
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 	},
 	{
 		.type = IIO_HUMIDITYRELATIVE,
+		/* PROCESSED maintained for ABI backwards compatibility */
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 	},
 	{
@@ -787,6 +796,48 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_TEMP:
+			ret = bme680_read_temp(data, (s16 *)&chan_val);
+			if (ret)
+				return ret;
+
+			*val = chan_val;
+			return IIO_VAL_INT;
+		case IIO_PRESSURE:
+			ret = bme680_read_press(data, &chan_val);
+			if (ret)
+				return ret;
+
+			*val = chan_val;
+			return IIO_VAL_INT;
+		case IIO_HUMIDITYRELATIVE:
+			ret = bme680_read_humid(data, &chan_val);
+			if (ret)
+				return ret;
+
+			*val = chan_val;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_TEMP:
+			*val = 10;
+			return IIO_VAL_INT;
+		case IIO_PRESSURE:
+			*val = 1;
+			*val2 = 1000;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_HUMIDITYRELATIVE:
+			*val = 1;
+			*val2 = 1000;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		switch (chan->type) {
 		case IIO_TEMP:
-- 
2.43.0


