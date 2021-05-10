Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDECD37913F
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 16:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbhEJOuC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 10:50:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240067AbhEJOsu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 May 2021 10:48:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D546613DE;
        Mon, 10 May 2021 14:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620658065;
        bh=kHbtU5LMf+KlOpMKVRwQwYeO/rtT2+Cpt+i0hb+ABx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vJirzEQcWhiQ7r5iZRShIz9FhMoUDXn7bkGYjhS13F4AbaEmWvc88qu1hguDdlrWO
         dd7ZYLB5HqNe2Zw8NRsijo5LmeMDVcdvk9fQZPQsj5wZzNrAnVWFMKhTPWzz3Azal2
         U7z7LEj/Mauziwy1kyDu7U2sVVeFh2Wbv16jXSdbeB1IffHfu4iA+xGRF+pmUkkPMs
         3co8FhX3r+71ucEIouWDrofqROE4+ngs7KrTt51SnbX77HZIMfYL+msGz9iGWTQwgS
         tVx+puwAcOipxPUNv7NUsoCtYBboSe/68Y6vGqvY1Tcp2cJ9T55WQj5jcg8m3Fa12M
         vm4ufZbrURCrg==
Date:   Mon, 10 May 2021 16:47:40 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     lorenzo.bianconi83@gmail.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: do not roundup set samplerate
Message-ID: <YJlHjMtosViHbzAV@lore-desk>
References: <20210507103220.2194009-1-sean@geanix.com>
 <YJUeKhjooi8lAN1Q@lore-desk>
 <d0b62523-dcc9-ff14-aeaf-db24915f7aeb@geanix.com>
 <YJjSfpTfSMqf3w0v@lore-desk>
 <303a2899-2aff-410f-3bce-e40a7d7637e9@geanix.com>
 <YJkh6c297Msx0Xwn@lore-desk>
 <e0d50da5-7aac-1ba3-e60c-f6cd85037d30@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AXXbmkK6J6t2Z5xA"
Content-Disposition: inline
In-Reply-To: <e0d50da5-7aac-1ba3-e60c-f6cd85037d30@geanix.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--AXXbmkK6J6t2Z5xA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 10/05/2021 14.07, Lorenzo Bianconi wrote:
> >> On 10/05/2021 08.28, Lorenzo Bianconi wrote:
> >>>> On 07/05/2021 13.02, Lorenzo Bianconi wrote:
> >>>>>> The correct way to set the sampling rate to 12.5 Hz before
> >>>>>> commit f8710f0357bc ("iio: imu: st_lsm6dsx: express odr in mHZ")
> >>>>>> was to write 13 Hz to sampling_frequency.
> >>>>>> Before this patch writing 13 to samplerate results in sample rate =
set
> >>>>>> to 26 Hz.
> >>>>>> Now we return EINVAL if the sampling rate is not in table.
> >>>>>>
> >>>>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> >>>>>
> >>>>> I think this patch is breaking i2c-master support available in st_l=
sm6dsx, have you tested it?
> >>>>>
> >>>> I have not tested with i2c-master.
> >>>> But it's not nice to round up sample rate from user space without an=
y notice.
> >>>
> >>> the point is accel odr is used as trigger for i2c-slave sampling. Con=
nected
> >>> i2c slave devices have different sample rates (e.g. LIS2MDL), so we n=
eed to
> >>> select the lower accel odr greather than slave device one.
> >>>
> >>> Regards,
> >>> Lorenzo
> >>>
> >>
> >> We could open up for custom sample rates if i2c-slaves are enabled?
> >=20
> > can you please explain what you mean?
> >=20
> If i2c-slaves are enabled, it's allowed to set off table sample rates.(We=
 roundup samplerate like now)
> If i2c-slaves are disabled, we return -EINVAL if we can't find the chosen=
 samplerate in the samplerate table?

IMO this is not a big deal because if you set the proper ODR (e.g. 26Hz) wi=
th the
i2c-master disabled, the sample rate will not be rounded-up. If you set 20H=
z,
the accel ODR will be set to 26Hz. I think it does not worth to make the co=
de
uglier and more complex to maintain.

Regards,
Lorenzo

>=20
> /Sean

--AXXbmkK6J6t2Z5xA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYJlHigAKCRA6cBh0uS2t
rE8zAP9s8Mri50OgZLba59MSpk2Swm6yOUGkEFKkTkQYvQZqcwD/WDO8ziXjpvjf
P/+Jg09MPPtscCUgFhkdKxvHkRtlrg8=
=drDy
-----END PGP SIGNATURE-----

--AXXbmkK6J6t2Z5xA--
