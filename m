Return-Path: <linux-iio+bounces-13886-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FC1A01458
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2025 13:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31CD13A4155
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2025 12:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E581B87DC;
	Sat,  4 Jan 2025 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsB/dL4q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCBCEEA6;
	Sat,  4 Jan 2025 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735994740; cv=none; b=abdJqVWpGIDCPpqDwmHgh9ihZz4L3+Z5aidfXuG68O7DuhL0Wy/s/GIf851hbEg2Wxhhjd7mqm3QxybnNpDkAHI+IcieTEjfpIkY1y1IgEYOM+j1gjtwxs/Fzt8qi2zXjXaUi0Ca13Pkqua2VIjf8x9MZiZAs9LAko8BiXiVjHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735994740; c=relaxed/simple;
	bh=EHUDpYovjokVhBaFK1CwURVE/oujyxCO7dnnYtjR7YA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oo7Ul83QSlxsEPcbyBWQRKywRTAT8UfY8DosDgaujm1K7U/AZaNQswfAPZso5If2xK7h/YyHJM07OkQN5GqSD+a0UxSQI3j4yh5pKul36/RXbHZ6dR3hfAUrUT+7TW7nBUQgPcIYdEO4zHFpVRYJOmZtnXJPrNNgH8KzSbieAjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsB/dL4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F073FC4CED1;
	Sat,  4 Jan 2025 12:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735994740;
	bh=EHUDpYovjokVhBaFK1CwURVE/oujyxCO7dnnYtjR7YA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OsB/dL4qPBErxy30nC/2immL1+ZXi/OT1/JvBZ+jo7IKUzy4ICCmLqzI2Mwzw0jUt
	 uFOGUoGqxVhKsru8/HxTa6suJ1MFmqssWMz6yZQex32USRk+93wvRhGHcLYxXYhkLP
	 MATGyVOKO2Uj5oGM6mPxvh6rKcz4WeQj4WI5M/jdBh23IWRNIWeFmF8PzoTuIIifrW
	 QQX1E7UlZwOQQNZ8UAi88sf4HrvAfdYH89MBhv8EPC1SiaemYI7eG8uCqhlpwoJd6P
	 OvoM6jEJN2vWk66hxeNvrJiXHEQG3WCyjYf0xDfOZjA/7zN4vRMd1uR9GgtmZiBbs6
	 A2VpivUBqLk5g==
Date: Sat, 4 Jan 2025 12:45:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>, Krzysztof
 Kozlowski <krzk@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Conor Dooley <conor+dt@kernel.org>,
 Emil Gedenryd <emil.gedenryd@axis.com>, Andreas Dannenberg
 <dannenberg@ti.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] dt-bindings: iio: light: opt3001: add compatible for
 opt3004
Message-ID: <20250104124530.293e96de@jic23-huawei>
In-Reply-To: <20250102213436.GA602988-robh@kernel.org>
References: <20241227131134.10810-1-hardevsinh.palaniya@siliconsignals.io>
	<qgottqtq5lvp6fifi37xzq7supalvm7leue755yjatyun6k5um@pju4v3kqoizq>
	<PN0P287MB2843E7005997F1728B0F9B2CFF0F2@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
	<20241228131929.49e4a90d@jic23-huawei>
	<PN0P287MB284355F3DD7DCF6BFC6D071FFF092@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
	<20250102213436.GA602988-robh@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2 Jan 2025 15:34:36 -0600
Rob Herring <robh@kernel.org> wrote:

