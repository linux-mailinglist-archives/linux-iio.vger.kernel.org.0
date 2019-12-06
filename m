Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA9A115694
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2019 18:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfLFReM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Dec 2019 12:34:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfLFReM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 6 Dec 2019 12:34:12 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40A8B2054F;
        Fri,  6 Dec 2019 17:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575653651;
        bh=sZgvO6D9zwygRJ+QnTukHXWsFDl1iKjjprbv0Y7JKWY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PUz8EXeGF8FpB6Zh5V5y0PPTa9pxHtKLeWsniHXahpVD1KEHUbNRB0Dns3MsklxB4
         MP+Su0bBbcaRWWnk9Or9+DurzPqQPi6aPar4zMlA7NYsD1MP1fdpucYecsIE5lt5bk
         hLYj3Z74uhcfBhTS3lIknnIv3n6uhCAHIxORTq9k=
Date:   Fri, 6 Dec 2019 17:34:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars =?UTF-8?B?TcO2bGxlbmRvcmY=?= <lars.moellendorf@plating.de>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: align the size of scan bytes to size of
 the largest element
Message-ID: <20191206173407.651ac889@archlinux>
In-Reply-To: <20191202142714.12030-1-lars.moellendorf@plating.de>
References: <531d08db4d758cb8ab9f7e1955c7b918ff2b0c69.camel@analog.com>
        <20191202142714.12030-1-lars.moellendorf@plating.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  2 Dec 2019 15:27:14 +0100
Lars M=C3=B6llendorf <lars.moellendorf@plating.de> wrote:

Even when fixing a patch send issue as you did here, please mark clearly
with v2 and add a change log saying that's what you did.  Also
please don't send in reply to the earlier thread, but instead as a
completely new thread.   The reply to thread thing seems sensible for
simple cases, but when we get to v20 (it happens ;) things get really
confusing :)

> Previous versions of `iio_compute_scan_bytes` only aligned the current
> element to its own length (i.e. its own natural alignment). This worked
> in case the length of each channel's scan elements had been smaller then
> the length of the successive channel's scan elements.

I'd modify this description a little bit.  The key thing was the length of =
the
last element - didn't matter what happened before that.

u32
u16
u32
would be aligned correctly I hope?

>=20
> E.g.
>=20
> u16
> u32 <- aligned to its natural alignment
>=20
> But if the length of a channel's scan elements is greater then the
> length of scan elements of the consecutive channel no alignment had
> been taken into account. This is however needed to preserve the
> alignment for multiple consecutive sets of scan elements.
>=20
> u32 <- alignment is off by two byte for the second set of scan elements
> u16 <- no alignment takes place
>=20
> This commit fixes this by aligning the scan bytes to the size of the
> largest scan element.
>=20
> Signed-off-by: Lars M=C3=B6llendorf <lars.moellendorf@plating.de>
Code looks good to me, so just a v3 tidying up the message.

Thanks for sorting this out!  Ideally we'd add a specific
fixes tag as well for when this was introduced but I fear
it goes back nearly all the way (at least before the move
out of staging) so we can probably leave that vague for this
one unless you fancy some archaeology.=20

Jonathan

> ---
>  drivers/iio/industrialio-buffer.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio=
-buffer.c
> index 5d05c38c4ba9..2f037cd59d53 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -546,7 +546,7 @@ static int iio_compute_scan_bytes(struct iio_dev *ind=
io_dev,
>  				const unsigned long *mask, bool timestamp)
>  {
>  	unsigned bytes =3D 0;
> -	int length, i;
> +	int length, i, largest =3D 0;
> =20
>  	/* How much space will the demuxed element take? */
>  	for_each_set_bit(i, mask,
> @@ -554,13 +554,17 @@ static int iio_compute_scan_bytes(struct iio_dev *i=
ndio_dev,
>  		length =3D iio_storage_bytes_for_si(indio_dev, i);
>  		bytes =3D ALIGN(bytes, length);
>  		bytes +=3D length;
> +		largest =3D max(largest, length);
>  	}
> =20
>  	if (timestamp) {
>  		length =3D iio_storage_bytes_for_timestamp(indio_dev);
>  		bytes =3D ALIGN(bytes, length);
>  		bytes +=3D length;
> +		largest =3D max(largest, length);
>  	}
> +
> +	bytes =3D ALIGN(bytes, largest);
>  	return bytes;
>  }
> =20

