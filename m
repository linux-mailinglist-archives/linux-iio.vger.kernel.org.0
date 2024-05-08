Return-Path: <linux-iio+bounces-4888-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E58C8C0204
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 18:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0841EB244CC
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 16:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2FD65F;
	Wed,  8 May 2024 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXtbLrgw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419E3D524;
	Wed,  8 May 2024 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715186080; cv=none; b=Ntn1d52Kt7JCQtsHTpKrNDXemsz46ctq/i4/uJn+rFsPNYi8TeUBAOqZooh61mDzOGDHv6RbWoD4/XFeGgjjJZG0wQ4sAWkfmObO6Xl9OshWYShVWEWUcRMzemcQBoadd9/EwYplLHL/CubOZAuPiDof0CVjxhye51YU9h3co+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715186080; c=relaxed/simple;
	bh=doBaB0rNJP6gachGgrNAb5iWQ/1lP5X0sdIEkPUu1pg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YgaXzVu8PZ1dWVfrqQHQT+SQ6qSV1ETsjxJFM5u/dzaMmuCgOr8wDt8T7/avm6IhYqVo7qQOK526I0Qn7uW1XzyPgIDf5AHCv0R91mU7YyjbQ00nYUYEnVrtODKuxqKcIGQf1HrJDLjeSDYyWybxd5CMqRQfGC9TGHDf9q6kRLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXtbLrgw; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a599af16934so1161282066b.1;
        Wed, 08 May 2024 09:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715186077; x=1715790877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkV2bnGI2BWyPngxKTJfpLv7Ui/dNejnP7F0QLwVFr0=;
        b=bXtbLrgwmDOUtjG83Lce6exoc1lMYeoCcVqTBGO57Urh1lCrRF+Mm+k2N/QH+95eZX
         WBdpFDIrWVnngSs7C76PjhwpD3MCFGneQLBjmD1SlsecakoRwHuE/bSi/91GARk9/S0Q
         ZX+4hE9rMU4rPvvZzqN9FjPuJLmwND6FKrl0Nk3cFD1EVQ4wtERXmoIh8ezpwjbhJbwD
         aDvw8UZtZoZJf4bbOBmNiLDyiUSnDBe88F6xc4URp3QIukq0St9Ea+VT4cCkLizG5Xy8
         4/LABsrHCm8JgpERfedyPE3K/VKYXvUK8wvTr9fhVIgXIGCfimr1Z5TmjgmcXcOVj4Wg
         p6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715186077; x=1715790877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkV2bnGI2BWyPngxKTJfpLv7Ui/dNejnP7F0QLwVFr0=;
        b=onFmpZ4OMoG40drRehRXIE5eARIoS5s2zBq2AMnYt3CSCf6SGoNdCsDC4S89mQZ1av
         RfN9FOiEbFIvuzSWRdE6vAEpCkVL2zfKQhhPeQKkWzg3rWQLEQJ7wGtVg6QyXYKyiw1L
         avDMDffQ0+eVbk6yzyssAf4uvg8PyKWxkxBu2c0MiJvLlQ+nlYkQqxd9VrqrkPonMnoW
         /3ABqPPSiHBWaZHu9gXkv7MwkjupwUmc/XwSuZpbuY3kHrlcFQ+3jLD77p8mbrGwtuGf
         dA3INz/UYOi9CAv0mTOkBjAgyp11ozk44l3/v9eNEm7ok2PRf0i0LKU/IHWgRgLT9lym
         w0Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUsYgJuhk0YPH7PIHePmvomQRFeVWcLsW/JXRXO6j771Q+suMxsAb0B5sa8YrGEfexHba+5zJE6tb8IvXhwJAIDXp/+GN26a3XjlEvJo5GkUV50DhD3WyROCVDldMklx0826ZHzxW+P
X-Gm-Message-State: AOJu0YyaZ9JqTn5ebrx6VxUSTuaPlDJcztxgC7C5CKmNiHho4oZN4ibh
	dJ2W49fdw3F5xkGb3xhMUyqmG4Uhl89QAGPTN8JGebRGKjmtEGiY
X-Google-Smtp-Source: AGHT+IHgS7/wWqZc6dzNuSJWgKHqX6ij49SOo03Fc6S9d1w4T8ZjuCLRqFcLujV1+P8zw8IwjiedOQ==
X-Received: by 2002:a17:906:f917:b0:a59:b02a:90e7 with SMTP id a640c23a62f3a-a59fb9f0eeemr207854466b.64.1715186077523;
        Wed, 08 May 2024 09:34:37 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:a3c8:644e:cd04:560a])
        by smtp.gmail.com with ESMTPSA id hb4-20020a170906b88400b00a5599f3a057sm7872843ejb.107.2024.05.08.09.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 09:34:37 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com,
	ak@it-klinger.de,
	petre.rodan@subdimension.ro,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	linus.walleij@linaro.org,
	semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH 1/9] iio: pressure: bmp280: Remove dead error checks
Date: Wed,  8 May 2024 18:34:17 +0200
Message-Id: <20240508163425.143831-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240508163425.143831-1-vassilisamir@gmail.com>
References: <20240508163425.143831-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ret value is being checked already in all the previous
paths which exit in case of error, so this path can never
become true.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index ed49e0779d41..311a011604da 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1350,10 +1350,6 @@ static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
 		poll = 50;
 		timeout = 400;
 	}
-	if (ret) {
-		dev_err(data->dev, "failed to write command sequence\n");
-		return -EIO;
-	}
 
 	/* Wait until NVM is ready again */
 	ret = regmap_read_poll_timeout(data->regmap, BMP580_REG_STATUS, reg,

base-commit: dccb07f2914cdab2ac3a5b6c98406f765acab803
prerequisite-patch-id: 97b99b1106cbfd65cef8d256e4dc1a3a9257511e
prerequisite-patch-id: c60e8ef6fae62417c3430b7598b1a3d2a551be79
prerequisite-patch-id: 6a49484a6d154ddcd1b45b71a6be2c3542ae0be6
prerequisite-patch-id: 5aae62fa92c719fb65a8701ec4e1c4284bef7fd9
prerequisite-patch-id: 6943297d5f70f74bfcf5d5b26198423e428773d9
-- 
2.25.1


