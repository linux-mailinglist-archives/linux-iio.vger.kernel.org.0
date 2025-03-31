Return-Path: <linux-iio+bounces-17413-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78712A7640E
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC04188A101
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 10:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED761DF75B;
	Mon, 31 Mar 2025 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQYe0TXg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B64E1DE892;
	Mon, 31 Mar 2025 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743416534; cv=none; b=nUyOwoD9G6iBQXT3XMBGPkKANqlFiyPg5E/HSwmHahsbM8tii7trQi5R7eLzk04UGHLGTOhlM4s/F+HaLeE7LMZqMItLdSyg8oux9al6TKBmToOC9FVej3ycWqKT1pWlLgrhwVgfrBwgF1CVlKWfy9+wwshBaLOGyZ1S8pwOHTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743416534; c=relaxed/simple;
	bh=vKRUMgcWb9UyjN7FvkeSjwbIlIKvKrgZrhoWgtJYVHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKEiT1zmnC5mH4ko50qH5D+WRScH0UghWBJj5v11bNS1RRZSxOjkMaML2BKNtUCpYWPzfOwmoyUx3GM4Bjh40F1SbErJ4QrHGah15ukFMexfIU59gn+MRIp27MQzr5JxelC7+wMvJpLvAU+M2K+ckAVx0MYu+LwkNqNQ0aWx7js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQYe0TXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586A1C4CEE3;
	Mon, 31 Mar 2025 10:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743416533;
	bh=vKRUMgcWb9UyjN7FvkeSjwbIlIKvKrgZrhoWgtJYVHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uQYe0TXgb7fvhOF87U7EizzuwDOb4SkAOnDJU2F+YM6a643tHHXK23Plic1JRIP61
	 mK9mDH/3Pu/L+m5fRyu+W5yy7/2dBG4c5GIwu/9tTCdM8t1qEZzvPALQOeyny2joLD
	 ij9OpJc7f6E1o1rbWBWdA9oIEixKAeZg3Us1a2BWAIVMTB6xDyYONII5yGcFz/ENCu
	 YGtYBKDzNqEBD/6rDDvUl36uhECvRitwICeqaS4MGqnJ/qsYKDG84fguQtGfmhEKWg
	 +irKvn9cqgqt4jYFWYhRBXru3pxEseLW1TYM/WQP6hhSAcKuh7IoarugLxkY/+z6pt
	 vIFUIEkeHYDFQ==
Date: Mon, 31 Mar 2025 11:22:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v5 02/11] iio: accel: adxl345: add single tap feature
Message-ID: <20250331112205.2457d829@jic23-huawei>
In-Reply-To: <20250318230843.76068-3-l.rubusch@gmail.com>
References: <20250318230843.76068-1-l.rubusch@gmail.com>
	<20250318230843.76068-3-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Mar 2025 23:08:34 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the single tap feature with a threshold in 62.5mg/LSB points and a
> scaled duration in us. Keep singletap threshold in regmap cache but
> the scaled value of duration in us as member variable.
>=20
> Both use IIO channels for individual enable of the x/y/z axis. Initializes
> threshold and duration with reasonable content. When an interrupt is
> caught it will be pushed to the according IIO channel.
>=20
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

A couple of build issues plus one comment inline
(I was going to tweak that thing whilst applying but the axis_en one is mor=
e complex).

  drivers/iio/accel/adxl345_core.c: In function =E2=80=98adxl345_is_tap_en=
=E2=80=99:
  drivers/iio/accel/adxl345_core.c:201:14: warning: variable =E2=80=98axis_=
en=E2=80=99 set but not used [-Wunused-but-set-variable]
    201 |         bool axis_en;
        |              ^~~~~~~
Not sure what intent was in this code.

  drivers/iio/accel/adxl345_core.c: At top level:
  drivers/iio/accel/adxl345_core.c:818:31: error: initialization of =E2=80=
=98int (*)(struct iio_dev *, const struct iio_chan_spec *, enum iio_event_t=
ype,  enum iio_event_direction, bool)=E2=80=99 {aka =E2=80=98int (*)(struct=
 iio_dev *, const struct iio_chan_spec *, enum iio_event_type,  enum iio_ev=
ent_direction,  _Bool)=E2=80=99} from incompatible pointer type =E2=80=98in=
t (*)(struct iio_dev *, const struct iio_chan_spec *, enum iio_event_type, =
 enum iio_event_direction,  int)=E2=80=99 [-Wincompatible-pointer-types]
     818 |         .write_event_config =3D adxl345_write_event_config,
        |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/accel/adxl345_core.c:818:31: note: (near initialization for =
=E2=80=98adxl345_info.write_event_config=E2=80=99)

This is a change in the core to take a boolean for the last parameter.  Tha=
t one I'd have
just fixed up whilst applying if not for the axis_en one above.

> =20
> -static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat)
> +static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
> +			      enum iio_modifier tap_dir)
>  {
> +	s64 ts =3D iio_get_time_ns(indio_dev);
>  	struct adxl345_state *st =3D iio_priv(indio_dev);
>  	int samples;
> +	int ret =3D -ENOENT;
> +
> +	if (FIELD_GET(ADXL345_INT_SINGLE_TAP, int_stat)) {
> +		ret =3D iio_push_event(indio_dev,
> +				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, tap_dir,
> +							IIO_EV_TYPE_GESTURE,
> +							IIO_EV_DIR_SINGLETAP),
> +				     ts);
> +		if (ret)
> +			return ret;
> +	}
> =20
>  	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
>  		samples =3D adxl345_get_samples(st);
> @@ -428,9 +751,11 @@ static int adxl345_push_event(struct iio_dev *indio_=
dev, int int_stat)
> =20
>  		if (adxl345_fifo_push(indio_dev, samples) < 0)
>  			return -EINVAL;
> +
> +		return 0;
I'm normally a fan of early returns but in this one corner case I think
		ret =3D 0;
makes it more consistent with the other field matches.
It is just coincidence that the other one sets the value of ret inside
the if block.

>  	}
> =20
> -	return 0;
> +	return ret;
>  }


