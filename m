Return-Path: <linux-iio+bounces-5135-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B868C960D
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 21:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86441F21218
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 19:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1DA4C60B;
	Sun, 19 May 2024 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNAip4XM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32AEEAEB;
	Sun, 19 May 2024 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716146452; cv=none; b=NlFl9PF/ZbjfZJZOE8rr7PK2qaUKqfLaJu9ehMfnkUKZ5Wy7HtJRUvw3Xp1iGJqubCkOwOe2ORzj5lzBwyREAD0Bn9weODfobaKsNGaMplkpyj6PE9LSBLzU1fC7pLepCgnziveQ52peENeTSMLp/5hMIyWnzSeLmnRX0xZGaII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716146452; c=relaxed/simple;
	bh=ykLxESgB7ISBPimW2UXAEsGJazq8lCpoX0jzaPzAzFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AAheE5/tT1w9r5WX4t89ZZbwONkcKAmkBqNDS0wWqqGMx0mNcj2xQRWS8NlR3SEJTe8//yTie/9SkZRW7tXG4D7Z+mTGyT/IEXhGW5EKHJD4pXaUCt/WzHhOhcW+ue1q+hfbX6gsRfeuvz30nIFjOLofC6hA8gN+GUQfUzj32LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNAip4XM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B8BC32781;
	Sun, 19 May 2024 19:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716146451;
	bh=ykLxESgB7ISBPimW2UXAEsGJazq8lCpoX0jzaPzAzFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dNAip4XM8wdUfJAQ6NEtWFMVCidR9ibuqM0426E0JFFEbaxMI3D+tmdocXHLoSmBW
	 hYIrehDtUGu3V18nY7Bs8scP5CavU14GcDTWWUBbDdzs4G5AuG9iCvg5PMqcoZOF5Y
	 g7vG9B8uF9jbU8pqjdPzUS49yZGE/fA8SR2Gq+pF6favZsHrMez1xWzTFOb9Zx36aR
	 07gsXGKm0uY1jdidTFaghL+cxg7vLzlKX3TdUlq6KeS6WTF12H2Qnp+KcRt8GetKQn
	 Q7gDvkz7AUOFUhet6yKHGzIV+kHiU0sFSBe3T0Z1SVVsDQW/pNDk3u8CvK25VhZ8pZ
	 3n2h3Tr8pYeGw==
Date: Sun, 19 May 2024 20:20:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Julien Stephan <jstephan@baylibre.com>, Esteban Blanc
 <eblanc@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 4/4] iio: adc: ad7380: add support for multiple scan
 type
Message-ID: <20240519202039.5a70157d@jic23-huawei>
In-Reply-To: <CAMknhBFob4Wd8Gm8W8NKSuL9UbBCY8+fAN_voGPhb4Fy1tAT-w@mail.gmail.com>
References: <20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com>
	<20240507-iio-add-support-for-multiple-scan-types-v1-4-95ac33ee51e9@baylibre.com>
	<20240508124049.00001661@Huawei.com>
	<CAMknhBFob4Wd8Gm8W8NKSuL9UbBCY8+fAN_voGPhb4Fy1tAT-w@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 8 May 2024 12:21:09 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Wed, May 8, 2024 at 6:40=E2=80=AFAM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Tue,  7 May 2024 14:02:08 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> > =20
> > > The AD783x chips have a resolution boost feature that allows for 2
> > > extra bits of resolution. Previously, we had to choose a scan type to
> > > fit the largest resolution and manipulate the raw data to fit when the
> > > resolution was lower. This patch adds support for multiple scan types
> > > for the voltage input channels so that we can support both resolutions
> > > without having to manipulate the raw data.
> > >
> > > Signed-off-by: David Lechner <dlechner@baylibre.com> =20
> >
> > I'm wondering about the control mechanism.  I was thinking we'd poke
> > the scan type directly but this may well make more sense.
> >
> > This is relying on _scale change to trigger the change in the scan type.
> > That may well be sufficient and I've been over thinking this for far to=
o many
> > years :)
> >
> > It will get messy though in some cases as the device might have a PGA o=
n the
> > front end so we will have a trade off between actual scaling control and
> > resolution related scale changes. We've had a few device where the scale
> > calculation is already complex and involves various different hardware
> > controls, but none have affected the storage format like this.
> >
> > I'll think some more.
> > =20
>=20
> Here is some more food for thought. The AD4630 family of chips we are
> working on is similar to this one in that it also has oversampling
> with increased resolution. Except in that case, they are strictly tied
> together. With oversampling disabled, we must only read 24-bits (or 16
> depending on the exact model) and when oversampling is enabled, we
> must read 32-bits (30 real bits with 2-bit shift). So in that case,
> the scan_type would depend only on oversampling ratio > 0. (Writing
> the oversampling ratio attribute would affect scale, but scale
> wouldn't be writable like on ad7380.)
>=20
> It seems more intuitive to me that to enable oversampling, we would
> just write to the oversampling ratio attribute rather than having to
> write to a buffer _type attribute to enable oversampling in the first
> place. And other than requiring reading the documentation it would be
> pretty hard to guess that writing le:s30/32>>2 is what you need to do
> to enable oversampling.
>=20

Ok. Few weeks thinking and I've no better ideas.  Generally I'm fine
with how you did this but I wouldn't have a 'special / default'
scan_type.  Just put them all in the array and pick between them.
That avoids fun of people trying to work out on what basis to
prefer one over another.=20

So tidy the loose ends up and I'd be delighted to see a non RFC version.
It 'might' be worth waiting until we have a couple of suitable drivers
though and then show the feature works well for them all.
Whilst I think I'd take it with just one though as can see how it fits
together, but more than one driver would boost my confidence level.

Jonathan

