Return-Path: <linux-iio+bounces-3819-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2089288CBEA
	for <lists+linux-iio@lfdr.de>; Tue, 26 Mar 2024 19:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B4E1F33E3A
	for <lists+linux-iio@lfdr.de>; Tue, 26 Mar 2024 18:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD4086626;
	Tue, 26 Mar 2024 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plQ0Q3rW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25098527A;
	Tue, 26 Mar 2024 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711477330; cv=none; b=RhkKB3Xoi5turxNF5XotrZq54NutBGuQZ2S0Qez0JoCyk57V1Dfh+hFQcByWz51EQLshQP+jb2LV9H7EmMhOhQH4Yi9nBwhc3eX9fvE2uX5vOD8Z3ANCw1D9PtYC0b8AJKjTzvCi/jAJp/vwXhQgJvUhqDFOwfyrRsTPTONHKrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711477330; c=relaxed/simple;
	bh=LmnS6eBvBa5awlBsum9RK+OXNBT2Mr9Z/NCR7y7hu6A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VcqHOfXKEy1EwgmxKtQJ/ttVU904i5vo9419/9FXmevxQxlzHVZ+nk3gNQqCaFzYeJ5E0y84v7oBPZ0LvAQNsJ8pCLmThAVBuNmGLuxezUfiwA6+PD8XnoEOuFUorrOuSxjjLkKTxnwF8LRM2eW0d9NXSphVfyQo6vNVzuqxbW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plQ0Q3rW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCA0C43390;
	Tue, 26 Mar 2024 18:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711477329;
	bh=LmnS6eBvBa5awlBsum9RK+OXNBT2Mr9Z/NCR7y7hu6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=plQ0Q3rWlM3clHWxGS0j9Mk7mdSBHTD0ZOXfg60La0B4Hq0jOPXfiR5EA7BP/7/B7
	 tNxPajdJpREXd7T3TAWutykFZUn4Lq8eM7uj2ByFVWPZVIGEkxc/Jf1EcGYbydSgcn
	 1hZbl848ewwXjHMTXAGge7uOyYNRwXQ/Iiai222UUqkFH4b8sm61e0iav0F1qMjbaf
	 kFT9Szt2coqxjGdZ+aLwrkAGQulqZLynI+n5bMWGwGhbWm9bpcRYd4oAbrfTeGMUAb
	 4Ep6eFYmdoy1ZmqvCxRTuG6gTeG6GKwJP/SpoS1tEMkgqhKBbfSEyon5/q9+fWysu1
	 1RdHvA48jhXdw==
Date: Tue, 26 Mar 2024 18:21:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, "Trevor Zaharichuk"
 <trevor@au-zone.com>, Greg Lytle <greg@au-zone.com>, "Lars-Peter Clausen"
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Sean Nyekjaer <sean@geanix.com>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: iio: dac: ti,dac5571: Add DAC081C081
 support
Message-ID: <20240326182152.03f860e5@jic23-huawei>
In-Reply-To: <20240326171316.000018f5@Huawei.com>
References: <20240325203245.31660-1-laurent.pinchart@ideasonboard.com>
	<20240325203245.31660-2-laurent.pinchart@ideasonboard.com>
	<20240325204857.4f2fd468@jic23-huawei>
	<20240325205641.GD23988@pendragon.ideasonboard.com>
	<20240326152927.00006229@Huawei.com>
	<20240326165043.GB28895@pendragon.ideasonboard.com>
	<20240326171316.000018f5@Huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Mar 2024 17:13:16 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 26 Mar 2024 18:50:43 +0200
> Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:
>=20
> > On Tue, Mar 26, 2024 at 03:29:27PM +0000, Jonathan Cameron wrote: =20
> > > On Mon, 25 Mar 2024 22:56:41 +0200 Laurent Pinchart wrote:   =20
> > > > On Mon, Mar 25, 2024 at 08:48:57PM +0000, Jonathan Cameron wrote:  =
 =20
> > > > > On Mon, 25 Mar 2024 22:32:41 +0200 Laurent Pinchart wrote:
> > > > >      =20
> > > > > > The DAC081C081 is a TI DAC whose software interface is compatib=
le with
> > > > > > the DAC5571. It is the 8-bit version of the DAC121C081, already
> > > > > > supported by the DAC5571 bindings. Extends the bindings to supp=
ort this
> > > > > > chip.
> > > > > >=20
> > > > > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.=
com>     =20
> > > > >=20
> > > > > Hi Laurent,
> > > > >=20
> > > > > Given it's a part number where no one is going to guess it is com=
patible
> > > > > with the DAC5571 and that we don't have a history of fallback com=
patibles
> > > > > I'm fine with this change, but just wanted to ask is a fallback c=
ompatible
> > > > > useful to you to run with older kernels?
> > > > >=20
> > > > > I should have noticed when Peter added the dac121c081. If we add =
a fallback
> > > > > should do that one as well.     =20
> > > >=20
> > > > I've indeed noticed that there should have been a fallback for
> > > > dac121c081, but didn't stop to ponder why that wasn't the case, and=
 just
> > > > went along with the flow :-) I agree a fallback could be useful, wh=
ich
> > > > would then allow dropping patch 2/5 from this series (*). I can do =
so if
> > > > you prefer.
> > > >=20
> > > > * This is not entirely true. While the DAC1081C081 is largely compa=
tible
> > > > with the DAC5573, they have different values for one of the power-d=
own
> > > > resistors (2.5k=CE=A9 instead of 1k=CE=A9 if I recall correctly). T=
o be completely
> > > > accurate, the driver should report that. We could still use the fal=
lback
> > > > compatible, reporting the wrong power-down resistor value.   =20
> > >=20
> > > Hmm - Would anyone really care about that value being wrong?   =20
> >=20
> > I don't have enough expertise with IIO to be sure, but my guess is that
> > nobody would.
> >  =20
> > > I think perhaps that's just about significant enough that maybe a fal=
lback
> > > compatible doesn't make sense here.   =20
> >=20
> > Then let's keep it simple and just merge this patch as-is ? :-) =20
> Makes sense. I'm on wrong computer at the moment but will pick it up at
> weekend if not before.
Sooner it is.  Applied 1 and 2 to the togreg branch of iio.git and pushed
out as testing on the extremely unlikely chance that 0-day finds a build
issue...

I grabbed them today because I have a memory like a gold fish and the thread
is deep enough that I might skip over later on basis 'it must have outstand=
ing
questions' :)

Jonathan

>=20
> Jonathan
>=20
>=20
> >  =20
> > > > > > ---
> > > > > >  Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > >=20
> > > > > > diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac55=
71.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
> > > > > > index 79da0323c327..e59db861e2eb 100644
> > > > > > --- a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
> > > > > > @@ -21,6 +21,7 @@ properties:
> > > > > >        - ti,dac5573
> > > > > >        - ti,dac6573
> > > > > >        - ti,dac7573
> > > > > > +      - ti,dac081c081
> > > > > >        - ti,dac121c081
> > > > > > =20
> > > > > >    reg:     =20
> >  =20
>=20


