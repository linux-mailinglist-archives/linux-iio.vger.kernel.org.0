Return-Path: <linux-iio+bounces-22502-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87D3B1F606
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 21:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ADAB3B25DE
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 19:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E492A274B43;
	Sat,  9 Aug 2025 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yre0dFqz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF851F76A5;
	Sat,  9 Aug 2025 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754768278; cv=none; b=gFiLB04heAUxg5Llj5uakY8tvMDrNXqCB2IKsK7FbdQHG6qwCOgcKUltri6gmJiWYOH3Ti0TZ5+7kGsutziPak49+qnrpk4Io3iTOQBQ40JaWf38VyVx0m8zfZhAsniYkYHGqOem9MQkKyRnbxp9G0AEpwhQTwJNRLulTZhUq3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754768278; c=relaxed/simple;
	bh=rV96oknmnWYsz10wtH9cy0n9LgqSE14sXOyCasUmt6I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikAh9vfOIvL3Vd9239QxO2aX5BPJX9Wt4ir5aUljcElbQeWAy3iiGFHef7c/XVugSDRhyNmZdOAqysAW+ONgbOvGrZvuB7vJ+mypb7kxz24AdV3d/PY/a1i+uHXb6TssRY4qvvsG/0DoMQTk9qAlnOmOjttMocg6CYNfNlBCDN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yre0dFqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2375C4CEE7;
	Sat,  9 Aug 2025 19:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754768278;
	bh=rV96oknmnWYsz10wtH9cy0n9LgqSE14sXOyCasUmt6I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yre0dFqzJk0mnmj/KkW0gVF5n5jtE7LuXztDSGfQ1pVrf8/+Ojg4KJN7I3etQGxN0
	 magFyxsWTo1Sx8dfBBlxo5l1rjnBTkJGgJ5Hk+7Q77Vyqm0Vt5cjPjXa7biOLUWhxj
	 9jO+sCvT4CijCDL178xmDbIsQ1Km9Gxoijf7tPrkNWmz2GayC1cBEsM7Z9DKx2qDJd
	 eWeTb2cTrC66oCwevittzk9GzEmR3ymhTWdHVuGuunWoyirJMQ6BsroTSLXHhanIPP
	 PwindmGx+iyNnR0B5Fo5bQ5mgauZX3eaT2S4ueTaV9Lj6eQJxOydTud8GwOtAiJpXa
	 gZvsxDleAsnWQ==
Date: Sat, 9 Aug 2025 20:37:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ioana Risteiu <Ioana.Risteiu@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ramona Nechita <ramona.nechita@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: adc: update ad7779 to use IIO backend
Message-ID: <20250809203748.1cac382f@jic23-huawei>
In-Reply-To: <aJO8thsrIgS3YGj2@smile.fi.intel.com>
References: <20250806192502.10120-1-Ioana.Risteiu@analog.com>
	<20250806192502.10120-4-Ioana.Risteiu@analog.com>
	<aJO8thsrIgS3YGj2@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> 
> > +static int ad7779_conf_channels(struct iio_dev *indio_dev, const struct ad7779_state *st)
> > +{
> > +	struct iio_chan_spec *channels;
> > +	struct device *dev = &st->spi->dev;
> > +	int num_channels = ARRAY_SIZE(ad7779_channels);
> > +
> > +	channels = devm_kcalloc(dev, num_channels, sizeof(*channels), GFP_KERNEL);  
> 
> Doesn't sound like a right place for devm. Is this function called only at probe stage?
Yup.  So probably wants a name that doesn't sound like a runtime thing.  setup_channels maybe?

> 

