Return-Path: <linux-iio+bounces-18723-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF91A9E26A
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 12:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C3367A20EA
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 10:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2432405E5;
	Sun, 27 Apr 2025 10:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+kg/7Bm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D5C19DF6A;
	Sun, 27 Apr 2025 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745749101; cv=none; b=i9nEUjt0JenW1DbITXxmB+7sTLZarZ2th2++XGqifNXQXclFXDSbW2wdCPMIK2V5cWaTdWs46IJHfXECCVUfv5mC2M+1JGva3i4xexzutFYZIQEBac1KcNbiubf+30Bn0lJBKrollc18/ASgrJdoB28K+jt9+FR30XT8QHn8VBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745749101; c=relaxed/simple;
	bh=MYKBOv3U0GpmTnvHlX5zBCmp4LKLuZG9MJMLRv/q5f8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r2Tvw3Wc053QdzP8Ni1BvF+/4XrpvaxMliYu2Czit4Cu2ufewD2OaomjTw6Ms1EUTf2qGNH9gvP3v/W6LD1stRlfbFNoMw5A2ogt2VDc1ps2IWRKUBzeiYD+ZfwOLJ3Pk3s2XyqIiQ8THjj3RCYnXwGBQuHyTOz4D1ogxqY1VbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+kg/7Bm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0B6C4CEE3;
	Sun, 27 Apr 2025 10:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745749099;
	bh=MYKBOv3U0GpmTnvHlX5zBCmp4LKLuZG9MJMLRv/q5f8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F+kg/7BmuAubW4RRXDDBPU8XEh7ULftZkLRmiJP9zObHu8V+mWC2FRZftjrnUk0xO
	 FUDS2y/oMBSlEighvo5r5bpzZpN81N14HoAnavcT+R1bsrItJy5pyKQJfYewRE0d2G
	 kIy6iHmZCa69U3E8snzPLeGq6cCTKKpuWd0WY+WK1ia9w54iHVheRAnJCfnNCsE5bl
	 95C39CVsuDIIRJQ7TfZnBbJAIyp1T26yNrvkDY2zaYzgBuS+cJYrtKe9cOxp3+fZQr
	 +cmEDrnLWdjfPEEF2Kd+6CXgu5KHFLleUf8RmzFYvD/aTS3tHhELNsWJJ62M03kW+c
	 v8EOpfe42hJlQ==
Date: Sun, 27 Apr 2025 11:18:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Guillaume Ranquet <granquet@baylibre.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: adc: ad7173: fix compiling without gpiolib
Message-ID: <20250427111810.7c6c5caa@jic23-huawei>
In-Reply-To: <f5de85b7-489c-4a81-a111-fbe7a893694c@baylibre.com>
References: <20250422-iio-adc-ad7173-fix-compile-without-gpiolib-v1-1-295f2c990754@baylibre.com>
	<CAHp75VfHkKC81EinO+oN1b0=NRkwmNBLPky=HkrvPJCmt4njDQ@mail.gmail.com>
	<20250426161814.1bbf7f82@jic23-huawei>
	<f5de85b7-489c-4a81-a111-fbe7a893694c@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 26 Apr 2025 17:45:02 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/26/25 10:18 AM, Jonathan Cameron wrote:
> > On Wed, 23 Apr 2025 00:03:38 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >  =20
> >> On Tue, Apr 22, 2025 at 11:12=E2=80=AFPM David Lechner <dlechner@bayli=
bre.com> wrote: =20
> >>> =20
>=20
> ...
>=20
> >>> Not related to the fix, but I also question the use of the regmap her=
e.
> >>> This is one of the ad_sigma_delta drivers that does funny things with
> >>> the SPI bus, like keeping it locked during the entire time a buffer is
> >>> enabled. So, if someone tried to use a GPIO during a buffered read, t=
he
> >>> GPIO call could block (waiting for the SPI bus mutex) until the buffer
> >>> is disabled, which could be an indefinitely long time. And to make it
> >>> even worse, this is not an interruptible wait, so the GPIO consumer
> >>> would effectively be deadlocked.   =20
> >>
> >> I would say either the entire buffer mode is broken (in software), or
> >> hardware is broken and GPIO shouldn't be supported at all if the
> >> buffer mode is enabled. I think the best solution here is to remove
> >> the GPIO chip before enabling buffered mode. If GPIO is in use, fail
> >> the buffer mode. =20
> > I'd kind of assume that anyone using these GPIOs is doing it in a fashi=
on
> > related closely to the ADC itself.
> >=20
> > Can we make any other use fail more cleanly?=20
> >=20
> > J =20
> >> =20
> >  =20
>=20
> My inclination would be to implement it like [1] where we use iio_claim_d=
irect()
> to return -EBUSY during buffered reads to avoid the deadlock-like possibi=
lity
> instead of using the gpio regmap.
>=20
> [1]: https://lore.kernel.org/linux-iio/2a789531fda5031c135fc207a547f2c3f0=
0a13ea.1744325346.git.Jonathan.Santos@analog.com/

That sounds better.

J

