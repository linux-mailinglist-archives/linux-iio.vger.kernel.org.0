Return-Path: <linux-iio+bounces-27355-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4ECCDFD19
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 15:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7604D3010AB9
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 14:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE14314D1E;
	Sat, 27 Dec 2025 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRKapo+T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069012264AB
	for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766844218; cv=none; b=FFXzWwS1+bg6WwvcQ9nyy11dUFvrbSQOd5yD2QIsyxb4x8Pd2pJenlC6RW5vBE08Xz+KdpG7DPyNNDRdOKeKRx7+Rnf5eKjFU+Pw3AhmXCgpJ2gycUp6XhrDu7EbIB75F8Afb4v2P1t3atKZEctVad/RbWO2TC8u2Bw9PaDNgVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766844218; c=relaxed/simple;
	bh=H2tP5zpEOVDed9S8A6h3BzyTB6w1NTvr9crRa288eWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfeY1pxobW6Gzvxr9leryrD8DfzI6UsX2VLAakZ2/pM4XIvRfDbg7uuvpBHSZge+cIsjnQtEXmZRuUNSh1qWgcg7i5WvFt3/MEZ80spzM2WxKeP1M5JoaLGVpDkaxZK9nX5j1TgDlpb9TCfCG2hWX5hCDMeh0ZZmxKCaeMLrocU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRKapo+T; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so1750947566b.2
        for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 06:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766844215; x=1767449015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2tP5zpEOVDed9S8A6h3BzyTB6w1NTvr9crRa288eWU=;
        b=YRKapo+TxN9k+WE3taC6GY/ATGXxd9LZ8DxMaqqlbC5kSbrg1hB6wH/fQ99mT3jjgI
         Xjt4Y8MsibgNeDI43ON1hQvwrMErJkQXoDjLQWHb5+bxS3LyoGp6Jm7Fa9qCk7X6u926
         ov2LpjDVE35jnG5zmuYVr/0d570wa1Ng2EbpQCF6zvWbZir3+WMLV9FggpdsOjVqY4t+
         k7zlOZQwkUFFX5bw2jU6QppeMTur6gIR5yndjiJeO0VOSOd7H6Gy1jvD0indefaKYUyj
         VMtmZCZSfolJaLB2A8F+xBHxHCOhAD8aun5l2gay33fZ8UrQ06cVkLYox68nWy6N949Z
         KpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766844215; x=1767449015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H2tP5zpEOVDed9S8A6h3BzyTB6w1NTvr9crRa288eWU=;
        b=Jl+3SNnsiaIUf0MnwlJRVG3jqcVHkkbBlHEnaKAOE1CnMd7uTXuIm6UA3gDpc/BVv8
         EaC0pOFOh0jEde1Xdq5otYGGljN0sWHsCOxgxMuwFwgMLPQIS4lbgJU0lTVZNeSLc4Vn
         6ucSvGf7vE3FjWAiGPhOCXJdvMuKvGl4tdS7b+rEKa+AkQyXJ6KLiSiCN+adTX4zZgts
         r1GVmA7quC584rfCXbeFxkIMx2rdCeCLg23DfOIZlljvEbTjOgCBBErei+r+Ht41U/U4
         2NMNJISkMWPAHiIPzrB6T3IIVgSKqsPTDarhDuZ2rOikWbZ9SUbZ6Ixigr3y9UCekWsa
         Z0tg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ9mjLMMCKLmM3s7/m0JeMbJCiFXH91ssnFpCAvRA9nKNee89rnAs2BUlkLHhhmJl5MSMJ2y8E08g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNbuhFkopAiypOxI9tfqxrUpxV8lggzQW5M2+K0WkV6uyMA4WG
	QNq2/HT/qf+FcYqIeEOVvxUZJH/Nc75m9CXRnLKLjsmb8qN5wCDuHallrrkrTWUpnZe8jNvT+SM
	UO/fFts2fsFknDElCm0OwDdZcSnb5Ha4=
X-Gm-Gg: AY/fxX6bhWzFSxKrv6Q5GRRhC40AL7UlmOy47Zdfnv7Mxvb3JOCOaWohOPbyXzxCpg7
	4+2R3wLyjCkAyR6vbk5v+EIUPM8NkprR0GwEnp6yvqz/wUdxdJ8bf6qM/F2An6exi6FHbYXwM5d
	LfTS3Wb2dL/bD8iFULIOS9tk1PzQ3hwXbsXManTgc8FQ1AELpkbmwympMC2bO/ogrJjOusMMBwt
	1KyFK52qNFIYCxvTRAmg/s3iJBQXycvR1phFNpbl2BmNkUHhH03vGBVwpOAvebyXYGovtOkQe89
	9cFN3hQdto5BK1K9T+p9P/Qyu5/ceOhS7JFIZL3ydbNcajZZ9VN9WSUB6yTq/yw1QoWPgaU=
X-Google-Smtp-Source: AGHT+IHV0zRV3dCnT5la+eatlUStMpAINA4aBfvBhZNqL1zRV5a0K3mnW78BKrhfAADqS9yNCAk0tt8nJSTvAFzeDQw=
X-Received: by 2002:a17:907:3f9d:b0:b7a:5c1a:85e with SMTP id
 a640c23a62f3a-b8036f2d03cmr2764851066b.23.1766844215032; Sat, 27 Dec 2025
 06:03:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com>
 <20251203-iio-dmabuf-improvs-v1-3-0e4907ce7322@analog.com>
 <aTBmriwVrMwlKiXX@smile.fi.intel.com> <760dce5b5721ae6e46daeac03b96df7b009db3ce.camel@gmail.com>
In-Reply-To: <760dce5b5721ae6e46daeac03b96df7b009db3ce.camel@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 27 Dec 2025 16:02:58 +0200
X-Gm-Features: AQt7F2rN846vvPqKYYxUpGxrisVDV0ILRiyuDuWGZWxx1Dqe1_b-tZGATleEWjk
Message-ID: <CAHp75Ve5TF76gOVgxxW_RGqD10L40EC+gu3URfwrKk-gkh7Q4g@mail.gmail.com>
Subject: Re: [PATCH 3/6] iio: buffer-dma: Turn iio_dma_buffer_init() void
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, nuno.sa@analog.com, 
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 5:03=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
> On Wed, 2025-12-03 at 18:34 +0200, Andy Shevchenko wrote:
> > On Wed, Dec 03, 2025 at 03:11:38PM +0000, Nuno S=C3=A1 via B4 Relay wro=
te:

...

> > > While at it, fix a mismatch between the function declaration and defi=
nition
> > > regarding the struct device (dma_dev !=3D dev).
> >
> > So, all others use simple dev?
>
> Totally forgot about this. What do you mean by the above? If other functi=
ons in the
> header use just dev? If so, the one I changed is the only one that uses s=
truct device
> (in that header). It is also consistent with what we have for the devm_ii=
o_dmaengine_*
> APIs.

Does the device, that is physical, DMA? Or is it a separate device for
that purpose? I mean that naming may suggest that they are different
devices. The original Q was about APIs. Are all of them, after your
patch, use the same device semantically?


--=20
With Best Regards,
Andy Shevchenko

