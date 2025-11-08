Return-Path: <linux-iio+bounces-26044-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBA7C42B43
	for <lists+linux-iio@lfdr.de>; Sat, 08 Nov 2025 11:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4E2B4E230A
	for <lists+linux-iio@lfdr.de>; Sat,  8 Nov 2025 10:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACEF2FC892;
	Sat,  8 Nov 2025 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmwRP73j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E0B2FC03C
	for <linux-iio@vger.kernel.org>; Sat,  8 Nov 2025 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762597525; cv=none; b=o/ub3TPSkkOrDu1NIU4Ga+ZTT0RVurwJxo2fR252dTjEI8XpeRShgEUgVCyATWIxFrwdyLkeAQOnH45JrpjjOHMa+Y0thB4z+moowCgoDAcw5+m4hm5nv2jdzFsFipDtf2OluKXhq5kfVbIFuVM/wkxzG+EiNTatfQBMYXlxAlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762597525; c=relaxed/simple;
	bh=edkeFamHGMtqmzoxgm5+GBH8lS9BaJlzt9lOLcAyeAE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZRYl1RFEQucdn8R2A0qTn6BxK+ZTaIwnGUM85PfBuuo0ih1bEDCeRnCg9EwbdNDPfc18/f/3ovSaJ9BX4RtsBXYpYaCiVtlF2YtNnRQEKNnt96GuCpkMp9bQ3d6SK3OC39k69VXzozaUSeuhsjthO5o/dK4vM24Eut+uDYSDeSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmwRP73j; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so1061383f8f.0
        for <linux-iio@vger.kernel.org>; Sat, 08 Nov 2025 02:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762597521; x=1763202321; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kXDYd3AFiu0SkxyPJ9uzyD3xwRVj9J1Ie5FJD40k2zU=;
        b=RmwRP73j0sU7SrHek5Vjpor9mI4FoCm/vKw7EZRfQhxMutkeHWh/GK/t9ZhhbdiKJJ
         lIv2frStX4AExaItPsI4C597E4VH4O7WA1p+TUNR4max5QnXcLHTLqHdIZgq6F/YODeS
         K5K5HJ6A/A4ygyrGj7iJeNZVs8Mc4oJf9U8MXbbNxS9SM7fmgLsvS+0zbTIuUGxT2UKM
         572chj7AAGI/WgoxjLcCAz6AynOTEEWKEa8yhkk+Fx/5W7ul84uBOacd1CsaOV5v5igJ
         F5uOyctc6pxIreJsHdrh04qJnGNACpTMyFIwaa24ZyUEDVTY/SOMXmVoThrR1wp+A9Y2
         wVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762597521; x=1763202321;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kXDYd3AFiu0SkxyPJ9uzyD3xwRVj9J1Ie5FJD40k2zU=;
        b=uPytMHRG2HUDlMr3KHtfi3gZiU+arsIVBnmni/LSrogIXsm+IRiL9eA0eBnGj+Dytm
         3Hnab/hC5ZZTORAHo2is34hxwvxxl64cW6RAnU/on9Pm2O22PwOqWvoYc+KFdQCwA4yx
         yym5PeGI/AvguxjqlX283r8t05bDaLQV0CEq3SwHllt457NDzwDRw4YOBpmsvNRlNdfk
         56p6ZV839Y7BGLrBjT9HB9417lv8xjbT+8dhdmSbPngzOLFTrjUJ4bwq8Vmpp2AfW8TJ
         9DHOI9C6kRXdGRRyqq83oR9tvFxYkRwZ34AnEc02fy37kkgDsTI1tOtRcB9osgG7U0C/
         vG+w==
X-Forwarded-Encrypted: i=1; AJvYcCXrIQMOcKEmoSHxojrIPL48+WQiG0CyW7b1mBLU2oQHEb7EpsA/yx6W/vgULmekRj1aOozMMo2+gRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLuFDqavp1XXleAfnjbwEFTOYZ10ZVj38AekKKpaoSBJ34cfHX
	lTAuROQI2tJotjz4BNNekQPmf3G1A2jIWyJuUnNlqIdaAJzHv5dc5YeA
X-Gm-Gg: ASbGncsMyZaO6Tq2LTCGO6g6bz1Wm2InygWhIk8TLDhgMkDf7XQN2l0kaPVmzfXniPn
	v+TFtXUuhQUqOMsPUvCpL1REEVXWCzDl8r0ZSFUkNGs9x8doa7MzqmP5Hi10Klio2k9xUN8MKUp
	Goj5/5MsfBogfb9hI8KSu4xLs60sZTyksIor6MNP1eWBAB152cwAs2b1u5+Hg4nAT9pwX1apqsb
	xy11/NqrKQ1HElLdn1uk1KJMwTHrdiHTsqIUhwqklbqp6yIwAH/AynqS9RJfpQJdn4lBZ3qFG34
	fSoLu446/YOPnMtTWnwmityBxk+5H3BHm7sIendArtAMjjxRKXDNwFmFAoC2mgA4IiIkVa5Gpfr
	AtBORi70pCmh+yCU+3f2ajZByhin0fjDCcYdGeuN/MwP/ar47YTF2dJLq+HmPZaa5KLC6UBjvkg
	oYYfMM+Wb6QpK0K72yRV5HEbIzw4hmRdwmiErecEwioP+sTv+aLtmlgx3Q5Bc=
