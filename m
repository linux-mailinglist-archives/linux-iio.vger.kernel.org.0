Return-Path: <linux-iio+bounces-18004-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8B5A86CCD
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 13:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BED6178E10
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 11:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEC81DEFE0;
	Sat, 12 Apr 2025 11:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7LcA1lB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5355F1D8DEE;
	Sat, 12 Apr 2025 11:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744457582; cv=none; b=mnEIWvNmS6hKl7SfPF6P0qGr2jKRkyFRw43HkgDRLk/9sPTP/VAHkY/fH9NE7v/51X7PhhAhyLbKiJzsTaznSQwlu+FbNKfPzj5isGc5N09oGcgdtlJDfrX+X7YI+q1J65az0UJZCzNbJe7AdVMBEkojj0BNmJ8vYlL+fs/6FWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744457582; c=relaxed/simple;
	bh=OIbqskXMGg9jCTAPO1W4KbSMiMrj8ZFv5zOd8t12z/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ksgUoWvOez1Gwf85RK1XAxRpeLhCehR9x0NxJj++NOJhBrInLE7O7JjgpIP14eJuoq4PdPtvbArErkdNsJCXsF49dHQUwjkGurm8pnUVDnPfSPu07W80kHkoWqHH2hP5dIdYpCJn1AI1/x7oiL3T6tRQD2qkDJ/zgzBB7g0GXU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7LcA1lB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A0FC4CEE3;
	Sat, 12 Apr 2025 11:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744457581;
	bh=OIbqskXMGg9jCTAPO1W4KbSMiMrj8ZFv5zOd8t12z/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D7LcA1lBdwoSuIQtbb6hxY0SUUlSSRlWdo2hCmWBSWU5/cDe+dZ9iC7a4GHsoZugl
	 nncIpWDkVa3pmKNojUoEHY2LLsGjkh96zo9YIsDkBqeQEXfupbzt5/NEdQ/0SOFq6+
	 bX0yNg8VksftE3eq9/9iCHcwMRL6LxKa+joa6mK25cNxMPoA582z4gFIWubk0HWQ9I
	 0WLvlgPVbg90xzoPXTAz2qDTVlFRnCv31l9bfVrZfqC9idj1diah45BbCaLoLbgV9u
	 86lW/L+fCnK48adMGJbslMJqbJr+oUGVUarzNa1QZsWgmKiu8kXx6+09I2n8fDD5IO
	 u1S71+5hQAoTQ==
Date: Sat, 12 Apr 2025 12:32:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Linus
 Walleij	 <linus.walleij@linaro.org>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 0/7] iio: convert GPIO chips to using new value
 setters
Message-ID: <20250412123253.28a99570@jic23-huawei>
In-Reply-To: <a160ad15944f28159a0d1145cdf4584fb2972d6d.camel@gmail.com>
References: <20250409-gpiochip-set-rv-iio-v2-0-4b36428f39cb@linaro.org>
	<a160ad15944f28159a0d1145cdf4584fb2972d6d.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 09 Apr 2025 15:08:24 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2025-04-09 at 10:40 +0200, Bartosz Golaszewski wrote:
> > struct gpio_chip now has callbacks for setting line values that return
> > an integer, allowing to indicate failures. We're in the process of
> > converting all GPIO drivers to using the new API. This series converts
> > all the IIO GPIO controllers and also contains some additional
> > refactoring patches for ad5592r in preparation for the conversion.
> >=20
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > --- =20
>=20
> LGTM,
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
Applied with that tweak to patch 2.
Pushed out initially as testing for the build bots to poke at it some more.

Jonathan

> > Changes in v2:
> > - move devm_mutex_init() earlier in probe() to avoid using a goto
> > - rework returning on error in ad5592r_set_channel_modes(): return
> > =C2=A0 immediately instead of saving the return value and going to the =
bottom
> > =C2=A0 of the function
> > - use scoped_guard() in one more place to fix a build warning reported
> > =C2=A0 by the build bot
> > - Link to v1:
> > https://lore.kernel.org/r/20250407-gpiochip-set-rv-iio-v1-0-8431b003a14=
5@linaro.org
> >=20
> > ---
> > Bartosz Golaszewski (7):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: dac: ad5592r: destroy mutexes in de=
tach paths
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: dac: ad5592r: use lock guards
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: dac: ad5592r: use new GPIO line val=
ue setter callbacks
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ti-ads7950: use new GPIO line =
value setter callbacks
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad4130: use new GPIO line valu=
e setter callbacks
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: addac: ad74413r: use new GPIO line =
value setter callbacks
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: addac: ad74115: use new GPIO line v=
alue setter callbacks
> >=20
> > =C2=A0drivers/iio/adc/ad4130.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 10 +--
> > =C2=A0drivers/iio/adc/ti-ads7950.c=C2=A0=C2=A0 |=C2=A0 17 +++--
> > =C2=A0drivers/iio/addac/ad74115.c=C2=A0=C2=A0=C2=A0 |=C2=A0 18 +++--
> > =C2=A0drivers/iio/addac/ad74413r.c=C2=A0=C2=A0 |=C2=A0 28 ++++----
> > =C2=A0drivers/iio/dac/ad5592r-base.c | 147 ++++++++++++++++++----------=
------------
> > -
> > =C2=A05 files changed, 103 insertions(+), 117 deletions(-)
> > ---
> > base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> > change-id: 20250401-gpiochip-set-rv-iio-b064ce43791d
> >=20
> > Best regards, =20


