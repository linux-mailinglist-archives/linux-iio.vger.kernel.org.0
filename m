Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657C3470DCB
	for <lists+linux-iio@lfdr.de>; Fri, 10 Dec 2021 23:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbhLJWbm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Dec 2021 17:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbhLJWbl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Dec 2021 17:31:41 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BCCC061746;
        Fri, 10 Dec 2021 14:28:06 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id n26so9695689pff.3;
        Fri, 10 Dec 2021 14:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g1Fndq6mwW0NhE7RrUnl/fT7Cbruf7CL95nMSwq0+yM=;
        b=VdpkDYQc4R3TnPZPOSyCuAkcz/N20FeYzuaBG1jiZpVX5csw3xs3LOY4rVaOiDYFas
         00FrPg/TbaCN3MMRk8aft95N41KE6ReJ+uPfMIWMnM0+fP4muF3yPwIq77zy7Iivbi7C
         mFaBxKRett/kOq32KQqJhizPET9SUusNHylCw9tBCF3k1A3qy2LuZYfILinOfdv4sVeM
         9F9NSCDKx44NYmxrLExt/jqBmxzCVEd6aEHC1MHoGhmpBQbUUGJjoJCCOzsauDGyVHxd
         8wdj+lMHepulniBJF/Z4VRI9W5/4Ehg2vh+4ZU8YGXiUnrwae+hg3HIXnS5AYjcWBlCO
         wS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g1Fndq6mwW0NhE7RrUnl/fT7Cbruf7CL95nMSwq0+yM=;
        b=HuDh6000Of4faNd83TDzxpmNjAb/iwXZ6qWoviwzOH35X0BHp8TX4irP7QxdNUG1Br
         dMTSL1C6Rj6WzE4ZDhfbaVtJ72ieOfjFdKHSmt2QqasZCdutKhFYFB0ozG7/l4Y07uc/
         QvartKJd8STPeJLxg5ClfdP9Yw7Unskka0nSkCh+2FakyWZ34ikMf3Jpg3WKaAPJX6Wl
         zlfglj/RdPdCGTzmGgLFnI55XZItKyT98o5mNLxRYOYQKnXNqSr103KDAMn4gamLz75A
         fTnrnMLZFAX+vrU+dwJcINl9KbidvOgsjL/rhFdLzpZ4LW7BWVukBM+vP018FNiQwHcj
         wv4g==
X-Gm-Message-State: AOAM530guDm8phovvsa3NvKxBV1fA2A0Z4wmSib88A+A/Bz5eDS3F9z5
        QYfB+Va31RAFET3M/9neW8o=
X-Google-Smtp-Source: ABdhPJymXhwrBm6I/hJFtTyDBIsRNR4G0I+M8Rm6ap+8l55+98V/bN+YRXN7l91nJrKyjOUTn4VgHg==
X-Received: by 2002:a63:d50b:: with SMTP id c11mr40768870pgg.278.1639175285956;
        Fri, 10 Dec 2021 14:28:05 -0800 (PST)
Received: from shinobu ([37.120.154.45])
        by smtp.gmail.com with ESMTPSA id a26sm4034845pfh.161.2021.12.10.14.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 14:28:05 -0800 (PST)
Date:   Sat, 11 Dec 2021 07:28:00 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Yanteng Si <siyanteng01@gmail.com>
Cc:     corbet@lwn.net, chenhuacai@kernel.org, linux-doc@vger.kernel.org,
        linux-iio@vger.kernel.org, Yanteng Si <siyanteng@loongson.cn>
Subject: Re: [PATCH] counter: Add the necessary colons and indents to the
 comments of counter_compi
Message-ID: <YbPUcMljr3LUmeMB@shinobu>
References: <20211205130816.4121898-1-siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XaEPONa1/2J+TUcy"
Content-Disposition: inline
In-Reply-To: <20211205130816.4121898-1-siyanteng@loongson.cn>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--XaEPONa1/2J+TUcy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 05, 2021 at 09:08:16PM +0800, Yanteng Si wrote:
> Fix warning as:
>=20
> linux-next/Documentation/driver-api/generic-counter:234: ./include/linux/=
counter.h:43: WARNING: Unexpected indentation.
> linux-next/Documentation/driver-api/generic-counter:234: ./include/linux/=
counter.h:45: WARNING: Block quote ends without a blank line; unexpected un=
indent.
>=20
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>

Hello Yanteng,

Thank you for the patch. Is this fixing commit aaec1a0f76ec ("counter:
Internalize sysfs interface code")?

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

--XaEPONa1/2J+TUcy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmGz1FoACgkQhvpINdm7
VJJ4bBAA56i8pfMleCjtojCPdvwPHtbVoPjZzf7IkNnnwP71CTFPFHBXlz2UOeUW
ZuKjoccEI0rJOxCqJGPMAmBgYTY/OjFfOn9p/HDWNcFDoD5fJ0WlpCWpizTjt52O
mn/obJAvn+9gcuc4Fh+7soU4CthL96/70yFXvziGMRXPT2J7ZGADLVnfx7HXSMx3
fV/tHkoxIv+5oIqR6+RfrAh72NUCV7h1PoO0WS9HiMtdlr2RlkKZZch0Ol4K2+tH
zRSv6UUNfbE7AODHV63dzbdYTEDYOG5SF7DeUbuybUJL+r9EOAIX5m2Ta0hWaLQL
gb8Joi4ftgZFfcvieOHyCr3xhlQcoFj3eWoXTS0KNqFDtfIMi4BUTFL4ja9i1Kv2
o6GXbvKacYm6CNN4nODQDV7IpcuQ0EBBHwLpbpcQ546FThd/7XsM79oYsDJlB86R
4EH9MVsCstl3oc//wcovr9kY2rHub2zLCPobX2t1iDqmDKs2MTlyI1uGn3nkfCwX
HGLh1zBprTsNI7dDmwEkeJBQ+3WMhggI/YGMMqxUaO5oLFQfvu8f4qxzxUEmnsGt
Egvdqpoi7Jb3CvQwzVy0nxpx+6BjK6RHVCRjk+XDrOgJyc5xIiSX7PIJcP0ftnIa
XPDVFLMdR7dxNswRDhCxFPbGnMGZWpRImMT+b3oEKATE6MSvNlY=
=6ucm
-----END PGP SIGNATURE-----

--XaEPONa1/2J+TUcy--
