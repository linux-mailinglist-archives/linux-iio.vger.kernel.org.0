Return-Path: <linux-iio+bounces-10576-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED5499D6A1
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 20:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D741F2164C
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 18:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16131C9B87;
	Mon, 14 Oct 2024 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvTH/000"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DDD1AB6FC;
	Mon, 14 Oct 2024 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728931033; cv=none; b=l0p3MWdG0vIVd0uJ1e4RG/l6xprOl4ZCHVx+TRu18h5MLBnvQrr0ei8S19e/yWeOksvEkhVdToxppfHdHLtIMCa8EHKn+hqhwWWadzJV7EWqhdKiisxBMExKn0EalbmGg3Py0EzfYR3VQz4zYCDzKDhyT/cFsLS3GhLj767vMNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728931033; c=relaxed/simple;
	bh=VYkzv62Tv2hPBGCkoeopLT5+FAqEnNT/1ZDpLUILkMs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DEL/gPd196x8epcCePUItlY/+46boCXpqBghVolDyNKhmPOGu0X9mF1DnyXVnaQ1IL8Gnt34KiUTGHWEHJpLAopK/dX5CVdd8rqIf4Ji9kDwz3XyWitMRboCEnxf701MIeccEhMkaBT0xfpXcvWMH6fu7xwtCYvzVeqZMipzVAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvTH/000; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D018C4CEC3;
	Mon, 14 Oct 2024 18:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728931033;
	bh=VYkzv62Tv2hPBGCkoeopLT5+FAqEnNT/1ZDpLUILkMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MvTH/000qxj3FRGeoUrZ9ZJ2d9Sv7C/hZwti0S8ZhivwTkgFjXf6iUeKmaeJW/V8n
	 eh9HmiGGiAZ9AJGLzZx/x/iQsrWsMq2s0KTWY5ig0e2Yyo/vyY1MhqMAxyQ1RdGUQ3
	 NfA42MRlR18uPZQSa0CUQOvrLiu962/fhBwVEFEQqcl3/zRiu0ZUgb7hO6nCvx9oEN
	 Kj4Mxg5aRnQ+qXfl1TkldyqIj7Ot983Mi+HYcIQ/UTSCyHIXjXSQg6Wk2MzrTCurf/
	 HUxSCk0L6T+jMZq+4kg+sfiH+lfRv02vKDmroRXf0yqQxgGAHFO19KXRxJNvTHjdRW
	 4P2zF+fs87w8w==
Date: Mon, 14 Oct 2024 19:37:01 +0100
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
Message-ID: <20241014193701.40e3785a@jic23-huawei>
In-Reply-To: <CAEHHSvaGTKFA1mUeONXUQ=aTirVemHWFc_E-i76sQgtQ5_Svtg@mail.gmail.com>
References: <20241007-ad7380-fix-supplies-v1-0-badcf813c9b9@baylibre.com>
	<20241007-ad7380-fix-supplies-v1-2-badcf813c9b9@baylibre.com>
	<v7in5n6ktmu5kfzlndn4eujmk5n66fmft4lvwuvucqbcv5r5hb@etdqvn6ev6nl>
	<20241010192218.12808268@jic23-huawei>
	<CAEHHSvaGTKFA1mUeONXUQ=aTirVemHWFc_E-i76sQgtQ5_Svtg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Oct 2024 11:00:39 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> Le jeu. 10 oct. 2024 =C3=A0 20:22, Jonathan Cameron <jic23@kernel.org> a =
=C3=A9crit :
> >
> > On Tue, 8 Oct 2024 09:52:50 +0200
> > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > =20
> > > On Mon, Oct 07, 2024 at 05:45:45PM +0200, Julien Stephan wrote: =20
> > > > ad7380-4 is the only device from ad738x family that doesn't have an
> > > > internal reference. Moreover its external reference is called REFIN=
 in
> > > > the datasheet while all other use REFIO as an optional external
> > > > reference. If refio-supply is omitted the internal reference is
> > > > used.
> > > >
> > > > Fix the binding by adding refin-supply and makes it required for
> > > > ad7380-4 only. =20
> > >
> > > Maybe let's just use refio as refin? Reference-IO fits here well.
> > > Otherwise you have two supplies for the same. =20
> > Whilst it is ugly, the effort this series is going to in order
> > to paper over a naming mismatch makes me agree with Krzysztof.
> >
> > I think adding a comment to the dt-binding would be sensible
> > though as people might fall into this hole.
> > =20
>=20
> Hi Jonathan and Krzysztof,
>=20
> I am currently adding support for another chip to this family
> (ADAQ4380-4) and it also uses REFIN.. but in another way ad7380-4
> does..
> So:
> - ad7380-4 does not have any internal reference and use a mandatory
> refin supply as external reference
> - adaq4380-4 does not have external reference but uses a 3V internal
> reference derived from a 5V mandatory refin supply
> - all others (AFAIK) use an optional refio external reference. If
> omitted, use an internal 2.5V reference.
>=20
> I am not sure using a single refio-supply for all will make things
> clearer.. What do you think? Should I also send the adaq series now to
> bring more context? (I wanted feedback on this series first).
>=20

Sounds like that context would be useful if you have it more or less
ready to send anyway.  I don't have particularly strong views on this
either way.  If we 'fix' the case you have here, old bindings should
continue to work for the part you are moving over (though no need
to have them in the dt-bindings file).

Jonathan

> Cheers
> Julien
>=20
> > Other than the missing ret =3D, rest of series looks fine to me
> >
> > Jonathan
> > =20
> > >
> > > Best regards,
> > > Krzysztof
> > > =20
> > =20


