Return-Path: <linux-iio+bounces-24491-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1435EBA60EC
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 17:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2EB4C13B1
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 15:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633DE20101D;
	Sat, 27 Sep 2025 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QK5q8k+k"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA8C1E835D;
	Sat, 27 Sep 2025 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758986743; cv=none; b=lqqRd5Tgi116j9BEhDZ/1Pjw3uLVGy87rwzgR5p3+Qkxmu/fJLrOfGlVLYagnV+sKYkQuqyn8ORRv6sfODnihKy9Ts/8pzTganwpPQX81xUobYogsoPQtd2Ru4hfagv27ME2fnY2XTod8/1Ewp5gDUtA860f/PjPXwdpl2jIWlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758986743; c=relaxed/simple;
	bh=YgITrmNg/NjGeSSEMK4ZzE7tujHAoNfv0EzP1qrhx2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dxpjtowYhlGo9GFK9xHC+jaNPVIqyKF7N6uhPvhqGtXtfpWvtcpu7tKCKqSI9MKBZ/M6lKB9aR3ki+Hughf7wuPB39cM2ehaGpjBBaHFkHnoNY5nMAfdUdatVXaODwqNNmFdNNiFR5plUdyFirK9GSjtqxTQm7eDPjfAVWKGS9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QK5q8k+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B0CC4CEE7;
	Sat, 27 Sep 2025 15:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758986742;
	bh=YgITrmNg/NjGeSSEMK4ZzE7tujHAoNfv0EzP1qrhx2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QK5q8k+k9LF1yBMTr6RX0dMw6bSZW9FYsqKqk3ScSYAHhygUwfXdZtfrQPVvsuRMU
	 PAgSrZWkoSPk1ZGJSi7DRJR3ylSbXlDsvtlChASu8OatxZ1k9uKjw3vVyclcv+p40+
	 y7fCxdjY6BlcFwZ6cOahgGexhaq+bmAo3tIY7ARRZJPZFCNfVL/Oaq2Pin2grwlZeq
	 nj8DPJ5nE4yN5YroeTar+eYDQrI8c3hfU+gjriL3+h7AsJWcutNW2y5BWbbnrDRNlo
	 ig4Q+zbk7SsHYc5Mvspm8avAYjRARRztbqPRsUPw4Ka9fwxk8X6DTR/rhfp0aOr4Dz
	 RixF6WTz38ftw==
Date: Sat, 27 Sep 2025 16:25:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <Victor.Duicu@microchip.com>
Cc: <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <robh@kernel.org>, <linux-kernel@vger.kernel.org>, <andy@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <Marius.Cristea@microchip.com>
Subject: Re: [PATCH v5 2/2] iio: temperature: add support for MCP998X
Message-ID: <20250927162533.14f3c475@jic23-huawei>
In-Reply-To: <42a376a9451ed340e0aa7f1c01a16554298c0693.camel@microchip.com>
References: <20250918111937.5150-1-victor.duicu@microchip.com>
	<20250918111937.5150-3-victor.duicu@microchip.com>
	<20250920115554.36dc4de1@jic23-huawei>
	<42a376a9451ed340e0aa7f1c01a16554298c0693.camel@microchip.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Sep 2025 12:47:31 +0000
<Victor.Duicu@microchip.com> wrote:

> On Sat, 2025-09-20 at 11:55 +0100, Jonathan Cameron wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> >  =20
>=20
> Hi Jonathan,
>=20
> > On Thu, 18 Sep 2025 14:19:37 +0300
> > <victor.duicu@microchip.com> wrote:
> >  =20
> > > From: Victor Duicu <victor.duicu@microchip.com>
> > >=20
> > > This is the driver for Microchip MCP998X/33 and MCP998XD/33D
> > > Multichannel
> > > Automotive Temperature Monitor Family.
> > >=20
> > > Signed-off-by: Victor Duicu <victor.duicu@microchip.com> =20
> > Hi Victor,
> >=20
> > Various minor comments inline.
> > Given the build warnings I didn't elect to just tidy these up whilst
> > applying.
> > Seemed like there was slightly too high a risk of me messing it up!
> > Also we have lots of time as IIO is closed for this cycle now.
> >=20
> > Jonathan
> >  =20
> ...
>=20
> >=20
> >  =20
> > > +/**
> > > + * Bit flags and their meaning =20
> >=20
> > As below. I don't think it is worth encoding these in a bitmap. Just
> > use
> > 5 bools to represent the state.
> >  =20
> > > + * @RECD34_ENABLE:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 state of Resistance Error
> > > Correction(REC) on channels 3 and 4
> > > + * @RECD12_ENABLE:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 state of Resistance Error
> > > Correction(REC) on channels 1 and 2
> > > + * @APDD_ENABLE:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 state of anti-parallel diode mode
> > > + * @RUN_STATE:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 chip is in run state,
> > > otherwise is in standby state
> > > + * @WAIT_BEFORE_READ:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 whether we need to wait a
> > > delay before reading a new value
> > > + */
> > > +#define RECD34_ENABLE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
> > > +#define RECD12_ENABLE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1
> > > +#define APDD_ENABLE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
> > > +#define RUN_STATE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3
> > > +#define WAIT_BEFORE_READ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 4
> > > +#define USE_PREVIOUS_FREQ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5
> > > + =20
>=20
> Considering that I am planning to add new features to this driver,
> I think that it would be useful to keep the flags.

Unless there are many of these I think the loss of readability vs
the likely limited extra space used by bools still makes flags a
less than ideal approach.  For reasons of DMA safe buffer allocations
on many architectures there is a lot of padding in the iio_dev / iio_priv
allocation, so you can always check if it makes any difference at all
on the allocated data

>=20
> > > +#define MCP9982_CHAN(index, si, __address)
> > > (=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
> > Why the outer set of ()? =20
>=20
> Without the outer () compiler returns error "Macros with complex values
> should be enclosed in parentheses."

Hmm. I'd ignore that as an unhelpful warning in this case.

>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 (struct iio_chan_spec)
> > > {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .type =3D
> > > IIO_TEMP,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .info_mask_separate =3D
> > > BIT(IIO_CHAN_INFO_RAW),=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .info_mask_shared_by_all_available =3D
> > > BIT(IIO_CHAN_INFO_SAMP_FREQ) |=C2=A0=C2=A0=C2=A0=C2=A0 \
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0
> > > BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =20
>=20
> Kind Regards,
> Victor


