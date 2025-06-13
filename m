Return-Path: <linux-iio+bounces-20614-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E726EAD96D7
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 23:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167404A1573
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 21:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB4D26AA93;
	Fri, 13 Jun 2025 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpY20LQc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9252A26A0E3;
	Fri, 13 Jun 2025 21:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749848614; cv=none; b=t5sMv/wS/jEFZklLyjbeyRMOn6oH9NXps6J2b1aUa5CneU5v8ull0Rkcx+8CdbKBeHJ8rVpXju6lDGm8rY9TFSi34jdnA+NjToBmR1gvhA5JqCzKYC95/+0AnlBYSPm7v3j1gLtINeY/0ICeBquaSmsz9oxEi5NFWVnWPCJtYds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749848614; c=relaxed/simple;
	bh=IyzwKXOWUU8N4gJ4oYPEoooee64bDvtK5035+V25JGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiI8X9Xy9M7HQhmlLcy2C6l/jvqZb4DO3OL6L04HGZLxHkqWEwoezcoCi1kP8vMkCyfB0oNyvUOv3wWx60C34ViQPl0awD7qfhDiDXSe7kNMAwgxPXPPcK/rrXrRz4f8WYOeNK5kQgTs3lVa2huDL/91L/SgXX1a3dlHxi1hyG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpY20LQc; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ade750971f2so316611966b.2;
        Fri, 13 Jun 2025 14:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749848611; x=1750453411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4R5mc6uUx7bSRT5odrTZCsHFmbha7bqUvNpknNdXdSs=;
        b=DpY20LQcQ79NCetQbCfPu5A03ktc4GOwtcmY3ZX1v0e9pFoIlIxKi0rifhX5qzYt9E
         /+9kdjv1Ecm48qQWXA7AGO4Jo1li1MhJmNyj6blBs6KY0ouZQ7iLGrMPHOhn0DboxIUo
         0ieY/mJBOAUIzaVxueTvQAAQxneJb8Kj+6PXSOI+zrbKdXf9Mo6vUP/Kt1+OykJFUH2o
         k8Fc5OXA0P/NMd4+LacjyMdFDIJjsLiNIX/sLKemWDgxHg+NcPY0JhEvmjcvzydFe3o/
         1QeFPnP0xJs5VjennlbllMrf10fm2jbOjujU32YcEF5q0eYoOfBwqtnO8L0YqBAjLzMd
         HMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749848611; x=1750453411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4R5mc6uUx7bSRT5odrTZCsHFmbha7bqUvNpknNdXdSs=;
        b=N+GFvu9u+O89t3qutgsdqnvoX/hv1BA/M77zxgIQXoaA/pChizqwgsbzKlhk4TEhot
         vYGPlqp095LGB3Uwf00QuS/kKOHgz8wTf5bsAT4WYx3uuvJvlcgNXINs2NNTAxEKs9cc
         qApMLcVqhb2G2bccHYE/4d67CHBxq/3aSJCYg3RI3E6RZNQkFpWo1uxQLX27AQC0e6iz
         6QvHdGmACm/TO4i73nmyymaoKMg67Wf+V/SB/tVMOLgH6BAWRzYjSZpM0nM6sOwfZEAL
         dGZLdrJd3V0M4AAZPaICxneG3hHBI9XVKszSGFUANuq0R9R/PQXtNHMoP2N1LoUXEoJm
         7chA==
X-Forwarded-Encrypted: i=1; AJvYcCWg7ZMD1wuxOIkFVEMfwFyd1Yp8MvAo4ehbcvJJLqBs+VeJ+TlUk8GlfJ1aYR4oU18epUcN+1HyeIKeaHoZ@vger.kernel.org, AJvYcCXbPJ9Jd4V3C4cPvgQUnhVDnNB7hpsy+KzWsF6xlAi+GuGzHGygYaP1Ph10Ad1N//N4Q0SPX0gl6Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPuLUkRwKjE93qJgidz8pudYros+2O120ByPlk9Li20pAz46sL
	LJnPFJGNOrr1HxlnK7QKaIsZLGGJi1rVmBjPR9TiLaxWFzmCvp8MXMluTZd2mSWW9ikJ0uZnPZX
	CuXH6maGPEdwyQoUGQnjeHv8mfXP1eX0=
