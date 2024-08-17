Return-Path: <linux-iio+bounces-8546-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 752E9955862
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 16:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3341C210B9
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 14:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A0C9473;
	Sat, 17 Aug 2024 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bUaz2I/8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D6679E1
	for <linux-iio@vger.kernel.org>; Sat, 17 Aug 2024 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723905422; cv=none; b=BEIBz4m0KPXuh+Fcz6ffH0rDJZUAofCMhq7N9rJ5oAGCWUSwnOHlIKt1z+h8QfUQEWt/BQeYXMMaItzUEN6MFWv+/KT+3jyHnGIr16G/JaRFR+5g2ZK5o4Pm8wLSbEzOyEXpizFeiZf4c/gRoxHtefCRvGbkZdSc+wNu0MnfaRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723905422; c=relaxed/simple;
	bh=AgZkjTczEFd62yuqkbBbC5Z2vbFEzvDMtqf4z8mAx6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vu9TtEQLjm8xFdMSBrMGW6IReWzPXzbjuNRtpe7ODNLL5xFVLSd/E20vs2FUn5UrHPF9W4zqx6al9Ai3BhpSHljawbvq/KxBkPaPSa028EbmaXqN1HA5X3wV8/bxCO9pCuSBlgHCepT7F/Xqvj5rmCOMQ+DY5DXORifUtc+T4wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bUaz2I/8; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a688e726755so25941966b.1
        for <linux-iio@vger.kernel.org>; Sat, 17 Aug 2024 07:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723905418; x=1724510218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al+SmtU+sIIwFr4jQDcTO2Drgn6PFlBI5eq4W/6i2T0=;
        b=bUaz2I/8xBodmvNFF7Oaq2cJguW9BV1kc9oJYvhEZRXDwct7Xdp1VPXndnOIWoY4lf
         B7Z3W43nU+ApR31cI3MpgAwOQ2tw6+wJPSbc2Gr8MnJVT6WLpmPWnByaTdyjMsNvRJ6x
         s6QXz+mBkRW2xhqXoS/3EAYW0VmGQEA5+o9mx6o1JoqmzE0lrjXV6V9CA0PE3oeQkWuB
         hwN/nA5xh+2AwSsc3g6mLhk/wRYqlayPi8LTZDhlTCfz1wYUn7gdf5hqtmv29JgXG/an
         vsV5WN5fHWIf4b9ZHA6OHig7IwDjDh8igYzLcR9ETbeLGhUX2/9YZvHJnM00NbJI0oBK
         JUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723905418; x=1724510218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Al+SmtU+sIIwFr4jQDcTO2Drgn6PFlBI5eq4W/6i2T0=;
        b=t9raDi/9jDUaXK/7a121qB3hmgstSBGHy+bJH292jLLr+vL1B1Xp4PQI7+Emi2GznQ
         Fw6sHsq5JAjFB5NWBOWfNaaXweetimiDH3NfMMZW1lgy/MaUecZ65QrsnOhTmiMgYb0J
         Y4A1dhu09pt+oeS4W4byViczEoPx/jgTSOryxAhimtaTLlwQ1DsSHhAv3rbHw1XOXvUS
         PkUnfY2fqaBEkTua3UI0f+WwPcp/GjpZ9Vn3F7YY/CEagHXkfqVFPm6gIxDXXj0WC3hl
         Q025RML7cMm16P1/5/F3FR6E+7RRI4Rv7eE2ZchhCauogJYhiPcdSoTnVydXuYDIg7WY
         tpoA==
X-Gm-Message-State: AOJu0YygjoiLNcDQkU4IshDDw/y4P12k+rrqYnMs4VbqIlb5aqlJ/Mq2
	CJE/eKL7WlLlU26zeAUGHs+ZXfD2iKPCH6p3zQFZPalhkvnZyrMRlUUhVeq/nePhWl8mAiXVXjm
	Z2W4=
X-Google-Smtp-Source: AGHT+IGXfJ5EzbcdgJZ4wHtZcC561IG3+5+VwIwevWbFKrMqVIbwwgqjQ8Fig1iwUAxR5oDeuAxQrg==
X-Received: by 2002:a17:907:9709:b0:a80:ed79:a0d9 with SMTP id a640c23a62f3a-a839254db5fmr211834866b.0.1723905417295;
        Sat, 17 Aug 2024 07:36:57 -0700 (PDT)
Received: from localhost.localdomain ([188.27.129.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383946898sm410376866b.174.2024.08.17.07.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 07:36:56 -0700 (PDT)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	Michael.Hennerich@analog.com,
	lars@metafoo.de,
	gstols@baylibre.com,
	nuno.sa@analog.com,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH v2] iio: adc: ad7606: move 'val' pointer to ad7606_scan_direct()
Date: Sat, 17 Aug 2024 17:36:47 +0300
Message-ID: <20240817143647.15998-1-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240817142257.14470-1-aardelean@baylibre.com>
References: <20240817142257.14470-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ad7606_scan_direct() function returns 'int', which is fine for 16-bit
samples.
But when going to 18-bit samples, these need to be implemented as 32-bit
(or int) type.

In that case when getting samples (which can be negative), we'd get random
error codes.
So, the easiest thing is to just move the 'val' pointer to
'ad7606_scan_direct()'. This doesn't qualify as a fix, it's just a
preparation for 18-bit ADCs (of the AD7606 family).

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index dba1f28782e4..68481e97e50a 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -138,7 +138,8 @@ static irqreturn_t ad7606_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
+static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
+			      int *val)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 	int ret;
@@ -153,7 +154,7 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
 
 	ret = ad7606_read_samples(st);
 	if (ret == 0)
-		ret = st->data[ch];
+		*val = (short)st->data[ch];
 
 error_ret:
 	gpiod_set_value(st->gpio_convst, 0);
@@ -173,10 +174,9 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
 		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			ret = ad7606_scan_direct(indio_dev, chan->address);
+			ret = ad7606_scan_direct(indio_dev, chan->address, val);
 			if (ret < 0)
 				return ret;
-			*val = (short) ret;
 			return IIO_VAL_INT;
 		}
 		unreachable();
-- 
2.46.0


