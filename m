Return-Path: <linux-iio+bounces-16673-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA769A5962D
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 14:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16E5163076
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 13:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D90229B23;
	Mon, 10 Mar 2025 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b="KkXeiQyz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30532846D
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741613144; cv=none; b=r/8tyv2e8dtPExI+sBYnYMyecxjNTpDe7Mpf+10ikh+n0b204T2H02zYMw8JT5Xcvvt3XmZnc3cAM+CqbLggrkGTQnXq9lEEIhaip2YcsVeUggGf7hnmgq+WerzRDAQup3UWBoEhK5B5NBL0VldEMe5dAAMgwQdMle5svYsddnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741613144; c=relaxed/simple;
	bh=YrADBiheJchAyAdCNqc9RprXi1WRoKmHkKStj8Ms0Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tV9bchAkA1M5VsiBYF3jC7gfhPYjuUIw1W3LAeSLq2TyRoViDwAUZ9Ezl7JIPkNDgjt2xZyX9jMWEhS803C1GLeU5jMNrLI1QZeYsBKdqfXe9GuHnACW1YXrCPq1cIh8uAMNzTkmF7S9a+LsSLfPweWB8dCJ2Gl3UAk+rLTIfLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it; spf=pass smtp.mailfrom=4sigma.it; dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b=KkXeiQyz; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4sigma.it
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bdf0cbb6bso23929715e9.1
        for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=4sigma.it; s=google; t=1741613140; x=1742217940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uB3e94MFj8rTJRt3M09+UlwEYAG3T1Bpr1A/4vExtqY=;
        b=KkXeiQyzopcCXQNeo2U0TbzRbbq8ee6zYhiivpaO/ED80LSlWFQivRylJyXsFHRWRD
         /UnC50Wr30JfGiRyjPnktZiJrbjjxLEkGuQ0CG7AY0ck41uSiJZxxWuqpliIlQp5xWML
         mGiS6zBeys0dEWLsfZ2A9sRUqYktVxpyru3+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741613140; x=1742217940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uB3e94MFj8rTJRt3M09+UlwEYAG3T1Bpr1A/4vExtqY=;
        b=fFoiugu3G/v2wDq07uOmZM9RJY3uOVu1tL+Qlmll55Zf9cIZtTQXrGFwtCGsG1OIod
         yX/ktDMDWrQ3k3LJMGmXOVbDoWyCkTpVM8Hvf7pdHcP9DbhPb6fb7XLLKMFG5V2UGCzC
         dWqgDu1uXef55NBP7G6Y5wt3zYdDtFsxar/HTJQPRFKWAzEZiq1PQBJTGDHBsL5by8td
         RkT3JY6nggx+SRceCTW0HuVBy1ib+Eo0qehNpdZMYm6Tnfc/QegxkHRImSzgJXT/MkGR
         uH0iN5HlfoICjsfycXPojpkvvUf6XX6gBN8KOBYTU6/LRUbIAhd83YVQrxmVJ5Ewu1to
         AiVw==
X-Forwarded-Encrypted: i=1; AJvYcCVHS7ArBEtqlVareGBbhsBK9bhkv/aN1qz0aswGxR7jHx9cfmDKJmrhEcER3mZzoUofIUdUFDcXLbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa1dpcacjdufBHmvU7+A0W1ECqflh7xJ4Q60D2pji7YE/KVZIk
	dDcduCD0NzS5DVmeNaix9qMyiH7OsqAJX1ODwlNZO3KjWiyP4etqp7DaA3Q/Nw==
X-Gm-Gg: ASbGncvn/ANzkiaect9oQtkcDVMOcuI5dncbiFA9Y8q20BJLuoYtxMXLg6Xfda9BBEK
	FhhJDrmGPUoA/wvhzirngaE4praQXnAfpwIymlXoawrcErVOWanSC2YaNo1TbE2DdLUnYDecMpc
	VITtP5NqRhyiEoNdtGFvAtQYRKXu/HJs7V6pq8BtVkKyVOch1+FPaxeMDzAARw/UF2UViOFZIsY
	9nL/mHSHI9MRyUjkNdV3jpY5dx0Bt/LM0wo7vb5fZz52bv1TCd5CXLX/KFkkGW1vePcQA4DK3O7
	j31tC/UyPQKQm6tv7VxG97cmTn4m/DAwV1j6EHHP2pRBDLL/8fFnmA65pCPfGU7BBQIJ9QbX/I3
	+4u3g+KA=
X-Google-Smtp-Source: AGHT+IE9sjaOWti2nWlnXm70Bf6OEGxgj1h0tw7FKu5GsXjvCPFTORvOO8LpxkXl9SJv0ptxnOkylA==
X-Received: by 2002:a5d:598c:0:b0:391:45c8:3829 with SMTP id ffacd0b85a97d-39145c83c49mr3312166f8f.23.1741613140359;
        Mon, 10 Mar 2025 06:25:40 -0700 (PDT)
Received: from marvin.localdomain (83-103-103-194.ip.fastwebnet.it. [83.103.103.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfcdasm14638099f8f.23.2025.03.10.06.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 06:25:39 -0700 (PDT)
From: Silvano Seva <s.seva@4sigma.it>
To: lorenzo@kernel.org
Cc: a.greco@4sigma.it,
	Silvano Seva <s.seva@4sigma.it>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix possible lockup during FIFO read
Date: Mon, 10 Mar 2025 14:22:37 +0100
Message-ID: <20250310132508.24660-2-s.seva@4sigma.it>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <Z8sFdGG4bDyALrsi@lore-desk>
References: <Z8sFdGG4bDyALrsi@lore-desk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent st_lsm6dsx_read_fifo and st_lsm6dsx_read_tagged_fifo functions
from falling in an infinite loop in case pattern_len is equal to zero and
the device FIFO is not empty.

Signed-off-by: Silvano Seva <s.seva@4sigma.it>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 0a7cd8c1aa33..39a7e15ae9ae 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -392,9 +392,14 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 	if (fifo_status & cpu_to_le16(ST_LSM6DSX_FIFO_EMPTY_MASK))
 		return 0;
 
+	if (!pattern_len)
+		pattern_len = ST_LSM6DSX_SAMPLE_SIZE;
+
 	fifo_len = (le16_to_cpu(fifo_status) & fifo_diff_mask) *
 		   ST_LSM6DSX_CHAN_SIZE;
 	fifo_len = (fifo_len / pattern_len) * pattern_len;
+	if (!fifo_len)
+		return 0;
 
 	acc_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
 	gyro_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_GYRO]);
@@ -623,6 +628,9 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
 	if (!fifo_len)
 		return 0;
 
+	if (!pattern_len)
+		pattern_len = ST_LSM6DSX_TAGGED_SAMPLE_SIZE;
+
 	for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
 		err = st_lsm6dsx_read_block(hw,
 					    ST_LSM6DSX_REG_FIFO_OUT_TAG_ADDR,
-- 
2.48.1