X-Gm-Gg: ASbGnctXS1InEi6nutolniNUiYx/rBs2zLtAomOtKBj+aoWFON2mWrwxngWZ5LCk1um
	mRx7kgYTpg6czAj1sUJzPCKpBISmgOiytTPDFzDwodbi/ybTims93gCyCjr0UOV+Iv6sndITP62
	vZT4Z5+ruCw1LeDQSCMpMrTICHSRretDocqmx0Sp7FIqU=
X-Google-Smtp-Source: AGHT+IGAJCWhpIZ5cBm4LAFsrDxyQjCv6z7IHjNQdgw7ZYReNFJnO6KlSLetdJXWDmAzvC8PGJ1qHs/aNr0Q9jJbSVQ=
X-Received: by 2002:a17:907:3d16:b0:adb:229f:6b71 with SMTP id
 a640c23a62f3a-adfad29dd95mr60119666b.5.1749848610511; Fri, 13 Jun 2025
 14:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613-losd-3-inv-icm42600-add-wom-support-v4-0-7e5f554201bf@tdk.com>
 <20250613-losd-3-inv-icm42600-add-wom-support-v4-1-7e5f554201bf@tdk.com>
 <aEvhZiXHLLIRe41-@smile.fi.intel.com> <FR3P281MB17578B82AC67F49552E24EB3CE77A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
 <aEwfUMgLTnQxOh_k@smile.fi.intel.com> <aEwfgP3tiio52Rj-@smile.fi.intel.com>
 <FR3P281MB1757AEF932A3CE2AB9637046CE77A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
 <aEw4q3p12q1iI7vC@smile.fi.intel.com> <aEw9Yxhodwhh8BT6@smile.fi.intel.com> <FR3P281MB175722266C119B719FCE9E6CCE77A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR3P281MB175722266C119B719FCE9E6CCE77A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 14 Jun 2025 00:02:52 +0300
X-Gm-Features: AX0GCFvL8R2aNRCEB9bzIup3Cgf6bvQBDKQQ_tT_IOLmq8KP1Z-ailvQKGnsuNQ
Message-ID: <CAHp75VeS8XQbcTaDFLUYTcd4SEdfoVOd4-mht6NGk__exSD0Vg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] iio: imu: inv_icm42600: add WoM support
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 8:14=E2=80=AFPM Jean-Baptiste Maneyrol
<Jean-Baptiste.Maneyrol@tdk.com> wrote:
 >From: Andy Shevchenko <andriy.shevchenko@intel.com>
> >Sent: Friday, June 13, 2025 17:01
> >On Fri, Jun 13, 2025 at 05:41:47PM +0300, Andy Shevchenko wrote:
> >> On Fri, Jun 13, 2025 at 01:43:58PM +0000, Jean-Baptiste Maneyrol wrote=
:
> >> > >From: Andy Shevchenko <andriy.shevchenko@intel.com>
> >> > >Sent: Friday, June 13, 2025 14:54
> >> > >On Fri, Jun 13, 2025 at 03:53:36PM +0300, Andy Shevchenko wrote:
> >> > >> On Fri, Jun 13, 2025 at 12:46:46PM +0000, Jean-Baptiste Maneyrol =
wrote:
> >> > >> > >From: Andy Shevchenko <andriy.shevchenko@intel.com>
> >> > >> > >Sent: Friday, June 13, 2025 10:29
> >> > >> > >On Fri, Jun 13, 2025 at 09:34:26AM +0200, Jean-Baptiste Maneyr=
ol via B4 Relay wrote:

...

> >> > >> > >Overall, looking to this patch again, I think it would be bett=
er to prepend it
> >> > >> > >by replacing *int*_t types by the respective uXX ones. Because=
 in this patch
> >> > >> > >we add dozens of new ones which increases an unneeded churn in=
 the future.
