Return-Path: <linux-iio+bounces-17411-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB283A763C1
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5003A5BBB
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 10:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A10D1DE4D8;
	Mon, 31 Mar 2025 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrpJwIvg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021611C8637
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743415342; cv=none; b=M43/Ms+eGdr+y6V8aoMIpxt4Wy9EngKeeCfUDb6As+/spvmDY33zsqeBLqH/2C4F1mDRPxxXSe5f4lPZ0Hgssw/DTT2lcbR71fecwLKK4geMFjkv7nkE518VB+S8RFiZqisCSDzovupz2m7RzSJBC9EF8CV/XjZQp9KKNHn9JVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743415342; c=relaxed/simple;
	bh=4Iy5z+BOfVC/Sc6c4Agw/ETDogSnGenMvoahzckEU2E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GmMLCkQkZ8VbGV0mpa+JZ4opQ691Zk5E6V8A9x8i9nJ8MS3ptJ/7ZqoVPexFqDKa8UgTwt87YMlxc0pexi1BK+ixuy+xuJcvcMnmfK36gFUF7NftFxI65Z3BfKtA2paOYGrJsYldWOLQBjsuGVHU8+pR4jIw7kfnKNUTOt7l36s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrpJwIvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4153CC4CEE3;
	Mon, 31 Mar 2025 10:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743415341;
	bh=4Iy5z+BOfVC/Sc6c4Agw/ETDogSnGenMvoahzckEU2E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OrpJwIvgs4132O57OA+5j0iGP3aUzMHlSQB+U8ik5x/RT86f94sutMTi27bn1MLp9
	 7Uu6KYCIRAlsVk0I00v3trpyMYEhHteK9O83QwChwS/5ZTc21THy6J6DOI2osTFFR7
	 PnTviucZdRNU/eolx1MDOxZgGdWloVya/yBz9YRuvYs3s6qONJLufpGslUUlIvZim8
	 KMpzdIVJz9ERI4Xdp2XwqMX96ITJfKNitRu1dYZnhIU+gDdDJFdNLqbLfxQPfx9waE
	 p6QY3lgKeqGnaRR0YPsOdt0xsDfoJJqiHPyJfnYDCMDCOdH2FvdLU7/90iNFHMR5kz
	 U4kN7VG8ZVYag==
Date: Mon, 31 Mar 2025 11:02:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: adc: ad7124: Fix 3dB filter frequency
 reading
Message-ID: <20250331110214.1eec2513@jic23-huawei>
In-Reply-To: <fgd3vr46ijt3kr6onvtulmfulgbr2jpshcyk3dr2pvz7vqs2fq@mka4q2zqmpwe>
References: <20250317115247.3735016-5-u.kleine-koenig@baylibre.com>
	<20250317190031.22c822c4@jic23-huawei>
	<fgd3vr46ijt3kr6onvtulmfulgbr2jpshcyk3dr2pvz7vqs2fq@mka4q2zqmpwe>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Mar 2025 10:44:52 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello Jonathan,
>=20
> On Mon, Mar 17, 2025 at 07:00:31PM +0000, Jonathan Cameron wrote:
> > On Mon, 17 Mar 2025 12:52:46 +0100
> > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:
> >  =20
> > > Hello,
> > >=20
> > > (implicit) v1 of this patch set is available at
> > > https://lore.kernel.org/linux-iio/cover.1741801853.git.u.kleine-koeni=
g@baylibre.com
> > > .
> > >=20
> > > Changes since then:
> > >=20
> > >  - Reorder patches to have the cleanup ("Make register naming
> > >    consistent") last
> > >  - Drop write support for the filter_low_pass_3db_frequency property
> > >    which is completely broken.
> > >  - trivially rebase to todays iio/togreg
> > >=20
> > > I wonder if there is a way to remove the writable permission of the
> > > filter_low_pass_3db_frequency sysfs file instead of erroring out when=
 a
> > > value is written. Hints welcome. =20
> >=20
> > Unfortunately not. With a lot of hindsight that is a flaw in the way
> > we generate sysfs attributes. IIRC when hwmon added similar they
> > avoided that trap.  To retrofit it onto IIO now we'd have to have
> > some form of complex permissions query or duplicate all the masks
> > to allow r and w separately. =20
>=20
> OK, fine for me, so I didn't miss anything :-)
>=20
> I have another patch in my queue for ad7124. For that it would be great
> to know if you intend to apply this patch set. If yes, I continue to
> build on top of this stack.

Sorry for slow reply.  Bunch of travel (and being a tourist on either end
of the work bit ;)

Subject to the question on patch 1 from Marcelo I'm fine with this.

I'll probably take all 3 for next merge window though as patch 1 is
a minor fix I think in something that people probably haven't really=20
been using and splitting it makes for a messy cycle.

Jonathan



>=20
> Best regards
> Uwe


