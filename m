Return-Path: <linux-iio+bounces-13344-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95DB9ED66C
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 20:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF5C281749
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 19:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE05F2594AC;
	Wed, 11 Dec 2024 19:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvZ+M8FF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAB825948D;
	Wed, 11 Dec 2024 19:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944991; cv=none; b=mpCsdNYC6cF6LKvLVCoEtmGNeEoixS4ZeH+ORP95VB8KnRUqhG7ZKiVVVIbGjyOWRIZ21Snb1y+Dme1MRZ75RKBfoKZrQ+/hrV0Yfu9hLtHeokcecOdXq3Ak4vprK0o1YiEIDRaw7X5AtKyurMMbTW1icezr4JW82OUfP1VOoto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944991; c=relaxed/simple;
	bh=zuB3sRSO/sRFvgXYvGAoUrkuagLiyC3cCBGNZtAFLjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IwLpDPeJYjJ35/9rf2rvvtfITHhF0V8YMwGNTAJq5bHC0nddHqI+XusfuDm5P5/WCZs6ImXdNOUPM7ZC9Y2InSZMiRpmR6mwMpGyUpQkQW8I/W4SV4WOgVuIVg3wjnmqK3bqzZkFqIleS188jYxcAUn81wxeQVyPidP4cTP9Sso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvZ+M8FF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3084BC4CED2;
	Wed, 11 Dec 2024 19:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733944991;
	bh=zuB3sRSO/sRFvgXYvGAoUrkuagLiyC3cCBGNZtAFLjQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gvZ+M8FFsfExF5oj5tyRgvcFbCHr7+MeWHxpR+/kRINWRsHs8Al05bNdyG9uJHVSC
	 E4190/gq/uHso7eyM7dGzTW+0at9hbinBfPk+jTFQQop4T9ZAhidxyIvDl3YJpidxJ
	 LIveb/TOqMDcu9SLKU8rmgrF7bFtSW2i4eUBeD3N1nIQ4h//feo5VUt3sY9NzHNmy3
	 MR7HCqiKUJMpaHY+bsguDxDOWPa/FnZR1WFmt7CbEwK3WZ4QhBIjU1qu/6xttFPgvg
	 8Mb3eYrUYxniP8lJPdksBLv/KoEl1uEzgbnOy0rXnIpXcO4+dC9Iu2qXclAQMqL036
	 U6UwitIYQ0DTw==
Date: Wed, 11 Dec 2024 19:23:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Alexandru Ardelean <aardelean@baylibre.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 Renato Lui Geh <renatogeh@gmail.com>, Rob Herring <robh@kernel.org>, Trevor
 Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v6 10/10] iio: adc: ad7124: Implement temperature
 measurement
Message-ID: <20241211192300.6218e5a1@jic23-huawei>
In-Reply-To: <hoiksj7mar2qbegvy4du3b2pq4c23myrgmzmdc7axwl7yzcxm4@dupqkcedvjax>
References: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
	<433211af8ac3f02dee58586ecb51d2e98246a095.1733504533.git.u.kleine-koenig@baylibre.com>
	<hoiksj7mar2qbegvy4du3b2pq4c23myrgmzmdc7axwl7yzcxm4@dupqkcedvjax>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Dec 2024 10:28:17 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello Jonathan,
>=20
> On Fri, Dec 06, 2024 at 06:28:42PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> > index 9405cb579324..d858bffd2628 100644
> > --- a/drivers/iio/adc/ad7124.c
> > +++ b/drivers/iio/adc/ad7124.c
> > [...]
> > @@ -902,6 +941,37 @@ static int ad7124_parse_channel_config(struct iio_=
dev *indio_dev,
> >  		chan[channel].channel2 =3D ain[1];
> >  	}
> > =20
> > +	if (num_channels < AD7124_MAX_CHANNELS) {
> > +		st->channels[num_channels] =3D (struct ad7124_channel) {
> > +			.nr =3D num_channels,
> > +			.ain =3D AD7124_CHANNEL_AINP(AD7124_INPUT_TEMPSENSOR) |
> > +				AD7124_CHANNEL_AINM(AD7124_INPUT_AVSS),
> > +			.cfg =3D {
> > +				.bipolar =3D true,
> > +			},
> > +		};
> > +
> > +		chan[num_channels] =3D (struct iio_chan_spec) {
> > +			.type =3D IIO_TEMP,
> > +			.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +				BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET) |
> > +				BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +			.scan_type =3D {
> > +				/*
> > +				 * You might find it strange that a bipolar
> > +				 * measurement yields an unsigned value, but
> > +				 * this matches the device's manual.
> > +				 */
> > +				.sign =3D 'u',
> > +				.realbits =3D 24,
> > +				.storagebits =3D 32,
> > +				.endianness =3D IIO_BE,
> > +			},
> > +			.address =3D num_channels,
> > +			.scan_index =3D num_channels,
> > +		};
> > +	}; =20
>=20
> The kernel build bot wailed about the ; here. Should I send a proper
> patch, or can you still just rewrite your tree to drop it?

I tweaked it in the tree

Thanks,

Jonathan

>=20
> Best regards and thanks and sorry,
> Uwe


