Return-Path: <linux-iio+bounces-24021-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B3FB5546E
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 18:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696E517093B
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 16:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8738B30C60D;
	Fri, 12 Sep 2025 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c+gzG1O/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258A21DE3AC
	for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757693214; cv=none; b=MszCtRws5UFTPlvr8aEUiyz7EdqcfWTbJ4dBRlhqbfygALvDfiSe0gtyyrGqFKHQ9YoUr02aKE2/oyBCK6q3dmbAeE1AUOUAZydFMA45uCfmABo/Pb6OkjzG/BSAF8vHTsmiftk+5IC93UUWxFS5Qbh5Q+SB0bOKSLJZKmHKPgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757693214; c=relaxed/simple;
	bh=VpNE595yCdSeatal7vCh4ifyEZdobn2WH1Bf/R8GOS0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NGUeJRVVxmfE08Utx7PSYtMfffrlYIO9IYmtcNAC+9nKfLy2onT28zQRtMG/5T1rBnfmzlGq4tNlHdvwVULpLLwCa/PWaAhlTFVrEcuWReLzVuhO7JbPk7AGKzT99lLIfEgduNw6gBERDftp6Vy8TmAqizeZUXbpA1aw5d2gN8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c+gzG1O/; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-74542b1b2bcso2225262a34.3
        for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 09:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757693211; x=1758298011; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gPGBKA/NKS+g70XoYGArtCKJfE8klIJC7bmaO8UeETE=;
        b=c+gzG1O/ROdSEvKKFSAlZ3VBKP+jUSoze7qmeYWjeqqttywKtGHPe8hpVUr4rDDmqJ
         r5ylW5k+sUQsmWQhQJtk3VXX5TWrv894ixTXeCnIELhGVgm8udfWEfxfsIVmuLxkOhmH
         JulyMzHmRcg0h/9LoHCB1OdfnRbSilBB0hUqdQlJjqj3Xrc/zRKdDStWlrfmZvGKyO/B
         R1jni0kmaM+oXim1CC7nyMnLqhI6UDNgduG+2ZC8cv6fom7TcR1iFQh/BPuVXrnaJ8B8
         WeoqQmzZVkL1ugkQ6xnHGl1lSwfte7jiIdyEZtWWlVpgx0RNhr+98wxF4StTKnaEL03k
         5bHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757693211; x=1758298011;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPGBKA/NKS+g70XoYGArtCKJfE8klIJC7bmaO8UeETE=;
        b=whxQKwbo4RIPl6CF11flS0k/qw6AbKR8VOuReGNlPWsWuWsUUlMEG9UNtUviVmVJwE
         QtoURl3Rqt83jpGfkFeE3diwr4ByIMVgKVQshzTeCwmmBaVQ/NmNg6nxbT47br0mIePI
         R3biV15iBmsCcF+pDCxrvzgOP10oHzVsBBsR4qguIKQvxHNJV0T6MtfsAF2WBnIQLw7b
         D/Es3qT56Og0M50tXjLhx3AXLXpihNiaRO6Q3vTwhy+sr2PTICQW7XURU6b6ypSzFqgd
         XPLRCDhzN6YS3k4uTsllaWeHBagbfsZg3MJOrwyHUYKc1f3kQK63aNoDO7F7PDQg1hib
         xeVQ==
X-Gm-Message-State: AOJu0YyAqN2u6LmLU4FB01Z5QLlEV7I48yDHUr85YXh9s4TzW96H9CxE
	ZIu+IEaz9XhtWDcbBGSK2WnmVx/yTmNMRsczgN2TgmWnzPBIQ4QGTfi+9JJDbLybL1FMW2CO8NK
	KqnQQDN8=
X-Gm-Gg: ASbGncvK+XRg4qa9dES0HgXP48EknBJo5eLeUDEEjj6dYVKeeYiay6iFRKCYz6mDRV0
	bmAiTrAmj3Pk8MKKQmiRK5ZQ48ocCG7X9f5frhNfVMmO+LC7X3Gnfdd6uUI6UnBjHCIM2fZ+7mI
	Qcb0DkuWiVC48bQHeTtPf3Af/wigkhWbraJlxTAXzLPBqrT0jzZtnJRng1mkywptS+Z7lZuo8MC
	7eQfM106BY+xYNY0h/ck49lwrl375KLsAq8SB+aIq1/3+BSvxRLGukBrhAesINkntdQ08fyZyZE
	2z4P5kLI5ZPWjEHHq8OH9tGXVUKw/+mfYn8BAOYQEmUr6IhzbZkXDjKu41F2G3pJh3EOaYrVND3
	sMxiuiVHnJjLq2S4wAZJviBFnAgWaf3wQOaGZXHAzr8tl9JZ/QA==
