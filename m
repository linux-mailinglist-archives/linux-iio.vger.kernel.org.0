Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAE3184CF8
	for <lists+linux-iio@lfdr.de>; Fri, 13 Mar 2020 17:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgCMQvl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Mar 2020 12:51:41 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34256 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgCMQvl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Mar 2020 12:51:41 -0400
Received: by mail-qt1-f196.google.com with SMTP id 59so8064403qtb.1;
        Fri, 13 Mar 2020 09:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zjrGKOmUu95Kp+WH+bIMTt0FHzvlrNH5EQNM4TLTqds=;
        b=Qp4bLpv8axxeOXYJ8lXkTbS2Aa+dk1529QySUKA2lxUTfLuCBjYya1tMYAfmBEqGWn
         4iFhwoD90MpUM0av/XEoHlfzM8THzxSTPAcgBx5Zv1EIVkV0dWRU3aYJ1daC8qCXxbX+
         0iTNzUFhFkXkC66oG7ciBlT735JUVEysHy+ZMZ4ZMn1aX/xQZRKh/N8FPLK2O2ol256Q
         iAbnPzJi9O0IzTVfqXk6jg+/xsB7QETVQz48Cvj9AyVhG1l+f6cZUf4JNY3XTWIt0R79
         zEqmbuAWfcodyGnCCbdOmW9QHyDMjxybYo/n6S/7jy0r5qaPHjhpEHrNY6D8GkfQj03h
         rBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zjrGKOmUu95Kp+WH+bIMTt0FHzvlrNH5EQNM4TLTqds=;
        b=Q2ubuEghtOHY5OK4d0ifIi/H65uDvyQZutahCTUPQnmq9JaX9nJ5xoiLnPUd9X4lqJ
         c0lYAes5x8UaDTUyUsPyWLRWAOy3EumMzZ70p7RAxzKk+blnYhQx1eLZElQ8xS1HOcy9
         OjAXpot3TQoEXsZEsGI900lwMaZ1bZqbacPrK17JLcJP7nZYLQxhLJ8VrZ7jzzOPsnXh
         AMiomftk+0G8xcsfwkY/F0uG/xZQMSQNsokau5pItPhiChrVxCQqoNGMed5otebp4wGH
         y+hJ+XCDzawUtL/5J1bBnGFGmgI6cMOSBqlK5G0tCutPMwATKmzdiIhXERZWZtmy+arq
         KkgQ==
X-Gm-Message-State: ANhLgQ1tbdeC9Faayi4TxhxtmAePnWBaD6r7edXC66pGJvvyjUCYzkzj
        tYhZ3qBARXTWhinG+PbNmBU=
X-Google-Smtp-Source: ADFU+vvnx32Z5uor+ifWPE+WM37Hjyf6UpowPICHhyYy7xp1XUX4/sPB2EvEBu1oR1ZAsTGTe2qUbg==
X-Received: by 2002:ac8:4548:: with SMTP id z8mr13902106qtn.188.1584118299979;
        Fri, 13 Mar 2020 09:51:39 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id 82sm13610930qkd.62.2020.03.13.09.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 09:51:38 -0700 (PDT)
Date:   Fri, 13 Mar 2020 12:51:36 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] counter: 104-quad-8: Add lock guards -
 differential encoder cable
Message-ID: <20200313165136.GB5024@icarus>
References: <20200313120133.GA17830@syed>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: <20200313120133.GA17830@syed>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2020 at 05:31:33PM +0530, Syed Nayyar Waris wrote:
> Add lock protection from race conditions in the 104-quad-8 counter
> driver for differential encoder cable status changes. There is no IRQ
> handling so use spin_lock calls for protection.
>=20
> Fixes: bbef69e088c3 ("counter: 104-quad-8: Support Differential Encoder C=
able Status")
>=20
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
> Changes in v4:
>  - Shift review-comments section so that it is not saved in commit messag=
e.
>  - Add spin_unlock calls for deadlock avoidance.
>  - Few changes related to casting.
>=20
>  drivers/counter/104-quad-8.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 9dab190..c9e227f 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -1151,18 +1151,26 @@ static ssize_t quad8_signal_cable_fault_read(stru=
ct counter_device *counter,
>  					     struct counter_signal *signal,
>  					     void *private, char *buf)
>  {
> -	const struct quad8_iio *const priv =3D counter->priv;
> +	struct quad8_iio *const priv =3D counter->priv;
>  	const size_t channel_id =3D signal->id / 2;
> -	const bool disabled =3D !(priv->cable_fault_enable & BIT(channel_id));
> +	bool disabled;
>  	unsigned int status;
>  	unsigned int fault;
> =20
> -	if (disabled)
> +	spin_lock(&priv->lock);
> +
> +	disabled =3D !(priv->cable_fault_enable & BIT(channel_id));
> +
> +	if (disabled) {
> +		spin_unlock(&priv->lock);
>  		return -EINVAL;
> +	}
> =20
>  	/* Logic 0 =3D cable fault */
>  	status =3D inb(priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	/* Mask respective channel and invert logic */
>  	fault =3D !(status & BIT(channel_id));
> =20
> @@ -1194,6 +1202,8 @@ static ssize_t quad8_signal_cable_fault_enable_writ=
e(
>  	if (ret)
>  		return ret;
> =20
> +	spin_lock(&priv->lock);
> +
>  	if (enable)
>  		priv->cable_fault_enable |=3D BIT(channel_id);
>  	else
> @@ -1204,6 +1214,8 @@ static ssize_t quad8_signal_cable_fault_enable_writ=
e(
> =20
>  	outb(cable_fault_enable, priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return len;
>  }
> =20
> --=20
> 2.7.4
>=20

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl5ruhgACgkQhvpINdm7
VJJUJRAAz57BVCZYZOuh2SqAwKCpbzw/pBsx4nWJzQN/u3b9tSf1Fo+wLu94EN7w
HrfElOb2SlKWIwANn/lmH7yvbOu1MELJA1YnEJJts/cW09ZuLgLcaTsZ7HrkiEtv
0Bs2vZiiTswifuay+9bKtrkrIlDzDLHJ9ignnDmRHXq5J6jgFTJhDfZ+rrhmAtLQ
0sctX5qRamMFhIzcTUhPJq/dCqxmnc7Hn2znGNoX1cV5PFZZoO8aLkcShCxdO+z+
WHtY3DS8aZaf3G26NSpHoTGyiSk0vJO41H5MqRvFHuhuF/0dvJPDGZZhyNp1Sqr0
X7/lZYSFpjPHOdRlTKAmmmN6/I44c3Y7vkp0263+IEGLD1SndmQEYoqelaYHAAG+
HFJgh4OZ7z+Dur2p4n2x0N8zqLLuDLw02XHWDCex+wu7CUvTfcfYlSfPyvMWmi83
Ja0lYDCk+kbj2xXBB252ZddQ9Uj7J2lTOPBla02ZrAk2k373dXCSiPabdZ8SpdlN
QN2lgB/RnRR8tLukryaOl5F70uPaPafxYGenPFVrljYy/lpqbnn+KTqIWvLT4FiD
ku/n0vwnfFOLCHwUIzBygzVpptZpfcKjgSAzdElPWeAUr1wyo9BZHU3T2tdTcpYV
dA2C/gpiBJIErJ9T0kVR/4gWMUP3gTMHwBRoICE3kWCQFKycHyU=
=H8i4
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
