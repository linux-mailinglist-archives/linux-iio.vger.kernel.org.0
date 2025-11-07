Return-Path: <linux-iio+bounces-26025-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC820C40EA1
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 17:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 166233B25C4
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 16:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C04E32ED33;
	Fri,  7 Nov 2025 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzGmVF+n"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2893131AF09
	for <linux-iio@vger.kernel.org>; Fri,  7 Nov 2025 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762534026; cv=none; b=G55rrXVAkDRNZ7Y4lc0+QFhfVdyXVVwmNbptHlg04VePDuek20qsukW56T71NLpEvu+5GkF00uY9Mb3SP9t2HcnEI4k/emNUC+JPsZ1mKtVcI9HIp96hct1ds9r5rle4SffL06/CasxjK5//qtienoGuP9+6oPeiYaLW2+8CBQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762534026; c=relaxed/simple;
	bh=u4LrvUOCXV3F5CzwiPkFF3ajzXge7N52cRuaAf5BNKo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K8tFitSF35FSKX3XfPSWBIsGFaRFeGnsvUE38ApiCHq10/qTwYWi0x+0tVPtVHVx4o7gF1Zpy6mVEYygAMFlUqJwQOJ/ZHT+3C1s3ER+kmy0fgzTyWGXWch/DoepvitKc2EIKAdXjonCgm0i7jS7Gu0hmm1Au7b015Du76glcQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzGmVF+n; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so8285435e9.3
        for <linux-iio@vger.kernel.org>; Fri, 07 Nov 2025 08:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762534023; x=1763138823; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VyPjRi+QXINK/G3HwEIUSz2pe7MM61slaCvReUYNTJU=;
        b=gzGmVF+ngF1YIt8AqiRE7OCVAxhroBWj6+ejwlHBhf3YISDTgK0HCkc7EPlEdX7sy6
         NV9DvmCrOFh6jZhVz6KpBgHX3TtV7+HyB3fHRnc8TTggT2oFIh/Jix/hA74NsMMzu23i
         JNBG1CRp+ilEe3956reE/lsiKGjfXnZtmcRo0gKbWITLaWHYt647LpDPwnSCs6ri5CTH
         o93g3TpxYy+3MnqYlw2PHt2/MW8xn6HjRQSrILaezH+Snr5yjcQ165I8uNTTzUxx0FPe
         gdSqK2b4HjiBoen/TDvxgWT4LlitNHzOLlRRFC13UgbDkUCFh7hqy+xzkJuaA8ncN4MJ
         Kx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762534023; x=1763138823;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VyPjRi+QXINK/G3HwEIUSz2pe7MM61slaCvReUYNTJU=;
        b=vWaCSFK/lFAMf78Sd7rB/kyvQL/y84SAqOslip6cxHqL6btoq5RBqsS3ygMdv/52Xk
         snH98ebGvSRq/zAy+EQ/30iFUNu0GWH/skiZkwhwHDIjyADdRjCxTkgLJ6jlqXdS+zHU
         cPxyDVLiXsIrYmLB724remUg7uT3LTkHkaLZT6gsXzyETmLrHVazxuAIYxJsrqGwN88W
         yXTFIsakJYPpTUi8WUCPvyPDhpX9WaLhpudgquN0cimGK/dmj2ukTiCazGVkUvShx+HP
         rObVMxLDUFzX7y62jL/kUA8UYU3w6oQlCe/SLQ9DfuSLuNPvqM+SzgeeVQi21zJo5Vqo
         kY1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU11L5OYDIr7VQLJz7VFvFxoBLDwAqz+w1t1MR0osHpu3+76VwAgCnbYULSSBFAvFWP7GLPNvoYmG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlKr7Yhkh2QYq3QjCfVmrPehrmWTE5Y6nyLNmGpnmTVozIqdRD
	ksWEIJ9DchP8G/hFKwklEKk93PsiiEbsufbAd4QRw/DNdQjghdv66H36
