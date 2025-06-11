Return-Path: <linux-iio+bounces-20479-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 870B8AD5F4F
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 21:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8F917B179
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 19:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66662286D57;
	Wed, 11 Jun 2025 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMuuiNH1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FD42BD5B9;
	Wed, 11 Jun 2025 19:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749671276; cv=none; b=gEg5OYfr+Is4tEuzfqFqbb+1DDi6Xafg3WlideBvWxnljBNkAeLS0kPdtMTPsYCMFxJoYLQG6wSNpbqj4KWaUJ2cXrSMnN16ODEsf0GEAGoe8UsXk4w4Ap+2FtseSSnQVNmdo2nkAvWwdPfzpDtuY055gB+6OhZ7AbFQ+VpEOZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749671276; c=relaxed/simple;
	bh=smzX7C3twUdA1NNM8wBfAOff/YFksIjG59CddnyWsXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udTmNJGZVZ8RvGxCJQUwPKcaUpW2HuXKQuD2rza3apikeUpQQ94e2PFrYSzRgKixuV9HVG3UmhbVXnmXHqxZFmslOtCx3Qbjwoh4W6PtcB654Pzw++iSfX8wPc4XEb8xWv+Cok9DhxemWUjAZFrV3HJYmYROgSyTvwxinEfxo5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMuuiNH1; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7113ac6d4b3so1410947b3.3;
        Wed, 11 Jun 2025 12:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749671273; x=1750276073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCE3dDRzDVwJNp9h/otx2hIV9aBHTXeqV3g5kT6Wtz0=;
        b=IMuuiNH1SMd/v3wpea98vLqmc55DGar7viCvT0+DpNt0Z0wdWz+yqCEPa/WStjkQ3C
         qI9rb9MP/mXa82c2osCL9HS/4hwhjGLXXFr5HPMOyxppqnBqDhqxwbPdq8OifvZtnt5O
         Wh/KAzhUJRvLX8peCL54PoBwmXLekrNfn6Y4ESYD13hLd5K9ZxHxCUeH5AMhMLdibT4g
         MgdAjjmxw8AnISUp3hynV0Nr90f2BkWFQsRIuvRkRR77cAebA9OIYmU4DXQy8lOgNnpq
         dmO8Dzn0zpVQXuNQX0Awbpwn4MGLPdzAuHpLU1c4Y3UsQH8lnJiNTymYIP+azpRL4gek
         Yo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749671273; x=1750276073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCE3dDRzDVwJNp9h/otx2hIV9aBHTXeqV3g5kT6Wtz0=;
        b=UlnzNBP+bfrJICvu/hFjDufH2Tg8v/3ULqJ/f0dMEim6S7IJQSb9bRiCF8g35srtfY
         EdbypHlbjX6/B44RNvv8tEgi9jOM9CIga866W4eKHmHHGyyiYhFwwVvcSzX/wMDYpPBj
         HEravyycglU8HGkC6SMrfr+1DNLTT49XEoVw1dY0jpiNOjiCA7EC8EehmorwOWtCaLsV
         81npSCHwYuqr8ai2x8C1KsgAu7GzVLqpVILIOI7MrAPMVy2VSe6lAmPKs5MwoTXt5de5
         3eX9jJr3JndUD5JUMiGGG7XRTH6usBYKQ9i+lKGnZ1+U0Gf2iH9DrIyu4uoA+9Thdfx0
         6wgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcWS+zDmkG9IV8t1xx4/gsLa8sq56wesRkKsERXDxNrpjg+KYjSBEvG6zz43yHDcTGvGMy8S463WqoDtsB@vger.kernel.org, AJvYcCW/5DFZ0l8qCaAJk6IFbENWDxJzJTGz9D/E8rp9vLn5OGvLFTDyBoGjgmDuGqU8/zpdkOhrI56meII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5VsPWbfBlcABjNMES0P5Cb+0XtpLMy9H0gkLl9Lktq84xv5ym
	3WGU1EUZAT9Vs2o/fcPnyj6BXW3OfwEvzG/BLsRbrKnIRYSNfOlYZwaC
X-Gm-Gg: ASbGncumR4/PaRBMXXyb/M8rTXrfzqxsS1Vkky7BNBJ6iuimv3G8bz7Ysr4FwLYnJ/s
	BJlr/DbGNMtrEbvos1Z2ahdJVp58bnaGosiSF0tesNEq6X+C1vq0Qco/178twPA7bXEcm8D9K+h
	E2JJplfJpDgjBZdgIdfHpVpLomTptA1QzEOW9wjJ5CuKLWpr4Niwvbs+FMHG8kr+a9WgXoPF9zP
	ycVxJDivuvU1+D61AsNUXDryII0AzbrGyScBd0eujenjpfRsE+pgQ9AFAFOer3IkmGhYPB11dvZ
	T7TPPW3H7ouMYvVG1RtuA8mcIYSlrl4SqE0HG4S3cLGPzaK+R0FFIKxoMmXQr47dISj1vKO7dcU
	1fAni
