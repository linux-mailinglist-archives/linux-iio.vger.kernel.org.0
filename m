Return-Path: <linux-iio+bounces-11662-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BB59B70C8
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 00:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27421F21C93
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 23:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805A3217902;
	Wed, 30 Oct 2024 23:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSOABHIE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FEE21745E;
	Wed, 30 Oct 2024 23:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730332475; cv=none; b=ivsk7uhhKji9qk+UbJiSGw8laFO1Qeig2G0408EAD3QjsCFzVsgYNbVBU702Dvz3oOsbrqfAjXjmDTacMkBtyx/eU3gjlT05qdM2Qp0vwJ9N9esNApjUIK2Bg8qr3pP0qvLX+3vcZzHo2jptodMqvI3PumpR/bz0u/XJnqAluKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730332475; c=relaxed/simple;
	bh=VTcE0ijVM8FqhrglRBTsjTmEk3EkQ7qXgOFsmOrpM4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1KxDWRjuFkaYTB1SncjfLBj2fYVj5jFz1PsbPK9gG7w/jE0w3kcLt2yEEXsBetLo+GtnxBvyZZ/R1G1NzPSZvgdqsAQatShtUTfsdzYeAzlH/kT9slB0FqJHqNs9SJGBBrL/A2RJt3Yfi6irhqx4YaxBN/m6v5gHw9C+VdN70s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSOABHIE; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d63a79bb6so277512f8f.0;
        Wed, 30 Oct 2024 16:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730332471; x=1730937271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XP9qgPUE5HvDD+pjvdBJslWZuJHVJ6y7greO8Ou8P1E=;
        b=cSOABHIE9CrK/4bMlNtfZBpEwoKzttK0I7PY/3LUEzpE4OUQqSt51rihdnmp317FWD
         M3Pctd8YY8aQAODJP7phqI+kUpyIYB7Bp6t1xyfRGC+j7lrJOUYiWz0O6ctB08Qa1Dlh
         GyPkEw5LKYop8CZVkYyl/2yi/4TslxHumjfwdQZFs0HbqzK7KwcqZ4lhvMZ3f5ZiXUYh
         VqW0v9M+4LaEKaXjz9P2oH82vFISe36+UrmAd55alcCgCgi+AwEl5D52Mj+v0lLNE2Bf
         EGDZL+PSWFRU3tZgzCis4xLR7MV5kcbrsDHXvxhG7H9Uz3L41QV84tiRTTGHwjQ8tQNV
         b75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730332471; x=1730937271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XP9qgPUE5HvDD+pjvdBJslWZuJHVJ6y7greO8Ou8P1E=;
        b=oIspubXIMehQmvUyrrQHpimcNgN1qEDWM+j5XmalXueqPlWI8LFZZNtpd4EOZ3wXvk
         2NjN5SJsI/5RM3UjcFIFMAuKnseYZNkukUW0VZ6JWo2dskzkXCDt7+rqezt0vrlV9/Uq
         pBPivs5yUYP/GKQnsCbA3ss70YWfhqhAfZjSLXIALy2U2GgypT5xzvm13ps8DAOYcZSz
         74jalrDYEShyedU/eFi4O6OonaApz9Xfo6I7MlQcaHfBNjxeaTiaqeKBdMj7gmA1jyUK
         mdxC9OjKyuQ/f3aVJ+Q2udJdsCCmVPAq3r8bfaqs1xq2Jpu93SgzAlYLkuv6aw/6LUJ0
         im4w==
X-Forwarded-Encrypted: i=1; AJvYcCVxqizY8vuKAXkXct3qVbYuMNB/Ku2ozDBepslCvmc4tFWRNOWCFeX+4K0H2yOZPL5/K4Pz8BdPxPp4BD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzhGTxvqvWJibbtDOAduJ+u2BcRmTOx3AnDSULjB+G6O9RiHXY
	WeTMuuqWr6FcE86vW2DX2LMZQO1G5bFyCaZMOifzK0HKzK4Qan89
X-Google-Smtp-Source: AGHT+IF8zzlhEv5g7iCKAYMdARFEGY1ICG1ECNZu15IOoQF5SXeNMA513vRaptDWYfenmmty6xYmNw==
X-Received: by 2002:a5d:64a1:0:b0:37d:4fe9:b6a7 with SMTP id ffacd0b85a97d-381bea1c1f4mr1014755f8f.36.1730332471407;
        Wed, 30 Oct 2024 16:54:31 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:81b2:9436:f9a7:d877])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381c113e885sm362644f8f.89.2024.10.30.16.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 16:54:30 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: dan.carpenter@linaro.org,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1] iio: chemical: bme680: use s16 variable for temp value to avoid casting
Date: Thu, 31 Oct 2024 00:54:24 +0100
Message-ID: <20241030235424.214935-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241030235424.214935-1-vassilisamir@gmail.com>
References: <20241030235424.214935-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use local s16 variable for the temperature channel to avoid casting it
later before passing it to the bme680_read_temp() function. This way,
possible endianness and initialization issues are avoided.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 871921d81e70..6d11f9188367 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -741,6 +741,7 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
 {
 	struct bme680_data *data = iio_priv(indio_dev);
 	int chan_val, ret;
+	s16 temp_chan_val;
 
 	guard(mutex)(&data->lock);
 
@@ -757,11 +758,11 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
 		case IIO_TEMP:
-			ret = bme680_read_temp(data, (s16 *)&chan_val);
+			ret = bme680_read_temp(data, &temp_chan_val);
 			if (ret)
 				return ret;
 
-			*val = chan_val * 10;
+			*val = temp_chan_val * 10;
 			return IIO_VAL_INT;
 		case IIO_PRESSURE:
 			ret = bme680_read_press(data, &chan_val);
-- 
2.43.0


