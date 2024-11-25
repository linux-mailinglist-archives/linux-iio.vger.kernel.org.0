Return-Path: <linux-iio+bounces-12661-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A942C9D8DD3
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 22:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B02F28AE6A
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 21:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF231D1730;
	Mon, 25 Nov 2024 21:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVbCIC1h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9F51BDAAF;
	Mon, 25 Nov 2024 21:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732569400; cv=none; b=JRkP+c7uMIIq1AJx0+4Al/1CVx7rA8gdApoU8ei1994M88yVphnleYFggiUeW7mjSqo7PvaKfnrzrPWLyrmcpCr5FstovAtfvgbc+YGgx5XmgmHoCyGByTsztvw8oA5qxweXoZfxfOPHJJl95GKdld7nIvEdoPZ44W34xt3XVEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732569400; c=relaxed/simple;
	bh=MnJLJRBd7l+61UU+1kkKssT/cMDRYTwrBfUB9O2sPzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dUeQ6Qbw6C2hsCs9fcRVAiDdVqrk3qZGaWe0oexP2KQJalkSmSh4xBbFMYh13dInMmbZjI4XGmonkZxmnEk7UueBmxH1aeB18e9n8i3DaWE3JGxcMmJnIy7F3yzizykMdD+6l1KKH1owCqWm4+sf5t0F0aTmFEFf4e5YG0yYnno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVbCIC1h; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a2033562so7358045e9.1;
        Mon, 25 Nov 2024 13:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732569396; x=1733174196; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9X4xpOgGPYzYDpEftMUld8E8Sy48bF/slktKFCfPG0=;
        b=GVbCIC1hcZG9GoM02tG2WGbCtIOpLMjOLX7nDKwpI643vU2KHFa/NRdNTD4W0KDONo
         i+h6dbgzD0JFQMSyZvi5uCDZs8tpcYk/I2msIlpibGPVYKgsVQYt5p/4Gy4tEBy7WeDo
         6dNoP5O9DoqCugsDR7T5dpTpj3qNZtLYBNagWEt7S7Vgclhwx0/2/hfSVNaFCF1u5MbH
         zHykYrbPcrXCcRPoBBRImffElUgX95UNlX1FabOR+vrewpKeAWkJ3gEposkKr00zcs5R
         IPUQ3kojjyQaI6PzpFb1eK7a1ebppkxtdlwQXxSdJWXV1258c8agK1a4tLE5h4aUTdMC
         9uLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732569396; x=1733174196;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9X4xpOgGPYzYDpEftMUld8E8Sy48bF/slktKFCfPG0=;
        b=DOzJ+kuCmf4UGdYit79+Mf6YlzH1+lM5dLFF9K+zHmS0CfvaDVqxn4Ra7ii1dJUbIz
         c4J5Sz3ssioxGmVe0uWEZkxVTHQf9XUDP88jbuWIkUkj848pJyXbSppBbXNIjSB0a6by
         xXHNAJVApPeqWJDRZa+iCJd2hMhBSUYrhqXB8z0Pw4gKnd0gIEYjZXrHlkP63RfVlnLC
         WwpWhKnKK76q3Or+SuCbUIlrQWuc8Qr1IHLgyvRy5KzWNU4dY2WKXaQ+/IxeagEum8mL
         6QGIDyjoRcdzIJ65VYUENjg8O+arwbFxxTnsksJa6mcqIFrbBe8YSBCj4gQ+MU72Ulf2
         klaA==
