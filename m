Return-Path: <linux-iio+bounces-16879-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12086A631DA
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 19:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256081897512
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 18:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D52515573F;
	Sat, 15 Mar 2025 18:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEOi0PB4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB542F3B
	for <linux-iio@vger.kernel.org>; Sat, 15 Mar 2025 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742064407; cv=none; b=ClaFEKwMjuIZTA6+fBtJs0BXDzPThr+V8IZLRep3NHOwJKIpS9E1+i89ZE+DQYIArkWMHYVOSIaCotEcSLLNKt5TJzCyqG3wtfzKAe6XXZ832UgeEgJeHqRaZJGUNuliSPEliwBeNikBX3qTPg5dWUqUkjZg71RGXQpDff8QuQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742064407; c=relaxed/simple;
	bh=eSK1JqR6yvKdl37pcZbTA+GrXthr/OAFHuIVNiR1Tcw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJvlcHMq5EM+4xC0GZhRgvVytd6ueqWLmAqwPBjSkfeMx4XKs8d1xqkYr39CFLdDTMzyLp6kdNq4jt1JbUMQiKt1jFoE652p98Ir1Dsar3QzPbckraYMXPksiA8RaHKA+eLU+Qu+49rROj9n3SgMCWIN+NHPLizP5Wtd9QYSemc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEOi0PB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499E1C4CEE5;
	Sat, 15 Mar 2025 18:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742064405;
	bh=eSK1JqR6yvKdl37pcZbTA+GrXthr/OAFHuIVNiR1Tcw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rEOi0PB4DCA1myQAY0DVvyCXWI8B0Y5D147E92Wu396EywYhh07/P8TrG/J3UWKuc
	 NYtHiFsP7dby3fyAStwsS8SZzi1GUIahoCmxEvwi5RR544aZv3JRrkby0oe9I9AUgF
	 2eNPxD7iOM3fIPphkgGg3bPGue6KvwG9hI8plDBMc3IrhN6/BO9H51DmvpHn+3En9J
	 eNTGpsdy3qExydqpaKqn8LCTvsCTEEFh8Ac9UqovY+4hkTWuhoeOdR80YQHxFKkZ69
	 2afAjR8cTUN+ADYxXhqJhF+b1DVKkcA7fe7+mLpZLSSZwYlsHz0Snh5+hjLcNdK/o/
	 7Hc384Wi2Y4qw==
Date: Sat, 15 Mar 2025 18:46:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Alexandru Tachici
 <alexandru.tachici@analog.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: adc: ad7124: Fix 3dB filter frequency reading
Message-ID: <20250315184638.5bac05e1@jic23-huawei>
In-Reply-To: <cover.1741801853.git.u.kleine-koenig@baylibre.com>
References: <cover.1741801853.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Mar 2025 19:38:36 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello,
>=20
> here comes another fix for the ad7124: The getter function for the
> filter_low_pass_3db_frequency sysfs property used wrong factors to
> calculate the f_{3dB}.
>=20
> The first patch is a cleanup I implemented before I noticed the issue. I
> didn't switch their ordering because I was lazy. If I continue to
> discover issues in the ad7124 driver at that rate, swapping for this one
> fix doesn't really matter :-)

Hmm. Even so, please swap if not too ahrd.

>=20
> Note the setter function is still broken. And it's worse enough that I
> don't know how to fix it at all. The relevant part of the function looks
> as follows:
>=20
> 	sinc4_3db_odr =3D DIV_ROUND_CLOSEST(freq * 1000, 230);
> 	sinc3_3db_odr =3D DIV_ROUND_CLOSEST(freq * 1000, 262);
>=20
> 	if (sinc4_3db_odr > sinc3_3db_odr) {
> 		new_filter =3D AD7124_FILTER_FILTER_SINC3;
> 		new_odr =3D sinc4_3db_odr;
> 	} else {
> 		new_filter =3D AD7124_FILTER_FILTER_SINC4;
> 		new_odr =3D sinc3_3db_odr;
> 	}
>=20
> The issues I'm aware of in this function are:
>=20
>  - the sinc3 factor should be 0.272 not 0.262 (which is fixed for the
>    getter in patch #2)
>  - for freq > 1 the if condition is always true
>  - In the nearly always taken if branch the filter is set to sinc3, but
>    the frequency is set for sinc4. (And vice versa in the else branch.)
>=20
> Also it's unclear to me why sinc4_3db_odr > sinc3_3db_odr is the test to
> decide between the two branches. Maybe something like
>=20
> 	if (abs(sinc4_3db_odr - current_odr) < abs(sinc3_3db_odr - current_odr))
> 		use_sinc4()
> 	else
> 		use_sinc3()
>=20
> would make more sense.
>=20
> I intend to add a filter_type property to the driver next. When this is
> implemented setting the filter_low_pass_3db_frequency shouldn't be
> needed any more and we can either keep the function as is (and
> discourage its use) or just drop it.

If it is currently broken I'm less fussed about dropping the ABI than I wou=
ld be
for even correct but useless ABI.  This falls into the category of unlikely
anyone will noticed as they should have noticed it wasn't working if
they were using it!

Jonathan

>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=C3=B6nig (2):
>   iio: adc: ad7124: Make register naming consistent
>   iio: adc: ad7124: Fix 3dB filter frequency reading
>=20
>  drivers/iio/adc/ad7124.c | 176 +++++++++++++++++++--------------------
>  1 file changed, 85 insertions(+), 91 deletions(-)
>=20
>=20
> base-commit: 8dbeb413806f9f810d97d25284f585b201aa3bdc


