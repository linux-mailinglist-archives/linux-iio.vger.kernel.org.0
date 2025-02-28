Return-Path: <linux-iio+bounces-16169-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A78A4936D
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 09:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1341890630
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 08:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09946242924;
	Fri, 28 Feb 2025 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckDyDm7s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B19D209F5B;
	Fri, 28 Feb 2025 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731204; cv=none; b=eVS5y8yac5ok9XgGMNpmxfyi/VB7+ACAtJ1m6qcoLwhmnS43RlAyqUTUjxup3M2gqnDje/yhCUd3iZrvcBIRuFnEmq9z5BOOXG1vAnnaIgWf7mJBf6UUIIntCOjoRlpr6vle1waJOZt/nlOxqzb+/Mh5myzEad7SJ+LnOy8H07k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731204; c=relaxed/simple;
	bh=c7YMPUbabUYMC0gLFMQRRPcLNjm7M6eGv/SHyYQzSQM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kmrj6WFYmnbVXPfbrnE6hx+gcggSJ1SEHgvyMttBnAAxYv69yAci8WVH1L/9WEUbj24MuOVYX7J4nfBU0YRrGmpzB528W4Q4EGyIKhyxTG/ZFLjEkri2qof8NGeDlarDBrPrqQQkXR+GniB5stauZEsmfLKM4DCRPTfju/QeCbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckDyDm7s; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso995913f8f.3;
        Fri, 28 Feb 2025 00:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740731201; x=1741336001; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c7YMPUbabUYMC0gLFMQRRPcLNjm7M6eGv/SHyYQzSQM=;
        b=ckDyDm7ssdgWAL/t4CLOVWp2SQM+lgjjPPGxhhWF9XHm2W4Mfm6PyWfYY3cO53dGiw
         /ZAnkifqex7Y332IBws1ppub7DLZpFIUR9/IKrZZ8pCbqMB9HKNGFql/mCDyAD3Djzrk
         t2tscc+tojarjOa+7mH9cWW3fK6Tn0opZFCgwDHDpUZq00wXx2L6uPP6CU1VKoypTTsI
         9zhQJ0F4beZiPPUFJzafR3qDGsTbjZ1vrvkUiI2ioIiXIggS9S3XVcFk5ggeo/XSnv40
         Z4MEk7lWmfuiI5UiAmBuUXegne7ULpKo2RBlTx69kEmUvb6eGZ5mZkMZVExH+lOANyyM
         eqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740731201; x=1741336001;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c7YMPUbabUYMC0gLFMQRRPcLNjm7M6eGv/SHyYQzSQM=;
        b=hm2Y++W+/9lE2GCXgTqqJh1PxJ/yKfvVEli6O+hIuGp7dy0rg5fV/3kuHl9Ovc8z75
         3uibdFfVdxEHhCqbHRYfQGxEFZpQ1L/xHrPkadcCCwhAPrHoiKCl7NDGokYjtY9vWnnQ
         cqMPI7D18yGMDfM5HBXiEB0HWms7HgahGxyMdKB7+z0Qq1rACy5o3aO7zMZlM2t5idce
         s7LSsSxQV01mXJJCiLrMud/j8AanjmsX3QmK+MSKsF/8YwqeWHj6jNXnfEQjMaz7eQUQ
         uCj1+YroNJkvHIGy0S4Cufc3OcS25gEPat/RoBAUvbV0Zp9PEUtgGrFtYudJhRHfCgU/
         AlMw==
X-Forwarded-Encrypted: i=1; AJvYcCX62x411JDq9+bhlOrjJ9C5VUhk0sFjYvbJICyGI6BoLKMNypxHZBcN+a0N6Of1Fun79t6fwKE10iTT9SE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS6SKqr88NuhFpyOFgT1R7nQlGwF5LIszGLmPgoGdwtUuB99hc
	txwaw88GrKdKvLnHbAMhvOyQnHeZgQ9SWDksmYavE2NPiczIkfgr
