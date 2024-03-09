Return-Path: <linux-iio+bounces-3407-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D76CE87727E
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 18:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D80A1F21F88
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 17:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1089C225DA;
	Sat,  9 Mar 2024 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLxsBRHG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C501B2C85D
	for <linux-iio@vger.kernel.org>; Sat,  9 Mar 2024 17:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710006117; cv=none; b=oB2Qwh2uEvZpSNFzSG5epYLO5am59zLxHQahBj5muykdlvCCMJZg1zCzPR3yjkSFZdjeEq+lhNjBuqzCqW3UmaBJs5RsDjCg1FQ3qufjykVNcoKPkxsqACStwgojm6ifrjHfKsFJW0m2cGZrLbUXl+3EbLfSHTwycfD7QcnY+ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710006117; c=relaxed/simple;
	bh=enoU/oU45b+qMJWKCTH0lkoXhAIsPrUcvKPHLiShlPc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O35vkFETsIBW/wUHHEUK2E2xylvRb7Do6Gbd+NdbHjf6yBYAHgB/I1e4DLJm1SOry9vJz6gBUgrMH7SjIQyiepafDoxeQ1oAg9kNPr8CpQg3rJYNeyVhUn2eBf1qtf++6L5aerCqk1S2Nu03Ce18Y/gyLzK3I0SnoyNdTsl/P48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLxsBRHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4336FC433C7;
	Sat,  9 Mar 2024 17:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710006117;
	bh=enoU/oU45b+qMJWKCTH0lkoXhAIsPrUcvKPHLiShlPc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BLxsBRHGddPQvImZ3+vGqa6EN5b3Zn9zCqxd5PXyz31FPXNs+S2WYx2HET9xQOgEK
	 FVhHWIWI6itXaeGDiqrwjnmQfdc4qc4rQSj6T1QcInKg/opo7m0K4adE1jrxCID5hW
	 7n44PWhr0wxXuy3auFWkAoLcC/GH8ooFmiOrA8XEinKF+fOFnS572vhT5LRIz5NCVw
	 P9c2t+uDK43XmEfZcAf0w2L8p1X7GiAFGWz66YhdC5q9WgJPfeGXXnh/FsycRDceq4
	 6vR8n+QUGQHsqV4brAwinRwDV1A5aMvZMKOkS8V6wtdip73UGQ/mwaofRfyKTQNZEb
	 zCSEUPedZeiRQ==
Date: Sat, 9 Mar 2024 17:41:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 4/4] iio: inkern: move to the cleanup.h magic
Message-ID: <20240309174145.0834de04@jic23-huawei>
In-Reply-To: <740c98678f943c761623800544a8ba998aa4aa93.camel@gmail.com>
References: <20240229-iio-use-cleanup-magic-v3-0-c3d34889ae3c@analog.com>
	<20240229-iio-use-cleanup-magic-v3-4-c3d34889ae3c@analog.com>
	<20240303142431.506c05a2@jic23-huawei>
	<740c98678f943c761623800544a8ba998aa4aa93.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 04 Mar 2024 09:04:49 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sun, 2024-03-03 at 14:24 +0000, Jonathan Cameron wrote:
> > On Thu, 29 Feb 2024 16:10:28 +0100
> > Nuno Sa <nuno.sa@analog.com> wrote:
> >  =20
> > > Use the new cleanup magic for handling mutexes in IIO. This allows us=
 to
> > > greatly simplify some code paths.
> > >=20
> > > While at it, also use __free(kfree) where allocations are done and dr=
op
> > > obvious comment in iio_channel_read_min().
> > >=20
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com> =20
> >=20
> > Hi Nuno
> >=20
> > Series looks very nice. One trivial thing inline - I can tidy that up w=
hilst
> > applying if nothing else comes up.
> >=20
> > Given this obviously touches a lot of core code, so even though simple =
it's
> > high risk for queuing up late. I also have a complex mess already queue=
d up
> > for the coming merge window. Hence I'm going to hold off on applying th=
is
> > series until the start of the next cycle.
> >=20
> > Nothing outside IIO is going to depend on it, so it's rather simpler de=
cision
> > to hold it than for the ones that add new general purpose infrastructur=
e.
> >=20
> >  =20
>=20
> Seems reasonable... It may even give us some time to see how the cond_gua=
rd()
> and scoped_cond_guard() will end up.

Absolutely - thankfully converting to the suggestions Linus made will be st=
raight
forwards, so hopefully the worst that happens is a complex merge, or some
fixing up to do afterwards.

>=20
> >=20
> >  =20
> > > =C2=A0EXPORT_SYMBOL_GPL(iio_read_channel_attribute);
> > > =C2=A0
> > > @@ -757,29 +711,24 @@ int iio_read_channel_processed_scale(struct
> > > iio_channel *chan, int *val,
> > > =C2=A0	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(ch=
an- =20
> > > >indio_dev); =20
> > > =C2=A0	int ret;
> > > =C2=A0
> > > -	mutex_lock(&iio_dev_opaque->info_exist_lock);
> > > -	if (!chan->indio_dev->info) {
> > > -		ret =3D -ENODEV;
> > > -		goto err_unlock;
> > > -	}
> > > +	guard(mutex)(&iio_dev_opaque->info_exist_lock);
> > > +	if (!chan->indio_dev->info)
> > > +		return -ENODEV;
> > > =C2=A0
> > > =C2=A0	if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_PROCESSE=
D)) {
> > > =C2=A0		ret =3D iio_channel_read(chan, val, NULL,
> > > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_CHAN_INFO_PROCESSE=
D);
> > > =C2=A0		if (ret < 0)
> > > -			goto err_unlock;
> > > +			return ret;
> > > =C2=A0		*val *=3D scale; =20
> >=20
> > 		return 0;
> >  =20
> > > =C2=A0	} else { =20
> > could drop the else.
> >  =20
> > > =C2=A0		ret =3D iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
> > > =C2=A0		if (ret < 0)
> > > -			goto err_unlock;
> > > +			return ret;
> > > =C2=A0		ret =3D iio_convert_raw_to_processed_unlocked(chan, *val,
> > > val,
> > > =C2=A0							=C2=A0=C2=A0=C2=A0 scale); =20
> > 		return iio_convert_raw_to_proc...
> >  =20
>=20
> Hmm, unless I completely misunderstood your comments on v2, this was exac=
tly
> what I had but you recommended to leave the else branch :).
>=20
That was a younger me :)  Either way is fine.

Jonathan


> - Nuno S=C3=A1
>=20


