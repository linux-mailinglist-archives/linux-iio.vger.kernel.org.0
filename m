Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19A7475425
	for <lists+linux-iio@lfdr.de>; Wed, 15 Dec 2021 09:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237817AbhLOISf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Dec 2021 03:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbhLOISf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Dec 2021 03:18:35 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD7AC061574;
        Wed, 15 Dec 2021 00:18:35 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id k4so19570479pgb.8;
        Wed, 15 Dec 2021 00:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xvhdlym9UYRkQuYzzCb/2lwV2gQGZyhFU19sImXbCTU=;
        b=YL5443Jp2k6o1IhYqPMU3fdsGgKF9BZajAwLU4WvsQmuyQ108b4iUrYh0bCttL1hNh
         KDTM/ooPY1h+wWZ+eDR89qIg5oQmsZzqa/DE90+KwPHjudNNAWiyUXFzyNQ5GDhST7BJ
         zqqLpCM77rDYqknOdYEC+fvo9UqLagqMF97lDrf5dsOkygbiuCCQmTmw70oCt/2LaMpI
         pzSnYGTqjjDBm7z+5NS6SCTFt8fkWZVpvLbHoAaZjqQonTYYkfsBjqO2kfpNI4iPMuMS
         EHWXHF4a21rIISfeuRxzjC7KsnSpkHvWGgPtlgxnOhEGx/n3xuhK69KO4BaRFflv407v
         zhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xvhdlym9UYRkQuYzzCb/2lwV2gQGZyhFU19sImXbCTU=;
        b=UiX+48ArsJmaz4PHReTdBqOgNH4YUV/gCdPbtyyw2CcFBizrWyA6f6Yg+HAsLU7dS4
         zKcmD2esbMqjUc1hxO+FUZucam53q3oDi2bygxnJQQZKyEwUyY7Za/rXRjTCbBIPkFO+
         Xw8BIvzs7OXHuxN3nLgQ1Kk04JKwphbndyl0VbBJco5gmMgH7e2d24TMDZeHhTB5Nwdp
         rEwuW65uTD65Z7YUb6xShQCl2Ji06/uGzzCrTIrF8/qedHrY91Z3bx+ewa4crfyW5Fqh
         KfUR6leJnmZ63nt9k7W9Wk/jmVzn+4wn9QnmVkSyZhsQ4dH3H3u/LE3WaJlsaLEhKjho
         eSzQ==
X-Gm-Message-State: AOAM532o40plg0DBr/or/cEpcKiSbA3pXXeC+O+D4m/aKdxdNeABozGb
        ewZb4hSBZhTXsRR0OQL//99XD2pXFNMZBA==
X-Google-Smtp-Source: ABdhPJxqZ0iRSFD1i/kNvr4TCHfVz+VnR/qZ3C6BJKZw5xklZm6H/Zud3XujPizn56U0smPApHbgLA==
X-Received: by 2002:a63:5853:: with SMTP id i19mr7070012pgm.331.1639556314515;
        Wed, 15 Dec 2021 00:18:34 -0800 (PST)
Received: from shinobu ([37.120.154.45])
        by smtp.gmail.com with ESMTPSA id b18sm1344254pjo.31.2021.12.15.00.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 00:18:33 -0800 (PST)
Date:   Wed, 15 Dec 2021 17:18:26 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Yanteng Si <siyanteng01@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-iio@vger.kernel.org, chenhuacai@kernel.org,
        Yanteng Si <siyanteng@loongson.cn>
Subject: Re: [PATCH v2] counter: Add the necessary colons and indents to the
 comments of counter_compi
