Return-Path: <linux-iio+bounces-9689-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172E897DE32
	for <lists+linux-iio@lfdr.de>; Sat, 21 Sep 2024 20:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38EC81C20CA2
	for <lists+linux-iio@lfdr.de>; Sat, 21 Sep 2024 18:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249B25589B;
	Sat, 21 Sep 2024 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxCl8APu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E64726AFC;
	Sat, 21 Sep 2024 18:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726942787; cv=none; b=fIOuKtBW2o2cwN9bnn/8X3Cwc5ZvuxWvgMsY4EKQsmim4YZditBiTW8h4J/bCqC7V8FtrcougZyfaOIkErrDabA1xr83UbJPEti57lf1qzbeDeUp0UiLBMd1HYmdxzbUU7Cgn00f94lM2tI2qgKjK1gom7/VW0dWJIZc6Ajy0hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726942787; c=relaxed/simple;
	bh=mwalr7VrvIcrtEf9sSDPwhNxlwWBY/6+yMfWIXs1uq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZFRbB+LqBwRkXhY9XNjngjZGqOICdEStUP5OE59TZA2fsDNtRTg7ipmWeG66okqHrb+7g+f2HTvzoTvE5cZfp+e57C/HMORCry3px+kEeRfdaB9JEuzaoCcXfj5KxpwIWyrEk6WireV39vLM/aPDKqMJNq5r9M11vQVZu9X4V6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxCl8APu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so26621315e9.3;
        Sat, 21 Sep 2024 11:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726942784; x=1727547584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+CujGxHvINZLu20PICcYwIYLWP2GswRl8+GAJJOTTs=;
        b=OxCl8APuAIo/NweL2s4ip5lLzyDifJVCMC+VDaiIQHQyYjfs9s/PlpvaAxC6M1B5gh
         eAoZisgXWPlIzLb9CsldGyKevtXgRJNzs/ZEm0Bi4SwbNTkPM4uAm55FYg0rjmO5y46j
         nRE9pYbwStFyessY/hoDmP5wS1a8coqrXLGSzU6Jw4cbKAwcpR0rNzMmiz43fBeDhGad
         8YTiIYRIEK+w1J0f5hD1gBPCJQa4CB+bkx5xBDrjcAbhJF+pDdKfxuyt7gSubX49hYZM
         sJHnT4zuoUuIOP0vYIQxWzJtIPl7s5jXRc4noAqamkB9rvJ1YUSoq7oEvKKdNOATY22e
         lzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726942784; x=1727547584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+CujGxHvINZLu20PICcYwIYLWP2GswRl8+GAJJOTTs=;
        b=ifJzSJDc41hsk1RdelJrMFCQVzw5eQCaN36lEon8CUZ8f2jgDKJ9oUOnD84GuQ9EJ9
         Ada6Cz7Y/YVDVwiaSZrhArDTmfQ/bxddjLZSsHRUCCFnWyRWxMDLrZPar6etaReVYvB1
         wp1pq8Xn1r5+P/Gtsx910HpLVyGYxGiD4VO1G/XXSB1JkqW45YQdYuV2wL+dsys3S20l
         +xbmKd1AkDD38B4vnzoT8YvizJ7GEhB+NrzR54FqyUnlwTUZTgVP8ku1vbvr+QF2v92h
         FeBqkhQwJjYCBK2a+MlQHpKC2pc7rixXOnp4Ve4SLDThfEXop8UeCSaP3VIJ0AgRInrl
         Ddsg==
X-Forwarded-Encrypted: i=1; AJvYcCVOsRvSh6YRqKWkelH7aKK+MNtSv8EnqSD4BBpYxanO2Py5Jbbj12fp3KnyOxTTiB7BDQVyYrgim0C1vMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFCn/rAvcEGtnAVqgRM90SZxApdI5lUQxKQiky/P0EyOSRkB/H
	l+YGHwQKD4ejrBm3Fgp3O3/jTvnrJp5cwCNkFjMl+ujXt2LNPM8IBqZopg==
X-Google-Smtp-Source: AGHT+IEmrJc/UOSGwPp/syNI6LwnjAVrSrWSm7JqqIdMzVBz++2/MSyxlfSnLvQxLgKaRXb5xei2JA==
X-Received: by 2002:a05:600c:3108:b0:42c:b63e:fe91 with SMTP id 5b1f17b1804b1-42e7ad88a07mr43741475e9.24.1726942784540;
        Sat, 21 Sep 2024 11:19:44 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:a498:414b:b435:bfeb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7afa9c93sm55494315e9.18.2024.09.21.11.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 11:19:43 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	mazziesaccount@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1 1/2] iio: Drop usage of iio_validate_own_trigger()
Date: Sat, 21 Sep 2024 20:19:38 +0200
Message-Id: <20240921181939.392517-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240921181939.392517-1-vassilisamir@gmail.com>
References: <20240921181939.392517-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change iio_validate_own_trigger() for iio_trigger_validate_own_device()
since they are the same function.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/accel/kionix-kx022a.c  | 2 +-
 drivers/iio/industrialio-trigger.c | 2 +-
 drivers/iio/light/rohm-bu27008.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 53d59a04ae15..0487610bab33 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -873,7 +873,7 @@ static const struct iio_info kx022a_info = {
 	.write_raw_get_fmt = &kx022a_write_raw_get_fmt,
 	.read_avail = &kx022a_read_avail,
 
-	.validate_trigger	= iio_validate_own_trigger,
+	.validate_trigger	= iio_trigger_validate_own_device,
 	.hwfifo_set_watermark	= kx022a_set_watermark,
 	.hwfifo_flush_to_buffer	= kx022a_fifo_flush,
 };
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 54416a384232..3da8b8c25185 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -315,7 +315,7 @@ int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 	 * this is the case if the IIO device and the trigger device share the
 	 * same parent device.
 	 */
-	if (!iio_validate_own_trigger(pf->indio_dev, trig))
+	if (!iio_trigger_validate_own_device(trig, pf->indio_dev))
 		trig->attached_own_device = true;
 
 	return ret;
diff --git a/drivers/iio/light/rohm-bu27008.c b/drivers/iio/light/rohm-bu27008.c
index 0f010eff1981..12cfaa7614ce 100644
--- a/drivers/iio/light/rohm-bu27008.c
+++ b/drivers/iio/light/rohm-bu27008.c
@@ -1386,7 +1386,7 @@ static const struct iio_info bu27008_info = {
 	.write_raw_get_fmt = &bu27008_write_raw_get_fmt,
 	.read_avail = &bu27008_read_avail,
 	.update_scan_mode = bu27008_update_scan_mode,
-	.validate_trigger = iio_validate_own_trigger,
+	.validate_trigger = iio_trigger_validate_own_device,
 };
 
 static int bu27008_trigger_set_state(struct iio_trigger *trig, bool state)

base-commit: 8bea3878a1511bceadc2fbf284b00bcc5a2ef28d
-- 
2.25.1


