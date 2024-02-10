Return-Path: <linux-iio+bounces-2368-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8158985055D
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 17:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 556D51C24ECF
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 16:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A8B5C8F4;
	Sat, 10 Feb 2024 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/vtRMKO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907C05C8E9;
	Sat, 10 Feb 2024 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707583324; cv=none; b=XoSMzOP4t5NbJvtg1p8jzTwqS6E3o4IVq85YBaBXAHxhB3BujBCJKpp0iCAUNqpH2VqxbDL93kbV/rzdrC7BVEUxJmp6yaRRf5tBujFC9KciD3W0/ec537TpaRpatUFyv87nUB9XpKd7hPcjudkxsczhH9EO9b6rq7NM8ejflS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707583324; c=relaxed/simple;
	bh=owz1tK0Z5BI52KOQBXE8oG2n0PLLddltbo9LC+lQeAM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ByYLr78z+pEKgDQjywuuk5/rYZLuiNLtyGrIzc740SZ4hvaITqWbsyg3tOVcsHBW7N/Xxz1zvJ6+r+GyFnBfoH7ie8J8JL2gAf05adPGKnqrqs4t6jXTeoUzv4vvfwvcgIXFkxhYnggOhsMm+D7UESqYC21L8BCj8pgxYbhsD54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/vtRMKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC1EC433C7;
	Sat, 10 Feb 2024 16:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707583324;
	bh=owz1tK0Z5BI52KOQBXE8oG2n0PLLddltbo9LC+lQeAM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o/vtRMKODFRVPr80dylBNE1eu48kLzFSXfx4D4Ld44rTuzYrqyAkmyM0zYZmHPWL7
	 g2Tv2NtpqMFM+S0p8+M6RXE6K7oqcXI0AoWN1QjecVr4gYoy5dVV2BY2AQ7VM1jNxv
	 h7pU4ZNzyWUJgiVmb3JPZXx97ZfRLD7/cvd3GjLhiNn8c9ovtmfzJ92oLg7RTGDY4+
	 p6XGix4541lgcSfmNtQIGizMs1PlqJfaCqkZcUm/lwzklFmjjzZ2DMmIHqZquMfLgO
	 hG4XHiRke2eOy1foWpE5eFNwdZzRYJ9VzJNtuAnKAcNMkYXT+Yfgmt1DaW8W58dEDv
	 eyAO89NDbhVuA==
Date: Sat, 10 Feb 2024 16:41:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Olivier
 Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v10 5/7] iio: add the IIO backend framework
Message-ID: <20240210164152.49d5406a@jic23-huawei>
In-Reply-To: <CAHp75VeqUnV33YF1WT9B0h=V_DpJBjwaH3g6AHiQQ-yDZBOyfg@mail.gmail.com>
References: <20240209-iio-backend-v10-0-3ed842064318@analog.com>
	<20240209-iio-backend-v10-5-3ed842064318@analog.com>
	<CAHp75VeqUnV33YF1WT9B0h=V_DpJBjwaH3g6AHiQQ-yDZBOyfg@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 9 Feb 2024 18:30:53 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Feb 9, 2024 at 5:26=E2=80=AFPM Nuno Sa <nuno.sa@analog.com> wrote:
>=20
> ...
>=20
> > +struct iio_backend *devm_iio_backend_get(struct device *dev, const cha=
r *name)
> > +{
> > +       struct fwnode_handle *fwnode;
> > +       struct iio_backend *back;
> > +       unsigned int index;
> > +       int ret;
> > +
> > +       if (name) {
> > +               ret =3D device_property_match_string(dev, "io-backend-n=
ames",
> > +                                                  name);
> > +               if (ret < 0)
> > +                       return ERR_PTR(ret);
> > +               index =3D ret;
> > +       } else {
> > +               index =3D 0;
> > +       }
> > +
> > +       fwnode =3D fwnode_find_reference(dev_fwnode(dev), "io-backends"=
, index);
> > +       if (IS_ERR(fwnode)) {
> > +               dev_err_probe(dev, PTR_ERR(fwnode),
> > +                             "Cannot get Firmware reference\n");
> > +               return ERR_CAST(fwnode);
> > +       }
> > +
> > +       guard(mutex)(&iio_back_lock);
> > +       list_for_each_entry(back, &iio_back_list, entry) {
> > +               if (!device_match_fwnode(back->dev, fwnode))
> > +                       continue; =20
>=20
> > +               fwnode_handle_put(fwnode);
> > +               ret =3D __devm_iio_backend_get(dev, back); =20
>=20
> This order makes me think about the reference counting. So, fwnode is
> the one of the backend devices to which the property points to.
> Another piece is the local (to this framework) list that keeps backend
> devices. So, fwnode reference can be  dropped earlier, while the usual
> pattern to interleave gets and puts in a chain. Dunno if above needs a
> comment, reordering or nothing.
>=20
I'm lost. Why don't we need to hold fwnode reference for the
device_match_fwnode() just before here?

Or do you mean that we are safe here with the fwnode_handle_put() being
before the __devm_iio_backend_get()? I think you are correct that the
lifetimes are fine as we switched from the fwnode to the
iio_backend from the list at this point.

> > +               if (ret)
> > +                       return ERR_PTR(ret);
> > +
> > +               return back;
> > +       }
> > +
> > +       fwnode_handle_put(fwnode);
> > +       return ERR_PTR(-EPROBE_DEFER); =20
>=20
> While thinking about the above, I noticed the room to refactor.
>=20
>   list_for_each_entry(...) {
>     if (...)
>       break;
>   }
>   fwnode_handle_put(...);
>   // Yes, we may use the below macro as the (global) pointers are
> protected by a mutex.
>   if (list_entry_is_head(...))

Knowing that means we failed to match is a bit obscure.

>     return ERR_PTR(...);
>=20
>   ret =3D __devm_iio_backend_get(...);
>   ...

Maybe - it's a little ugly either way.  I don't think we care about
potentially holding the fwnode handle too long, so flipping over to
the cleanup.h handling (I need to get back to that sometime this week)
will make this all simpler.

>=20
> > +} =20
>=20