Message-ID: <Ybmk0s47ZqpXV2xy@shinobu>
References: <20211211115315.2255384-1-siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mSCeIwYAa9zXeMNZ"
Content-Disposition: inline
In-Reply-To: <20211211115315.2255384-1-siyanteng@loongson.cn>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--mSCeIwYAa9zXeMNZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 11, 2021 at 07:53:15PM +0800, Yanteng Si wrote:
> From: Yanteng Si <siyanteng01@gmail.com>
>=20
> Since aaec1a0f76ec ("counter: Internalize sysfs interface code") introduc=
e a warning as:
>=20
> linux-next/Documentation/driver-api/generic-counter:234: ./include/linux/=
counter.h:43: WARNING: Unexpected indentation.
> linux-next/Documentation/driver-api/generic-counter:234: ./include/linux/=
counter.h:45: WARNING: Block quote ends without a blank line; unexpected un=
indent.
>=20
> Add the necessary colons and indents.
>=20
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>

Hi Yanteng,

Thank you for resubmitting this patch with a reference to the commit
that introduced the bug. I'll pick this patch up and submit it later
with the rest of the Counter changes for this cycle.

For future patches, please add information about which commit a patch
fixes by using the Fixes tag. For example, this patch would have the
following Fixes tag above your Signed-off-by tag.

Fixes: aaec1a0f76ec ("counter: Internalize sysfs interface code")

I'll add that Fixes tag for you as I pick this up so you won't need to
resubmit this patch again. :-)

Thanks,

William Breathitt Gray

