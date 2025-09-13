Return-Path: <linux-iio+bounces-24052-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2F4B56130
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85A9D7B56FF
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 13:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501B72EE5FE;
	Sat, 13 Sep 2025 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0KAUyAe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FF52E7BA2;
	Sat, 13 Sep 2025 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757770929; cv=none; b=uN8kDwsF1oc24Tw8bZZk+l/IC5O8eoBvdY+3TI2J/LXZgLNG3Dd5qbAlqA0aNCj1PI3y4eH1wcr0D3c8zVAnfWoaSK+1df+ZsBvhIYsAKJBPFVDt21Psu6yze9Skq+M6Y9pG4WZHYiZl8QzQsCQ0OzuFspkj/dJSiYEh21hbLf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757770929; c=relaxed/simple;
	bh=Rim3KkEyi7viemKrPUHNd1Ff0UKCC6EKGZx1aIDg/t8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pA0vyXJnAfKrA8LVzaYk6ZDpfpsAfgTDGhojwxkbc/dGi0y0blQj6yDyunUBgiN1vMz6D+UWHXOqMxFhSAJVxTGLL3X2xdQS563s8ITG8DnnRRUtqr4ZzvRuDAbJQ61T1clu/XcKgnO5/Erdeqzvj9DG4YuolbP8iwPuhHZuM9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0KAUyAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D696CC4CEEB;
	Sat, 13 Sep 2025 13:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757770928;
	bh=Rim3KkEyi7viemKrPUHNd1Ff0UKCC6EKGZx1aIDg/t8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y0KAUyAej47GlDXw0OvlDkIpdjfrhVCvfF+cpflo/3cvJdbeLQfDnCzcRopuWQCHM
	 iSviL254i8GEwuAAOtLxxC+bIJFGfLS2HaIRs18iEUUBP1CHRQUpYv9UUrqrQxO/FY
	 o1zdgGR0bNFlrHl1jp+jc50KfnjwKhwscmKvUEfYlfQvdGeKya0OvF7TBrn41LqcpS
	 Ft/KnIjwJty5T287PBqJVsNfxupNVHuuoQ3WoHtmQj6Z6p60L1TtSReiiHloZvRshN
	 YorN6P8hIXWKGLJ70hrmtZ88xQT2NfGCKsKPKiNGbEHKvx84pzow9Rnx6qxrabEGk1
	 UDVsT+2foTmuw==
Date: Sat, 13 Sep 2025 14:42:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] iio: adc: ad7124: add filter support
Message-ID: <20250913144200.17337dd8@jic23-huawei>
In-Reply-To: <87245221-c3d0-4026-980d-36562f0b4669@baylibre.com>
References: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
	<20250911-iio-adc-ad7124-add-filter-support-v2-5-b09f492416c7@baylibre.com>
	<CAHp75Vf69X4PmGx2c_9KvQwu1opLDyfL0+TyjwX2wTG9bgtMZw@mail.gmail.com>
	<87245221-c3d0-4026-980d-36562f0b4669@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Sep 2025 09:27:47 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 9/11/25 11:49 PM, Andy Shevchenko wrote:
> > On Fri, Sep 12, 2025 at 12:43=E2=80=AFAM David Lechner <dlechner@baylib=
re.com> wrote: =20
> >>
> >> Add support to the ad7124 driver for selecting the filter type.
> >>
> >> The filter type has an influence on the effective sampling frequency of
> >> each channel. For sinc3+pf{1,2,3,4}, the sampling frequency is fixed.
> >> For sinc{3,4} (without post filter), there is a factor of 3 or 4
> >> depending on the filter type. For the extra +sinc1, there is an extra
> >> averaging factor that depends on the power mode.
> >>
> >> In order to select the closest sampling frequency for each filter type,
> >> we keep a copy of the requested sampling frequency. This way, if the
> >> user sets the sampling frequency first and then selects the filter typ=
e,
> >> the sampling frequency will still be as close as possible to the
> >> requested value.
> >>
> >> Since we always either have the SINGLE_CYCLE bit set or have more than
> >> one channel enabled, the sampling frequency is always using the
> >> "zero-latency" calculation from the data sheet. This is only documented
> >> for the basic sinc{3,4} filters, so the other filter types had to be
> >> inferred and confirmed through testing.
> >>
> >> Since the flat filter type list consists of multiple register fields,
> >> the struct ad7124_channel_config::filter_type field is changed to the
> >> enum ad7124_filter_type type to avoid nested switch statements in a
> >> lot of places. =20
> >=20
> > ...
> >  =20
> >> -       factor =3D 32 * 4; /* N =3D 4 for default sinc4 filter. */
> >> -       odr_sel_bits =3D DIV_ROUND_CLOSEST(fclk, odr * factor +
> >> -                                              odr_micro * factor / MI=
CRO);
> >> -       odr_sel_bits =3D clamp(odr_sel_bits, 1, 2047);
> >> +       divisor =3D cfg->requested_odr * factor +
> >> +                 cfg->requested_odr_micro * factor / MICRO;
> >> +       odr_sel_bits =3D clamp(DIV_ROUND_CLOSEST(fclk, divisor), 1, 20=
47); =20
> >=20
> > I have a d=C3=A9j=C3=A0 vu feeling here. Is this similar code to elsewh=
ere?  Can
> > it be factored out to a helper?
> >=20
> >  =20
>=20
> It is changing the same code from a previous commit, not duplicating
> it. I guess I could have introduced the divisor variable in the
> earlier commit and saved some churn.
For this and the previous patch, to me it feels like we are letting
aiming for perfect patch break up be the enemy of a good result.
So I've applied them both but as I don't know if Andy will agree
not his RB.

Jonathan


