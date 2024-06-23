Return-Path: <linux-iio+bounces-6763-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D449F913C6A
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 17:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034391C20CEF
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 15:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6951822C8;
	Sun, 23 Jun 2024 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoK5qQBq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E82D383A2;
	Sun, 23 Jun 2024 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719156702; cv=none; b=gDt1hZIJcl6dOZT1Rw6dQH9dDE31oZa4vhaVd9r5qI6gSJj96GMkpgMQ5fnwCm579WPLYfMyCal98ztpjBpvnIqrlGwWcbeuVmfhmrsfoODHxb4e/Sx+GHgEuDnvXrfPQOr14wEY0MQyN2GCpo4qTBHlvSybeCQFPO2osYLrCME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719156702; c=relaxed/simple;
	bh=8XdoNgWYoI5e8gBbGLxgz0jAyLcowmSamJHZsUEjQ70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCqJetEe0Lp4l3kDNspHAkWx5QMVgwfcVTq1pdRgEfCONvNdtQMANLqut6+DRczN/7hlzCFUiRR4GCQYsAtNm7r2gtbk2qoquGeg4e3LXGSCIsU+uMA2jh3tiU+16N703o+rf/8fgLQwhSWkpmGGUUHfjM0YiYHS6eBrj7mjyDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoK5qQBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F1EC2BD10;
	Sun, 23 Jun 2024 15:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719156701;
	bh=8XdoNgWYoI5e8gBbGLxgz0jAyLcowmSamJHZsUEjQ70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XoK5qQBqXHUim0EAEUMCJKBdjW8MHVvnTS7Cb2+G5rfZZOapP8vNXhKsMsnEyTudd
	 bHCNQ1JsZi3b/I4QUEl9OyQmHZl+d7LQ0tONivpNtjirCwrudNA63zRZIMjHjVPO7i
	 eUd0phg2q+1usR4czExaICCmdW3EBhpW+UAxT2eWMfTJFwKO/eF8m5l6eJ1Jgigp7J
	 mlFOZn90egIK4j+wtswRMUIq1Q9IXdFvMKaooyAgVtx9UKNWpx1MMeymukmGwtWPXg
	 EJZyt2juJCy6MZ3lzcai0+s+dns0dB+jEl18jJrJs+99It1eqUFcgOEgXWA4ziLmNW
	 +DQ8ZrAx9BJzw==
Date: Sun, 23 Jun 2024 16:31:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Guillaume Stols <gstols@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Beniamin Bia <beniamin.bia@analog.com>,
 Stefan Popa <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 devicetree@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 jstephan@baylibre.com, dlechner@baylibre.com
Subject: Re: [PATCH 4/9] dt-bindings: iio: adc: adi,ad7606: add supply
 properties
Message-ID: <20240623163130.4a72707b@jic23-huawei>
In-Reply-To: <20240618-spearfish-swear-213166c7224f@spud>
References: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
	<20240618-cleanup-ad7606-v1-4-f1854d5c779d@baylibre.com>
	<20240618-eggnog-cusp-8b5a17313367@spud>
	<12e5c4b4-e51d-4e69-8c63-3f6aefb574d9@baylibre.com>
	<20240618-spearfish-swear-213166c7224f@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Jun 2024 18:32:20 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Tue, Jun 18, 2024 at 05:33:16PM +0200, Guillaume Stols wrote:
> >=20
> > On 6/18/24 17:12, Conor Dooley wrote: =20
> > > On Tue, Jun 18, 2024 at 02:02:36PM +0000, Guillaume Stols wrote: =20
> > > > Add voltage supplies =20
> > > Are these available on all devices? =20
> >=20
> > Yes all chips from=C2=A0 AD7606 series (including AD7606B, AD7606C(-16,=
-18),
> > AD7605-4, AD7606 (-4,-8,-6), AD7607, AD7608, AD7609), as well as AD7616
> > have a VDrive pin, as well as a RefSelect + RefIn/RefOut pin that takes
> > an input voltage in case RefSelect is high, or outputs the internal
> > reference voltage if RefSelect is low. =20
>=20
> Okay,
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> provided that...

Sounds like vdrive-supply is a requirement for the device to function but
refin may be optional.

So add vdrive-supply to the required property list.

Note the binding for supplies reflects what must be wired and ignores
the ability of the linux regulator framework to get fake supplies when
they are not provided in DT.

>=20
> >  =20
> > >  =20
> > > > Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> > > > ---
> > > >   Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 9 +++=
++++++
> > > >   1 file changed, 9 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.y=
aml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> > > > index 80866940123c..e480c9a7c7ca 100644
> > > > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> > > > @@ -35,6 +35,15 @@ properties:
> > > >     avcc-supply: true
> > > > +  vdrive-supply: =20
>=20
> The lack of a blank line here is an artifact of the reply
>=20
> > > > +    description:
> > > > +      Determines the voltage level at which the interface logic pi=
ns will
> > > > +      operate.
> > > > +
> > > > +  refin-supply:
> > > > +    description:
> > > > +      The voltage supply for optional external reference voltage.
> > > > +
> > > >     interrupts:
> > > >       description:
> > > >         The BUSY pin falling edge indicates that the conversion is =
over, and thus
> > > >=20
> > > > --=20
> > > > 2.34.1
> > > >  =20