> On Mon, Dec 30, 2024 at 07:34:27AM +0000, Hardevsinh Palaniya wrote:
> > Hi Jonathan,=C2=A0Krzysztof
> > =C2=A0
> > Thanks for your input.
> > =C2=A0 =20
> > > On Sat, 28 Dec 2024 10:54:33 +0000
> > > Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io> wrote:
> > >=C2=A0 =20
> > > > Hi Krzysztof,
> > > > =20
> > > > > On Fri, Dec 27, 2024 at 06:41:32PM +0530, Hardevsinh Palaniya wro=
te: =20
> > > > > > Add Support for OPT3004 Digital ambient light sensor (ALS) with
> > > > > > increased angular IR rejection.
> > > > > >
> > > > > > The OPT3004 sensor shares the same functionality and scale rang=
e as
> > > > > > the OPT3001. The compatible string is added with fallback suppo=
rt to
> > > > > > ensure compatibility.
> > > > > >
> > > > > > Datasheet: https://www.ti.com/lit/gpn/opt3004
> > > > > > Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@silicon=
signals.io>
> > > > > > ---
> > > > > >
> > > > > > v2 -> v3:
> > > > > >
> > > > > > - Reverse the order of compatible string
> > > > > >
> > > > > > v1 -> v2:
> > > > > >
> > > > > > - Use fallback mechanism for the OPT3004.
> > > > > > - Drop 2/2 patch from the patch series[1] as per feedback.
> > > > > >
> > > > > > Link[1]: https://lore.kernel.org/linux-iio/20241224061321.6048-=
1-hardevsinh.palaniya@siliconsignals.io/T/#t =20
> > > > >=C2=A0
> > > > >
> > > > > And where is any user of this, the DTS? We don't take bindings ju=
st
> > > > > because there is such device out there.
> > > > >
> > > > > I looked and nothing:
> > > > > https://lore.kernel.org/all/?q=3Dti%2Copt3004
> > > > > =20
> > > > I added compatibility for the OPT3004 into the driver. However,
> > > > based on Andy's feedback, it seems there might not be a need
> > > > to include this directly in the driver.
> > > > (Refer to Link [1] from the changelog.)
> > > >
> > > > we could follow a similar approach to how we handled the ADXL346,
> > > > by just adding it to the bindings, since the ADXL346 is similar to =
the
> > > > ADXL345.
> > > >
> > > > If I misunderstood then please let me know. =20
> > >
> > > Perhaps give some more information on the device in which this is fou=
nd?
> > > If that's a board that you plan to support upstream in the longer term
> > > then that would provide more justification for this patch.
> > >=C2=A0
> > > The note on the opt3001 page does give a hint as to how the parts are=
 different
> > > but saying the opt3004 has better IR rejection.=C2=A0 They also have =
a somewhat different
> > > sensitivity curves. However, those are details we don't expose in the=
 ABI and the
> > > devices unhelpfully report the same ID register value, so it is not o=
bvious that
> > > we need to treat them differently. =20
> > =C2=A0
> > In our customer project, this sensor is utilized in the product. Howeve=
r,=C2=A0
> > I acknowledge that, at present, there is no upstream user of this bindi=
ng
> > in the mainline.
> > =C2=A0
> > Additionally, it is unlikely that the custom board using this sensor wi=
ll be=C2=A0
> > upstreamed in the future. The primary motivation for this patch is the=
=C2=A0
> > absence of existing support for the OPT3004 in the mainline kernel.
> > =C2=A0
> > I fully understand your concerns regarding the addition of bindings wit=
hout=C2=A0
> > an immediate upstream use case. I leave the decision to you regarding w=
hether
> > it would be appropriate to include this binding. I am open to your guid=
ance and
> > will respect the outcome either way. =20
>=20
> I'm confused. Jonathan seems to say the OPT3004 needs different=20
> handling. The binding says it doesn't at least for some subset of=20
> functionality matching OPT3001.
>=20
> If you need driver changes, then submit this with the driver changes. If=
=20
> you don't, then make it clear the device works with the existing driver.

It would need different handling only if we exposed extremely detailed
information on the light sensitivity.  We've looked at how to design an ABI
for that in the past, but there has never been sufficient demand for that
information to justify what would be a complex bit of ABI.

Datasheet graphs aren't easy to convey from kernel drivers to userspace :(
I don't see us closing that gap in the near future and even then I don't th=
ink
any user would care about the small differences between these two sensors.

Hence I'd suggest we don't explicitly support the OPT3004 in the binding
until we need to. In meantime any out of tree board can just use a
fallback compatible from opt3004 to opt3001 thus future proofing against
the potential for the subtle differences making a difference in the future.

Conclusion: Don't do anything upstream now.

Jonathan


Jonathan


>=20
> Rob