> ---
>  include/linux/counter.h | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
>=20
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index b7d0a00a61cf..dfbde2808998 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -38,64 +38,64 @@ enum counter_comp_type {
>   * @type:		Counter component data type
>   * @name:		device-specific component name
>   * @priv:		component-relevant data
> - * @action_read		Synapse action mode read callback. The read value of the
> + * @action_read:		Synapse action mode read callback. The read value of t=
he
>   *			respective Synapse action mode should be passed back via
>   *			the action parameter.
> - * @device_u8_read	Device u8 component read callback. The read value of =
the
> + * @device_u8_read:		Device u8 component read callback. The read value o=
f the
>   *			respective Device u8 component should be passed back via
>   *			the val parameter.
> - * @count_u8_read	Count u8 component read callback. The read value of the
> + * @count_u8_read:		Count u8 component read callback. The read value of =
the
>   *			respective Count u8 component should be passed back via
>   *			the val parameter.
> - * @signal_u8_read	Signal u8 component read callback. The read value of =
the
> + * @signal_u8_read:		Signal u8 component read callback. The read value o=
f the
>   *			respective Signal u8 component should be passed back via
>   *			the val parameter.
> - * @device_u32_read	Device u32 component read callback. The read value of
> + * @device_u32_read:		Device u32 component read callback. The read value=
 of
>   *			the respective Device u32 component should be passed
>   *			back via the val parameter.
> - * @count_u32_read	Count u32 component read callback. The read value of =
the
> + * @count_u32_read:		Count u32 component read callback. The read value o=
f the
>   *			respective Count u32 component should be passed back via
>   *			the val parameter.
> - * @signal_u32_read	Signal u32 component read callback. The read value of
> + * @signal_u32_read:		Signal u32 component read callback. The read value=
 of
>   *			the respective Signal u32 component should be passed
>   *			back via the val parameter.
> - * @device_u64_read	Device u64 component read callback. The read value of
> + * @device_u64_read:		Device u64 component read callback. The read value=
 of
>   *			the respective Device u64 component should be passed
>   *			back via the val parameter.
> - * @count_u64_read	Count u64 component read callback. The read value of =
the
> + * @count_u64_read:		Count u64 component read callback. The read value o=
f the
>   *			respective Count u64 component should be passed back via
>   *			the val parameter.
> - * @signal_u64_read	Signal u64 component read callback. The read value of
> + * @signal_u64_read:		Signal u64 component read callback. The read value=
 of
>   *			the respective Signal u64 component should be passed
>   *			back via the val parameter.
> - * @action_write	Synapse action mode write callback. The write value of
> + * @action_write:		Synapse action mode write callback. The write value of
>   *			the respective Synapse action mode is passed via the
>   *			action parameter.
> - * @device_u8_write	Device u8 component write callback. The write value =
of
> + * @device_u8_write:		Device u8 component write callback. The write valu=
e of
>   *			the respective Device u8 component is passed via the val
>   *			parameter.
> - * @count_u8_write	Count u8 component write callback. The write value of
> + * @count_u8_write:		Count u8 component write callback. The write value =
of
>   *			the respective Count u8 component is passed via the val
>   *			parameter.
> - * @signal_u8_write	Signal u8 component write callback. The write value =
of
> + * @signal_u8_write:		Signal u8 component write callback. The write valu=
e of
>   *			the respective Signal u8 component is passed via the val
>   *			parameter.
> - * @device_u32_write	Device u32 component write callback. The write valu=
e of
> + * @device_u32_write:		Device u32 component write callback. The write va=
lue of
>   *			the respective Device u32 component is passed via the
>   *			val parameter.
> - * @count_u32_write	Count u32 component write callback. The write value =
of
> + * @count_u32_write:		Count u32 component write callback. The write valu=
e of
>   *			the respective Count u32 component is passed via the val
>   *			parameter.
> - * @signal_u32_write	Signal u32 component write callback. The write valu=
e of
> + * @signal_u32_write:		Signal u32 component write callback. The write va=
lue of
>   *			the respective Signal u32 component is passed via the
>   *			val parameter.
> - * @device_u64_write	Device u64 component write callback. The write valu=
e of
> + * @device_u64_write:		Device u64 component write callback. The write va=
lue of
>   *			the respective Device u64 component is passed via the
>   *			val parameter.
> - * @count_u64_write	Count u64 component write callback. The write value =
of
> + * @count_u64_write:		Count u64 component write callback. The write valu=
e of
>   *			the respective Count u64 component is passed via the val
>   *			parameter.
> - * @signal_u64_write	Signal u64 component write callback. The write valu=
e of
> + * @signal_u64_write:		Signal u64 component write callback. The write va=
lue of
>   *			the respective Signal u64 component is passed via the
>   *			val parameter.
>   */
> --=20
> 2.27.0
>=20

--mSCeIwYAa9zXeMNZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmG5pMcACgkQhvpINdm7
VJL+XBAAzeoH+1oRksDolFZQ/WdMMLEDupB4IqPUWSI1vp7E04fqk7uRJLt14YWN
/Lq/DrsXwMGfbI9TTXu7LR/faV6GfR79sktQXaTv7AXhgI1uS5DzouDWCeeTuRon
OxavvUBcpGj/saQPoiqwaf5DYR0ddiDrjiKLONkF4hyr+8AaYek3t7c1xCHvN86D
VuOx9EHJ0CLSYE6gFWH05STWoM0mu73MGG7hyr+DkPFJAvSg8yqbNYBFzEgzpY3k
Fh+MvHTP1C4lW5zNDWmbHgc0MJyj89xuXHUkT+FbizFnhyvwCUcFD9CURX8ofcHj
Pm7vGz3zFUma4r17bwUoBEt3PY8ZqNYXYgPemN1+Py8aCvAiLDu/Cf0fw03uKM+y
7lG7uEzYmcFjP3TxWdaQUr1J9rrQWbSD4/gZVycPNm7jv45vCm9TNSEDc10Buodf
drnoDW3l+k3lIagRzbdmDLu75UmDg3b6tacrtPvZKHi0Q4H1MuBo3bkcr9CoujLB
u55EqJhSTiyjgpAaLo9iVt35KfmYcNFmIaBXzPKEzgqsHY6ad7s8/Lkm5TCoF46Q
vqanIyfB7r0edHLNESB7m8DQaXoGi1TXnesXtU/pbAWRK2u2/53H7mOVDBGQjBxU
3PSF5BZCwEluMZz1bQtg64bC5xLUP/GxHD976iL/7ktcNLCUs/M=
=LvW/
-----END PGP SIGNATURE-----

--mSCeIwYAa9zXeMNZ--
