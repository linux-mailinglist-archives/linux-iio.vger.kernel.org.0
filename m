Return-Path: <linux-iio+bounces-10427-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4890999942F
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 23:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB61B1F277F1
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 21:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30AA1EF0B9;
	Thu, 10 Oct 2024 21:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+9uvBZP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFE11EBFF8;
	Thu, 10 Oct 2024 21:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594056; cv=none; b=mtEp0Lef0JrdFp2PqteHVN7jdeK2Fv8HQh3w7NYJmA4K8Z4Jl8bboAojDj1ZXtmLY13XU0o7xBWPcW9hKxV8PceDAM5pXehO3lIW5CNNYoxnVEfN9fENZZtZyNlpjNYYjztxwlf1HR4emcEvHZ8fC9cXcuKqYlxBr962A/GjVQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594056; c=relaxed/simple;
	bh=bmhA3SsOWnIZbrU89s1sQYvFCSZk/tlwnESgmddNpJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IltG2xdWJMlEpAGrm67KZTudgE5iQzyrFvB6i44p6j9Cm+1KWx04DUdyuKb3OqKtfUiLfVkP5xDmZ1wm5h5oFNXWnre0tmg7KhRtDLMWBkAPclCD66mSgov3+BT6nHJjpcHUH9BD37CQYjs3BNyNoF4CDGAGCBdIe00BwUdEdeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+9uvBZP; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c9362c26d8so1957701a12.1;
        Thu, 10 Oct 2024 14:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728594053; x=1729198853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIki3gH9gwohrIiKjOvxS4lxdekFzOTu2gTcUdwnifU=;
        b=d+9uvBZP4cUEibarnhgY7g77i+2V/g7Ird09dSC3IWRi2PuC0NjKhnsFs7+DjB+14I
         tETDHCDBFKSFwdfiuVkv8hReJfhkwotbUGUwYsJ1GM2bLFm++YCo0ngBJ7hMS30f0uVX
         n/uY23lk+WCK5coEw5t4MBq+Kvko4oYH27yTIYhaaSlmsQ2Vet/wBrohz00PGGmJqZSG
         TFTSFzmQJVnvqDho/qIk8+NyfjYSeJsiPgkx5HDIDp1zRdPYDd9f02LuaeUbXSykDYMH
         86kqoQDcic+5XasqgVCjl+lY8TNmuJDpKZm9HU6P/Fl+oG9yMTL1EGjbMuWbmKPEdr9Q
         7KOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728594053; x=1729198853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIki3gH9gwohrIiKjOvxS4lxdekFzOTu2gTcUdwnifU=;
        b=F1i9KvXQTEdXYLXbWr+sQIyhhJNRwFvLsNS47TlnkWYNK9KPItcfmuUelQ706MyeSK
         jLPlxfvbiGRTaHktvdU6fLcxc7BzZTe2KssBjpL8lm45m0rDFFvEibPK3+lkfoUYKBQv
         Bko51fS7xQcHR4Zfan40RqxtoyaYyKyNIwmAlqGtdPMf8x1g+VNnuvSlZ9hEB0BzaO1v
         cii2l5nvU33c2UkUs4FwV0M2TtU1ae/b0zw9UmzUWNLCBmvMBGsvSr8jSFpJT7J2Egj8
         UEQdTHqb0C1yNewYn1usGiPsS73GhqBBA621++ziWASrdWrPeEY/iVZsSpOFG57lCu0K
         fz1w==
X-Forwarded-Encrypted: i=1; AJvYcCUYcKx7ahjerUhIVqoA0LxOjurW10I1RkSFQpSEgMu/Hd+rsEUjgD5Lp0tTEk1ZevaaRNGAtONtZtNi@vger.kernel.org, AJvYcCVXYaC+Vcn4T+Elu97ZOG8xdQvt0CLruG+qoM5Su2ysy1adzyBpoZb1Ad1nQv3aH91CSM1fbTax1Z6k@vger.kernel.org, AJvYcCXqEBs6YoIzpF9+D3prGLsK2G3PlFj9Nub8XHTcOWyHr3+JF0cslqpAUZBPk7ecmXILueN0AvKd8LRJAIGw@vger.kernel.org
X-Gm-Message-State: AOJu0YzHUGj6189ldxdkdgreUqqWiEMMBUNF5bbu8wlOy4paC3U4B4It
	tNLTL/0xknJOZREG1cEjmDl7Lvm85m9VEHhBfIUmNyXApzlBlk2q
X-Google-Smtp-Source: AGHT+IFmPTUR8VwYFGLVeZSiu+c3uz/wO9gGgR2hjdMGttdYSCSrr9HirJGcZFQN8MhqQflNK+eA0A==
X-Received: by 2002:a17:907:9495:b0:a8d:4e69:4030 with SMTP id a640c23a62f3a-a99a11092a0mr427547066b.19.1728594053039;
        Thu, 10 Oct 2024 14:00:53 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:7eab:ec9d:62da:64f5])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a99a7f25f4dsm135692566b.68.2024.10.10.14.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 14:00:52 -0700 (PDT)
From: vamoirid <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	andriy.shevchenko@linux.intel.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 11/13] iio: chemical: bme680: Add SCALE and RAW channels
Date: Thu, 10 Oct 2024 23:00:28 +0200
Message-ID: <20241010210030.33309-12-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010210030.33309-1-vassilisamir@gmail.com>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasileios Amoiridis <vassilisamir@gmail.com>

Add SCALE,RAW channels to the device. Even though PROCESSED should be
kept for backwards compatibility add comment to avoid using it if the
value is not actually reported in IIO values.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 51 ++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 4669338ec2e5..7d6f4d8c5fe4 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -155,17 +155,26 @@ EXPORT_SYMBOL_NS(bme680_regmap_config, IIO_BME680);
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
@@ -802,6 +811,48 @@ static int __bme680_read_raw(struct iio_dev *indio_dev,
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


