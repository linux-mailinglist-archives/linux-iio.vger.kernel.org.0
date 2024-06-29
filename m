Return-Path: <linux-iio+bounces-7043-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C5891CE29
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 18:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A08282D73
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 16:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B18E12DD8A;
	Sat, 29 Jun 2024 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnpAbJvz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FB28288C;
	Sat, 29 Jun 2024 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719679213; cv=none; b=Tu2Qm2HrEYvaSbutC56MAeNd4EFFDgjTPxBdEbiG1TPMqKDPVHUaci6lQLx0/hyz27izB0OCXFsHjsewGvr1RSyPnqy8OvluLPDyt4nG+cljGejvOP3417KFNTFW60mQEpq6Qdmjdy2K/+/1LioxVUulCQ7+mWPnMZW/Cw113Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719679213; c=relaxed/simple;
	bh=5ixL2BQMrSl+lggmiUBQPpOCHdB3l4fgW6wZQ0wpGNg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cI4gi3bGFZdzvIKG39VHhR+zJCHectxhuYM7zmBKOYM9sR7lnF9EJGmsgbBFCOuHmW9nOxF0H3OjX+7EJAa9xAXY90xZSu4lS55z7O51H8BppBHGTJuyNr8E/oi3lAnwHH8jWjkui4aaYxh3FU47j8a9awonIHiGZN/nYyBLkMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnpAbJvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69782C2BBFC;
	Sat, 29 Jun 2024 16:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719679212;
	bh=5ixL2BQMrSl+lggmiUBQPpOCHdB3l4fgW6wZQ0wpGNg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UnpAbJvzArwlVfMPuJomPhlng8t78kpT7nrWjBHEibOTD2qsY2TqYLbhVma+8YVzx
	 5Q8zgV2U143Rjrtmibhdnwf5Z8pedlvLhfDdGyJX/nfqq1Y4mGgURvlOI4DAkQfyz1
	 tgbHMRruaXyg1D1d6RjmEJ3Gfm4jNL4oTrDshxDt1X/Hidu5dbCn2EazxpmfgNT717
	 lcLLyNBmv8LjDEv1hy//wB+GRdHdbiQWKIhwtzTf2NwCsZfS9e/O3cxOUecr5m91q0
	 IYQVz57L7h038iQ9oBgv36zv5Txoc0N6rjw2sKQ+EslkF3L63zQxbzfmkEApp6ziWK
	 o0Re31q/yeg0A==
Date: Sat, 29 Jun 2024 17:40:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Esteban Blanc <eblanc@baylibre.com>, baylibre-upstreaming@groups.io,
 Lars-Peter Clausen  <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski  <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno
 Sa  <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>
Subject: Re: [PATCH RFC 2/5] iio: adc: ad4030: add driver for ad4030-24
Message-ID: <20240629174003.60738d4b@jic23-huawei>
In-Reply-To: <0036d44542f8cf45c91c867f0ddd7b45d1904d6b.camel@gmail.com>
References: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
	<20240627-eblanc-ad4630_v1-v1-2-fdc0610c23b0@baylibre.com>
	<0036d44542f8cf45c91c867f0ddd7b45d1904d6b.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> > +#define AD4030_CHAN_CMO(_idx)=C2=A0 {					\
> > +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),			\
> > +	.type =3D IIO_VOLTAGE,						\
> > +	.indexed =3D 1,							\
> > +	.channel =3D _idx,						\
> > +	.scan_index =3D _idx,						\
> > +	.scan_type =3D {							\
> > +		.sign =3D 'u',						\
> > +		.storagebits =3D 8,					\
> > +		.realbits =3D 8,						\
> > +		.endianness =3D IIO_BE,					\
> > +	},								\
> > +}
> > + =20
>=20
> So, from the datasheet, figure 39 we have something like a multiplexer wh=
ere we
> can have:
>=20
> - averaged data;
> - normal differential;
> - test pattern (btw, useful to have it in debugfs - but can come later);

Can consider doing test pattern as simply a different channel, data is afte=
rall
coming from a very different place.


> - 8 common mode bits;
>=20
> While the average, normal and test pattern are really mutual exclusive, t=
he
> common mode voltage is different in the way that it's appended to differe=
ntial
> sample. Making it kind of an aggregated thingy. Thus I guess it can make =
sense
> for us to see them as different channels from a SW perspective (even more=
 since
> gain and offset only apply to the differential data). But there are a cou=
ple of
> things I don't like (have concerns):
>=20
> * You're pushing the CM channels into the end. So when we a 2 channel dev=
ice
> we'll have:
>=20
>  in_voltage0 - diff
>  in_voltage1 - diff
>  in_voltage2 - CM associated with chan0
>  in_voltage0 - CM associated with chan1
>=20
> I think we could make it so the CM channel comes right after the channel =
where
> it's data belongs too. So for example, odd channels would be CM channels =
(and
> labels could also make sense).
>=20
> Other thing that came to mind is if we could somehow use differential =3D=
 true
> here. Having something like:
>=20
> in_voltage1_in_voltage0_raw - diff data
in_voltage1-voltage0_raw  so normal differential channel.

> ...
> And the only thing for CM would be:
>=20
> in_voltage1_raw
> in_voltage1_scale

you can do that with normal channels.

>=20
> (not sure if the above is doable with ext_info - maybe only with device_a=
ttrs)
We 'could' do the somewhat nasty

in_voltage1-voltage0_raw - so normal differential channel.

in_voltage1+voltage0_raw via a custom attribute.  Don't try to hammer that =
in
as channel related though.


>=20
> The downside of the above is that we don't have a way to separate the scan
> elements. Meaning that we don't have a way to specify the scan_type for b=
oth the
> common mode and differential voltage. That said, I wonder if it is that u=
seful
> to buffer the common mode stuff? Alternatively, we could just have the sc=
an_type
> for the diff data and apps really wanting the CM voltage could still acce=
ss the
> raw data. Not pretty, I know...

Hmm. That is indeed a nasty corner if we don't use a real channel.
This may be a case for just using labels for the relationship.

>=20
> However, even if we go with the two separate channels there's one thing t=
hat
> concerns me. Right now we have diff data with 32 for storage bits and CM =
data
> with 8 storage bits which means the sample will be 40 bits and in reality=
 we
> just have 32. Sure, now we have SW buffering so we can make it work but t=
he
> ultimate goal is to support HW buffering where we won't be able to touch =
the
> sample and thus we can't lie about the sample size. Could you run any tes=
t with
> this approach on a HW buffer setup?=20
>=20
> I did not gave too much thought on it but I'm not sure there's a sane way=
 to
> have multiple scan_types associated with the same channel.=20

Not at the same time.

Jonathan

