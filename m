Return-Path: <linux-iio+bounces-10740-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FBA9A4575
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 20:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908FD284708
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 18:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D112040B3;
	Fri, 18 Oct 2024 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mj0U5Uvz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AEC204092;
	Fri, 18 Oct 2024 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729274970; cv=none; b=lz5JMy0CkEKYC5ors/RSoWYxABk8mVQs6WIO9xOlyh9GKzymumRVJJgljc+G+TRmKScaETd9tZFPuN7DQrSg+0tSJl5gRtfMj2l4mbD+fUEky1k5QzzJSn8npmEiSmCn0Gw6Xjk/arJ356awo1CLoEjPSg6xX3owhmfVnheNbCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729274970; c=relaxed/simple;
	bh=4V6GpGKvYpTfduyTTGEUDYljDeC5zb4hwZzBd8QWZbU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRvzC5xkvFfCHqQ1f6U4t/gNVfDJzlxYETujpYLIGTjbrHQvm37J9qoL3G2Iof5r9EjjdICQrSXfDWo3E6MqsnTeaHJObiD/7snVsz5XzukMgbMNEOjwJpGUSSPrZ6oTg6UeJInDv6S8Zz7KZUz1JR93nCI69NXzwJbO1wdDwMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mj0U5Uvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EE6C4CEC3;
	Fri, 18 Oct 2024 18:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729274970;
	bh=4V6GpGKvYpTfduyTTGEUDYljDeC5zb4hwZzBd8QWZbU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mj0U5UvzUEUVBxT40igNR6+/uG4eYSK6nR1/GnTbUHqN2u5mg8+0NGh9134x7EsR5
	 LKSCNsWS/wsVTVRauPKVVgVcJusqVvWAiQgOKGOl+1w5rB+boGK7CZDt+5wfe58848
	 Z9ye9NWbrpgF9JOTDU+vEPe6sMk0/oyp81nG36+IwQ376TQthZ6s5A8iSSyIFeXP7V
	 SorUOU87eAqOZdmE9UpKDUUbPHuaqCbSmi52P4jxyCt5rRLGGxri7/eXEzJJGCeNs+
	 McfjRgOnMrALpoOKwu2QVJyCI6eldGm1Iv7ZuCZr76ZTYG+zCoskf2XndpyEB+afk0
	 N/NDNesXSM99g==
Date: Fri, 18 Oct 2024 19:09:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: iio: adc: ad7380: fix ad7380-4
 reference supply
Message-ID: <20241018190920.2a037a24@jic23-huawei>
In-Reply-To: <CAEHHSvbvGGD=EPjdB+hPoKx3AHjTB8e3f_umLhv83i4=sRJ0Yw@mail.gmail.com>
References: <20241007-ad7380-fix-supplies-v1-0-badcf813c9b9@baylibre.com>
	<20241007-ad7380-fix-supplies-v1-2-badcf813c9b9@baylibre.com>
	<v7in5n6ktmu5kfzlndn4eujmk5n66fmft4lvwuvucqbcv5r5hb@etdqvn6ev6nl>
	<20241010192218.12808268@jic23-huawei>
	<CAEHHSvaGTKFA1mUeONXUQ=aTirVemHWFc_E-i76sQgtQ5_Svtg@mail.gmail.com>
	<20241014193701.40e3785a@jic23-huawei>
	<CAEHHSvbvGGD=EPjdB+hPoKx3AHjTB8e3f_umLhv83i4=sRJ0Yw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Oct 2024 11:10:52 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> Le lun. 14 oct. 2024 =C3=A0 20:37, Jonathan Cameron <jic23@kernel.org> a =
=C3=A9crit :
> >
> > On Mon, 14 Oct 2024 11:00:39 +0200
> > Julien Stephan <jstephan@baylibre.com> wrote:
> > =20
> > > Le jeu. 10 oct. 2024 =C3=A0 20:22, Jonathan Cameron <jic23@kernel.org=
> a =C3=A9crit : =20
> > > >
> > > > On Tue, 8 Oct 2024 09:52:50 +0200
> > > > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > =20
> > > > > On Mon, Oct 07, 2024 at 05:45:45PM +0200, Julien Stephan wrote: =
=20
> > > > > > ad7380-4 is the only device from ad738x family that doesn't hav=
e an
> > > > > > internal reference. Moreover its external reference is called R=
EFIN in
> > > > > > the datasheet while all other use REFIO as an optional external
> > > > > > reference. If refio-supply is omitted the internal reference is
> > > > > > used.
> > > > > >
> > > > > > Fix the binding by adding refin-supply and makes it required for
> > > > > > ad7380-4 only. =20
> > > > >
> > > > > Maybe let's just use refio as refin? Reference-IO fits here well.
> > > > > Otherwise you have two supplies for the same. =20
> > > > Whilst it is ugly, the effort this series is going to in order
> > > > to paper over a naming mismatch makes me agree with Krzysztof.
> > > >
> > > > I think adding a comment to the dt-binding would be sensible
> > > > though as people might fall into this hole.
> > > > =20
> > >
> > > Hi Jonathan and Krzysztof,
> > >
> > > I am currently adding support for another chip to this family
> > > (ADAQ4380-4) and it also uses REFIN.. but in another way ad7380-4
> > > does..
> > > So:
> > > - ad7380-4 does not have any internal reference and use a mandatory
> > > refin supply as external reference
> > > - adaq4380-4 does not have external reference but uses a 3V internal
> > > reference derived from a 5V mandatory refin supply
> > > - all others (AFAIK) use an optional refio external reference. If
> > > omitted, use an internal 2.5V reference.
> > >
> > > I am not sure using a single refio-supply for all will make things
> > > clearer.. What do you think? Should I also send the adaq series now to
> > > bring more context? (I wanted feedback on this series first).
> > > =20
> >
> > Sounds like that context would be useful if you have it more or less
> > ready to send anyway.  I don't have particularly strong views on this
> > either way.  If we 'fix' the case you have here, old bindings should
> > continue to work for the part you are moving over (though no need
> > to have them in the dt-bindings file).
> > =20
>=20
> Hi Jonathan,
>=20
> Just sent the new series with an RFC tag.
https://lore.kernel.org/all/20241015-ad7380-add-adaq4380-4-support-v1-1-d2e=
1a95fb248@baylibre.com/

Examples in there look strong enough reason that we are going to need
refin-supply in the binding anyway shortly. So might as well use it for this
part as well.

Just include a reference to that patch under the --- in v2.
+ see if you can keep the description from patch 1 and fix the assignment i=
ssue
the bot found.


Thanks,

Jonathan



>=20
>=20
> Cheers
> Julien
>=20
> > Jonathan
> > =20
> > > Cheers
> > > Julien
> > > =20
> > > > Other than the missing ret =3D, rest of series looks fine to me
> > > >
> > > > Jonathan
> > > > =20
> > > > >
> > > > > Best regards,
> > > > > Krzysztof
> > > > > =20
> > > > =20
> > =20