X-Gm-Gg: ASbGncv2O/2BlKmA3GlZFc5fBaMab7yHpaYLD2Z1HWqCyOaOqROjSwSMaTn61sl5ubN
	2Xp+DgbGFG0O4lpvbxPHpgUbQxKDwp/v6s2FhtlmD1td3B0ZucrX1I2c7aXI5wNqJwkVBzpTjUW
	3W07xgHx7OF/5Lm5xFNHeMI+Jhpf3fqY5HFNJ94RYQZBNsk5EvPV3IeELEgCan31SeXAOmiUhve
	xyvfTykQO0UBM8tsjFwWT0vW2gcT8cAbffxCphTtL0mjH/FzZ8xvwvHg8UUVy8OxaEQyqSrjxQ8
	uXhmvOsQsv81BcEUoOVL5K+fEUwStdsA7vQmd0K3n/xuU+0O9WS/qjEsTSVJRcH4QOU8rGctEQ=
	=
X-Google-Smtp-Source: AGHT+IF02T9DCrzPbNmE6I998k6imxNc+Gzw/MUi0LrgoTxdMgRAoQO6UnMNOcZm9UKF+0p3Qy5fGQ==
X-Received: by 2002:a05:6000:1568:b0:38e:c2de:70d4 with SMTP id ffacd0b85a97d-390eca1fa8fmr1641740f8f.42.1740731200643;
        Fri, 28 Feb 2025 00:26:40 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4848252sm4487565f8f.69.2025.02.28.00.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 00:26:40 -0800 (PST)
Message-ID: <37a99292819c20e6da5227cd46e9f1250cb67804.camel@gmail.com>
Subject: Re: [PATCH] iio: buffer-dma: Fix docstrings
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Folker Schwesinger <dev@folker-schwesinger.de>, Jonathan Cameron
	 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa
	 <nuno.sa@analog.com>, Paul Cercueil <paul@crapouillou.net>, Peter Zijlstra
	 <peterz@infradead.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 28 Feb 2025 08:26:44 +0000
In-Reply-To: <D83IPSTKYWNB.1PUBV1530XI86@folker-schwesinger.de>
References: <D83IPSTKYWNB.1PUBV1530XI86@folker-schwesinger.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-27 at 20:27 +0100, Folker Schwesinger wrote:
> Fix a typo in the docstring of iio_dma_buffer_read() and fix what looks
> like a copy-and-paste error in the iio_dma_buffer_write() docstring.
>=20
> Signed-off-by: Folker Schwesinger <dev@folker-schwesinger.de>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/buffer/industrialio-buffer-dma.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c
> b/drivers/iio/buffer/industrialio-buffer-dma.c
> index 7ea784304ffb..ee294a775e8a 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dma.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dma.c
> @@ -624,7 +624,7 @@ static int iio_dma_buffer_io(struct iio_buffer *buffe=
r,
> size_t n,
> =C2=A0
> =C2=A0/**
> =C2=A0 * iio_dma_buffer_read() - DMA buffer read callback
> - * @buffer: Buffer to read form
> + * @buffer: Buffer to read from
> =C2=A0 * @n: Number of bytes to read
> =C2=A0 * @user_buffer: Userspace buffer to copy the data to
> =C2=A0 *
> @@ -640,7 +640,7 @@ EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_read,
> "IIO_DMA_BUFFER");
> =C2=A0
> =C2=A0/**
> =C2=A0 * iio_dma_buffer_write() - DMA buffer write callback
> - * @buffer: Buffer to read form
> + * @buffer: Buffer to write to
> =C2=A0 * @n: Number of bytes to read
> =C2=A0 * @user_buffer: Userspace buffer to copy the data from
> =C2=A0 *
>=20
> base-commit: faeaa1ec6c63b6676679f321601471772f2a0c9b


