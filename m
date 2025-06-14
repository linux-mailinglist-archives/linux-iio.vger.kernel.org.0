Return-Path: <linux-iio+bounces-20645-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 002BAAD9CBB
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 14:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E043018946C7
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 12:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748A928E604;
	Sat, 14 Jun 2025 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUQUu8Tz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5521BC3F;
	Sat, 14 Jun 2025 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749904893; cv=none; b=fhzQQsYFSGWGDy90c1B+d1scP+R997CPxxJcGE9L1JQQnTueKG4ivZrn1psQY1g7rwjVAUkXZ9s+VExPc8cL3hLi+g6nPkt/0/QxXcJTS7AH/cyxmKIpsGFr+F/EtXDe+cM6qoVwKGIEyTaUJWICms2R1LwAebrmk1FIZvPb17M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749904893; c=relaxed/simple;
	bh=VekB320Qeh3glq16VCv4Eu6QdIgbB9LAIgGyitA4WXo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YF85JSj+J2Kt0/hCn33VTKuas3WQU3JuQnBUz9hNSXNWwPmbQVlCfakqoAWNJWQzmitmEhQpG7+hsxEmzY82KCex1VHYOIWUciJl9jTK1KP2tLvm5tbKl4z/YEt43tQiIvDF2Oh3FWtF9jYYKtstMKoWz8LZIVFrhdAISZw3IKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUQUu8Tz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D57C4CEEB;
	Sat, 14 Jun 2025 12:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749904892;
	bh=VekB320Qeh3glq16VCv4Eu6QdIgbB9LAIgGyitA4WXo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eUQUu8TzfJ6qSztE+5TXCpOIAvWa225Te3TsKCWvQ4sG8QzG6kzdkKkI0PD48Y9OM
	 hsB1qmHBZXGVxvZwN0NFe11xIiU8jIYAB0JT3kLLOCitXxuerzzAwOk8N+hyHqiOhJ
	 zb29csG75P1JLpJowkwF+rpo6dNr5yj2LxIzvU2lEZ0cDN5dWtDTVDvlBhbcIQ+4+f
	 HKeSzr7QHiNJKRU/8bCJkCRiwNfNHl7vyKxQqXEpwskKswKRSAJGMzIMjcdfts3tW4
	 0NpMojkxAEP8ZdAqViUXxHOL5xxSZeEHj0bOaUI9MA8bshLvuVkLMCTwxdsl78NnTd
	 Vx78trIf9OtHQ==
Date: Sat, 14 Jun 2025 13:41:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] iio: imu: inv_icm42600: add WoM support
Message-ID: <20250614134125.1fe5f1cb@jic23-huawei>
In-Reply-To: <CAHp75VeS8XQbcTaDFLUYTcd4SEdfoVOd4-mht6NGk__exSD0Vg@mail.gmail.com>
References: <20250613-losd-3-inv-icm42600-add-wom-support-v4-0-7e5f554201bf@tdk.com>
	<20250613-losd-3-inv-icm42600-add-wom-support-v4-1-7e5f554201bf@tdk.com>
	<aEvhZiXHLLIRe41-@smile.fi.intel.com>
	<FR3P281MB17578B82AC67F49552E24EB3CE77A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<aEwfUMgLTnQxOh_k@smile.fi.intel.com>
	<aEwfgP3tiio52Rj-@smile.fi.intel.com>
	<FR3P281MB1757AEF932A3CE2AB9637046CE77A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<aEw4q3p12q1iI7vC@smile.fi.intel.com>
	<aEw9Yxhodwhh8BT6@smile.fi.intel.com>
	<FR3P281MB175722266C119B719FCE9E6CCE77A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<CAHp75VeS8XQbcTaDFLUYTcd4SEdfoVOd4-mht6NGk__exSD0Vg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 14 Jun 2025 00:02:52 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Jun 13, 2025 at 8:14=E2=80=AFPM Jean-Baptiste Maneyrol
> <Jean-Baptiste.Maneyrol@tdk.com> wrote:
>  >From: Andy Shevchenko <andriy.shevchenko@intel.com> =20
> > >Sent: Friday, June 13, 2025 17:01
> > >On Fri, Jun 13, 2025 at 05:41:47PM +0300, Andy Shevchenko wrote: =20
> > >> On Fri, Jun 13, 2025 at 01:43:58PM +0000, Jean-Baptiste Maneyrol wro=
te: =20
> > >> > >From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > >> > >Sent: Friday, June 13, 2025 14:54
> > >> > >On Fri, Jun 13, 2025 at 03:53:36PM +0300, Andy Shevchenko wrote: =
=20
> > >> > >> On Fri, Jun 13, 2025 at 12:46:46PM +0000, Jean-Baptiste Maneyro=
l wrote: =20
> > >> > >> > >From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > >> > >> > >Sent: Friday, June 13, 2025 10:29
> > >> > >> > >On Fri, Jun 13, 2025 at 09:34:26AM +0200, Jean-Baptiste Mane=
yrol via B4 Relay wrote: =20
>=20
> ...
>=20
> > >> > >> > >Overall, looking to this patch again, I think it would be be=
tter to prepend it
> > >> > >> > >by replacing *int*_t types by the respective uXX ones. Becau=
se in this patch
> > >> > >> > >we add dozens of new ones which increases an unneeded churn =
in the future.
> > >> > >> > > =20
> > >> > >> > In my opinion, to respect the rule don't mix *int*_t and uXX =
types, it is better
> > >> > >> > to keep *int*_t types. If it need to be changed, we can chang=
e afterward the
> > >> > >> > whole driver types with a replace tool and send it in a separ=
ate patch. =20
> > >> > >>
> > >> > >> It will be never ending story, sorry. We need someone to solve =
this tech debt.
> > >> > >> And since this patch adds more than 3 new users of it, I think =
it's a candidate
> > >> > >> to embrace the burden. =20
> > >> > >
> > >> > >For your convenience I can mock-up a change... =20
> > >> >
> > >> > It looks like there's something I don't understand in the kernel D=
ocumentation about
> > >> > types then.
> > >> > Quoting Documentation/process/coding-style.rst, section 5.d:
> > >> > ---
> > >> > New types which are identical to standard C99 types, in certain ex=
ceptional circumstances.
> > >> >
> > >> > Although it would only take a short amount of time for the eyes an=
d brain to become accustomed
> > >> > to the standard types like uint32_t, some people object to their u=
se anyway.
> > >> >
> > >> > Therefore, the Linux-specific u8/u16/u32/u64 types and their signe=
d equivalents which are
> > >> > identical to standard types are permitted -- although they are not=
 mandatory in new code