X-Google-Smtp-Source: AGHT+IHNKAtp0ckn1BlkBoqTrbyKeEmqJrBsZRzKSwy0gcvXHEv1bxh0pUIcRmOMiPlgmUhaL2bKAQ==
X-Received: by 2002:a05:690c:4991:b0:709:19f7:d7ce with SMTP id 00721157ae682-7114ed83dd5mr16839437b3.31.1749671273522;
        Wed, 11 Jun 2025 12:47:53 -0700 (PDT)
Received: from delta4.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7115206130csm80587b3.1.2025.06.11.12.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 12:47:53 -0700 (PDT)
From: Andrew Ijano <andrew.ijano@gmail.com>
X-Google-Original-From: Andrew Ijano <andrew.lopes@alumni.usp.br>
To: jic23@kernel.org
Cc: andrew.lopes@alumni.usp.br,
	gustavobastos@usp.br,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	jstephan@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] iio: accel: sca3000: replace error_ret labels by simple returns
Date: Wed, 11 Jun 2025 16:39:19 -0300
Message-ID: <20250611194648.18133-2-andrew.lopes@alumni.usp.br>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611194648.18133-1-andrew.lopes@alumni.usp.br>
References: <20250611194648.18133-1-andrew.lopes@alumni.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace usage of error_ret labels by returning directly when handling
errors. Cases that do a mutex unlock were not changed.

Signed-off-by: Andrew Ijano <andrew.lopes@alumni.usp.br>
Co-developed-by: Gustavo Bastos <gustavobastos@usp.br>
Signed-off-by: Gustavo Bastos <gustavobastos@usp.br>
Suggested-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/accel/sca3000.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index aabe4491efd7..bfa8a3f5a92f 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -369,23 +369,20 @@ static int sca3000_write_ctrl_reg(struct sca3000_state *st,
 
 	ret = sca3000_reg_lock_on(st);
 	if (ret < 0)
-		goto error_ret;
+		return ret;
 	if (ret) {
 		ret = __sca3000_unlock_reg_lock(st);
 		if (ret)
-			goto error_ret;
+			return ret;
 	}
 
 	/* Set the control select register */
 	ret = sca3000_write_reg(st, SCA3000_REG_CTRL_SEL_ADDR, sel);
 	if (ret)
-		goto error_ret;
+		return ret;
 
 	/* Write the actual value into the register */
-	ret = sca3000_write_reg(st, SCA3000_REG_CTRL_DATA_ADDR, val);
-
-error_ret:
-	return ret;
+	return sca3000_write_reg(st, SCA3000_REG_CTRL_DATA_ADDR, val);
 }
 
 /**
@@ -402,22 +399,20 @@ static int sca3000_read_ctrl_reg(struct sca3000_state *st,
 
 	ret = sca3000_reg_lock_on(st);
 	if (ret < 0)
-		goto error_ret;
+		return ret;
 	if (ret) {
 		ret = __sca3000_unlock_reg_lock(st);
 		if (ret)
-			goto error_ret;
+			return ret;
 	}
 	/* Set the control select register */
 	ret = sca3000_write_reg(st, SCA3000_REG_CTRL_SEL_ADDR, ctrl_reg);
 	if (ret)
-		goto error_ret;
+		return ret;
 	ret = sca3000_read_data_short(st, SCA3000_REG_CTRL_DATA_ADDR, 1);
 	if (ret)
-		goto error_ret;
+		return ret;
 	return st->rx[0];
-error_ret:
-	return ret;
 }
 
 /**
@@ -577,7 +572,8 @@ static inline int __sca3000_get_base_freq(struct sca3000_state *st,
 
 	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
-		goto error_ret;
+		return ret;
+
 	switch (SCA3000_REG_MODE_MODE_MASK & st->rx[0]) {
 	case SCA3000_REG_MODE_MEAS_MODE_NORMAL:
 		*base_freq = info->measurement_mode_freq;
@@ -591,7 +587,6 @@ static inline int __sca3000_get_base_freq(struct sca3000_state *st,
 	default:
 		ret = -EINVAL;
 	}
-error_ret:
 	return ret;
 }
 
@@ -834,7 +829,7 @@ static ssize_t sca3000_read_av_freq(struct device *dev,
 	val = st->rx[0];
 	mutex_unlock(&st->lock);
 	if (ret)
-		goto error_ret;
+		return ret;
 
 	switch (val & SCA3000_REG_MODE_MODE_MASK) {
 	case SCA3000_REG_MODE_MEAS_MODE_NORMAL:
@@ -857,8 +852,6 @@ static ssize_t sca3000_read_av_freq(struct device *dev,
 		break;
 	}
 	return len;
-error_ret:
-	return ret;
 }
 
 /*
-- 
2.49.0


