Return-Path: <linux-iio+bounces-3555-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2789287DA44
	for <lists+linux-iio@lfdr.de>; Sat, 16 Mar 2024 14:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52DBB1C20BC4
	for <lists+linux-iio@lfdr.de>; Sat, 16 Mar 2024 13:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48C2179A7;
	Sat, 16 Mar 2024 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbeEqOiQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7573117BAF
	for <linux-iio@vger.kernel.org>; Sat, 16 Mar 2024 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710595592; cv=none; b=cg6qvRWD6U2fvB1BI+91VVlUADV/ZcrnUq74Uo8at2IW3rrqil8bIAA4eorKx/74NOmSzVaxY6MZe0CTpZlqeJJNKp20aNfAoyGLV7W0oS1c8uw8Jvc3qJpCch9lNu06sxe4dauRVaj9rRxoCDTsRVUDN4lPkq33xT18ssZcDKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710595592; c=relaxed/simple;
	bh=bPiGxqy/7Ev9VovY1nEuD30cL/1DJiw6LXQO2lKPicQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tY/DGzgYFYHm+O0GE7d4tJE6q0aeG05CCK6a+OFJ9v2ZpfCmskv3HBgOJzldhCVBi6tZN84iNFcXob6PaZc73hsxgmYLNLG1g59+Q28ndX5hfUCEPJNCJ+kXoILE8wcOsnJ1c0q+bjnIHrqHvztBNNigIXeFpDvuOMyImi4elAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbeEqOiQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E083BC433F1;
	Sat, 16 Mar 2024 13:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710595591;
	bh=bPiGxqy/7Ev9VovY1nEuD30cL/1DJiw6LXQO2lKPicQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DbeEqOiQW0QT21LYwf5NYNPwWE1mZ/WWEKXUoQ1ZSeI8BX4oL9ji1ULB1FB8b0n/7
	 DTyfOQeGyQM+KbeXvO1ogt/5CKc/gtxCYLZMK3U0+9K07PI1NvuxWjwmk+S24mapKP
	 gggE4xGXC4RnTmbVuTTrZDDuYkFyKn0mQuNOH3u+wnezgdKYJPS9BecKCrStBtAdiI
	 WhlXMP6U5nVNvHN+vlTAuVQXMI7nfbUD11sF4TihUGu6InIw3JMHEg+gIMt5KL0JnG
	 GaCIXJvzwsI/57gIPYtzJGoeRsQhbm5AvvkFMBfvlfOoY2EJwbf35axne8pUHvcUFU
	 S3dRoKhRCg6LA==
Date: Sat, 16 Mar 2024 13:26:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 4/4] iio: inkern: move to the cleanup.h magic
Message-ID: <20240316132618.434ff138@jic23-huawei>
In-Reply-To: <20240309174145.0834de04@jic23-huawei>
References: <20240229-iio-use-cleanup-magic-v3-0-c3d34889ae3c@analog.com>
	<20240229-iio-use-cleanup-magic-v3-4-c3d34889ae3c@analog.com>
	<20240303142431.506c05a2@jic23-huawei>
	<740c98678f943c761623800544a8ba998aa4aa93.camel@gmail.com>
	<20240309174145.0834de04@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 9 Mar 2024 17:41:45 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 04 Mar 2024 09:04:49 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Sun, 2024-03-03 at 14:24 +0000, Jonathan Cameron wrote: =20
> > > On Thu, 29 Feb 2024 16:10:28 +0100
> > > Nuno Sa <nuno.sa@analog.com> wrote:
> > >    =20
> > > > Use the new cleanup magic for handling mutexes in IIO. This allows =
us to
> > > > greatly simplify some code paths.
> > > >=20
> > > > While at it, also use __free(kfree) where allocations are done and =
drop
> > > > obvious comment in iio_channel_read_min().
> > > >=20
> > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>   =20
> > >=20
> > > Hi Nuno
> > >=20
> > > Series looks very nice. One trivial thing inline - I can tidy that up=
 whilst
> > > applying if nothing else comes up.
> > >=20
> > > Given this obviously touches a lot of core code, so even though simpl=
e it's
> > > high risk for queuing up late. I also have a complex mess already que=
ued up
> > > for the coming merge window. Hence I'm going to hold off on applying =
this
> > > series until the start of the next cycle.
> > >=20
> > > Nothing outside IIO is going to depend on it, so it's rather simpler =
decision
> > > to hold it than for the ones that add new general purpose infrastruct=
ure.
> > >=20
> > >    =20
> >=20
> > Seems reasonable... It may even give us some time to see how the cond_g=
uard()
> > and scoped_cond_guard() will end up. =20
>=20
> Absolutely - thankfully converting to the suggestions Linus made will be =
straight
> forwards, so hopefully the worst that happens is a complex merge, or some
> fixing up to do afterwards.
>=20
> >  =20
> > >=20
> > >    =20
> > > > =C2=A0EXPORT_SYMBOL_GPL(iio_read_channel_attribute);
> > > > =C2=A0
> > > > @@ -757,29 +711,24 @@ int iio_read_channel_processed_scale(struct
> > > > iio_channel *chan, int *val,
> > > > =C2=A0	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(=
chan-   =20
> > > > >indio_dev);   =20
> > > > =C2=A0	int ret;
> > > > =C2=A0
> > > > -	mutex_lock(&iio_dev_opaque->info_exist_lock);
> > > > -	if (!chan->indio_dev->info) {
> > > > -		ret =3D -ENODEV;
> > > > -		goto err_unlock;
> > > > -	}
> > > > +	guard(mutex)(&iio_dev_opaque->info_exist_lock);
> > > > +	if (!chan->indio_dev->info)
> > > > +		return -ENODEV;
> > > > =C2=A0
> > > > =C2=A0	if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_PROCES=
SED)) {
> > > > =C2=A0		ret =3D iio_channel_read(chan, val, NULL,
> > > > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_CHAN_INFO_PROCES=
SED);
> > > > =C2=A0		if (ret < 0)
> > > > -			goto err_unlock;
> > > > +			return ret;
> > > > =C2=A0		*val *=3D scale;   =20
> > >=20
> > > 		return 0;
> > >    =20
> > > > =C2=A0	} else {   =20
> > > could drop the else.
> > >    =20
> > > > =C2=A0		ret =3D iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW=
);
> > > > =C2=A0		if (ret < 0)
> > > > -			goto err_unlock;
> > > > +			return ret;
> > > > =C2=A0		ret =3D iio_convert_raw_to_processed_unlocked(chan, *val,
> > > > val,
> > > > =C2=A0							=C2=A0=C2=A0=C2=A0 scale);   =20
> > > 		return iio_convert_raw_to_proc...
> > >    =20
> >=20
> > Hmm, unless I completely misunderstood your comments on v2, this was ex=
actly
> > what I had but you recommended to leave the else branch :).
> >  =20
> That was a younger me :)  Either way is fine.

I compromised - move the returns into the two branches, but kept the else.

Given I've started queuing stuff up for next cycle, seemed sensible to pick=
 these
up. Applied to the togreg-normal branch of iio.git.

That will get rebased on rc1 and become togreg as normal in a few weeks time
and hopefully I'll retire the togreg-normal / togreg-cleanup split.

Thanks,

Jonathan

>=20
> Jonathan
>=20
>=20
> > - Nuno S=C3=A1
> >  =20
>=20
>=20


