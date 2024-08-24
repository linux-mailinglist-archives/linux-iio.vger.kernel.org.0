Return-Path: <linux-iio+bounces-8766-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A9C95DE44
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 16:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA7A1C20AAE
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 14:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A27A1509B6;
	Sat, 24 Aug 2024 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d50MFR94"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4775684;
	Sat, 24 Aug 2024 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724508699; cv=none; b=TOu1JNTafHvb2sLbgsXmP7SQA7DVqqXCa1ix2i8lzWXIbi40DK4tYY2kJFhaLaH4qtYIWs48FdXH8FQlB1zkauMCqUmWTsTyQrP8H5z9oUbUGrf5uvT/+biPdZ2dD1K2+jRsnfvb7u0YmoqGMAPh9+4w1DJJQ2+1oaiVeCbphKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724508699; c=relaxed/simple;
	bh=el5g8EjgI7ujTT5IDKB2mejP4XX43NJSqTyNLGJwfUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrR2l3k6MSQdorHIkHtzR2LO8z3SY/jI8pbgBiNlquc7qucIDtfLCPVtLAKkzKrKvZ6s2TahM6+G0UP2pogKy4Xb+T5w9i2j4ZNT/8XOrIQWw2YjXz+Gdx+mvNcr18BHwcfIzEyxTK2zvZCbhEDe1NfYX+CyWICB9Rlrv9b8BGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d50MFR94; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3718cd91185so1464824f8f.2;
        Sat, 24 Aug 2024 07:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724508696; x=1725113496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOfgtpLj5kVyrTGG8p96eBlXRzfkS1PEwfIicl9tXtk=;
        b=d50MFR94l4ABEUmfCEAmtg2hKgkCZ7XcaPYBEg9egkE9LcZtaISa/ZcbiKNSxuume/
         4ZhdOIztBFOyR5zzLfXJ+HgfNmf4Z7z/tIYKIlXg0AM3pMXa0GkCy3M1V2HwPQmAd3US
         m0kHdRV0b9gNYcYrCe7c8RR+jOQSXoUEsmgg8dU0QQbPWqcuhOoZ/4b1kW5LbqCKgKlG
         uOcRoB2sXOcJfgGvNYYRBRveQ5++dNHFi48zt7U5Vb9v1AMGnesQXiTqDayoPHIe7uXS
         8s/pKL2F5l7ENGvRT/yyoUuPTdG7tZYkv3dDaGVMmg3IVCRwjGRBatehqswcaAp5+Z9j
         xFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724508696; x=1725113496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOfgtpLj5kVyrTGG8p96eBlXRzfkS1PEwfIicl9tXtk=;
        b=skqAbAa99m5XIelxUyPTe97Wuppnm93/dFnhlVi6+YeSh3GKG+3UKW4IQjknnhnqx4
         1ssXhvYnXo6YO3U9C015Mp/u++MziCxQJPYmgsfN1aZDczyCHhwSkGoD3U3CPSzCb6MI
         ZOWAoVsXTlCuJJftovSJ6UIO9ipAN9yOQ5FoyHd8QIDllvhTpikptxwQRgEo+2O1JC5j
         vBl1xW7yt6UKGAbIlvIfCW5LUGRyUEGrCW8vt7ukNZ9/EJZxK6iJ/4A7VXD6nheHP5I1
         mSeMDQwWmVMyJvhNREXU3T5bP/+E3W8Ev02BYtKDub3r0vTjwNuERdzkWxBEiKMJKc/8
         e4Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVumNdcOyMFRBmK+J/6XnXYgDBStqlQvCDcDKX1FVxdH8HM80X5tKGSUSRbNyycIV3A6fCKXPveuyox02vW@vger.kernel.org, AJvYcCW1H6NuUDgC3sUIGSKmhvqoOKJ3sthJPAXqycb48KBXm6RJ7HHsarMlDHInXInOQHLvDzmNLQLk0vI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIWRo8J4h6c4xG+sbBKrfbDW+qgvG0EmmGKgTecnuj60lM/ceB
	fp683ECGFIjqwh1nfzNswWhYRgtMTDO6fuJjqDbTDFJTYT4/x7xw
X-Google-Smtp-Source: AGHT+IElju49k+3n9zGWNBvysJnitIKsLiUPcCK2PVsYtpYFs19K+eLFgU1+uigXLerGm3G2V5YR4w==
X-Received: by 2002:adf:f40e:0:b0:36c:ff0c:36d3 with SMTP id ffacd0b85a97d-3731186839dmr4291474f8f.29.1724508695481;
        Sat, 24 Aug 2024 07:11:35 -0700 (PDT)
Received: from localhost.localdomain ([151.95.114.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730821ab05sm6591427f8f.98.2024.08.24.07.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 07:11:35 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jagath Jog J <jagathjog1996@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D . Jones" <luke@ljones.dev>,
	Jonathan LoBue <jlobue10@gmail.com>,
	Denis Benato <benato.denis96@gmail.com>
Subject: [PATCH v3 0/1] iio: bmi323: have the peripheral consume less power
Date: Sat, 24 Aug 2024 16:11:21 +0200
Message-ID: <20240824141122.334620-1-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240823192921.7df291f8@jic23-huawei>
References: <20240823192921.7df291f8@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bmi323 chip is part of handhelds PCs that are run on battery.

One of said PC is well-known for its short battery life, even in s2idle:
help mitigate that by putting the device in its lowest-consumption
state while the peripheral is unused.

Have runtime-pm suspend callback save used configuration registers
and runtime-pm resume callback restore saved registers to restore
the previous state.

Changelog:
- V2: patch 1:
	+ change patch commit message
	+ drop removal callbacks and use devm_add_action_or_reset
	+ split bmi323_init in two functions
	+ separate regs to save and relative value
	+ drop unhelpful consts ptr modifiers
	+ add a comment to explain why BMI323_FIFO_CTRL_REG is
	  being used in runtime resume
- V3: patch 1:
  + drop a struct array and replace with an array of
    unsigned int: u8 was too small and it would have resulted
    in overflow of register addresses
  + use single-line comments where possible
  + drop useless comments
  + remove intermediate variables
  + remove blank lines

Previous patches obsoleted:
https://lore.kernel.org/all/20240811161202.19818-1-benato.denis96@gmail.com
https://lore.kernel.org/all/20240818150923.20387-1-benato.denis96@gmail.com

Signed-off-by: Denis Benato <benato.denis96@gmail.com>

Denis Benato (1):
  iio: bmi323: peripheral in lowest power state on suspend

 drivers/iio/imu/bmi323/bmi323_core.c | 155 ++++++++++++++++++++++++++-
 1 file changed, 153 insertions(+), 2 deletions(-)

-- 
2.46.0


