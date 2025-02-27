Return-Path: <linux-iio+bounces-16115-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F05A47C56
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 12:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF9C1889D7E
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 11:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D391522A816;
	Thu, 27 Feb 2025 11:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rxjUM5QK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7BA22A4CD
	for <linux-iio@vger.kernel.org>; Thu, 27 Feb 2025 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740656146; cv=none; b=FvCB5lKcSPQ3Z/KJ6QdYstRuz19n2Sd80Euq1s5xlArBQQi+MM9zhi/u2he2HSvOiAvoNP+GEDUe49nOcYMiCUm/W4ZzGq0o1JUtCRX/ZKMH6/INAoMD0xKaQx/I3e6cp/p4i2RV7c7uWN7jGWpuVypYmJh/HEG1WLqmBVgxfEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740656146; c=relaxed/simple;
	bh=XF0W6M3TQrfUEnWKFecpLK9eif7sJXUkKs8IhY41nXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f6qqB72q5Oc7Tidh1MyV0J4Z8bWFPIMxaFCojGsKRppG6FzO3rudvFMuDiDNPqHKv4kARopHUeZ1RRz2QzJWUXOYudzCb7p0okVT8eakr7fgEX3Zmla6y96AzZZEZi+ZjDinwtucLzLw42K50Eq/4r8hN+BJmWjNx5cOupG7P18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rxjUM5QK; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e4cbade42aso678901a12.1
        for <linux-iio@vger.kernel.org>; Thu, 27 Feb 2025 03:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740656143; x=1741260943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEh4jM8Mpuv5pXgK/4BzIOdvFFUvIsNIq+v+bkok9nY=;
        b=rxjUM5QKnEzDROXTxeLGcqoB2aN+4nq8YOZUvOwHUzcfRW90VRGuqIAXG+F3+AgYka
         R2+pI5+FMIb7NKiibDN/UyzzDBcYn2Pu4G7wP+q4pIK1vWNbe7lnGOBHa5xN81zn964w
         1m7Fne2vligFpATQ6uD6aqizweR0PcfaS5+Ii+Jrma8FuPtFuH+T8Yv13/qGuZd5ckzX
         BQzWFucSTyBmALZRAbE+7ttfR0sllMo122m6iudXnekAfplYJ03WSDZd8YyetWK0xGT/
         Lkf4WwGJVOlszlH0Cs835EPxHWgfLypThHey6bjSE2L+XHUm98SBCox7YDMueP/awwxZ
         M1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740656143; x=1741260943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEh4jM8Mpuv5pXgK/4BzIOdvFFUvIsNIq+v+bkok9nY=;
        b=P0GTTFCQXdH/B5LcSJgt0G5M8wfCz9w39p+rBpcWQFQuLtjmCZVqgTZd17K2JBiJ8/
         x45P0cr1ADN3AtYMTnGt2v+qtFOVFnDzErbeqtQiY/C5j3rTg2LS4lMAjI/XgnoOwwx9
         panZFy2xyAycoa6FZFV+3YIboXHcz4auc/H8f9Cvf4yA1KtuefepDWQvZuMBDC8YASL+
         WwA7zcfdqhHnFPXVQe8LQ4QwpNQ7uIv8HOnl7a1++jERWcGCVdSD9QpK9YmfUQAQVqmW
         ia1RqDAPMK1aGEB2jhPOuiVmP9XqbLNeVzq+F150x3t0jKvM9Y/9Soaaiang1q7MSHdM
         9VNQ==
X-Gm-Message-State: AOJu0Yw5ia03+91yREXyH5zZ/I15GrJocfou9jxQlo37TwPw43mE3XV+
	GWNgh9qjI9pHVVfrEtH3mePoKyf/hoIl9bkNrBsZmvMFWVR6eG3IT2s4akp3WD0=
