Return-Path: <linux-iio+bounces-21367-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22253AF9E00
	for <lists+linux-iio@lfdr.de>; Sat,  5 Jul 2025 05:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 803C95A2916
	for <lists+linux-iio@lfdr.de>; Sat,  5 Jul 2025 03:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4794526E71C;
	Sat,  5 Jul 2025 03:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RO6hSo/q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3365383;
	Sat,  5 Jul 2025 03:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751684632; cv=none; b=a08Ow02Wg7gqgaUkQeTjC5b88jXbcKEvBW0E9lH3/ZG5RR2DX3KUrHwd4IgkNiFr5qP/UodtNp4s4OhpCfPZXSAoQlr6cetyCNXuwpyOEVeSOni07aGFY+SVYfIyK+zjhaJV5L/PZBbh8Pfd+Mdi1EI9GRRE+PcGdR0dH3M8GNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751684632; c=relaxed/simple;
	bh=//RnRTXOf51cFekTGGk5Qd0NRZnGCdyz7dD2c7mx1IQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aaCb/xHgm4qzlf6NaQ5d7QSLHYngkNI9uqZn8a9ekjuOHMG+8ExLjEexazES0iv69BZ/LETsDmjnIvYwaRVAZ++D2IXdcuzP2sMaWS7iO63MD5a0oe9LdvpQUQHxmaAj9quVE9uhPhV3GnZTI70AeLvVXtN8m9Uf2llCl1+5Ah4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RO6hSo/q; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5316a5e4c6cso477173e0c.1;
        Fri, 04 Jul 2025 20:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751684629; x=1752289429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//RnRTXOf51cFekTGGk5Qd0NRZnGCdyz7dD2c7mx1IQ=;
        b=RO6hSo/qJT0kSUQMhmP4/ZRsqO0YYvLp8AP9/JnBTAtofosqnzgHb6oqPS9OlJ5sis
         laxZuDDo4LGXqfzlSPnmZ8Www201v3L70W+/h0EOcTZKYFoxRgWiL6ubbTSHKuiH4SD9
         GbhfpmTbJXM/ImMvPek6tkI0Pq7dTE9vA45L4K/QAA8lf2kTeh56Zscf0X6X5c3vxKiL
         tzna8qlDm/+2eRggcidSXq171jDFcuc0k6oUtthhxihICxgLZRteMawwKyzS4CSH84gO
         lX3I6yQ6WXegESZu/x2OOLANOUEJojCHsbcN7Jawjr6XmeM2mlzdX5IUnCsmhm5f/k71
         gbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751684629; x=1752289429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//RnRTXOf51cFekTGGk5Qd0NRZnGCdyz7dD2c7mx1IQ=;
        b=OfIq+ARIZ9GGAgs0hx4SNz2odzaG9IIsa6bTfLQHV3xD25OAeRFJBMyMTpsb75SpHr
         E6KynwWABrMynVPeF2ou1OqYj1uwvgewOJYd+Ag5SZAI/qdjr4FieOj28Ad1YI9a4gAq
         yJmGxkfMmJyOkMuoDOiypkBcxhCZutuOmAgezir1n06Fi4VD00v2OY6vwYevEfeYBzlK
         sVqGWl4q0i+/ph0+cnDPGaIQfNj/bDU9+BoHpJ/iu/RbF8krSvvFzdMFsHaNo7cmIjyw
         kU5TwEVsXgnStmmoRVF/9X7s/ia87IA4eea7hMjoajYRtAPO0W+xULG8Xv8aumgp0Qdu
         g0SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOL9RqoR4pSqwW39dUU7mHwDM/j1ITZhQace1rghMJxuFTXGJxqRQyvm3QSa3F2b70yq7wTjRUGG4aBjj/@vger.kernel.org, AJvYcCXywEBc7Y1Bz0xnaQAkJ6mIT/cPe6zFwYLVQJjaFcXUbR+Fwg4lxVu0pg0MIDpPivnLITToXUQ3CJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxpDrZgGPCywQUHu0Ozpj6wkcSyKU+C6imbWalp+0qnm+CJYTv
	ZDshmUqZF+dFYL5pjO4wVp+MswPhyYJlmmjwPGP+C3ffKXGzBiLiCSPUo6auCUolMRDhhu7FPHZ
	89pRuT623cDCxSy9Ns9eIYQpn2+Pmps4=
