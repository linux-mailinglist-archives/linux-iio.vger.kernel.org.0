Return-Path: <linux-iio+bounces-19433-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB22AB2931
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 16:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 719B53A4670
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 14:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116307081A;
	Sun, 11 May 2025 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dO1qNWP3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B415D1C69D;
	Sun, 11 May 2025 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746974770; cv=none; b=F+KbmTtyWVOfe6BKiU26E3xfSlgp46y5YBJWGJpQzbzF02YDdrD/yKsV4venIAfaFeeyHSEG1tbNpVk2NbqWrg4LfcV6Kytieo0masqn+Kn68x8CGVaaevPecBjIYCRoDlaDjDjnybrjG9BTjn2c3DQ8hdb8PZfc3NDOOhLvvrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746974770; c=relaxed/simple;
	bh=ZJ9djcHc8Rmd129dIqaJ8JzqjDj+Q1d3DdIKr+C4TeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzAgDFUxQS4ADUTTj/bREelh+aZa3HQIYRIZcqg390ipCX3PLmFWg1Yh1EIIIlmt9fibGx84At4X467fxaNutdp9HA871k0pAoGf3jTqUgFXmHeLgOXEiCHFLcfRtUwUY07TiSlRR+E/xkRHnD3pEm20ajhxIwiauStQctAkB3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dO1qNWP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD42C4CEE4;
	Sun, 11 May 2025 14:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746974770;
	bh=ZJ9djcHc8Rmd129dIqaJ8JzqjDj+Q1d3DdIKr+C4TeQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dO1qNWP3FVy8ym18xnfsznYsrgbklYe1dyoe4haP2SkZ+6YlALUsR36fPrzA2bsXn
	 9dqbFP0G6aFQLcUzb/LFPzrVDvUIfZORdFlHjMrAa/BUYqXY6SymAPChoknOMozpl3
	 Lymmju+UCdMvkQaNDsaoRoaYxCatmz1mrOsoY65ShIUVZALbeCAIdM5Y/jr7upo0Me
	 CQo6N6MfpMjCy/Obq9Q5dDPQ75hz/dhOvQCOJ2drsLQVMgx3jHrpx8pqLegnF1aDHc
	 Ug2iawVvzCosoTxbymtBLdRFmY1YvlWopshYpAoucPK7JljIYe4wTuV7IP/ok/Qg6W
	 l25xhZah+LQsQ==
Date: Sun, 11 May 2025 15:45:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Pop Ioan Daniel <pop.ioan-daniel@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sergiu Cuciurean
 <sergiu.cuciurean@analog.com>, Dragos Bogdan <dragos.bogdan@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Tobias Sperling <tobias.sperling@softing.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Matteo Martelli <matteomartelli3@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: adc: ad7405: add ad7405 driver
Message-ID: <20250511154555.067143c9@jic23-huawei>
In-Reply-To: <4fb74419-51bf-4294-82bf-545504ad0c3f@baylibre.com>
References: <20250508123107.3797042-1-pop.ioan-daniel@analog.com>
	<20250508123107.3797042-5-pop.ioan-daniel@analog.com>
	<4fb74419-51bf-4294-82bf-545504ad0c3f@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > +
> > +static const struct iio_info ad7405_iio_info = {
> > +	.read_raw = &ad7405_read_raw,
> > +	.write_raw = &ad7405_write_raw,
> > +	.read_avail = &ad7405_read_avail,
> > +};
> > +
> > +#define AD7405_IIO_CHANNEL {							\
> > +	.type = IIO_VOLTAGE,							\
> > +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> > +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\  
> 
> Would it make more sense to use IIO_CHAN_INFO_OVERSAMPLING_RATIO for controlling
> the decimation rate and have IIO_CHAN_INFO_SAMP_FREQ be read-only?

My initial reaction to this was that we'd be not providing one of the longest
standing and user friendly(ish) interfaces.  However if it literally only affects
oversampling then indeed I think oversampling is the more informative interface.
Which is to say I started writing no then thought some more and ended up agreeing with
you ;)

As you say, a read only sampling frequency is fine.  We use those when it's controlled
by some outside factor (like a clock frequency) so userspace should in theory at least
cope fine with that being RO.

> Maybe also useful to have a read-only filter_type attribute to say that the
> backend is providing a sinc3 filter?

Nice to have perhaps.


J


