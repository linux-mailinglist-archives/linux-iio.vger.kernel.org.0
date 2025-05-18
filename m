Return-Path: <linux-iio+bounces-19639-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E11BABB118
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 19:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D601761B4
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 17:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C5521C19E;
	Sun, 18 May 2025 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzCOF4zq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED38213B7AE
	for <linux-iio@vger.kernel.org>; Sun, 18 May 2025 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747589273; cv=none; b=bcteSZajhkdJlhakYCb8/+Iqybfu2GDRz5sdyNXe4FqN+UHgd/dorxlcCU+UM6RpqLGZcdPL0o/mltONzWJl+0nR+4+lcpQPX1lVCsC8NXRJLRXGozq/N2+5OMr+QQfwGP4NsGU3YM13mqmT9MWY0CnF73x0q+zflRpb4CYMpaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747589273; c=relaxed/simple;
	bh=iqYlT8XwxrFdHXcbJTK7ejcvGkEKPCHHIzP9U8EQ3m4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SF7ek4j7pfpkxsB1i1NTc7ZBNijQieq+VzLGj+VBOooeMmqcNYpqxVkisRGbCBqOar7Za195oXiWaAw5WSOJ/USkQCKx5Mud/tYZnwHHZ7gw16MilmqppE2b89tjaBh/lhq/pORdwWqAmqVesALW3NZJmP9DieKk7myak67vHyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzCOF4zq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674DAC4CEE7;
	Sun, 18 May 2025 17:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747589272;
	bh=iqYlT8XwxrFdHXcbJTK7ejcvGkEKPCHHIzP9U8EQ3m4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QzCOF4zqiYi7iF0Hgk1+zG8FSGZTvnn83nLeaVHEDP0arJjJ7FmBK7R5jDXV/39sG
	 AvhTwn0P88up1APwK2Glh10K0p8mrGVYYrjDamJ5n1V4aYkTNeSQqpXDWNuTYX/11W
	 wlHy/EFUuQZoU4UgWuBPoibU16I2x5OiW5kh4QsqjiUuDFvh/Sd/UpryA2jlWLfkQl
	 fnEwdoXbErwUbRPkMWwO6vXIo33ZgMybmjlGHH7oRt1kp90kB4cgsUTjuhU6yaWftK
	 6C1zxXrNB8LXQV2gVB5YEqzg3Xw/3CZ14tLD4Yq5lRa9pxeLrtAOqWWwgUxvKgDTTG
	 nCyefNbhACGBw==
Date: Sun, 18 May 2025 18:27:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?T2N0w6F2aW8=?= Carneiro <ocarneiro1@gmail.com>
Cc: linux-iio@vger.kernel.org, fernandolimabusiness@gmail.com,
 eijiuchiyama@usp.br
Subject: Re: [PATCH v1 RESEND] iio: adc: ti-ads131e08: Add
 iio_device_claim_direct() to protect buffered captures
Message-ID: <20250518182746.11d5a356@jic23-huawei>
In-Reply-To: <20250514190901.11011-1-ocarneiro1@gmail.com>
References: <20250514190901.11011-1-ocarneiro1@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 May 2025 16:09:01 -0300
Oct=C3=A1vio Carneiro <ocarneiro1@gmail.com> wrote:

> Add iio_device_claim_direct() to protect buffered captures. In
> ads131e08_debugfs_reg_access and ads131e08_trigger_handler, data
> reads are protected by the function call to avoid possible errors
> caused by concurrent access.
>=20
> Signed-off-by: Oct=C3=A1vio Carneiro <ocarneiro1@gmail.com>
> Co-developed-by: Fernando Lima <fernandolimabusiness@gmail.com>
> Signed-off-by: Fernando Lima <fernandolimabusiness@gmail.com>
> Co-developed-by: Lucas Eiji <eijiuchiyama@usp.br>
> Signed-off-by: Lucas Eiji <eijiuchiyama@usp.br>

> ---

Firstly - why the resend?  If you do that, please put a message
here about it.

Comments inline.

>  drivers/iio/adc/ti-ads131e08.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e0=
8.c
> index c6096b646..00a7e6494 100644
> --- a/drivers/iio/adc/ti-ads131e08.c
> +++ b/drivers/iio/adc/ti-ads131e08.c
> @@ -578,12 +578,16 @@ static int ads131e08_debugfs_reg_access(struct iio_=
dev *indio_dev,
>  {
>  	struct ads131e08_state *st =3D iio_priv(indio_dev);
> =20
> +	if (!iio_device_claim_direct(indio_dev))
Why? This is a debug accessor. If it is even vaguely possible to access the=
 registers
whilst in buffered mode this might be very useful for debug.

These interfaces are not hardened against a user shooting themselves in the=
 foot.

> +		return -EBUSY;
> +
>  	if (readval) {
>  		int ret =3D ads131e08_read_reg(st, reg);
>  		*readval =3D ret;
>  		return ret;
>  	}
> =20
> +	iio_device_release_direct(indio_dev);
>  	return ads131e08_write_reg(st, reg, writeval);
>  }
> =20
> @@ -627,9 +631,11 @@ static irqreturn_t ads131e08_trigger_handler(int irq=
, void *private)
>  	unsigned int num_bytes =3D ADS131E08_NUM_DATA_BYTES(st->data_rate);
>  	u8 tweek_offset =3D num_bytes =3D=3D 2 ? 1 : 0;
> =20
> -	if (iio_trigger_using_own(indio_dev))
> +	if (iio_trigger_using_own(indio_dev)) {
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;

Why?  I think this is showing a rather critical failure to undertand
what iio_device_claim_direct() is for.
It's about preventing state transitions whilst we are in the middle
of some action that plays badly with buffered mode.=20
If you are in the trigger handler, then you are very much in buffered
mode already.

>  		ret =3D ads131e08_read_data(st, st->readback_len);
> -	else
> +	} else
>  		ret =3D ads131e08_pool_data(st);
If the above was valid then this is no longer correct kernel code
c style.  All legs of an if else should have {} if any need them
due to being multiline.

> =20
>  	if (ret)
> @@ -670,6 +676,7 @@ static irqreturn_t ads131e08_trigger_handler(int irq,=
 void *private)
>  out:
>  	iio_trigger_notify_done(indio_dev->trig);
> =20
> +	iio_device_release_direct(indio_dev);
>  	return IRQ_HANDLED;
>  }
> =20