X-Gm-Gg: ASbGncu6eH8KtXNjcSsc+CrLxvYH/uVBwZS3lnqIWPptZk8Zh5sLMJVhqTjXDB0n1t+
	a21jQNUjkvxBvaufkez9EW9MLTIidLG5poS4BEfG45VjhoY/dwnl8bZqjnlZUme1PIZ2z+JJbbm
	A7i5n8dvwBvkqLZz+sBThpiUqyCzvGhmR0v2ps3HTJ7u4=
X-Google-Smtp-Source: AGHT+IEgs4SB0SvvoGlUCQQGq7ufy5sylQnYc5CbBVAto8sfsCcaB2uDt3bO3c8R7XbK7PhopUA/cmjKsWYjLzEj3dg=
X-Received: by 2002:a05:6122:134a:b0:531:2afc:463e with SMTP id
 71dfb90a1353d-534f016f351mr597717e0c.5.1751684628707; Fri, 04 Jul 2025
 20:03:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618031638.26477-1-andrew.lopes@alumni.usp.br>
 <CAHp75Ve4yAp6sViUWZY+0abRoNZ0W+rQLCmsbijEcrh8kguVOA@mail.gmail.com>
 <CANZih_S9_8OdY=oKyVPBCTSTqYm_z_rkE=xbPym3uHOSsHMv6A@mail.gmail.com>
 <aFL6PE-8KLLKZun_@smile.fi.intel.com> <CANZih_QeeA_G5mFOAb=TMNYiR4eo9SUD5iW1G-5LBGL27NpTRw@mail.gmail.com>
 <aFQrgEw4zw9RSAO3@smile.fi.intel.com>
In-Reply-To: <aFQrgEw4zw9RSAO3@smile.fi.intel.com>
From: Andrew Ijano <andrew.ijano@gmail.com>
Date: Sat, 5 Jul 2025 00:03:37 -0300
X-Gm-Features: Ac12FXw41CdZZMjWQ7ztZepUfKxGh4nqikLajCCAsmqYaTtVeRdd9R5hqSDnDNg
Message-ID: <CANZih_S=7-ArpBT3NF54-RH_KYER=mdS9nf1bUO3djEiDY_RWQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] iio: accel: sca3000: simplify by using newer infrastructure
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, jic23@kernel.org, andrew.lopes@alumni.usp.br, 
	gustavobastos@usp.br, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, jstephan@baylibre.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 12:23=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Jun 18, 2025 at 03:20:06PM -0300, Andrew Ijano wrote:
> > On Wed, Jun 18, 2025 at 2:41=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Wed, Jun 18, 2025 at 09:24:19AM -0300, Andrew Ijano wrote:
> > > > On Wed, Jun 18, 2025 at 2:56=E2=80=AFAM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Wed, Jun 18, 2025 at 6:17=E2=80=AFAM Andrew Ijano <andrew.ijan=
o@gmail.com> wrote:
> > > > > >
> > > > > > The sca3000 driver is old and could be simplified by using newe=
r
> > > > > > infrastructure.
> > > > >
> > > > > I haven't found any reference to a base commit here. Have you
> > > > > forgotten to use --base when preparing the series?
> > > > > In any case, please clarify what this series is based on.
> > > >
> > > > Thank you for pointing this out! I think I forgot to use --base for
> > > > it. In this case, should I submit a new version of the whole patchs=
et
> > > > with this information or is there a better way to do it?
> > >
> > > For now just reply here what is the base. I asked this question above=
.
> >
> > Ok! No problem. So the base for this patchset is the commit
> > 3c23416f69f2870bea83697d7ab03c6a8497daa7.
>
> No such commit in the repository. :-(
> You are doing something interesting here [1].
>
> So, make sure you are based on the iio/testing or so, make sure that the =
base
> commit is the one that may be found on git.kernel.org. Use that in the ne=
xt
> version. Due to above this version is ambiguous to even start reviewing i=
t.
>
> [1] I have connected IIO subsystem as a remote, so I have access to many =
trees
> from kernel.org (but not to all of them).
>

Hi, Andy. Sorry for the late response.

Actually, I think I didn't fully understand this part of the
contribution process and that's what was causing confusion.
Basically, the base commit appeared in the previous version of this
patchset but I removed it after it was approved, to prevent it from
being reviewed again. However, I think I could just add the
reviewed-by tag.

I'll send a next version with other corrections and the missing commit
based on iio/testing.

Thanks,
Andrew

