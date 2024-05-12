Return-Path: <linux-iio+bounces-4978-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7049C8C363E
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 13:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 041B7B20DB7
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 11:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA651CD2A;
	Sun, 12 May 2024 11:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTs1wN1l"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACD11C2AD
	for <linux-iio@vger.kernel.org>; Sun, 12 May 2024 11:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715514475; cv=none; b=a1vX8ob9l59DLi8dR9NHmXydF41yfy+Hle/lDu9hOQuXYFx858SmU3dwL43L11MNYys3FFPwedKnwlX2+GufsYnuW7p6wLV5cmlW6sjSeL4NXW6sIg/cEBNOgDiHU4yfadLhRlMGlSHWiMnZlwEih0x1srBftbmRWt0yRghIyzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715514475; c=relaxed/simple;
	bh=8JfDhB2JyER/KnuVeLAgy585TKodh/vlA9qSyV6cbEw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDH6PqUzBrW9llstwMPkNOCgR/UcyeanTh51S/w7Vam7uSxMMwxikYGFA+vw2xaXbXZMz7Vt74pACxwabPsiY3A4MrhBIDwL/jZnwep0lIXtuqATqMWM5CTDpoxHbO6s7zCInju9fNHIBscu3Gq2lBVXcm9zYia7zqxaR1DtPSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTs1wN1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B69C116B1;
	Sun, 12 May 2024 11:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715514475;
	bh=8JfDhB2JyER/KnuVeLAgy585TKodh/vlA9qSyV6cbEw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VTs1wN1lhgnFyPe+Vf1NZll9dH0x6JEVWmNO9HC1K6if39s2XDSDqvAfQO+QjHlhp
	 lDbZFz1PdbQtNZukkobHz6aC+rhCt8vyhaTgnTa/P+EUI2sZZ3QZzHs5MqoLd2LAOj
	 wE4XjiqCat+ibIZpLYVB6WB8HuZCkDh6G5l9sUZxwcFywMquTmA3hUVvCisNW7AuTI
	 ID+T4HgOpWoJhURdwxGzuszBFyF7fM52ZOGM8AuwOJi4H3PVGbCWclzGs5dHWWv3Xi
	 fU2Oeg8DLItUZERfeXd5YziCe+3wgc+vWizuV+4CDODzRbg01qDNFPQEP067YdjkaE
	 DggsHX88woJHQ==
Date: Sun, 12 May 2024 12:47:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de
Subject: Re: [PATCH] iio: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
Message-ID: <20240512124742.632b0435@jic23-huawei>
In-Reply-To: <vffn6ntzcnps64kczm5rryuiqcjpz4sev2y4nier6divyg5srx@rdzojlblraqb>
References: <20240508072928.2135858-2-u.kleine-koenig@pengutronix.de>
	<20240511142006.27facd74@jic23-huawei>
	<vffn6ntzcnps64kczm5rryuiqcjpz4sev2y4nier6divyg5srx@rdzojlblraqb>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 12 May 2024 13:41:51 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> Hello Jonathan,
>=20
> On Sat, May 11, 2024 at 02:20:06PM +0100, Jonathan Cameron wrote:
> > On Wed,  8 May 2024 09:29:27 +0200
> > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
> >  =20
> > > These drivers don't use the driver_data member of struct i2c_device_i=
d,
> > > so don't explicitly initialize this member.
> > >=20
> > > This prepares putting driver_data in an anonymous union which requires
> > > either no initialization or named designators. But it's also a nice
> > > cleanup on its own.
> > >=20
> > > While add it, also remove commas after the sentinel entries.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > > Hello,
> > >=20
> > > I didn't add all the individual maintainers to Cc and put the iio cha=
nges in a
> > > single patch. If you want I can split per driver (or per iio subdirec=
tory?),
> > > just tell me if you prefer it that way. =20
> >=20
> > I don't mind a single patch as resolving any backporting issues around =
this
> > should be easy.  =20
>=20
> *nod*
>=20
> > Whilst your changes for driver_data in struct i2c_device_id obviously d=
on't
> > need it, maybe it's worth similar patches to cleanup acpi_device_id and
> > of_device_id tables with pointless 0 initialisation? =20
>=20
> Yup, I'm aware of these. I'll tackle them once I'm through with i2c.
>=20
> > Applied this with some conflicts in bmi160 resolved by hand.
> >=20
> > Applied to the togreg branch of iio.git but only pushed out for now as =
testing
> > to let 0-day look at it. I'll rebase on 6.10-rc1 once available. =20
>=20
> Sounds good. I didn't find a public branch on
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/ that
> contains your adaption of my patch. Otherwise I'd have double checked
> your conflict resolution. Feel free to tell me once it's there (or where
> I missed it).
>=20
Got distracted and didn't push out :(
Anyhow, should be there shortly on the testing branch.

Thanks,

Jonathan

> Best regards
> Uwe
>=20