X-Google-Smtp-Source: AGHT+IEl3DAiqgThvVJsW3h9LsNQGzlRKJ42h6whlt9K3mExQg0fRMpo96Hnr13+gl2KdwzafZ1+vA==
X-Received: by 2002:a05:6000:40cb:b0:429:cf88:f7aa with SMTP id ffacd0b85a97d-42b2dc16d26mr1303521f8f.9.1762597521308;
        Sat, 08 Nov 2025 02:25:21 -0800 (PST)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62b23csm10571649f8f.10.2025.11.08.02.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 02:25:20 -0800 (PST)
Message-ID: <b6d9db5e17bb3400888ee6e5934cfbe5fa2251e2.camel@gmail.com>
Subject: Re: [PATCH v3] iio: trigger: Fix error handling in
 viio_trigger_alloc
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ma Ke <make24@iscas.ac.cn>, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Date: Sat, 08 Nov 2025 10:26:21 +0000
In-Reply-To: <aQ44IB1b7AXun_qN@smile.fi.intel.com>
References: <20251107020200.6285-1-make24@iscas.ac.cn>
	 <9aac9a66c02c691e073043f918fef055dca888e9.camel@gmail.com>
	 <aQ3NHnL2rF0wkqeo@smile.fi.intel.com>
	 <9e96f49f3903f704e16e8dde540507b10a978951.camel@gmail.com>
	 <aQ44IB1b7AXun_qN@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-07 at 20:19 +0200, Andy Shevchenko wrote:
> On Fri, Nov 07, 2025 at 04:48:03PM +0000, Nuno S=C3=A1 wrote:
> > On Fri, 2025-11-07 at 12:42 +0200, Andy Shevchenko wrote:
> > > On Fri, Nov 07, 2025 at 10:26:10AM +0000, Nuno S=C3=A1 wrote:
> > > > On Fri, 2025-11-07 at 10:02 +0800, Ma Ke wrote:
> > > > > viio_trigger_alloc() initializes the device with device_initializ=
e()
> > > > > but uses kfree() directly in error paths, which bypasses the devi=
ce's
> > > > > release callback iio_trig_release(). This could lead to memory le=
aks
> > > > > and inconsistent device state.
>=20
> ...
>=20
> > > > > -free_descs:
> > > > > -	irq_free_descs(trig->subirq_base,
> > > > > CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> > > > > =C2=A0free_trig:
> > > > > -	kfree(trig);
> > > > > +	put_device(&trig->dev);
> > > >=20
> > > > Yes, device_initialize() docs do say that we should give the refere=
nce
> > > > instead of
> > > > freeing the device but I'm not see how that helps in here. Maybe in=
itializing
> > > > the
> > > > device should be done only after all the resources are allocated so=
 the code
> > > > is a
> > > > bit
> > > > more clear... But doing it like you're doing just means that we mig=
ht get
> > > > into
> > > > the
> > > > release function with things that might or might not be allocated w=
hich is a
> > > > pattern
> > > > I would prefer to avoid.
> > >=20
> > > The put_device() here is the correct (and must) thing to do independe=
ntly on
> > > the preferences. The problem is that device_initialise() and followed=
 calls
> > > may do much more than just some initialisation.
> >=20
> > Well, I would argue against that (at least in the context the function =
is now
> > implemented). To me, the right thing to do would be to move the device
> > initialization
> > code to this point:
> >=20
> > https://elixir.bootlin.com/linux/v6.17.7/source/drivers/iio/industriali=
o-trigger.c#L594
> >=20
> > trig->dev.parent =3D parent;
> > trig->dev.type =3D &iio_trig_type;
> > trig->dev.bus =3D &iio_bus_type;
> > device_initialize(&trig->dev);
> >=20
> > Then we would not even need to think about put_device(). Like it is, us=
ing it,
> > it's
> > just prone to errors (I did mentioned a couple of things this patch int=
roduced If
> > I'm
> > not overseeing it) or we do need to have lots of care in the release fu=
nction to
> > make
> > sure we don't mess up. To me that's a bad sign on how the code is archi=
tectured.=20
> >=20
> > FWIW, the pattern you find for example in SPI is the natural one for me=
:
> >=20
> > You have a spi_alloc_device() [1] that initialises struct device right =
in the
> > end.
> > Above it, kfree() as usual. Then the callers, will indeed use put_devic=
e() in
> > their
> > error paths.
> >=20
> > So the pattern to me is to do device_initialize() after all resources o=
f your
> > device
> > are allocated. So that after that point put_device() does not get you i=
nto some
> > odd
> > handling in the release callback.
>=20
> Sure, this can be another approach. Whatever you, folks, prefer. But at l=
east
> the mutex_destroy() (separate) patch can be issued and accepted independe=
ntly.
>=20

Sure, agreed on that.

> The bottom line is:
> 1) the current code has an issue;
> 2) the proposed fix has its own flaws;
> 3) but the idea in the current approach at least small (if implemented
> correctly) and makes sure that any new allocations won't be forgotten in
> the error patch, nor in the ->release() callback.
>=20
> > [1]: https://elixir.bootlin.com/linux/v6.17.7/source/drivers/spi/spi.c#=
L568

FWIW and unless I'm missing something there's nothing fundamentally wrong i=
n the
current code (i.e any real bug). That said, I would ack a change that moved=
 the
device initialization code to it's natural place (at least in the way I see=
 it).

- Nuno S=C3=A1

