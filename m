Return-Path: <linux-iio+bounces-17776-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EE1A7E6FC
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 18:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FEBC17A1B3
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 16:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6111E210F56;
	Mon,  7 Apr 2025 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHZTqv3g"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663E320C00F
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043669; cv=none; b=AuOnHjfw94b2kMHwT6j3jb9xrxugJxYXPPEL1hXJw9dj99fI/7RCoQtNrJhfPVjZENxRm9tRbrTz4csfBS9eAyViIpO+qsmIKoZjzqJQhJXo9/XDHQCrjr9GMen4Vz5B6ynIYHRZ9h+sG4IfIPSmR3uB712NmnPQ0Ni2KxUncOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043669; c=relaxed/simple;
	bh=0pBfWwYsTO1EVaedaFV8YBwSnZizf6En8UVtVNeKL70=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CM1ZZJXQxakSIvOm70MFAK2kAhVeS2j+X7JUb5LWM+cPkUQRebVu6HovzIVfZSirp+3yrWs4rAwmz6MVJDUi/Hka3YgLBeUrrE2LMipTvSnlPsDGyF8vLHlHZYX4DKGBUhtk0c42ETFQKdkEJW1UwR3W49CZm0FLzjXrF5G3q5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHZTqv3g; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso46068485e9.1
        for <linux-iio@vger.kernel.org>; Mon, 07 Apr 2025 09:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744043664; x=1744648464; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0BX68r59iFPFAOVoObQ3Xanu8h8pPLb6IuceKbYf4sQ=;
        b=dHZTqv3gCprboafQhNgicHy2xmePSMr0ZmD7LQwGJhnf4pxEdcL8lD6wj4ZsEF3Ggh
         Q0/vskNFYK2ARdRVkpeCQuNTfRZj3LEIfbIp2pBNwIdfIzodpT1B1FZRcqBklrhUGR5k
         AghhOSqr8hQTnwhTCAxL99TzxPRJrxuugmilYXXFbjXXD8n2di0WkmxaNELYW9/GaJc2
         UefloGz4VjbzYAPd/u/5SABu+quDhM66dOVcTP6T7tVxdVb2hhqh5nx4Ji1KBDrKVblt
         0TQNcesyw659YMam4G3etfPKfrLYC0ivQC08pdMGzfba5VYw6vwYmQNIDd6jALuFMaT9
         sDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744043664; x=1744648464;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0BX68r59iFPFAOVoObQ3Xanu8h8pPLb6IuceKbYf4sQ=;
        b=gWI56d9CWVWCxrZCN44HMAZ2n5TWKz2RVIUYGWfR1qGxizB9kRcA3dUTwAeF3lCqNl
         qoKAyn2C3u7pwO4SUO6XOivcUrwkEOWJ9n2pVnO1COux5ESPyR1ik6VWFkxapNj0+mVk
         YRMGSXEcRX+5rmpuNuxUvClYr3+oHZwjL4D+HClnzQzgX+qQwdOqUnI8+gnfZP9A6giz
         8ucPZcauyL2CzNuEL3EexQBSb6A13gtp4Rj5ZG6VGD8t1zUEGJuJ3MQDdSkPv0J0eI9M
         /whWgNf8LharnUrSdk+Lw3iIGA92cGplci4hWL9gc5qTibCNaqVAAhKsXcHi5xOKDE6e
         uXUQ==
X-Gm-Message-State: AOJu0YytnEWPHvYl/qH4G15FsXCTk4l9ajOFpafCZ8hLDeuJhfFkxb+p
	Q4wMPxyobCRErPpz5NKw0qNsAUWX5+n0Qr7pmGhKaMW3NsVkcUOq
X-Gm-Gg: ASbGncuZrFWAl8y9FsYrcByDAO6gljgcutgRIkfSdT2ygHNnF4TTXb9Yf1RBSxytANz
	IxHipHpcNBCfZ0DIoqoyz7/qnCfLHNDnjLdeIhK9JVYessfTJchzCwjQiLM9/SQAcfBgbNuzl6h
	4KmJ4DT90yUz91pcEodtydDg18TTaVIYDoxsjz9xnWk4+2GPGU3lGMrAtuVm3K96LaIQ8b9aoQW
	MtGkZQ3atgu1PdeKGbvq3i7xLh4xLtwzFlCsADRN+VpxLbp4B5RQIvybJEEAnHTUtpT8gHCzdyk
	Ui252Azebukc1J81BTpe+Vn56c716XcFL9cNzbdK1yazssJ4DUlTsSBnXe+rA5SFAa7EgGsRfbX
	4JQffT5Bye3BDVlB8
X-Google-Smtp-Source: AGHT+IHOpCiJIf5bqyaGVCQSekui+TV5jNyA4vXnklkojFAw6PptFPfeXFxwGDWIHXaURIU4RTLwSg==
X-Received: by 2002:a05:600c:1e8f:b0:43c:f63c:babb with SMTP id 5b1f17b1804b1-43ed0b837c4mr112966665e9.1.1744043664063;
        Mon, 07 Apr 2025 09:34:24 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec163156bsm2517905e9.7.2025.04.07.09.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 09:34:23 -0700 (PDT)
Message-ID: <29002c58344f88eaba95426a0e4bc45d3d70406b.camel@gmail.com>
Subject: Re: [PATCH v2 06/20] iio: dummy: Use a fixed structure to build up
 scan to push to buffers.
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Mon, 07 Apr 2025 17:34:24 +0100
In-Reply-To: <Z_OZgoORPl_6J01m@smile.fi.intel.com>
References: <20250406172001.2167607-1-jic23@kernel.org>
	 <20250406172001.2167607-7-jic23@kernel.org>
	 <Z_OZgoORPl_6J01m@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-04-07 at 12:23 +0300, Andy Shevchenko wrote:
> On Sun, Apr 06, 2025 at 06:19:47PM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > It has long been discouraged for drivers to make use of iio_dev->scan_b=
ytes
> > directly as that is an implementation detail of the core. As such our
> > example driver should definitely not be doing so.
> >=20
> > A simple anonymous structure definition suffices here as even though
> > we have a mixture of signed and unsigned channels only the signed ones
> > use the full storage so the unsigned channels can used signed types as
> > well.
>=20
> ...
>=20
> > ---
> > v2: Add a comment about stack buffers not being DMA safe.
>=20
> > -	data =3D kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
> > -	if (!data)
> > -		goto done;
> > +	/*
> > +	 * Note that some buses such as SPI require DMA safe buffers which
> > +	 * cannot be on the stack.
> > +	 */
> > +	struct {
> > +		s16 data[ARRAY_SIZE(fakedata)];
> > +		aligned_s64 timestamp;
> > +	} scan;
>=20
> But why not continue using kmemdup() / kzalloc() for this and put
> ithe comment there, which would make more sense? Then the device
> driver developer will choose either to use the on-stack or heap one?
>=20
> Or didn't I get the idea behind all this?

I think Jonathan means that if you need to do any SPI/I2c transfer as part =
of
your trigger handler, then do not use stack allocated variables. Since in t=
his
example we have anything like that, things were simplified to use stack
variables with a comment on top of it.

- Nuno S=C3=A1

