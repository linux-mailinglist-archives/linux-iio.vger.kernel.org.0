Return-Path: <linux-iio+bounces-24948-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF9CBD0306
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 16:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B58D3B0B18
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 14:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13842276056;
	Sun, 12 Oct 2025 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGRXpAUc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B0F188580;
	Sun, 12 Oct 2025 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760277784; cv=none; b=nRnseZRe0BEn6xFXWoRtY0SHYRro/oxUPOI3h2fXPXTQMVl5CyKAI4lG0DRpaBkUUT+gf4aPzsroDl2emcHAjg88x9dOVm+RNNyLFa+N7I1mRqxXOzC+CLQOOGjLQE5UpSwKErhiV4XRItQ7PXIAv2Zqfsvj8PhPeX05ssziSVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760277784; c=relaxed/simple;
	bh=EAspJa6t6E3V4OV6p3CSIjt1r0aWviz5Hwp7mlffVhI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Og5Tf5Z1Yt7cYGYQWroKdATAvc1CmCIFVO5eyb+4B1jy06BTC27+L0+iSsJ7q3KAUPjpktHZ9sLmvPjwwpKgDUo/3JseAr6e0+L89g4WJD8ww/9OkPj9BprFRnWxo/2tWtUcsURr2C5Bjd8DNriI5Hy87ZhM3TWwsP/gQObyv0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGRXpAUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D925C4CEE7;
	Sun, 12 Oct 2025 14:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760277784;
	bh=EAspJa6t6E3V4OV6p3CSIjt1r0aWviz5Hwp7mlffVhI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IGRXpAUcPSIOeXz+2mseEEd1RYDfim+pECs7Rl/UOWXKwk8xsOdr8nFIMqBPdXuaF
	 7lEGJ+kRa3j/ExMcE5f0rCm4TV7iYEKsCNR5/tZzkz5tOC/3YPj8NB/Aemzs3i3m2U
	 8f188HX86REZys7OcMJHeoZ6UPRb/o/JCPwvuAI2dfDkEofQVHJAQvZbMo10epG0Kb
	 g1YuD1fQ46/PTncLHS8EVbKJdkYv65jfNl8igdUiAekRBRJQj3hOrLwPt7/n3eB2Zj
	 5L5LxxFY2uD3hpYYxIe0RSFCuntSHkhxH50EcXw9zuYs2piTayBdNJ0Llt73qtHQ+3
	 jQexwNRWBAOwQ==
Date: Sun, 12 Oct 2025 15:02:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: dan@dlrobertson.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] iio: accel: bma400: Reorganize and rename
 register and field macros
Message-ID: <20251012150257.46ebc15a@jic23-huawei>
In-Reply-To: <CAE3SzaST=w7f0yM1C2iGfD9fw7smzMDven5kOoSQ0jMMZHMkWw@mail.gmail.com>
References: <20251002184120.495193-1-akshayaj.lkd@gmail.com>
	<20251002184120.495193-2-akshayaj.lkd@gmail.com>
	<20251004135312.41858380@jic23-huawei>
	<CAE3SzaST=w7f0yM1C2iGfD9fw7smzMDven5kOoSQ0jMMZHMkWw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Oct 2025 12:09:43 +0530
Akshay Jindal <akshayaj.lkd@gmail.com> wrote:

> On Sat, Oct 4, 2025 at 6:23=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >This is much easier to review. Thanks for breaking it all up. =20
>=20
> Hi Jonathan,
> Thank you for the review.
> Keeping v3 feedback in mind, I have floated a v4 patch series.
> Have some follow-ups in some comments. Please read below
> for those.
>=20
> Thanks,
> Akshay.
>=20
> > >  #define BMA400_INT_STAT0_REG        0x0e
> > >  #define BMA400_INT_STAT1_REG        0x0f
> > >  #define BMA400_INT_STAT2_REG        0x10
> > > -#define BMA400_INT12_MAP_REG        0x23
> > > -#define BMA400_INT_ENG_OVRUN_MSK    BIT(4)
> > > +#define BMA400_ENG_OVRUN_INT_STAT_MASK               BIT(4) =20
> >
> > This is an odd field as it applies to all the INT_STATX registers
> > However  I would still try to make that connection with a name
> > such as BMA500_INT_STAT_OVRUN_MASK =20
> The connection is still there Jonathan.
> The name in the spec is Interrupt Engine Overrun.
> BMA400_ENG_OVRUN_INT_STAT_MASK can be read as
> Engine Overrun Interrupt Status Mask.
> Here for Interrupt Status fields, I have intentionally taken a little
> deviation from the naming convention established.
> Original convention:BMA400_<reg_name>_<field_name>_<suffix>
> Convention here: BMA400_<INT NAME>_<INT_STAT>_<suffix>
> so that it can be read as <INT_NAME> Interrupt Status mask.
>=20
> I would understand, if you want to adhere to original convention.
> Will make the change in next version

Yes, I definitely wnt the register name association in there (or a wild
card type thing if it turns up in multiple similar registers.

>=20
> > =20
> > > +#define BMA400_STEP_INT_STAT_MASK            GENMASK(9, 8) =20
> >
> > This bit is a little odd.  We are treating INT_STAT0 and INT_STAT1
> > (but not 2) as a single 16 bit register. That makes it hard to
> > associate the field with the register name. I wonder if we shouldn't
> > break that and just handle it as a pair of u8 instead. =20
> The spec talks about doing a burst read for such multipart registers
> to avoid reading one, while the other one is being updated.
> Hence did not touch it.
ok. But then why not INT_STAT2?  Could also do a burst read but still
treat them as separate registers. Bulk read into a u8[2];
 =20
Cropping out the stuff that needs no more discussion (you could have cropped
the bits you agree with btw!)  Removing them is an implicit 'agreed'

>=20
> > >       ret =3D regmap_update_bits(data->regmap, BMA400_INT_CONFIG1_REG,
> > > -                              BMA400_STEP_INT_MSK,
> > > -                              FIELD_PREP(BMA400_STEP_INT_MSK, val ? =
1 : 0));
> > > +                              BMA400_INT_CONFIG1_STEP_INT_MASK,
> > > +                              FIELD_PREP(BMA400_INT_CONFIG1_STEP_INT=
_MASK, val ? 1 : 0)); =20
> >
> > Could use regmap_assign_bits() to simplify this a bit - but separate ch=
ange
> > so different patch. =20
> regmap_assign_bits calls regmap_set_bits which itself uses
> regmap_update_bits_base similar to regmap_update_bits.
> Moreover adoption of regmap_assign_bits is not much in drivers.
> Hence would request to keep it as it is.

I think it is fairly new and the gain here is minor (plus it would be an ad=
ditional
change anyway) so fine to leave it as it stands.

Thanks,

Jonathan


>=20
> Thanks,
> Akshay
>=20