X-Gm-Gg: ASbGncuGKj7zuACtpzgdCE55RxgET8972kr9zBD8SykyBwY6csTVDLSMc6chDjfBfGN
	PGXFPowgcogOrM17sYpyslgBl0fGEngutFZbiKBLi4r+MXxZ3H+N0s1cOIJYEFS4aD0QLdG4izD
	Tad5RmXpnRG+EVi+6QiRsipADJYI1pERK0wA7zJ06vnLgCvcAjWURWftXVvuc1g7BkHt74GBSlw
	IE7bHCZnp/bVGNfWOhdP8CEchMjl0b2oWQWZIc/OfcZy1l9jnB74HlN81HRSA0/WAFi40SfjeTi
	hBJSq1sRlI8AEV8rHBJ6gjCtjp9hzjk3Y/UV2f/P5o4KG2CNW81gzy0AHWnHhei5bZOHR5h9CRG
	09Nf+ZpJ5k/CKNFr6p/YhiDAfSmEK5o6cSuK5bRZkw26nDbwbhroyldC04JY1+0xUX+9I+45squ
	jLhTJ6QIYIU2p7dKdIgHvoEdWSXAzELrpVEWNaUIldb7nSIHkHZ0Pmxukd/I4=
X-Google-Smtp-Source: AGHT+IFzxeAoFSolRKaGRaQ387Osx3T525m9qfl3b6uQkmAcCEJFSA44ck/eKjXMRtfI8txtrZHBfw==
X-Received: by 2002:a05:600c:a4b:b0:471:1774:3003 with SMTP id 5b1f17b1804b1-4776bcde4d5mr35739515e9.29.1762534023150;
        Fri, 07 Nov 2025 08:47:03 -0800 (PST)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763b5359esm49117375e9.0.2025.11.07.08.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 08:47:02 -0800 (PST)
Message-ID: <9e96f49f3903f704e16e8dde540507b10a978951.camel@gmail.com>
Subject: Re: [PATCH v3] iio: trigger: Fix error handling in
 viio_trigger_alloc
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ma Ke <make24@iscas.ac.cn>, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Date: Fri, 07 Nov 2025 16:48:03 +0000
In-Reply-To: <aQ3NHnL2rF0wkqeo@smile.fi.intel.com>
References: <20251107020200.6285-1-make24@iscas.ac.cn>
	 <9aac9a66c02c691e073043f918fef055dca888e9.camel@gmail.com>
	 <aQ3NHnL2rF0wkqeo@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-07 at 12:42 +0200, Andy Shevchenko wrote:
> On Fri, Nov 07, 2025 at 10:26:10AM +0000, Nuno S=C3=A1 wrote:
> > On Fri, 2025-11-07 at 10:02 +0800, Ma Ke wrote:
> > > viio_trigger_alloc() initializes the device with device_initialize()
> > > but uses kfree() directly in error paths, which bypasses the device's
> > > release callback iio_trig_release(). This could lead to memory leaks
> > > and inconsistent device state.
>=20
> ...
>=20
> > > -free_descs:
> > > -	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER)=
;
> > > =C2=A0free_trig:
> > > -	kfree(trig);
> > > +	put_device(&trig->dev);
> >=20
> > Yes, device_initialize() docs do say that we should give the reference =
instead of
> > freeing the device but I'm not see how that helps in here. Maybe initia=
lizing the
> > device should be done only after all the resources are allocated so the=
 code is a
> > bit
> > more clear... But doing it like you're doing just means that we might g=
et into
> > the
> > release function with things that might or might not be allocated which=
 is a
> > pattern
> > I would prefer to avoid.
>=20
> The put_device() here is the correct (and must) thing to do independently=
 on
> the preferences. The problem is that device_initialise() and followed cal=
ls
> may do much more than just some initialisation.
>=20

Well, I would argue against that (at least in the context the function is n=
ow
implemented). To me, the right thing to do would be to move the device init=
ialization
code to this point:

https://elixir.bootlin.com/linux/v6.17.7/source/drivers/iio/industrialio-tr=
igger.c#L594

trig->dev.parent =3D parent;
trig->dev.type =3D &iio_trig_type;
trig->dev.bus =3D &iio_bus_type;
device_initialize(&trig->dev);

Then we would not even need to think about put_device(). Like it is, using =
it, it's
just prone to errors (I did mentioned a couple of things this patch introdu=
ced If I'm
not overseeing it) or we do need to have lots of care in the release functi=
on to make
sure we don't mess up. To me that's a bad sign on how the code is architect=
ured.=20

FWIW, the pattern you find for example in SPI is the natural one for me:

You have a spi_alloc_device() [1] that initialises struct device right in t=
he end.
Above it, kfree() as usual. Then the callers, will indeed use put_device() =
in their
error paths.

So the pattern to me is to do device_initialize() after all resources of yo=
ur device
are allocated. So that after that point put_device() does not get you into =
some odd
handling in the release callback.

[1]: https://elixir.bootlin.com/linux/v6.17.7/source/drivers/spi/spi.c#L568

- Nuno S=C3=A1

