Return-Path: <linux-iio+bounces-26825-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A55EFCAA961
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 16:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8CD230CEA8C
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 15:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FC82652B6;
	Sat,  6 Dec 2025 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnjZPVAb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C081E244675;
	Sat,  6 Dec 2025 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765035779; cv=none; b=XBo07MX5Lwx/KmV5w58g5lfaj0z9IRmmm6cfGuywdJ45osawqJ1zRNFZeMPVPHa+vdPJYttVmF6ltygNI2ad3xlYuECOALnkjJTjDBWvM9m4mI2r+g/vBG24xR5TpJCnceU/HMcNWN/KRw76fw6hAaQj/7tmg2p5IiD8Stw1lCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765035779; c=relaxed/simple;
	bh=Y+nB8jUrNe/Vy9wuhhDeU1eHbQjXRG5ckwzSR47dIVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YScvTEUDY16oStczagez00/j7K+6cAWdHIBuLSNiT56cMN5L+FdzpUN9M4RjP+Cj+f9LkYjA5FsOljSURkwYQQT5XnR/KjPncM2LQe4m/MbFp1Z8N762dQz+7ycqB93q1RIjE78Lbv7PKSONucyXLFt/z4RLnKMMVjD1oLVC150=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnjZPVAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCEBC4CEF5;
	Sat,  6 Dec 2025 15:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765035779;
	bh=Y+nB8jUrNe/Vy9wuhhDeU1eHbQjXRG5ckwzSR47dIVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nnjZPVAbnht9sCYOwQ88rRnQuxy2iUxSfI/mpYJJV4mO1WUZ/avgpC3RTLJ0bMvLF
	 7LcOe36daTdTcjfB13F7m1GhL8I/KGSoPex8U7gmqRgTtuCG4BWMPAtKXHoS+5ve+3
	 rBm7AKrz1EMltT9WQHtVQb6Ox7aEWfrmPd4phNpbYbMV62Pvg0pEvbeYsjHKbDQQ34
	 laqI5whJjuGhaS1WRnYqutTCeuKLMaiVN/gn7li5Z9tgVL3jmFvCLsNHApF0qAXnnB
	 P8Lme+vt6Dx2fZVzHJGWaGwJD/gEUyG5huQWG9hoytGtfbJii/ai8SwGqGvXnSBgln
	 anKG08Qr1KqmQ==
Date: Sat, 6 Dec 2025 15:42:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dharanitharan R <dharanitharan725@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] staging: iio: frequency: ad9832: replace long/short
 with u32/u16
Message-ID: <20251206154250.7d5dfa74@jic23-huawei>
In-Reply-To: <20251206054831.26045-1-dharanitharan725@gmail.com>
References: <20251206054831.26045-1-dharanitharan725@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat,  6 Dec 2025 05:48:31 +0000
Dharanitharan R <dharanitharan725@gmail.com> wrote:

> Cleanup the AD9832 header by explicitly including <linux/types.h> and
> replacing ambiguous integer types with fixed-width kernel types:
>=20
> - unsigned long =E2=86=92 u32
> - unsigned short =E2=86=92 u16
>=20
> This improves type clarity and ensures consistent behavior across
> architectures.
>=20
> Signed-off-by: Dharanitharan R <dharanitharan725@gmail.com>

Hi Dharanitharan,

Thanks for sending this.

A few comments.  Firstly there is a reasonably high chance we'll be shortly
dropping this driver from staging because it's had no significant work to
bring it up to date in a very long time.  Unfortunately unless you were
following that discussion deep in an unrelated looking thread there was
no way for you to know that :(

Following up on this particular patch, it doesn't make sense to just
change the types where they are stored here.  These are passed into
various functions that continue to take unsigned long / short parameters.
For example, ad9832_write_frequency() and the calls under that.
If we were going to tighten the types up it should be consistent.
Such a patch would then show how these updated types interact with the
other values in the driver for example the output of clk_get_rate().

So in general this sort of cleanup might makes sense only if done
right across all use of the values for which the types are being changed
otherwise it just ends up adding to the confusion.

Third, platform data like this is a nasty bit of legacy from the pre
device tree days (this is a very old driver!) and so if we didn't fix
up this driver it would likely go away as part of that effort.

As noted though I wouldn't advise continuing with this particular
driver on simple basis it will probably go away (unless someone shouts
that they still need it when I send the removal patch!)

Jonathan


> ---
>  drivers/staging/iio/frequency/ad9832.h | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/staging/iio/frequency/ad9832.h b/drivers/staging/iio=
/frequency/ad9832.h
> index d0d840edb8d2..d59ad0627a9b 100644
> --- a/drivers/staging/iio/frequency/ad9832.h
> +++ b/drivers/staging/iio/frequency/ad9832.h
> @@ -6,6 +6,7 @@
>   */
>  #ifndef IIO_DDS_AD9832_H_
>  #define IIO_DDS_AD9832_H_
> +#include <linux/types.h>
> =20
>  /*
>   * TODO: struct ad9832_platform_data needs to go into include/linux/iio
> @@ -22,12 +23,12 @@
>   */
> =20
>  struct ad9832_platform_data {
> -	unsigned long		freq0;
> -	unsigned long		freq1;
> -	unsigned short		phase0;
> -	unsigned short		phase1;
> -	unsigned short		phase2;
> -	unsigned short		phase3;
> +	u32 freq0;
> +	u32 freq1;
> +	u16 phase0;
> +	u16 phase1;
> +	u16 phase2;
> +	u16 phase3;
>  };
> =20
>  #endif /* IIO_DDS_AD9832_H_ */


