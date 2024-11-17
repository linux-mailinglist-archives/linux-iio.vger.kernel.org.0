Return-Path: <linux-iio+bounces-12353-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AE29D0515
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 19:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9371AB227C9
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 18:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C171DDA10;
	Sun, 17 Nov 2024 18:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaaK+FQ+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FBC1DD862;
	Sun, 17 Nov 2024 18:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731868109; cv=none; b=JOLq0Ymmm+npGSziKkhRgWGi4Z+RFlV9KtqlijkOc2Bw9/7T/Om7QgePRBEAAjdhOFJFKx31FMkdNmkGElGRCo20n3xO0qnaGpVJmd7GBikP+J5wqwuKaLnxlhIY9f42bK6Uk1ou4KXogpTNJuSr8qfM/WwiCio/mpaVRWomy5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731868109; c=relaxed/simple;
	bh=7ht4ODhUVZtZWQWhZMHDdqVUX5Z9ixmgQJA5GDPh9ik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VV05qhWbd79YPvziJmSM05V2quvVr1RXTlpBQSe2CTEssK8XuFzs+DR8+tddDFhQJT2HHGk22jBGtYJN6myYaEWYCid7/YbD5OWiZxsjXy2s/eMboPn+9awL3HxGTHGTWv0Ggx6pHB8neHA935CAlLIe+68t8po4IBdGZ/5eGCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaaK+FQ+; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-382377822b9so170665f8f.3;
        Sun, 17 Nov 2024 10:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731868106; x=1732472906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isbyosWHvXydkQYw7H4qCGUq+Q5YVEqyoJq0CjLjPWQ=;
        b=VaaK+FQ+k4Cipx5B961hZIJV9tET8cYFO7aJVO+j7ilRyBX7phzg1zrgeuzxFWWDBU
         msp5yIeUSkymR3nwXD5O+MFPE5ZnVdW9dn9OIAU19L7Pqc3B5DxdkHucnNH/A22Pjag+
         O2zpeYmh7zehrEhLEfpbV9awj7q1TDwvknm4SgunOWz2Uq0gaIari1h9hNeg/yGAKZY2
         sua0eR8sRCdkFprX5c2TpqOwBndGnleJG+JIjYXzmU1E4X3vXyg6e9nkJm9xSglLR15I
         qyLGoDHGFVnLNKzZHR1hr41kpCioDeN5FiGYl+/TRxwavbUIvz8K6JrgJod+JQLtMpgt
         gVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731868106; x=1732472906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isbyosWHvXydkQYw7H4qCGUq+Q5YVEqyoJq0CjLjPWQ=;
        b=ishLs+4pm6SdP4kQkEdQSwr2IGpM++CE90z5l5JB6H48xKtI7Yyy1SzzPBfPBCJ3sP
         tZ+qXLituXw3na/2w8g5/ZQdZ2AF3V2X+ZUiuVtlwHM4NjOpCD/PInEMlFhX//BJzISP
         wMdF5EcYu3pt66WQCzwJGoOmHYnBgC6PRLVsYM48zUcR7/P2QRxtxQy52y2kcg9Z88L1
         Ri8o4Rmf3LNClTTbtypmYFgkNaCzJbMcd8iSMxaQ16BhuBC9ficFWkIiqUQL8t6c/UpW
         LrQT5DpQxvp6g1IoacKkjikrMVDoVln+NHmv1ir3FGavUmve/OjBkPuqDjFgRiYKC8KM
         nLWA==
X-Forwarded-Encrypted: i=1; AJvYcCX8o8JMrdPkc1WKbvVtdPxJWQzMmNVB4DxPnpCTZaYK8RI9xMwnuZwigydpBAsJDTRzDRx0py4We3+u91s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn2a76rStfz/wRSYVP3MqUpg1Inwe+1gF19XAV8yjsS73XiEle
	4V/xgpDlID81y7jbGoLCNotiv2CgYQvXbWvFuVvkRgbx3UFoKy4G
X-Google-Smtp-Source: AGHT+IGTTdDTahXCeP6L7HmXPPULpto6bTEyM0vfZwNb93RSc6QlugO/+PPG7NCIkGzWJ4+diKquMA==
X-Received: by 2002:a5d:6c65:0:b0:378:955f:d47d with SMTP id ffacd0b85a97d-38225a83057mr3008312f8f.11.1731868105725;
        Sun, 17 Nov 2024 10:28:25 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823f72441bsm3028137f8f.101.2024.11.17.10.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 10:28:24 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 10/22] iio: accel: adxl345: set interrupt line to INT1
Date: Sun, 17 Nov 2024 18:26:39 +0000
Message-Id: <20241117182651.115056-11-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241117182651.115056-1-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The adxl345 sensor uses one of two interrupt lines, INT1 or INT2. The
interrupt lines are used to signal feature events such as watermark
reached, single tap, double tap, activity, etc. Only one interrupt line
is used and must be configured. The adxl345 default is to use INT1 and
in many installations only INT1 is even connected. Therefore configure
INT1 as the sensor's default interrupt line.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index c8d9e1f9e0..32163cfe6f 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -131,6 +131,7 @@ struct adxl34x_state {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
 	bool fifo_delay; /* delay: delay is needed for SPI */
+	u8 intio;
 };
 
 #define ADXL345_CHANNEL(index, axis) {					\
@@ -345,6 +346,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		return -ENODEV;
 
 	st->fifo_delay = fifo_delay_default;
+	st->intio = ADXL345_INT1;
 
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
-- 
2.39.5


