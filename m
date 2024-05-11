Return-Path: <linux-iio+bounces-4966-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 171658C3271
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 18:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14601F21C39
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 16:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368BA57307;
	Sat, 11 May 2024 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUia6/GJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C0E56B7F;
	Sat, 11 May 2024 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715444529; cv=none; b=gwhRZYwCO+aLOD94Bqiv1+SevTRoEiGh3aKUcmBA0J8LDcdQJb1Fherjf3TeN1JyJfG7ESPZT0+PTkJOb6WJ9G0hQL7HWf9tX/I02mS1f4hfUPqkUN+KcoPAW9eVs3vSWRJHzzsDpeiZwNfcAnHfAZrX9Tcucuv75y58bxcqDtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715444529; c=relaxed/simple;
	bh=waGZCjYc4EYoDlFRXsZRE3LgBvKQnnMdiOCAiz2Or9o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mejdGM30sOG99Ug6TMlkY7SxEepquNmmuVNjynWMPCdijv/E2hw1t4rW6e+HlWwU/powyEWwV/cVeJ7XuS+k6YbTjKqIiAd3ykwM7ICOZ21AE1dB95op0E0UpzPh1M9owv9yim3ftiNfJukWxddf+2ke7+x/3dI6MyN0CxKTsMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUia6/GJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E07C2BBFC;
	Sat, 11 May 2024 16:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715444528;
	bh=waGZCjYc4EYoDlFRXsZRE3LgBvKQnnMdiOCAiz2Or9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pUia6/GJ/XPK9APwp4JYfbzEwt6LAl7RDFE9bwqBx4kaRYlMBJmpZGh0cErFE0whr
	 wLOnsBUedJuhU2GH1arbv4VJdwvX6xIU8AgrrZ3iOjY1qyVgeFl0tmCaark/jNfnX9
	 RLanF+02PGK9ZE1youvcLMirMEGHCMxqVs9MnKiNsDVyzY32ORJ98s7gNM5LdQefZB
	 3V+RmGqPXgCzrTFB402Obtar39ONhwy7hSkuLnNHvyae9msA4p3d4NFA/gQFAYJlde
	 XbuSCJOqYlq4Xn901LC9hT/8yPtR7s9gzYNroAPIFEOKVLsDoZuu8vZsYSZrT5eQwK
	 DVVz57QgPFa5Q==
Date: Sat, 11 May 2024 17:21:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mariel Tinaco <Mariel.Tinaco@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 0/2] add AD8460 DAC driver
Message-ID: <20240511172155.08bc0987@jic23-huawei>
In-Reply-To: <CAMknhBHd2XCJH4rgYDq=vbCL5E_tM3FxFPWbNy9PvxLCJL4tcA@mail.gmail.com>
References: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
	<CAMknhBHd2XCJH4rgYDq=vbCL5E_tM3FxFPWbNy9PvxLCJL4tcA@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 10 May 2024 12:30:46 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Fri, May 10, 2024 at 1:42=E2=80=AFAM Mariel Tinaco <Mariel.Tinaco@anal=
og.com> wrote:
> >
> > The AD8460 is a 14-bit, high power +-40V 1A, high-speed DAC,
> > with dual digital input modes, programmable supply current and
> > fault monitoring and protection settings for output current,
> > output voltage and junction temperature.
> >
> > The fault monitoring and shutdown protection features were
> > supported in the earlier versions of the IIO driver but was
> > scrapped due to uncertainties if the functionalities belong to
> > the IIO driver. However, it would be best to implement it for
> > the device's quality of life. I'd like to know if it's better
> > suited as a stand-alone HWMON driver.

That probably doesn't make sense.  This reply btw is based on the
text here. I haven't yet looked in detail at the datasheet.

Some fault conditions are relatively easy to map to threshold events
on an input channel.  The ones that are harder are things
like short circuit detectors where it's hard to know what the
actual threshold is.

The other place we are limited is in multiple levels for the
same thing.  So warning and fault levels. That stuff is handled
much better by hwmon where these things are more common.
The issue we have is that the event encoding is a bit tight
but we could see if there is a way to add these.

> >
> > The following are the configurable and readable parameters
> > through SPI that could be implemented on the HWMON driver:
> >   * An enable bit to arm/protect the device on overcurrent,
> > overvoltage or overtemperature events. The device is shut down
> > upon detection.

We don't have a good way to handle restarting from shutdown, but
perhaps we could use another action to signal that - maybe even
going as far as saying that the driver should be reloaded.

As for the thresholds, they sound like the map to IIO events
reasonably well. =20

> >   * A configurable range/threshold for voltage, current and
> > temperature that raises alarm when exceeded while the device is
> > armed.

That maps fine to the IIO event threshold controls.

> >   * Flags that can be polled to raise alarm upon detection of
> > overcurrent, overvoltage or overtemperature events, and apply
> > additional protective measures.
The specific need to poll is awkward but you could do it easily
enough in driver and use the IIO event stuff to signal any
events detected.


> >   * Programmable quiescent current (optional)
Could probably figure out a suitable control for this, but I'm not
entirely sure what it is :)

> >   * Thermal monitoring is done by measuring voltage on TMP pin
> > (unlikely to be included)

If you did want to, the usual trick for these is to include
an optional use as a consumer of an IIO provider which would be
a separate ADC.=20

> > =20
>=20
> Adding myself to the cc: here since I'm interested to see what
> Jonathan (or anyone else) has to say about the fault monitoring.

Jonathan

