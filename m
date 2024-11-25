Return-Path: <linux-iio+bounces-12662-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 491309D8DD5
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 22:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E00A28655F
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 21:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AB41D4341;
	Mon, 25 Nov 2024 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mK/RSSWn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780111D4169;
	Mon, 25 Nov 2024 21:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732569404; cv=none; b=AZ8/TkIZhan4VeK8e5B2rDCpm4v//KHJSEaJ3Y2yWhy7vnZ0KtQBIyg9hhu573hKcrJkfxzGFvSodcb/M9OKFhOZ6PiFrHFaq+kXtS2uVQNLmYwLyvpSn+7l/jm49ahzg6P8kTocgetcnQlQueIfM/+T9U3IQLbyJxUg+DnPOgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732569404; c=relaxed/simple;
	bh=A5f+hgxSFBau/J9wGch0+bL5gusNzvwM80QyMwDLN+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hwY05tneMkOio7VW2g8TCq1jLQOQ7MfXhVawhhPAU69qdYsuB6xStF+meoDBNZ4azF6/tEO3pBDidvNb7jWQd6u3p0BafDIb7DokRRCIPLWsJts4dnMV9sFkudwB7Q3rTLbZp6137EvFhjoasRpuNJ/Ay22yihuuOc00E9iKRc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mK/RSSWn; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4349e1467fbso13700335e9.1;
        Mon, 25 Nov 2024 13:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732569398; x=1733174198; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L5uJPBz6TeglXeo554KOh/VAk2n4YGIIimy93nEytGY=;
        b=mK/RSSWnuYm/b+MUwkqrvicvFYnKDDgQi+IKG9GN2H4EsAxEBnq/nvwhSxhrOucSDN
         pqlWS23INW18FwRNZMF/1Td5pbAFovFXFyzAePk0NJANGxux8FEKu/6buWJlOMF9C/DE
         U4hleaBS3Q7kD08JLL10CozpvUROB3uKc40rpvYwjdvgNf+mEa5rc/dEzsZJt7kJR0s9
         jai2xi/0P+TcquIHorJxKX4IoQXnhpWpNzAaA28PAb/7suFENypE0X5g+Z9+gllopD83
         NNFvGq33AuKJCMCQpPA5QJBS6b6zuNDBVNZWrp3XHsyCgy3P5lPeb08Btz52LFNj0ExS
         BaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732569398; x=1733174198;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5uJPBz6TeglXeo554KOh/VAk2n4YGIIimy93nEytGY=;
        b=TGZAXgix0xhzW5DPvFubkR5Tza5U/BDkx8ZVsMHGjG8409dKlptcHIXOGmb7tPGIJO
         TcpOkD9qkCnZ1okcuLfcsOjqGeBmzdhIOWbpBe4QQog8Z/Ra8MKuCnzFSzG1LUy8dSgQ
         S4/THAeXPUjj9Jn3hsUAh/5H69+Atzf7BggILb1dvnWmaEcvKleQzKdz9bKYUZmWuQTq
         moxyTCoJVqNUjs8OHHla+YLeSc978Z+NSpyvF3ZX3/uB+0Ae3+kWbc7mPtMuqWGssSYI
         aFe/KJ7D+pRoTodjFeZeJ7BgyBuWuj38Jwu7L5s6++b783FRceRAkCirY/i37luDYr+X
         5JJA==
X-Forwarded-Encrypted: i=1; AJvYcCU7iGmTcSpQh3OYYRreVQPu7WdmvmZw7/H61cJpiidsNtLLnjagycutUeuwFNszXNeb56FoNJITyXfzQUjl@vger.kernel.org, AJvYcCXY/6qlvzIoq9j89MD2hxe17M21uAC6ZVgEr+tILn5yTc8WHRHIgkCiYWOs9kWj9RfTphwMf3o6H/M=@vger.kernel.org, AJvYcCXuXKeYpFqxHhgqp0tkYZPNY2X2CtoBxv4ELj7iSNa9DOznmLGTq10gtAlRSmjNbQKIWqFRPNH5@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdzo47m/Lz2SJpmqpvVW/Ml2mFOFN93ej75gnEZ2K4/Z77kvfz
	ZPEt43UW3aEv1U1ZVOxhgJXNITP3SYtAsFfonL4aGOezT0ldtkrDrEJgOw==
X-Gm-Gg: ASbGncuHq/kh8pKvzD8ZiSoy4l0M14c0qRDWgAY0cI9lM3KNW78395c2x6DndlPN+Bs
	qfhjgF1YWg3rhkbcuRzH3qc9CitMzHog06xkWwtO+7B5jvJuJsK4dLVaxU/gOhK4BgxyzfEzsjt
	KK/svxB9Ct2p7YJVcSnoau5930ka6NS9MdwirK9cfWBvIp7e2Eq9L4PSsja6gdR/v1swL8YEZl5
	B0fj6MXQLkQQf7iVzc6Z6S4lVWHLn66RFKzBRc9VRT9FDUDbhEz6Us/FVwJZQSY9pPT/iyn2YXC
	2V/VogWGYH+A4QYPON9kKHQSJdQQsAfCIvDR+eWtt0yextSvGQXUHkF3KsBRfQDqLVWPYgXO
X-Google-Smtp-Source: AGHT+IHyL+p8dJwHNZ6pwWMnP9g4uOpLQJodr/tba4IA/05FdQxOb+l1atdGAnpia/bOa9lKxfUeEw==
X-Received: by 2002:a05:600c:3b12:b0:432:d875:c298 with SMTP id 5b1f17b1804b1-433ce426968mr126557785e9.14.1732569397764;
        Mon, 25 Nov 2024 13:16:37 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-eff8-ad65-1bf6-3f21.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:eff8:ad65:1bf6:3f21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349ca82957sm75236295e9.33.2024.11.25.13.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 13:16:37 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 25 Nov 2024 22:16:17 +0100
Subject: [PATCH 09/11] iio: dummy: iio_simply_dummy_buffer: fix information
 leak in triggered buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-iio_memset_scan_holes-v1-9-0cb6e98d895c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732569377; l=1121;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=A5f+hgxSFBau/J9wGch0+bL5gusNzvwM80QyMwDLN+4=;
 b=60Af4gaoutFmm+7Nqj9Vb5rRrQGetXcnTt7LgdWxF5fQVaLWcwqZTvuRCYIrnmYjM3hVHgnzq
 2jqtOmCyWUXATrBeCgv5wUP+LkrMvtMdhCIg4KF4lPqLvdp2zuwzCUX
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The 'data' array is allocated via kmalloc() and it is used to push data
to user space from a triggered buffer, but it does not set values for
inactive channels, as it only uses iio_for_each_active_channel()
to assign new values.

Use kzalloc for the memory allocation to avoid pushing uninitialized
information to userspace.

Cc: stable@vger.kernel.org
Fixes: 415f79244757 ("iio: Move IIO Dummy Driver out of staging")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/dummy/iio_simple_dummy_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
index 4ca3f1aaff99..288880346707 100644
--- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
+++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
@@ -48,7 +48,7 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 	int i = 0, j;
 	u16 *data;
 
-	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
+	data = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (!data)
 		goto done;
 

-- 
2.43.0


