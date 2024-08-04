Return-Path: <linux-iio+bounces-8234-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61C8946F49
	for <lists+linux-iio@lfdr.de>; Sun,  4 Aug 2024 16:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3E321C20A51
	for <lists+linux-iio@lfdr.de>; Sun,  4 Aug 2024 14:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DA6524B4;
	Sun,  4 Aug 2024 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8XZNXHY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE8A39FC6;
	Sun,  4 Aug 2024 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722781422; cv=none; b=F9s8ir+iEmWCZo0wuy+q4L8MZcT9dO8SmSQDPHaoKdKg0bLgt1zixQZhqPuk7VN4gGXPUxiG0z1F56gcgfTMpIwbrmi+8InFuD8BMUTtbhOio6CW/3G+47znCQalyJsRaRUOCXB8MxqJR+0ucqYwFTEclBo9i6kcZi+hribj2vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722781422; c=relaxed/simple;
	bh=F7SZ7VgS66I8SNcvaE7vcV8Nqj0nYfi0XhxybIAm18w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WZeWyrfLgloeDWPHY2uHfHk2rw1ZTcWVMQ+Zq3YsCj6KMWs8sLxJaTDb1acpBKSn+iSZ3yRoVktni09DHS0g0dJcgiubssf5huqnTtp3UUrvcpOhspvRapz4OrjM7AokRWoMZnzJDoEdzhgSax2v2kxBzLuvllzIGkBzXRuabyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8XZNXHY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc566ac769so69627055ad.1;
        Sun, 04 Aug 2024 07:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722781419; x=1723386219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YWJI3MQBVLDTzSxd4uCl/z6amcgyuSHjzeHCgekSREk=;
        b=U8XZNXHYYclYiUTkf5u+t9CqAcu1vMQ89Pxy7VoWVpsJiQh0FKyTuXXkg5POvQjTZs
         UReQlKWgCfnl60iyQ8evekRbUHif6iKQ/yD+JjQMBFjtLB366WBiRT4Ut/Xsye/MoZxV
         yuRfF+zFFHhp+YFCUYPVf/fEFl/Mkm2qTSHqjkqjqXGlZJdH/oivjxkmoKCndgnVTQr7
         CdcfPoM7Vmqxkq21yw7z5cFjDX0JP81Q8YW6Fd81MDJV2Ylb1TuCDyoJU7rNsRoxuXII
         SFDEMZsIJc00EeibNatkPpWZVL+MwMaG69px0XSHqP631z0S10ftdRlwXyf0Dnj4aboo
         9zQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722781419; x=1723386219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YWJI3MQBVLDTzSxd4uCl/z6amcgyuSHjzeHCgekSREk=;
        b=dUOtHyXEgJi2qUv5d0HNtOOgybwqn2+ZMOkQ5vn34ER/vQwp5LCWy3n/HI/Pmzv85Y
         wudXqGsEXVHG2LUC/nohbbS6vOhw3qLflqW13I604EYk0bhHBuVGmx20U7j8ffHtFo/F
         pAF3ljitZWMNPPvb79GodJjiKywM3nW5fN97Bv9h86V5tC4z5yGGWb3rtM8DwBgNGFgN
         44e19yiC6QyugwtlbZAPv9BaXU5NN33ieMNjo7Zn2w9sYSLMQKyCawQU9agB/3OM1gBP
         jsPlCPzTeSLl5HYunGZVI07SeBIRiVFpOmglMz3HxP8SctM1BUHsWoxqksbvYKITiCho
         gq2A==
X-Forwarded-Encrypted: i=1; AJvYcCWmRW/4VtDaTfBcSJcfEvgn3DsJEP5vGKwd0NiRQMRiO+NyyE/R/RdoLXWpElOUlTJhKMXon19RvfpGMz4UyIeIrOrsZpXnOUI9c9G5
X-Gm-Message-State: AOJu0YwI0kkKN+jMvb/07fXPGWvO3JVNcJiRDAQ+TY/Ljv8YzbghJCEs
	jCwLVJhF+sgl5Ju7fusVU5GSVx4gmmteaUt7cvodSDgpH2p8XkRahTJb8MnnHAiKbw==
