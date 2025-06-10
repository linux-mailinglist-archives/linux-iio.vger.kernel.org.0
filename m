Return-Path: <linux-iio+bounces-20392-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B8FAD456A
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 00:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA031189BB44
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 22:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A234289E0B;
	Tue, 10 Jun 2025 21:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCVCAqON"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B828928934A;
	Tue, 10 Jun 2025 21:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749592793; cv=none; b=XD/HPh9jBLqr2EAhmJpbLl80aZowBiIKmoXtveTp+JVJ0mSMg6Umq14axBMwwgW9TR8yzJsfJUpm0aZzw4LPHlTGkvjTBIZ0MPtzIW+jEly3cvNhfUM44QoIlgALw/HAKEH5JnoXhFvPniLAcq9jYD5bawRSeP0NhAsFjAFmjjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749592793; c=relaxed/simple;
	bh=Excy6KTjLJIcHfsatlEND0MXIgSw996D4QyB7VyZH+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EtnYUjMALA+/hN7gYQ2rCYtooUAeIsYjIGIRCbCW3T/sCjuvXZLz9FGKLCs2ZGKvEt+UB0V+dxVGmqu2cGW+4CFIzB1Xyqcs74gM7zTjMdb6mMdnU7eYPWQFUtI0xRT2AnHKrityW3QM8p9qG/kox8c2VFYLIfosUThVqOrE+b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCVCAqON; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-450cfb8b335so4806635e9.2;
        Tue, 10 Jun 2025 14:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749592790; x=1750197590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38n/wHuxAFqfv+bXMk8iuWO10rdnMupQMWYBFpyvjP0=;
        b=GCVCAqONxlFg9OWNlWT2yRwMMacJGwnxAzStMW1nhUwWFG/QaKa61DFX44c00Kt9NI
         8mZxerRIQwZFDsPyxg4InU3upofdAW7nFDjrzEw0dmHoe5SEJuFxZwUTKWb26ZrZk2AY
         U1Ct+2lk+Fvw3AqcT8vHPreLE1P8iqZf84Nmiw2Jkex0UMuSQJmWEe2Y74LAWBULkwlq
         ndn70v+XqJrik06sd/wZ926R2wIQY+J+iL8zRxU1QjSfHnqwPXh/+8RR8NbcQTr62moP
         7B6EJzOBQknyDc+XJYt0/0KUyaJhQ4r4xjP4ck/ialT7AMa5NXrp8V7ent63JbNh6TbZ
         U0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749592790; x=1750197590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38n/wHuxAFqfv+bXMk8iuWO10rdnMupQMWYBFpyvjP0=;
        b=FosnDYpg1c2zhjzzKAhpHL1w/kTSRE00YpaqlVrxvULLbNqdWdEfil8bHNQqJR/Mpx
         TRb8RCnXfGdSc7Jg/2p3E4Jk66RlibYKZgMGIZcCjHX+YkvT3mgEoQunJCYksCBcH9HU
         aWqro3ms/IetPaO1htonfRKBIEpOzCf3FRCUvQlBpciah7YuTUOS/4iRycSH7p2065ki
         O0/CDTQxA2DiYIkq/bfIasjGQYc+Wl4iZZ7N9VkwEsv+xQGLHcOMhFFSGHZ+4G2czCua
         zSYp04YfmBQT5yOR1t5B9w3yPlnbvKCRTk+l7Q1ziefbiNYzb7qrND1ecjP/YC9SJkD1
         MOwg==
X-Forwarded-Encrypted: i=1; AJvYcCUr5x+scTid3XlCCztGNzDA4ARU5rxU9MxinXGQg2ROnrxWDyP4hwVn0RgCYY9GlhTtNiFOJ3JFQ6M=@vger.kernel.org, AJvYcCWVUNmRxXc55uaHLlg0HKzKK+ZcB6midoJpsoLt82vBsqL0ZHiyyD+DxywlA3ur0JnhDZBncfCbFHduS0d1@vger.kernel.org
X-Gm-Message-State: AOJu0YzFhTBvV7lwjTZ3JAjg/fVPbqbUyvn4mCp+ncaCPEyyuaRMOSGT
	m9KLrvodhqLsmQo7LEdqmalzv+s80MAO+z3IfDHIJi5jgld2iQm3pme2
X-Gm-Gg: ASbGncts3fbnr3r+VwtXp4Evh/U3uV8XWDKl1qXrUIbJgAuqKDfvWiBNNaeDcj7lYst
	G5ZLFLxrVAYlxc7wLD4LSAtAz/ZXMKvCU9hyv5VI3uETMRJIa8IutmeW5sapA7MnsQ+kN/80Fh4
	q5aCTMbg3vXoskdyGf8grzB0AQwFhIgxY5dQ1Eb5wrZunpwASwLqOX/9O18ry1ExfwbP3vt2mZ8
	uadrX6Fqly9sFCzh3s3Ho3xhqKngsb1x78eqQOo7hz8+9Wa9VxA2B/N5lX+AptpaUg5vnOsOAqk
	tas/2AKKqNmAEViy/vOXof6JaWIyHCQcIeU3SbcmRC01JnQ6b0Ip33sUh2wbR7eUyz4B4rnrbBA
	+xYi84fpmlvhMG+5gvkr6DLz5xN56RDNR6LABTWYDNN8=
X-Google-Smtp-Source: AGHT+IGVqLp7cfzlbv6IeIgX5XQLg1EU8xkx6mx7eveL+YYGlnUwKoSKNw7QdXeGuFmn4wSjXldcMA==
X-Received: by 2002:a5d:64c8:0:b0:3a4:e8bc:596 with SMTP id ffacd0b85a97d-3a558821f8bmr190540f8f.12.1749592789934;
        Tue, 10 Jun 2025 14:59:49 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f04dsm13312647f8f.73.2025.06.10.14.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 14:59:49 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v9 06/11] iio: accel: adxl345: replace magic numbers by unit expressions
Date: Tue, 10 Jun 2025 21:59:28 +0000
Message-Id: <20250610215933.84795-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250610215933.84795-1-l.rubusch@gmail.com>
References: <20250610215933.84795-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace absolute numbers by their expressions from units.h to avoid
using magic numbers. Use uniform expressions to clarify their usage.

This is a refactoring change and should not impact functionality.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index dcfbfe4cac0f..2c4f045c741c 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -706,15 +706,15 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 			return IIO_VAL_FRACTIONAL;
 		case IIO_EV_INFO_TIMEOUT:
 			*val = st->tap_duration_us;
-			*val2 = 1000000;
+			*val2 = MICRO;
 			return IIO_VAL_FRACTIONAL;
 		case IIO_EV_INFO_RESET_TIMEOUT:
 			*val = st->tap_window_us;
-			*val2 = 1000000;
+			*val2 = MICRO;
 			return IIO_VAL_FRACTIONAL;
 		case IIO_EV_INFO_TAP2_MIN_DELAY:
 			*val = st->tap_latent_us;
-			*val2 = 1000000;
+			*val2 = MICRO;
 			return IIO_VAL_FRACTIONAL;
 		default:
 			return -EINVAL;
-- 
2.39.5


