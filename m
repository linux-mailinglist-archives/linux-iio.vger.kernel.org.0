Return-Path: <linux-iio+bounces-2367-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83315850538
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 17:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5EEB1C22DE2
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 16:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD08A41C87;
	Sat, 10 Feb 2024 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8fALJ8q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890D529CEF;
	Sat, 10 Feb 2024 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707582724; cv=none; b=TRqeFCNAvEKDEAbhrtSlsCeXN+dmKCOS62LATLTnkZyoOsronVTpJi9HxO4iQdTGnMNtChwNDbc7BW467clj2JBPDWYJYZzoHn6SbeaI4go8Z4V4fSH0cPXyix6tmo9KA9vinYwwBEW0UInpaWxWwVjqcb/OdI+tdhxJXooEFBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707582724; c=relaxed/simple;
	bh=fRQuHaaaN/V5ij49FbfGzU94BV7t2qScQxlth67fsyo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qY4vTEOQgAX9lhKgu3aIhcqse7qWiNzazdY+6d3sBEFa4Qi93mG3VM0As8V+jEgb2SkDl2KtxQzsMXuCX5Gyj5qTFHY0JYeZb1KhF1O+T6D7yDA6oBf4/vbFWePwB/jdU8YRRCFZM+T4SI54mAGYun1DanFwLZGnWNEk7eThY6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8fALJ8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA9DC433C7;
	Sat, 10 Feb 2024 16:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707582724;
	bh=fRQuHaaaN/V5ij49FbfGzU94BV7t2qScQxlth67fsyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m8fALJ8qRwn3nqGlYBGnmEeCCntgMBGtxtRjvyNTi37W5t6hA3Asun0xhDH68yGty
	 TarF+o+d0ZPvLXmNeZEnB94b2B1Fx1zQtTRWQ/3Pk3isBqnosWUa/OBVNZ4/ELWQHG
	 0O6ADEPTLGMe5lTZ9jRugMz6eG2pDDDfaVdDeKpbbBXOnTCoHixLiPo/keiPJpXcOA
	 UN7uN1SorNzCYHiIrGlZyb5vE9ztojSmB/qlv6xdywYIKzQUe6R2BG5OeG6LS542LW
	 htNj1pjTDS1A26aGi5bpREthNHrWwRCdZSuH1+gVQX5+bhfKTG9WCbuG/O47HGDgVN
	 e+XWRn7FmS2hw==
Date: Sat, 10 Feb 2024 16:31:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, nuno.sa@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v9 6/7] iio: adc: ad9467: convert to backend framework
Message-ID: <20240210163151.37c31016@jic23-huawei>
In-Reply-To: <18a89feff869edb9bef6c5d7ffdbc7baadf2cfee.camel@gmail.com>
References: <20240206-iio-backend-v9-0-df66d159c000@analog.com>
	<20240206-iio-backend-v9-6-df66d159c000@analog.com>
	<CAHp75VeWV0+hqCoUb4YvfObnEAv0AaYJmXgpxJLfve+mBwhkyQ@mail.gmail.com>
	<f6ed72343be50c358db8e7e36d9afa875f788425.camel@gmail.com>
	<CAHp75Vf3vvYHz6pTpAQGEAxV-obWV+0XbhVhaFqYU5JUbtFY8Q@mail.gmail.com>
	<18a89feff869edb9bef6c5d7ffdbc7baadf2cfee.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 07 Feb 2024 10:23:36 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2024-02-06 at 19:51 +0200, Andy Shevchenko wrote:
> > On Tue, Feb 6, 2024 at 6:51=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.=
com> wrote: =20
> > > On Tue, 2024-02-06 at 16:20 +0200, Andy Shevchenko wrote: =20
> > > > On Tue, Feb 6, 2024 at 12:08=E2=80=AFPM Nuno Sa via B4 Relay
> > > > <devnull+nuno.sa.analog.com@kernel.org> wrote: =20
> >=20
> > ...
> >  =20
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->back =3D devm_iio_backe=
nd_get(&st->spi->dev, NULL);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If not found, don't erro=
r out as we might have legacy DT
> > > > > property */
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!IS_ERR(st->back))
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (PTR_ERR(st->back) !=3D =
-ENOENT)
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(st->back); =20
> > > >=20
> > > > This looks hackish... =20
> > >=20
> > > This was suggested by Jonathan so I'm keen in leaving it as-is =20
> >=20
> > I think I proposed how to improve it. Jonathan?
> >  =20
>=20
> Well, you did change it around so that we have the typical 'if (ret)' pat=
tern.
> But, honestly, that is also bringing an arguably useless helper. So, yes,
> currently we are not doing the typical "check for errors first" pattern b=
ut I do
> think that the code is perfectly fine and readable as it is.
>=20
> It's also already pretty late in the review process of the series and the=
re was
> already some back and forth so to me, the above is really a minor detail =
and I'm
> not keen on changing it at this stage (unless Jonathan really feels stron=
g about
> doing it).
It's odd code I don't expect to see anywhere else, so I'm not that fussed if
it takes a little more thinking than normal (and you have a comment there t=
o help
us!)

So I'm fine with leaving this as it stands

Jonathan

>=20
> I'll spin a v10 with your dev_err_probe() suggestion later today but at t=
his
> point I would prefer to not have to spin another one (afterwards) unless =
really
> needed (meaning, not because of minor details).
>=20
> - Nuno S=C3=A1


