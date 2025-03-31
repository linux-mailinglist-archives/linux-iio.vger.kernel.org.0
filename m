Return-Path: <linux-iio+bounces-17409-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AB7A7639C
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 11:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8973D167185
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 09:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B421DE884;
	Mon, 31 Mar 2025 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJ7MAlKu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3E015530C
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743414822; cv=none; b=DvArwVzenxxJiOUAp6SatAvihmUlppRbWK5Wy0KAaoa5VhsPiU5pXdGtrqj5hay6M2V3r4+BfzS9Mpe2+v2J/vn6QxWaJ3C49K0FFgm6QzVZPr8xvIKoHQc/3zORRRd+VbjwJwlCGEJmPEW8CkN5HmaHp5zGiyl+vaX7nPxL8nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743414822; c=relaxed/simple;
	bh=wKAOo4LOQ1dlVLOiuKYuCoS3Kq1smXEc29rWCHGqDAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6Q9kSO3IJDA60ZUkq97QkKXsG5lkZOMzt7wpicQ6hxZgTkFBW75uJUIeEbG4RPsXMdtMyfQpTnA3qA7SO8aEz1dVIsfxvDxIQDg96YBUjjXOHGYfDnQXi2TN4dX+vYUkVdFGLAkHj36Aoeh/3OkYMKAy91XlcZJQM3RNDZjdCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJ7MAlKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7FCC4CEE5;
	Mon, 31 Mar 2025 09:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743414822;
	bh=wKAOo4LOQ1dlVLOiuKYuCoS3Kq1smXEc29rWCHGqDAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IJ7MAlKuAED1wmgsoN2u4GxqABJIB1fv9mIpJQKBerYS4AmPuYBRQTE6craNcumzA
	 Qilh6AvFH9+Z/8FUrjA3ZVBv+MLhlg2xtggDk2z+8qJqli5evMoZ46Zu4hD5vdvVlL
	 XssZzknHL9TNYbnyBvwvoa6bXdhgmalqni/c2N41WfTQr0PyMpI/sYB8QBrkB18ho3
	 BCW3+N8u5HCm+7oZnSEC6HUtad6ioIyyaSDEV0RD3KIIAzPP+e1KK90DTR5OVH3P4B
	 TR3tF3WfZeUcoMyX7/iJ4tm+i1VZEptD65cR0/eB5GsUalFItgaVapGkDlsDrgQcYo
	 q7k/lFa01o0nA==
Date: Mon, 31 Mar 2025 10:53:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: adc: ad7124: Remove ability to write
 filter_low_pass_3db_frequency
Message-ID: <20250331105334.677b60c6@jic23-huawei>
In-Reply-To: <Z-RI2JsbK9l2aMnY@debian-BULLSEYE-live-builder-AMD64>
References: <20250317115247.3735016-5-u.kleine-koenig@baylibre.com>
	<20250317115247.3735016-7-u.kleine-koenig@baylibre.com>
	<Z-RI2JsbK9l2aMnY@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Mar 2025 15:35:04 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 03/17, Uwe Kleine-K=C3=B6nig wrote:
> > There are several issues with the function that implements writing to
> > the filter_low_pass_3db_frequency property:
> >=20
> >  - The sinc3 factor should be 0.272 not 0.262 (this is fixed for the
> >    reading side in the previous patch).
> >  - For freq > 1 the if condition is always true so the sinc4 filter is
> >    hardly ever chosen.
> >  - In the nearly always taken if branch the filter is set to sinc3, but
> >    the frequency is set for sinc4. (And vice versa in the else branch.)
> >=20
> > This is broken enough to justify the claim that there isn't any serious
> > user. Also it it counter-intuitive that setting the 3db frequency
> > modifies the sample frequency and the filter type. =20
>=20
> Not from engineering background but, as a Linux developer, I agree changi=
ng 3dB
> frequency to set the ODR (sampling frequency) is counter-intuitive and un=
common
> among other IIO sigma-delta ADC drivers.
First, ABI wise, any parameter is allowed to change any other - so we have
no firm rules on this.

Changing the filter type isn't completely silly as a side effect of changing
3db point as when we are selecting between fixed filters that may be precis=
ely
what the user is trying to do.

Changing the sampling frequency is harder to argue.

Given it's horribly broken anyway I guess no one ever touched it and we are
fine to clean things up.

Jonathan

>=20
> >=20
> > So drop the ability to write that property.
> >=20
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> =20
>=20
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>