X-Google-Smtp-Source: AGHT+IHMKnNk6AgBVrbblYvZ3wRj4uIOwWUYQEE27u/iIG0IIr4sc/5n0JqYHN/eN+TTu/8FNu3MoA==
X-Received: by 2002:a05:6830:6383:b0:746:d640:71c5 with SMTP id 46e09a7af769-75352995a82mr1898298a34.7.1757693211033;
        Fri, 12 Sep 2025 09:06:51 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524b8a39ecsm1073863a34.23.2025.09.12.09.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 09:06:49 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/7] iio: buffer: document calling context when pushing to
 buffers
Date: Fri, 12 Sep 2025 11:05:51 -0500
Message-Id: <20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN9ExGgC/x3NQQqEMAxA0atI1gZqZWCcq4gLbZMxm0aaKoJ4d
 4vLt/n/AqMsZPBrLsh0iImmiq5tIKxz+hNKrAbv/McNnUcRxagBt91WLIrLzkzZMGgqdBaM3Id
 5+DK5yFArWyaW8z2M030/Xe4MbXEAAAA=
X-Change-ID: 20250912-iio-doc-push-to-buffers-context-df3ca98fe0df
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1412; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=VpNE595yCdSeatal7vCh4ifyEZdobn2WH1Bf/R8GOS0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoxETiJRnWesgQhq94bDBDw0lFSGqBHLEHARRj2
 gdUHJjGRfOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMRE4gAKCRDCzCAB/wGP
 wP0sB/0b45i7n+GtQb5HuF3Fd4odXQ0tWeBAL+/aTZCZZfNThLkyKLZqsjuH4R3nTmzgUZNvTct
 lBClt66K1MsBjzHus+BDG5DHGamhBQCIF+o31npix6V96Wb9b5WJMxZPUi1oB6IBYuJ059LuOUd
 camjkk0gEc1vriQBuZvA7q/3wI0dkN39FjELVpTIH31muI0wRZ+pWaxras9aiAD1TkHZBD64S5W
 PP3Ph1P21XKK/VnfkCDoZqbxABmjyg26n2dK2pUzlFNhkqKf6PTa77s39Va2Ev+yyf0WIBPpsv/
 QyY0k2QYoNimev1ppSPx5k+FEfRyaFlAEmqSOIfs50g021zd
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

It came up in a recent discussion [1] that we need to be careful about
the calling context for various iio_push_to_buffer*() functions. Here is
a series that adds some documentation in a number of places to make this
a bit more visible.

[1]: https://lore.kernel.org/linux-iio/CAHp75Vc8u2N2AHWtnPRmRXWKN3u8Qi=yvx5afbFh4NLNb8-y9A@mail.gmail.com/

---
David Lechner (7):
      iio: buffer: document iio_push_to_buffers_with_ts_unaligned() may sleep
      iio: buffer: iio_push_to_buffers_with_ts_unaligned() might_sleep()
      iio: buffer: document iio_push_to_buffers_with_ts()
      iio: buffer: deprecated iio_push_to_buffers_with_timestamp()
      iio: buffer: document iio_push_to_buffers() calling context
      iio: buffer: document store_to() callback may be called in any context
      iio: buffer: document that buffer callback must be context safe

 drivers/iio/buffer/industrialio-buffer-cb.c |  1 +
 drivers/iio/industrialio-buffer.c           |  8 ++++++++
 include/linux/iio/buffer.h                  | 22 +++++++++++++++++-----
 include/linux/iio/buffer_impl.h             |  3 ++-
 include/linux/iio/consumer.h                |  3 ++-
 5 files changed, 30 insertions(+), 7 deletions(-)
---
base-commit: b8902d55155cec7bd743dc1129e0b32e70b1751f
change-id: 20250912-iio-doc-push-to-buffers-context-df3ca98fe0df

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