X-Gm-Gg: ASbGncsHYULb6nsYdFXeqGPYA9qjOHs6yHJ0gk7cd8UX1TDpzFt7Kb1sUAsUo6fml8C
	dTJzD4YjNsbQel3eod2iITWpJF0nU0PPdf3frZwt1dQpXsOCJsGTHhVqDdlVsSengJDHSYcg7nF
	7HFXR+JkICuMwU4ZvFQ1QWTaXVs7ZpzIlzzyLai/I0YzFmsvBSjF0nRSHBE5ehQUqi+chNOe5wW
	0MuA/qlXvhLKHya+EssEBN38gbanyi6UkGOYnymywDi6M4obpEUVNe5onyI8ny3DYPQUPdvb4Gs
	y1fObcpjTqkKFs6oJxV6E3a+UYMdGCZC+mWShiDZx/kZchW8PRDlGKQDFFNKxYc=
X-Google-Smtp-Source: AGHT+IH06VVKW+WeLgsv6OIiRiyqXwWFKDGMZsodwjYkCuarD60rNipBy8dReMtpBS3bQVknSqV85A==
X-Received: by 2002:a05:6402:26c9:b0:5de:572c:72cf with SMTP id 4fb4d7f45d1cf-5e4bfb8067bmr4476643a12.10.1740656142753;
        Thu, 27 Feb 2025 03:35:42 -0800 (PST)
Received: from localhost (p200300f65f2c000000000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f2c::1b9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3bb5abfsm959090a12.35.2025.02.27.03.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 03:35:42 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Guillaume Ranquet <granquet@baylibre.com>
Cc: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>
Subject: [PATCH 1/2] iio: adc: ad7173: Grab direct mode for calibration
Date: Thu, 27 Feb 2025 12:35:27 +0100
Message-ID:  <8319fa2dc881c9899d60db4eba7fe8e984716617.1740655250.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740655250.git.u.kleine-koenig@baylibre.com>
References: <cover.1740655250.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1029; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=XF0W6M3TQrfUEnWKFecpLK9eif7sJXUkKs8IhY41nXw=; b=owGbwMvMwMXY3/A7olbonx/jabUkhvQDfkzam4Vyw1/f2tL1/bratL6Hk/gny7Ht9Xl3tCRL3 rnoWYF1J6MxCwMjF4OsmCKLfeOaTKsqucjOtf8uwwxiZQKZwsDFKQATWbidg6FVyOVL3UmRtgS9 kA+rgwWF1hTvv1xz4vU6br8d2aKX9whusTy3zXdhi+WJ68+FeDY4NTAnH+J0qXqVcsE7O+LrVCf 5PLaspYWZLW/nGVzLrkwqyjp8QUPtyN0JodOYGAPvJcT5PazUydyy5lqT1B1DOeHz9iop1lOc++ Zv+dyhzLMo5OHEoqAIGy6D+ZXhlasbkoxFLi7V3n+n2ESw/W5AZ/fismNTVb93L3qWsDtX7rece p7YPHaberm6g+zaIlOKtPe5muXObRJ9JdOo+zBwn3msx/Re/1uZ79683jPjjdfa3qcGXB9yLptl Mttw5fw99WPXGRX5u4666bKhfq77mKdmbxMw2xVvXusHAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

While a calibration is running, better don't make the device do anything
else.

To enforce that, grab direct mode during calibration.

Fixes: 031bdc8aee01 ("iio: adc: ad7173: add calibration support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7173.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 962033393943..110539a2b112 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -349,6 +349,9 @@ static ssize_t ad7173_write_syscalib(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
 	mode = st->channels[chan->channel].syscalib_mode;
 	if (sys_calib) {
 		if (mode == AD7173_SYSCALIB_ZERO_SCALE)
@@ -359,6 +362,8 @@ static ssize_t ad7173_write_syscalib(struct iio_dev *indio_dev,
 					      chan->address);
 	}
 
+	iio_device_release_direct(indio_dev);
+
 	return ret ? : len;
 }
 
-- 
2.47.1