> >> > >> > >
> >> > >> > In my opinion, to respect the rule don't mix *int*_t and uXX ty=
pes, it is better
> >> > >> > to keep *int*_t types. If it need to be changed, we can change =
afterward the
> >> > >> > whole driver types with a replace tool and send it in a separat=
e patch.
> >> > >>
> >> > >> It will be never ending story, sorry. We need someone to solve th=
is tech debt.
> >> > >> And since this patch adds more than 3 new users of it, I think it=
's a candidate
> >> > >> to embrace the burden.
> >> > >
> >> > >For your convenience I can mock-up a change...
> >> >
> >> > It looks like there's something I don't understand in the kernel Doc=
umentation about
> >> > types then.
> >> > Quoting Documentation/process/coding-style.rst, section 5.d:
> >> > ---
> >> > New types which are identical to standard C99 types, in certain exce=
ptional circumstances.
> >> >
> >> > Although it would only take a short amount of time for the eyes and =
brain to become accustomed
> >> > to the standard types like uint32_t, some people object to their use=
 anyway.
> >> >
> >> > Therefore, the Linux-specific u8/u16/u32/u64 types and their signed =
equivalents which are
> >> > identical to standard types are permitted -- although they are not m=
andatory in new code
> >> > of your own.
> >> >
> >> > When editing existing code which already uses one or the other set o=
f types, you should
> >> > conform to the existing choices in that code.
> >> > ---
> >> >
> >> > My understanding is that uXX are not mandatory for new code. You can=
 use types like *int*_t.
> >> > But you need to conform afterward to the existing choice. That's why=
 this driver was
> >> > done initially with *int*_t types, and that patches are conforming t=
o this choice.
> >>
> >> This part of the documentation has a lot of room for different interpr=
etations.
> >> One [1] may consider this as uXX superior, another, like you, that it'=
s okay
> >> to use.  In any case Greg KH prefers uXX over uintXX_t. And he is also=
 in
> >> the chain of maintainers here. Feel free to amend the Documentation. B=
ut
> >> be sure all stakeholders will see your proposal (like Greg KH and othe=
r
> >> key maintainers).
> >>
> >> > By looking at all Linux drivers, there are plenty of them using *int=
*_t, even
> >> > inside iio:
> >>
> >> $ git grep -l 'u\?int[0-9][0-9]\?_t' -- drivers/iio/ | wc -l
> >> 59
> >>
> >> $ git ls-files drivers/iio*.c | wc -l
> >> 640
> >>
> >> Less than 10%.
> >>
> >> > Then, why it is mandatory to change this driver to use uXX instead?
> >>
> >> TO be consistent. With the above wording in the documentation I may ar=
gue that
> >> entire subsystem should be consistent and at least in IIO we have tons=
 of patch
> >> series that are against the whole subsystem to do one style change or =
another
> >> (look at the recent memset() vs. {} for initialisation).
> >>
> >> [1] https://urldefense.com/v3/__https://lore.kernel.org/all/2025040918=
0953.398686-1-matchstick@neverthere.org/__;!!FtrhtPsWDhZ6tw!DVTvkgDsymM7132=
dB-wjei-s0JxYiivZxtzEHfWjsrn_6toqTXA__hm2nPUh7jmectCXcP9Z3OAh0hMm-WD6eQAHOt=
diGbYQqsw$[lore[.]kernel[.]org]
> >
> >Oh, this [2] is golden!
> >You may found support for your arguments and for mine in that thread, bu=
t the
> >bottom line is: what do maintainers of IIO prefer? (Taking into account =
that it
> >goes via Greg KH)
> >
> >[2]: https://urldefense.com/v3/__https://lore.kernel.org/all/20210423230=
609.13519-1-alx.manpages@gmail.com/__;!!FtrhtPsWDhZ6tw!DVTvkgDsymM7132dB-wj=
ei-s0JxYiivZxtzEHfWjsrn_6toqTXA__hm2nPUh7jmectCXcP9Z3OAh0hMm-WD6eQAHOtdiuFc=
54eI$[lore[.]kernel[.]org]
>
> If this is required, I can do it. I would just want to know if this is ma=
ndatory
> since we already have a couple of drivers merged using standard types and
> other drivers planned to be merged.

Let's wait for others to speak up. Especially maintainers.

> Can I do it in the same series or should it be in a separate patch before=
 this
> series?

Same series, just a prerequisite patch. Note, I have one locally, I
just need to send it and you can use it, but the reason why I haven't
sent is the same =E2=80=94 I want to know the official position of the IIO
subsystem about this.

--=20
With Best Regards,
Andy Shevchenko