> > >> > of your own.
> > >> >
> > >> > When editing existing code which already uses one or the other set=
 of types, you should
> > >> > conform to the existing choices in that code.
> > >> > ---
> > >> >
> > >> > My understanding is that uXX are not mandatory for new code. You c=
an use types like *int*_t.
> > >> > But you need to conform afterward to the existing choice. That's w=
hy this driver was
> > >> > done initially with *int*_t types, and that patches are conforming=
 to this choice. =20
> > >>
> > >> This part of the documentation has a lot of room for different inter=
pretations.
> > >> One [1] may consider this as uXX superior, another, like you, that i=
t's okay
> > >> to use.  In any case Greg KH prefers uXX over uintXX_t. And he is al=
so in
> > >> the chain of maintainers here. Feel free to amend the Documentation.=
 But
> > >> be sure all stakeholders will see your proposal (like Greg KH and ot=
her
> > >> key maintainers).
> > >> =20
> > >> > By looking at all Linux drivers, there are plenty of them using *i=
nt*_t, even
> > >> > inside iio: =20
> > >>
> > >> $ git grep -l 'u\?int[0-9][0-9]\?_t' -- drivers/iio/ | wc -l
> > >> 59
> > >>
> > >> $ git ls-files drivers/iio*.c | wc -l
> > >> 640
> > >>
> > >> Less than 10%.
> > >> =20
> > >> > Then, why it is mandatory to change this driver to use uXX instead=
? =20
> > >>
> > >> TO be consistent. With the above wording in the documentation I may =
argue that
> > >> entire subsystem should be consistent and at least in IIO we have to=
ns of patch
> > >> series that are against the whole subsystem to do one style change o=
r another
> > >> (look at the recent memset() vs. {} for initialisation).
> > >>
> > >> [1] https://urldefense.com/v3/__https://lore.kernel.org/all/20250409=
180953.398686-1-matchstick@neverthere.org/__;!!FtrhtPsWDhZ6tw!DVTvkgDsymM71=
32dB-wjei-s0JxYiivZxtzEHfWjsrn_6toqTXA__hm2nPUh7jmectCXcP9Z3OAh0hMm-WD6eQAH=
OtdiGbYQqsw$[lore[.]kernel[.]org] =20
> > >
> > >Oh, this [2] is golden!
> > >You may found support for your arguments and for mine in that thread, =
but the
> > >bottom line is: what do maintainers of IIO prefer? (Taking into accoun=
t that it
> > >goes via Greg KH)
> > >
> > >[2]: https://urldefense.com/v3/__https://lore.kernel.org/all/202104232=
30609.13519-1-alx.manpages@gmail.com/__;!!FtrhtPsWDhZ6tw!DVTvkgDsymM7132dB-=
wjei-s0JxYiivZxtzEHfWjsrn_6toqTXA__hm2nPUh7jmectCXcP9Z3OAh0hMm-WD6eQAHOtdiu=
Fc54eI$[lore[.]kernel[.]org] =20
> >
> > If this is required, I can do it. I would just want to know if this is =
mandatory
> > since we already have a couple of drivers merged using standard types a=
nd
> > other drivers planned to be merged. =20
>=20
> Let's wait for others to speak up. Especially maintainers.
>=20
> > Can I do it in the same series or should it be in a separate patch befo=
re this
> > series? =20
>=20
> Same series, just a prerequisite patch. Note, I have one locally, I
> just need to send it and you can use it, but the reason why I haven't
> sent is the same =E2=80=94 I want to know the official position of the IIO
> subsystem about this.
>=20

I'm generally not keen on taking strong opinions that add a barrier to
code submission / new contributors when there are arguments both ways.
I am getting fussier on style though in my old age - mostly driven by
just how many drivers we now have and the advantages of consistency
of arbitrary decisions.

So I'll state a strong preference for the kernel internal types u8 etc
and would like to see patches converting larger drivers that are
significantly copied for new code over like this one.

Thanks

Jonathan


