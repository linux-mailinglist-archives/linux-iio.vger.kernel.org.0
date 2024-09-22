Return-Path: <linux-iio+bounces-9702-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DAD97E26D
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 18:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF8D1F21382
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 16:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E264E208C4;
	Sun, 22 Sep 2024 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6dGwwGe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AB4BA2E;
	Sun, 22 Sep 2024 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727022051; cv=none; b=qi0RvCMvLziekRAely/UaZMcZAkc1T4F4UDUqgDzyyHUorhKeTS2ZhdjuSHfl17H7Qc5nmBy9IM3oedkFC70NZDJ5x5LFH05SWC/zpw1wTXuesIPflGdTCRhGG6K3Wsu+sLlvjNbDl7gUy0m0GrCu4XysE+Zf0SeTFB0IIlDNiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727022051; c=relaxed/simple;
	bh=VLVK8MXysmZ6L/PNZWNeMSlRa8gUmXd2gHrgmbBkB0w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T0sBctC+/fRtp7sl7mRdyUHdqRjv6wQcPZ+Y4+xFT4sxKNH30W9PfW0Briy2ZovMnvr7gQ2f43R01NHazvsV0NKHYex08Es++l95kwmafXl8+VWsgP/WwKgQgw6qR3Rnll8B/DvZeBiT3V0SSs4upp2tR9wPtICNDfTy0NyvWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6dGwwGe; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cafda818aso34149505e9.2;
        Sun, 22 Sep 2024 09:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727022048; x=1727626848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cQyhvSM4HJwpfuLal2TzN7izTBmZh87chYwzJ6Y9BQI=;
        b=a6dGwwGe1V0WmXtOwlU+0k+7XcdYegkSDfsC+nRO/etq9FiQ+EnLtugYROSIWEzUOu
         wKzWODzaKQONma0INSzE2zXZjmX1N7s9y3TL8Cur/y6mIXdJFh/dcDwSs6jXU9iIA2va
         E92pnLn/vW8N6UNMSDz7nnLBtJwnS0auJ/PLq+DUUG160v3kVqgamNTTqAYHL0pkm8tg
         5R9r9/iNICe8p+XOJ2nDB71ikPy7NmFrZaGtAnfZRkYssNK8vu7HpZ1O3wUq1ReoVaLv
         yCjGPbfxgB0H7YVB3t68T8ynZ3D5BtAxzVt9h09cDyVu/90jkc4adNUs2Q0F3Xlvpb4V
         j/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727022048; x=1727626848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQyhvSM4HJwpfuLal2TzN7izTBmZh87chYwzJ6Y9BQI=;
        b=wTNS+1BabOd8vZ6O6r0774un65QQaOyV3T7n+w0pYSAiKZUl9yy5YeDomfSF6uHA8x
         mx7PziSbfiBM72O9WpYhMBSOV5EisXsJjbWv2xdDIh8IgEVxN8TxY+JGThcC+yP/rmGb
         1Q//rvLPWHfI+ntmimJnQ/5YVZ9gfD5/IWZD8STUoyHmPH0XRRU09wicqg0+fGBmeozI
         uhFq0kZTOv8p3424C3vBUfFa00IcYhNCMhLbR/W8cNx1b0McY4g6xiWethsDfWo7sDRk
         m7FMse0sA/5t7aLU7MHL9V1MlRG8+El9xMTu7rbijOxMHZE+AOFWzGpFTYSA1J9HOsnA
         5TqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkOzRrclFFD4Wyffp/j26074aP3/4ga0LZ8+E/xqu6wLGr10eLm3NBMGCW+SCpjFG7uW3yUcxY148=@vger.kernel.org, AJvYcCVulPDXGZyz24E9r8vquwT5ogPK5gUTjZA8+4cYQphr4zjy3ZY5f2sIBvuad8q/L2aLRbMx6sUo4XgXbe5q@vger.kernel.org
X-Gm-Message-State: AOJu0YzW/F0268EulVSkK5UEF2S7qoX4urbQlxyh8Tfi+y/c3xxCMWLc
	s/IzHaclFLdhBOcY+IEzpYvOtnyk1X0hUYiMB/Phn2nqQr1fl/K3
X-Google-Smtp-Source: AGHT+IGL9sO3gv9ytDZtcaV+GPim1OF3aSGYLJ18k6ZcSCY0DSgORcQds4wwGvWbt9uMv1v4pg0ktw==
X-Received: by 2002:a05:600c:4f48:b0:42c:b16e:7a0a with SMTP id 5b1f17b1804b1-42e7c16f861mr47250605e9.20.1727022048203;
        Sun, 22 Sep 2024 09:20:48 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:7367:3ea8:c47e:88f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754c6dbcsm104566485e9.46.2024.09.22.09.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 09:20:47 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: andy.shevchenko@gmail.com,
	u.kleine-koenig@pengutronix.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH RFC v1 0/2] iio: Simplify IRQ and trigger management in RPR0521
Date: Sun, 22 Sep 2024 18:20:39 +0200
Message-Id: <20240922162041.525896-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an RFC series, because I have no way to test those changes apart from
compiling them. It was just a bit unfamiliar the way the trigger and irq was
working in this driver compared to the other ones so I did a bit of digging to
see if we it is actually needed and if we can simplify it somehow. Plese let me
know how this looks like.

Vasileios Amoiridis (2):
  iio: light: rpr0521: Use generic iio_pollfunc_store_time()
  iio: light: rpr0521: Drop unnecessary checks for timestamp value

 drivers/iio/light/rpr0521.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)


base-commit: 8bea3878a1511bceadc2fbf284b00bcc5a2ef28d
-- 
2.25.1


