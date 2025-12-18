Return-Path: <linux-iio+bounces-27185-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D78ECCC91E
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 16:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09E203079AB2
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 15:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B81934B1B4;
	Thu, 18 Dec 2025 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gn0lB8oq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F90345753
	for <linux-iio@vger.kernel.org>; Thu, 18 Dec 2025 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766072803; cv=none; b=nTATKCr/HQa3RlHbYHUjMa/YVHTzdFHewPea0mdjCbgqnQEcCHa6xOLGSnH3MQj0+ls0z/fgvFd6WFbfhZiAzFnYgg6nbbYwcDIaHxCen3PYvulkRrXHTO2lxSt+FyJ4MeRvFh6n+MulP3P4b2CS5W7P+4IRzw0viNpbkaXg4Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766072803; c=relaxed/simple;
	bh=ABS6WeCxCL8XmcbmIplxXpFY8pwjfQdhazzFikeqcR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2DsNaSIHKuVlrt++c20ZxzOdAWxw40xdDKj4rySBJoxGPJTxsFec69qjtGh/R9Edeix3Pb5GRwqy69gyKU24Byi82oWOGA9x5koEQ11fltKKLKA3dGS96AJ6FZ5I1c+1uVFmXoKtGR3YZLH6xZAw/oiHdnYjPe//dQ2cELTobY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gn0lB8oq; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-11b6bc976d6so2821619c88.0
        for <linux-iio@vger.kernel.org>; Thu, 18 Dec 2025 07:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766072798; x=1766677598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2pY3Dj22eRFI6euLJuJo7wjRAoKSeAvX/5BXg+N1IlA=;
        b=gn0lB8oq2Bhsukz92UZPA6ndUMSrUwbnu3gksfhs158XgYuEIr27n/n6dWQr9VZkPC
         4MLlFh6s9pBf94OniVBsTwtSvX7yeLjFIOsDnxb5xOluZjTNFmrc/j85QOk2O1GRv9dp
         9fQQQzky7dh83TdTEpsje1tZmEGgTmREzgdSk+8dTIcU3DywAZdX9uJ5IjZyxPb5R1uB
         c278ZA/Pga4dtWaXiqebjP5Mpl4+Tjp6qpzqBqtSoLBKWu3ZUfKUtS+mW4LlIH/3Yong
         kh3n17nzX8+TWaLi0+k6FUNkx9khRH/KEgH4pjQdhJ6exVHn6IADuEyLdEY4ifgumy9A
         rBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766072798; x=1766677598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pY3Dj22eRFI6euLJuJo7wjRAoKSeAvX/5BXg+N1IlA=;
        b=g+4SfdiFl/GrnbuuQRcI9sOtSDQUP8W+o2b7sYInydjbq4vKMjx4XWgJs0LP+/GxGZ
         xLmClUEAKzChUgJ1KumQoWrvBvfJfTrUjK12iG9SXNvPmwHiO8PrsgtqE9NPNQEoLyNo
         bfOUc7473wB5ADeSX7IkLkyZbBQsRGu2XJSXqQ1tNtG0oYOpPgtFL/UuOzs30Jq0UayB
         qzgIwGVQ6t8/T+xNfwMpPP7p3gyX/SdbJK/EsNf2uk/so+QE7Eh2qRqxNYKnf67nwPiI
         +p6DVK0qLxQBWlA+haZBgGbMNRV4tr6tzGsgk8qol1Nn47ulrQvNt9CQgrLrZW9uuLhz
         kafg==
X-Forwarded-Encrypted: i=1; AJvYcCW9XrISL0EinLn0NSrLLEgpFx3pWNUWSlOR0Fm5+jRIdIjCpenj47tB3dXPMl3tXH1tK9JDJQi3xpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeJbAbhgxb+PM4FqmT96hGWSrlgvGF3tEAgCn3xIDLkcbJUoHT
	fqoWmvXkYWRvP+SviF/jOlieB7faL1yh0l2UDdLoZkVxiJIr2h/j6iXK
X-Gm-Gg: AY/fxX5CgoxbgNSIUCwGgS9KugVryWGvX2EBvwoW1QSGcxvqC6tYtGJ+zEOnNjCWBDq
	JtYotPmsJ9J8e9QesVeHjVP+121NzSbVcnfWO3kGDT4D+wU1D0ngLs+4woxHHrenv9eXUP5b7i1
	2Z6iY3tVwOGzMCcFoMpwYz4eGcmAYtPmMD2Yci1LpH/J439ZJXzTGtEpSfP8FP2uZXt0Jl4092G
	0zlv04EA9RYXOqHU59FyuO+LKNd3STAC2iKx4STwuhpkxwOvypM64nk1ACeNdUUnHWRA/Wivl9C
	panAGZGCQdvldkYKPC/fCux8p862fr0/z2ghrhngJs/AVJhrl64gdfVobNZ4qriGudF9kJuRKSG
	8hkJfhFvczndzHFmW4TfLdzB1wQYVwV8B++3IH72JWzPAcE1LYPkKtzTP5sCCNCzxkK8zXd4uF7
	df4fxPxwck2h2rowSqg0bU/cvjuUC9/HjRCZbVsm0p2mATUfmsUKteL51t64d5EU0gMFwQPTK1Q
	uofoJmqpLcrz3d6Mss/0ULvwc6soqkbC5CgHnNU9Ubr9pdiGutLdjW/JCpJyUBPHJIx
