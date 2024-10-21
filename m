Return-Path: <linux-iio+bounces-10900-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B8E9A9052
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 21:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8295D1C22BA4
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 19:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D57D1FEFA1;
	Mon, 21 Oct 2024 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOuriq22"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8C01FE0F8;
	Mon, 21 Oct 2024 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540421; cv=none; b=iXPsSa/qv715tD9NeCcL+tizCPU7U/wTV8bEZUKcumgxEFsbOcot1XtJ1Uv7ZgBgtj1ukkLZ0MdwVpKztzkPrbvmoJeSyhXYo9Vp/16L3S4BoPN5U2bvid42S+53y5Gmtmx3cz3fiTApO/ZU3U6kOHnd1i4dQcepeORW+frQNRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540421; c=relaxed/simple;
	bh=0gNsWS5mdan6YA0Yx4uRI+D/q95UpinMQTo4fP7TfpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQBB5DUEHyD+UUZ3d6cc8i3hY1c0waY/odkw17VG1ycpaSyVs9tFofhKSvNhEC3GrEDaOnF/ISlAn3JCp7n9jH/RLa/yus+55vCFGNaTiDiCxNGHZRo0MZ2CWFIvYucjjFfWYMOzwoRtP/U+5IjNyiB/KIuSG336gpI1JmhoyWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOuriq22; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c94c4ad9d8so6309985a12.2;
        Mon, 21 Oct 2024 12:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729540418; x=1730145218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2kngOOnzpWjdddsQOkA3a+2iH1yfArg1N3g/ZRWe80=;
        b=HOuriq22xXmJqRNEw72iISlpfNgbBCtGNbuVOHvLunUvrsmWHq9aeyjepYBbN40e6X
         yULYTtF8hPM0OKS11o1QmQ3+eIE1Yh/dBIiTXOfbBdpYjraAeyDUafmE6kpEE1adb29M
         vdnQCX10T49X/fagrVlZQKY/D4F/6JfW7TWLM4/zpcB+OFO+Mi5xsUS82pgFUGCKKYFO
         Ng6J9SpT/cxciWWOEObTOCLXnj0vlqBQ49XMTAF90HYXZQ7U0StrXZuDLhLKZcDzP4i8
         XHr2OHZb5bWjgAX+yaDZfgU8R9iMZOOuIzdOA+VE5kOBMtA94tRP/fDJf+XJQCNdg6LT
         pk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729540418; x=1730145218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2kngOOnzpWjdddsQOkA3a+2iH1yfArg1N3g/ZRWe80=;
        b=i5D5fQ6Gq+yIbkzbcjLqqL90agwU5Xi47Cm/n372ew5+GfaJdABElYbgBfuLdgUVmA
         1pgnK9s9xQS7FXIekIMAXFfItt2NvzFyjSMZGlGP9BUagFOqXHOQE92qBwBCQ1z2OB7E
         1irC+DpgN9Dsa/CYeszSXzk9WuMxDdpmoahfOtpJ/NJRMAEvonMhzyiJprEDQdcQYcRB
         3oC7Jf2wzAOnuCfmeCaGuVvQjLEOmi9bs+SwCymgccoscFLMEHnyecnnpdqks4w8RYxX
         Ux68LDjxd5WtZLdQofppdH06hzsOT4ysHYh1NQWFQM3WCC3P/tgerHoqS95hhTMtX5w3
         bQeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXEej9/T5aAerzgWlLuYA0+ryjtmo42OkpyZ2BcQ4/3K09ieI2aIg9rmj5EyWnhV5BCj4urNNH1fvhAcbq@vger.kernel.org, AJvYcCWIHxJM+OPPydv5/SQNnlMgKpv0MVLQfYyQFXBSBIfShoVhUmN/pmyx7Pyf8aFhv9lo63Pajwzo2tUI@vger.kernel.org, AJvYcCWxsjENCVKUxLXu2swxdXYTGJEz0UrmLzvPMMka/UsRZaZl5ZWcPtGyIKPWMxwHPsjpKbRcJMGcXx1G@vger.kernel.org
X-Gm-Message-State: AOJu0YyYv8fKNjgeff/ceg55VJtXvNS1zsUAQWhgUQaV3oG02ajdpkxM
	AWdI2cNFzfM75fVxgjsMcONTmDAR2ICgECipcqptpF1a/lagbIGVMjq0RA==
X-Google-Smtp-Source: AGHT+IGUMoXDwNLIySvBaN/OKHO2CpdxKys3ZpuZfub/Gl3Ae4H0AHskSzUo5jURp2ZKTvcRohGGsw==
X-Received: by 2002:a05:6402:4403:b0:5c9:7dd9:3eda with SMTP id 4fb4d7f45d1cf-5cb7fcd8c18mr82328a12.5.1729540417501;
        Mon, 21 Oct 2024 12:53:37 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:9cf6:f1e5:ce2b:ea6b])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b12dsm2338702a12.77.2024.10.21.12.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:53:37 -0700 (PDT)
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
Subject: [PATCH v2 08/13] iio: chemical: bme680: Add SCALE and RAW channels
Date: Mon, 21 Oct 2024 21:53:11 +0200
Message-ID: <20241021195316.58911-9-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021195316.58911-1-vassilisamir@gmail.com>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
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
index c79ba6d1ece8..e8098754a85f 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -143,17 +143,26 @@ EXPORT_SYMBOL_NS(bme680_regmap_config, IIO_BME680);
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
@@ -785,6 +794,48 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
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


