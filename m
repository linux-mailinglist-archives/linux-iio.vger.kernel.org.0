Return-Path: <linux-iio+bounces-18955-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106D1AA6A36
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 07:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5832846591A
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 05:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682561B0416;
	Fri,  2 May 2025 05:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="qDrtAhNs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E4D17B505;
	Fri,  2 May 2025 05:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746164079; cv=none; b=q0fsuKy5B9HB26pRuzAvit6rAqiVBXE8RSQ6mnWRjMPv7bWfFLtsDtHZFH+tg4R9b3uYpZWndt99c5nS110sO8mQrryqhwVMpCQGdQw+rGWp06SQdnwGzzCXEV3v/kupQMAvodw3/XldUgpYalj03GbrhMw5M9vdoNTgFZ1n5nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746164079; c=relaxed/simple;
	bh=QsTRzg9J/cNlzWCksgM2zZySuLFsON2cAv39/UOg6Wg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nS/GJ5mxpejOgc98AuTx2f/85dK46K5nFIg94EPJ1xAOCTU+Dr5CbbI4qYIN0fMK3aOYoyctUIh2C75Io/CBdWclE0dDo3DjBpdmkkhVoNmK+X8962cVPepb5DHEIxUNOkCvCFwUEcymUHkfDjJkXpuTxKydmWsPlccCBbwx+Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=qDrtAhNs; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1746164066; x=1746423266;
	bh=F2EV4NpgMO3XEIjtI6UIlbXoZzYff7V8oDByN+S8dsM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=qDrtAhNskV6vKhFAwyz/ka7zra7vrr+HwN7+y9imUl0XJmliQfdgl4t0QtoM/WL9E
	 giGeXkM7PolJUGu1aMqfj7/f+fjWY+giHSgsEjI/APcLha7KEhzhGGSQmQ9mvyGP5w
	 j+q4vn0GlnkQIqXHptB3OMiGtxOhEKNtKawS4UQ1paETj9k2CLHyIv5bJHrJ7XSG9b
	 E/inc0OKBaHuRiwjIKJNv2CWyuOGYEK8V84E8xEgabVBkEaODPFh3cu3ay3/GTeTl/
	 GB9Tp/CqJGU94K4jG5G+o+uXBzHITE+XZIBvqrvvaydggwS8yhSOS6P0bHdi9hOjjA
	 YqL248HysLHqg==
Date: Fri, 02 May 2025 05:34:23 +0000
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: fxls8962af: Fix temperature calculation
Message-ID: <4i3cracjtbjc5qjfa27d6mytoy27hiaduaftwmpr3zuyipc6jq@mwou3lp6pmue>
In-Reply-To: <aBPH2dHgwI_4lHvj@debian-BULLSEYE-live-builder-AMD64>
References: <20250501-fxls-v1-1-f54061a07099@geanix.com> <aBPH2dHgwI_4lHvj@debian-BULLSEYE-live-builder-AMD64>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: b5e8b5afb38de9c9db92554951abebc548b63add
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Marcelo,

On Thu, May 01, 2025 at 04:13:29PM +0100, Marcelo Schmitt wrote:
> Hello Sean,
>=20
> Overall, this looks good to me.
> Only thing I think need to (not) change is the offset (see comment below)=
.
>=20
> Regards,
> Marcelo
>=20
> On 05/01, Sean Nyekjaer wrote:
> > According to spec temperature should be returned in milli degrees Celsi=
us.
> > Add in_temp_scale to calculate from Celsius to milli Celsius.
> >
> > Fixes: a3e0b51884ee ("iio: accel: add support for FXLS8962AF/FXLS8964AF=
 accelerometers")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > ---
> >  drivers/iio/accel/fxls8962af-core.c | 17 ++++++++++++++---
> ...
> >
> >  /* Raw temp channel offset */
> > -#define FXLS8962AF_TEMP_CENTER_VAL=09=0925
> > +#define FXLS8962AF_TEMP_CENTER_VAL=09=0925000
> I think the offset was correct the way it was before.
> For example, if the sensor at 37=C2=B0C, the output code will be 0b000011=
00, 12 (decimal).
> Then (_raw + _offset) * _scale =3D (12 + 25) * 1000 =3D 37000 milli =
=C2=B0C

Yes you are right. Just checked the documentation.
"If known for a device, offset to be added to <type>[Y]_raw prior to
scaling by <type>[Y]_scale"

>=20
> > +/* Raw temp channel scale */
> > +#define FXLS8962AF_TEMP_SCALE=09=09=091000
> >
> ...
> > @@ -736,6 +746,7 @@ static const struct iio_event_spec fxls8962af_event=
[] =3D {
> >  =09.type =3D IIO_TEMP, \
> >  =09.address =3D FXLS8962AF_TEMP_OUT, \
> >  =09.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | \
> > +=09=09=09      BIT(IIO_CHAN_INFO_SCALE) | \
> >  =09=09=09      BIT(IIO_CHAN_INFO_OFFSET),\
> >  =09.scan_index =3D -1, \
> >  =09.scan_type =3D { \
> Datasheet page 39 says 'the TEMP_OUT register contains the 8-bit, 2's com=
plement
> temperature value.'
> So I think we can make the temperature scan element signed.
> =09=09.sign =3D 's',=09\
>=20
> Though, I guess that would be a thing for a separate patch.

Good catch will do some testing :)

Thanks
/Sean