X-Google-Smtp-Source: AGHT+IHb/eNV/7mWNkTh18nYLS5rphIb9rhKGnLuKtFrw0FBtuXs6D6PH9x/CYpkVsE7oEYzcvlEQQ==
X-Received: by 2002:a17:902:ecc2:b0:1fb:fc96:757e with SMTP id d9443c01a7336-1ff5730969emr82166175ad.37.1722781419376;
        Sun, 04 Aug 2024 07:23:39 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ff59293a90sm49735375ad.235.2024.08.04.07.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 07:23:38 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v7 0/2] Add light channel for LTR390
Date: Sun,  4 Aug 2024 19:53:19 +0530
Message-ID: <20240804142321.54586-1-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The first patch adds a new channel for the ALS feature of the sensor.
The same configuration of gain and resolution has to be provided for this
channel as well. As there are two IIO channels now, we would need to
switch the sensor's mode of operation depending on which sensor is being
accessed. Hence, mode switching is also provided.

Then the second patch adds support for calculating `counts_per_uvi` based
on the current gain and resolution value.

Changes in v7:
- Changed the `ltr390_set_mode` function to do better error handling.

Changes in v6:
- Changed IIO_CHAN_INFO_PROCESSED to IIO_CHAN_INFO_RAW
- Changed the scaling code
- Link to v5: https://lore.kernel.org/linux-iio/CAG=0Rq+q0WJzMroYwQy-4Ng0aSkTvaw-FEMx68i3MqAZwfteCg@mail.gmail.com/T/#t

Changes in v5:
- Replaced the IIO_INTENSITY channel with IIO_LIGHT channel
- We calculate the lux value directly using `als_data / (gain * int_time)`
- Provided a scale channel where the scale is 0.6 * WINDOW_FACTOR
- Link to v4: https://lore.kernel.org/linux-iio/20240730065822.5707-1-abhashkumarjha123@gmail.com/T/#m

Changes in v4:
- Added "bitfield.h" include to fix `-Wimplicit-function-declaration`.
- Link to v3: https://lore.kernel.org/linux-iio/20240729115056.355466-1-abhashkumarjha123@gmail.com/

Changes in v3:
- Added cover letter to the patch series.
- Fixed indentation in the patch description.
- Patch specific changes are listed below.

[PATCH v3 1/3]
	- Cleaned up the spurious changes made in v2.
	- ltr390_set_int_time and ltr390_set_gain now return -EINVAL to
	indicate no match.

[PATCH v3 2/3]
	- Used enum ltr390_mode inside the ltr390_data struct.
	- Refactored `ltr390_set_mode` function according to the comments in v2.

[PATCH v3 3/3]
	- Simplified the formula for `counts_per_uvi` calculation.
	- Removed spurious whitespace changes introduced in v2.

- Link to v2: https://lore.kernel.org/linux-iio/20240728151957.310237-1-abhashkumarjha123@gmail.com/

Changes in v2:
- Split the single patch into 3 patches.
- Used FIELD_PREP to perform bit shifting.
- Used enum for mode selection instead of defines.
- Fixed indentation and whitespace issues pointed out in the comments
- Replaced `mutex_lock(&data->lock)` with `guard(mutex)(&data->lock)`
- Provided available values for gain and resolution via `read_avail`
  instead of sysfs attributes.
- Refactored `ltr390_set_gain` and `ltr390_set_int_time`.
- Used early returns instead of single exit points.

- Link to v1: https://lore.kernel.org/linux-iio/20240718104947.7384-1-abhashkumarjha123@gmail.com/

Regards,
Abhash

Abhash Jha (2):
  iio: light: ltr390: Add ALS channel and support for gain and
    resolution
  iio: light: ltr390: Calculate 'counts_per_uvi' dynamically

 drivers/iio/light/ltr390.c | 115 ++++++++++++++++++++++++++++++++-----
 1 file changed, 100 insertions(+), 15 deletions(-)

-- 
2.43.0