X-Forwarded-Encrypted: i=1; AJvYcCU5aeXD9+ksn0qR+sjHi66cff+SnIX682I0on45ApbK1PqqBmBUu9fOfoiXqBj9fnc8+L6JebK3aOE=@vger.kernel.org, AJvYcCWXCdJ8l4Z17tngBTiDdHx74r/+b22mZc3Yh4EWwqWUoNvrny4VQH9b2nUY/TgVwfMOt29mE1Tl@vger.kernel.org, AJvYcCXKErpO4clzw6KxZfuJA30sjQHTOaSs3fMpcqDU2X8hwHOU9IL/NX0W8Yct5dWZLwjp7855F/kRz1GqPa9n@vger.kernel.org
X-Gm-Message-State: AOJu0YzDdp+9bF/Ce3pZd35UPJx0lpFCIa2OWdU0ilpfQs0wGC9HZYYh
	kE06g4QPQX2Tx/vQ7Cj7wE7vL7vuxPfrMB7cTN/YjnhP4qa9YOE01UmhBA==
X-Gm-Gg: ASbGnct5ztuCk+9K94jNEFwV82DwznT+YdauOeKzxeMcJh1OpxhNrdjXg4X0VZVSGQK
	RTTzc4W4pVbuZFJ+ef04E8o95NGv08mVbPdhg70V7Iha6mIQin9mGSBVxvojqZf9ee6EJ7p607a
	u3/ftV4yuHAQla/93a9qrlvx3zSefecif3yYQapC/UHDidnXqmWeV4H9GKpM/LfZmZv8DNZWQLf
	JOolrrqXmVjEc+YlEISLWV1e1ct+HgEiGBnQ34nUEezUnqPiOHRMu4VoFhe/clquBKmbultmIai
	6ys4LDn2jbx2ggI9kur2EOJCGWxWkt+IpJdnq6+7z2ZMV4LsmK+5FRwHGolQnCiJwt5RE6ua
X-Google-Smtp-Source: AGHT+IH85+4cYeAFSxcCPnqfbJZBrM3ZYDfEucQPDUQs50gVlOcqLQZaVbU1W0WwOcF9LJ8T9tu8dg==
X-Received: by 2002:a05:6000:18ab:b0:382:5066:6f38 with SMTP id ffacd0b85a97d-38260b67c52mr11652339f8f.23.1732569396450;
        Mon, 25 Nov 2024 13:16:36 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-eff8-ad65-1bf6-3f21.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:eff8:ad65:1bf6:3f21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349ca82957sm75236295e9.33.2024.11.25.13.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 13:16:35 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 25 Nov 2024 22:16:16 +0100
Subject: [PATCH 08/11] iio: adc: ti-ads8688: fix information leak in
 triggered buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-iio_memset_scan_holes-v1-8-0cb6e98d895c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732569377; l=1243;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=MnJLJRBd7l+61UU+1kkKssT/cMDRYTwrBfUB9O2sPzs=;
 b=pda3qacHR7U9b1xq5j3B+4bQ2bjGN+KtxMv99FQdm+9RGDI1Y+iwu0yTQSiK2uoysb+2PmA8E
 HNWWhVm0oF7CQ8Ng3ZvtiG8ytIklVGNvT2MORfpxAZCMamnbqjfqcfv
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The 'buffer' local array is used to push data to user space from a
triggered buffer, but it does not set values for inactive channels, as
it only uses iio_for_each_active_channel() to assign new values.

Initialize the array to zero before using it to avoid pushing
uninitialized information to userspace.

Cc: stable@vger.kernel.org
Fixes: 61fa5dfa5f52 ("iio: adc: ti-ads8688: Fix alignment of buffer in iio_push_to_buffers_with_timestamp()")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/adc/ti-ads8688.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index 9b1814f1965a..a31658b760a4 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -381,7 +381,7 @@ static irqreturn_t ads8688_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	/* Ensure naturally aligned timestamp */
-	u16 buffer[ADS8688_MAX_CHANNELS + sizeof(s64)/sizeof(u16)] __aligned(8);
+	u16 buffer[ADS8688_MAX_CHANNELS + sizeof(s64)/sizeof(u16)] __aligned(8) = { };
 	int i, j = 0;
 
 	iio_for_each_active_channel(indio_dev, i) {

-- 
2.43.0


