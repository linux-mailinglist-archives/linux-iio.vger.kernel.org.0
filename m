Return-Path: <linux-iio+bounces-12654-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE45C9D8DC1
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 22:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2E3169AA5
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 21:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C491C07EA;
	Mon, 25 Nov 2024 21:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjR9IFTz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C8C29CF0;
	Mon, 25 Nov 2024 21:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732569384; cv=none; b=TYr9ent2/1BXBi4wdSHOtntmSCzFvVV7zErKX8UaH1uar5+2KUopUC+3mJQjOU2ZgOiAeo+LBpUYMH/cd8uGEbe5qwKebGviiRGycq8PmxaWs9cHwqPjac1UQInruLTX5aPu1qX/lqMG1xnZ2DvLKpB4bThgR9394EkYGRtCPsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732569384; c=relaxed/simple;
	bh=cyBeaQMPDUmjguYiw+l5uyptd3ou1PYxJOynjAFQjc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GC46QKOGJr4AamYdOP6MX0IKNaUgWomFuhgvFlvR1okQeqTxLKELCcizbq21VLiGvT5fUVdQfGKI8EIc4CexdMOKxLvNcxRfQkcX4vfPWJSyHUovOjmS740bLMxnX9F7ckDHDz/zoCMsPmfLIes2oFuHdTv4N2d+O2195hqGaCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjR9IFTz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a1fe2b43so7702525e9.2;
        Mon, 25 Nov 2024 13:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732569380; x=1733174180; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADRD2BHODBZiky8Gh1dqilnT9fbY5WGuqoJtO3/r8Kc=;
        b=YjR9IFTz0axPlXtqSie5l8jp91VDwHoBhX1exLxn5zUMZzL9rFkjwDvCILyq/fX99v
         4dt6sEQGkGxrAyZi93Oe8yBCAIdyPCMUr7Bxkc7xjAr4DKN0Cd+tevMJwOGREnWgPooY
         8tnTuT0dLraQdgruogMBSwgHnqi2qCw8dblgLRIcp13AItd9iSPsig+YYWQn0tqDbYnq
         DqVDy8034ny0biB1LBUjDblpjnuUfGRiNAxZSxJhxLNJLNneWeD0R6AmJ/JFwB3nEqtN
         UkzIRM/fOrycyF9GOhCZYvg+m/w+5ThQiIykvpDLhJ8uN0MLPpFZ7dF74PrgdIgVCbQn
         ljIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732569380; x=1733174180;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADRD2BHODBZiky8Gh1dqilnT9fbY5WGuqoJtO3/r8Kc=;
        b=SEeqqLxmMTt4LjSSKwvinnmBjyymYcPW5Rgw6rtXS4sSD+TiAVPqimA7Z7RRqWd1EU
         DyRFI4zkU9JMt0HWIUhlTmqx3AkjGE3cpVR1MLr9JN2hlJMyAvqt7qADmcJyb422pGEd
         hRZ7hGHePLvYUT+wK4Adqjm9VwhfgJ1amgGMqus7U7O9HlhXK+MTjR9qHc6kFPnqTKyy
         S5mpeVJOUGzlBjLkcjjkTu3Y8v1mTd6fB4lheIR2KKnPPkxNEEtdu2z3LUHr2g4OzqHk
         bj3y3v9kMhsFmjkNkB9gHocnyzZfdOu627RnhfeHrnDa/0WXydONefEDE/fvgty3nZt1
         EPZA==
X-Forwarded-Encrypted: i=1; AJvYcCU80LE9VscD3HsFF/RPAfBzM1xCRg2l7HVwrCkRS1zGou/BjSgEKTxWK8BU540t7vRm6qBVI2Rqrafjl9LJ@vger.kernel.org, AJvYcCUM2nk75UHVkY7/tJAFP/JRp7M2LDEAO9tX8EpuyODRBiUlg2GyWWsAq/RGI2djcDWIx4BcII7I0aU=@vger.kernel.org, AJvYcCXbbzxWSeWEPlmRfmwcpuL5fN186XrHl5Iu6dAG7JZsx6eyuOVersOPj9up8sOTuEr7Pa3bwalK@vger.kernel.org
X-Gm-Message-State: AOJu0YyW80buuAe4rKV+Zmadox5+HntX8PqFwKrZXJOsguaoSdzW67l6
	WnghBI7eDcAkXMLF9F5A7oTKTP73Tyz3+suDovNqYrZggAG5KINwl3d5+g==
X-Gm-Gg: ASbGncs0rB0BAXNR+ANGzr5quUdCK6hBTf3nh/nDriWd9lE3LAfpslHxYDPFMyTblmy
	QJq+MauYHkz/9TYM18opAxkp0y8k/igpdn2QMRhk/zCrjJEYQnLKlN/DuKVoKb7MxW4BeHfR/vd
	wzBQdl1xCvlT6pbePuc1zpesrWv94W/lOv9KVCIQ6Aq3Yi48HxJjaHoEM+k6ZnOyNlgmXVsMte/
	39EXXvXLjDB6Y/iZO3nCdp8y0xSwWK6oG7JTYXTMQaY+tOBokp0Y+sVbudXdF+DjfN6uVtO7IOe
	a9k4T/B2s/M5JYb65NXhYkgJYOUB9+tkIjcN+q/YrS2kxYOnygaQV7bvppnZnmU2EHvz/58d
X-Google-Smtp-Source: AGHT+IEcDypKkBqPDRoZTI1jTSyHl7AVBhnZb/1/cxO6Xbs2UhO+OUiLKARF3j1G66fIgJxJOq/ocg==
X-Received: by 2002:a5d:6d08:0:b0:382:4a66:f517 with SMTP id ffacd0b85a97d-38260b452e2mr11624365f8f.4.1732569380364;
        Mon, 25 Nov 2024 13:16:20 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-eff8-ad65-1bf6-3f21.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:eff8:ad65:1bf6:3f21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349ca82957sm75236295e9.33.2024.11.25.13.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 13:16:19 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 25 Nov 2024 22:16:09 +0100
Subject: [PATCH 01/11] iio: temperature: tmp006: fix information leak in
 triggered buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-iio_memset_scan_holes-v1-1-0cb6e98d895c@gmail.com>
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
In-Reply-To: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Antoni Pokusinski <apokusinski01@gmail.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Gregor Boirie <gregor.boirie@parrot.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732569377; l=1016;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=cyBeaQMPDUmjguYiw+l5uyptd3ou1PYxJOynjAFQjc8=;
 b=NjMGye2yswzQcRCrPFe9LSzYJ6tjwQN6IMBFPZg96P9HqIfwoUPeiHgDqXAcS4d1q83uhYfE/
 uv6FnYNIZ8VAfxG/Q3LRntserIXym31W6+33pTOoLQybn7fpxDcyCrK
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The 'scan' local struct is used to push data to user space from a
triggered buffer, but it has a hole between the two 16-bit data channels
and the timestamp. This hole is never initialized.

Initialize the struct to zero before using it to avoid pushing
uninitialized information to userspace.

Cc: stable@vger.kernel.org
Fixes: 91f75ccf9f03 ("iio: temperature: tmp006: add triggered buffer support")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/temperature/tmp006.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index 0c844137d7aa..02b27f471baa 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -252,6 +252,8 @@ static irqreturn_t tmp006_trigger_handler(int irq, void *p)
 	} scan;
 	s32 ret;
 
+	memset(&scan, 0, sizeof(scan));
+
 	ret = i2c_smbus_read_word_data(data->client, TMP006_VOBJECT);
 	if (ret < 0)
 		goto err;

-- 
2.43.0