X-Google-Smtp-Source: AGHT+IHakG1mTeS/TpPra0zj9B9gXizYj4XxBwSdmKSjjmjy7IkFavN6SQhkCFG558NqSUEyBk3ZGQ==
X-Received: by 2002:a05:7022:4584:b0:11b:2a5:3b9b with SMTP id a92af1059eb24-12171a752b0mr81467c88.8.1766072798015;
        Thu, 18 Dec 2025 07:46:38 -0800 (PST)
Received: from localhost ([181.191.143.42])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12061fc54b4sm8927625c88.10.2025.12.18.07.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 07:46:37 -0800 (PST)
Date: Thu, 18 Dec 2025 12:46:36 -0300
From: Tomas Borquez <tomasborquez13@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 4/5] staging: iio: ad9832: convert to iio channels and
 ext_info attrs
Message-ID: <aUQh3KAvgm5_QIMO@Lewboski.localdomain>
References: <20251215190806.11003-1-tomasborquez13@gmail.com>
 <20251215190806.11003-5-tomasborquez13@gmail.com>
 <aUQYBdiYVy3sn0Nx@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUQYBdiYVy3sn0Nx@debian-BULLSEYE-live-builder-AMD64>

On Thu, Dec 18, 2025 at 12:04:37PM -0300, Marcelo Schmitt wrote:
> Hi Tomas,

...

> > Convert ad9832 from custom sysfs attributes to standard channel interface
> > using a single IIO_ALTCURRENT channel with ext_info attributes, as this
> > device is a current source DAC with one output, as well as removing the
> > dds.h header.
> > 
> > Changes:
> > - Add single iio_chan_spec with ext_info for frequency0/1 and phase0-3
> > - Phase attributes accept radians directly, driver converts internally
> > - Frequency attributes accept Hz (unchanged)
> > - Cache frequency and phase values in driver state for readback
> > - Remove dependency on dds.h macros
> I'm not sure, was the dds stuff being used before this patch? Maybe dds.h
> removal would be better as another separate clean up patch.

Yep it was used, dds.h contains some macros for creating the sysfs
attributes, I could make a separate patch which transforms the custom
macros to "native" ones.

> > - Rename symbol attributes to frequency_symbol and phase_symbol
> It's nice to have a change log between patch versions. Though, it's usually
> provided as part of extra patch info, not commit message.

You are right mb, I realized too late I'll add it next time under ---

...

> This patch fails to apply? I've tried getting it applied on top of current
> IIO testing branch with b4 shazam, git am <individual patches>, and
> git apply <patch4 on top of applied patch3>, but patch 4 fails to apply either way.
> Couldn't figure out how to fix that.

I think I made some weird change which makes it unappliable but I'll make
sure that does not happen next version.

...

> > +static ssize_t ad9832_write_phase(struct iio_dev *indio_dev,
> > +				  uintptr_t private,
> > +				  struct iio_chan_spec const *chan,
> > +				  const char *buf, size_t len)
> >  {
> > +	struct ad9832_state *st = iio_priv(indio_dev);
> >  	u8 phase_bytes[2];
> >  	u16 phase_cmd;
> > +	u32 phase_urad, phase;
> > +	int val, val2, ret;
> >  
> > -	if (phase >= BIT(AD9832_PHASE_BITS))
> > +	if (private >= ARRAY_SIZE(ad9832_phase_addr))
> >  		return -EINVAL;
> >  
> > +	ret = iio_str_to_fixpoint(buf, 100000, &val, &val2);
> Maybe I'm missing something but, why 100000 here? Should it be MICRO instead?

iio_str_to_fixpoint parses one more decimal digit than the fract_mult
suggests, passing 100000 gives 6 decimal digits (microradians precision).
Using MICRO here would parse 7 digits instead, as far as I understood.

> We can use macros to make it easier to read values that are related to metric units.

Agreed, I'll use MICRO for the multiplication and division/modulo operations.

...

> Best regards,
> Marcelo

Agree on the rest of the feedback, thanks for the comments from these and
previous patches

Tomas

